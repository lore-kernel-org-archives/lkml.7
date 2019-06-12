Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4888C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639712080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jq96wh7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407437AbfFLHm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:42:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46189 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406732AbfFLHm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:42:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so8586048lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qCaeMjgx/Ue3wRq5PlJmBJB/IncjiulKu6SZOzw/jQ=;
        b=jq96wh7vNtFmS3IbSSJHfLHn8aMp6W9D6XxkjC4zqpkbM2/Km6CuLgTkQ4AoCFW9IA
         YvpfTXEnML6WJnW5YrWko9SElJ+d8NYjdYymmHd5V1NrwZdY1giA4fd54B6koNRVs6JX
         faC/lVq4K9LAcSrBa7bQCqcZn5+aspUZLXYugHcmi955+LiylGeMNFskxx2HIk7mnPBx
         mgJoJRwzfQbAHvlXiX1y3CBqGGAzNLGYEX8B+6Jebbio7sUn2Hp6Xfh4Wo/wv3cyCRe2
         6uglaEGE4bexBBZRICNbzSIIV64/FyhvRz/GW76I3K2nKUcVx1TNCg4HhSAtrtgcLnJj
         PuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qCaeMjgx/Ue3wRq5PlJmBJB/IncjiulKu6SZOzw/jQ=;
        b=a5s6W2GgHVrOn/8udTbPyeSjyvvq7D6LLqtEggy98UVORmUBVp0xm1O2EPg+CN+X5G
         6B4B1apKcFh/6Bzuwj5Za1mfQWMAA0URJ3k2wPOqfYoYB3hlSuhFUPp9H5xlJr7vzX32
         B6wvWJgsRj1QaXy6L5w0GR8kwTbqLNAlYBX5EVL33TbqeqSBD4ZQsiBG8VKiXCQyMVWs
         Kle+/2rQTCGMsEJ+eHKCvT0V5gRzd7pGHIXwyVnt+ke9EgcLcSWmN6Cuy58JIacrGSf5
         birmT1JNQkiiqNlvDgM2PiS4p+o+0W0zygoocbf59dSNCh1PeEQ9q/1X6gOUQX9GKT4e
         Lnag==
X-Gm-Message-State: APjAAAX2bya+Pd1D1B+diKsOyTTwG3jNuhl+fNqX/qOTL2YgXV5mfIKy
        q/cPKXf75mhuy5JT9Pbk4W7RJg==
X-Google-Smtp-Source: APXvYqzSI5Q+MjwikWA3YWmvoANzJy7BQr5R8oWLh+ENqclB2WtGo8BuouONyUmhUr2rsMYiuGLiIQ==
X-Received: by 2002:ac2:514f:: with SMTP id q15mr3840040lfd.145.1560325345637;
        Wed, 12 Jun 2019 00:42:25 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id m10sm2932955lfd.32.2019.06.12.00.42.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 00:42:24 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com
Subject: [PATCH v2] regulator: wm831x: Convert to use GPIO descriptors
Date:   Wed, 12 Jun 2019 09:42:22 +0200
Message-Id: <20190612074222.10584-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the Wolfson Micro WM831x DCDC converter to use
a GPIO descriptor for the GPIO driving the DVS pin.

There is just one (non-DT) machine in the kernel using this, and
that is the Wolfson Micro (now Cirrus) Cragganmore 6410 so we
patch this board to pass a descriptor table and fix up the driver
accordingly.

Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use device name "wm831x-buckv.11" as described by Charles
- Use devm_gpiod_get() rather than the optional variant
---
 arch/arm/mach-s3c64xx/mach-crag6410.c | 21 ++++++++++++++++++-
 drivers/regulator/wm831x-dcdc.c       | 29 ++++++++++++---------------
 include/linux/mfd/wm831x/pdata.h      |  1 -
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 379424d72ae7..8ec6a4f5eb05 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/leds.h>
 #include <linux/delay.h>
 #include <linux/mmc/host.h>
