Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C923BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962FE20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PUVbjOZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfCFKlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:41:36 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9065 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbfCFKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:41:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7fa3dd0000>; Wed, 06 Mar 2019 02:41:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Mar 2019 02:41:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Mar 2019 02:41:33 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Mar
 2019 10:41:33 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 6 Mar 2019 10:41:32 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7fa3da0000>; Wed, 06 Mar 2019 02:41:32 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <mkumard@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/3] dmaengine: tegra210-adma: use devm_clk_*() helpers
Date:   Wed, 6 Mar 2019 16:11:17 +0530
Message-ID: <1551868878-1131-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551868878-1131-1-git-send-email-spujar@nvidia.com>
References: <1551868878-1131-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551868893; bh=zd+T0jSSPTNtSGYxDwl/VtyPt5PqZbL4yl5jQ2tur9U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=PUVbjOZav1l6/MPfZtcwX3ngizp+cxULeQ/acMCUTDAfPkWlmO1k9wX/gMDAwG0nj
         1KoA6n+Vse5pl03zJYSs1sRl4Yg8dvfJQTtA92XOEiY2K9uqgaqqCMERKWpl0Ci5cL
         vs0Xv2m092xyC1eQJEhZcWj3iPYX3ZX9VII3NC27+4igi8ZzUhBdejKaplqXp2o534
         CexUYiIEyjmG6N/C4nAQ1Q8moSBzE74B3aknAkLxvLJs9H+tQgj8wNWHfJR21IOsql
         nBbb9SBasWXU5G8y6cDHddTk4hEFbEDaL1DzeWiaEJYl23r0eDN69V7aBaOWKN9M8z
         4IKCYuuitGbgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of pm_clk_*() results in non-zero prepare_count for clocks and hence
module clocks remain ON always. This is not desired as it will leak power
unncessarily. This patch replaces pm_clk_*() with devm_clk_*() interface.
This helps to keep refcounts balanced when device is not in use and runtime
PM callbacks help to enable or disable clocks. System suspend/resume calls
can use pm_runtime_force_suspend/resume.

Suggested-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index b26256f..123fc6d 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -22,7 +22,6 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/of_irq.h>
-#include <linux/pm_clock.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
@@ -141,6 +140,7 @@ struct tegra_adma {
 	struct dma_device		dma_dev;
 	struct device			*dev;
 	void __iomem			*base_addr;
+	struct clk			*ahub_clk;
 	unsigned int			nr_channels;
 	unsigned long			rx_requests_reserved;
 	unsigned long			tx_requests_reserved;
@@ -637,8 +637,9 @@ static int tegra_adma_runtime_suspend(struct device *dev)
 	struct tegra_adma *tdma = dev_get_drvdata(dev);
 
 	tdma->global_cmd = tdma_read(tdma, ADMA_GLOBAL_CMD);
+	clk_disable_unprepare(tdma->ahub_clk);
 
-	return pm_clk_suspend(dev);
+	return 0;
 }
 
 static int tegra_adma_runtime_resume(struct device *dev)
@@ -646,10 +647,11 @@ static int tegra_adma_runtime_resume(struct device *dev)
 	struct tegra_adma *tdma = dev_get_drvdata(dev);
 	int ret;
 
-	ret = pm_clk_resume(dev);
-	if (ret)
+	ret = clk_prepare_enable(tdma->ahub_clk);
+	if (ret) {
+		dev_err(dev, "ahub clk_enable failed: %d\n", ret);
 		return ret;
-
+	}
 	tdma_write(tdma, ADMA_GLOBAL_CMD, tdma->global_cmd);
 
 	return 0;
@@ -692,13 +694,11 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	if (IS_ERR(tdma->base_addr))
 		return PTR_ERR(tdma->base_addr);
 
-	ret = pm_clk_create(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = of_pm_clk_add_clk(&pdev->dev, "d_audio");
-	if (ret)
-		goto clk_destroy;
+	tdma->ahub_clk = devm_clk_get(&pdev->dev, "d_audio");
+	if (IS_ERR(tdma->ahub_clk)) {
+		dev_err(&pdev->dev, "Error: Missing ahub controller clock\n");
+		return PTR_ERR(tdma->ahub_clk);
+	}
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -775,8 +775,6 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 rpm_disable:
 	pm_runtime_disable(&pdev->dev);
-clk_destroy:
-	pm_clk_destroy(&pdev->dev);
 
 	return ret;
 }
@@ -793,22 +791,15 @@ static int tegra_adma_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	pm_clk_destroy(&pdev->dev);
 
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tegra_adma_pm_suspend(struct device *dev)
-{
-	return pm_runtime_suspended(dev) == false;
-}
-#endif
-
 static const struct dev_pm_ops tegra_adma_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_adma_runtime_suspend,
 			   tegra_adma_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(tegra_adma_pm_suspend, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static struct platform_driver tegra_admac_driver = {
-- 
2.7.4

