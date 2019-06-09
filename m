Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7B9C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 21:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9F62063F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 21:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJmjtLBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfFIVA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 17:00:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37897 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfFIVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 17:00:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so7125027wrs.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nx9VeEKVquFQb7ZeRyZ4hBa+Y8BqiskUNnYJAspASkA=;
        b=MJmjtLBQ2EPc+2PY7inf4/CygWqA5fHhNFIrtodMnSR8bOreKAof/DKdiDZN7bgMte
         EoQNH1aCG3I/WisZRqFnvyhIkhnxtVZYmrWjlSXKD3mCf9jIZu/DSw9fXh9lzSnP2+PJ
         JOPYq4PH+XepszpiXbh10L9hAEKbVuoiQoKsL6z8A9Tlw/M3jcMmJ7Vo38OSQ/m1NK6F
         GnjwaD927Cx8DmUI8D2hyEr3xNQX2kBrGKMEFlG93zVt8t6Y50uOzZEwjhPkemASNLNG
         O8B7bkYMSwEXNt00sg2eoY+keP6Z4WGtJYE+plMf8hJerAdT2DGB/qTvJVTcNgJtsUe/
         RTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nx9VeEKVquFQb7ZeRyZ4hBa+Y8BqiskUNnYJAspASkA=;
        b=LTIdeLybredY7UVBkY3s7qdTHVcwi7qIYCcwSleHwsDzGE5YrF8jitKmry6PSDCdGl
         Q7CQ0xxEeOSerjVlcUdb48BbtLiyI1zk8500IF1ocz2teKD5KsJ+h3w6R9wGZLlSVuDD
         piJlk0csKqPiLDLKxzEdgPbqthz5HbKvqYojgq/3W2Ua3kVObCMZwtwXeAS4KvVDfp73
         R4OMil38/9k4zj1tGj13srtoZZBqkoUCJLoZjU6SmHwQCasizwX4X67KOqCgoy51JU5G
         BKe23gLMq6+zW4vvU/UF1O7Iq6ukRYXKcdWbgh3Gx+NNEjHkng2BF3z3092FHxkWPqJM
         UbYg==
X-Gm-Message-State: APjAAAXovk4mOVS6PnkUs9z5ranCD+DvQStGoDQvY8WZdSyiqfGE0euS
        RswBgGFxMjzzM4jp9xOqNTzZJA==
X-Google-Smtp-Source: APXvYqy1M0h7R6aOa8txulTNa5XI9/mDfsXyKXWcmora4WjoYLjXrOAbAu4/eTfqwr23zVgvArYIZA==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr2768658wrx.182.1560114025734;
        Sun, 09 Jun 2019 14:00:25 -0700 (PDT)
Received: from localhost.localdomain (catv-89-135-96-219.catv.broadband.hu. [89.135.96.219])
        by smtp.gmail.com with ESMTPSA id d10sm8750690wrp.74.2019.06.09.14.00.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 14:00:24 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com
Subject: [PATCH] regulator: wm831x: Convert to use GPIO descriptors
Date:   Sun,  9 Jun 2019 23:00:25 +0200
Message-Id: <20190609210025.29224-1-linus.walleij@linaro.org>
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
 arch/arm/mach-s3c64xx/mach-crag6410.c | 20 +++++++++++++++++-
 drivers/regulator/wm831x-dcdc.c       | 29 ++++++++++++---------------
 include/linux/mfd/wm831x/pdata.h      |  1 -
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 379424d72ae7..b90ded91916c 100644
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
@@ -596,6 +596,23 @@ static struct wm831x_pdata crag_pmic_pdata = {
 	.touch = &touch_pdata,
 };
 
+/*
+ * VDDARM is eventually ending up as a regulator hanging on the MFD cell device
+ * "wm831x-buckv.1" spawn from drivers/mfd/wm831x-core.c.
+ *
+ * From the note on the platform data we can see that this is clearly DVS1
+ * and assigned as dcdc1 resource to the MFD core which sets .id of the cell
+ * spawning the DVS1 platform device to 1, resulting in the device name
+ * "wm831x-buckv.1".
+ */
+static struct gpiod_lookup_table crag_pmic_gpiod_table = {
+	.dev_id = "wm831x-buckv.1",
+	.table = {
+		GPIO_LOOKUP("GPIOK", 0, "dvs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct i2c_board_info i2c_devs0[] = {
 	{ I2C_BOARD_INFO("24c08", 0x50), },
 	{ I2C_BOARD_INFO("tca6408", 0x20),
@@ -836,6 +853,7 @@ static void __init crag6410_machine_init(void)
 	s3c_fb_set_platdata(&crag6410_lcd_pdata);
 	dwc2_hsotg_set_platdata(&crag6410_hsotg_pdata);
 
+	gpiod_add_lookup_table(&crag_pmic_gpiod_table);
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index b422eef97b77..319a743e242a 100644
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
+	dcdc->dvs_gpiod = devm_gpiod_get_optional(&pdev->dev, "dvs",
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

