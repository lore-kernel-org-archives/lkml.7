Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74594C282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A31A2083E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDGVQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:16:51 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39349 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:16:50 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3EEEC1C0002;
        Sun,  7 Apr 2019 21:16:48 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: tegra: set range
Date:   Sun,  7 Apr 2019 23:16:44 +0200
Message-Id: <20190407211646.14962-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra 20 RTC is a 32bit seconds counter (with an unused millisecond
counter).

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tegra.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index c6b0a99aa3a9..3f93a1f7abb5 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -306,6 +306,13 @@ static int __init tegra_rtc_probe(struct platform_device *pdev)
 
 	info->tegra_rtc_irq = ret;
 
+	info->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(info->rtc_dev))
+		return PTR_ERR(info->rtc_dev);
+
+	info->rtc_dev->ops = &tegra_rtc_ops;
+	info->rtc_dev->range_max = U32_MAX;
+
 	info->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(info->clk))
 		return PTR_ERR(info->clk);
@@ -327,16 +334,6 @@ static int __init tegra_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	info->rtc_dev = devm_rtc_device_register(&pdev->dev,
-				dev_name(&pdev->dev), &tegra_rtc_ops,
-				THIS_MODULE);
-	if (IS_ERR(info->rtc_dev)) {
-		ret = PTR_ERR(info->rtc_dev);
-		dev_err(&pdev->dev, "Unable to register device (err=%d).\n",
-			ret);
-		goto disable_clk;
-	}
-
 	ret = devm_request_irq(&pdev->dev, info->tegra_rtc_irq,
 			tegra_rtc_irq_handler, IRQF_TRIGGER_HIGH,
 			dev_name(&pdev->dev), &pdev->dev);
@@ -347,6 +344,13 @@ static int __init tegra_rtc_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
+	ret = rtc_register_device(info->rtc_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to register device (err=%d).\n",
+			ret);
+		goto disable_clk;
+	}
+
 	dev_notice(&pdev->dev, "Tegra internal Real Time Clock\n");
 
 	return 0;
-- 
2.20.1

