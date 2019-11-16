Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269C5C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC0C20815
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919919;
	bh=944Gv2+l1XgASQkX6iyrWbxMiwa3kQrgD3Lq7C+YADM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NP9YjU68MqwJFRZH1dGl+U6yhdDeUIPdlZxOuKbZYHHHMsvfzlRmhOBqLMznn98fN
	 ma5TJSK8gjEZ/GJltRN6WfzxAQ9YPYxdg9tN0ZnyHD1vNM76GqGwy1RoxNkhGPexn7
	 EN54J1b7mlVTIKIhNGgWTVPLMFSZVXlTRTTNNZYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbfKPP6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730616AbfKPPyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:54:17 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5FE4218DE;
        Sat, 16 Nov 2019 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919657;
        bh=944Gv2+l1XgASQkX6iyrWbxMiwa3kQrgD3Lq7C+YADM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISmbCy22x5JcAOo7RVS/dV3y8kDJ4cHW3vIbvbZ1uze1zow/Z5ZxWxVPiIL8ZbZit
         kJ/0CkdT1n37o1IHYWiWcgBgQjIaPoKMa+eJiweyIYiUzEiDzAiGVQYmoiIQG8qyvu
         /89AXv4SG+hd4QahhXgx7T6UqxtY1uGWjyXW+qbM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 30/77] spi: omap2-mcspi: Set FIFO DMA trigger level to word length
Date:   Sat, 16 Nov 2019 10:52:52 -0500
Message-Id: <20191116155339.11909-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit b682cffa3ac6d9d9e16e9b413c45caee3b391fab ]

McSPI has 32 byte FIFO in Transmit-Receive mode. Current code tries to
configuration FIFO watermark level for DMA trigger to be GCD of transfer
length and max FIFO size which would mean trigger level may be set to 32
for transmit-receive mode if length is aligned. This does not work in
case of SPI slave mode where FIFO always needs to have data ready
whenever master starts the clock. With DMA trigger size of 32 there will
be a small window during slave TX where DMA is still putting data into
FIFO but master would have started clock for next byte, resulting in
shifting out of stale data. Similarly, on Slave RX side there may be RX
FIFO overflow
Fix this by setting FIFO watermark for DMA trigger to word
length. This means DMA is triggered as soon as FIFO has space for word
length bytes and DMA would make sure FIFO is almost always full
therefore improving FIFO occupancy in both master and slave mode.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 83b53cd956aa1..2e35fc735ba6a 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -301,7 +301,7 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi *mcspi;
 	unsigned int wcnt;
-	int max_fifo_depth, fifo_depth, bytes_per_word;
+	int max_fifo_depth, bytes_per_word;
 	u32 chconf, xferlevel;
 
 	mcspi = spi_master_get_devdata(master);
@@ -317,10 +317,6 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		else
 			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH;
 
-		fifo_depth = gcd(t->len, max_fifo_depth);
-		if (fifo_depth < 2 || fifo_depth % bytes_per_word != 0)
-			goto disable_fifo;
-
 		wcnt = t->len / bytes_per_word;
 		if (wcnt > OMAP2_MCSPI_MAX_FIFOWCNT)
 			goto disable_fifo;
@@ -328,16 +324,17 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 		xferlevel = wcnt << 16;
 		if (t->rx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFER;
-			xferlevel |= (fifo_depth - 1) << 8;
+			xferlevel |= (bytes_per_word - 1) << 8;
 		}
+
 		if (t->tx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFET;
-			xferlevel |= fifo_depth - 1;
+			xferlevel |= bytes_per_word - 1;
 		}
 
 		mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL, xferlevel);
 		mcspi_write_chconf0(spi, chconf);
-		mcspi->fifo_depth = fifo_depth;
+		mcspi->fifo_depth = max_fifo_depth;
 
 		return;
 	}
@@ -569,7 +566,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	struct dma_slave_config	cfg;
 	enum dma_slave_buswidth width;
 	unsigned es;
-	u32			burst;
 	void __iomem		*chstat_reg;
 	void __iomem            *irqstat_reg;
 	int			wait_res;
@@ -591,22 +587,14 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	}
 
 	count = xfer->len;
-	burst = 1;
-
-	if (mcspi->fifo_depth > 0) {
-		if (count > mcspi->fifo_depth)
-			burst = mcspi->fifo_depth / es;
-		else
-			burst = count / es;
-	}
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
 	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
 	cfg.src_addr_width = width;
 	cfg.dst_addr_width = width;
-	cfg.src_maxburst = burst;
-	cfg.dst_maxburst = burst;
+	cfg.src_maxburst = es;
+	cfg.dst_maxburst = es;
 
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
-- 
2.20.1

