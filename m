Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E4C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992042186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbfCNTpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:45:36 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:53208 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfCNTpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 15:45:34 -0400
Received: from localhost.localdomain (85-76-115-153-nat.elisa-mobile.fi [85.76.115.153])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 8A22D2005F;
        Thu, 14 Mar 2019 21:45:30 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 1/2] net: stmmac: don't set own bit too early for jumbo frames
Date:   Thu, 14 Mar 2019 21:43:19 +0200
Message-Id: <20190314194320.25566-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

Commit 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit
routine") overlooked jumbo frames when re-ordering the code, and as a
result the own bit was not getting set anymore for the first jumbo frame
descriptor. Commit 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo
frames") tried to fix this, but now the bit is getting set too early and
the DMA may start while we are still setting up the remaing descriptors.
And with the chain mode the own bit remains still unset.

Fix by setting the own bit at the end of xmit also with jumbo frames.

Fixes: 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit routine")
Fixes: 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo frames")
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c   |  4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index d8c5bc412219..bc83ced94e1b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -59,7 +59,7 @@ static int jumbo_frm(void *p, struct sk_buff *skb, int csum)
 
 		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum,
-				STMMAC_RING_MODE, 1, false, skb->len);
+				STMMAC_RING_MODE, 0, false, skb->len);
 		tx_q->tx_skbuff[entry] = NULL;
 		entry = STMMAC_GET_ENTRY(entry, DMA_TX_SIZE);
 
@@ -91,7 +91,7 @@ static int jumbo_frm(void *p, struct sk_buff *skb, int csum)
 		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
 		desc->des3 = cpu_to_le32(des2 + BUF_SIZE_4KiB);
 		stmmac_prepare_tx_desc(priv, desc, 1, nopaged_len, csum,
-				STMMAC_RING_MODE, 1, true, skb->len);
+				STMMAC_RING_MODE, 0, true, skb->len);
 	}
 
 	tx_q->cur_tx = entry;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 97c5e1aad88f..6a2e1031a62a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3216,14 +3216,16 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		stmmac_prepare_tx_desc(priv, first, 1, nopaged_len,
 				csum_insertion, priv->mode, 1, last_segment,
 				skb->len);
-
-		/* The own bit must be the latest setting done when prepare the
-		 * descriptor and then barrier is needed to make sure that
-		 * all is coherent before granting the DMA engine.
-		 */
-		wmb();
+	} else {
+		stmmac_set_tx_owner(priv, first);
 	}
 
+	/* The own bit must be the latest setting done when prepare the
+	 * descriptor and then barrier is needed to make sure that
+	 * all is coherent before granting the DMA engine.
+	 */
+	wmb();
+
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr);
-- 
2.17.0

