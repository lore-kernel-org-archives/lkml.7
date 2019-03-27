Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF642070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DdyW7rCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733076AbfC0F5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:57:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17599 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732982AbfC0F5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10be0000>; Tue, 26 Mar 2019 22:57:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 22:57:15 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:15 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:14 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:14 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10b80000>; Tue, 26 Mar 2019 22:57:14 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 08/26] spi: tegra114: configure dma burst size to fifo trig level
Date:   Tue, 26 Mar 2019 22:56:29 -0700
Message-ID: <1553666207-11414-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666239; bh=Nj/elAeLdFMfOLAFpS3A87IYAOW4dTIKTWuFL3/8PDU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=DdyW7rCIuI4ONDCFGL/Z66ZHjs7Zkj1SJzl67O1fs2Jpktcwu9YPrgxeULbm0PJpb
         3bK0jj7HTimvIzZVG1OGcgHtsqsX9QAV2c4FkWgRURUE4GKJR3QyAn4dzbydoJp+8z
         4uCj3nc5JeUg6yIkXfLKQ/fBYxmwd9/lH01dRxIqxAZVOAqvpfwY5Ezvmz5L3wUAGT
         edWM2+Zq2AlT+zslCjDWYdKjzYHlI36VIW6nnFpzHNK4HMLmyLYP04Eba6VxJmtI5T
         G15+MUyG/RZO4QygwwMXMhiuyV///lsoJ/IWWYWpfFMh6/wilWHz58JPMzPkLqDf5L
         hUe+kOCP7BejQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: Configure DMA burst size to be same as SPI TX/RX trigger levels
to avoid mismatch.

SPI FIFO trigger levels are calculated based on the transfer length.
So this patch moves DMA slave configuration to happen before start
of DMAs.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 52 ++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 477828051aba..b7e71676a506 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -530,6 +530,8 @@ static int tegra_spi_start_dma_based_transfer(
 	u32 val;
 	unsigned int len;
 	int ret = 0;
+	u8 dma_burst;
+	struct dma_slave_config dma_sconfig = {0};
 
 	val = SPI_DMA_BLK_SET(tspi->curr_dma_words - 1);
 	tegra_spi_writel(tspi, val, SPI_DMA_BLK);
@@ -541,12 +543,16 @@ static int tegra_spi_start_dma_based_transfer(
 		len = tspi->curr_dma_words * 4;
 
 	/* Set attention level based on length of transfer */
-	if (len & 0xF)
+	if (len & 0xF) {
 		val |= SPI_TX_TRIG_1 | SPI_RX_TRIG_1;
-	else if (((len) >> 4) & 0x1)
+		dma_burst = 1;
+	} else if (((len) >> 4) & 0x1) {
 		val |= SPI_TX_TRIG_4 | SPI_RX_TRIG_4;
-	else
+		dma_burst = 4;
+	} else {
 		val |= SPI_TX_TRIG_8 | SPI_RX_TRIG_8;
+		dma_burst = 8;
+	}
 
 	if (tspi->cur_direction & DATA_DIR_TX)
 		val |= SPI_IE_TX;
@@ -557,7 +563,18 @@ static int tegra_spi_start_dma_based_transfer(
 	tegra_spi_writel(tspi, val, SPI_DMA_CTL);
 	tspi->dma_control_reg = val;
 
+	dma_sconfig.device_fc = true;
 	if (tspi->cur_direction & DATA_DIR_TX) {
+		dma_sconfig.dst_addr = tspi->phys + SPI_TX_FIFO;
+		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_sconfig.dst_maxburst = dma_burst;
+		ret = dmaengine_slave_config(tspi->tx_dma_chan, &dma_sconfig);
+		if (ret < 0) {
+			dev_err(tspi->dev,
+				"DMA slave config failed: %d\n", ret);
+			return ret;
+		}
+
 		tegra_spi_copy_client_txbuf_to_spi_txbuf(tspi, t);
 		ret = tegra_spi_start_tx_dma(tspi, len);
 		if (ret < 0) {
@@ -568,6 +585,16 @@ static int tegra_spi_start_dma_based_transfer(
 	}
 
 	if (tspi->cur_direction & DATA_DIR_RX) {
+		dma_sconfig.src_addr = tspi->phys + SPI_RX_FIFO;
+		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_sconfig.src_maxburst = dma_burst;
+		ret = dmaengine_slave_config(tspi->rx_dma_chan, &dma_sconfig);
+		if (ret < 0) {
+			dev_err(tspi->dev,
+				"DMA slave config failed: %d\n", ret);
+			return ret;
+		}
+
 		/* Make the dma buffer to read by dma */
 		dma_sync_single_for_device(tspi->dev, tspi->rx_dma_phys,
 				tspi->dma_buf_size, DMA_FROM_DEVICE);
@@ -628,7 +655,6 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 	u32 *dma_buf;
 	dma_addr_t dma_phys;
 	int ret;
-	struct dma_slave_config dma_sconfig;
 
 	dma_chan = dma_request_slave_channel_reason(tspi->dev,
 					dma_to_memory ? "rx" : "tx");
@@ -649,19 +675,6 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 	}
 
 	if (dma_to_memory) {
-		dma_sconfig.src_addr = tspi->phys + SPI_RX_FIFO;
-		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		dma_sconfig.src_maxburst = 0;
-	} else {
-		dma_sconfig.dst_addr = tspi->phys + SPI_TX_FIFO;
-		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		dma_sconfig.dst_maxburst = 0;
-	}
-
-	ret = dmaengine_slave_config(dma_chan, &dma_sconfig);
-	if (ret)
-		goto scrub;
-	if (dma_to_memory) {
 		tspi->rx_dma_chan = dma_chan;
 		tspi->rx_dma_buf = dma_buf;
 		tspi->rx_dma_phys = dma_phys;
@@ -671,11 +684,6 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 		tspi->tx_dma_phys = dma_phys;
 	}
 	return 0;
-
-scrub:
-	dma_free_coherent(tspi->dev, tspi->dma_buf_size, dma_buf, dma_phys);
-	dma_release_channel(dma_chan);
-	return ret;
 }
 
 static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
-- 
2.7.4

