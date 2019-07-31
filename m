Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF225C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA6120693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfGaHin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:38:43 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:26934 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726248AbfGaHin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:38:43 -0400
Received: from localhost.localdomain ([176.167.166.146])
        by mwinf5d75 with ME
        id jKec2000i39qjAg03KedzC; Wed, 31 Jul 2019 09:38:39 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 31 Jul 2019 09:38:39 +0200
X-ME-IP: 176.167.166.146
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mark.einon@gmail.com, davem@davemloft.net, willy@infradead.org,
        f.fainelli@gmail.com, andrew@lunn.ch
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net: ethernet: et131x: Use GFP_KERNEL instead of GFP_ATOMIC when allocating tx_ring->tcb_ring
Date:   Wed, 31 Jul 2019 09:38:42 +0200
Message-Id: <20190731073842.16948-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no good reason to use GFP_ATOMIC here. Other memory allocations
are performed with GFP_KERNEL (see other 'dma_alloc_coherent()' below and
'kzalloc()' in 'et131x_rx_dma_memory_alloc()')

Use GFP_KERNEL which should be enough.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/agere/et131x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index e43d922f043e..174344c450af 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -2362,7 +2362,7 @@ static int et131x_tx_dma_memory_alloc(struct et131x_adapter *adapter)
 
 	/* Allocate memory for the TCB's (Transmit Control Block) */
 	tx_ring->tcb_ring = kcalloc(NUM_TCB, sizeof(struct tcb),
-				    GFP_ATOMIC | GFP_DMA);
+				    GFP_KERNEL | GFP_DMA);
 	if (!tx_ring->tcb_ring)
 		return -ENOMEM;
 
-- 
2.20.1

