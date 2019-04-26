Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D82C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD09120684
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="E+1Smtdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDZHlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:41:32 -0400
Received: from first.geanix.com ([116.203.34.67]:59626 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfDZHkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:40:07 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 0DD62308E70;
        Fri, 26 Apr 2019 07:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556263932; bh=TK/ovJaRB6WOs+l7w73epKrR+MKWBf/YJtJBLWqeuDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E+1Smtdl1Tqa83KSS0UEZET0PJ+U2ujB+mZGxCGaWitZ/pTBkhj956tV0GGUkTV4B
         k4DKssretsDtnxEODb2eHwFFxodL7dOMUdTQtaeu1pcCM9AD/2lY6biw+N0N224RZP
         OvzyCb/OB+SeT9HiJWZ48Sm4VErWrGeAYhcGJzdtSuHn29VnMq5AFimOpnyrVb/3Lz
         iAkFIfp/J1VbnuKAHIqsK//wswTw5xi5bpSXN6LlqT/vcrjKbzWGJcPzXMXtvX5urp
         J5UUm8Xne0KjN7WNGGr41xwEKf467fYlz9AuCzAIvFbLRVkhzCsWJndX4+WnKoYJ46
         nP+XNsFfqLlgg==
From:   Esben Haabendal <esben@geanix.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Yang Wei <yang.wei9@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] net: ll_temac: Enable DMA when ready, not before
Date:   Fri, 26 Apr 2019 09:32:31 +0200
Message-Id: <20190426073231.4008-13-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426073231.4008-1-esben@geanix.com>
References: <20190426073231.4008-1-esben@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As soon as TAILDESCR_PTR is written, DMA transfers might start.
Let's ensure we are ready to receive DMA IRQ's before doing that.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index a30ac11..b8e3dbd 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -316,17 +316,21 @@ static int temac_dma_bd_init(struct net_device *ndev)
 		    CHNL_CTRL_IRQ_EN | CHNL_CTRL_IRQ_ERR_EN |
 		    CHNL_CTRL_IRQ_DLY_EN | CHNL_CTRL_IRQ_COAL_EN);
 
-	lp->dma_out(lp, RX_CURDESC_PTR,  lp->rx_bd_p);
-	lp->dma_out(lp, RX_TAILDESC_PTR,
-		       lp->rx_bd_p + (sizeof(*lp->rx_bd_v) * (RX_BD_NUM - 1)));
-	lp->dma_out(lp, TX_CURDESC_PTR, lp->tx_bd_p);
-
 	/* Init descriptor indexes */
 	lp->tx_bd_ci = 0;
 	lp->tx_bd_next = 0;
 	lp->tx_bd_tail = 0;
 	lp->rx_bd_ci = 0;
 
+	/* Enable RX DMA transfers */
+	wmb();
+	lp->dma_out(lp, RX_CURDESC_PTR,  lp->rx_bd_p);
+	lp->dma_out(lp, RX_TAILDESC_PTR,
+		       lp->rx_bd_p + (sizeof(*lp->rx_bd_v) * (RX_BD_NUM - 1)));
+
+	/* Prepare for TX DMA transfer */
+	lp->dma_out(lp, TX_CURDESC_PTR, lp->tx_bd_p);
+
 	return 0;
 
 out:
@@ -790,6 +794,7 @@ temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	skb_tx_timestamp(skb);
 
 	/* Kick off the transfer */
+	wmb();
 	lp->dma_out(lp, TX_TAILDESC_PTR, tail_p); /* DMA start */
 
 	return NETDEV_TX_OK;
-- 
2.4.11

