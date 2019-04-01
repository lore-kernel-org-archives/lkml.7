Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD37C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E852133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfDAQIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:08:39 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48871 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfDAQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:08:37 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6A659240004;
        Mon,  1 Apr 2019 16:08:35 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 07/12] rtc: pcf85063: differentiate pcf85063a and pcf85063tp
Date:   Mon,  1 Apr 2019 18:08:11 +0200
Message-Id: <20190401160816.17859-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
References: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in a comment pcf85063a and pcf85063tp don't have the same number
of registers. Especially, pcf85063tp doesn't have alarm support.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/rtc/nxp,pcf85063.txt  |  5 ++-
 drivers/rtc/rtc-pcf85063.c                    | 33 +++++++++++++++----
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
index d3e380ad712d..1e31afbfffe9 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
@@ -1,7 +1,10 @@
 * NXP PCF85063 Real Time Clock
 
 Required properties:
-- compatible: Should contain "nxp,pcf85063".
+- compatible: Should one of contain:
+	"nxp,pcf85063",
+	"nxp,pcf85063a",
+	"nxp,pcf85063tp"
 - reg: I2C address for chip.
 
 Optional property:
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 632e1c8a3957..7519da905128 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -30,6 +30,10 @@
 #define PCF85063_REG_SC			0x04 /* datetime */
 #define PCF85063_REG_SC_OS		0x80
 
+struct pcf85063_config {
+	struct regmap_config regmap;
+};
+
 struct pcf85063 {
 	struct rtc_device	*rtc;
 	struct regmap		*regmap;
@@ -147,10 +151,20 @@ static int pcf85063_load_capacitance(struct pcf85063 *pcf85063,
 				  PCF85063_REG_CTRL1_CAP_SEL, reg);
 }
 
-static const struct regmap_config regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = 0x11,
+static const struct pcf85063_config pcf85063a_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x11,
+	},
+};
+
+static const struct pcf85063_config pcf85063tp_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x0a,
+	},
 };
 
 static int pcf85063_probe(struct i2c_client *client)
@@ -158,6 +172,8 @@ static int pcf85063_probe(struct i2c_client *client)
 	struct pcf85063 *pcf85063;
 	unsigned int tmp;
 	int err;
+	const struct pcf85063_config *config = &pcf85063tp_config;
+	const void *data = of_device_get_match_data(&client->dev);
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
@@ -166,7 +182,10 @@ static int pcf85063_probe(struct i2c_client *client)
 	if (!pcf85063)
 		return -ENOMEM;
 
-	pcf85063->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (data)
+		config = data;
+
+	pcf85063->regmap = devm_regmap_init_i2c(client, &config->regmap);
 	if (IS_ERR(pcf85063->regmap))
 		return PTR_ERR(pcf85063->regmap);
 
@@ -196,7 +215,9 @@ static int pcf85063_probe(struct i2c_client *client)
 
 #ifdef CONFIG_OF
 static const struct of_device_id pcf85063_of_match[] = {
-	{ .compatible = "nxp,pcf85063" },
+	{ .compatible = "nxp,pcf85063", .data = &pcf85063tp_config },
+	{ .compatible = "nxp,pcf85063tp", .data = &pcf85063tp_config },
+	{ .compatible = "nxp,pcf85063a", .data = &pcf85063a_config },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pcf85063_of_match);
-- 
2.20.1

