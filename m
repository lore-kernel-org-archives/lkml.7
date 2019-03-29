Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FDBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE1F2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K8hPeLQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfC2QC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:02:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58474 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfC2QC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:02:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TG2npU055841;
        Fri, 29 Mar 2019 11:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553875369;
        bh=CGNHK7q7iqmr9pe5pOwaCqXVUHJHn96hRh6Q3rdxHZU=;
        h=From:To:CC:Subject:Date;
        b=K8hPeLQcLM60HO92LbGJ+li2q5EMbaS0u8i0hnHAgfXAupubdCvzZW1jq5uuAZaE+
         4WoxrE9Jwn5H+fFg71K0xUYXfAqekL2xU4ULIloz+JG+a7mvToIj+Wm/roPYSTdtKX
         LrilnAX7oVZT0IU6gBLnLjiM+kPVVgEwVTFZUOiI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TG2n3R039763
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 11:02:49 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 11:02:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 11:02:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TG2mvM112287;
        Fri, 29 Mar 2019 11:02:48 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        <linux-omap@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v2 net-next] net: ethernet: ti: cpsw: drop TI_DAVINCI_CPDMA config option
Date:   Fri, 29 Mar 2019 18:00:35 +0200
Message-ID: <1553875235-14335-1-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both drivers CPSW and EMAC can't work without CPDMA, hence simplify build
of those drivers by always linking davinci_cpdma and drop TI_DAVINCI_CPDMA
config option.
Note. the davinci_emac driver module was changed to "ti_davinci_emac" to
make build work.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
It's been marked as RFC as I've had to change davinci_emac.c module name
 to "ti_davinci_emac".  if no objection - I'd like to do the same for ALE module also
 and then resend.

v2:
- corrected patch - missed Kconfig changes

 drivers/net/ethernet/ti/Kconfig         | 12 ------------
 drivers/net/ethernet/ti/Makefile        |  6 +++---
 drivers/net/ethernet/ti/davinci_cpdma.c | 26 -------------------------
 3 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 8b21b40a9fe5..46f253aadcdd 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -20,7 +20,6 @@ config TI_DAVINCI_EMAC
 	tristate "TI DaVinci EMAC Support"
 	depends on ARM && ( ARCH_DAVINCI || ARCH_OMAP3 ) || COMPILE_TEST
 	select TI_DAVINCI_MDIO
-	select TI_DAVINCI_CPDMA
 	select PHYLIB
 	---help---
 	  This driver supports TI's DaVinci Ethernet .
@@ -38,16 +37,6 @@ config TI_DAVINCI_MDIO
 	  To compile this driver as a module, choose M here: the module
 	  will be called davinci_mdio.  This is recommended.
 
-config TI_DAVINCI_CPDMA
-	tristate "TI DaVinci CPDMA Support"
-	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
-	select GENERIC_ALLOCATOR
-	---help---
-	  This driver supports TI's DaVinci CPDMA dma engine.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called davinci_cpdma.  This is recommended.
-
 config TI_CPSW_PHY_SEL
 	bool "TI CPSW Phy mode Selection (DEPRECATED)"
 	default n
@@ -63,7 +52,6 @@ config TI_CPSW_ALE
 config TI_CPSW
 	tristate "TI CPSW Switch Support"
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
-	select TI_DAVINCI_CPDMA
 	select TI_DAVINCI_MDIO
 	select TI_CPSW_ALE
 	select MFD_SYSCON
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 0be551de821c..a763e1b27304 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -8,14 +8,14 @@ obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
 
 obj-$(CONFIG_TLAN) += tlan.o
 obj-$(CONFIG_CPMAC) += cpmac.o
-obj-$(CONFIG_TI_DAVINCI_EMAC) += davinci_emac.o
+obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
+ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
 obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
