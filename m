Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B5FC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B512083E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfDGVMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:12:38 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48399 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfDGVMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:12:36 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 764B760002;
        Sun,  7 Apr 2019 21:12:34 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/4] rtc: stmp3xxx: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Sun,  7 Apr 2019 23:12:21 +0200
Message-Id: <20190407211223.14265-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407211223.14265-1-alexandre.belloni@bootlin.com>
References: <20190407211223.14265-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion now that the range is
enforced by the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-stmp3xxx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index a6a2963e89a5..dc0c6cc4849d 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -160,7 +160,7 @@ static int stmp3xxx_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	if (ret)
 		return ret;
 
-	rtc_time_to_tm(readl(rtc_data->io + STMP3XXX_RTC_SECONDS), rtc_tm);
+	rtc_time64_to_tm(readl(rtc_data->io + STMP3XXX_RTC_SECONDS), rtc_tm);
 	return 0;
 }
 
@@ -214,17 +214,15 @@ static int stmp3xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(rtc_data->io + STMP3XXX_RTC_ALARM), &alm->time);
+	rtc_time64_to_tm(readl(rtc_data->io + STMP3XXX_RTC_ALARM), &alm->time);
 	return 0;
 }
 
 static int stmp3xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
-	unsigned long t;
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	rtc_tm_to_time(&alm->time, &t);
-	writel(t, rtc_data->io + STMP3XXX_RTC_ALARM);
+	writel(rtc_tm_to_time64(&alm->time), rtc_data->io + STMP3XXX_RTC_ALARM);
 
 	stmp3xxx_alarm_irq_enable(dev, alm->enabled);
 
-- 
2.20.1

