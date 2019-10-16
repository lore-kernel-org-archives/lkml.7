Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F3CECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562CB2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391569AbfJPIZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:25:08 -0400
Received: from smtp1.goneo.de ([85.220.129.30]:43128 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfJPIZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:25:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id C53712409D2;
        Wed, 16 Oct 2019 10:24:47 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HnwqULM0aaEh; Wed, 16 Oct 2019 10:24:43 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 5EC942406D6;
        Wed, 16 Oct 2019 10:24:43 +0200 (CEST)
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH 1/3] auxdisplay: Make charlcd.[ch] more general
Date:   Wed, 16 Oct 2019 10:24:26 +0200
Message-Id: <20191016082430.5955-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

charlcd.c contains lots of hd44780 hardware specific stuff. It is nearly
impossible to reuse the interface for other character based displays.
The current users of charlcd are the hd44780 and the panel drivers.
This does factor out the hd44780 specific stuff out of charlcd into a
new module called hd44780_common.
charlcd gets rid of the hd44780 specfics and more generally useable.
The hd44780 and panel drivers are modified to use the new
hd44780_common.
This is tested on a hd44780 connected through the gpios of a pcf8574.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/Kconfig          |  16 +
 drivers/auxdisplay/Makefile         |   1 +
 drivers/auxdisplay/charlcd.c        | 591 ++++++++--------------------
 drivers/auxdisplay/charlcd.h        | 109 ++++-
 drivers/auxdisplay/hd44780.c        | 121 ++++--
 drivers/auxdisplay/hd44780_common.c | 370 +++++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  32 ++
 drivers/auxdisplay/panel.c          | 178 ++++-----
 8 files changed, 851 insertions(+), 567 deletions(-)
 create mode 100644 drivers/auxdisplay/hd44780_common.c
 create mode 100644 drivers/auxdisplay/hd44780_common.h

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index b8313a04422d..5fb6784c6579 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -14,12 +14,27 @@ menuconfig AUXDISPLAY
 
 	  If you say N, all options in this submenu will be skipped and disabled.
 
+config CHARLCD
+	tristate "Character LCD core support" if COMPILE_TEST
+	help
+	  This is the base system for character based lcd displays.
+	  It makes no sense to have this alone, you select your display driver
+	  and if it needs the charlcd core, it has to select it automatically.
+
+config HD44780_COMMON
+	tristate "Common functions for HD44780 (and compatibles) LCD displays" if COMPILE_TEST
+	help
+	  This is a module with the common symbols for HD44780 (and compatibles)
+	  displays. This is code that is shared between other modules. It is not
+	  useful alone.
+
 if AUXDISPLAY
 
 config HD44780
 	tristate "HD44780 Character LCD support"
 	depends on GPIOLIB || COMPILE_TEST
 	select CHARLCD
+	select HD44780_COMMON
 	---help---
 	  Enable support for Character LCDs using a HD44780 controller.
 	  The LCD is accessible through the /dev/lcd char device (10, 156).
@@ -168,6 +183,7 @@ menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
 	select CHARLCD
+	select HD44780_COMMON
 	---help---
 	  Say Y here if you have an HD44780 or KS-0074 LCD connected to your
 	  parallel port. This driver also features 4 and 6-key keypads. The LCD
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index cf54b5efb07e..7e8a8c3eb3c3 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_CHARLCD)		+= charlcd.o
+obj-$(CONFIG_HD44780_COMMON)	+= hd44780_common.o
 obj-$(CONFIG_ARM_CHARLCD)	+= arm-charlcd.o
 obj-$(CONFIG_KS0108)		+= ks0108.o
 obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index bef6b85778b6..86c38b978c8b 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -24,267 +24,85 @@
 
 #define LCD_MINOR		156
 
-#define DEFAULT_LCD_BWIDTH      40
-#define DEFAULT_LCD_HWIDTH      64
-
 /* Keep the backlight on this many seconds for each flash */
 #define LCD_BL_TEMPO_PERIOD	4
 
-#define LCD_FLAG_B		0x0004	/* Blink on */
-#define LCD_FLAG_C		0x0008	/* Cursor on */
-#define LCD_FLAG_D		0x0010	/* Display on */
-#define LCD_FLAG_F		0x0020	/* Large font mode */
-#define LCD_FLAG_N		0x0040	/* 2-rows mode */
-#define LCD_FLAG_L		0x0080	/* Backlight enabled */
-
-/* LCD commands */
-#define LCD_CMD_DISPLAY_CLEAR	0x01	/* Clear entire display */
-
-#define LCD_CMD_ENTRY_MODE	0x04	/* Set entry mode */
-#define LCD_CMD_CURSOR_INC	0x02	/* Increment cursor */
-
-#define LCD_CMD_DISPLAY_CTRL	0x08	/* Display control */
-#define LCD_CMD_DISPLAY_ON	0x04	/* Set display on */
-#define LCD_CMD_CURSOR_ON	0x02	/* Set cursor on */
-#define LCD_CMD_BLINK_ON	0x01	/* Set blink on */
-
-#define LCD_CMD_SHIFT		0x10	/* Shift cursor/display */
-#define LCD_CMD_DISPLAY_SHIFT	0x08	/* Shift display instead of cursor */
-#define LCD_CMD_SHIFT_RIGHT	0x04	/* Shift display/cursor to the right */
-
-#define LCD_CMD_FUNCTION_SET	0x20	/* Set function */
-#define LCD_CMD_DATA_LEN_8BITS	0x10	/* Set data length to 8 bits */
-#define LCD_CMD_TWO_LINES	0x08	/* Set to two display lines */
-#define LCD_CMD_FONT_5X10_DOTS	0x04	/* Set char font to 5x10 dots */
-
-#define LCD_CMD_SET_CGRAM_ADDR	0x40	/* Set char generator RAM address */
-
-#define LCD_CMD_SET_DDRAM_ADDR	0x80	/* Set display data RAM address */
-
-#define LCD_ESCAPE_LEN		24	/* Max chars for LCD escape command */
 #define LCD_ESCAPE_CHAR		27	/* Use char 27 for escape command */
 
-struct charlcd_priv {
-	struct charlcd lcd;
-
-	struct delayed_work bl_work;
-	struct mutex bl_tempo_lock;	/* Protects access to bl_tempo */
-	bool bl_tempo;
-
-	bool must_clear;
-
-	/* contains the LCD config state */
-	unsigned long int flags;
-
-	/* Contains the LCD X and Y offset */
-	struct {
-		unsigned long int x;
-		unsigned long int y;
-	} addr;
-
-	/* Current escape sequence and it's length or -1 if outside */
-	struct {
-		char buf[LCD_ESCAPE_LEN + 1];
-		int len;
-	} esc_seq;
-
-	unsigned long long drvdata[0];
-};
-
-#define charlcd_to_priv(p)	container_of(p, struct charlcd_priv, lcd)
-
 /* Device single-open policy control */
 static atomic_t charlcd_available = ATOMIC_INIT(1);
 
-/* sleeps that many milliseconds with a reschedule */
-static void long_sleep(int ms)
+static void charlcd_bl_off(struct work_struct *work)
 {
-	schedule_timeout_interruptible(msecs_to_jiffies(ms));
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct charlcd *lcd =
+		container_of(dwork, struct charlcd, bl_work);
+
+	mutex_lock(&lcd->bl_tempo_lock);
+	if (lcd->bl_tempo) {
+		lcd->bl_tempo = false;
+		if (!(lcd->flags & LCD_FLAG_L))
+			lcd->ops->backlight(lcd, CHARLCD_OFF);
+	}
+	mutex_unlock(&lcd->bl_tempo_lock);
 }
 
 /* turn the backlight on or off */
-static void charlcd_backlight(struct charlcd *lcd, int on)
+int charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
+	int ret = 0;
 
 	if (!lcd->ops->backlight)
-		return;
+		return ret;
 
-	mutex_lock(&priv->bl_tempo_lock);
-	if (!priv->bl_tempo)
-		lcd->ops->backlight(lcd, on);
-	mutex_unlock(&priv->bl_tempo_lock);
-}
+	mutex_lock(&lcd->bl_tempo_lock);
+	if (!lcd->bl_tempo)
+		ret = lcd->ops->backlight(lcd, on);
 
