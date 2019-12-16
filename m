Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD33C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03605215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XrD5/KYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfLPJ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:56:43 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58834 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfLPJ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:41 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uSwc106137;
        Mon, 16 Dec 2019 03:56:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490188;
        bh=hOJHDmL6AFhdHJjk4PXU1SdyLIBqNQCFUPS9hn289rg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XrD5/KYc7fdQd9L1OvUsxoi7uX5JF+Zq0yu2PBvXqL19r9I54e5FWU3LPCcqWVfOB
         3nji6WHd8N6detzrLV4YI+udsXsowZMbFmUEMco6FZFtSuQak1UTGSkshWhSg8dDK3
         kJG8+Y0UlX6u+JlyvQpqBUt4iHJxMENJRKy9iEKE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uS4W038405;
        Mon, 16 Dec 2019 03:56:28 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:56:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:56:28 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tsJU084408;
        Mon, 16 Dec 2019 03:56:25 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 11/14] phy: cadence: Sierra: Set cmn_refclk_dig_div/cmn_refclk1_dig_div frequency to 25MHz
Date:   Mon, 16 Dec 2019 15:27:09 +0530
Message-ID: <20191216095712.13266-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216095712.13266-1-kishon@ti.com>
References: <20191216095712.13266-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set cmn_refclk_dig_div/cmn_refclk1_dig_div frequency to 25MHz
as specified in "Common Module Clock Configurations" of the Cadence
Sierra 16FFC Multi-Protocol PHY PMA Specification. It is set to 25MHz
since the only user of Cadence Sierra SERDES, TI J721E SoC provides
input clock frequency of 100MHz. For other frequencies,
cmn_refclk_dig_div/cmn_refclk1_dig_div should be configured
based on the "Common Module Clock Configurations".

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 665a6dbc7816..82466d0e9b38 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -198,6 +198,8 @@ struct cdns_sierra_phy {
 	struct regmap_field *phy_pll_cfg_1;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct clk *clk;
+	struct clk *cmn_refclk_dig_div;
+	struct clk *cmn_refclk1_dig_div;
 	int nsubnodes;
 	u32 num_lanes;
 	bool autoconf;
@@ -279,6 +281,8 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	if (phy->autoconf)
 		return 0;
 
+	clk_set_rate(phy->cmn_refclk_dig_div, 25000000);
+	clk_set_rate(phy->cmn_refclk1_dig_div, 25000000);
 	if (ins->phy_type == PHY_TYPE_PCIE) {
 		num_cmn_regs = phy->init_data->pcie_cmn_regs;
 		num_ln_regs = phy->init_data->pcie_ln_regs;
@@ -468,6 +472,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, ret, node = 0;
 	void __iomem *base;
+	struct clk *clk;
 	struct device_node *dn = dev->of_node, *child;
 
 	if (of_get_child_count(dn) == 0)
@@ -523,6 +528,22 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(sp->apb_rst);
 	}
 
+	clk = devm_clk_get_optional(dev, "cmn_refclk_dig_div");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "cmn_refclk_dig_div clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->cmn_refclk_dig_div = clk;
+
+	clk = devm_clk_get_optional(dev, "cmn_refclk1_dig_div");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "cmn_refclk1_dig_div clock not found\n");
+		ret = PTR_ERR(clk);
+		return ret;
+	}
+	sp->cmn_refclk1_dig_div = clk;
+
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
 		return ret;
-- 
2.17.1

