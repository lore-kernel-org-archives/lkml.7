Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41DDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6ED2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfDPIdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:33:43 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:54689 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfDPIdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:33:14 -0400
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D604A200011;
        Tue, 16 Apr 2019 08:33:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/4] rtc: mc13xxx: use .set_time
Date:   Tue, 16 Apr 2019 10:33:06 +0200
Message-Id: <20190416083308.14220-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416083308.14220-1-alexandre.belloni@bootlin.com>
References: <20190416083308.14220-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss64.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mc13xxx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-mc13xxx.c b/drivers/rtc/rtc-mc13xxx.c
index 5c2862fcb2df..d8fab85fce61 100644
--- a/drivers/rtc/rtc-mc13xxx.c
+++ b/drivers/rtc/rtc-mc13xxx.c
@@ -89,14 +89,14 @@ static int mc13xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static int mc13xxx_rtc_set_mmss(struct device *dev, time64_t secs)
+static int mc13xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct mc13xxx_rtc *priv = dev_get_drvdata(dev);
 	unsigned int seconds, days;
 	unsigned int alarmseconds;
 	int ret;
 
-	days = div_s64_rem(secs, SEC_PER_DAY, &seconds);
+	days = div_s64_rem(rtc_tm_to_time64(tm), SEC_PER_DAY, &seconds);
 
 	mc13xxx_lock(priv->mc13xxx);
 
@@ -253,7 +253,7 @@ static irqreturn_t mc13xxx_rtc_alarm_handler(int irq, void *dev)
 
 static const struct rtc_class_ops mc13xxx_rtc_ops = {
 	.read_time = mc13xxx_rtc_read_time,
-	.set_mmss64 = mc13xxx_rtc_set_mmss,
+	.set_time = mc13xxx_rtc_set_time,
 	.read_alarm = mc13xxx_rtc_read_alarm,
 	.set_alarm = mc13xxx_rtc_set_alarm,
 	.alarm_irq_enable = mc13xxx_rtc_alarm_irq_enable,
-- 
2.20.1

