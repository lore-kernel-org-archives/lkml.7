Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC8EC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E4A2083E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDGVMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:12:47 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49477 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfDGVMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:12:37 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3BFB01C0003;
        Sun,  7 Apr 2019 21:12:35 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] rtc: stmp3xxx: use .set_time
Date:   Sun,  7 Apr 2019 23:12:22 +0200
Message-Id: <20190407211223.14265-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407211223.14265-1-alexandre.belloni@bootlin.com>
References: <20190407211223.14265-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-stmp3xxx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index dc0c6cc4849d..143486f69485 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -164,11 +164,11 @@ static int stmp3xxx_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	return 0;
 }
 
-static int stmp3xxx_rtc_set_mmss(struct device *dev, unsigned long t)
+static int stmp3xxx_rtc_settime(struct device *dev, struct rtc_time *rtc_tm)
 {
 	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
 
-	writel(t, rtc_data->io + STMP3XXX_RTC_SECONDS);
+	writel(rtc_tm_to_time64(rtc_tm), rtc_data->io + STMP3XXX_RTC_SECONDS);
 	return stmp3xxx_wait_time(rtc_data);
 }
 
@@ -233,7 +233,7 @@ static const struct rtc_class_ops stmp3xxx_rtc_ops = {
 	.alarm_irq_enable =
 			  stmp3xxx_alarm_irq_enable,
 	.read_time	= stmp3xxx_rtc_gettime,
-	.set_mmss	= stmp3xxx_rtc_set_mmss,
+	.set_time	= stmp3xxx_rtc_settime,
 	.read_alarm	= stmp3xxx_rtc_read_alarm,
 	.set_alarm	= stmp3xxx_rtc_set_alarm,
 };
-- 
2.20.1

