Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B74ECA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE6620640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QlcbSDzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405083AbfJWM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:58:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59302 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405447AbfJWM6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwZMj048096;
        Wed, 23 Oct 2019 07:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835515;
        bh=LaDHmzMFRFZZi0cfbucYtOjAncJhlSl2As2VSimU6go=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QlcbSDzquR20MLnfOxDdS6Gen2qZjYk95ddYumS/lRxWy/OrfhqpdDAbQtxVjrbxe
         IkMQwQgdAP1HjnB+nFtF8FKdLr5ozCOHywfG+hyhIVA15Yd/ETn5OBkNHXe70EtxVT
         /wkkj0sOo/sYrDA/WIeq9Now4aFsbxX9C2dTKHbo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwZH2064753;
        Wed, 23 Oct 2019 07:58:35 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:58:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:58:24 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5oF061147;
        Wed, 23 Oct 2019 07:58:32 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 11/14] phy: cadence: Sierra: Set cmn_refclk/cmn_refclk1 frequency to 25MHz
Date:   Wed, 23 Oct 2019 18:27:32 +0530
Message-ID: <20191023125735.4713-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023125735.4713-1-kishon@ti.com>
References: <20191023125735.4713-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set cmn_refclk/cmn_refclk1 frequency to 25MHz as specified in
"Common Module Clock Configurations" of the Cadence Sierra 16FFC
Multi-Protocol PHYPMA Specification. It is set to 25MHz since
the only user of Cadence Sierra SERDES, TI J721E SoC provides
input clock frequency of 100MHz. For other frequencies,
cmn_refclk/cmn_refclk1 should be configured based on the
"Common Module Clock Configurations".

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index dd54a0ab89b7..affede8c4368 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -196,6 +196,8 @@ struct cdns_sierra_phy {
 	struct regmap_field *phy_pll_cfg_1;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct clk *clk;
+	struct clk *cmn_refclk;
+	struct clk *cmn_refclk1;
 	int nsubnodes;
 	u32 num_lanes;
 	bool autoconf;
@@ -277,6 +279,8 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	if (phy->autoconf)
 		return 0;
 
+	clk_set_rate(phy->cmn_refclk, 25000000);
+	clk_set_rate(phy->cmn_refclk1, 25000000);
 	if (ins->phy_type == PHY_TYPE_PCIE) {
 		num_cmn_regs = phy->init_data->pcie_cmn_regs;
 		num_ln_regs = phy->init_data->pcie_ln_regs;
@@ -466,6 +470,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, ret, node = 0;
 	void __iomem *base;
+	struct clk *clk;
 	struct device_node *dn = dev->of_node, *child;
 
 	if (of_get_child_count(dn) == 0)
@@ -521,6 +526,22 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(sp->apb_rst);
 	}
 
+	clk = devm_clk_get_optional(dev, "cmn_refclk");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "core_ref_clk clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->cmn_refclk = clk;
+
+	clk = devm_clk_get_optional(dev, "cmn_refclk1");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "core_ref_clk clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->cmn_refclk1 = clk;
+
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
 		return ret;
-- 
2.17.1

