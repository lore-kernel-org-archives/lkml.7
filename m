Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D816BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9B3208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfDAQIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:08:41 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:52891 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfDAQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:08:38 -0400
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4131F100003;
        Mon,  1 Apr 2019 16:08:34 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 06/12] rtc: pcf85063: switch to regmap
Date:   Mon,  1 Apr 2019 18:08:10 +0200
Message-Id: <20190401160816.17859-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
References: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to regmap to simplify register accesses and remove the need for
pcf85063_stop_clock/pcf85063_start_clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig        |   1 +
 drivers/rtc/rtc-pcf85063.c | 154 +++++++++++++++----------------------
 2 files changed, 62 insertions(+), 93 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index d00f1aefaaad..7b8e156dbf38 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -439,6 +439,7 @@ config RTC_DRV_PCF8523
 
 config RTC_DRV_PCF85063
 	tristate "NXP PCF85063"
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the PCF85063 RTC chip
 
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 5e993162c5b2..632e1c8a3957 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -10,6 +10,8 @@
 #include <linux/bcd.h>
 #include <linux/rtc.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
 
 /*
  * Information for this driver was pulled from the following datasheets.
@@ -28,50 +30,14 @@
 #define PCF85063_REG_SC			0x04 /* datetime */
 #define PCF85063_REG_SC_OS		0x80
 
-static int pcf85063_stop_clock(struct i2c_client *client, u8 *ctrl1)
-{
-	int rc;
-	u8 reg;
-
-	rc = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
-	if (rc < 0) {
-		dev_err(&client->dev, "Failing to stop the clock\n");
-		return -EIO;
-	}
-
-	/* stop the clock */
-	reg = rc | PCF85063_REG_CTRL1_STOP;
-
-	rc = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, reg);
-	if (rc < 0) {
-		dev_err(&client->dev, "Failing to stop the clock\n");
-		return -EIO;
-	}
-
-	*ctrl1 = reg;
-
-	return 0;
-}
-
-static int pcf85063_start_clock(struct i2c_client *client, u8 ctrl1)
-{
-	int rc;
-
-	/* start the clock */
-	ctrl1 &= ~PCF85063_REG_CTRL1_STOP;
-
-	rc = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, ctrl1);
-	if (rc < 0) {
-		dev_err(&client->dev, "Failing to start the clock\n");
-		return -EIO;
-	}
-
-	return 0;
-}
+struct pcf85063 {
+	struct rtc_device	*rtc;
+	struct regmap		*regmap;
+};
 
 static int pcf85063_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
 	int rc;
 	u8 regs[7];
 
@@ -81,16 +47,14 @@ static int pcf85063_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	 * event, the access must be finished within one second. So, read all
 	 * time/date registers in one turn.
 	 */
-	rc = i2c_smbus_read_i2c_block_data(client, PCF85063_REG_SC,
-					   sizeof(regs), regs);
-	if (rc != sizeof(regs)) {
-		dev_err(&client->dev, "date/time register read error\n");
-		return -EIO;
-	}
+	rc = regmap_bulk_read(pcf85063->regmap, PCF85063_REG_SC, regs,
+			      sizeof(regs));
+	if (rc)
+		return rc;
 
 	/* if the clock has lost its power it makes no sense to use its time */
 	if (regs[0] & PCF85063_REG_SC_OS) {
-		dev_warn(&client->dev, "Power loss detected, invalid time\n");
+		dev_warn(&pcf85063->rtc->dev, "Power loss detected, invalid time\n");
 		return -EINVAL;
 	}
 
@@ -108,17 +72,18 @@ static int pcf85063_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int pcf85063_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
 	int rc;
 	u8 regs[7];
-	u8 ctrl1;
 
 	/*
 	 * to accurately set the time, reset the divider chain and keep it in
 	 * reset state until all time/date registers are written
 	 */
-	rc = pcf85063_stop_clock(client, &ctrl1);
-	if (rc != 0)
+	rc = regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL1,
+				PCF85063_REG_CTRL1_STOP,
+				PCF85063_REG_CTRL1_STOP);
+	if (rc)
 		return rc;
 
 	/* hours, minutes and seconds */
