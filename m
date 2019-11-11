Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C495C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D532621925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498369;
	bh=X0UsWCc8knCwIbpLLX0WtWSJ5qAx6dFoPruE5QMt/z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oOea4Jdwn+UHLx4cVwcooOY4BY59dW8s+V0KxAwhvgcOYh/X+LX4+lOosdHKwrFWR
	 YLkR1suX0wuzfAQr/ROUddOcpIRkt7nEN+c0AGRw5lXNO5Kqn0kHGj48XmYxejtIgT
	 zOyPZkUY/JiK6ohA//+Qf1lD4Dh/TxirMHg/hbFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfKKSws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:52:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730493AbfKKSwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:52:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0405F214E0;
        Mon, 11 Nov 2019 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498356;
        bh=X0UsWCc8knCwIbpLLX0WtWSJ5qAx6dFoPruE5QMt/z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hI4gQ/qGsX6qNSRiwlrDPZxccLNkt+dwrCvZYPYwE6T6DJMSwbZFwjGzBl8C8M52P
         jwmY6jaL9oClVsP04b+h8KZiu4wU13rUVEp843RubRs1CpGs8ujgvAoamVBAQor+rh
         uBY6nzqrsLh+mFMdNcBWHEhbUobf9oxMAAk2hThk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 095/193] dmaengine: xilinx_dma: Fix control reg update in vdma_channel_set_config
Date:   Mon, 11 Nov 2019 19:27:57 +0100
Message-Id: <20191111181508.158970974@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

[ Upstream commit 6c6de1ddb1be3840f2ed5cc9d009a622720940c9 ]

In vdma_channel_set_config clear the delay, frame count and master mask
before updating their new values. It avoids programming incorrect state
when input parameters are different from default.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Acked-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Link: https://lore.kernel.org/r/1569495060-18117-3-git-send-email-radhey.shyam.pandey@xilinx.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/xilinx_dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 1fbe0258578b0..5d56f1e4d332c 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -68,6 +68,9 @@
 #define XILINX_DMA_DMACR_CIRC_EN		BIT(1)
 #define XILINX_DMA_DMACR_RUNSTOP		BIT(0)
 #define XILINX_DMA_DMACR_FSYNCSRC_MASK		GENMASK(6, 5)
+#define XILINX_DMA_DMACR_DELAY_MASK		GENMASK(31, 24)
+#define XILINX_DMA_DMACR_FRAME_COUNT_MASK	GENMASK(23, 16)
+#define XILINX_DMA_DMACR_MASTER_MASK		GENMASK(11, 8)
 
 #define XILINX_DMA_REG_DMASR			0x0004
 #define XILINX_DMA_DMASR_EOL_LATE_ERR		BIT(15)
@@ -2118,8 +2121,10 @@ int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
 	chan->config.gen_lock = cfg->gen_lock;
 	chan->config.master = cfg->master;
 
+	dmacr &= ~XILINX_DMA_DMACR_GENLOCK_EN;
 	if (cfg->gen_lock && chan->genlock) {
 		dmacr |= XILINX_DMA_DMACR_GENLOCK_EN;
+		dmacr &= ~XILINX_DMA_DMACR_MASTER_MASK;
 		dmacr |= cfg->master << XILINX_DMA_DMACR_MASTER_SHIFT;
 	}
 
@@ -2135,11 +2140,13 @@ int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
 	chan->config.delay = cfg->delay;
 
 	if (cfg->coalesc <= XILINX_DMA_DMACR_FRAME_COUNT_MAX) {
+		dmacr &= ~XILINX_DMA_DMACR_FRAME_COUNT_MASK;
 		dmacr |= cfg->coalesc << XILINX_DMA_DMACR_FRAME_COUNT_SHIFT;
 		chan->config.coalesc = cfg->coalesc;
 	}
 
 	if (cfg->delay <= XILINX_DMA_DMACR_DELAY_MAX) {
+		dmacr &= ~XILINX_DMA_DMACR_DELAY_MASK;
 		dmacr |= cfg->delay << XILINX_DMA_DMACR_DELAY_SHIFT;
 		chan->config.delay = cfg->delay;
 	}
-- 
2.20.1



