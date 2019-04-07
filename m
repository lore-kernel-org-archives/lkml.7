Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4733C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6852087F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDGVKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:10:39 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49681 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfDGVKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:10:36 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 35C0A20004;
        Sun,  7 Apr 2019 21:10:34 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/4] rtc: coh901331: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Sun,  7 Apr 2019 23:10:25 +0200
Message-Id: <20190407211027.14012-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407211027.14012-1-alexandre.belloni@bootlin.com>
References: <20190407211027.14012-1-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-coh901331.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index 5b214db919d0..1fd743fefe28 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -80,13 +80,14 @@ static int coh901331_read_time(struct device *dev, struct rtc_time *tm)
 
 	clk_enable(rtap->clk);
 	/* Check if the time is valid */
-	if (readl(rtap->virtbase + COH901331_VALID)) {
-		rtc_time_to_tm(readl(rtap->virtbase + COH901331_CUR_TIME), tm);
+	if (!readl(rtap->virtbase + COH901331_VALID)) {
 		clk_disable(rtap->clk);
-		return 0;
+		return -EINVAL;
 	}
+
+	rtc_time64_to_tm(readl(rtap->virtbase + COH901331_CUR_TIME), tm);
 	clk_disable(rtap->clk);
-	return -EINVAL;
+	return 0;
 }
 
 static int coh901331_set_mmss(struct device *dev, unsigned long secs)
@@ -105,7 +106,7 @@ static int coh901331_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	struct coh901331_port *rtap = dev_get_drvdata(dev);
 
 	clk_enable(rtap->clk);
-	rtc_time_to_tm(readl(rtap->virtbase + COH901331_ALARM), &alarm->time);
+	rtc_time64_to_tm(readl(rtap->virtbase + COH901331_ALARM), &alarm->time);
 	alarm->pending = readl(rtap->virtbase + COH901331_IRQ_EVENT) & 1U;
 	alarm->enabled = readl(rtap->virtbase + COH901331_IRQ_MASK) & 1U;
 	clk_disable(rtap->clk);
@@ -116,9 +117,8 @@ static int coh901331_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 static int coh901331_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct coh901331_port *rtap = dev_get_drvdata(dev);
-	unsigned long time;
+	unsigned long time =  rtc_tm_to_time64(&alarm->time);
 
-	rtc_tm_to_time(&alarm->time, &time);
 	clk_enable(rtap->clk);
 	writel(time, rtap->virtbase + COH901331_ALARM);
 	writel(alarm->enabled, rtap->virtbase + COH901331_IRQ_MASK);
-- 
2.20.1

