Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B6E217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IZOQAVE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfDEAOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:14:30 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6443 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfDEAO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:26 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69de60000>; Thu, 04 Apr 2019 17:14:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Apr 2019 17:14:25 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:25 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:25 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69de00003>; Thu, 04 Apr 2019 17:14:24 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 05/20] spi: tegra114: dump SPI registers during timeout
Date:   Thu, 4 Apr 2019 17:14:04 -0700
Message-ID: <1554423259-26056-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423270; bh=C8/q/A8GIH9xcJFybB+7dkihJTAhAi0KGae3smUb564=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=IZOQAVE9+EzXq3ErJcPFBrqofjILHFAP/71t8hC3tID87+ZiU6Gfu73Tp+QvMfSAE
         PYPYltg/g8P8f3pwI5CbODuBy/aZRX96a7hRU97pr1blEvn9zJOkDIN0CiufLMTQxC
         0YuqPFw1nFQuwpm0xbEKNsaOdF0ZPYcBj17vf8MSm0bX3M8GWHVBh4eaROwWkIQG08
         wpzyEnU6Znwh18n7pvN3dOhtPwby/VWe0T6RXbuX4rbaxyRD0Qd6MaGGoirvrY3oQi
         yRXfVUzCeUkDFDOOIaLVQdi09GFroz2sv/la/kBrS3sn3CduN+wS/SE1SUNDbHYExe
         zDMXUMFmoOIkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch dumps SPI registers on transfer error or timeout for debug
purpose.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index d928a2c92a3d..e0f20fad5df2 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -876,6 +876,20 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 }
 
+static void tegra_spi_dump_regs(struct tegra_spi_data *tspi)
+{
+	dev_dbg(tspi->dev, "============ SPI REGISTER DUMP ============\n");
+	dev_dbg(tspi->dev, "Command1:    0x%08x | Command2:    0x%08x\n",
+		tegra_spi_readl(tspi, SPI_COMMAND1),
+		tegra_spi_readl(tspi, SPI_COMMAND2));
+	dev_dbg(tspi->dev, "DMA_CTL:     0x%08x | DMA_BLK:     0x%08x\n",
+		tegra_spi_readl(tspi, SPI_DMA_CTL),
+		tegra_spi_readl(tspi, SPI_DMA_BLK));
+	dev_dbg(tspi->dev, "TRANS_STAT:  0x%08x | FIFO_STATUS: 0x%08x\n",
+		tegra_spi_readl(tspi, SPI_TRANS_STATUS),
+		tegra_spi_readl(tspi, SPI_FIFO_STATUS));
+}
+
 static int tegra_spi_transfer_one_message(struct spi_master *master,
 			struct spi_message *msg)
 {
@@ -922,6 +936,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			    (tspi->cur_direction & DATA_DIR_RX))
 				dmaengine_terminate_all(tspi->rx_dma_chan);
 			ret = -EIO;
+			tegra_spi_dump_regs(tspi);
 			tegra_spi_flush_fifos(tspi);
 			reset_control_assert(tspi->rst);
 			udelay(2);
@@ -932,6 +947,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		if (tspi->tx_status ||  tspi->rx_status) {
 			dev_err(tspi->dev, "Error in Transfer\n");
 			ret = -EIO;
+			tegra_spi_dump_regs(tspi);
 			goto complete_xfer;
 		}
 		msg->actual_length += xfer->len;
@@ -973,6 +989,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
 		complete(&tspi->xfer_completion);
 		spin_unlock_irqrestore(&tspi->lock, flags);
@@ -1047,6 +1064,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
 		complete(&tspi->xfer_completion);
 		spin_unlock_irqrestore(&tspi->lock, flags);
-- 
2.7.4

