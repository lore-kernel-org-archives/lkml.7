Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55811C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2462A21D7B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354007;
	bh=M2yOs9afGDUJ0xsdPlqgFgcEldyZBxj7OSIeQV5vXzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uETNRuJl9mng0vnP3ksm8WdB63X3WZcQGJTDlu2yH5k5P5Ib7i/OuenZ9EFrLEso5
	 id5LSLZ5FpLLO91s/54MKhMbmqNY81OsEQ5APSUxYDX1AWUBQMoQIcrtdpMbef8MHf
	 SpAroDItJ/NhoV9koYPTf/edbIWMBW+0HKr/LQaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfKJCqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:46:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbfKJCqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:46:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F9921D7B;
        Sun, 10 Nov 2019 02:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353999;
        bh=M2yOs9afGDUJ0xsdPlqgFgcEldyZBxj7OSIeQV5vXzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKiSNBvON/KoaRUDXSXLG0jsSns5/kItb6qAPZiWeKuDVTMu0m9IP5TXDkXXTF3o8
         WG0DaGivbu3BYDcgKlmUr1DR2VPXFDMytKJ/rj1F09sVUWX8xI9lvBHrghcPMk4xnZ
         4lxkBOjQhiseB1WMi+4myAP4TUzEaluVChLthgH8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 026/109] nfp: provide a better warning when ring allocation fails
Date:   Sat,  9 Nov 2019 21:44:18 -0500
Message-Id: <20191110024541.31567-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 23d9f5531c7c28546954b0bf332134a9b8a38c0a ]

NFP supports fairly enormous ring sizes (up to 256k descriptors).
In commit 466271703867 ("nfp: use kvcalloc() to allocate SW buffer
descriptor arrays") we have started using kvcalloc() functions to
make sure the allocation of software state arrays doesn't hit
the MAX_ORDER limit.  Unfortunately, we can't use virtual mappings
for the DMA region holding HW descriptors.  In case this allocation
fails instead of the generic (and fairly scary) warning/splat in
the logs print a helpful message explaining what happened and
suggesting how to fix it.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/netronome/nfp/nfp_net_common.c  | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 6df2c8b2ce6f3..bffa25d6dc294 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2169,9 +2169,13 @@ nfp_net_tx_ring_alloc(struct nfp_net_dp *dp, struct nfp_net_tx_ring *tx_ring)
 
 	tx_ring->size = sizeof(*tx_ring->txds) * tx_ring->cnt;
 	tx_ring->txds = dma_zalloc_coherent(dp->dev, tx_ring->size,
-					    &tx_ring->dma, GFP_KERNEL);
-	if (!tx_ring->txds)
+					    &tx_ring->dma,
+					    GFP_KERNEL | __GFP_NOWARN);
+	if (!tx_ring->txds) {
+		netdev_warn(dp->netdev, "failed to allocate TX descriptor ring memory, requested descriptor count: %d, consider lowering descriptor count\n",
+			    tx_ring->cnt);
 		goto err_alloc;
+	}
 
 	sz = sizeof(*tx_ring->txbufs) * tx_ring->cnt;
 	tx_ring->txbufs = kzalloc(sz, GFP_KERNEL);
@@ -2314,9 +2318,13 @@ nfp_net_rx_ring_alloc(struct nfp_net_dp *dp, struct nfp_net_rx_ring *rx_ring)
 	rx_ring->cnt = dp->rxd_cnt;
 	rx_ring->size = sizeof(*rx_ring->rxds) * rx_ring->cnt;
 	rx_ring->rxds = dma_zalloc_coherent(dp->dev, rx_ring->size,
-					    &rx_ring->dma, GFP_KERNEL);
-	if (!rx_ring->rxds)
+					    &rx_ring->dma,
+					    GFP_KERNEL | __GFP_NOWARN);
+	if (!rx_ring->rxds) {
+		netdev_warn(dp->netdev, "failed to allocate RX descriptor ring memory, requested descriptor count: %d, consider lowering descriptor count\n",
+			    rx_ring->cnt);
 		goto err_alloc;
+	}
 
 	sz = sizeof(*rx_ring->rxbufs) * rx_ring->cnt;
 	rx_ring->rxbufs = kzalloc(sz, GFP_KERNEL);
-- 
2.20.1

