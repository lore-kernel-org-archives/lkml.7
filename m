Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBA5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26466204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498358;
	bh=AAz1RORaZKt3U0k7M1DgjgQESTkcFki/l1MSeAXSw5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uwk5K0RIImG8NNK7KoTaJLbuO7//qfSmTpJQ2rlZrLEYgADT+fuPNzfeWpn054vK2
	 x2WFUj3L/D95Tc6IKsoCtu3McVpwwW9UKmNg5LI6Nz0SeU8t3fwLzc+LenvoE0VSGG
	 qpsrFCdtnhciiZ6SSlq8NceBQCDx9nI7lBxvqJVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfKKSwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729608AbfKKSwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:52:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA43204EC;
        Mon, 11 Nov 2019 18:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498349;
        bh=AAz1RORaZKt3U0k7M1DgjgQESTkcFki/l1MSeAXSw5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDvCSh6XyLyDc4uEHIRd7nwaUjG6bYwmMZlEPMacpmFSrFR248+xVuM4/e9w8sG/H
         wBr1YuApl5Wrwwc94LA+KSnCTKKTp9wXjMPT6TCtCBp4ZvFN4/EqPfe9H2g5y0cNaE
         StH+/FMLSk0ACWKt6sjfPVptJTpDqpGiRmWpSKv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 094/193] dmaengine: xilinx_dma: Fix 64-bit simple AXIDMA transfer
Date:   Mon, 11 Nov 2019 19:27:56 +0100
Message-Id: <20191111181508.078312105@linuxfoundation.org>
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

[ Upstream commit 68fe2b520cee829ed518b4b1f64d2a557bcbffe1 ]

In AXI DMA simple mode also pass MSB bits of source and destination
address to xilinx_write function. It fixes simple AXI DMA operation
mode using 64-bit addressing.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Link: https://lore.kernel.org/r/1569495060-18117-2-git-send-email-radhey.shyam.pandey@xilinx.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/xilinx_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index e7dc3c4dc8e07..1fbe0258578b0 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1354,7 +1354,8 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 					   node);
 		hw = &segment->hw;
 
-		xilinx_write(chan, XILINX_DMA_REG_SRCDSTADDR, hw->buf_addr);
+		xilinx_write(chan, XILINX_DMA_REG_SRCDSTADDR,
+			     xilinx_prep_dma_addr_t(hw->buf_addr));
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-- 
2.20.1