@@ -140,23 +105,18 @@ static int pcf85063_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	regs[6] = bin2bcd(tm->tm_year - 100);
 
 	/* write all registers at once */
-	rc = i2c_smbus_write_i2c_block_data(client, PCF85063_REG_SC,
-					    sizeof(regs), regs);
-	if (rc < 0) {
-		dev_err(&client->dev, "date/time register write error\n");
+	rc = regmap_bulk_write(pcf85063->regmap, PCF85063_REG_SC,
+			       regs, sizeof(regs));
+	if (rc)
 		return rc;
-	}
 
 	/*
 	 * Write the control register as a separate action since the size of
 	 * the register space is different between the PCF85063TP and
 	 * PCF85063A devices.  The rollover point can not be used.
 	 */
-	rc = pcf85063_start_clock(client, ctrl1);
-	if (rc != 0)
-		return rc;
-
-	return 0;
+	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL1,
+				  PCF85063_REG_CTRL1_STOP, 0);
 }
 
 static const struct rtc_class_ops pcf85063_rtc_ops = {
@@ -164,66 +124,74 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
 	.set_time	= pcf85063_rtc_set_time
 };
 
-static int pcf85063_load_capacitance(struct i2c_client *client)
+static int pcf85063_load_capacitance(struct pcf85063 *pcf85063,
+				     const struct device_node *np)
 {
-	u32 load;
-	int rc;
-	u8 reg;
-
-	rc = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
-	if (rc < 0)
-		return rc;
-
-	reg = rc;
-	load = 7000;
-	of_property_read_u32(client->dev.of_node, "quartz-load-femtofarads",
-			     &load);
+	u32 load = 7000;
+	u8 reg = 0;
 
+	of_property_read_u32(np, "quartz-load-femtofarads", &load);
 	switch (load) {
 	default:
-		dev_warn(&client->dev, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
+		dev_warn(&pcf85063->rtc->dev, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
 			 load);
 		/* fall through */
 	case 7000:
-		reg &= ~PCF85063_REG_CTRL1_CAP_SEL;
 		break;
 	case 12500:
-		reg |= PCF85063_REG_CTRL1_CAP_SEL;
+		reg = PCF85063_REG_CTRL1_CAP_SEL;
 		break;
 	}
 
-	rc = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, reg);
-
-	return rc;
+	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL1,
+				  PCF85063_REG_CTRL1_CAP_SEL, reg);
 }
 
+static const struct regmap_config regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x11,
+};
+
 static int pcf85063_probe(struct i2c_client *client)
 {
-	struct rtc_device *rtc;
+	struct pcf85063 *pcf85063;
+	unsigned int tmp;
 	int err;
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
-	err = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
-	if (err < 0) {
+	pcf85063 = devm_kzalloc(&client->dev, sizeof(struct pcf85063),
+				GFP_KERNEL);
+	if (!pcf85063)
+		return -ENOMEM;
+
+	pcf85063->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(pcf85063->regmap))
+		return PTR_ERR(pcf85063->regmap);
+
+	i2c_set_clientdata(client, pcf85063);
+
+	err = regmap_read(pcf85063->regmap, PCF85063_REG_CTRL1, &tmp);
+	if (err) {
 		dev_err(&client->dev, "RTC chip is not present\n");
 		return err;
 	}
 
-	err = pcf85063_load_capacitance(client);
+	pcf85063->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(pcf85063->rtc))
+		return PTR_ERR(pcf85063->rtc);
+
+	err = pcf85063_load_capacitance(pcf85063, client->dev.of_node);
 	if (err < 0)
 		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
 			 err);
 
-	rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	rtc->ops = &pcf85063_rtc_ops;
-	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	rtc->range_max = RTC_TIMESTAMP_END_2099;
+	pcf85063->rtc->ops = &pcf85063_rtc_ops;
+	pcf85063->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	pcf85063->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
-	return rtc_register_device(rtc);
+	return rtc_register_device(pcf85063->rtc);
 }
 
 #ifdef CONFIG_OF
-- 
2.20.1

