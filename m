Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C86CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F0F2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dW/dfleJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfCMFnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:43:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17342 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfCMFnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:43:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c8898790001>; Tue, 12 Mar 2019 22:43:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Mar 2019 22:43:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Mar 2019 22:43:20 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 05:43:20 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 05:43:19 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c8898750001>; Tue, 12 Mar 2019 22:43:19 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 1/2] dmaengine: tegra210-adma: use devm_clk_*() helpers
Date:   Wed, 13 Mar 2019 11:13:13 +0530
Message-ID: <1552455794-24946-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552455801; bh=A7umo4lz+biXj6Y0lvPP0q+nh1ziQwUXGC6mJcqRD4g=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=dW/dfleJ3a8oRXA4B4NpazNXcn8HT0nEIUGrRa9xbWEhcjcIphpTO+cVX1jR3Q+2d
         PnmofwXRl2HpPFVbGypRhr1nsOS6AQKRbox0y1PDXfFEKWeXNptF8jkhPLhEzwJodV
         QiIBb+1GuzAUBTV6hsbiaLYA6UmuuG4HnjA6Fu/jiNYRFkZ5njg/rE22gebXsQSEc9
         k3yqVvgeQzPzp3BDCHp5H33sPMOTG5CMzQzCOc2qB3ATn9btqCPbHKBzi2N46CN14I
         xESo1y9esWwAbow7Fkn+RmBdmQIxmZpA9SsBDlfVr8omHROeaC4n3nLR4qsgZB/Kgj
         D3FC7AkO7Lq3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adma driver is using pm_clk_*() interface for managing clock resources.
With this it is observed that clocks remain ON always. This happens on
Tegra devices which use BPMP co-processor to manage clock resources,
where clocks are enabled during prepare phase. This is necessary because
clocks to BPMP are always blocking. When pm_clk_*() interface is used on
such Tegra devices, clock prepare count is not balanced till remove call
happens for the driver and hence clocks are seen ON always. Thus this
patch replaces pm_clk_*() with devm_clk_*() framework.

Suggested-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 5ec0dd9..650cd9c 100644
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
@@ -693,13 +695,11 @@ static int tegra_adma_probe(struct platform_device *pdev)
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
 
@@ -776,8 +776,6 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 rpm_disable:
 	pm_runtime_disable(&pdev->dev);
-clk_destroy:
-	pm_clk_destroy(&pdev->dev);
 
 	return ret;
 }
@@ -794,7 +792,6 @@ static int tegra_adma_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	pm_clk_destroy(&pdev->dev);
 
 	return 0;
 }
-- 
2.7.4

