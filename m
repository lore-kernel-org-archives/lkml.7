Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D5CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B2E218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfDXJQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:16:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:1102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbfDXJQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:16:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 02:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="145260875"
Received: from wvoon-ilbpg2.png.intel.com ([10.88.227.88])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2019 02:16:36 -0700
From:   Weifeng Voon <weifeng.voon@intel.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Kweh Hock Leong <hock.leong.kweh@intel.com>,
        Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH 3/7] net: stmmac: dma channel control register need to be init first
Date:   Thu, 25 Apr 2019 01:17:17 +0800
Message-Id: <1556126241-2774-4-git-send-email-weifeng.voon@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stmmac_init_chan() needs to be called before stmmac_init_rx_chan() and
stmmac_init_tx_chan(). This is because if PBLx8 is to be used,
"DMA_CH(#i)_Control.PBLx8" needs to be set before programming
"DMA_CH(#i)_TX_Control.TxPBL" and "DMA_CH(#i)_RX_Control.RxPBL".

Reviewed-by: Zhang, Baoli <baoli.zhang@intel.com>
Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a26e36d..ec031e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2208,6 +2208,10 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	if (priv->plat->axi)
 		stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
 
+	/* DMA CSR Channel configuration */
+	for (chan = 0; chan < dma_csr_ch; chan++)
+		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
+
 	/* DMA RX Channel Configuration */
 	for (chan = 0; chan < rx_channels_count; chan++) {
 		rx_q = &priv->rx_queue[chan];
@@ -2233,10 +2237,6 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 				       tx_q->tx_tail_addr, chan);
 	}
 
-	/* DMA CSR Channel configuration */
-	for (chan = 0; chan < dma_csr_ch; chan++)
-		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
-
 	return ret;
 }
 
-- 
1.9.1

