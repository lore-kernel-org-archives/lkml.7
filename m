Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4AACA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085F821852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391191AbfJRPm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:42:59 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33889 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505254AbfJRPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:54 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MyK5K-1i6xDo48SK-00ykGf; Fri, 18 Oct 2019 17:42:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 38/46] video: backlight: tosa: use gpio lookup table
Date:   Fri, 18 Oct 2019 17:41:53 +0200
Message-Id: <20191018154201.1276638-38-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2OhedckVn2duIvbZrX9602vjNldufJeHeDgaeXumpkFb9kLtGA6
 msV2qeFO73azgU68EuIPXTeNQ0kl8m+uEhwRmgp26oRSi2IlDmYS7TeGkJG8T2QJRa+ZOY1
 FCEv/86qhKRQNWYRbVDm55L5Gc09o3aV+pltG9n/0uJi1/KTPl68o/c/HbKZOiAUE8C/URr
 V58sD5sZMsaC/95RoUJqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Lw85U0rw3k=:QKhqL3L6NOnlz2xUIUUIXH
 /WyjOTbWKRMCPIn7uogbvL5bl2Asw+QgOlDmFWghCCzGh3f2/rIV2+PTvOdH49apoaWFVYrGm
 tVcRNcA6mwaSnyq1KrjvxaTIdyowqvN546cwkriRbr+0CScKif64mOuQoqAveW9UFeRstz0hT
 oNHGr+8MoDJ99euK/WRIrFAMelPdXCDePYQbqk8iC+SwP2JwNpnFD1yr16ZVsJrW+DUlpc6zo
 WJwGRhSZJGQ/WHE/PyE24Kq1pNOhRJWca8mI5g2yTlnNa6C59RroXaOe0XfGwnOWvtp+PHv/P
 e9nGz+q8kUU3HPgpuEyrT35Z9wUFJ320U5hhprzySLPD+t+Rr1Fw5RSKu+TtogLy1nTfTkjpM
 oS16Y3ezXogCTmi8sKED4EVCouWBf4eqPMnxNTc989gU3T0Pg4MQqKv+TTZ2r3Da3G2HzgjkI
 iQEOehoFx3ql6NnZqvnAfYGDz4agMIzv9qOvyITI3kpENSUFVP0c11KTXnAzNzRYZZFFD+Bxm
 vWBPaF3OivSKk7HTGp3PtD2pcKjdYsX6/rmGn4N11w5RtDRe4T6EaRlCcoKza/UfW5a4OZQL5
 TAXS/elwcE/+dMYaahbAEC2F4l649bcKAnQ9sOqte/GwJ6cr+y12CKOmu83TPLtOZmUIsClIz
 FnBzk65YyY4Sr0IDarAp8RXW7E80AIXVN/kBazywLNRFWRNibYjXbqLZC3xMNbyqw5Ay1P4+X
 madc6XqvkkGv9P6nQrnREC17u0qEgZCzjwhwIb6RxkGl4GfJqCDfOQlIAq+1sARH6FXwKJRww
 RCCIHxwUyEWQi41E5Prvl66m8gZiHWOTpVGzUdluz81iNnOOY5t2dYVa6GV6h7aCFHL8dVaLG
 Hislp5hnyQMcoZ7Bu2hA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver should not require a machine specific header. Change
it to pass the gpio line through a lookup table, and move the
timing generator definitions into the drivers itself.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
I'm not overly confident that I got the correct device names
for the lookup table, it would be good if someone could
double-check.
---
 arch/arm/mach-pxa/include/mach/tosa.h | 15 --------------
 arch/arm/mach-pxa/tosa.c              | 22 +++++++++++++++++++++
 drivers/video/backlight/tosa_bl.c     | 10 +++++-----
 drivers/video/backlight/tosa_bl.h     |  8 ++++++++
 drivers/video/backlight/tosa_lcd.c    | 28 ++++++++++++++++++++-------
 5 files changed, 56 insertions(+), 27 deletions(-)
 create mode 100644 drivers/video/backlight/tosa_bl.h

