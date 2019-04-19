Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C42C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C826920643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfDSTA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:00:59 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:38104 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfDSTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:00:59 -0400
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id E56723A8D17;
        Fri, 19 Apr 2019 08:00:12 +0000 (UTC)
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 03DFC4000C;
        Fri, 19 Apr 2019 08:00:11 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/8] rtc: ep93xx: stop setting platform_data
Date:   Fri, 19 Apr 2019 09:59:58 +0200
Message-Id: <20190419080005.16138-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 28dc5f803899 ("drivers/rtc/rtc-ep93xx.c: use
dev_get_platdata()"), platform_data is not used directly, it is not
necessary to set it anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ep93xx.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 1932a4f861d1..db04ac445c69 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -28,10 +28,6 @@
 #define  EP93XX_RTC_SWCOMP_INT_MASK	 0x0000ffff
 #define  EP93XX_RTC_SWCOMP_INT_SHIFT	 0
 
-/*
- * struct device dev.platform_data is used to store our private data
- * because struct rtc_device does not have a variable to hold it.
- */
 struct ep93xx_rtc {
 	void __iomem	*mmio_base;
 	struct rtc_device *rtc;
@@ -140,31 +136,23 @@ static int ep93xx_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(ep93xx_rtc->mmio_base))
 		return PTR_ERR(ep93xx_rtc->mmio_base);
 
-	pdev->dev.platform_data = ep93xx_rtc;
 	platform_set_drvdata(pdev, ep93xx_rtc);
 
 	ep93xx_rtc->rtc = devm_rtc_device_register(&pdev->dev,
 				pdev->name, &ep93xx_rtc_ops, THIS_MODULE);
-	if (IS_ERR(ep93xx_rtc->rtc)) {
-		err = PTR_ERR(ep93xx_rtc->rtc);
-		goto exit;
-	}
+	if (IS_ERR(ep93xx_rtc->rtc))
+		return PTR_ERR(ep93xx_rtc->rtc);
 
 	err = sysfs_create_group(&pdev->dev.kobj, &ep93xx_rtc_sysfs_files);
 	if (err)
-		goto exit;
+		return err;
 
 	return 0;
-
-exit:
-	pdev->dev.platform_data = NULL;
-	return err;
 }
 
 static int ep93xx_rtc_remove(struct platform_device *pdev)
 {
 	sysfs_remove_group(&pdev->dev.kobj, &ep93xx_rtc_sysfs_files);
-	pdev->dev.platform_data = NULL;
 
 	return 0;
 }
-- 
2.20.1

