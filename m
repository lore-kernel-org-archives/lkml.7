Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A48DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3D8218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfDXJQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:16:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:1102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfDXJQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:16:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 02:16:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="145260862"
Received: from wvoon-ilbpg2.png.intel.com ([10.88.227.88])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2019 02:16:31 -0700
From:   Weifeng Voon <weifeng.voon@intel.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Kweh Hock Leong <hock.leong.kweh@intel.com>,
        Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH 1/7] net: stmmac: add EHL SGMII 1Gbps platform data and PCI ID
Date:   Thu, 25 Apr 2019 01:17:15 +0800
Message-Id: <1556126241-2774-2-git-send-email-weifeng.voon@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added EHL SGMII 1Gbps PCI ID. Different MII and speed will have
different PCI ID.
For EHL, default TX and RX FIFO size is set to 32KB. This is
because the FIFO size advertised in the HW features is not the
same as the HW implementation. The TX FIFO is shared among all
all the TX queues and the RX FIFO is also shared among all the
RX queues.

Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 103 +++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index d819e8e..b454a97 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -118,6 +118,107 @@ static int stmmac_default_data(struct pci_dev *pdev,
 	.setup = stmmac_default_data,
 };
 
+static int ehl_common_data(struct pci_dev *pdev,
+			   struct plat_stmmacenet_data *plat)
+{
+	int i;
+
+	plat->bus_id = 1;
+	plat->phy_addr = 0;
+	plat->clk_csr = 5;
+	plat->has_gmac = 0;
+	plat->has_gmac4 = 1;
+	plat->force_sf_dma_mode = 0;
+	plat->tso_en = 1;
+
+	plat->rx_queues_to_use = 8;
+	plat->tx_queues_to_use = 8;
+	plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
+
+	for (i = 0; i < plat->rx_queues_to_use; i++) {
+		plat->rx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
+		plat->rx_queues_cfg[i].chan = i;
+
+		/* Disable Priority config by default */
+		plat->tx_queues_cfg[i].use_prio = false;
+
+		/* Disable RX queues routing by default */
+		plat->rx_queues_cfg[i].pkt_route = 0x0;
+	}
+
+	for (i = 0; i < plat->tx_queues_to_use; i++) {
+		plat->tx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
+
+		/* Disable Priority config by default */
+		plat->tx_queues_cfg[i].use_prio = false;
+	}
+
+	plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;
+	plat->tx_queues_cfg[0].weight = 0x09;
+	plat->tx_queues_cfg[1].weight = 0x0A;
+	plat->tx_queues_cfg[2].weight = 0x0B;
+	plat->tx_queues_cfg[3].weight = 0x0C;
+	plat->tx_queues_cfg[4].weight = 0x0D;
+	plat->tx_queues_cfg[5].weight = 0x0E;
+	plat->tx_queues_cfg[6].weight = 0x0F;
+	plat->tx_queues_cfg[7].weight = 0x10;
+
+	plat->mdio_bus_data->phy_reset = NULL;
+	plat->mdio_bus_data->phy_mask = 0;
+
+	plat->dma_cfg->pbl = 32;
+	plat->dma_cfg->pblx8 = true;
+	plat->dma_cfg->fixed_burst = 0;
+	plat->dma_cfg->mixed_burst = 0;
+	plat->dma_cfg->aal = 0;
+
+	plat->axi = devm_kzalloc(&pdev->dev, sizeof(*plat->axi),
+				 GFP_KERNEL);
+	if (!plat->axi)
+		return -ENOMEM;
+	plat->axi->axi_lpi_en = 0;
+	plat->axi->axi_xit_frm = 0;
+	plat->axi->axi_wr_osr_lmt = 0;
+	plat->axi->axi_rd_osr_lmt = 2;
+	plat->axi->axi_blen[0] = 4;
+	plat->axi->axi_blen[1] = 8;
+	plat->axi->axi_blen[2] = 16;
+
+	/* Set default value for multicast hash bins */
+	plat->multicast_filter_bins = HASH_TABLE_SIZE;
+
+	/* Set default value for unicast filter entries */
+	plat->unicast_filter_entries = 1;
+
+	/* Set the maxmtu to a default of JUMBO_LEN */
+	plat->maxmtu = JUMBO_LEN;
+
+	plat->tx_fifo_size = 32768;
+	plat->rx_fifo_size = 32768;
+
+	return 0;
+}
+
+static int ehl_sgmii1g_data(struct pci_dev *pdev,
+			    struct plat_stmmacenet_data *plat)
+{
+	int ret;
+
+	/* Set common default data first */
+	ret = ehl_common_data(pdev, plat);
+
+	if (ret)
+		return ret;
+
+	plat->interface = PHY_INTERFACE_MODE_SGMII;
+
+	return 0;
+}
+
+static struct stmmac_pci_info ehl_sgmii1g_pci_info = {
+	.setup = ehl_sgmii1g_data,
+};
+
 static const struct stmmac_pci_func_data galileo_stmmac_func_data[] = {
 	{
 		.func = 6,
@@ -355,6 +456,7 @@ static int __maybe_unused stmmac_pci_resume(struct device *dev)
 
 #define STMMAC_QUARK_ID  0x0937
 #define STMMAC_DEVICE_ID 0x1108
+#define STMMAC_EHL_SGMII1G_ID   0x4b31
 
 #define STMMAC_DEVICE(vendor_id, dev_id, info)	{	\
 	PCI_VDEVICE(vendor_id, dev_id),			\
@@ -365,6 +467,7 @@ static int __maybe_unused stmmac_pci_resume(struct device *dev)
 	STMMAC_DEVICE(STMMAC, STMMAC_DEVICE_ID, stmmac_pci_info),
 	STMMAC_DEVICE(STMICRO, PCI_DEVICE_ID_STMICRO_MAC, stmmac_pci_info),
 	STMMAC_DEVICE(INTEL, STMMAC_QUARK_ID, quark_pci_info),
+	STMMAC_DEVICE(INTEL, STMMAC_EHL_SGMII1G_ID, ehl_sgmii1g_pci_info),
 	{}
 };
 
-- 
1.9.1

