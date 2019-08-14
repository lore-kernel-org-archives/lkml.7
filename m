Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8D8C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DB120665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565750019;
	bh=Fg9qBlNYXCEIfp3RG9RBM6a9WLIy4JmQQ2janLyud6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fzkxeU4MUUV4ymOSuD2b5yydpDdhoSJs1Xc7zew836n+QL6Efevm+9gMvFoDuK7gx
	 WShtIpTPY4ZVDMiQCyL+N225pRxSDkJg1hftUs1M51ETehnLAJK8oz0TjwT3sSeGB4
	 JnpEdPpHl9aYqBRmFQ+QUj/4vMdaMRCW2fUFm4bU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfHNCdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfHNCOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:14:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D48208C2;
        Wed, 14 Aug 2019 02:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748852;
        bh=Fg9qBlNYXCEIfp3RG9RBM6a9WLIy4JmQQ2janLyud6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAUzxsary2LwTzeK+6zPCIbyrGQCjcRuDbAl6d14LSX92ycvZsm5hFAtrshafFT/t
         /L4D+rIxboaTJrgRBWFSNP6XDOEd5DkaEjxiQRezr7o1es3DW2cVoGxOvEVq3yuPU8
         R0u9g9sOGyUvSaIVGX73D90fFfyCa/xIzLyLzYYY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 103/123] net: stmmac: Fix issues when number of Queues >= 4
Date:   Tue, 13 Aug 2019 22:10:27 -0400
Message-Id: <20190814021047.14828-103-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit e8df7e8c233a18d2704e37ecff47583b494789d3 ]

When queues >= 4 we use different registers but we were not subtracting
the offset of 4. Fix this.

Found out by Coverity.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c   | 4 ++++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index e3850938cf2f3..d7bf0ad954b8c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -85,6 +85,8 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
 	u32 value;
 
 	base_register = (queue < 4) ? GMAC_RXQ_CTRL2 : GMAC_RXQ_CTRL3;
+	if (queue >= 4)
+		queue -= 4;
 
 	value = readl(ioaddr + base_register);
 
@@ -102,6 +104,8 @@ static void dwmac4_tx_queue_priority(struct mac_device_info *hw,
 	u32 value;
 
 	base_register = (queue < 4) ? GMAC_TXQ_PRTY_MAP0 : GMAC_TXQ_PRTY_MAP1;
+	if (queue >= 4)
+		queue -= 4;
 
 	value = readl(ioaddr + base_register);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 64b8cb88ea45d..d4bd99770f5d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -106,6 +106,8 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 	u32 value, reg;
 
 	reg = (queue < 4) ? XGMAC_RXQ_CTRL2 : XGMAC_RXQ_CTRL3;
+	if (queue >= 4)
+		queue -= 4;
 
 	value = readl(ioaddr + reg);
 	value &= ~XGMAC_PSRQ(queue);
@@ -169,6 +171,8 @@ static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
 	u32 value, reg;
 
 	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
+	if (queue >= 4)
+		queue -= 4;
 
 	value = readl(ioaddr + reg);
 	value &= ~XGMAC_QxMDMACH(queue);
-- 
2.20.1

