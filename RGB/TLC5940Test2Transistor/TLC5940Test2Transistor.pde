#include <Tlc5940.h>
#include <tlc_animations.h>
#include <tlc_config.h>
#include <tlc_fades.h>
#include <tlc_progmem_utils.h>
#include <tlc_servos.h>
#include <tlc_shifts.h>

struct rgb {
  byte r;
  byte g;
  byte b;
};

void setup() {
  Tlc.init();
  Serial.begin(9600);
}

void loop() {
  fadeTest();
}

void fadeTest() {
  if (tlc_fadeBufferSize < TLC_FADE_BUFFER_LENGTH - 2) {
    if (!tlc_isFading(1)) {
    tlc_removeFades(1);
    int time = millis() + 50;
    int up = tlc_addFade (1, 0, 4095, time + 0, time + 990);
//    Serial.print(" add fade up "); Serial.println(up);
    int down = tlc_addFade (1, 4095, 0, time + 1500, time + 2490);
//    Serial.print(" add fade down "); Serial.println(down);
    }
  }
  tlc_updateFades();

//  while (tlc_isFading(0)) {
//    delay(100);
//  } 
//  tlc_removeFades(0); 
}

void rgbTest() {
  struct rgb red = {255, 0, 0};
  struct rgb grn = {0, 255, 0};
  struct rgb blu = {0, 0, 255};
  
  output(1, &grn);
  Tlc.update();
  delay(1000);
  output(1, &blu);
  Tlc.update();
  delay(1000);
  output(1, &red);
  Tlc.update();
  delay(1000);
}

void output(int light, struct rgb* rgb) {
  int portoffset = light * 3;
  Tlc.set(0 + portoffset, rgb->r * 16);
  Tlc.set(1 + portoffset, rgb->g * 16);
  Tlc.set(2 + portoffset, rgb->b * 16);
}

