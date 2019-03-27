Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F566C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE1D20693
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WWhwB3eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbfC0F7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:59:00 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6229 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733035AbfC0F5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10be0001>; Tue, 26 Mar 2019 22:57:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 22:57:20 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:20 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:20 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:20 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10be0000>; Tue, 26 Mar 2019 22:57:19 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 11/26] spi: tegra114: reset controller on probe
Date:   Tue, 26 Mar 2019 22:56:32 -0700
Message-ID: <1553666207-11414-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666239; bh=XOOfuDefqq5ngbWhNxsWlTHkCm/Rd/ZkGBVSxxex63c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=WWhwB3eAdBq5t4JBb6Y7ZKcJgZnQAFDZU4Rr5Bb0xbcstFP5waI0ez6yCQCAwB1HF
         M6+l3JgGQlsfuIyCrS+jNSDXlxyc7GUQlf8BkwRhZBt82owp/0up2RJ1Js0mcgEkAE
         h+JZpdnkzQu7BDP/M6JRD02V27VUZMaBINOm4IanOVfCJVejy9ZFGbLaeVA+rAm/UW
         wxk5CB2372SyHIGh7PUFMayMZLFb9HfVWYF12cOfjWvNC56F+JCAJ+Q9I/cUmWFzB2
         Vb279o9/sp6DVjk4DrJPaogWjVnZjvd6+xnb/EiHNbxmE03E4L4aR4MsFybcZu5vSG
         +mzsXH14lWAUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: SPI driver can be built as module so perform SPI controller reset
on probe to make sure it is in valid state before initiating transfer.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 5523936b21f5..0e228f1e910e 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1157,27 +1157,19 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	spi_irq = platform_get_irq(pdev, 0);
 	tspi->irq = spi_irq;
-	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
-			tegra_spi_isr_thread, IRQF_ONESHOT,
-			dev_name(&pdev->dev), tspi);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
-					tspi->irq);
-		goto exit_free_master;
-	}
 
 	tspi->clk = devm_clk_get(&pdev->dev, "spi");
 	if (IS_ERR(tspi->clk)) {
 		dev_err(&pdev->dev, "can not get clock\n");
 		ret = PTR_ERR(tspi->clk);
-		goto exit_free_irq;
+		goto exit_free_master;
 	}
 
 	tspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(tspi->rst)) {
 		dev_err(&pdev->dev, "can not get reset\n");
 		ret = PTR_ERR(tspi->rst);
-		goto exit_free_irq;
+		goto exit_free_master;
 	}
 
 	tspi->max_buf_size = SPI_FIFO_DEPTH << 2;
@@ -1185,7 +1177,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	ret = tegra_spi_init_dma_param(tspi, true);
 	if (ret < 0)
-		goto exit_free_irq;
+		goto exit_free_master;
 	ret = tegra_spi_init_dma_param(tspi, false);
 	if (ret < 0)
 		goto exit_rx_dma_free;
@@ -1207,18 +1199,32 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
 		goto exit_pm_disable;
 	}
+
+	reset_control_assert(tspi->rst);
+	udelay(2);
+	reset_control_deassert(tspi->rst);
 	tspi->def_command1_reg  = SPI_M_S;
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	pm_runtime_put(&pdev->dev);
+	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
+				   tegra_spi_isr_thread, IRQF_ONESHOT,
+				   dev_name(&pdev->dev), tspi);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
+			tspi->irq);
+		goto exit_pm_disable;
+	}
 
 	master->dev.of_node = pdev->dev.of_node;
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
-		goto exit_pm_disable;
+		goto exit_free_irq;
 	}
 	return ret;
 
+exit_free_irq:
+	free_irq(spi_irq, tspi);
 exit_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
@@ -1226,8 +1232,6 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tegra_spi_deinit_dma_param(tspi, false);
 exit_rx_dma_free:
 	tegra_spi_deinit_dma_param(tspi, true);
-exit_free_irq:
-	free_irq(spi_irq, tspi);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
-- 
2.7.4

