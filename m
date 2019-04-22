Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96734C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CB42064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963892;
	bh=ttAwlyAQyLLsypH6iu/cUvStcyL3N8ctnb3+mlKWLww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WX4BlQG23/0HSMnnSQCfqd9nUrTdys4XW9z3yk/AeQSdFvFTI+jJq53Fw+B923F2B
	 AUsxPQDpTHgGaf9uu2uxC0p1GDBE14R45fCe2fSoLVfnrOH4BwkIOk//zN+ILBX9Ys
	 /kfFmrWMjhlaYji24WFY/RAS6vMIdPXeTgd52e/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfDVULb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbfDVTmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9989F2177B;
        Mon, 22 Apr 2019 19:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962135;
        bh=ttAwlyAQyLLsypH6iu/cUvStcyL3N8ctnb3+mlKWLww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeMKnD7gPFV7kW+WY5nGoLl8yGMwtXF1m+rW7+GmEkhGGmtm8xd52mzZDok2AQvIw
         gU5sVgTdKFyxedWSSjr/hobz2Ww+JfVV5DamGhJPE3U9G4Ez05m0N7IZ6JRIXaXIqQ
         6RP2G1VIsmaI62gTKzSgbcd6XUNTaV2zy4jLOtwI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 10/98] net: stmmac: don't set own bit too early for jumbo frames
Date:   Mon, 22 Apr 2019 15:40:37 -0400
Message-Id: <20190422194205.10404-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

[ Upstream commit 80acbed9f8fca1db3fbe915540b756f048aa0fd7 ]

Commit 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit
routine") overlooked jumbo frames when re-ordering the code, and as a
result the own bit was not getting set anymore for the first jumbo frame
descriptor. Commit 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo
frames") tried to fix this, but now the bit is getting set too early and
the DMA may start while we are still setting up the remaining descriptors.
And with the chain mode the own bit remains still unset.

Fix by setting the own bit at the end of xmit also with jumbo frames.

Fixes: 0e80bdc9a72d ("stmmac: first frame prep at the end of xmit routine")
Fixes: 487e2e22ab79 ("net: stmmac: Set OWN bit for jumbo frames")
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Acked-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c   |  4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index c0c75c111abb..afed0f0f4027 100644
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
index 019ab99e65bb..ff7751f6e828 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3192,14 +3192,16 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
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
2.19.1

