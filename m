Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41DEC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D902D22CF5
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfHSS1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:27:23 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52617 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfHSS1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:27:01 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 09CF5FF803;
        Mon, 19 Aug 2019 18:26:58 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 3/9] rtc: pcf2123: implement .alarm_irq_enable
Date:   Mon, 19 Aug 2019 20:26:50 +0200
Message-Id: <20190819182656.29744-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819182656.29744-1-alexandre.belloni@bootlin.com>
References: <20190819182656.29744-1-alexandre.belloni@bootlin.com>
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
index 829d7a2dd950..809c35c8ba1a 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -238,6 +238,14 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int pcf2123_rtc_alarm_irq_enable(struct device *dev, unsigned int en)
+{
+	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
+
+	return regmap_update_bits(pdata->map, PCF2123_REG_CTRL2, CTRL2_AIE,
+				  en ? CTRL2_AIE : 0);
+}
+
 static int pcf2123_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
@@ -295,15 +303,7 @@ static int pcf2123_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	if (ret)
 		return ret;
 
-	/* Enable alarm interrupt */
-	if (alm->enabled)	{
-		ret = regmap_update_bits(pdata->map, PCF2123_REG_CTRL2,
-						CTRL2_AIE, CTRL2_AIE);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return pcf2123_rtc_alarm_irq_enable(dev, alm->enabled);
 }
 
 static irqreturn_t pcf2123_rtc_irq(int irq, void *dev)
@@ -372,6 +372,7 @@ static const struct rtc_class_ops pcf2123_rtc_ops = {
 	.set_offset	= pcf2123_set_offset,
 	.read_alarm	= pcf2123_rtc_read_alarm,
 	.set_alarm	= pcf2123_rtc_set_alarm,
+	.alarm_irq_enable = pcf2123_rtc_alarm_irq_enable,
 };
 
 static int pcf2123_probe(struct spi_device *spi)
-- 
2.21.0

