Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A161F20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="LMynH7Dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDAKay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:30:54 -0400
Received: from onstation.org ([52.200.56.107]:36894 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfDAKal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:30:41 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 613424571E;
        Mon,  1 Apr 2019 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1554114640;
        bh=LKI5QutWjmEa9X7MXO2InBl2G8mvzCmPoaPQ3bHxYAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMynH7DlcvOvu14NthY5tN6clcMCTcg0O7jv3CYS8OCNLJ+dIyPBsCkaNxqat5toQ
         x5R93Dk8CNtHhH6oiZ4zmJWm3aHcTNKykJoxWVf1t2vixo7RYaC/2e3BlcDcRJ0wYs
         anqbw5OjWEGd+3s01pqwwS4DS8R5UcBX0EHWyUpo=
From:   Brian Masney <masneyb@onstation.org>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: [PATCH v2 3/3] backlight: lm3630a: add device tree supprt
Date:   Mon,  1 Apr 2019 06:30:34 -0400
Message-Id: <20190401103034.21062-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401103034.21062-1-masneyb@onstation.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support to the lm3630a driver and allow configuring
independently on both banks the mapping mode (linear or exponential),
initial and maximum LED brightness.

Driver was tested on a LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/video/backlight/lm3630a_bl.c | 69 ++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index ef2553f452ca..96fbc1273dda 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -35,6 +35,9 @@
 #define REG_MAX		0x50
 
 #define INT_DEBOUNCE_MSEC	10
+
+#define LM3630A_MAX_SOURCES	2
+
 struct lm3630a_chip {
 	struct device *dev;
 	struct delayed_work work;
@@ -364,6 +367,64 @@ static const struct regmap_config lm3630a_regmap = {
 	.max_register = REG_MAX,
 };
 
+static void lm3630a_parse_dt(struct lm3630a_chip *pchip)
+{
+	u32 sources[LM3630A_MAX_SOURCES], val;
+	struct device_node *child_node;
+	int num_sources, ret, i;
+	bool linear;
+
+	for_each_available_child_of_node(pchip->dev->of_node, child_node) {
+		num_sources = of_property_count_u32_elems(child_node,
+							  "led-sources");
+		if (num_sources < 0)
+			continue;
+
+		if (num_sources > LM3630A_MAX_SOURCES)
+			num_sources = LM3630A_MAX_SOURCES;
+
+		ret = of_property_read_u32_array(child_node, "led-sources",
+						 sources, num_sources);
+		if (ret) {
+			dev_err(pchip->dev,
+				"Error parsing led-sources node: %d\n", ret);
+			return;
+		}
+
+		linear = of_property_read_bool(child_node,
+					       "ti,linear-mapping-mode");
+
+		for (i = 0; i < num_sources; i++) {
+			if (sources[i] == 0)
+				pchip->pdata->leda_ctrl = linear ?
+					LM3630A_LEDA_ENABLE_LINEAR :
+					LM3630A_LEDA_ENABLE;
+			else if (sources[i] == 1)
+				pchip->pdata->ledb_ctrl = linear ?
+					LM3630A_LEDB_ENABLE_LINEAR :
+					LM3630A_LEDB_ENABLE;
+
+			ret = of_property_read_u32(child_node,
+						   "default-brightness", &val);
+			if (!ret) {
+				if (sources[i] == 0)
+					pchip->pdata->leda_init_brt = val;
+				else if (sources[i] == 1)
+					pchip->pdata->ledb_init_brt = val;
+			}
+
+			ret = of_property_read_u32(child_node, "max-brightness",
+						   &val);
+			if (!ret) {
+				if (sources[i] == 0)
+					pchip->pdata->leda_max_brt = val;
+				else if (sources[i] == 1)
+					pchip->pdata->ledb_max_brt = val;
+			}
+		}
+	};
+}
+
 static int lm3630a_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -405,6 +466,7 @@ static int lm3630a_probe(struct i2c_client *client,
 		pdata->ledb_init_brt = LM3630A_MAX_BRIGHTNESS;
 	}
 	pchip->pdata = pdata;
+	lm3630a_parse_dt(pchip);
 
 	/* chip initialize */
 	rval = lm3630a_chip_init(pchip);
@@ -470,11 +532,18 @@ static const struct i2c_device_id lm3630a_id[] = {
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

