Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C23C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420BE2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfCVHNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:13:47 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50135 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbfCVHNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:13:43 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5CDC5200003;
        Fri, 22 Mar 2019 07:13:41 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] rtc: wm831x: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Fri, 22 Mar 2019 08:13:27 +0100
Message-Id: <20190322071328.16123-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322071328.16123-1-alexandre.belloni@bootlin.com>
References: <20190322071328.16123-1-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-wm831x.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index 1b0c3b3f63e8..d286dd1dfcf9 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -155,7 +155,7 @@ static int wm831x_rtc_readtime(struct device *dev, struct rtc_time *tm)
 		if (memcmp(time1, time2, sizeof(time1)) == 0) {
 			u32 time = (time1[0] << 16) | time1[1];
 
-			rtc_time_to_tm(time, tm);
+			rtc_time64_to_tm(time, tm);
 			return 0;
 		}
 
@@ -215,11 +215,7 @@ static int wm831x_rtc_set_mmss(struct device *dev, unsigned long time)
 	if (ret < 0)
 		return ret;
 
-	ret = rtc_tm_to_time(&new_tm, &new_time);
-	if (ret < 0) {
-		dev_err(dev, "Failed to convert time: %d\n", ret);
-		return ret;
-	}
+	new_time = rtc_tm_to_time64(&new_tm);
 
 	/* Allow a second of change in case of tick */
 	if (new_time - time > 1) {
@@ -249,7 +245,7 @@ static int wm831x_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	time = (data[0] << 16) | data[1];
 
-	rtc_time_to_tm(time, &alrm->time);
+	rtc_time64_to_tm(time, &alrm->time);
 
 	ret = wm831x_reg_read(wm831x_rtc->wm831x, WM831X_RTC_CONTROL);
 	if (ret < 0) {
@@ -288,11 +284,7 @@ static int wm831x_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	int ret;
 	unsigned long time;
 
-	ret = rtc_tm_to_time(&alrm->time, &time);
-	if (ret < 0) {
-		dev_err(dev, "Failed to convert time: %d\n", ret);
-		return ret;
-	}
+	time = rtc_tm_to_time64(&alrm->time);
 
 	ret = wm831x_rtc_stop_alarm(wm831x_rtc);
 	if (ret < 0) {
-- 
2.20.1

