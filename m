Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F2C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A49E21841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998803;
	bh=EbW4p5thQ4BtvWYbGbLsCmj3+vKyq2vk2u9gGj1OPsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sOw3PQbLBRDEz0bRR1OJyk5QNwjt4gU/wHyznRlccuGTbco5MTnUkJ+fNaPCeTkim
	 9DcV01R1b6koPak5/AMQxlvYYAy7cBSOmqY13zcyO0SI7wjJo+KO2/i8XePdYEZ/zi
	 /SD/wCMDqafBDDX/xJOcb73ZSt6E1qKTxysnaXk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392607AbfGXUFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405590AbfGXUE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:04:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE78721852;
        Wed, 24 Jul 2019 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998698;
        bh=EbW4p5thQ4BtvWYbGbLsCmj3+vKyq2vk2u9gGj1OPsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOuiljAM/fpbPDPypEtKWARPk5KzafeCv1q/buFBL/DfzDrFQ6Yk2zNR6SInu0P0y
         nxUczwjwIYGFIxA7Pfp4XATtSecnfwI2QmhHuT5/bf1WABN45cFixyJ1+toVU4t1dB
         iRah/7pGKTdjI33+i3Ifkl+nfzuTg0Bccl1bYzbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Biao Huang <biao.huang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/271] net: stmmac: dwmac4: fix flow control issue
Date:   Wed, 24 Jul 2019 21:18:34 +0200
Message-Id: <20190724191659.034623208@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ee326fd01e79dfa42014d55931260b68b9fa3273 ]

Current dwmac4_flow_ctrl will not clear
GMAC_RX_FLOW_CTRL_RFE/GMAC_RX_FLOW_CTRL_RFE bits,
so MAC hw will keep flow control on although expecting
flow control off by ethtool. Add codes to fix it.

Fixes: 477286b53f55 ("stmmac: add GMAC4 core support")
Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index a2f3db39221e..d0e6e1503581 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -475,8 +475,9 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 	if (fc & FLOW_RX) {
 		pr_debug("\tReceive Flow-Control ON\n");
 		flow |= GMAC_RX_FLOW_CTRL_RFE;
-		writel(flow, ioaddr + GMAC_RX_FLOW_CTRL);
 	}
+	writel(flow, ioaddr + GMAC_RX_FLOW_CTRL);
+
 	if (fc & FLOW_TX) {
 		pr_debug("\tTransmit Flow-Control ON\n");
 
@@ -484,7 +485,7 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 			pr_debug("\tduplex mode: PAUSE %d\n", pause_time);
 
 		for (queue = 0; queue < tx_cnt; queue++) {
-			flow |= GMAC_TX_FLOW_CTRL_TFE;
+			flow = GMAC_TX_FLOW_CTRL_TFE;
 
 			if (duplex)
 				flow |=
@@ -492,6 +493,9 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 
 			writel(flow, ioaddr + GMAC_QX_TX_FLOW_CTRL(queue));
 		}
+	} else {
+		for (queue = 0; queue < tx_cnt; queue++)
+			writel(0, ioaddr + GMAC_QX_TX_FLOW_CTRL(queue));
 	}
 }
 
-- 
2.20.1



