Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46EAC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888EE2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jB3rOPkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfF1H3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:29:36 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:47978 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726443AbfF1H3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:29:25 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1C678C0BEB;
        Fri, 28 Jun 2019 07:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561706965; bh=lSv38C31yEJl7yfJG0Wjzez19Yarlphyf7vprqOVAos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=jB3rOPkh/NOlpHiABbQvM45dZvKSwX2PmAG/HRVWcxOA0kSW+WhDCQkKxzQsC4XOw
         AU/NjzyWnoI0S4no3+v4p5Ac+WqS8JcWJUr8CTIcGx+ZeZEj/EO3obxMx3qqDtmFCs
         bA72CMaCwHZrqVFlg2KrFHybL6PdHlVL9nzzWU7dakvxHgFN2FKL5G7TmqIx0wSp1F
         KUdAQOE6zo13Fa3yRH1ziK7bf7aB9/wAUVzGaNsbuWC9/pvtvpNGj29lcptgNhozSE
         xRFFyCoLfoCxwQ3xNt3Q4gvkLA65V49+U29vLKajavccRnPZf2IzplSgtRoQgnyrjG
         JfE4caYIFzliQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id BF08CA0239;
        Fri, 28 Jun 2019 07:29:23 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id B03F53E961;
        Fri, 28 Jun 2019 09:29:23 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next v2 06/10] net: stmmac: Do not disable interrupts when cleaning TX
Date:   Fri, 28 Jun 2019 09:29:17 +0200
Message-Id: <e4e9ee4cb9c3e7957fe0a09f88b20bc011e2bd4c.1561706801.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561706800.git.joabreu@synopsys.com>
References: <cover.1561706800.git.joabreu@synopsys.com>
In-Reply-To: <cover.1561706800.git.joabreu@synopsys.com>
References: <cover.1561706800.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a performance killer and anyways the interrupts are being
disabled by RX NAPI so no need to disable them again.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4a5941caaadc..e8f3e76889c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2061,10 +2061,8 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan)
 		napi_schedule_irqoff(&ch->rx_napi);
 	}
 
-	if ((status & handle_tx) && (chan < priv->plat->tx_queues_to_use)) {
-		stmmac_disable_dma_irq(priv, priv->ioaddr, chan);
+	if ((status & handle_tx) && (chan < priv->plat->tx_queues_to_use))
 		napi_schedule_irqoff(&ch->tx_napi);
-	}
 
 	return status;
 }
@@ -3570,8 +3568,8 @@ static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
 	work_done = stmmac_tx_clean(priv, DMA_TX_SIZE, chan);
 	work_done = min(work_done, budget);
 
-	if (work_done < budget && napi_complete_done(napi, work_done))
-		stmmac_enable_dma_irq(priv, priv->ioaddr, chan);
+	if (work_done < budget)
+		napi_complete_done(napi, work_done);
 
 	/* Force transmission restart */
 	tx_q = &priv->tx_queue[chan];
-- 
2.7.4

