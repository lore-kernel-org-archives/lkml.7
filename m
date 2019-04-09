Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EFBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56E32084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfDIKQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:16:47 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:50997 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfDIKQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:16:45 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0F6C424000E;
        Tue,  9 Apr 2019 10:16:42 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/6] rtc: lpc32xx: use .set_time
Date:   Tue,  9 Apr 2019 12:16:30 +0200
Message-Id: <20190409101631.5116-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409101631.5116-1-alexandre.belloni@bootlin.com>
References: <20190409101631.5116-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-lpc32xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index bd5186928eae..0ddb1ef98121 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -71,9 +71,10 @@ static int lpc32xx_rtc_read_time(struct device *dev, struct rtc_time *time)
 	return 0;
 }
 
-static int lpc32xx_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int lpc32xx_rtc_set_time(struct device *dev, struct rtc_time *time)
 {
 	struct lpc32xx_rtc *rtc = dev_get_drvdata(dev);
+	u32 secs = rtc_tm_to_time64(time);
 	u32 tmp;
 
 	spin_lock_irq(&rtc->lock);
@@ -184,7 +185,7 @@ static irqreturn_t lpc32xx_rtc_alarm_interrupt(int irq, void *dev)
 
 static const struct rtc_class_ops lpc32xx_rtc_ops = {
 	.read_time		= lpc32xx_rtc_read_time,
-	.set_mmss		= lpc32xx_rtc_set_mmss,
+	.set_time		= lpc32xx_rtc_set_time,
 	.read_alarm		= lpc32xx_rtc_read_alarm,
 	.set_alarm		= lpc32xx_rtc_set_alarm,
 	.alarm_irq_enable	= lpc32xx_rtc_alarm_irq_enable,
-- 
2.20.1

