Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E64EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782E72184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfCTMek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:34:40 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34893 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbfCTMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:34:39 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8773D1C000F;
        Wed, 20 Mar 2019 12:34:36 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/6] rtc: goldfish: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Wed, 20 Mar 2019 13:34:16 +0100
Message-Id: <20190320123417.13724-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320123417.13724-1-alexandre.belloni@bootlin.com>
References: <20190320123417.13724-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RTC handles dates after 2106 (up to July 2554), call the 64bit
versions of rtc_tm time conversion.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-goldfish.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
index 3fbd2715560e..e21d2e1f1623 100644
--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -57,7 +57,7 @@ static int goldfish_rtc_read_alarm(struct device *dev,
 	do_div(rtc_alarm, NSEC_PER_SEC);
 	memset(alrm, 0, sizeof(struct rtc_wkalrm));
 
-	rtc_time_to_tm(rtc_alarm, &alrm->time);
+	rtc_time64_to_tm(rtc_alarm, &alrm->time);
 
 	if (readl(base + TIMER_ALARM_STATUS))
 		alrm->enabled = 1;
@@ -71,21 +71,15 @@ static int goldfish_rtc_set_alarm(struct device *dev,
 				  struct rtc_wkalrm *alrm)
 {
 	struct goldfish_rtc *rtcdrv;
-	unsigned long rtc_alarm;
 	u64 rtc_alarm64;
 	u64 rtc_status_reg;
 	void __iomem *base;
-	int ret = 0;
 
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
 	if (alrm->enabled) {
-		ret = rtc_tm_to_time(&alrm->time, &rtc_alarm);
-		if (ret != 0)
-			return ret;
-
-		rtc_alarm64 = rtc_alarm * NSEC_PER_SEC;
+		rtc_alarm64 = rtc_tm_to_time64(&alrm->time) * NSEC_PER_SEC;
 		writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
 		writel(rtc_alarm64, base + TIMER_ALARM_LOW);
 	} else {
@@ -99,7 +93,7 @@ static int goldfish_rtc_set_alarm(struct device *dev,
 			writel(1, base + TIMER_CLEAR_ALARM);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int goldfish_rtc_alarm_irq_enable(struct device *dev,
@@ -148,7 +142,7 @@ static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	do_div(time, NSEC_PER_SEC);
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	return 0;
 }
@@ -157,21 +151,16 @@ static int goldfish_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct goldfish_rtc *rtcdrv;
 	void __iomem *base;
-	unsigned long now;
 	u64 now64;
-	int ret;
 
 	rtcdrv = dev_get_drvdata(dev);
 	base = rtcdrv->base;
 
-	ret = rtc_tm_to_time(tm, &now);
-	if (ret == 0) {
-		now64 = now * NSEC_PER_SEC;
-		writel((now64 >> 32), base + TIMER_TIME_HIGH);
-		writel(now64, base + TIMER_TIME_LOW);
-	}
+	now64 = rtc_tm_to_time64(tm) * NSEC_PER_SEC;
+	writel((now64 >> 32), base + TIMER_TIME_HIGH);
+	writel(now64, base + TIMER_TIME_LOW);
 
-	return ret;
+	return 0;
 }
 
 static const struct rtc_class_ops goldfish_rtc_ops = {
-- 
2.20.1

