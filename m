Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508FCC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1628C20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDIUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:09 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59487 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDIUAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:00:06 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3315C40003;
        Tue,  9 Apr 2019 20:00:03 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: ab3100: use .set_time
Date:   Tue,  9 Apr 2019 21:59:44 +0200
Message-Id: <20190409195945.20725-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409195945.20725-1-alexandre.belloni@bootlin.com>
References: <20190409195945.20725-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss64.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab3100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ab3100.c b/drivers/rtc/rtc-ab3100.c
index f73a3707b897..ecf3f1494c13 100644
--- a/drivers/rtc/rtc-ab3100.c
+++ b/drivers/rtc/rtc-ab3100.c
@@ -43,12 +43,12 @@
 /*
  * RTC clock functions and device struct declaration
  */
-static int ab3100_rtc_set_mmss(struct device *dev, time64_t secs)
+static int ab3100_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	u8 regs[] = {AB3100_TI0, AB3100_TI1, AB3100_TI2,
 		     AB3100_TI3, AB3100_TI4, AB3100_TI5};
 	unsigned char buf[6];
-	u64 hw_counter = secs * AB3100_RTC_CLOCK_RATE * 2;
+	u64 hw_counter = rtc_tm_to_time64(tm) * AB3100_RTC_CLOCK_RATE * 2;
 	int err = 0;
 	int i;
 
@@ -192,7 +192,7 @@ static int ab3100_rtc_irq_enable(struct device *dev, unsigned int enabled)
 
 static const struct rtc_class_ops ab3100_rtc_ops = {
 	.read_time	= ab3100_rtc_read_time,
-	.set_mmss64	= ab3100_rtc_set_mmss,
+	.set_time	= ab3100_rtc_set_time,
 	.read_alarm	= ab3100_rtc_read_alarm,
 	.set_alarm	= ab3100_rtc_set_alarm,
 	.alarm_irq_enable = ab3100_rtc_irq_enable,
-- 
2.20.1

