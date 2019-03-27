Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692D1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3262920693
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mQNFKuSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbfC0F7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:59:13 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6222 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732984AbfC0F5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10bb0000>; Tue, 26 Mar 2019 22:57:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 22:57:16 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:16 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:16 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10ba0003>; Tue, 26 Mar 2019 22:57:15 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 09/26] spi: tegra114: dump SPI registers during timeout
Date:   Tue, 26 Mar 2019 22:56:30 -0700
Message-ID: <1553666207-11414-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666235; bh=s3KHjtXt1zgMVIUGUGMHh6JDkD3XIJDHG16DAqm1T5E=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=mQNFKuSWUt7o8ySMVu83+C+6TThCIQ+08xb1KF5FDL4ECUs+ok4epFohew92dasaU
         gAIGVk8TK8dUGXCYEz5M4gEoL4xlhHu0x9/LIRE0bhhGQoQ7oPxhdFsInCcYwpgjT4
         WXM3y2FjxSOwm79zfY2wlKwtvbw35FFXEx6dhcfoulWWo76jc8JGIU4EiuxgpsgvuX
         /rgwq6hI0VmVj/0aYzMRoNjVfCgn0InF9P2+uGlSqQZV+oLFTvo0RUNtfiHYWVDqgm
         TuFPvKJLexhDNfEDACcm1d1O8doIpwhBFfrOl4GeTgnCrhJSm/xqn1OqjiB08f3e9K
         mXndgojDE+jkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch dumps SPI registers on DMA or transfer timeout for debug
purpose.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index b7e71676a506..268a790a663e 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -858,6 +858,20 @@ static void tegra_spi_transfer_delay(int delay)
 	udelay(delay % 1000);
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
@@ -904,6 +918,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			    (tspi->cur_direction & DATA_DIR_RX))
 				dmaengine_terminate_all(tspi->rx_dma_chan);
 			ret = -EIO;
+			tegra_spi_dump_regs(tspi);
 			tegra_spi_flush_fifos(tspi);
 			reset_control_assert(tspi->rst);
 			udelay(2);
@@ -913,6 +928,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 
 		if (tspi->tx_status ||  tspi->rx_status) {
 			dev_err(tspi->dev, "Error in Transfer\n");
+			tegra_spi_dump_regs(tspi);
 			ret = -EIO;
 			goto complete_xfer;
 		}
@@ -958,6 +974,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
 		reset_control_assert(tspi->rst);
 		udelay(2);
@@ -1031,6 +1048,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
 		reset_control_assert(tspi->rst);
 		udelay(2);
-- 
2.7.4

