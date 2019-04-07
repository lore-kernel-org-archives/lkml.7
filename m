Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A96C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142B721904
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfDGVKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:10:40 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37957 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDGVKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:10:37 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 2E3A21C0005;
        Sun,  7 Apr 2019 21:10:35 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] rtc: coh901331: use .set_time
Date:   Sun,  7 Apr 2019 23:10:26 +0200
Message-Id: <20190407211027.14012-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407211027.14012-1-alexandre.belloni@bootlin.com>
References: <20190407211027.14012-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-coh901331.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index 1fd743fefe28..bc9544329419 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -90,12 +90,12 @@ static int coh901331_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static int coh901331_set_mmss(struct device *dev, unsigned long secs)
+static int coh901331_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct coh901331_port *rtap = dev_get_drvdata(dev);
 
 	clk_enable(rtap->clk);
-	writel(secs, rtap->virtbase + COH901331_SET_TIME);
+	writel(rtc_tm_to_time64(tm), rtap->virtbase + COH901331_SET_TIME);
 	clk_disable(rtap->clk);
 
 	return 0;
@@ -143,7 +143,7 @@ static int coh901331_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static const struct rtc_class_ops coh901331_ops = {
 	.read_time = coh901331_read_time,
-	.set_mmss = coh901331_set_mmss,
+	.set_time = coh901331_set_time,
 	.read_alarm = coh901331_read_alarm,
 	.set_alarm = coh901331_set_alarm,
 	.alarm_irq_enable = coh901331_alarm_irq_enable,
-- 
2.20.1

