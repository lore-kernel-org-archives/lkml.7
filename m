Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835022054F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfC0Ufz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:35:55 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:55282 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfC0Ufx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:35:53 -0400
Received: from localhost.localdomain (85-76-9-223-nat.elisa-mobile.fi [85.76.9.223])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id AA78C30096;
        Wed, 27 Mar 2019 22:35:50 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "David S. Miller" <davem@davemloft.net>,
        Jose Abreu <joabreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 3/6] net: stmmac: don't stop NAPI processing when dropping a packet
Date:   Wed, 27 Mar 2019 22:35:37 +0200
Message-Id: <20190327203540.1884-4-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190327203540.1884-1-aaro.koskinen@iki.fi>
References: <20190327203540.1884-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

Currently, if we drop a packet, we exit from NAPI loop before the budget
is consumed. In some situations this will make the RX processing stall
e.g. when flood pinging the system with oversized packets, as the
errorneous packets are not dropped efficiently.

If we drop a packet, we should just continue to the next one as long as
the budget allows.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 392d94cede17..a26e36dbb5df 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3354,9 +3354,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
-	unsigned int entry = rx_q->cur_rx;
+	unsigned int next_entry = rx_q->cur_rx;
 	int coe = priv->hw->rx_csum;
-	unsigned int next_entry;
 	unsigned int count = 0;
 	bool xmac;
 
@@ -3374,10 +3373,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, DMA_RX_SIZE, true);
 	}
 	while (count < limit) {
-		int status;
+		int entry, status;
 		struct dma_desc *p;
 		struct dma_desc *np;
 
+		entry = next_entry;
+
 		if (priv->extend_desc)
 			p = (struct dma_desc *)(rx_q->dma_erx + entry);
 		else
@@ -3438,7 +3439,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 						   "len %d larger than size (%d)\n",
 						   frame_len, priv->dma_buf_sz);
 				priv->dev->stats.rx_length_errors++;
-				break;
+				continue;
 			}
 
 			/* ACS is set; GMAC core strips PAD/FCS for IEEE 802.3
@@ -3473,7 +3474,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 						dev_warn(priv->device,
 							 "packet dropped\n");
 					priv->dev->stats.rx_dropped++;
-					break;
+					continue;
 				}
 
 				dma_sync_single_for_cpu(priv->device,
@@ -3498,7 +3499,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 							   "%s: Inconsistent Rx chain\n",
 							   priv->dev->name);
 					priv->dev->stats.rx_dropped++;
-					break;
+					continue;
 				}
 				prefetch(skb->data - NET_IP_ALIGN);
 				rx_q->rx_skbuff[entry] = NULL;
@@ -3533,7 +3534,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			priv->dev->stats.rx_packets++;
 			priv->dev->stats.rx_bytes += frame_len;
 		}
-		entry = next_entry;
 	}
 
 	stmmac_rx_refill(priv, queue);
-- 
2.17.0

