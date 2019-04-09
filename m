Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5156DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCDF2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDIKQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:16:37 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:34943 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:16:36 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7138224001B;
        Tue,  9 Apr 2019 10:16:33 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/6] rtc: lpc32xx: convert to devm_rtc_allocate_device
Date:   Tue,  9 Apr 2019 12:16:26 +0200
Message-Id: <20190409101631.5116-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-lpc32xx.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index 910e600275b9..295dc6ddac6d 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -47,8 +47,6 @@
 
 #define LPC32XX_RTC_KEY_ONSW_LOADVAL	0xB5C13F27
 
-#define RTC_NAME "rtc-lpc32xx"
-
 #define rtc_readl(dev, reg) \
 	__raw_readl((dev)->rtc_base + (reg))
 #define rtc_writel(dev, reg, val) \
@@ -201,7 +199,7 @@ static int lpc32xx_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct lpc32xx_rtc *rtc;
-	int rtcirq;
+	int rtcirq, err;
 	u32 tmp;
 
 	rtcirq = platform_get_irq(pdev, 0);
@@ -256,12 +254,15 @@ static int lpc32xx_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
-	rtc->rtc = devm_rtc_device_register(&pdev->dev, RTC_NAME,
-					&lpc32xx_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc)) {
-		dev_err(&pdev->dev, "Can't get RTC\n");
+	rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc))
 		return PTR_ERR(rtc->rtc);
-	}
+
+	rtc->rtc->ops = &lpc32xx_rtc_ops;
+
+	err = rtc_register_device(rtc->rtc);
+	if (err)
+		return err;
 
 	/*
 	 * IRQ is enabled after device registration in case alarm IRQ
@@ -374,7 +375,7 @@ static struct platform_driver lpc32xx_rtc_driver = {
 	.probe		= lpc32xx_rtc_probe,
 	.remove		= lpc32xx_rtc_remove,
 	.driver = {
-		.name	= RTC_NAME,
+		.name	= "rtc-lpc32xx",
 		.pm	= LPC32XX_RTC_PM_OPS,
 		.of_match_table = of_match_ptr(lpc32xx_rtc_match),
 	},
-- 
2.20.1

