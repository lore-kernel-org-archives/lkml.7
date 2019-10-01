Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C280C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AEF21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569949202;
	bh=lg4NZhD6aEiaPEorh6MHcLCVlbXhvN9IA9cMZA+xJcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AYigti3DMTzFETXjk42Z6jPAyRG6QH3v2OmxpAcCCFzF3jcXgf7AL1Q9lNErzh99k
	 aPl5SnW4F07vd/F/e6I+kr8KTQOaYn7MvEKSlKm3nvLBabEWaaRiIp9vZTr1idDSOk
	 5i10RKj1gckUqq4HKtcjxpfDp25le+36VU/rc8V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbfJARAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730545AbfJAQlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:41:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FECF2168B;
        Tue,  1 Oct 2019 16:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948064;
        bh=lg4NZhD6aEiaPEorh6MHcLCVlbXhvN9IA9cMZA+xJcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5W2Jz99PPkHkl2IGDR0cf/R/2mwrc+Q9IIbfQ6SI0KDuLJBoz2VjYLWO0fUkSvzb
         a5p5F7ODZAZ4MVAqFzhBov+MPiOsceOdvncLcYDOHmkGZVZ7rUEJxPvNq46dMfvzEz
         6mbezP+KGxtSyBlbxxX/Bwk02fE3K25YCBV3i5EA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 61/71] net: stmmac: Fix page pool size
Date:   Tue,  1 Oct 2019 12:39:11 -0400
Message-Id: <20191001163922.14735-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001163922.14735-1-sashal@kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 4f28bd956e081fc018fe9b41ffa31573f17bfb61 ]

The size of individual pages in the page pool in given by an order. The
order is the binary logarithm of the number of pages that make up one of
the pages in the pool. However, the driver currently passes the number
of pages rather than the order, so it ends up wasting quite a bit of
memory.

Fix this by taking the binary logarithm and passing that in the order
field.

Fixes: 2af6106ae949 ("net: stmmac: Introducing support for Page Pool")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b19ab09cb18f7..5c4408bdc843a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1532,13 +1532,15 @@ static int alloc_dma_rx_desc_resources(struct stmmac_priv *priv)
 	for (queue = 0; queue < rx_count; queue++) {
 		struct stmmac_rx_queue *rx_q = &priv->rx_queue[queue];
 		struct page_pool_params pp_params = { 0 };
+		unsigned int num_pages;
 
 		rx_q->queue_index = queue;
 		rx_q->priv_data = priv;
 
 		pp_params.flags = PP_FLAG_DMA_MAP;
 		pp_params.pool_size = DMA_RX_SIZE;
-		pp_params.order = DIV_ROUND_UP(priv->dma_buf_sz, PAGE_SIZE);
+		num_pages = DIV_ROUND_UP(priv->dma_buf_sz, PAGE_SIZE);
+		pp_params.order = ilog2(num_pages);
 		pp_params.nid = dev_to_node(priv->device);
 		pp_params.dev = priv->device;
 		pp_params.dma_dir = DMA_FROM_DEVICE;
-- 
2.20.1

