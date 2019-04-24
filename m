Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493B9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F5720656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfDXJQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:16:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:1102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbfDXJQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:16:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 02:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="145260896"
Received: from wvoon-ilbpg2.png.intel.com ([10.88.227.88])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2019 02:16:44 -0700
From:   Weifeng Voon <weifeng.voon@intel.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Kweh Hock Leong <hock.leong.kweh@intel.com>,
        Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH 7/7] net: stmmac: add xPCS functions for device with DWMACv5.1
Date:   Thu, 25 Apr 2019 01:17:21 +0800
Message-Id: <1556126241-2774-8-git-send-email-weifeng.voon@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ong Boon Leong <boon.leong.ong@intel.com>

We introduce support for driver that has v5.10 IP and is also using
xPCS as MMD. This can be easily enabled for other product that integrates
xPCS that is not using v5.00 IP.

Reviewed-by: Chuah Kim Tatt <kim.tatt.chuah@intel.com>
Reviewed-by: Voon Weifeng <weifeng.voon@intel.com>
Reviewed-by: Kweh Hock Leong <hock.leong.kweh@intel.com>
Reviewed-by: Baoli Zhang <baoli.zhang@intel.com>
Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 67 +++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c        | 31 ++++++++++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h        |  1 +
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 7e5d5db..f36aa67 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -20,6 +20,7 @@
 #include <net/dsa.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
+#include "dw_xpcs.h"
 #include "dwmac4.h"
 #include "dwmac5.h"
 
@@ -505,6 +506,34 @@ static void dwmac4_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
 	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
 }
 
