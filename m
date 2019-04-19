Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0342C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697FB205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfDSS7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:59:13 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36370 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfDSS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:59:13 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id D7B203AAEB6;
        Fri, 19 Apr 2019 08:00:15 +0000 (UTC)
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0EEEF200028;
        Fri, 19 Apr 2019 08:00:14 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/8] rtc: ep93xx: use rtc_add_group
Date:   Fri, 19 Apr 2019 10:00:00 +0200
Message-Id: <20190419080005.16138-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419080005.16138-1-alexandre.belloni@bootlin.com>
References: <20190419080005.16138-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rtc_add_group to add the sysfs group in a race free manner.
This has the side effect of moving the files to their proper location.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ep93xx.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index f15391bc4597..27417b4a8095 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -94,7 +94,7 @@ static ssize_t ep93xx_rtc_show_comp_preload(struct device *dev,
 {
 	unsigned short preload;
 
-	ep93xx_rtc_get_swcomp(dev, &preload, NULL);
+	ep93xx_rtc_get_swcomp(dev->parent, &preload, NULL);
 
 	return sprintf(buf, "%d\n", preload);
 }
@@ -105,7 +105,7 @@ static ssize_t ep93xx_rtc_show_comp_delete(struct device *dev,
 {
 	unsigned short delete;
 
-	ep93xx_rtc_get_swcomp(dev, NULL, &delete);
+	ep93xx_rtc_get_swcomp(dev->parent, NULL, &delete);
 
 	return sprintf(buf, "%d\n", delete);
 }
@@ -144,22 +144,11 @@ static int ep93xx_rtc_probe(struct platform_device *pdev)
 
 	ep93xx_rtc->rtc->ops = &ep93xx_rtc_ops;
 
-	err = rtc_register_device(ep93xx_rtc->rtc);
+	err = rtc_add_group(ep93xx_rtc->rtc, &ep93xx_rtc_sysfs_files);
 	if (err)
 		return err;
 
-	err = sysfs_create_group(&pdev->dev.kobj, &ep93xx_rtc_sysfs_files);
-	if (err)
-		return err;
-
-	return 0;
-}
-
-static int ep93xx_rtc_remove(struct platform_device *pdev)
-{
-	sysfs_remove_group(&pdev->dev.kobj, &ep93xx_rtc_sysfs_files);
-
-	return 0;
+	return rtc_register_device(ep93xx_rtc->rtc);
 }
 
 static struct platform_driver ep93xx_rtc_driver = {
@@ -167,7 +156,6 @@ static struct platform_driver ep93xx_rtc_driver = {
 		.name	= "ep93xx-rtc",
 	},
 	.probe		= ep93xx_rtc_probe,
-	.remove		= ep93xx_rtc_remove,
 };
 
 module_platform_driver(ep93xx_rtc_driver);
-- 
2.20.1

