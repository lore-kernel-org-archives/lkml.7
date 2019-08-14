Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0367EC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8313216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfHNPKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:10:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43463 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfHNPKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:10:15 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 63E0520004;
        Wed, 14 Aug 2019 15:10:14 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 8/9] rtc: pcf2123: implement .alarm_irq_enable
Date:   Wed, 14 Aug 2019 17:10:01 +0200
Message-Id: <20190814151002.7324-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814151002.7324-1-alexandre.belloni@bootlin.com>
References: <20190814151002.7324-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement .alarm_irq_enable so it is possible to use RTC_ALM_SET,
RTC_AIE_ON and RTC_AIE_OFF.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2123.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 26f43b619b48..bda4b1687318 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -236,6 +236,14 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int pcf2123_rtc_alarm_irq_enable(struct device *dev, unsigned int en)
+{
+	struct pcf2123_data *pcf2123 = dev_get_drvdata(dev);
+
+	return regmap_update_bits(pcf2123->map, PCF2123_REG_CTRL2, CTRL2_AIE,
+				  en ? CTRL2_AIE : 0);
+}
+
 static int pcf2123_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct pcf2123_data *pcf2123 = dev_get_drvdata(dev);
@@ -293,15 +301,7 @@ static int pcf2123_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	if (ret)
 		return ret;
 
-	/* Enable alarm interrupt */
-	if (alm->enabled)	{
-		ret = regmap_update_bits(pcf2123->map, PCF2123_REG_CTRL2,
-						CTRL2_AIE, CTRL2_AIE);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return pcf2123_rtc_alarm_irq_enable(dev, alm->enabled);
 }
 
 static irqreturn_t pcf2123_rtc_irq(int irq, void *dev)
@@ -370,6 +370,7 @@ static const struct rtc_class_ops pcf2123_rtc_ops = {
 	.set_offset	= pcf2123_set_offset,
 	.read_alarm	= pcf2123_rtc_read_alarm,
 	.set_alarm	= pcf2123_rtc_set_alarm,
+	.alarm_irq_enable = pcf2123_rtc_alarm_irq_enable,
 };
 
 static int pcf2123_probe(struct spi_device *spi)
-- 
2.21.0

