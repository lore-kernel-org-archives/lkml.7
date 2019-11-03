Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A5CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 10:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C9A2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 10:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfKCKfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 05:35:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:56866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727156AbfKCKfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 05:35:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C42FB114;
        Sun,  3 Nov 2019 10:35:04 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [net v2 2/4] net: sgi: ioc3-eth: fix usage of GFP_* flags
Date:   Sun,  3 Nov 2019 11:34:31 +0100
Message-Id: <20191103103433.26826-2-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191103103433.26826-1-tbogendoerfer@suse.de>
References: <20191103103433.26826-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

dma_alloc_coherent always zeroes memory, there is no need for
__GFP_ZERO.  Also doing a GFP_ATOMIC allocation just before a GFP_KERNEL
one is clearly bogus.

Fixes: ed870f6a7aa2 ("net: sgi: ioc3-eth: use dma-direct for dma allocations")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 4879dedf1f60..d1546f04d1fd 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1244,7 +1244,7 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Allocate rx ring.  4kb = 512 entries, must be 4kb aligned */
 	ip->rxr = dma_alloc_coherent(ip->dma_dev, RX_RING_SIZE, &ip->rxr_dma,
-				     GFP_ATOMIC);
+				     GFP_KERNEL);
 	if (!ip->rxr) {
 		pr_err("ioc3-eth: rx ring allocation failed\n");
 		err = -ENOMEM;
@@ -1253,7 +1253,7 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Allocate tx rings.  16kb = 128 bufs, must be 16kb aligned  */
 	ip->tx_ring = dma_alloc_coherent(ip->dma_dev, TX_RING_SIZE + SZ_16K - 1,
-					 &ip->txr_dma, GFP_KERNEL | __GFP_ZERO);
+					 &ip->txr_dma, GFP_KERNEL);
 	if (!ip->tx_ring) {
 		pr_err("ioc3-eth: tx ring allocation failed\n");
 		err = -ENOMEM;
-- 
2.16.4