+static void dwmac_xpcs_init(struct net_device *ndev, int pcs_mode)
+{
+	dw_xpcs_init(ndev, pcs_mode);
+}
+
+static void dwmac_xpcs_ctrl_ane(struct net_device *ndev, bool ane,
+				bool loopback)
+{
+	dw_xpcs_ctrl_ane(ndev, ane, loopback);
+}
+
+static void dwmac_xpcs_rane(struct net_device *ndev, bool restart)
+{
+	dw_xpcs_rane(ndev, restart);
+}
+
+static void dwmac_xpcs_get_adv_lp(struct net_device *ndev,
+				  struct rgmii_adv *adv)
+{
+	dw_xpcs_get_adv_lp(ndev, adv);
+}
+
+static int dwmac_xpcs_irq_status(struct net_device *ndev,
+				 struct stmmac_extra_stats *x)
+{
+	return dw_xpcs_irq_status(ndev, x);
+}
+
 /* RGMII or SMII interface */
 static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
 {
@@ -799,6 +828,44 @@ static void dwmac4_debug(void __iomem *ioaddr, struct stmmac_extra_stats *x,
 	.flex_pps_config = dwmac5_flex_pps_config,
 };
 
+const struct stmmac_ops dwmac510_xpcs_ops = {
+	.core_init = dwmac4_core_init,
+	.set_mac = stmmac_dwmac4_set_mac,
+	.rx_ipc = dwmac4_rx_ipc_enable,
+	.rx_queue_enable = dwmac4_rx_queue_enable,
+	.rx_queue_prio = dwmac4_rx_queue_priority,
+	.tx_queue_prio = dwmac4_tx_queue_priority,
+	.rx_queue_routing = dwmac4_rx_queue_routing,
+	.prog_mtl_rx_algorithms = dwmac4_prog_mtl_rx_algorithms,
+	.prog_mtl_tx_algorithms = dwmac4_prog_mtl_tx_algorithms,
+	.set_mtl_tx_queue_weight = dwmac4_set_mtl_tx_queue_weight,
+	.map_mtl_to_dma = dwmac4_map_mtl_dma,
+	.config_cbs = dwmac4_config_cbs,
+	.dump_regs = dwmac4_dump_regs,
+	.host_irq_status = dwmac4_irq_status,
+	.host_mtl_irq_status = dwmac4_irq_mtl_status,
+	.flow_ctrl = dwmac4_flow_ctrl,
+	.pmt = dwmac4_pmt,
+	.set_umac_addr = dwmac4_set_umac_addr,
+	.get_umac_addr = dwmac4_get_umac_addr,
+	.set_eee_mode = dwmac4_set_eee_mode,
+	.reset_eee_mode = dwmac4_reset_eee_mode,
+	.set_eee_timer = dwmac4_set_eee_timer,
+	.set_eee_pls = dwmac4_set_eee_pls,
+	.xpcs_init = dwmac_xpcs_init,
+	.xpcs_ctrl_ane = dwmac_xpcs_ctrl_ane,
+	.xpcs_rane = dwmac_xpcs_rane,
+	.xpcs_get_adv_lp = dwmac_xpcs_get_adv_lp,
+	.xpcs_irq_status = dwmac_xpcs_irq_status,
+	.debug = dwmac4_debug,
+	.set_filter = dwmac4_set_filter,
+	.safety_feat_config = dwmac5_safety_feat_config,
+	.safety_feat_irq_status = dwmac5_safety_feat_irq_status,
+	.safety_feat_dump = dwmac5_safety_feat_dump,
+	.rxp_config = dwmac5_rxp_config,
+	.flex_pps_config = dwmac5_flex_pps_config,
+};
+
 int dwmac4_setup(struct stmmac_priv *priv)
 {
 	struct mac_device_info *mac = priv->hw;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 81b966a..3725baa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -73,6 +73,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 	bool gmac;
 	bool gmac4;
 	bool xgmac;
+	bool xpcs;
 	u32 min_id;
 	const struct stmmac_regs_off regs;
 	const void *desc;
@@ -89,6 +90,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 		.gmac = false,
 		.gmac4 = false,
 		.xgmac = false,
+		.xpcs = false,
 		.min_id = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC3_X_OFFSET,
@@ -106,6 +108,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 		.gmac = true,
 		.gmac4 = false,
 		.xgmac = false,
+		.xpcs = false,
 		.min_id = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC3_X_OFFSET,
@@ -123,6 +126,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 		.gmac = false,
 		.gmac4 = true,
 		.xgmac = false,
+		.xpcs = false,
 		.min_id = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -140,6 +144,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 		.gmac = false,
 		.gmac4 = true,
 		.xgmac = false,
+		.xpcs = false,
 		.min_id = DWMAC_CORE_4_00,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -157,6 +162,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 		.gmac = false,
 		.gmac4 = true,
 		.xgmac = false,
+		.xpcs = false,
 		.min_id = DWMAC_CORE_4_10,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -174,6 +180,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 		.gmac = false,
 		.gmac4 = true,
 		.xgmac = false,
+		.xpcs = false,
 		.min_id = DWMAC_CORE_5_10,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -191,6 +198,7 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 		.gmac = false,
 		.gmac4 = false,
 		.xgmac = true,
+		.xpcs = false,
 		.min_id = DWXGMAC_CORE_2_10,
 		.regs = {
 			.ptp_off = PTP_XGMAC_OFFSET,
@@ -204,7 +212,25 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 		.tc = &dwmac510_tc_ops,
 		.setup = dwxgmac2_setup,
 		.quirks = NULL,
-	},
+	}, {
+		.gmac = false,
+		.gmac4 = true,
+		.xgmac = false,
+		.xpcs = true,
+		.min_id = DWMAC_CORE_5_10,
+		.regs = {
+			.ptp_off = PTP_GMAC4_OFFSET,
+			.mmc_off = MMC_GMAC4_OFFSET,
+		},
+		.desc = &dwmac4_desc_ops,
+		.dma = &dwmac410_dma_ops,
+		.mac = &dwmac510_xpcs_ops,
+		.hwtimestamp = &stmmac_ptp,
+		.mode = &dwmac4_ring_mode_ops,
+		.tc = &dwmac510_tc_ops,
+		.setup = dwmac4_setup,
+		.quirks = NULL,
+	}
 };
 
 int stmmac_hwif_init(struct stmmac_priv *priv)
@@ -212,6 +238,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	bool needs_xgmac = priv->plat->has_xgmac;
 	bool needs_gmac4 = priv->plat->has_gmac4;
 	bool needs_gmac = priv->plat->has_gmac;
+	bool needs_xpcs = priv->plat->has_xpcs;
 	const struct stmmac_hwif_entry *entry;
 	struct mac_device_info *mac;
 	bool needs_setup = true;
@@ -256,6 +283,8 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 			continue;
 		if (needs_xgmac ^ entry->xgmac)
 			continue;
+		if (needs_xpcs ^ entry->xpcs)
+			continue;
 		/* Use synopsys_id var because some setups can override this */
 		if (priv->synopsys_id < entry->min_id)
 			continue;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index cb7eb48..485be41 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -495,6 +495,7 @@ struct stmmac_regs_off {
 extern const struct stmmac_ops dwmac410_ops;
 extern const struct stmmac_dma_ops dwmac410_dma_ops;
 extern const struct stmmac_ops dwmac510_ops;
+extern const struct stmmac_ops dwmac510_xpcs_ops;
 extern const struct stmmac_tc_ops dwmac510_tc_ops;
 extern const struct stmmac_ops dwxgmac210_ops;
 extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
-- 
1.9.1

