Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFDCC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A592085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HWnBfV4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfFZNs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:48:28 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:51130 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727862AbfFZNry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:47:54 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B0139C0C1B;
        Wed, 26 Jun 2019 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561556874; bh=Dzik/Aq7Wvsuf8kvK5g9OnOXGNEAqsJoyUxn72f1pcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HWnBfV4bn9lRpvJvkCUiXOTNWCfnW3P30bGP2rP0siO8V5RAbU4/uO9EzH8iURf7J
         x389GcCYsmSbHlu9fI1zUgaL1cwJPx515ge14/ymnyN+kI5JsKIGWoQHHPUlhrlo1M
         vQA8Dr8D7IfOWZKtO72HWAiTCLylj8mgffz1VUpddShJMJrOLS5NLd57iXojnFi1+T
         LZVvz3snSPKCqgAJt9UaKPLzz89aNSXB8UGqPhbhjC8y2qY8JhNCZ6XK1pktTDbUSX
         HzGwkJlbojy7B0Oiu5PqZo8QHBtDUpP1vOdbLxgY9uiE5894Iem0S72NLtJEFjCRRK
         g0lTlKD97tghA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4E0F8A0073;
        Wed, 26 Jun 2019 13:47:52 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 341633B575;
        Wed, 26 Jun 2019 15:47:52 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 08/10] net: stmmac: Update RX Tail Pointer to last free entry
Date:   Wed, 26 Jun 2019 15:47:42 +0200
Message-Id: <2e6b1cc84ef7542155313435277915f82514aef3.1561556556.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561556555.git.joabreu@synopsys.com>
References: <cover.1561556555.git.joabreu@synopsys.com>
In-Reply-To: <cover.1561556555.git.joabreu@synopsys.com>
References: <cover.1561556555.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the RX Tail Pointer to the last available SKB entry.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 65ff2a2a15e4..0893af8b432d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3337,6 +3337,8 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		entry = STMMAC_GET_ENTRY(entry, DMA_RX_SIZE);
 	}
 	rx_q->dirty_rx = entry;
+	rx_q->rx_tail_addr = rx_q->dma_rx_phy +
+			    (rx_q->dirty_rx * sizeof(struct dma_desc));
 	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
 }
 
-- 
2.7.4