-obj-$(CONFIG_TI_DAVINCI_CPDMA) += davinci_cpdma.o
 obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
 obj-$(CONFIG_TI_CPSW_ALE) += cpsw_ale.o
 obj-$(CONFIG_TI_CPTS_MOD) += cpts.o
 obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
-ti_cpsw-y := cpsw.o
+ti_cpsw-y := cpsw.o davinci_cpdma.o
 
 obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o
 keystone_netcp-y := netcp_core.o
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 4236dcdd5634..b8df342ba217 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -527,7 +527,6 @@ struct cpdma_ctlr *cpdma_ctlr_create(struct cpdma_params *params)
 		ctlr->num_chan = CPDMA_MAX_CHANNELS;
 	return ctlr;
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_create);
 
 int cpdma_ctlr_start(struct cpdma_ctlr *ctlr)
 {
@@ -588,7 +587,6 @@ int cpdma_ctlr_start(struct cpdma_ctlr *ctlr)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_start);
 
 int cpdma_ctlr_stop(struct cpdma_ctlr *ctlr)
 {
@@ -621,7 +619,6 @@ int cpdma_ctlr_stop(struct cpdma_ctlr *ctlr)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_stop);
 
 int cpdma_ctlr_destroy(struct cpdma_ctlr *ctlr)
 {
@@ -639,7 +636,6 @@ int cpdma_ctlr_destroy(struct cpdma_ctlr *ctlr)
 	cpdma_desc_pool_destroy(ctlr);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_destroy);
 
 int cpdma_ctlr_int_ctrl(struct cpdma_ctlr *ctlr, bool enable)
 {
@@ -660,25 +656,21 @@ int cpdma_ctlr_int_ctrl(struct cpdma_ctlr *ctlr, bool enable)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_int_ctrl);
 
 void cpdma_ctlr_eoi(struct cpdma_ctlr *ctlr, u32 value)
 {
 	dma_reg_write(ctlr, CPDMA_MACEOIVECTOR, value);
 }
-EXPORT_SYMBOL_GPL(cpdma_ctlr_eoi);
 
 u32 cpdma_ctrl_rxchs_state(struct cpdma_ctlr *ctlr)
 {
 	return dma_reg_read(ctlr, CPDMA_RXINTSTATMASKED);
 }
-EXPORT_SYMBOL_GPL(cpdma_ctrl_rxchs_state);
 
 u32 cpdma_ctrl_txchs_state(struct cpdma_ctlr *ctlr)
 {
 	return dma_reg_read(ctlr, CPDMA_TXINTSTATMASKED);
 }
