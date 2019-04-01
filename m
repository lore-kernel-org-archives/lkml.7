Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C91BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0E6208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfDAQI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:08:56 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:50095 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbfDAQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:08:40 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C1484240005;
        Mon,  1 Apr 2019 16:08:37 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 09/12] rtc: pcf85063: Add Micro Crystal RV8263 support
Date:   Mon,  1 Apr 2019 18:08:13 +0200
Message-Id: <20190401160816.17859-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
References: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Micro Crystal RV8263 has the same IC as the pcf85063 but has an on
board crystal. This means that the CAP_SEL bit has to be cleared so the
correct capacitance is selected for the crystal.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/rtc/nxp,pcf85063.txt  |  3 +-
 drivers/rtc/rtc-pcf85063.c                    | 32 ++++++++++++++++---
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
index 1e31afbfffe9..627bb533eff7 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
@@ -4,7 +4,8 @@ Required properties:
 - compatible: Should one of contain:
 	"nxp,pcf85063",
 	"nxp,pcf85063a",
-	"nxp,pcf85063tp"
+	"nxp,pcf85063tp",
+	"microcrystal,rv8263"
 - reg: I2C address for chip.
 
 Optional property:
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 536db43c84ee..0ac763c10744 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -5,6 +5,9 @@
  *
  * Author: Søren Andersen <san@rosetechnology.dk>
  * Maintainers: http://www.nslu2-linux.org/
+ *
+ * Copyright (C) 2019 Micro Crystal AG
+ * Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
  */
 #include <linux/i2c.h>
 #include <linux/bcd.h>
@@ -22,7 +25,10 @@
  *
  *  PCF85063A -- Rev. 6 — 18 November 2015
  *  PCF85063TP -- Rev. 4 — 6 May 2015
-*/
+ *
+ *  https://www.microcrystal.com/fileadmin/Media/Products/RTC/App.Manual/RV-8263-C7_App-Manual.pdf
+ *  RV8263 -- Rev. 1.0 — January 2019
+ */
 
 #define PCF85063_REG_CTRL1		0x00 /* status */
 #define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
@@ -41,6 +47,7 @@
 struct pcf85063_config {
 	struct regmap_config regmap;
 	unsigned has_alarms:1;
+	unsigned force_cap_7000:1;
 };
 
 struct pcf85063 {
@@ -230,12 +237,17 @@ static const struct rtc_class_ops pcf85063_rtc_ops_alarm = {
 };
 
 static int pcf85063_load_capacitance(struct pcf85063 *pcf85063,
-				     const struct device_node *np)
+				     const struct device_node *np,
+				     unsigned int force_cap)
 {
 	u32 load = 7000;
 	u8 reg = 0;
 
-	of_property_read_u32(np, "quartz-load-femtofarads", &load);
+	if (force_cap)
+		load = force_cap;
+	else
+		of_property_read_u32(np, "quartz-load-femtofarads", &load);
+
 	switch (load) {
 	default:
 		dev_warn(&pcf85063->rtc->dev, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
@@ -269,6 +281,16 @@ static const struct pcf85063_config pcf85063tp_config = {
 	},
 };
 
+static const struct pcf85063_config rv8263_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x11,
+	},
+	.has_alarms = 1,
+	.force_cap_7000 = 1,
+};
+
 static int pcf85063_probe(struct i2c_client *client)
 {
 	struct pcf85063 *pcf85063;
@@ -303,7 +325,8 @@ static int pcf85063_probe(struct i2c_client *client)
 	if (IS_ERR(pcf85063->rtc))
 		return PTR_ERR(pcf85063->rtc);
 
-	err = pcf85063_load_capacitance(pcf85063, client->dev.of_node);
+	err = pcf85063_load_capacitance(pcf85063, client->dev.of_node,
+					config->force_cap_7000 ? 7000 : 0);
 	if (err < 0)
 		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
 			 err);
@@ -339,6 +362,7 @@ static const struct of_device_id pcf85063_of_match[] = {
 	{ .compatible = "nxp,pcf85063", .data = &pcf85063tp_config },
 	{ .compatible = "nxp,pcf85063tp", .data = &pcf85063tp_config },
 	{ .compatible = "nxp,pcf85063a", .data = &pcf85063a_config },
+	{ .compatible = "microcrystal,rv8263", .data = &rv8263_config },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pcf85063_of_match);
-- 
2.20.1

