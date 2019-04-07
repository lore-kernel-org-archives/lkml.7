Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE81FC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F882070D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDGVaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:30:23 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:39781 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfDGVaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:30:23 -0400
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A6EED100003;
        Sun,  7 Apr 2019 21:30:20 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: test: use .set_time
Date:   Sun,  7 Apr 2019 23:30:12 +0200
Message-Id: <20190407213012.16108-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss64.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index f1a6dc5ad013..b298e9902f45 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -70,11 +70,11 @@ static int test_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static int test_rtc_set_mmss64(struct device *dev, time64_t secs)
+static int test_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct rtc_test_data *rtd = dev_get_drvdata(dev);
 
-	rtd->offset = secs - ktime_get_real_seconds();
+	rtd->offset = rtc_tm_to_time64(tm) - ktime_get_real_seconds();
 
 	return 0;
 }
@@ -94,15 +94,15 @@ static int test_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 
 static const struct rtc_class_ops test_rtc_ops_noalm = {
 	.read_time = test_rtc_read_time,
-	.set_mmss64 = test_rtc_set_mmss64,
+	.set_time = test_rtc_set_time,
 	.alarm_irq_enable = test_rtc_alarm_irq_enable,
 };
 
 static const struct rtc_class_ops test_rtc_ops = {
 	.read_time = test_rtc_read_time,
+	.set_time = test_rtc_set_time,
 	.read_alarm = test_rtc_read_alarm,
 	.set_alarm = test_rtc_set_alarm,
-	.set_mmss64 = test_rtc_set_mmss64,
 	.alarm_irq_enable = test_rtc_alarm_irq_enable,
 };
 
-- 
2.20.1

