Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CBBC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D057020835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625179;
	bh=vek708XiY9jinTBwmhYxGV6IqDP7VclEldcAHu22gA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cN6RaHYdSjGp3kkUSmyAufBYm0kXn3OXdQsGJq9zHmQnFPKStyYv/mCzclPGuEmh/
	 uzADzBwhTR2P/zrk+TgnbNVtVRnhNgGMAZAdxLaQG9UR4oUpOsJPCCK+iP750vxVXq
	 sLVBaACGZbfvPHTC8SSfJ0J771EUjO2dozfgHUEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbfD3LvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731341AbfD3LvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:51:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE76420449;
        Tue, 30 Apr 2019 11:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625069;
        bh=vek708XiY9jinTBwmhYxGV6IqDP7VclEldcAHu22gA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auu5QSDgz7vDfdbkQCFO1EoGZ/UuULiIwfb1ButX0JH2dFlL0YEf8FFi0QP3x1Ipb
         L4BwuxqNBFnf3K0Q2H672O6h8BBW7nbw7m96jos1WhG/n8f6IqhPb+mZjvADI8/teA
         OE5BKH8vE0YttJSxwnBbkjLNiD96ObWtCL+qgI+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaofei Shen <xiaofeis@codeaurora.org>,
        Sneh Shah <snehshah@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 78/89] net: stmmac: move stmmac_check_ether_addr() to driver probe
Date:   Tue, 30 Apr 2019 13:39:09 +0200
Message-Id: <20190430113613.428250383@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
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
@@ -2590,8 +2590,6 @@ static int stmmac_open(struct net_device
 	u32 chan;
 	int ret;
 
-	stmmac_check_ether_addr(priv);
-
 	if (priv->hw->pcs != STMMAC_PCS_RGMII &&
 	    priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI) {
@@ -4265,6 +4263,8 @@ int stmmac_dvr_probe(struct device *devi
 	if (ret)
 		goto error_hw_init;
 
+	stmmac_check_ether_addr(priv);
+
 	/* Configure real RX and TX queues */
 	netif_set_real_num_rx_queues(ndev, priv->plat->rx_queues_to_use);
 	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);


