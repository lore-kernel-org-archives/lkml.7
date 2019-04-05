Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D15C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BA12184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Jll4mqR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfDEAP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:15:26 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11321 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbfDEAOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:34 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69de60000>; Thu, 04 Apr 2019 17:14:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Apr 2019 17:14:32 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:32 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:32 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:32 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69de70001>; Thu, 04 Apr 2019 17:14:31 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 13/20] spi: tegra114: add support for interrupt mask
Date:   Thu, 4 Apr 2019 17:14:12 -0700
Message-ID: <1554423259-26056-13-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423270; bh=hYzL1haM0CQDbuYLN2OZw4JkYUbqqzT6jm7Oc/v2HfE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Jll4mqR034Z5brg5PO+UXWXEl3WnHo/lW3f7MCQY2qhGDx9Oz+iprkfwQRHdc4Wkd
         WUfzn7NdkRlTaVJpWx0uP8bBKkxUOFPBVJDk56mpL0Ty8c0Tym1b8bpuov9i3kJY5a
         yeywSqfKcFq3+rSZaWM8vRMIAygLuLeRavJiWDCQIHC/Uq2rpGt6CMyre9O4RQH/Ll
         j8mkB4Gq7NnsouN4uvEDlgf9vfQbivUg1L55j/16y3WQ4cvYAsIIzlAvXGlZ9tJdIg
         KqyRwVjp8tJnulPIMZBBBghxbSqpO4DLYFJG/pn7tfPbyzU/IJ0hmEU8R2NhaPSo4p
         ZP8avehG8WnYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates tegra_spi_soc_data structure to maintain and implement
SPI HW feature differences between different Tegra chips and also creates
a separate compatible string for T124/T210.

Tegra210 and later has a separate interrupt mask register SPI_INTR_MASK
for enabling or disabling interrupts while Tegra124 and prior uses
interrupt enable bits in SPI_DMA_CTL register.

This patch creates flag has_intr_mask_reg in tegra_spi_soc_data to
identify this and implements accordingly.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 53 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index d3b95bba2361..f4e39eb3857c 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -149,6 +149,8 @@
 
 #define SPI_TX_FIFO				0x108
 #define SPI_RX_FIFO				0x188
+#define SPI_INTR_MASK				0x18c
+#define SPI_INTR_ALL_MASK			(0x1fUL << 25)
 #define MAX_CHIP_SELECT				4
 #define SPI_FIFO_DEPTH				64
 #define DATA_DIR_TX				(1 << 0)
@@ -161,6 +163,10 @@
 #define MAX_HOLD_CYCLES				16
 #define SPI_DEFAULT_SPEED			25000000
 
+struct tegra_spi_soc_data {
+	bool has_intr_mask_reg;
+};
+
 struct tegra_spi_data {
 	struct device				*dev;
 	struct spi_master			*master;
@@ -211,6 +217,7 @@ struct tegra_spi_data {
 	u32					*tx_dma_buf;
 	dma_addr_t				tx_dma_phys;
 	struct dma_async_tx_descriptor		*tx_dma_desc;
+	const struct tegra_spi_soc_data		*soc_data;
 };
 
 static int tegra_spi_runtime_suspend(struct device *dev);
@@ -554,11 +561,13 @@ static int tegra_spi_start_dma_based_transfer(
 		dma_burst = 8;
 	}
 
-	if (tspi->cur_direction & DATA_DIR_TX)
-		val |= SPI_IE_TX;
+	if (!tspi->soc_data->has_intr_mask_reg) {
+		if (tspi->cur_direction & DATA_DIR_TX)
+			val |= SPI_IE_TX;
 
-	if (tspi->cur_direction & DATA_DIR_RX)
-		val |= SPI_IE_RX;
+		if (tspi->cur_direction & DATA_DIR_RX)
+			val |= SPI_IE_RX;
+	}
 
 	tegra_spi_writel(tspi, val, SPI_DMA_CTL);
 	tspi->dma_control_reg = val;
@@ -853,6 +862,12 @@ static int tegra_spi_setup(struct spi_device *spi)
 		return ret;
 	}
 
+	if (tspi->soc_data->has_intr_mask_reg) {
+		val = tegra_spi_readl(tspi, SPI_INTR_MASK);
+		val &= ~SPI_INTR_ALL_MASK;
+		tegra_spi_writel(tspi, val, SPI_INTR_MASK);
+	}
+
 	spin_lock_irqsave(&tspi->lock, flags);
 	val = tspi->def_command1_reg;
 	if (spi->mode & SPI_CS_HIGH)
@@ -1141,8 +1156,29 @@ static irqreturn_t tegra_spi_isr(int irq, void *context_data)
 	return IRQ_WAKE_THREAD;
 }
 
+static struct tegra_spi_soc_data tegra114_spi_soc_data = {
+	.has_intr_mask_reg = false,
+};
+
+static struct tegra_spi_soc_data tegra124_spi_soc_data = {
+	.has_intr_mask_reg = false,
+};
+
+static struct tegra_spi_soc_data tegra210_spi_soc_data = {
+	.has_intr_mask_reg = true,
+};
+
 static const struct of_device_id tegra_spi_of_match[] = {
-	{ .compatible = "nvidia,tegra114-spi", },
+	{
+		.compatible = "nvidia,tegra114-spi",
+		.data	    = &tegra114_spi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra124-spi",
+		.data	    = &tegra124_spi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra210-spi",
+		.data	    = &tegra210_spi_soc_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tegra_spi_of_match);
@@ -1184,6 +1220,13 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tspi->dev = &pdev->dev;
 	spin_lock_init(&tspi->lock);
 
+	tspi->soc_data = of_device_get_match_data(&pdev->dev);
+	if (!tspi->soc_data) {
+		dev_err(&pdev->dev, "unsupported tegra\n");
+		ret = -ENODEV;
+		goto exit_free_master;
+	}
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(tspi->base)) {
-- 
2.7.4

