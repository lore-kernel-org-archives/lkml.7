Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0ADC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A162064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414551;
	bh=Aozy7mvmIKkmP6PcJtF3CLj0u5npcPm8oxfNLsn1C1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xZE5BcXaX70dV3zTBo2PeG4UeYtbv3Kjnd229dWCGUJoMDpNUwRSeMLH73g5DUvZ2
	 BnTF6/pnu9y3uCzDoscxudUOTwAmzyb68WkaVqvxEdJZeW+dz2KV7kAbL7+rUDNnb9
	 c3j37g3svPTNx1sgZIqsMnsVMI7cpZMeRak678AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfLCXJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfLCWom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:44:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E317C207DD;
        Tue,  3 Dec 2019 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413081;
        bh=Aozy7mvmIKkmP6PcJtF3CLj0u5npcPm8oxfNLsn1C1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=186DrpfJcb2ADntaazIjqhd0IoWHAloUo6M/wCM3G4dOC1bLVkXiGgKOd0AYLqz7G
         yaHGbXofJci54v4ZgKymxsFK/Mux67lRG5KsVDL72/6S23wlzER9ltIpNX2vfLoInC
         C/95aiwrP/aN5qY2vDLyyL1SNvhZgyJqkhAYQAdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 087/135] net: stmmac: xgmac: Disable Flow Control when 1 or more queues are in AV
Date:   Tue,  3 Dec 2019 23:35:27 +0100
Message-Id: <20191203213034.577291467@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 132f2f20c9866325d12c155aca06d260f358d3cb ]

When in AVB mode we need to disable flow control to prevent MAC from
pausing in TX side.

Fixes: ec6ea8e3eee9 ("net: stmmac: Add CBS support in XGMAC2")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index a4f236e3593e7..28dc3b33606e1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -441,6 +441,7 @@ static void dwxgmac2_enable_tso(void __iomem *ioaddr, bool en, u32 chan)
 static void dwxgmac2_qmode(void __iomem *ioaddr, u32 channel, u8 qmode)
 {
 	u32 value = readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(channel));
+	u32 flow = readl(ioaddr + XGMAC_RX_FLOW_CTRL);
 
 	value &= ~XGMAC_TXQEN;
 	if (qmode != MTL_QUEUE_AVB) {
@@ -448,6 +449,7 @@ static void dwxgmac2_qmode(void __iomem *ioaddr, u32 channel, u8 qmode)
 		writel(0, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(channel));
 	} else {
 		value |= 0x1 << XGMAC_TXQEN_SHIFT;
+		writel(flow & (~XGMAC_RFE), ioaddr + XGMAC_RX_FLOW_CTRL);
 	}
 
 	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(channel));
-- 
2.20.1



