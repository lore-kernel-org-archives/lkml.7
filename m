Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E3CC2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 20:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98694207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 20:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfL2Uov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 15:44:51 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:36861 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfL2Uov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 15:44:51 -0500
X-Originating-IP: 92.184.100.83
Received: from localhost (unknown [92.184.100.83])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 68DC4C0002;
        Sun, 29 Dec 2019 20:44:40 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Eugen.Hristev@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/9] rtc: at91rm9200: remove procfs information
Date:   Sun, 29 Dec 2019 21:44:13 +0100
Message-Id: <20191229204421.337612-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC procfs interface is deprecated and hasn't been used by userspace
for years.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-at91rm9200.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 3b833e02a657..89d91ecd8ccf 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -254,20 +254,6 @@ static int at91_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 	return 0;
 }
-/*
- * Provide additional RTC information in /proc/driver/rtc
- */
-static int at91_rtc_proc(struct device *dev, struct seq_file *seq)
-{
-	unsigned long imr = at91_rtc_read_imr();
-
-	seq_printf(seq, "update_IRQ\t: %s\n",
-			(imr & AT91_RTC_ACKUPD) ? "yes" : "no");
-	seq_printf(seq, "periodic_IRQ\t: %s\n",
-			(imr & AT91_RTC_SECEV) ? "yes" : "no");
-
-	return 0;
-}
 
 /*
  * IRQ handler for the RTC
@@ -337,7 +323,6 @@ static const struct rtc_class_ops at91_rtc_ops = {
 	.set_time	= at91_rtc_settime,
 	.read_alarm	= at91_rtc_readalarm,
 	.set_alarm	= at91_rtc_setalarm,
-	.proc		= at91_rtc_proc,
 	.alarm_irq_enable = at91_rtc_alarm_irq_enable,
 };
 
-- 
2.23.0

