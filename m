Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B8EC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B772085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Gr39npG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfFZNsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:48:03 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:51182 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727890AbfFZNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:47:55 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C2CE1C0C4B;
        Wed, 26 Jun 2019 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561556874; bh=0bswUsADavcsJuPhrKYDpslb3LXvmrbbf7KafZXBVSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Gr39npG9OoiEpu/y+EBpp6chklbb22d8DRjysaVGD6avm8m+ft4AK3yj+UvEBfYCM
         Yk8Kg4xZ3nkLe4tQFNRnmqX7jnQV9Wx18TUY+YbMaZGlEl87TocaEbYe2jlD2JuxDw
         LsU0+TU1e0oeSXptUddiHui+cEgD/gyJkz69d2cIE1pcPCVn7M4WCtb4cbznS2NpGq
         TVtoOqW6C2GsDe47Ulk/1oGoajj1wuezj3N6Hwbamsi5oRuavZf8Uw03fmB0rK8s9T
         DSd73o4w98a4j4iX9+7MbzO/c40ld5mT+sJ/yKZndTpxdynmNpk0QWn1BHC9WweYKy
         hGFkqasrivJqQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 52568A0070;
        Wed, 26 Jun 2019 13:47:52 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 44F013B578;
        Wed, 26 Jun 2019 15:47:52 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 09/10] net: stmmac: Only disable interrupts if NAPI is scheduled
Date:   Wed, 26 Jun 2019 15:47:43 +0200
Message-Id: <372310483e674f14eb811c6e8c8355475496d520.1561556556.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561556555.git.joabreu@synopsys.com>
References: <cover.1561556555.git.joabreu@synopsys.com>
In-Reply-To: <cover.1561556555.git.joabreu@synopsys.com>
References: <cover.1561556555.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only disable the interrupts if RX NAPI gets to be scheduled. Also,
schedule the TX NAPI only when the interrupts are disabled.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0893af8b432d..bc949665c529 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2049,12 +2049,12 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan)
 						 &priv->xstats, chan);
 	struct stmmac_channel *ch = &priv->channel[chan];
 
-	if (status)
-		status |= handle_rx | handle_tx;
-
 	if ((status & handle_rx) && (chan < priv->plat->rx_queues_to_use)) {
-		stmmac_disable_dma_irq(priv, priv->ioaddr, chan);
-		napi_schedule_irqoff(&ch->rx_napi);
+		if (napi_schedule_prep(&ch->rx_napi)) {
+			stmmac_disable_dma_irq(priv, priv->ioaddr, chan);
+			__napi_schedule_irqoff(&ch->rx_napi);
+			status |= handle_tx;
+		}
 	}
 
 	if ((status & handle_tx) && (chan < priv->plat->tx_queues_to_use))
-- 
2.7.4