-static void charlcd_bl_off(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct charlcd_priv *priv =
-		container_of(dwork, struct charlcd_priv, bl_work);
-
-	mutex_lock(&priv->bl_tempo_lock);
-	if (priv->bl_tempo) {
-		priv->bl_tempo = false;
-		if (!(priv->flags & LCD_FLAG_L))
-			priv->lcd.ops->backlight(&priv->lcd, 0);
-	}
-	mutex_unlock(&priv->bl_tempo_lock);
+	mutex_unlock(&lcd->bl_tempo_lock);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(charlcd_backlight);
 
 /* turn the backlight on for a little while */
-void charlcd_poke(struct charlcd *lcd)
+int charlcd_poke(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
+	int ret = 0;
 
 	if (!lcd->ops->backlight)
-		return;
-
-	cancel_delayed_work_sync(&priv->bl_work);
+		return ret;
 
-	mutex_lock(&priv->bl_tempo_lock);
-	if (!priv->bl_tempo && !(priv->flags & LCD_FLAG_L))
-		lcd->ops->backlight(lcd, 1);
-	priv->bl_tempo = true;
-	schedule_delayed_work(&priv->bl_work, LCD_BL_TEMPO_PERIOD * HZ);
-	mutex_unlock(&priv->bl_tempo_lock);
-}
-EXPORT_SYMBOL_GPL(charlcd_poke);
+	cancel_delayed_work_sync(&lcd->bl_work);
 
-static void charlcd_gotoxy(struct charlcd *lcd)
-{
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-	unsigned int addr;
+	mutex_lock(&lcd->bl_tempo_lock);
+	if (!lcd->bl_tempo && !(lcd->flags & LCD_FLAG_L))
+		ret = lcd->ops->backlight(lcd, CHARLCD_ON);
 
-	/*
-	 * we force the cursor to stay at the end of the
-	 * line if it wants to go farther
-	 */
-	addr = priv->addr.x < lcd->bwidth ? priv->addr.x & (lcd->hwidth - 1)
-					  : lcd->bwidth - 1;
-	if (priv->addr.y & 1)
-		addr += lcd->hwidth;
-	if (priv->addr.y & 2)
-		addr += lcd->bwidth;
-	lcd->ops->write_cmd(lcd, LCD_CMD_SET_DDRAM_ADDR | addr);
-}
-
-static void charlcd_home(struct charlcd *lcd)
-{
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-
-	priv->addr.x = 0;
-	priv->addr.y = 0;
-	charlcd_gotoxy(lcd);
+	lcd->bl_tempo = true;
+	schedule_delayed_work(&lcd->bl_work, LCD_BL_TEMPO_PERIOD * HZ);
+	mutex_unlock(&lcd->bl_tempo_lock);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(charlcd_poke);
 
 static void charlcd_print(struct charlcd *lcd, char c)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-
-	if (priv->addr.x < lcd->bwidth) {
-		if (lcd->char_conv)
-			c = lcd->char_conv[(unsigned char)c];
-		lcd->ops->write_data(lcd, c);
-		priv->addr.x++;
-
-		/* prevents the cursor from wrapping onto the next line */
-		if (priv->addr.x == lcd->bwidth)
-			charlcd_gotoxy(lcd);
-	}
-}
-
-static void charlcd_clear_fast(struct charlcd *lcd)
-{
-	int pos;
-
-	charlcd_home(lcd);
-
-	if (lcd->ops->clear_fast)
-		lcd->ops->clear_fast(lcd);
-	else
-		for (pos = 0; pos < min(2, lcd->height) * lcd->hwidth; pos++)
-			lcd->ops->write_data(lcd, ' ');
-
-	charlcd_home(lcd);
-}
-
-/* clears the display and resets X/Y */
-static void charlcd_clear_display(struct charlcd *lcd)
-{
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-
-	lcd->ops->write_cmd(lcd, LCD_CMD_DISPLAY_CLEAR);
-	priv->addr.x = 0;
-	priv->addr.y = 0;
-	/* we must wait a few milliseconds (15) */
-	long_sleep(15);
-}
-
-static int charlcd_init_display(struct charlcd *lcd)
-{
-	void (*write_cmd_raw)(struct charlcd *lcd, int cmd);
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-	u8 init;
-
-	if (lcd->ifwidth != 4 && lcd->ifwidth != 8)
-		return -EINVAL;
+	if (lcd->addr.x >= lcd->width)
+		return;
 
-	priv->flags = ((lcd->height > 1) ? LCD_FLAG_N : 0) | LCD_FLAG_D |
-		      LCD_FLAG_C | LCD_FLAG_B;
+	if (lcd->char_conv)
+		c = lcd->char_conv[(unsigned char)c];
 
-	long_sleep(20);		/* wait 20 ms after power-up for the paranoid */
+	if (!lcd->ops->print(lcd, c))
+		lcd->addr.x++;
 
-	/*
-	 * 8-bit mode, 1 line, small fonts; let's do it 3 times, to make sure
-	 * the LCD is in 8-bit mode afterwards
-	 */
-	init = LCD_CMD_FUNCTION_SET | LCD_CMD_DATA_LEN_8BITS;
-	if (lcd->ifwidth == 4) {
-		init >>= 4;
-		write_cmd_raw = lcd->ops->write_cmd_raw4;
-	} else {
-		write_cmd_raw = lcd->ops->write_cmd;
+	/* prevents the cursor from wrapping onto the next line */
+	if (lcd->addr.x >= lcd->width) {
+		lcd->addr.x = lcd->width;
+		lcd->addr.x--;
+		lcd->ops->gotoxy(lcd);
+		lcd->addr.x++;
 	}
-	write_cmd_raw(lcd, init);
-	long_sleep(10);
-	write_cmd_raw(lcd, init);
-	long_sleep(10);
-	write_cmd_raw(lcd, init);
-	long_sleep(10);
-
-	if (lcd->ifwidth == 4) {
-		/* Switch to 4-bit mode, 1 line, small fonts */
-		lcd->ops->write_cmd_raw4(lcd, LCD_CMD_FUNCTION_SET >> 4);
-		long_sleep(10);
-	}
-
-	/* set font height and lines number */
-	lcd->ops->write_cmd(lcd,
-		LCD_CMD_FUNCTION_SET |
-		((lcd->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
-		((priv->flags & LCD_FLAG_F) ? LCD_CMD_FONT_5X10_DOTS : 0) |
-		((priv->flags & LCD_FLAG_N) ? LCD_CMD_TWO_LINES : 0));
-	long_sleep(10);
-
-	/* display off, cursor off, blink off */
-	lcd->ops->write_cmd(lcd, LCD_CMD_DISPLAY_CTRL);
-	long_sleep(10);
-
-	lcd->ops->write_cmd(lcd,
-		LCD_CMD_DISPLAY_CTRL |	/* set display mode */
-		((priv->flags & LCD_FLAG_D) ? LCD_CMD_DISPLAY_ON : 0) |
-		((priv->flags & LCD_FLAG_C) ? LCD_CMD_CURSOR_ON : 0) |
-		((priv->flags & LCD_FLAG_B) ? LCD_CMD_BLINK_ON : 0));
-
-	charlcd_backlight(lcd, (priv->flags & LCD_FLAG_L) ? 1 : 0);
-
-	long_sleep(10);
-
-	/* entry mode set : increment, cursor shifting */
-	lcd->ops->write_cmd(lcd, LCD_CMD_ENTRY_MODE | LCD_CMD_CURSOR_INC);
-
-	charlcd_clear_display(lcd);
-	return 0;
 }
 
 /*
@@ -369,47 +187,69 @@ static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
 
 static inline int handle_lcd_special_code(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-
 	/* LCD special codes */
 
 	int processed = 0;
 
-	char *esc = priv->esc_seq.buf + 2;
-	int oldflags = priv->flags;
+	char *esc = lcd->esc_seq.buf + 2;
+	int oldflags = lcd->flags;
 
 	/* check for display mode flags */
 	switch (*esc) {
 	case 'D':	/* Display ON */
-		priv->flags |= LCD_FLAG_D;
+		lcd->flags |= LCD_FLAG_D;
+		if (lcd->flags != oldflags)
+			lcd->ops->display(lcd, CHARLCD_ON);
+
 		processed = 1;
 		break;
 	case 'd':	/* Display OFF */
-		priv->flags &= ~LCD_FLAG_D;
+		lcd->flags &= ~LCD_FLAG_D;
+		if (lcd->flags != oldflags)
+			lcd->ops->display(lcd, CHARLCD_OFF);
+
 		processed = 1;
 		break;
 	case 'C':	/* Cursor ON */
-		priv->flags |= LCD_FLAG_C;
+		lcd->flags |= LCD_FLAG_C;
+		if (lcd->flags != oldflags)
+			lcd->ops->cursor(lcd, CHARLCD_ON);
+
 		processed = 1;
 		break;
 	case 'c':	/* Cursor OFF */
-		priv->flags &= ~LCD_FLAG_C;
+		lcd->flags &= ~LCD_FLAG_C;
+		if (lcd->flags != oldflags)
+			lcd->ops->cursor(lcd, CHARLCD_OFF);
+
 		processed = 1;
 		break;
 	case 'B':	/* Blink ON */
-		priv->flags |= LCD_FLAG_B;
+		lcd->flags |= LCD_FLAG_B;
+		if (lcd->flags != oldflags)
+			lcd->ops->blink(lcd, CHARLCD_ON);
+
 		processed = 1;
 		break;
 	case 'b':	/* Blink OFF */
-		priv->flags &= ~LCD_FLAG_B;
+		lcd->flags &= ~LCD_FLAG_B;
+		if (lcd->flags != oldflags)
+			lcd->ops->blink(lcd, CHARLCD_OFF);
+
 		processed = 1;
 		break;
 	case '+':	/* Back light ON */
-		priv->flags |= LCD_FLAG_L;
+		lcd->flags |= LCD_FLAG_L;
+		if (lcd->flags != oldflags)
+			lcd->ops->backlight(lcd, CHARLCD_ON);
+
 		processed = 1;
 		break;
 	case '-':	/* Back light OFF */
-		priv->flags &= ~LCD_FLAG_L;
+		lcd->flags &= ~LCD_FLAG_L;
+		if (lcd->flags != oldflags)
+			lcd->ops->backlight(lcd, CHARLCD_OFF);
+
 		processed = 1;
 		break;
 	case '*':	/* Flash back light */
@@ -417,222 +257,144 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		processed = 1;
 		break;
 	case 'f':	/* Small Font */
-		priv->flags &= ~LCD_FLAG_F;
+		lcd->flags &= ~LCD_FLAG_F;
 		processed = 1;
 		break;
 	case 'F':	/* Large Font */
-		priv->flags |= LCD_FLAG_F;
+		lcd->flags |= LCD_FLAG_F;
 		processed = 1;
 		break;
 	case 'n':	/* One Line */
-		priv->flags &= ~LCD_FLAG_N;
+		lcd->flags &= ~LCD_FLAG_N;
 		processed = 1;
 		break;
 	case 'N':	/* Two Lines */
-		priv->flags |= LCD_FLAG_N;
+		lcd->flags |= LCD_FLAG_N;
 		processed = 1;
 		break;
 	case 'l':	/* Shift Cursor Left */
-		if (priv->addr.x > 0) {
-			/* back one char if not at end of line */
-			if (priv->addr.x < lcd->bwidth)
-				lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
-			priv->addr.x--;
+		if (lcd->addr.x > 0) {
+			if (!lcd->ops->shift_cursor(lcd, CHARLCD_SHIFT_LEFT))
+				lcd->addr.x--;
 		}
+
 		processed = 1;
 		break;
 	case 'r':	/* shift cursor right */
-		if (priv->addr.x < lcd->width) {
-			/* allow the cursor to pass the end of the line */
-			if (priv->addr.x < (lcd->bwidth - 1))
-				lcd->ops->write_cmd(lcd,
-					LCD_CMD_SHIFT | LCD_CMD_SHIFT_RIGHT);
-			priv->addr.x++;
+		if (lcd->addr.x < lcd->width) {
+			if (!lcd->ops->shift_cursor(lcd, CHARLCD_SHIFT_RIGHT))
+				lcd->addr.x++;
 		}
+
 		processed = 1;
 		break;
 	case 'L':	/* shift display left */
-		lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT);
+		lcd->ops->shift_display(lcd, CHARLCD_SHIFT_LEFT);
 		processed = 1;
 		break;
 	case 'R':	/* shift display right */
-		lcd->ops->write_cmd(lcd,
-				    LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT |
-				    LCD_CMD_SHIFT_RIGHT);
+		lcd->ops->shift_display(lcd, CHARLCD_SHIFT_RIGHT);
 		processed = 1;
 		break;
 	case 'k': {	/* kill end of line */
-		int x;
+		int x, xs, ys;
 
-		for (x = priv->addr.x; x < lcd->bwidth; x++)
-			lcd->ops->write_data(lcd, ' ');
+		xs = lcd->addr.x;
+		ys = lcd->addr.y;
+		for (x = lcd->addr.x; x < lcd->width; x++)
+			lcd->ops->print(lcd, ' ');
 
 		/* restore cursor position */
-		charlcd_gotoxy(lcd);
+		lcd->addr.x = xs;
+		lcd->addr.y = ys;
+		lcd->ops->gotoxy(lcd);
 		processed = 1;
 		break;
 	}
 	case 'I':	/* reinitialize display */
-		charlcd_init_display(lcd);
+		lcd->ops->init_display(lcd);
+		lcd->flags = ((lcd->height > 1) ? LCD_FLAG_N : 0) | LCD_FLAG_D |
+			LCD_FLAG_C | LCD_FLAG_B;
 		processed = 1;
 		break;
 	case 'G': {
-		/* Generator : LGcxxxxx...xx; must have <c> between '0'
-		 * and '7', representing the numerical ASCII code of the
-		 * redefined character, and <xx...xx> a sequence of 16
-		 * hex digits representing 8 bytes for each character.
-		 * Most LCDs will only use 5 lower bits of the 7 first
-		 * bytes.
-		 */
-
-		unsigned char cgbytes[8];
-		unsigned char cgaddr;
-		int cgoffset;
-		int shift;
-		char value;
-		int addr;
-
-		if (!strchr(esc, ';'))
-			break;
-
-		esc++;
-
-		cgaddr = *(esc++) - '0';
-		if (cgaddr > 7) {
+		if (lcd->ops->redefine_char)
+			processed = lcd->ops->redefine_char(lcd, esc);
+		else
 			processed = 1;
-			break;
-		}
-
-		cgoffset = 0;
-		shift = 0;
-		value = 0;
-		while (*esc && cgoffset < 8) {
-			shift ^= 4;
-			if (*esc >= '0' && *esc <= '9') {
-				value |= (*esc - '0') << shift;
-			} else if (*esc >= 'A' && *esc <= 'F') {
-				value |= (*esc - 'A' + 10) << shift;
-			} else if (*esc >= 'a' && *esc <= 'f') {
-				value |= (*esc - 'a' + 10) << shift;
-			} else {
-				esc++;
-				continue;
-			}
-
-			if (shift == 0) {
-				cgbytes[cgoffset++] = value;
-				value = 0;
-			}
-
-			esc++;
-		}
-
-		lcd->ops->write_cmd(lcd, LCD_CMD_SET_CGRAM_ADDR | (cgaddr * 8));
-		for (addr = 0; addr < cgoffset; addr++)
-			lcd->ops->write_data(lcd, cgbytes[addr]);
-
-		/* ensures that we stop writing to CGRAM */
-		charlcd_gotoxy(lcd);
-		processed = 1;
 		break;
 	}
 	case 'x':	/* gotoxy : LxXXX[yYYY]; */
 	case 'y':	/* gotoxy : LyYYY[xXXX]; */
-		if (priv->esc_seq.buf[priv->esc_seq.len - 1] != ';')
+		if (lcd->esc_seq.buf[lcd->esc_seq.len - 1] != ';')
 			break;
 
 		/* If the command is valid, move to the new address */
-		if (parse_xy(esc, &priv->addr.x, &priv->addr.y))
-			charlcd_gotoxy(lcd);
+		if (parse_xy(esc, &lcd->addr.x, &lcd->addr.y))
+			lcd->ops->gotoxy(lcd);
 
 		/* Regardless of its validity, mark as processed */
 		processed = 1;
 		break;
 	}
 
-	/* TODO: This indent party here got ugly, clean it! */
-	/* Check whether one flag was changed */
-	if (oldflags == priv->flags)
-		return processed;
-
-	/* check whether one of B,C,D flags were changed */
-	if ((oldflags ^ priv->flags) &
-	    (LCD_FLAG_B | LCD_FLAG_C | LCD_FLAG_D))
-		/* set display mode */
-		lcd->ops->write_cmd(lcd,
-			LCD_CMD_DISPLAY_CTRL |
-			((priv->flags & LCD_FLAG_D) ? LCD_CMD_DISPLAY_ON : 0) |
-			((priv->flags & LCD_FLAG_C) ? LCD_CMD_CURSOR_ON : 0) |
-			((priv->flags & LCD_FLAG_B) ? LCD_CMD_BLINK_ON : 0));
-	/* check whether one of F,N flags was changed */
-	else if ((oldflags ^ priv->flags) & (LCD_FLAG_F | LCD_FLAG_N))
-		lcd->ops->write_cmd(lcd,
-			LCD_CMD_FUNCTION_SET |
-			((lcd->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
-			((priv->flags & LCD_FLAG_F) ? LCD_CMD_FONT_5X10_DOTS : 0) |
-			((priv->flags & LCD_FLAG_N) ? LCD_CMD_TWO_LINES : 0));
-	/* check whether L flag was changed */
-	else if ((oldflags ^ priv->flags) & LCD_FLAG_L)
-		charlcd_backlight(lcd, !!(priv->flags & LCD_FLAG_L));
-
 	return processed;
 }
 
 static void charlcd_write_char(struct charlcd *lcd, char c)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-
 	/* first, we'll test if we're in escape mode */
-	if ((c != '\n') && priv->esc_seq.len >= 0) {
+	if ((c != '\n') && lcd->esc_seq.len >= 0) {
 		/* yes, let's add this char to the buffer */
-		priv->esc_seq.buf[priv->esc_seq.len++] = c;
-		priv->esc_seq.buf[priv->esc_seq.len] = '\0';
+		lcd->esc_seq.buf[lcd->esc_seq.len++] = c;
+		lcd->esc_seq.buf[lcd->esc_seq.len] = '\0';
 	} else {
 		/* aborts any previous escape sequence */
-		priv->esc_seq.len = -1;
+		lcd->esc_seq.len = -1;
 
 		switch (c) {
 		case LCD_ESCAPE_CHAR:
 			/* start of an escape sequence */
-			priv->esc_seq.len = 0;
-			priv->esc_seq.buf[priv->esc_seq.len] = '\0';
+			lcd->esc_seq.len = 0;
+			lcd->esc_seq.buf[lcd->esc_seq.len] = '\0';
 			break;
 		case '\b':
 			/* go back one char and clear it */
-			if (priv->addr.x > 0) {
-				/*
-				 * check if we're not at the
-				 * end of the line
-				 */
-				if (priv->addr.x < lcd->bwidth)
-					/* back one char */
-					lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
-				priv->addr.x--;
+			if (lcd->addr.x > 0) {
+				/* back one char */
+				if (!lcd->ops->shift_cursor(lcd,
+							CHARLCD_SHIFT_LEFT))
+					lcd->addr.x--;
 			}
 			/* replace with a space */
-			lcd->ops->write_data(lcd, ' ');
+			charlcd_print(lcd, ' ');
 			/* back one char again */
-			lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
+			if (!lcd->ops->shift_cursor(lcd, CHARLCD_SHIFT_LEFT))
+				lcd->addr.x--;
+
 			break;
 		case '\f':
 			/* quickly clear the display */
-			charlcd_clear_fast(lcd);
+			lcd->addr.x = 0;
+			lcd->addr.y = 0;
+			lcd->ops->clear_display(lcd);
 			break;
 		case '\n':
 			/*
 			 * flush the remainder of the current line and
 			 * go to the beginning of the next line
 			 */
-			for (; priv->addr.x < lcd->bwidth; priv->addr.x++)
-				lcd->ops->write_data(lcd, ' ');
-			priv->addr.x = 0;
-			priv->addr.y = (priv->addr.y + 1) % lcd->height;
-			charlcd_gotoxy(lcd);
+			for (; lcd->addr.x < lcd->width; )
+				charlcd_print(lcd, ' ');
+
+			lcd->addr.x = 0;
+			lcd->addr.y = (lcd->addr.y + 1) % lcd->height;
+			lcd->ops->gotoxy(lcd);
 			break;
 		case '\r':
 			/* go to the beginning of the same line */
-			priv->addr.x = 0;
-			charlcd_gotoxy(lcd);
+			lcd->addr.x = 0;
+			lcd->ops->gotoxy(lcd);
 			break;
 		case '\t':
 			/* print a space instead of the tab */
@@ -649,22 +411,26 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 	 * now we'll see if we're in an escape mode and if the current
 	 * escape sequence can be understood.
 	 */
-	if (priv->esc_seq.len >= 2) {
+	if (lcd->esc_seq.len >= 2) {
 		int processed = 0;
 
-		if (!strcmp(priv->esc_seq.buf, "[2J")) {
+		if (!strcmp(lcd->esc_seq.buf, "[2J")) {
 			/* clear the display */
-			charlcd_clear_fast(lcd);
+			lcd->addr.x = 0;
+			lcd->addr.y = 0;
+			lcd->ops->clear_display(lcd);
 			processed = 1;
-		} else if (!strcmp(priv->esc_seq.buf, "[H")) {
+		} else if (!strcmp(lcd->esc_seq.buf, "[H")) {
 			/* cursor to home */
-			charlcd_home(lcd);
+			lcd->addr.x = 0;
+			lcd->addr.y = 0;
+			lcd->ops->home(lcd);
 			processed = 1;
 		}
 		/* codes starting with ^[[L */
-		else if ((priv->esc_seq.len >= 3) &&
-			 (priv->esc_seq.buf[0] == '[') &&
-			 (priv->esc_seq.buf[1] == 'L')) {
+		else if ((lcd->esc_seq.len >= 3) &&
+			 (lcd->esc_seq.buf[0] == '[') &&
+			 (lcd->esc_seq.buf[1] == 'L')) {
 			processed = handle_lcd_special_code(lcd);
 		}
 
@@ -673,8 +439,8 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 		 * flush the escape sequence if it's been processed
 		 * or if it is getting too long.
 		 */
-		if (processed || (priv->esc_seq.len >= LCD_ESCAPE_LEN))
-			priv->esc_seq.len = -1;
+		if (processed || (lcd->esc_seq.len >= LCD_ESCAPE_LEN))
+			lcd->esc_seq.len = -1;
 	} /* escape codes */
 }
 
@@ -705,7 +471,7 @@ static ssize_t charlcd_write(struct file *file, const char __user *buf,
 
 static int charlcd_open(struct inode *inode, struct file *file)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(the_charlcd);
+	struct charlcd *lcd = the_charlcd;
 	int ret;
 
 	ret = -EBUSY;
@@ -716,9 +482,11 @@ static int charlcd_open(struct inode *inode, struct file *file)
 	if (file->f_mode & FMODE_READ)	/* device is write-only */
 		goto fail;
 
-	if (priv->must_clear) {
-		charlcd_clear_display(&priv->lcd);
-		priv->must_clear = false;
+	if (lcd->must_clear) {
+		lcd->addr.x = 0;
+		lcd->addr.y = 0;
+		lcd->ops->clear_display(lcd);
+		lcd->must_clear = false;
 	}
 	return nonseekable_open(inode, file);
 
@@ -752,15 +520,17 @@ static void charlcd_puts(struct charlcd *lcd, const char *s)
 	int count = strlen(s);
 
 	for (; count-- > 0; tmp++) {
-		if (!in_interrupt() && (((count + 1) & 0x1f) == 0))
+		if (!in_interrupt() && (((count + 1) & 0x1f) == 0)) {
 			/*
 			 * let's be a little nice with other processes
 			 * that need some CPU
 			 */
 			schedule();
+		}
 
 		charlcd_write_char(lcd, *tmp);
 	}
+
 }
 
 #ifdef CONFIG_PANEL_BOOT_MESSAGE
@@ -780,12 +550,13 @@ static void charlcd_puts(struct charlcd *lcd, const char *s)
 /* initialize the LCD driver */
 static int charlcd_init(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 	int ret;
 
+	lcd->flags = ((lcd->height > 1) ? LCD_FLAG_N : 0) | LCD_FLAG_D |
+		      LCD_FLAG_C | LCD_FLAG_B;
 	if (lcd->ops->backlight) {
-		mutex_init(&priv->bl_tempo_lock);
-		INIT_DELAYED_WORK(&priv->bl_work, charlcd_bl_off);
+		mutex_init(&lcd->bl_tempo_lock);
+		INIT_DELAYED_WORK(&lcd->bl_work, charlcd_bl_off);
 	}
 
 	/*
@@ -793,7 +564,7 @@ static int charlcd_init(struct charlcd *lcd)
 	 * Since charlcd_init_display() needs to write data, we have to
 	 * enable mark the LCD initialized just before.
 	 */
-	ret = charlcd_init_display(lcd);
+	ret = lcd->ops->init_display(lcd);
 	if (ret)
 		return ret;
 
@@ -801,38 +572,26 @@ static int charlcd_init(struct charlcd *lcd)
 	charlcd_puts(lcd, "\x1b[Lc\x1b[Lb" LCD_INIT_BL LCD_INIT_TEXT);
 
 	/* clear the display on the next device opening */
-	priv->must_clear = true;
-	charlcd_home(lcd);
+	lcd->must_clear = true;
+	lcd->addr.x = 0;
+	lcd->addr.y = 0;
+	lcd->ops->home(lcd);
 	return 0;
 }
 
-struct charlcd *charlcd_alloc(unsigned int drvdata_size)
+struct charlcd *charlcd_alloc(void)
 {
-	struct charlcd_priv *priv;
 	struct charlcd *lcd;
 
-	priv = kzalloc(sizeof(*priv) + drvdata_size, GFP_KERNEL);
-	if (!priv)
+	lcd = kzalloc(sizeof(struct charlcd), GFP_KERNEL);
+	if (!lcd)
 		return NULL;
 
-	priv->esc_seq.len = -1;
-
-	lcd = &priv->lcd;
-	lcd->ifwidth = 8;
-	lcd->bwidth = DEFAULT_LCD_BWIDTH;
-	lcd->hwidth = DEFAULT_LCD_HWIDTH;
-	lcd->drvdata = priv->drvdata;
-
+	lcd->esc_seq.len = -1;
 	return lcd;
 }
 EXPORT_SYMBOL_GPL(charlcd_alloc);
 
-void charlcd_free(struct charlcd *lcd)
-{
-	kfree(charlcd_to_priv(lcd));
-}
-EXPORT_SYMBOL_GPL(charlcd_free);
-
 static int panel_notify_sys(struct notifier_block *this, unsigned long code,
 			    void *unused)
 {
@@ -881,15 +640,13 @@ EXPORT_SYMBOL_GPL(charlcd_register);
 
 int charlcd_unregister(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-
 	unregister_reboot_notifier(&panel_notifier);
 	charlcd_puts(lcd, "\x0cLCD driver unloaded.\x1b[Lc\x1b[Lb\x1b[L-");
 	misc_deregister(&charlcd_dev);
 	the_charlcd = NULL;
 	if (lcd->ops->backlight) {
-		cancel_delayed_work_sync(&priv->bl_work);
-		priv->lcd.ops->backlight(&priv->lcd, 0);
+		cancel_delayed_work_sync(&lcd->bl_work);
+		lcd->ops->backlight(lcd, CHARLCD_OFF);
 	}
 
 	return 0;
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 00911ad0f3de..6a9215871ff4 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -9,36 +9,113 @@
 #ifndef _CHARLCD_H
 #define _CHARLCD_H
 
+#define LCD_FLAG_B		0x0004	/* Blink on */
+#define LCD_FLAG_C		0x0008	/* Cursor on */
+#define LCD_FLAG_D		0x0010	/* Display on */
+#define LCD_FLAG_F		0x0020	/* Large font mode */
+#define LCD_FLAG_N		0x0040	/* 2-rows mode */
+#define LCD_FLAG_L		0x0080	/* Backlight enabled */
+
+#define LCD_ESCAPE_LEN		24	/* Max chars for LCD escape command */
+
+enum charlcd_onoff {
+	CHARLCD_OFF = 0,
+	CHARLCD_ON,
+};
+
+enum charlcd_shift_dir {
+	CHARLCD_SHIFT_LEFT,
+	CHARLCD_SHIFT_RIGHT,
+};
+
+enum charlcd_fontsize {
+	CHARLCD_FONTSIZE_SMALL,
+	CHARLCD_FONTSIZE_LARGE,
+};
+
+enum charlcd_lines {
+	CHARLCD_LINES_1,
+	CHARLCD_LINES_2,
+};
+
 struct charlcd {
 	const struct charlcd_ops *ops;
 	const unsigned char *char_conv;	/* Optional */
 
-	int ifwidth;			/* 4-bit or 8-bit (default) */
 	int height;
 	int width;
-	int bwidth;			/* Default set by charlcd_alloc() */
-	int hwidth;			/* Default set by charlcd_alloc() */
 
-	void *drvdata;			/* Set by charlcd_alloc() */
+	struct delayed_work bl_work;
+	struct mutex bl_tempo_lock;	/* Protects access to bl_tempo */
+	bool bl_tempo;
+
+	bool must_clear;
+
+	/* contains the LCD config state */
+	unsigned long flags;
+
+	/* Contains the LCD X and Y offset */
+	struct {
+		unsigned long x;
+		unsigned long y;
+	} addr;
+
+	/* Current escape sequence and it's length or -1 if outside */
+	struct {
+		char buf[LCD_ESCAPE_LEN + 1];
+		int len;
+	} esc_seq;
+
+	void *drvdata;
 };
 
+/**
+ * struct charlcd_ops - Functions used by charlcd. Drivers have to implement
+ * these.
+ * @print: just Print one character to the display at current cursor position.
+ * The cursor is advanced by charlcd.
+ * @clear_fast: Clear the whole display and set cursor to position 0, 0.
+ * @backlight: Turn backlight on or off. Optional.
+ * @gotoxy: Set cursor to x, y. The x and y values to set the cursor to are
+ * previously set in addr.x and addr.y by charlcd.
+ * @home: Set cursor to 0, 0. The values in addr.x and addr.y are set to 0, 0 by
+ * charlcd prior to calling this function.
+ * @clear_display: Again clear the whole display, set the cursor to 0, 0. The
+ * values in addr.x and addr.y are set to 0, 0 by charlcd prior to calling this
+ * function.
+ * @init_display: Initialize the display.
+ * @shift_cursor: Shift cursor left or right one position.
+ * @shift_display: Shift whole display content left or right.
+ * @display: Turn display on or off.
+ * @cursor: Turn cursor on or off.
+ * @blink: Turn cursor blink on or off.
+ * @fontsize: Fontsize large or small.
+ * @lines: One or two lines.
+ * @redefine_char: Redefine the actual pixel matrix of character.
+ */
 struct charlcd_ops {
-	/* Required */
-	void (*write_cmd)(struct charlcd *lcd, int cmd);
-	void (*write_data)(struct charlcd *lcd, int data);
-
-	/* Optional */
-	void (*write_cmd_raw4)(struct charlcd *lcd, int cmd);	/* 4-bit only */
-	void (*clear_fast)(struct charlcd *lcd);
-	void (*backlight)(struct charlcd *lcd, int on);
+	int (*print)(struct charlcd *lcd, int c);
+	int (*clear_fast)(struct charlcd *lcd);
+	int (*backlight)(struct charlcd *lcd, enum charlcd_onoff on);
+	int (*gotoxy)(struct charlcd *lcd);
+	int (*home)(struct charlcd *lcd);
+	int (*clear_display)(struct charlcd *lcd);
+	int (*init_display)(struct charlcd *lcd);
+	int (*shift_cursor)(struct charlcd *lcd, enum charlcd_shift_dir dir);
+	int (*shift_display)(struct charlcd *lcd, enum charlcd_shift_dir dir);
+	int (*display)(struct charlcd *lcd, enum charlcd_onoff on);
+	int (*cursor)(struct charlcd *lcd, enum charlcd_onoff on);
+	int (*blink)(struct charlcd *lcd, enum charlcd_onoff on);
+	int (*fontsize)(struct charlcd *lcd, enum charlcd_fontsize size);
+	int (*lines)(struct charlcd *lcd, enum charlcd_lines lines);
+	int (*redefine_char)(struct charlcd *lcd, char *esc);
 };
 
-struct charlcd *charlcd_alloc(unsigned int drvdata_size);
+int charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
+struct charlcd *charlcd_alloc(void);
 void charlcd_free(struct charlcd *lcd);
-
 int charlcd_register(struct charlcd *lcd);
 int charlcd_unregister(struct charlcd *lcd);
-
-void charlcd_poke(struct charlcd *lcd);
+int charlcd_poke(struct charlcd *lcd);
 
 #endif /* CHARLCD_H */
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index bcbe13092327..60bec69f9c29 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 
 #include "charlcd.h"
+#include "hd44780_common.h"
 
 enum hd44780_pin {
 	/* Order does matter due to writing to GPIO array subsets! */
@@ -37,12 +38,15 @@ struct hd44780 {
 	struct gpio_desc *pins[PIN_NUM];
 };
 
-static void hd44780_backlight(struct charlcd *lcd, int on)
+static int hd44780_backlight(struct charlcd *lcd, enum charlcd_onoff on)
 {
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780_common *hdc = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 
 	if (hd->pins[PIN_CTRL_BL])
 		gpiod_set_value_cansleep(hd->pins[PIN_CTRL_BL], on);
+
+	return 0;
 }
 
 static void hd44780_strobe_gpio(struct hd44780 *hd)
@@ -101,9 +105,9 @@ static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 }
 
 /* Send a command to the LCD panel in 8 bit GPIO mode */
-static void hd44780_write_cmd_gpio8(struct charlcd *lcd, int cmd)
+static void hd44780_write_cmd_gpio8(struct hd44780_common *hdc, int cmd)
 {
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio8(hd, cmd, 0);
 
@@ -112,9 +116,9 @@ static void hd44780_write_cmd_gpio8(struct charlcd *lcd, int cmd)
 }
 
 /* Send data to the LCD panel in 8 bit GPIO mode */
-static void hd44780_write_data_gpio8(struct charlcd *lcd, int data)
+static void hd44780_write_data_gpio8(struct hd44780_common *hdc, int data)
 {
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio8(hd, data, 1);
 
@@ -123,15 +127,25 @@ static void hd44780_write_data_gpio8(struct charlcd *lcd, int data)
 }
 
 static const struct charlcd_ops hd44780_ops_gpio8 = {
-	.write_cmd	= hd44780_write_cmd_gpio8,
-	.write_data	= hd44780_write_data_gpio8,
 	.backlight	= hd44780_backlight,
+	.gotoxy		= hd44780_common_gotoxy,
+	.home		= hd44780_common_home,
+	.clear_display	= hd44780_common_clear_display,
+	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
+	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
+	.redefine_char	= hd44780_common_redefine_char,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
-static void hd44780_write_cmd_gpio4(struct charlcd *lcd, int cmd)
+static void hd44780_write_cmd_gpio4(struct hd44780_common *hdc, int cmd)
 {
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio4(hd, cmd, 0);
 
@@ -140,10 +154,10 @@ static void hd44780_write_cmd_gpio4(struct charlcd *lcd, int cmd)
 }
 
 /* Send 4-bits of a command to the LCD panel in raw 4 bit GPIO mode */
-static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
+static void hd44780_write_cmd_raw_gpio4(struct hd44780_common *hdc, int cmd)
 {
 	DECLARE_BITMAP(values, 6); /* for DATA[4-7], RS, RW */
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 	unsigned int n;
 
 	/* Command nibble + RS, RW */
@@ -157,9 +171,9 @@ static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
 }
 
 /* Send data to the LCD panel in 4 bit GPIO mode */
-static void hd44780_write_data_gpio4(struct charlcd *lcd, int data)
+static void hd44780_write_data_gpio4(struct hd44780_common *hdc, int data)
 {
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio4(hd, data, 1);
 
@@ -168,10 +182,20 @@ static void hd44780_write_data_gpio4(struct charlcd *lcd, int data)
 }
 
 static const struct charlcd_ops hd44780_ops_gpio4 = {
-	.write_cmd	= hd44780_write_cmd_gpio4,
-	.write_cmd_raw4	= hd44780_write_cmd_raw_gpio4,
-	.write_data	= hd44780_write_data_gpio4,
 	.backlight	= hd44780_backlight,
+	.print		= hd44780_common_print,
+	.gotoxy		= hd44780_common_gotoxy,
+	.home		= hd44780_common_home,
+	.clear_display	= hd44780_common_clear_display,
+	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
+	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
+	.redefine_char	= hd44780_common_redefine_char,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
@@ -179,8 +203,9 @@ static int hd44780_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	unsigned int i, base;
 	struct charlcd *lcd;
+	struct hd44780_common *hdc;
 	struct hd44780 *hd;
-	int ifwidth, ret;
+	int ifwidth, ret = -ENOMEM;
 
 	/* Required pins */
 	ifwidth = gpiod_count(dev, "data");
@@ -198,31 +223,39 @@ static int hd44780_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	lcd = charlcd_alloc(sizeof(struct hd44780));
-	if (!lcd)
+	hdc = hd44780_common_alloc();
+	if (!hdc)
 		return -ENOMEM;
 
-	hd = lcd->drvdata;
+	lcd = charlcd_alloc();
+	if (!lcd)
+		goto fail1;
 
+	hd = kzalloc(sizeof(struct hd44780), GFP_KERNEL);
+	if (!hd)
+		goto fail2;
+
+	hdc->hd44780 = hd;
+	lcd->drvdata = hdc;
 	for (i = 0; i < ifwidth; i++) {
 		hd->pins[base + i] = devm_gpiod_get_index(dev, "data", i,
 							  GPIOD_OUT_LOW);
 		if (IS_ERR(hd->pins[base + i])) {
 			ret = PTR_ERR(hd->pins[base + i]);
-			goto fail;
+			goto fail3;
 		}
 	}
 
 	hd->pins[PIN_CTRL_E] = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(hd->pins[PIN_CTRL_E])) {
 		ret = PTR_ERR(hd->pins[PIN_CTRL_E]);
-		goto fail;
+		goto fail3;
 	}
 
 	hd->pins[PIN_CTRL_RS] = devm_gpiod_get(dev, "rs", GPIOD_OUT_HIGH);
 	if (IS_ERR(hd->pins[PIN_CTRL_RS])) {
 		ret = PTR_ERR(hd->pins[PIN_CTRL_RS]);
-		goto fail;
+		goto fail3;
 	}
 
 	/* Optional pins */
@@ -230,47 +263,60 @@ static int hd44780_probe(struct platform_device *pdev)
 							GPIOD_OUT_LOW);
 	if (IS_ERR(hd->pins[PIN_CTRL_RW])) {
 		ret = PTR_ERR(hd->pins[PIN_CTRL_RW]);
-		goto fail;
+		goto fail3;
 	}
 
 	hd->pins[PIN_CTRL_BL] = devm_gpiod_get_optional(dev, "backlight",
 							GPIOD_OUT_LOW);
 	if (IS_ERR(hd->pins[PIN_CTRL_BL])) {
 		ret = PTR_ERR(hd->pins[PIN_CTRL_BL]);
-		goto fail;
+		goto fail3;
 	}
 
 	/* Required properties */
 	ret = device_property_read_u32(dev, "display-height-chars",
 				       &lcd->height);
 	if (ret)
-		goto fail;
+		goto fail3;
 	ret = device_property_read_u32(dev, "display-width-chars", &lcd->width);
 	if (ret)
-		goto fail;
+		goto fail3;
 
 	/*
 	 * On displays with more than two rows, the internal buffer width is
 	 * usually equal to the display width
 	 */
 	if (lcd->height > 2)
-		lcd->bwidth = lcd->width;
+		hdc->bwidth = lcd->width;
 
 	/* Optional properties */
-	device_property_read_u32(dev, "internal-buffer-width", &lcd->bwidth);
-
-	lcd->ifwidth = ifwidth;
-	lcd->ops = ifwidth == 8 ? &hd44780_ops_gpio8 : &hd44780_ops_gpio4;
+	device_property_read_u32(dev, "internal-buffer-width", &hdc->bwidth);
+
+	hdc->ifwidth = ifwidth;
+	if (ifwidth == 8) {
+		lcd->ops = &hd44780_ops_gpio8;
+		hdc->write_data = hd44780_write_data_gpio8;
+		hdc->write_cmd = hd44780_write_cmd_gpio8;
+	} else {
+		lcd->ops = &hd44780_ops_gpio4;
+		hdc->write_data = hd44780_write_data_gpio4;
+		hdc->write_cmd = hd44780_write_cmd_gpio4;
+		hdc->write_cmd_raw4 = hd44780_write_cmd_raw_gpio4;
+	}
 
 	ret = charlcd_register(lcd);
 	if (ret)
-		goto fail;
+		goto fail3;
 
 	platform_set_drvdata(pdev, lcd);
 	return 0;
 
-fail:
-	charlcd_free(lcd);
+fail3:
+	kfree(hd);
+fail2:
+	kfree(lcd);
+fail1:
+	kfree(hdc);
 	return ret;
 }
 
@@ -278,9 +324,10 @@ static int hd44780_remove(struct platform_device *pdev)
 {
 	struct charlcd *lcd = platform_get_drvdata(pdev);
 
+	kfree(lcd->drvdata);
 	charlcd_unregister(lcd);
 
-	charlcd_free(lcd);
+	kfree(lcd);
 	return 0;
 }
 
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
new file mode 100644
index 000000000000..91b7365e1ca8
--- /dev/null
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#include "charlcd.h"
+#include "hd44780_common.h"
+
+/* LCD commands */
+#define LCD_CMD_DISPLAY_CLEAR	0x01	/* Clear entire display */
+
+#define LCD_CMD_ENTRY_MODE	0x04	/* Set entry mode */
+#define LCD_CMD_CURSOR_INC	0x02	/* Increment cursor */
+
+#define LCD_CMD_DISPLAY_CTRL	0x08	/* Display control */
+#define LCD_CMD_DISPLAY_ON	0x04	/* Set display on */
+#define LCD_CMD_CURSOR_ON	0x02	/* Set cursor on */
+#define LCD_CMD_BLINK_ON	0x01	/* Set blink on */
+
+#define LCD_CMD_SHIFT		0x10	/* Shift cursor/display */
+#define LCD_CMD_DISPLAY_SHIFT	0x08	/* Shift display instead of cursor */
+#define LCD_CMD_SHIFT_RIGHT	0x04	/* Shift display/cursor to the right */
+
+#define LCD_CMD_FUNCTION_SET	0x20	/* Set function */
+#define LCD_CMD_DATA_LEN_8BITS	0x10	/* Set data length to 8 bits */
+#define LCD_CMD_TWO_LINES	0x08	/* Set to two display lines */
+#define LCD_CMD_FONT_5X10_DOTS	0x04	/* Set char font to 5x10 dots */
+
+#define LCD_CMD_SET_CGRAM_ADDR	0x40	/* Set char generator RAM address */
+
+#define LCD_CMD_SET_DDRAM_ADDR	0x80	/* Set display data RAM address */
+
+#define DEFAULT_LCD_BWIDTH      40
+#define DEFAULT_LCD_HWIDTH      64
+
+/* sleeps that many milliseconds with a reschedule */
+static void long_sleep(int ms)
+{
+	schedule_timeout_interruptible(msecs_to_jiffies(ms));
+}
+
+int hd44780_common_print(struct charlcd *lcd, int c)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (lcd->addr.x < hdc->bwidth)
+		hdc->write_data(hdc, c);
+
+	return 0;
+}
+
+int hd44780_common_gotoxy(struct charlcd *lcd)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+	unsigned int addr;
+
+	/*
+	 * we force the cursor to stay at the end of the
+	 * line if it wants to go farther
+	 */
+	addr = lcd->addr.x < hdc->bwidth ? lcd->addr.x & (hdc->hwidth - 1)
+					  : hdc->bwidth - 1;
+	if (lcd->addr.y & 1)
+		addr += hdc->hwidth;
+	if (lcd->addr.y & 2)
+		addr += hdc->bwidth;
+	hdc->write_cmd(hdc, LCD_CMD_SET_DDRAM_ADDR | addr);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_gotoxy);
+
+int hd44780_common_home(struct charlcd *lcd)
+{
+	return hd44780_common_gotoxy(lcd);
+}
+EXPORT_SYMBOL_GPL(hd44780_common_home);
+
+/* clears the display and resets X/Y */
+int hd44780_common_clear_display(struct charlcd *lcd)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
+	/* we must wait a few milliseconds (15) */
+	long_sleep(15);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_clear_display);
+
+int hd44780_common_init_display(struct charlcd *lcd)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	void (*write_cmd_raw)(struct hd44780_common *hdc, int cmd);
+	u8 init;
+
+	if (hdc->ifwidth != 4 && hdc->ifwidth != 8)
+		return -EINVAL;
+
+	hdc->hd44780_common_flags = ((lcd->height > 1) ? LCD_FLAG_N : 0) |
+		LCD_FLAG_D | LCD_FLAG_C | LCD_FLAG_B;
+
+	long_sleep(20);		/* wait 20 ms after power-up for the paranoid */
+
+	/*
+	 * 8-bit mode, 1 line, small fonts; let's do it 3 times, to make sure
+	 * the LCD is in 8-bit mode afterwards
+	 */
+	init = LCD_CMD_FUNCTION_SET | LCD_CMD_DATA_LEN_8BITS;
+	if (hdc->ifwidth == 4) {
+		init >>= 4;
+		write_cmd_raw = hdc->write_cmd_raw4;
+	} else {
+		write_cmd_raw = hdc->write_cmd;
+	}
+	write_cmd_raw(hdc, init);
+	long_sleep(10);
+	write_cmd_raw(hdc, init);
+	long_sleep(10);
+	write_cmd_raw(hdc, init);
+	long_sleep(10);
+
+	if (hdc->ifwidth == 4) {
+		/* Switch to 4-bit mode, 1 line, small fonts */
+		hdc->write_cmd_raw4(hdc, LCD_CMD_FUNCTION_SET >> 4);
+		long_sleep(10);
+	}
+
+	/* set font height and lines number */
+	hdc->write_cmd(hdc,
+		LCD_CMD_FUNCTION_SET |
+		((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_F) ?
+			LCD_CMD_FONT_5X10_DOTS : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_N) ?
+			LCD_CMD_TWO_LINES : 0));
+	long_sleep(10);
+
+	/* display off, cursor off, blink off */
+	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CTRL);
+	long_sleep(10);
+
+	hdc->write_cmd(hdc,
+		LCD_CMD_DISPLAY_CTRL |	/* set display mode */
+		((hdc->hd44780_common_flags & LCD_FLAG_D) ?
+			LCD_CMD_DISPLAY_ON : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_C) ?
+			LCD_CMD_CURSOR_ON : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_B) ?
+			LCD_CMD_BLINK_ON : 0));
+
+	charlcd_backlight(lcd,
+			(hdc->hd44780_common_flags & LCD_FLAG_L) ? 1 : 0);
+
+	long_sleep(10);
+
+	/* entry mode set : increment, cursor shifting */
+	hdc->write_cmd(hdc, LCD_CMD_ENTRY_MODE | LCD_CMD_CURSOR_INC);
+
+	hd44780_common_clear_display(lcd);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_init_display);
+
+int hd44780_common_shift_cursor(struct charlcd *lcd, enum charlcd_shift_dir dir)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (dir == CHARLCD_SHIFT_LEFT) {
+		/* back one char if not at end of line */
+		if (lcd->addr.x < hdc->bwidth)
+			hdc->write_cmd(hdc, LCD_CMD_SHIFT);
+	} else if (dir == CHARLCD_SHIFT_RIGHT) {
+		/* allow the cursor to pass the end of the line */
+		if (lcd->addr.x < (hdc->bwidth - 1))
+			hdc->write_cmd(hdc,
+					LCD_CMD_SHIFT | LCD_CMD_SHIFT_RIGHT);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_shift_cursor);
+
+int hd44780_common_shift_display(struct charlcd *lcd,
+		enum charlcd_shift_dir dir)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (dir == CHARLCD_SHIFT_LEFT)
+		hdc->write_cmd(hdc, LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT);
+	else if (dir == CHARLCD_SHIFT_RIGHT)
+		hdc->write_cmd(hdc, LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT |
+			LCD_CMD_SHIFT_RIGHT);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_shift_display);
+
+static void hd44780_common_set_mode(struct hd44780_common *hdc)
+{
+	hdc->write_cmd(hdc,
+		LCD_CMD_DISPLAY_CTRL |
+		((hdc->hd44780_common_flags & LCD_FLAG_D) ?
+			LCD_CMD_DISPLAY_ON : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_C) ?
+			LCD_CMD_CURSOR_ON : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_B) ?
+			LCD_CMD_BLINK_ON : 0));
+}
+
+int hd44780_common_display(struct charlcd *lcd, enum charlcd_onoff on)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (on == CHARLCD_ON)
+		hdc->hd44780_common_flags |= LCD_FLAG_D;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_D;
+
+	hd44780_common_set_mode(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_display);
+
+int hd44780_common_cursor(struct charlcd *lcd, enum charlcd_onoff on)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (on == CHARLCD_ON)
+		hdc->hd44780_common_flags |= LCD_FLAG_C;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_C;
+
+	hd44780_common_set_mode(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_cursor);
+
+int hd44780_common_blink(struct charlcd *lcd, enum charlcd_onoff on)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (on == CHARLCD_ON)
+		hdc->hd44780_common_flags |= LCD_FLAG_B;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_B;
+
+	hd44780_common_set_mode(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_blink);
+
+static void hd44780_common_set_function(struct hd44780_common *hdc)
+{
+	hdc->write_cmd(hdc,
+		LCD_CMD_FUNCTION_SET |
+		((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_F) ?
+			LCD_CMD_FONT_5X10_DOTS : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_N) ?
+			LCD_CMD_TWO_LINES : 0));
+}
+
+int hd44780_common_fontsize(struct charlcd *lcd, enum charlcd_fontsize size)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (size == CHARLCD_FONTSIZE_LARGE)
+		hdc->hd44780_common_flags |= LCD_FLAG_F;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_F;
+
+	hd44780_common_set_function(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_fontsize);
+
+int hd44780_common_lines(struct charlcd *lcd, enum charlcd_lines lines)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (lines == CHARLCD_LINES_2)
+		hdc->hd44780_common_flags |= LCD_FLAG_N;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_N;
+
+	hd44780_common_set_function(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_lines);
+
+int hd44780_common_redefine_char(struct charlcd *lcd, char *esc)
+{
+	/* Generator : LGcxxxxx...xx; must have <c> between '0'
+	 * and '7', representing the numerical ASCII code of the
+	 * redefined character, and <xx...xx> a sequence of 16
+	 * hex digits representing 8 bytes for each character.
+	 * Most LCDs will only use 5 lower bits of the 7 first
+	 * bytes.
+	 */
+
+	struct hd44780_common *hdc = lcd->drvdata;
+	unsigned char cgbytes[8];
+	unsigned char cgaddr;
+	int cgoffset;
+	int shift;
+	char value;
+	int addr;
+
+	if (!strchr(esc, ';'))
+		return 0;
+
+	esc++;
+
+	cgaddr = *(esc++) - '0';
+	if (cgaddr > 7)
+		return 1;
+
+	cgoffset = 0;
+	shift = 0;
+	value = 0;
+	while (*esc && cgoffset < 8) {
+		shift ^= 4;
+		if (*esc >= '0' && *esc <= '9') {
+			value |= (*esc - '0') << shift;
+		} else if (*esc >= 'A' && *esc <= 'F') {
+			value |= (*esc - 'A' + 10) << shift;
+		} else if (*esc >= 'a' && *esc <= 'f') {
+			value |= (*esc - 'a' + 10) << shift;
+		} else {
+			esc++;
+			continue;
+		}
+
+		if (shift == 0) {
+			cgbytes[cgoffset++] = value;
+			value = 0;
+		}
+
+		esc++;
+	}
+
+	hdc->write_cmd(hdc, LCD_CMD_SET_CGRAM_ADDR | (cgaddr * 8));
+	for (addr = 0; addr < cgoffset; addr++)
+		hdc->write_data(hdc, cgbytes[addr]);
+
+	/* ensures that we stop writing to CGRAM */
+	lcd->ops->gotoxy(lcd);
+	return 1;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_redefine_char);
+
+struct hd44780_common *hd44780_common_alloc(void)
+{
+	struct hd44780_common *hd;
+
+	hd = kzalloc(sizeof(*hd), GFP_KERNEL);
+	if (!hd)
+		return NULL;
+
+	hd->ifwidth = 8;
+	hd->bwidth = DEFAULT_LCD_BWIDTH;
+	hd->hwidth = DEFAULT_LCD_HWIDTH;
+	return hd;
+
+}
+EXPORT_SYMBOL_GPL(hd44780_common_alloc);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
new file mode 100644
index 000000000000..a713b468f44c
--- /dev/null
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+struct hd44780_common;
+struct hd44780_common {
+	int ifwidth;			/* 4-bit or 8-bit (default) */
+	int bwidth;			/* Default set by hd44780_alloc() */
+	int hwidth;			/* Default set by hd44780_alloc() */
+	unsigned long hd44780_common_flags;
+	void (*write_data)(struct hd44780_common *hdc, int data);
+	void (*write_cmd)(struct hd44780_common *hdc, int cmd);
+	/* write_cmd_raw4 is for 4-bit connected displays only */
+	void (*write_cmd_raw4)(struct hd44780_common *hdc, int cmd);
+	void *hd44780;
+};
+
+int hd44780_common_print(struct charlcd *lcd, int c);
+int hd44780_common_gotoxy(struct charlcd *lcd);
+int hd44780_common_home(struct charlcd *lcd);
+int hd44780_common_clear_display(struct charlcd *lcd);
+int hd44780_common_init_display(struct charlcd *lcd);
+int hd44780_common_shift_cursor(struct charlcd *lcd,
+		enum charlcd_shift_dir dir);
+int hd44780_common_shift_display(struct charlcd *lcd,
+		enum charlcd_shift_dir dir);
+int hd44780_common_display(struct charlcd *lcd, enum charlcd_onoff on);
+int hd44780_common_cursor(struct charlcd *lcd, enum charlcd_onoff on);
+int hd44780_common_blink(struct charlcd *lcd, enum charlcd_onoff on);
+int hd44780_common_fontsize(struct charlcd *lcd, enum charlcd_fontsize size);
+int hd44780_common_lines(struct charlcd *lcd, enum charlcd_lines lines);
+int hd44780_common_redefine_char(struct charlcd *lcd, char *esc);
+struct hd44780_common *hd44780_common_alloc(void);
+
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 85965953683e..616e3f746a4a 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -56,6 +56,7 @@
 #include <linux/uaccess.h>
 
 #include "charlcd.h"
+#include "hd44780_common.h"
 
 #define KEYPAD_MINOR		185
 
@@ -710,7 +711,7 @@ static void lcd_send_serial(int byte)
 }
 
 /* turn the backlight on or off */
-static void lcd_backlight(struct charlcd *charlcd, int on)
+static void lcd_backlight(struct charlcd *charlcd, enum charlcd_onoff on)
 {
 	if (lcd.pins.bl == PIN_NONE)
 		return;
@@ -726,7 +727,7 @@ static void lcd_backlight(struct charlcd *charlcd, int on)
 }
 
 /* send a command to the LCD panel in serial mode */
-static void lcd_write_cmd_s(struct charlcd *charlcd, int cmd)
+static void lcd_write_cmd_s(struct hd44780_common *hdc, int cmd)
 {
 	spin_lock_irq(&pprt_lock);
 	lcd_send_serial(0x1F);	/* R/W=W, RS=0 */
@@ -737,7 +738,7 @@ static void lcd_write_cmd_s(struct charlcd *charlcd, int cmd)
 }
 
 /* send data to the LCD panel in serial mode */
-static void lcd_write_data_s(struct charlcd *charlcd, int data)
+static void lcd_write_data_s(struct hd44780_common *hdc, int data)
 {
 	spin_lock_irq(&pprt_lock);
 	lcd_send_serial(0x5F);	/* R/W=W, RS=1 */
@@ -748,7 +749,7 @@ static void lcd_write_data_s(struct charlcd *charlcd, int data)
 }
 
 /* send a command to the LCD panel in 8 bits parallel mode */
-static void lcd_write_cmd_p8(struct charlcd *charlcd, int cmd)
+static void lcd_write_cmd_p8(struct hd44780_common *hdc, int cmd)
 {
 	spin_lock_irq(&pprt_lock);
 	/* present the data to the data port */
@@ -770,7 +771,7 @@ static void lcd_write_cmd_p8(struct charlcd *charlcd, int cmd)
 }
 
 /* send data to the LCD panel in 8 bits parallel mode */
-static void lcd_write_data_p8(struct charlcd *charlcd, int data)
+static void lcd_write_data_p8(struct hd44780_common *hdc, int data)
 {
 	spin_lock_irq(&pprt_lock);
 	/* present the data to the data port */
@@ -792,7 +793,7 @@ static void lcd_write_data_p8(struct charlcd *charlcd, int data)
 }
 
 /* send a command to the TI LCD panel */
-static void lcd_write_cmd_tilcd(struct charlcd *charlcd, int cmd)
+static void lcd_write_cmd_tilcd(struct hd44780_common *hdc, int cmd)
 {
 	spin_lock_irq(&pprt_lock);
 	/* present the data to the control port */
@@ -802,7 +803,7 @@ static void lcd_write_cmd_tilcd(struct charlcd *charlcd, int cmd)
 }
 
 /* send data to the TI LCD panel */
-static void lcd_write_data_tilcd(struct charlcd *charlcd, int data)
+static void lcd_write_data_tilcd(struct hd44780_common *hdc, int data)
 {
 	spin_lock_irq(&pprt_lock);
 	/* present the data to the data port */
@@ -811,105 +812,81 @@ static void lcd_write_data_tilcd(struct charlcd *charlcd, int data)
 	spin_unlock_irq(&pprt_lock);
 }
 
-/* fills the display with spaces and resets X/Y */
-static void lcd_clear_fast_s(struct charlcd *charlcd)
-{
-	int pos;
-
-	spin_lock_irq(&pprt_lock);
-	for (pos = 0; pos < charlcd->height * charlcd->hwidth; pos++) {
-		lcd_send_serial(0x5F);	/* R/W=W, RS=1 */
-		lcd_send_serial(' ' & 0x0F);
-		lcd_send_serial((' ' >> 4) & 0x0F);
-		/* the shortest data takes at least 40 us */
-		udelay(40);
-	}
-	spin_unlock_irq(&pprt_lock);
-}
-
-/* fills the display with spaces and resets X/Y */
-static void lcd_clear_fast_p8(struct charlcd *charlcd)
-{
-	int pos;
-
-	spin_lock_irq(&pprt_lock);
-	for (pos = 0; pos < charlcd->height * charlcd->hwidth; pos++) {
-		/* present the data to the data port */
-		w_dtr(pprt, ' ');
-
-		/* maintain the data during 20 us before the strobe */
-		udelay(20);
-
-		set_bit(LCD_BIT_E, bits);
-		set_bit(LCD_BIT_RS, bits);
-		clear_bit(LCD_BIT_RW, bits);
-		set_ctrl_bits();
-
-		/* maintain the strobe during 40 us */
-		udelay(40);
-
-		clear_bit(LCD_BIT_E, bits);
-		set_ctrl_bits();
-
-		/* the shortest data takes at least 45 us */
-		udelay(45);
-	}
-	spin_unlock_irq(&pprt_lock);
-}
-
-/* fills the display with spaces and resets X/Y */
-static void lcd_clear_fast_tilcd(struct charlcd *charlcd)
-{
-	int pos;
-
-	spin_lock_irq(&pprt_lock);
-	for (pos = 0; pos < charlcd->height * charlcd->hwidth; pos++) {
-		/* present the data to the data port */
-		w_dtr(pprt, ' ');
-		udelay(60);
-	}
-
-	spin_unlock_irq(&pprt_lock);
-}
-
 static const struct charlcd_ops charlcd_serial_ops = {
-	.write_cmd	= lcd_write_cmd_s,
-	.write_data	= lcd_write_data_s,
-	.clear_fast	= lcd_clear_fast_s,
 	.backlight	= lcd_backlight,
+	.gotoxy		= hd44780_common_gotoxy,
+	.home		= hd44780_common_home,
+	.clear_display	= hd44780_common_clear_display,
+	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
+	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
+	.redefine_char	= hd44780_common_redefine_char,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
-	.write_cmd	= lcd_write_cmd_p8,
-	.write_data	= lcd_write_data_p8,
-	.clear_fast	= lcd_clear_fast_p8,
 	.backlight	= lcd_backlight,
+	.gotoxy		= hd44780_common_gotoxy,
+	.home		= hd44780_common_home,
+	.clear_display	= hd44780_common_clear_display,
+	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
+	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
+	.redefine_char	= hd44780_common_redefine_char,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
-	.write_cmd	= lcd_write_cmd_tilcd,
-	.write_data	= lcd_write_data_tilcd,
-	.clear_fast	= lcd_clear_fast_tilcd,
 	.backlight	= lcd_backlight,
+	.gotoxy		= hd44780_common_gotoxy,
+	.home		= hd44780_common_home,
+	.clear_display	= hd44780_common_clear_display,
+	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
+	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
+	.redefine_char	= hd44780_common_redefine_char,
 };
 
 /* initialize the LCD driver */
 static void lcd_init(void)
 {
 	struct charlcd *charlcd;
+	struct hd44780_common *hdc;
 
-	charlcd = charlcd_alloc(0);
-	if (!charlcd)
+	hdc = hd44780_common_alloc();
+	if (!hdc)
 		return;
 
+	charlcd = charlcd_alloc();
+	if (!charlcd) {
+		kfree(hdc);
+		return;
+	}
+
+	hdc->hd44780 = &lcd;
+	charlcd->drvdata = hdc;
+
 	/*
 	 * Init lcd struct with load-time values to preserve exact
 	 * current functionality (at least for now).
 	 */
 	charlcd->height = lcd_height;
 	charlcd->width = lcd_width;
-	charlcd->bwidth = lcd_bwidth;
-	charlcd->hwidth = lcd_hwidth;
+	hdc->bwidth = lcd_bwidth;
+	hdc->hwidth = lcd_hwidth;
 
 	switch (selected_lcd_type) {
 	case LCD_TYPE_OLD:
@@ -920,8 +897,8 @@ static void lcd_init(void)
 		lcd.pins.rs = PIN_AUTOLF;
 
 		charlcd->width = 40;
-		charlcd->bwidth = 40;
-		charlcd->hwidth = 64;
+		hdc->bwidth = 40;
+		hdc->hwidth = 64;
 		charlcd->height = 2;
 		break;
 	case LCD_TYPE_KS0074:
@@ -933,8 +910,8 @@ static void lcd_init(void)
 		lcd.pins.da = PIN_D0;
 
 		charlcd->width = 16;
-		charlcd->bwidth = 40;
-		charlcd->hwidth = 16;
+		hdc->bwidth = 40;
+		hdc->hwidth = 16;
 		charlcd->height = 2;
 		break;
 	case LCD_TYPE_NEXCOM:
@@ -946,8 +923,8 @@ static void lcd_init(void)
 		lcd.pins.rw = PIN_INITP;
 
 		charlcd->width = 16;
-		charlcd->bwidth = 40;
-		charlcd->hwidth = 64;
+		hdc->bwidth = 40;
+		hdc->hwidth = 64;
 		charlcd->height = 2;
 		break;
 	case LCD_TYPE_CUSTOM:
@@ -965,8 +942,8 @@ static void lcd_init(void)
 		lcd.pins.rs = PIN_SELECP;
 
 		charlcd->width = 16;
-		charlcd->bwidth = 40;
-		charlcd->hwidth = 64;
+		hdc->bwidth = 40;
+		hdc->hwidth = 64;
 		charlcd->height = 2;
 		break;
 	}
@@ -977,9 +954,9 @@ static void lcd_init(void)
 	if (lcd_width != NOT_SET)
 		charlcd->width = lcd_width;
 	if (lcd_bwidth != NOT_SET)
-		charlcd->bwidth = lcd_bwidth;
+		hdc->bwidth = lcd_bwidth;
 	if (lcd_hwidth != NOT_SET)
-		charlcd->hwidth = lcd_hwidth;
+		hdc->hwidth = lcd_hwidth;
 	if (lcd_charset != NOT_SET)
 		lcd.charset = lcd_charset;
 	if (lcd_proto != NOT_SET)
@@ -1000,15 +977,17 @@ static void lcd_init(void)
 	/* this is used to catch wrong and default values */
 	if (charlcd->width <= 0)
 		charlcd->width = DEFAULT_LCD_WIDTH;
-	if (charlcd->bwidth <= 0)
-		charlcd->bwidth = DEFAULT_LCD_BWIDTH;
-	if (charlcd->hwidth <= 0)
-		charlcd->hwidth = DEFAULT_LCD_HWIDTH;
+	if (hdc->bwidth <= 0)
+		hdc->bwidth = DEFAULT_LCD_BWIDTH;
+	if (hdc->hwidth <= 0)
+		hdc->hwidth = DEFAULT_LCD_HWIDTH;
 	if (charlcd->height <= 0)
 		charlcd->height = DEFAULT_LCD_HEIGHT;
 
 	if (lcd.proto == LCD_PROTO_SERIAL) {	/* SERIAL */
 		charlcd->ops = &charlcd_serial_ops;
+		hdc->write_data = lcd_write_cmd_s;
+		hdc->write_cmd = lcd_write_data_s;
 
 		if (lcd.pins.cl == PIN_NOT_SET)
 			lcd.pins.cl = DEFAULT_LCD_PIN_SCL;
@@ -1017,6 +996,8 @@ static void lcd_init(void)
 
 	} else if (lcd.proto == LCD_PROTO_PARALLEL) {	/* PARALLEL */
 		charlcd->ops = &charlcd_parallel_ops;
+		hdc->write_data = lcd_write_cmd_p8;
+		hdc->write_cmd = lcd_write_data_p8;
 
 		if (lcd.pins.e == PIN_NOT_SET)
 			lcd.pins.e = DEFAULT_LCD_PIN_E;
@@ -1026,6 +1007,8 @@ static void lcd_init(void)
 			lcd.pins.rw = DEFAULT_LCD_PIN_RW;
 	} else {
 		charlcd->ops = &charlcd_tilcd_ops;
+		hdc->write_data = lcd_write_cmd_tilcd;
+		hdc->write_cmd = lcd_write_data_tilcd;
 	}
 
 	if (lcd.pins.bl == PIN_NOT_SET)
@@ -1622,7 +1605,7 @@ static void panel_attach(struct parport *port)
 	if (lcd.enabled)
 		charlcd_unregister(lcd.charlcd);
 err_unreg_device:
-	charlcd_free(lcd.charlcd);
+	kfree(lcd.charlcd);
 	lcd.charlcd = NULL;
 	parport_unregister_device(pprt);
 	pprt = NULL;
@@ -1649,7 +1632,8 @@ static void panel_detach(struct parport *port)
 	if (lcd.enabled) {
 		charlcd_unregister(lcd.charlcd);
 		lcd.initialized = false;
-		charlcd_free(lcd.charlcd);
+		kfree(lcd.charlcd->drvdata);
+		kfree(lcd.charlcd);
 		lcd.charlcd = NULL;
 	}
 
-- 
2.23.0

