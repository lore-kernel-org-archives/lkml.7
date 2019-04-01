Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBA8C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668DE2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfDAQI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:08:57 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:50631 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfDAQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:08:40 -0400
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B5887100003;
        Mon,  1 Apr 2019 16:08:38 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 10/12] rtc: pcf85063: add nvram support
Date:   Mon,  1 Apr 2019 18:08:14 +0200
Message-Id: <20190401160816.17859-10-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
References: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcf85063 has one byte of nvram.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 0ac763c10744..04aaa83a5431 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -38,6 +38,8 @@
 #define PCF85063_CTRL2_AF		BIT(6)
 #define PCF85063_CTRL2_AIE		BIT(7)
 
+#define PCF85063_REG_RAM		0x03
+
 #define PCF85063_REG_SC			0x04 /* datetime */
 #define PCF85063_REG_SC_OS		0x80
 
@@ -236,6 +238,18 @@ static const struct rtc_class_ops pcf85063_rtc_ops_alarm = {
 	.alarm_irq_enable = pcf85063_rtc_alarm_irq_enable,
 };
 
+static int pcf85063_nvmem_read(void *priv, unsigned int offset,
+			       void *val, size_t bytes)
+{
+	return regmap_read(priv, PCF85063_REG_RAM, val);
+}
+
+static int pcf85063_nvmem_write(void *priv, unsigned int offset,
+				void *val, size_t bytes)
+{
+	return regmap_write(priv, PCF85063_REG_RAM, *(u8 *)val);
+}
+
 static int pcf85063_load_capacitance(struct pcf85063 *pcf85063,
 				     const struct device_node *np,
 				     unsigned int force_cap)
@@ -298,6 +312,13 @@ static int pcf85063_probe(struct i2c_client *client)
 	int err;
 	const struct pcf85063_config *config = &pcf85063tp_config;
 	const void *data = of_device_get_match_data(&client->dev);
+	struct nvmem_config nvmem_cfg = {
+		.name = "pcf85063_nvram",
+		.reg_read = pcf85063_nvmem_read,
+		.reg_write = pcf85063_nvmem_write,
+		.type = NVMEM_TYPE_BATTERY_BACKED,
+		.size = 1,
+	};
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
@@ -354,6 +375,9 @@ static int pcf85063_probe(struct i2c_client *client)
 		}
 	}
 
+	nvmem_cfg.priv = pcf85063->regmap;
+	rtc_nvmem_register(pcf85063->rtc, &nvmem_cfg);
+
 	return rtc_register_device(pcf85063->rtc);
 }
 
-- 
2.20.1

