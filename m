Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D95C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE8C217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428310;
	bh=tMEmiguX2xAF7coy7XsImyDwSDGVwzm2dbXTDCPnWGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hp3pqQfRaH4vJwMTMq65StuM+IZ3/evzhKTYDDPAWPWzjpzjBzDoRtcS0CqCuiR7i
	 15/7zjjsAFLPf8lavkFKnvPq4r414rsFqlzVR3VgF7U0UE/Ck5isl4/fcU7mRoD+KT
	 VtO/SPxxfOuADWtAklJWCwfmURKcOjombe3tw/mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfG2TZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbfG2TZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:25:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B467621655;
        Mon, 29 Jul 2019 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428304;
        bh=tMEmiguX2xAF7coy7XsImyDwSDGVwzm2dbXTDCPnWGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efrCiiCdOtKP4DMzPKpY+GlmYAUy1GJsfP1Y2vmxNmzJI5vpwrZlHKFy7RNtbx4C7
         OYf88+nAQHS1nCd9n5i/dMLiV5jXQV498qZo09NqP5ozqDhXjnpQcqn0Hjk5IEhGKf
         rtzouQoXkNihZnz4AFWM67uDKBiwFsZnRk+YArHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Biao Huang <biao.huang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 034/293] net: stmmac: dwmac4: fix flow control issue
Date:   Mon, 29 Jul 2019 21:18:45 +0200
Message-Id: <20190729190824.745579097@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
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
index ed5fcd4994f2..8445af580cb6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -474,8 +474,9 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 	if (fc & FLOW_RX) {
 		pr_debug("\tReceive Flow-Control ON\n");
 		flow |= GMAC_RX_FLOW_CTRL_RFE;
-		writel(flow, ioaddr + GMAC_RX_FLOW_CTRL);
 	}
+	writel(flow, ioaddr + GMAC_RX_FLOW_CTRL);
+
 	if (fc & FLOW_TX) {
 		pr_debug("\tTransmit Flow-Control ON\n");
 
@@ -483,7 +484,7 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 			pr_debug("\tduplex mode: PAUSE %d\n", pause_time);
 
 		for (queue = 0; queue < tx_cnt; queue++) {
-			flow |= GMAC_TX_FLOW_CTRL_TFE;
+			flow = GMAC_TX_FLOW_CTRL_TFE;
 
 			if (duplex)
 				flow |=
@@ -491,6 +492,9 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 
 			writel(flow, ioaddr + GMAC_QX_TX_FLOW_CTRL(queue));
 		}
+	} else {
+		for (queue = 0; queue < tx_cnt; queue++)
+			writel(0, ioaddr + GMAC_QX_TX_FLOW_CTRL(queue));
 	}
 }
 
-- 
2.20.1



