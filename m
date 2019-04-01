Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEB5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7633C208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfDAQIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:08:46 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:44275 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfDAQIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:08:42 -0400
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DA13D100003;
        Mon,  1 Apr 2019 16:08:40 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 12/12] rtc: pcf85063: add RTC_VL_READ/RTC_VL_CLR support
Date:   Mon,  1 Apr 2019 18:08:16 +0200
Message-Id: <20190401160816.17859-12-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
References: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow reading the oscillator status bit. Also allow clearing it even if
that makes little sense and can't be done in a race free way.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 1bce53f8a7da..e550db5c2bc2 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -277,11 +277,45 @@ static int pcf85063_set_offset(struct device *dev, long offset)
 	return regmap_write(pcf85063->regmap, PCF85063_REG_OFFSET, reg);
 }
 
+static int pcf85063_ioctl(struct device *dev, unsigned int cmd,
+			  unsigned long arg)
+{
+	struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
+	int status, ret = 0;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		ret = regmap_read(pcf85063->regmap, PCF85063_REG_SC, &status);
+		if (ret < 0)
+			return ret;
+
+		if (status & PCF85063_REG_SC_OS)
+			dev_warn(&pcf85063->rtc->dev, "Voltage low, data loss detected.\n");
+
+		status &= PCF85063_REG_SC_OS;
+
+		if (copy_to_user((void __user *)arg, &status, sizeof(int)))
+			return -EFAULT;
+
+		return 0;
+
+	case RTC_VL_CLR:
+		ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_SC,
+					 PCF85063_REG_SC_OS, 0);
+
+		return ret;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 static const struct rtc_class_ops pcf85063_rtc_ops = {
 	.read_time	= pcf85063_rtc_read_time,
 	.set_time	= pcf85063_rtc_set_time,
 	.read_offset	= pcf85063_read_offset,
 	.set_offset	= pcf85063_set_offset,
+	.ioctl		= pcf85063_ioctl,
 };
 
 static const struct rtc_class_ops pcf85063_rtc_ops_alarm = {
@@ -292,6 +326,7 @@ static const struct rtc_class_ops pcf85063_rtc_ops_alarm = {
 	.read_alarm	= pcf85063_rtc_read_alarm,
 	.set_alarm	= pcf85063_rtc_set_alarm,
 	.alarm_irq_enable = pcf85063_rtc_alarm_irq_enable,
+	.ioctl		= pcf85063_ioctl,
 };
 
 static int pcf85063_nvmem_read(void *priv, unsigned int offset,
-- 
2.20.1