@@ -398,7 +399,6 @@ static struct pca953x_platform_data crag6410_pca_data = {
 /* VDDARM is controlled by DVS1 connected to GPK(0) */
 static struct wm831x_buckv_pdata vddarm_pdata = {
 	.dvs_control_src = 1,
-	.dvs_gpio = S3C64XX_GPK(0),
 };
 
 static struct regulator_consumer_supply vddarm_consumers[] = {
@@ -596,6 +596,24 @@ static struct wm831x_pdata crag_pmic_pdata = {
 	.touch = &touch_pdata,
 };
 
+/*
+ * VDDARM is eventually ending up as a regulator hanging on the MFD cell device
+ * "wm831x-buckv.1" spawn from drivers/mfd/wm831x-core.c.
+ *
+ * From the note on the platform data we can see that this is clearly DVS1
+ * and assigned as dcdc1 resource to the MFD core which sets .id of the cell
+ * spawning the DVS1 platform device to 1, then the cell platform device
+ * name is calculated from 10*instance + id resulting in the device name
+ * "wm831x-buckv.11"
+ */
+static struct gpiod_lookup_table crag_pmic_gpiod_table = {
+	.dev_id = "wm831x-buckv.11",
+	.table = {
+		GPIO_LOOKUP("GPIOK", 0, "dvs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct i2c_board_info i2c_devs0[] = {
 	{ I2C_BOARD_INFO("24c08", 0x50), },
 	{ I2C_BOARD_INFO("tca6408", 0x20),
@@ -836,6 +854,7 @@ static void __init crag6410_machine_init(void)
 	s3c_fb_set_platdata(&crag6410_lcd_pdata);
 	dwc2_hsotg_set_platdata(&crag6410_hsotg_pdata);
 
+	gpiod_add_lookup_table(&crag_pmic_gpiod_table);
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index b422eef97b77..018dbbd96771 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 
 #include <linux/mfd/wm831x/core.h>
@@ -50,7 +50,7 @@ struct wm831x_dcdc {
 	int base;
 	struct wm831x *wm831x;
 	struct regulator_dev *regulator;
-	int dvs_gpio;
+	struct gpio_desc *dvs_gpiod;
 	int dvs_gpio_state;
 	int on_vsel;
 	int dvs_vsel;
@@ -217,7 +217,7 @@ static int wm831x_buckv_set_dvs(struct regulator_dev *rdev, int state)
 		return 0;
 
 	dcdc->dvs_gpio_state = state;
-	gpio_set_value(dcdc->dvs_gpio, state);
+	gpiod_set_value(dcdc->dvs_gpiod, state);
 
 	/* Should wait for DVS state change to be asserted if we have
 	 * a GPIO for it, for now assume the device is configured
@@ -237,10 +237,10 @@ static int wm831x_buckv_set_voltage_sel(struct regulator_dev *rdev,
 	int ret;
 
 	/* If this value is already set then do a GPIO update if we can */
-	if (dcdc->dvs_gpio && dcdc->on_vsel == vsel)
+	if (dcdc->dvs_gpiod && dcdc->on_vsel == vsel)
 		return wm831x_buckv_set_dvs(rdev, 0);
 
-	if (dcdc->dvs_gpio && dcdc->dvs_vsel == vsel)
+	if (dcdc->dvs_gpiod && dcdc->dvs_vsel == vsel)
 		return wm831x_buckv_set_dvs(rdev, 1);
 
 	/* Always set the ON status to the minimum voltage */
@@ -249,7 +249,7 @@ static int wm831x_buckv_set_voltage_sel(struct regulator_dev *rdev,
 		return ret;
 	dcdc->on_vsel = vsel;
 
-	if (!dcdc->dvs_gpio)
+	if (!dcdc->dvs_gpiod)
 		return ret;
 
 	/* Kick the voltage transition now */
@@ -296,7 +296,7 @@ static int wm831x_buckv_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct wm831x_dcdc *dcdc = rdev_get_drvdata(rdev);
 
-	if (dcdc->dvs_gpio && dcdc->dvs_gpio_state)
+	if (dcdc->dvs_gpiod && dcdc->dvs_gpio_state)
 		return dcdc->dvs_vsel;
 	else
 		return dcdc->on_vsel;
@@ -337,7 +337,7 @@ static void wm831x_buckv_dvs_init(struct platform_device *pdev,
 	int ret;
 	u16 ctrl;
 
-	if (!pdata || !pdata->dvs_gpio)
+	if (!pdata)
 		return;
 
 	/* gpiolib won't let us read the GPIO status so pick the higher
@@ -345,17 +345,14 @@ static void wm831x_buckv_dvs_init(struct platform_device *pdev,
 	 */
 	dcdc->dvs_gpio_state = pdata->dvs_init_state;
 
-	ret = devm_gpio_request_one(&pdev->dev, pdata->dvs_gpio,
-				    dcdc->dvs_gpio_state ? GPIOF_INIT_HIGH : 0,
-				    "DCDC DVS");
-	if (ret < 0) {
-		dev_err(wm831x->dev, "Failed to get %s DVS GPIO: %d\n",
-			dcdc->name, ret);
+	dcdc->dvs_gpiod = devm_gpiod_get(&pdev->dev, "dvs",
+			dcdc->dvs_gpio_state ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
+	if (IS_ERR(dcdc->dvs_gpiod)) {
+		dev_err(wm831x->dev, "Failed to get %s DVS GPIO: %ld\n",
+			dcdc->name, PTR_ERR(dcdc->dvs_gpiod));
 		return;
 	}
 
-	dcdc->dvs_gpio = pdata->dvs_gpio;
-
 	switch (pdata->dvs_control_src) {
 	case 1:
 		ctrl = 2 << WM831X_DC1_DVS_SRC_SHIFT;
diff --git a/include/linux/mfd/wm831x/pdata.h b/include/linux/mfd/wm831x/pdata.h
index dcc9631b3052..1b8bb36e13b8 100644
--- a/include/linux/mfd/wm831x/pdata.h
+++ b/include/linux/mfd/wm831x/pdata.h
@@ -52,7 +52,6 @@ struct wm831x_battery_pdata {
  * I2C or SPI buses.
  */
 struct wm831x_buckv_pdata {
-	int dvs_gpio;        /** CPU GPIO to use for DVS switching */
 	int dvs_control_src; /** Hardware DVS source to use (1 or 2) */
 	int dvs_init_state;  /** DVS state to expect on startup */
 	int dvs_state_gpio;  /** CPU GPIO to use for monitoring status */
-- 
2.20.1

