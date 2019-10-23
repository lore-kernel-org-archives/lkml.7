Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5D1CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9862173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tzn2NI+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405448AbfJWM6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:58:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50288 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405421AbfJWM6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwKxH040803;
        Wed, 23 Oct 2019 07:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835500;
        bh=FYnyDkp8O13hgdHJFePiQ3GXV91GcizfC8VXOBovgOI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Tzn2NI+ig2NSGbsj3yXw+3L1hMkMnusfWQBJT0WZpwD87D3R/NEGNNz7F2H2RT4oA
         d6lhETb4U2zhFg45SDmVke4vHRDztsV0uf+MRL+2Mx/q4EuWinqsq/X65JgkGlL3CX
         C7ZmneF2LfdyjajsWwm/NHbv1oSwdQ2G5B4cXavs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NCwKmW100596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 07:58:20 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:58:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:58:10 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5o9061147;
        Wed, 23 Oct 2019 07:58:18 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 05/14] phy: cadence: Sierra: Make cdns_sierra_phy_init() as phy_ops
Date:   Wed, 23 Oct 2019 18:27:26 +0530
Message-ID: <20191023125735.4713-6-kishon@ti.com>
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

Instead of invoking cdns_sierra_phy_init() from probe, add it in
phy_ops so that it's initialized when the PHY consumer invokes
phy_init()

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 89a3b732c311..5c617248841f 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -174,7 +174,7 @@ static struct regmap_config cdns_sierra_phy_config_ctrl_config = {
 	.reg_read = cdns_regmap_read,
 };
 
-static void cdns_sierra_phy_init(struct phy *gphy)
+static int cdns_sierra_phy_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
 	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
@@ -183,6 +183,10 @@ static void cdns_sierra_phy_init(struct phy *gphy)
 	struct cdns_reg_pairs *vals;
 	u32 num_regs;
 
+	/* Initialise the PHY registers, unless auto configured */
+	if (phy->autoconf)
+		return 0;
+
 	if (ins->phy_type == PHY_TYPE_PCIE) {
 		num_regs = phy->init_data->pcie_regs;
 		vals = phy->init_data->pcie_vals;
@@ -190,7 +194,7 @@ static void cdns_sierra_phy_init(struct phy *gphy)
 		num_regs = phy->init_data->usb_regs;
 		vals = phy->init_data->usb_vals;
 	} else {
-		return;
+		return -EINVAL;
 	}
 	for (i = 0; i < ins->num_lanes; i++) {
 		for (j = 0; j < num_regs ; j++) {
@@ -198,6 +202,8 @@ static void cdns_sierra_phy_init(struct phy *gphy)
 			regmap_write(regmap, vals[j].off, vals[j].val);
 		}
 	}
+
+	return 0;
 }
 
 static int cdns_sierra_phy_on(struct phy *gphy)
@@ -216,6 +222,7 @@ static int cdns_sierra_phy_off(struct phy *gphy)
 }
 
 static const struct phy_ops ops = {
+	.init		= cdns_sierra_phy_init,
 	.power_on	= cdns_sierra_phy_on,
 	.power_off	= cdns_sierra_phy_off,
 	.owner		= THIS_MODULE,
@@ -436,10 +443,6 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		sp->phys[node].phy = gphy;
 		phy_set_drvdata(gphy, &sp->phys[node]);
 
-		/* Initialise the PHY registers, unless auto configured */
-		if (!sp->autoconf)
-			cdns_sierra_phy_init(gphy);
-
 		node++;
 	}
 	sp->nsubnodes = node;
-- 
2.17.1

