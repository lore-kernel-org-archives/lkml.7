Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7670BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496E821473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfDIKQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:16:46 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47953 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDIKQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:16:44 -0400
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id AD18F100011;
        Tue,  9 Apr 2019 10:16:41 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/6] rtc: lpc32xx: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Tue,  9 Apr 2019 12:16:29 +0200
Message-Id: <20190409101631.5116-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409101631.5116-1-alexandre.belloni@bootlin.com>
References: <20190409101631.5116-1-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-lpc32xx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index 652b969158d4..bd5186928eae 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -66,7 +66,7 @@ static int lpc32xx_rtc_read_time(struct device *dev, struct rtc_time *time)
 	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
 
 	elapsed_sec = rtc_readl(rtc, LPC32XX_RTC_UCOUNT);
-	rtc_time_to_tm(elapsed_sec, time);
+	rtc_time64_to_tm(elapsed_sec, time);
 
 	return 0;
 }
@@ -95,7 +95,7 @@ static int lpc32xx_rtc_read_alarm(struct device *dev,
 {
 	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(rtc_readl(rtc, LPC32XX_RTC_MATCH0), &wkalrm->time);
+	rtc_time64_to_tm(rtc_readl(rtc, LPC32XX_RTC_MATCH0), &wkalrm->time);
 	wkalrm->enabled = rtc->alarm_enabled;
 	wkalrm->pending = !!(rtc_readl(rtc, LPC32XX_RTC_INTSTAT) &
 		LPC32XX_RTC_INTSTAT_MATCH0);
@@ -109,13 +109,8 @@ static int lpc32xx_rtc_set_alarm(struct device *dev,
 	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
 	unsigned long alarmsecs;
 	u32 tmp;
-	int ret;
 
-	ret = rtc_tm_to_time(&wkalrm->time, &alarmsecs);
-	if (ret < 0) {
-		dev_warn(dev, "Failed to convert time: %d\n", ret);
-		return ret;
-	}
+	alarmsecs = rtc_tm_to_time64(&wkalrm->time);
 
 	spin_lock_irq(&rtc->lock);
 
-- 
2.20.1

