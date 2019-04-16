Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFBBC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988662176F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="A+W14/Os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfDPXyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:54:17 -0400
Received: from onstation.org ([52.200.56.107]:38662 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbfDPXyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:54:14 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 892A144895;
        Tue, 16 Apr 2019 23:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1555458852;
        bh=I6XAQfnXzzMYWvuNlSX2GOhv7GRS4pAsK9csPezVX30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+W14/OsyNecaD9QfpCjYlPkOOwK7gf2c0bYJ+Jg8pBkzPFBM1pZyDrmT7OMKHoTY
         FOJ+ZbJq1O3eFZ7iX7FMx+HDOZ/fjDmwEApXTkEUW3ZkOt/GyU2n/REFQXLG7MSCpA
         cRSJrLbWo9HkJLstNeiEcjDf+UAIO5jDEggX8RRE=
From:   Brian Masney <masneyb@onstation.org>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: [PATCH v4 3/3] backlight: lm3630a: add firmware node support
Date:   Tue, 16 Apr 2019 19:53:50 -0400
Message-Id: <20190416235350.13742-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416235350.13742-1-masneyb@onstation.org>
References: <20190416235350.13742-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fwnode support to the lm3630a driver and optionally allow
configuring the label, default brightness level, and maximum brightness
level. The two outputs can be controlled by bank A and B independently
or bank A can control both outputs.

If the platform data was not configured, then the driver defaults to
enabling both banks. This patch changes the default value to disable
both banks before parsing the firmware node so that just a single bank
can be enabled if desired. There are no in-tree users of this driver.

Driver was tested on a LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v3
- Add support for label
- Changed lm3630a_parse_node() to return -ENODEV if no nodes were found
- Remove LM3630A_LED{A,B}_DISABLE
- Add two additional newlines for code readability
- Remove extra newline

Changes since v2
- Separated out control banks and outputs via the reg and led-sources
  properties.
- Use fwnode instead of of API
- Disable both banks by default before calling lm3630a_parse_node()
- Add lots of error handling
- Check for duplicate source / bank definitions
- Remove extra ;
- Make probe() method fail if fwnode parsing fails.

 drivers/video/backlight/lm3630a_bl.c     | 147 ++++++++++++++++++++++-
 include/linux/platform_data/lm3630a_bl.h |   4 +
 2 files changed, 146 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index ef2553f452ca..6d3c54bfbb10 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -329,15 +329,17 @@ static const struct backlight_ops lm3630a_bank_b_ops = {
 
 static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
 {
-	struct backlight_properties props;
 	struct lm3630a_platform_data *pdata = pchip->pdata;
+	struct backlight_properties props;
+	const char *label;
 
 	props.type = BACKLIGHT_RAW;
 	if (pdata->leda_ctrl != LM3630A_LEDA_DISABLE) {
 		props.brightness = pdata->leda_init_brt;
 		props.max_brightness = pdata->leda_max_brt;
+		label = pdata->leda_label ? pdata->leda_label : "lm3630a_leda";
 		pchip->bleda =
-		    devm_backlight_device_register(pchip->dev, "lm3630a_leda",
+		    devm_backlight_device_register(pchip->dev, label,
 						   pchip->dev, pchip,
 						   &lm3630a_bank_a_ops, &props);
 		if (IS_ERR(pchip->bleda))
@@ -348,8 +350,9 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
 	    (pdata->ledb_ctrl != LM3630A_LEDB_ON_A)) {
 		props.brightness = pdata->ledb_init_brt;
 		props.max_brightness = pdata->ledb_max_brt;
+		label = pdata->ledb_label ? pdata->ledb_label : "lm3630a_ledb";
 		pchip->bledb =
-		    devm_backlight_device_register(pchip->dev, "lm3630a_ledb",
+		    devm_backlight_device_register(pchip->dev, label,
 						   pchip->dev, pchip,
 						   &lm3630a_bank_b_ops, &props);
 		if (IS_ERR(pchip->bledb))
@@ -364,6 +367,129 @@ static const struct regmap_config lm3630a_regmap = {
 	.max_register = REG_MAX,
 };
 
+/**
+ * lm3630a_parse_led_sources - Parse the optional led-sources fwnode property.
+ * @node: firmware node
+ * @default_bitmask: bitmask to return if the led-sources property was not
+ *                   specified
+ *
+ * Parses the optional led-sources firmware node and returns a bitmask that
+ * contains the outputs that are associated with the control bank. If the
+ * property is missing, then the value of of @default_bitmask will be returned.
+ */
+static int lm3630a_parse_led_sources(struct fwnode_handle *node,
+				     int default_bitmask)
+{
+	int ret, num_sources, i;
+	u32 sources[2];
+
+	num_sources = fwnode_property_read_u32_array(node, "led-sources", NULL,
+						     0);
+	if (num_sources < 0)
+		return default_bitmask;
+	else if (num_sources > ARRAY_SIZE(sources))
+		return -EINVAL;
+
+	ret = fwnode_property_read_u32_array(node, "led-sources", sources,
+					     num_sources);
+	if (ret)
+		return ret;
+
+	ret = 0;
+	for (i = 0; i < num_sources; i++) {
+		if (sources[i] < 0 || sources[i] > 1)
+			return -EINVAL;
+
+		ret |= BIT(sources[i]);
+	}
+
+	return ret;
+}
+
+static int lm3630a_parse_node(struct lm3630a_chip *pchip,
+			      struct lm3630a_platform_data *pdata)
+{
+	int led_sources, ret = -ENODEV, seen = 0;
+	struct fwnode_handle *node;
+	const char *label;
+	u32 bank, val;
+	bool linear;
+
+	device_for_each_child_node(pchip->dev, node) {
+		ret = fwnode_property_read_u32(node, "reg", &bank);
+		if (ret < 0)
+			return ret;
+
+		if (bank < 0 || bank > 1)
+			return -EINVAL;
+
+		if (seen & BIT(bank))
+			return -EINVAL;
+
+		seen |= BIT(bank);
+
+		led_sources = lm3630a_parse_led_sources(node, BIT(bank));
+		if (led_sources < 0)
+			return led_sources;
+
+		linear = fwnode_property_read_bool(node,
+						   "ti,linear-mapping-mode");
+		if (bank == 0) {
+			if (!(led_sources & BIT(0)))
+				return -EINVAL;
+
+			pdata->leda_ctrl = linear ?
+				LM3630A_LEDA_ENABLE_LINEAR :
+				LM3630A_LEDA_ENABLE;
+
+			if (led_sources & BIT(1)) {
+				if (seen & BIT(1))
+					return -EINVAL;
+
+				seen |= BIT(1);
+
+				pdata->ledb_ctrl = LM3630A_LEDB_ON_A;
+			}
+		} else {
+			if (led_sources & BIT(0) || !(led_sources & BIT(1)))
+				return -EINVAL;
+
+			pdata->ledb_ctrl = linear ?
+				LM3630A_LEDB_ENABLE_LINEAR :
+				LM3630A_LEDB_ENABLE;
+		}
+
+		ret = fwnode_property_read_string(node, "label", &label);
+		if (!ret) {
+			if (bank == 0)
+				pdata->leda_label = label;
+			else
+				pdata->ledb_label = label;
+		}
+
+		ret = fwnode_property_read_u32(node, "default-brightness",
+					       &val);
+		if (!ret) {
+			if (bank == 0)
+				pdata->leda_init_brt = val;
+			else
+				pdata->ledb_init_brt = val;
+		}
+
+		ret = fwnode_property_read_u32(node, "max-brightness", &val);
+		if (!ret) {
+			if (bank == 0)
+				pdata->leda_max_brt = val;
+			else
+				pdata->ledb_max_brt = val;
+		}
+
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int lm3630a_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -396,13 +522,18 @@ static int lm3630a_probe(struct i2c_client *client,
 				     GFP_KERNEL);
 		if (pdata == NULL)
 			return -ENOMEM;
+
 		/* default values */
-		pdata->leda_ctrl = LM3630A_LEDA_ENABLE;
-		pdata->ledb_ctrl = LM3630A_LEDB_ENABLE;
 		pdata->leda_max_brt = LM3630A_MAX_BRIGHTNESS;
 		pdata->ledb_max_brt = LM3630A_MAX_BRIGHTNESS;
 		pdata->leda_init_brt = LM3630A_MAX_BRIGHTNESS;
 		pdata->ledb_init_brt = LM3630A_MAX_BRIGHTNESS;
+
+		rval = lm3630a_parse_node(pchip, pdata);
+		if (rval) {
+			dev_err(&client->dev, "fail : parse node\n");
+			return rval;
+		}
 	}
 	pchip->pdata = pdata;
 
@@ -470,11 +601,17 @@ static const struct i2c_device_id lm3630a_id[] = {
 	{}
 };
 
+static const struct of_device_id lm3630a_match_table[] = {
+	{ .compatible = "ti,lm3630a", },
+	{ },
+};
+
 MODULE_DEVICE_TABLE(i2c, lm3630a_id);
 
 static struct i2c_driver lm3630a_i2c_driver = {
 	.driver = {
 		   .name = LM3630A_NAME,
+		   .of_match_table = lm3630a_match_table,
 		   },
 	.probe = lm3630a_probe,
 	.remove = lm3630a_remove,
diff --git a/include/linux/platform_data/lm3630a_bl.h b/include/linux/platform_data/lm3630a_bl.h
index 7538e38e270b..762e68956f31 100644
--- a/include/linux/platform_data/lm3630a_bl.h
+++ b/include/linux/platform_data/lm3630a_bl.h
@@ -38,9 +38,11 @@ enum lm3630a_ledb_ctrl {
 
 #define LM3630A_MAX_BRIGHTNESS 255
 /*
+ *@leda_label    : optional led a label.
  *@leda_init_brt : led a init brightness. 4~255
  *@leda_max_brt  : led a max brightness.  4~255
  *@leda_ctrl     : led a disable, enable linear, enable exponential
+ *@ledb_label    : optional led b label.
  *@ledb_init_brt : led b init brightness. 4~255
  *@ledb_max_brt  : led b max brightness.  4~255
  *@ledb_ctrl     : led b disable, enable linear, enable exponential
@@ -50,10 +52,12 @@ enum lm3630a_ledb_ctrl {
 struct lm3630a_platform_data {
 
 	/* led a config.  */
+	const char *leda_label;
 	int leda_init_brt;
 	int leda_max_brt;
 	enum lm3630a_leda_ctrl leda_ctrl;
 	/* led b config. */
+	const char *ledb_label;
 	int ledb_init_brt;
 	int ledb_max_brt;
 	enum lm3630a_ledb_ctrl ledb_ctrl;
-- 
2.20.1

