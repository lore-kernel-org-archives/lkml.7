Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB503C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC4821900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116500;
	bh=OtmkAcgz7QVshY2ThtgYS97aaMTHqdPyX3yUnvlMWug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=brSVJCjAOTBKLU+rcYLSO9LdOgxJljZXFTq7UULnZc9oIfaodjgpw78pUYtxjabdo
	 M/Wq984cB3P0pwE6TK9IqSE9Dp/YdSN71D7ATci3UoSm04tYdItg6O4TTZJNO78ylp
	 xjIBvjGiRCkuIf9b0Owf3PZB2khY3XYBhlBBnj9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfDXOe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731153AbfDXOe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:34:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75BDD218FE;
        Wed, 24 Apr 2019 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116496;
        bh=OtmkAcgz7QVshY2ThtgYS97aaMTHqdPyX3yUnvlMWug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6pw4rTkHTqqY26BAZsgQ2E5EtcdMhHytaFXJAnSY24Lu8pduMAUr8KOawzpI3gVL
         l9RVD4T4qDoweuCPatKX0s411bUWzc/onlbD7hzvAFsscw4+aSDPKzPzA6Zc8SdvGk
         qe1eDIIldvUCc/0NyrSjhoz3cmvE5q29parqYuqQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 29/66] net: stmmac: don't stop NAPI processing when dropping a packet
Date:   Wed, 24 Apr 2019 10:33:03 -0400
Message-Id: <20190424143341.27665-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

[ Upstream commit 07b3975352374c3f5ebb4a42ef0b253fe370542d ]

Currently, if we drop a packet, we exit from NAPI loop before the budget
is consumed. In some situations this will make the RX processing stall
e.g. when flood pinging the system with oversized packets, as the
errorneous packets are not dropped efficiently.

If we drop a packet, we should just continue to the next one as long as
the budget allows.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e41136d57bfa..ca36f05de476 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3328,9 +3328,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
-	unsigned int entry = rx_q->cur_rx;
+	unsigned int next_entry = rx_q->cur_rx;
 	int coe = priv->hw->rx_csum;
-	unsigned int next_entry;
 	unsigned int count = 0;
 	bool xmac;
 
@@ -3348,10 +3347,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -3412,7 +3413,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 						   "len %d larger than size (%d)\n",
 						   frame_len, priv->dma_buf_sz);
 				priv->dev->stats.rx_length_errors++;
-				break;
+				continue;
 			}
 
 			/* ACS is set; GMAC core strips PAD/FCS for IEEE 802.3
@@ -3447,7 +3448,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 						dev_warn(priv->device,
 							 "packet dropped\n");
 					priv->dev->stats.rx_dropped++;
-					break;
+					continue;
 				}
 
 				dma_sync_single_for_cpu(priv->device,
@@ -3472,7 +3473,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 							   "%s: Inconsistent Rx chain\n",
 							   priv->dev->name);
 					priv->dev->stats.rx_dropped++;
-					break;
+					continue;
 				}
 				prefetch(skb->data - NET_IP_ALIGN);
 				rx_q->rx_skbuff[entry] = NULL;
@@ -3507,7 +3508,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			priv->dev->stats.rx_packets++;
 			priv->dev->stats.rx_bytes += frame_len;
 		}
-		entry = next_entry;
 	}
 
 	stmmac_rx_refill(priv, queue);
-- 
2.19.1

