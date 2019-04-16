Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDBDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979C220868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfDPIer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:34:47 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:37401 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPIeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:34:46 -0400
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5256220000A;
        Tue, 16 Apr 2019 08:34:43 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/5] rtc: imxdi: set range
Date:   Tue, 16 Apr 2019 10:34:28 +0200
Message-Id: <20190416083432.14483-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC Time Counter MSB Register contains the 32 most significant bits
(47:16) of the 47-bit RTC Time Counter. Clocked by a 32.768 KHz clock, this
register is effectively a 32-bit seconds counter.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-imxdi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 80931114c899..43d9cad69241 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -796,6 +796,10 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 
 	mutex_init(&imxdi->write_mutex);
 
+	imxdi->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(imxdi->rtc))
+		return PTR_ERR(imxdi->rtc);
+
 	imxdi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(imxdi->clk))
 		return PTR_ERR(imxdi->clk);
@@ -829,12 +833,13 @@ static int __init dryice_rtc_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, imxdi);
-	imxdi->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-				  &dryice_rtc_ops, THIS_MODULE);
-	if (IS_ERR(imxdi->rtc)) {
-		rc = PTR_ERR(imxdi->rtc);
+
+	imxdi->rtc->ops = &dryice_rtc_ops;
+	imxdi->rtc->range_max = U32_MAX;
+
+	rc = rtc_register_device(imxdi->rtc);
+	if (rc)
 		goto err;
-	}
 
 	return 0;
 
-- 
2.20.1

