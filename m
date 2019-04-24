Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6456AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37506208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfDXQYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:24:04 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:44579 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfDXQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:24:03 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hJKgY-0003E7-SJ; Wed, 24 Apr 2019 17:23:51 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1hJKgY-0006Au-Gi; Wed, 24 Apr 2019 17:23:50 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dma: tegra: add accurate reporting of dma state
Date:   Wed, 24 Apr 2019 17:23:48 +0100
Message-Id: <20190424162348.23692-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tx_status callback does not report the state of the transfer
beyond complete segments. This causes problems with users such as
ALSA when applications want to know accurately how much data has
been moved.

This patch addes a function tegra_dma_update_residual() to query
the hardware and modify the residual information accordinly. It
takes into account any hardware issues when trying to read the
state, such as delays between finishing a buffer and signalling
the interrupt.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com> (supporter:TEGRA DMA DRIVERS)
Cc: Jon Hunter <jonathanh@nvidia.com> (supporter:TEGRA DMA DRIVERS)
Cc: Vinod Koul <vkoul@kernel.org> (maintainer:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM)
Cc: Dan Williams <dan.j.williams@intel.com> (reviewer:ASYNCHRONOUS TRANSFERS/TRANSFORMS (IOAT) API)
Cc: Thierry Reding <thierry.reding@gmail.com> (supporter:TEGRA ARCHITECTURE SUPPORT)
Cc: dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM)
Cc: linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Cc: linux-kernel@vger.kernel.org (open list)
---
 drivers/dma/tegra20-apb-dma.c | 92 ++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index cf462b1abc0b..544e7273e741 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -808,6 +808,90 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	return 0;
 }
 
+static unsigned int tegra_dma_update_residual(struct tegra_dma_channel *tdc,
+					      struct tegra_dma_sg_req *sg_req,
+					      struct tegra_dma_desc *dma_desc,
+					      unsigned int residual)
+{
+	unsigned long status = 0x0;
+	unsigned long wcount;
+	unsigned long ahbptr;
+	unsigned long tmp = 0x0;
+	unsigned int result;
+	int retries = TEGRA_APBDMA_BURST_COMPLETE_TIME * 10;
+	int done;
+
+	/* if we're not the current request, then don't alter the residual */
+	if (sg_req != list_first_entry(&tdc->pending_sg_req,
+				       struct tegra_dma_sg_req, node)) {
+		result = residual;
+		ahbptr = 0xffffffff;
+		goto done;
+	}
+
+	/* loop until we have a reliable result for residual */
+	do {
+		ahbptr = tdc_read(tdc, TEGRA_APBDMA_CHAN_AHBPTR);
+		status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
+		tmp =  tdc_read(tdc, 0x08);	/* total count for debug */
+
+		/* check status, if channel isn't busy then skip */
+		if (!(status & TEGRA_APBDMA_STATUS_BUSY)) {
+			result = residual;
+			break;
+		}
+
+		/* if we've got an interrupt pending on the channel, don't
+		 * try and deal with the residue as the hardware has likely
+		 * moved on to the next buffer. return all data moved.
+		 */
+		if (status & TEGRA_APBDMA_STATUS_ISE_EOC) {
+			result = residual - sg_req->req_len;
+			break;
+		}
+
+		if (tdc->tdma->chip_data->support_separate_wcount_reg)
+			wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
+		else
+			wcount = status;
+
+		/* If the request is at the full point, then there is a
+		 * chance that we have read the status register in the
+		 * middle of the hardware reloading the next buffer.
+		 *
+		 * The sequence seems to be at the end of the buffer, to
+		 * load the new word count before raising the EOC flag (or
+		 * changing the ping-pong flag which could have also been
+		 * used to determine a new buffer). This  means there is a
+		 * small window where we cannot determine zero-done for the
+		 * current buffer, or moved to next buffer.
+		 *
+		 * If done shows 0, then retry the load, as it may hit the
+		 * above hardware race. We will either get a new value which
+		 * is from the first buffer, or we get an EOC (new buffer)
+		 * or both a new value and an EOC...
+		 */
+		done = get_current_xferred_count(tdc, sg_req, wcount);
+		if (done != 0) {
+			result = residual - done;
+			break;
+		}
+
+		ndelay(100);
+	} while (--retries > 0);
+
+	if (retries <= 0) {
+		dev_err(tdc2dev(tdc), "timeout waiting for dma load\n");
+		result = residual;
+	}
+
+done:	
+	dev_dbg(tdc2dev(tdc), "residual: req %08lx, ahb@%08lx, wcount %08lx, done %d\n",
+		 sg_req->ch_regs.ahb_ptr, ahbptr, wcount, done);
+
+	return result;
+}
+
 static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
@@ -849,6 +933,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 		residual = dma_desc->bytes_requested -
 			   (dma_desc->bytes_transferred %
 			    dma_desc->bytes_requested);
+		residual = tegra_dma_update_residual(tdc, sg_req, dma_desc, residual);
 		dma_set_residue(txstate, residual);
 	}
 
@@ -1444,12 +1529,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 		BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
 	tdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	/*
-	 * XXX The hardware appears to support
-	 * DMA_RESIDUE_GRANULARITY_BURST-level reporting, but it's
-	 * only used by this driver during tegra_dma_terminate_all()
-	 */
-	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	tdma->dma_dev.device_config = tegra_dma_slave_config;
 	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
 	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
-- 
2.20.1

