Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDC2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A9720868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfDPIdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:33:17 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43801 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPIdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:33:14 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id EDEB940002;
        Tue, 16 Apr 2019 08:33:11 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] rtc: mc13xxx: set range
Date:   Tue, 16 Apr 2019 10:33:05 +0200
Message-Id: <20190416083308.14220-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All supported PMICs have a 15 bits days counter and hours, minutes, seconds

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mc13xxx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mc13xxx.c b/drivers/rtc/rtc-mc13xxx.c
index 0fa33708fc49..5c2862fcb2df 100644
--- a/drivers/rtc/rtc-mc13xxx.c
+++ b/drivers/rtc/rtc-mc13xxx.c
@@ -285,8 +285,15 @@ static int __init mc13xxx_rtc_probe(struct platform_device *pdev)
 	priv->mc13xxx = mc13xxx;
 	priv->valid = 1;
 
+	priv->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(priv->rtc))
+		return PTR_ERR(priv->rtc);
 	platform_set_drvdata(pdev, priv);
 
+	priv->rtc->ops = &mc13xxx_rtc_ops;
+	/* 15bit days + hours, minutes, seconds */
+	priv->rtc->range_max = (timeu64_t)(1 << 15) * SEC_PER_DAY - 1;
+
 	mc13xxx_lock(mc13xxx);
 
 	mc13xxx_irq_ack(mc13xxx, MC13XXX_IRQ_RTCRST);
@@ -303,8 +310,9 @@ static int __init mc13xxx_rtc_probe(struct platform_device *pdev)
 
 	mc13xxx_unlock(mc13xxx);
 
-	priv->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					     &mc13xxx_rtc_ops, THIS_MODULE);
+	ret = rtc_register_device(priv->rtc);
+	if (ret)
+		goto err_irq_request;
 
 	return 0;
 
-- 
2.20.1

