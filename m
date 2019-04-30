Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D277C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AB52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625468;
	bh=24vZY+O6/y4ek2Var+3vq0gwG+F89pdG9TfVxl0hlnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TULxUEP5YphwqQwLfdMollmDNswpRRR0gdwCDSYui6cBp0/mHftFnvIiQWntiW2EO
	 brtzD3MMYmLqgEcufjwNYuxFPLL3cq4bGXMQhVv3FnvadexbSBP93X61wFCzuqclea
	 GKSzSNPHXX1R50ZMtf0WNyADqE/ZtzFkE8dcDYvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfD3L5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbfD3Lrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:47:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62BE2054F;
        Tue, 30 Apr 2019 11:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624865;
        bh=24vZY+O6/y4ek2Var+3vq0gwG+F89pdG9TfVxl0hlnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWCGOzofspvmEYZgpBK4LbW1WNNUKn/nNg8ZdjYM5b9R6mTsE6LSIOwNXDbZJtM65
         zsVe4oNkxm55hfKpHp6ZwRM0UkNlqLo/+F/dMNkcJP/wFBOMo5S2pLLjh/r860keM7
         BpfpDtG/pUUtXApQTgA3jrOIDlmSknHBKrva649c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaofei Shen <xiaofeis@codeaurora.org>,
        Sneh Shah <snehshah@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 090/100] net: stmmac: move stmmac_check_ether_addr() to driver probe
Date:   Tue, 30 Apr 2019 13:38:59 +0200
Message-Id: <20190430113613.062637557@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit b561af36b1841088552464cdc3f6371d92f17710 ]

stmmac_check_ether_addr() checks the MAC address and assigns one in
driver open(). In many cases when we create slave netdevice, the dev
addr is inherited from master but the master dev addr maybe NULL at
that time, so move this call to driver probe so that address is
always valid.

Signed-off-by: Xiaofei Shen <xiaofeis@codeaurora.org>
Tested-by: Xiaofei Shen <xiaofeis@codeaurora.org>
Signed-off-by: Sneh Shah <snehshah@codeaurora.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2595,8 +2595,6 @@ static int stmmac_open(struct net_device
 	u32 chan;
 	int ret;
 
-	stmmac_check_ether_addr(priv);
-
 	if (priv->hw->pcs != STMMAC_PCS_RGMII &&
 	    priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI) {
@@ -4296,6 +4294,8 @@ int stmmac_dvr_probe(struct device *devi
 	if (ret)
 		goto error_hw_init;
 
+	stmmac_check_ether_addr(priv);
+
 	/* Configure real RX and TX queues */
 	netif_set_real_num_rx_queues(ndev, priv->plat->rx_queues_to_use);
 	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);


