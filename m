Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F30C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15AE2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfCTMcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:32:42 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51813 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfCTMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:32:42 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C71AB4000F;
        Wed, 20 Mar 2019 12:32:39 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/7] rtc: xgene: fix possible race condition
Date:   Wed, 20 Mar 2019 13:32:27 +0100
Message-Id: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
struct before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-xgene.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index 153820876a82..2f741f455c30 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -168,6 +168,10 @@ static int xgene_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(pdata->csr_base))
 		return PTR_ERR(pdata->csr_base);
 
+	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(pdata->rtc))
+		return PTR_ERR(pdata->rtc);
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "No IRQ resource\n");
@@ -198,15 +202,15 @@ static int xgene_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					 &xgene_rtc_ops, THIS_MODULE);
-	if (IS_ERR(pdata->rtc)) {
-		clk_disable_unprepare(pdata->clk);
-		return PTR_ERR(pdata->rtc);
-	}
-
 	/* HW does not support update faster than 1 seconds */
 	pdata->rtc->uie_unsupported = 1;
+	pdata->rtc->ops = &xgene_rtc_ops;
+
+	ret = rtc_register_device(pdata->rtc);
+	if (ret) {
+		clk_disable_unprepare(pdata->clk);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.20.1