diff --git a/arch/arm/mach-pxa/include/mach/tosa.h b/arch/arm/mach-pxa/include/mach/tosa.h
index a499ed17931e..8bfaca3a8b64 100644
--- a/arch/arm/mach-pxa/include/mach/tosa.h
+++ b/arch/arm/mach-pxa/include/mach/tosa.h
@@ -72,18 +72,6 @@
 #define TOSA_GPIO_BAT0_TH_ON		(TOSA_TC6393XB_GPIO_BASE + 14)
 #define TOSA_GPIO_BAT1_TH_ON		(TOSA_TC6393XB_GPIO_BASE + 15)
 
-/*
- * Timing Generator
- */
-#define TG_PNLCTL 			0x00
-#define TG_TPOSCTL 			0x01
-#define TG_DUTYCTL 			0x02
-#define TG_GPOSR 			0x03
-#define TG_GPODR1 			0x04
-#define TG_GPODR2 			0x05
-#define TG_PINICTL 			0x06
-#define TG_HPOSCTL 			0x07
-
 /*
  * PXA GPIOs
  */
@@ -192,7 +180,4 @@
 #define TOSA_KEY_MAIL		KEY_MAIL
 #endif
 
-struct spi_device;
-extern int tosa_bl_enable(struct spi_device *spi, int enable);
-
 #endif /* _ASM_ARCH_TOSA_H_ */
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 9a7f1e42adac..8329a2969b2b 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -813,6 +813,26 @@ static struct pxa2xx_spi_controller pxa_ssp_master_info = {
 	.num_chipselect	= 1,
 };
 
