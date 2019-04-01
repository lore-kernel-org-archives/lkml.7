Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC67C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B11208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfDAQIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:08:44 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41011 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbfDAQIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:08:42 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D60CD1BF20D;
        Mon,  1 Apr 2019 16:08:39 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 11/12] rtc: pcf85063: add offset correction support
Date:   Mon,  1 Apr 2019 18:08:15 +0200
Message-Id: <20190401160816.17859-11-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
References: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCF850363 has an offset correction with two modes:

With mode 0, the correction is triggered once every two hours and then
correction pulses are applied once per minute until the programmed
correction values have been implemented. This gives a step of 4.34 ppm.

With mode 1, the correction is triggered once every four minutes and then
correction pulses are applied once per second up to a maximum of 60 pulses.
When correction values greater than 60 pulses are used, additional
correction pulses are made in the 59 th second. This gives a step of 4.069
ppm.

Use the correction closest to the requested value.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 58 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 04aaa83a5431..1bce53f8a7da 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -38,6 +38,12 @@
 #define PCF85063_CTRL2_AF		BIT(6)
 #define PCF85063_CTRL2_AIE		BIT(7)
 
+#define PCF85063_REG_OFFSET		0x02
+#define PCF85063_OFFSET_SIGN_BIT	6	/* 2's complement sign bit */
+#define PCF85063_OFFSET_MODE		BIT(7)
+#define PCF85063_OFFSET_STEP0		4340
+#define PCF85063_OFFSET_STEP1		4069
+
 #define PCF85063_REG_RAM		0x03
 
 #define PCF85063_REG_SC			0x04 /* datetime */
@@ -225,14 +231,64 @@ static irqreturn_t pcf85063_rtc_handle_irq(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static int pcf85063_read_offset(struct device *dev, long *offset)
+{
+	struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
+	long val;
+	u32 reg;
+	int ret;
+
+	ret = regmap_read(pcf85063->regmap, PCF85063_REG_OFFSET, &reg);
+	if (ret < 0)
+		return ret;
+
+	val = sign_extend32(reg & ~PCF85063_OFFSET_MODE,
+			    PCF85063_OFFSET_SIGN_BIT);
+
+	if (reg & PCF85063_OFFSET_MODE)
+		*offset = val * PCF85063_OFFSET_STEP1;
+	else
+		*offset = val * PCF85063_OFFSET_STEP0;
+
+	return 0;
+}
+
+static int pcf85063_set_offset(struct device *dev, long offset)
+{
+	struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
+	s8 mode0, mode1, reg;
+	unsigned int error0, error1;
+
+	if (offset > PCF85063_OFFSET_STEP0 * 63)
+		return -ERANGE;
+	if (offset < PCF85063_OFFSET_STEP0 * -64)
+		return -ERANGE;
+
+	mode0 = DIV_ROUND_CLOSEST(offset, PCF85063_OFFSET_STEP0);
+	mode1 = DIV_ROUND_CLOSEST(offset, PCF85063_OFFSET_STEP1);
+
+	error0 = abs(offset - (mode0 * PCF85063_OFFSET_STEP0));
+	error1 = abs(offset - (mode1 * PCF85063_OFFSET_STEP1));
+	if (mode1 > 63 || mode1 < -64 || error0 < error1)
+		reg = mode0 & ~PCF85063_OFFSET_MODE;
+	else
+		reg = mode1 | PCF85063_OFFSET_MODE;
+
+	return regmap_write(pcf85063->regmap, PCF85063_REG_OFFSET, reg);
+}
+
 static const struct rtc_class_ops pcf85063_rtc_ops = {
 	.read_time	= pcf85063_rtc_read_time,
-	.set_time	= pcf85063_rtc_set_time
+	.set_time	= pcf85063_rtc_set_time,
+	.read_offset	= pcf85063_read_offset,
+	.set_offset	= pcf85063_set_offset,
 };
 
 static const struct rtc_class_ops pcf85063_rtc_ops_alarm = {
 	.read_time	= pcf85063_rtc_read_time,
 	.set_time	= pcf85063_rtc_set_time,
+	.read_offset	= pcf85063_read_offset,
+	.set_offset	= pcf85063_set_offset,
 	.read_alarm	= pcf85063_rtc_read_alarm,
 	.set_alarm	= pcf85063_rtc_set_alarm,
 	.alarm_irq_enable = pcf85063_rtc_alarm_irq_enable,
-- 
2.20.1

