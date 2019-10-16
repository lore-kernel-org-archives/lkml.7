Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFD4FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4B621925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394663AbfJPUMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:12:30 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:47299 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389651AbfJPUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:12:29 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AE056240003;
        Wed, 16 Oct 2019 20:12:27 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Biwen Li <biwen.li@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] rtc: fsl-ftm-alarm: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Wed, 16 Oct 2019 22:12:22 +0200
Message-Id: <20191016201223.30568-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016201223.30568-1-alexandre.belloni@bootlin.com>
References: <20191016201223.30568-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion to avoid the y2038 issue.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-fsl-ftm-alarm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
index e954c51bf39b..039bd2f1a7ee 100644
--- a/drivers/rtc/rtc-fsl-ftm-alarm.c
+++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
@@ -180,7 +180,7 @@ static int ftm_rtc_alarm_irq_enable(struct device *dev,
  */
 static int ftm_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	rtc_time_to_tm(ktime_get_real_seconds(), tm);
+	rtc_time64_to_tm(ktime_get_real_seconds(), tm);
 
 	return 0;
 }
@@ -204,12 +204,13 @@ static int ftm_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 static int ftm_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct rtc_time tm;
-	unsigned long now, alm_time, cycle;
+	time64_t now, alm_time;
+	unsigned long long cycle;
 	struct ftm_rtc *rtc = dev_get_drvdata(dev);
 
 	ftm_rtc_read_time(dev, &tm);
-	rtc_tm_to_time(&tm, &now);
-	rtc_tm_to_time(&alm->time, &alm_time);
+	now = rtc_tm_to_time64(&tm);
+	alm_time = rtc_tm_to_time64(&alm->time);
 
 	ftm_clean_alarm(rtc);
 	cycle = (alm_time - now) * rtc->alarm_freq;
-- 
2.21.0

