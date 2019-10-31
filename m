Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97AACA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7EB21734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K/aKKSqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfJaLBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:01:48 -0400
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:59448 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbfJaLBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:01:04 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A9D25C08B4;
        Thu, 31 Oct 2019 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1572519662; bh=wQtrPv+GIGZu+Tp6DHyLxgJSIlQY5yW+McFB8EMBWDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=K/aKKSqtUKMUPsRWVnHHIm2YegPgnrOvZJEXFBuVYB3VfFvDtR5DmRkE/4sHx8dYn
         8UCcbjSiKuPTW28gEwgPMHiEZSLHYu0BkDpYE/wUBUZ4Yr2rET0tlekHTlmKDFML7P
         fs5Y9EN+E240v3Jh6QwpMNk06hiBycl1qC6Dl++9vV4lpxxMRDRrKLlfL93nLyTC27
         9WbGslZnYlzYLplmyuPhU3Qe7cNIsEVpV2pjuJ2fEKyqqxEfzFBecdnMOHJJyCtOH8
         uQnLn4xVptxRBgKTF1qXPaehvXxQx6+EMszS5opgyfDjZ+Dlr3FKS4Q8qY9Sv521ZL
         0GtzrIWbODuEA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6D854A0087;
        Thu, 31 Oct 2019 11:01:00 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 10/10] net: stmmac: Fix the packet count in stmmac_rx()
Date:   Thu, 31 Oct 2019 12:00:48 +0100
Message-Id: <fca9407d676529289866358f5f57656138ef039e.1572519070.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1572519070.git.Jose.Abreu@synopsys.com>
References: <cover.1572519070.git.Jose.Abreu@synopsys.com>
In-Reply-To: <cover.1572519070.git.Jose.Abreu@synopsys.com>
References: <cover.1572519070.git.Jose.Abreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, stmmac_rx() is counting the number of descriptors but it
should count the number of packets as specified by the NAPI limit.

Fix this.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>

---
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 063b0ecd244b..d3886d2b16d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3505,8 +3505,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (unlikely(status & dma_own))
 			break;
 
-		count++;
-
 		rx_q->cur_rx = STMMAC_GET_ENTRY(rx_q->cur_rx, DMA_RX_SIZE);
 		next_entry = rx_q->cur_rx;
 
@@ -3533,6 +3531,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			goto read_again;
 		if (unlikely(error)) {
 			dev_kfree_skb(skb);
+			count++;
 			continue;
 		}
 
@@ -3572,6 +3571,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			skb = napi_alloc_skb(&ch->rx_napi, len);
 			if (!skb) {
 				priv->dev->stats.rx_dropped++;
+				count++;
 				continue;
 			}
 
@@ -3637,6 +3637,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		priv->dev->stats.rx_packets++;
 		priv->dev->stats.rx_bytes += len;
+		count++;
 	}
 
 	if (status & rx_not_ls) {
-- 
2.7.4

