Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2831BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30BA20656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfDXJQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:16:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:1102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfDXJQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:16:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 02:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="145260891"
Received: from wvoon-ilbpg2.png.intel.com ([10.88.227.88])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2019 02:16:41 -0700
From:   Weifeng Voon <weifeng.voon@intel.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Kweh Hock Leong <hock.leong.kweh@intel.com>,
        Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH 6/7] net: stmmac: add xPCS platform data for EHL
Date:   Thu, 25 Apr 2019 01:17:20 +0800
Message-Id: <1556126241-2774-7-git-send-email-weifeng.voon@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable xPCS capability inside EHL platform data.

Signed-off-by: Weifeng Voon <weifeng.voon@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index b454a97..daac2eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -23,6 +23,7 @@
 #include <linux/dmi.h>
 
 #include "stmmac.h"
+#include "dw_xpcs.h"
 
 /*
  * This struct is used to associate PCI Function of MAC controller on a board,
@@ -128,6 +129,8 @@ static int ehl_common_data(struct pci_dev *pdev,
 	plat->clk_csr = 5;
 	plat->has_gmac = 0;
 	plat->has_gmac4 = 1;
+	plat->xpcs_phy_addr = 0x16;
+	plat->pcs_mode = AN_CTRL_PCS_MD_C37_SGMII;
 	plat->force_sf_dma_mode = 0;
 	plat->tso_en = 1;
 
@@ -211,6 +214,7 @@ static int ehl_sgmii1g_data(struct pci_dev *pdev,
 		return ret;
 
 	plat->interface = PHY_INTERFACE_MODE_SGMII;
+	plat->has_xpcs = 1;
 
 	return 0;
 }
@@ -387,6 +391,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 	res.addr = pcim_iomap_table(pdev)[i];
 	res.wol_irq = pdev->irq;
 	res.irq = pdev->irq;
+	res.xpcs_irq = 0;
 
 	return stmmac_dvr_probe(&pdev->dev, plat, &res);
 }
-- 
1.9.1

