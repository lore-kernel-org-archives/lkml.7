Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B748C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472D2206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Qcj2fjTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDOH3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:29:42 -0400
Received: from onstation.org ([52.200.56.107]:59988 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfDOH3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:29:35 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D6BB344895;
        Mon, 15 Apr 2019 07:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1555313374;
        bh=+i67XgU9HN36r7KEsrp8EwMrTBjy20nz09sb/xCrgqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qcj2fjTAGRafrlRHWeuAEAYjg9ouumjjFY7REHqU17qniAcq+kDdw1QdjRvAJqf+2
         vLUcca/0QjzSFipCFAKg56MSWvRTLDBRSNM5bw6NBmOrUV4r/JKEnLjleTKHYFPkhQ
         WuR4CLMgORV3xDdd9w4o8NBhTt6BXLEKTv3uVCxM=
From:   Brian Masney <masneyb@onstation.org>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: [PATCH v3 3/3] backlight: lm3630a: add firmware node support
Date:   Mon, 15 Apr 2019 03:29:05 -0400
Message-Id: <20190415072905.2861-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415072905.2861-1-masneyb@onstation.org>
References: <20190415072905.2861-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fwnode support to the lm3630a driver and allow configuring
the initial and maximum LED brightness on both LED banks independently.
The two outputs can be controlled by bank A and B independently or
bank A can control both outputs.

If the platform data was not configured, then the driver defaults to
enabling both banks. This patch changes the default value to disable
both banks before parsing the firmware node so that just a single bank
can be enabled if desired. There are no in-tree users of this driver.

Driver was tested on a LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v2
- Separated out control banks and outputs via the reg and led-sources
  properties.
- Use fwnode instead of of API
- Disable both banks by default before calling lm3630a_parse_node()
- Add lots of error handling
- Check for duplicate source / bank definitions
- Remove extra ;
- Make probe() method fail if fwnode parsing fails.

 drivers/video/backlight/lm3630a_bl.c | 128 ++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index ef2553f452ca..15922da9c05a 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -364,6 +364,116 @@ static const struct regmap_config lm3630a_regmap = {
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
+	int seen = 0, led_sources, ret;
+	struct fwnode_handle *node;
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
+	}
+
+	return 0;
+}
+
 static int lm3630a_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -396,13 +506,20 @@ static int lm3630a_probe(struct i2c_client *client,
 				     GFP_KERNEL);
 		if (pdata == NULL)
 			return -ENOMEM;
+
 		/* default values */
-		pdata->leda_ctrl = LM3630A_LEDA_ENABLE;
-		pdata->ledb_ctrl = LM3630A_LEDB_ENABLE;
+		pdata->leda_ctrl = LM3630A_LEDA_DISABLE;
+		pdata->ledb_ctrl = LM3630A_LEDB_DISABLE;
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
 
@@ -470,11 +587,18 @@ static const struct i2c_device_id lm3630a_id[] = {
 	{}
 };
 
+static const struct of_device_id lm3630a_match_table[] = {
+	{ .compatible = "ti,lm3630a", },
+	{ },
+};
+
+
 MODULE_DEVICE_TABLE(i2c, lm3630a_id);
 
 static struct i2c_driver lm3630a_i2c_driver = {
 	.driver = {
 		   .name = LM3630A_NAME,
+		   .of_match_table = lm3630a_match_table,
 		   },
 	.probe = lm3630a_probe,
 	.remove = lm3630a_remove,
-- 
2.20.1