-EXPORT_SYMBOL_GPL(cpdma_ctrl_txchs_state);
 
 static void cpdma_chan_set_descs(struct cpdma_ctlr *ctlr,
 				 int rx, int desc_num,
@@ -774,7 +766,6 @@ int cpdma_chan_split_pool(struct cpdma_ctlr *ctlr)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_split_pool);
 
 
 /* cpdma_chan_set_weight - set weight of a channel in percentage.
@@ -807,7 +798,6 @@ int cpdma_chan_set_weight(struct cpdma_chan *ch, int weight)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_set_weight);
 
 /* cpdma_chan_get_min_rate - get minimum allowed rate for channel
  * Should be called before cpdma_chan_set_rate.
@@ -822,7 +812,6 @@ u32 cpdma_chan_get_min_rate(struct cpdma_ctlr *ctlr)
 
 	return DIV_ROUND_UP(divident, divisor);
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_get_min_rate);
 
 /* cpdma_chan_set_rate - limits bandwidth for transmit channel.
  * The bandwidth * limited channels have to be in order beginning from lowest.
@@ -867,7 +856,6 @@ int cpdma_chan_set_rate(struct cpdma_chan *ch, u32 rate)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_set_rate);
 
 u32 cpdma_chan_get_rate(struct cpdma_chan *ch)
 {
@@ -880,7 +868,6 @@ u32 cpdma_chan_get_rate(struct cpdma_chan *ch)
 
 	return rate;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_get_rate);
 
 struct cpdma_chan *cpdma_chan_create(struct cpdma_ctlr *ctlr, int chan_num,
 				     cpdma_handler_fn handler, int rx_type)
@@ -940,7 +927,6 @@ struct cpdma_chan *cpdma_chan_create(struct cpdma_ctlr *ctlr, int chan_num,
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return chan;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_create);
 
 int cpdma_chan_get_rx_buf_num(struct cpdma_chan *chan)
 {
@@ -953,7 +939,6 @@ int cpdma_chan_get_rx_buf_num(struct cpdma_chan *chan)
 
 	return desc_num;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_get_rx_buf_num);
 
 int cpdma_chan_destroy(struct cpdma_chan *chan)
 {
@@ -975,7 +960,6 @@ int cpdma_chan_destroy(struct cpdma_chan *chan)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_destroy);
 
 int cpdma_chan_get_stats(struct cpdma_chan *chan,
 			 struct cpdma_chan_stats *stats)
@@ -988,7 +972,6 @@ int cpdma_chan_get_stats(struct cpdma_chan *chan,
 	spin_unlock_irqrestore(&chan->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_get_stats);
 
 static void __cpdma_chan_submit(struct cpdma_chan *chan,
 				struct cpdma_desc __iomem *desc)
@@ -1095,7 +1078,6 @@ int cpdma_chan_submit(struct cpdma_chan *chan, void *token, void *data,
 	spin_unlock_irqrestore(&chan->lock, flags);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_submit);
 
 bool cpdma_check_free_tx_desc(struct cpdma_chan *chan)
 {
@@ -1110,7 +1092,6 @@ bool cpdma_check_free_tx_desc(struct cpdma_chan *chan)
 	spin_unlock_irqrestore(&chan->lock, flags);
 	return free_tx_desc;
 }
-EXPORT_SYMBOL_GPL(cpdma_check_free_tx_desc);
 
 static void __cpdma_chan_free(struct cpdma_chan *chan,
 			      struct cpdma_desc __iomem *desc,
@@ -1204,7 +1185,6 @@ int cpdma_chan_process(struct cpdma_chan *chan, int quota)
 	}
 	return used;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_process);
 
 int cpdma_chan_start(struct cpdma_chan *chan)
 {
@@ -1224,7 +1204,6 @@ int cpdma_chan_start(struct cpdma_chan *chan)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_start);
 
 int cpdma_chan_stop(struct cpdma_chan *chan)
 {
@@ -1287,7 +1266,6 @@ int cpdma_chan_stop(struct cpdma_chan *chan)
 	spin_unlock_irqrestore(&chan->lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpdma_chan_stop);
 
 int cpdma_chan_int_ctrl(struct cpdma_chan *chan, bool enable)
 {
@@ -1329,25 +1307,21 @@ int cpdma_control_set(struct cpdma_ctlr *ctlr, int control, int value)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cpdma_control_set);
 
 int cpdma_get_num_rx_descs(struct cpdma_ctlr *ctlr)
 {
 	return ctlr->num_rx_desc;
 }
-EXPORT_SYMBOL_GPL(cpdma_get_num_rx_descs);
 
 int cpdma_get_num_tx_descs(struct cpdma_ctlr *ctlr)
 {
 	return ctlr->num_tx_desc;
 }
-EXPORT_SYMBOL_GPL(cpdma_get_num_tx_descs);
 
 void cpdma_set_num_rx_descs(struct cpdma_ctlr *ctlr, int num_rx_desc)
 {
 	ctlr->num_rx_desc = num_rx_desc;
 	ctlr->num_tx_desc = ctlr->pool->num_desc - ctlr->num_rx_desc;
 }
-EXPORT_SYMBOL_GPL(cpdma_set_num_rx_descs);
 
 MODULE_LICENSE("GPL");
-- 
2.17.1

