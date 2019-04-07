Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFCCC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3261820880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDGLys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:54:48 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50153 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfDGLys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:54:48 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1F65F1C0009;
        Sun,  7 Apr 2019 11:54:45 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: wm831x: use .set_time
Date:   Sun,  7 Apr 2019 13:54:44 +0200
Message-Id: <20190407115444.20650-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-wm831x.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index 6a0defd16088..ed29f4df2a3c 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -165,15 +165,17 @@ static int wm831x_rtc_readtime(struct device *dev, struct rtc_time *tm)
 /*
  * Set current time and date in RTC
  */
-static int wm831x_rtc_set_mmss(struct device *dev, unsigned long time)
+static int wm831x_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	struct wm831x_rtc *wm831x_rtc = dev_get_drvdata(dev);
 	struct wm831x *wm831x = wm831x_rtc->wm831x;
 	struct rtc_time new_tm;
-	unsigned long new_time;
+	unsigned long time, new_time;
 	int ret;
 	int count = 0;
 
+	time = rtc_tm_to_time64(tm);
+
 	ret = wm831x_reg_write(wm831x, WM831X_RTC_TIME_1,
 			       (time >> 16) & 0xffff);
 	if (ret < 0) {
@@ -334,7 +336,7 @@ static irqreturn_t wm831x_alm_irq(int irq, void *data)
 
 static const struct rtc_class_ops wm831x_rtc_ops = {
 	.read_time = wm831x_rtc_readtime,
-	.set_mmss = wm831x_rtc_set_mmss,
+	.set_time = wm831x_rtc_settime,
 	.read_alarm = wm831x_rtc_readalarm,
 	.set_alarm = wm831x_rtc_setalarm,
 	.alarm_irq_enable = wm831x_rtc_alarm_irq_enable,
-- 
2.20.1