+static struct gpiod_lookup_table tosa_lcd_gpio_table = {
+	.dev_id = "spi2.0",
+	.table = {
+		GPIO_LOOKUP("tc6393xb",
+			    TOSA_GPIO_TG_ON - TOSA_TC6393XB_GPIO_BASE,
+			    "tg #pwr", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+static struct gpiod_lookup_table tosa_lcd_bl_gpio_table = {
+	.dev_id = "i2c-tosa-bl",
+	.table = {
+		GPIO_LOOKUP("tc6393xb",
+			    TOSA_GPIO_BL_C20MA - TOSA_TC6393XB_GPIO_BASE,
+			    "backlight", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct spi_board_info spi_board_info[] __initdata = {
 	{
 		.modalias	= "tosa-lcd",
@@ -935,6 +955,8 @@ static void __init tosa_init(void)
 	platform_scoop_config = &tosa_pcmcia_config;
 
 	pxa2xx_set_spi_info(2, &pxa_ssp_master_info);
+	gpiod_add_lookup_table(&tosa_lcd_gpio_table);
+	gpiod_add_lookup_table(&tosa_lcd_bl_gpio_table);
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 
 	clk_add_alias("CLK_CK3P6MI", tc6393xb_device.name, "GPIO11_CLK", NULL);
diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
index 1275e815bd86..cff5e96fd988 100644
--- a/drivers/video/backlight/tosa_bl.c
+++ b/drivers/video/backlight/tosa_bl.c
@@ -18,7 +18,7 @@
 
 #include <asm/mach/sharpsl_param.h>
 
-#include <mach/tosa.h>
+#include "tosa_bl.h"
 
 #define COMADJ_DEFAULT	97
 
@@ -28,6 +28,7 @@
 struct tosa_bl_data {
 	struct i2c_client *i2c;
 	struct backlight_device *bl;
+	struct gpio_desc *gpio;
 
 	int comadj;
 };
@@ -42,7 +43,7 @@ static void tosa_bl_set_backlight(struct tosa_bl_data *data, int brightness)
 	i2c_smbus_write_byte_data(data->i2c, DAC_CH2, (u8)(brightness & 0xff));
 
 	/* SetBacklightVR */
-	gpio_set_value(TOSA_GPIO_BL_C20MA, brightness & 0x100);
+	gpiod_set_value(data->gpio, brightness & 0x100);
 
 	tosa_bl_enable(spi, brightness);
 }
@@ -87,9 +88,8 @@ static int tosa_bl_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data->comadj = sharpsl_param.comadj == -1 ? COMADJ_DEFAULT : sharpsl_param.comadj;
-
-	ret = devm_gpio_request_one(&client->dev, TOSA_GPIO_BL_C20MA,
-				GPIOF_OUT_INIT_LOW, "backlight");
+	data->gpio = devm_gpiod_get(&client->dev, "backlight", GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(data->gpio);
 	if (ret) {
 		dev_dbg(&data->bl->dev, "Unable to request gpio!\n");
 		return ret;
diff --git a/drivers/video/backlight/tosa_bl.h b/drivers/video/backlight/tosa_bl.h
new file mode 100644
index 000000000000..589e17e6fdb2
--- /dev/null
+++ b/drivers/video/backlight/tosa_bl.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _TOSA_BL_H
+#define _TOSA_BL_H
+
+struct spi_device;
+extern int tosa_bl_enable(struct spi_device *spi, int enable);
+
+#endif
diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index 29af8e27b6e5..e8ab583e5098 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -19,7 +19,7 @@
 
 #include <asm/mach/sharpsl_param.h>
 
-#include <mach/tosa.h>
+#include "tosa_bl.h"
 
 #define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)
 
@@ -28,12 +28,26 @@
 #define TG_REG0_UD	0x0004
 #define TG_REG0_LR	0x0008
 
+/*
+ * Timing Generator
+ */
+#define TG_PNLCTL 	0x00
+#define TG_TPOSCTL 	0x01
+#define TG_DUTYCTL 	0x02
+#define TG_GPOSR 	0x03
+#define TG_GPODR1 	0x04
+#define TG_GPODR2 	0x05
+#define TG_PINICTL 	0x06
+#define TG_HPOSCTL 	0x07
+
+
 #define	DAC_BASE	0x4e
 
 struct tosa_lcd_data {
 	struct spi_device *spi;
 	struct lcd_device *lcd;
 	struct i2c_client *i2c;
+	struct gpio_desc *gpiod_tg;
 
 	int lcd_power;
 	bool is_vga;
@@ -66,7 +80,7 @@ EXPORT_SYMBOL(tosa_bl_enable);
 static void tosa_lcd_tg_init(struct tosa_lcd_data *data)
 {
 	/* TG on */
-	gpio_set_value(TOSA_GPIO_TG_ON, 0);
+	gpiod_set_value(data->gpiod_tg, 0);
 
 	mdelay(60);
 
@@ -100,6 +114,7 @@ static void tosa_lcd_tg_on(struct tosa_lcd_data *data)
 		 */
 		struct i2c_adapter *adap = i2c_get_adapter(0);
 		struct i2c_board_info info = {
+			.dev_name = "tosa-bl",
 			.type	= "tosa-bl",
 			.addr	= DAC_BASE,
 			.platform_data = data->spi,
@@ -121,7 +136,7 @@ static void tosa_lcd_tg_off(struct tosa_lcd_data *data)
 	mdelay(50);
 
 	/* TG Off */
-	gpio_set_value(TOSA_GPIO_TG_ON, 1);
+	gpiod_set_value(data->gpiod_tg, 1);
 	mdelay(100);
 }
 
@@ -191,10 +206,9 @@ static int tosa_lcd_probe(struct spi_device *spi)
 	data->spi = spi;
 	spi_set_drvdata(spi, data);
 
-	ret = devm_gpio_request_one(&spi->dev, TOSA_GPIO_TG_ON,
-				GPIOF_OUT_INIT_LOW, "tg #pwr");
-	if (ret < 0)
-		return ret;
+	data->gpiod_tg = devm_gpiod_get(&spi->dev, "tg #pwr", GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpiod_tg))
+		return PTR_ERR(data->gpiod_tg);
 
 	mdelay(60);
 
-- 
2.20.0

