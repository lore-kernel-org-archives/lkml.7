Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D1C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A910320828
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Uo5l031V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLPJ4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:56:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58812 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfLPJ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:32 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uPeO106127;
        Mon, 16 Dec 2019 03:56:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490185;
        bh=uk33OX2/IRV4qk5zeJOpsDKsk+aZEVFfOmbpkxiarpY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Uo5l031VytwY+htp3tFoNwtIhjoGVm6sIm2RQ0gPw4d9I2XSz4E0Z3X+p/I2Y6+Pj
         7uldACES1kpYDGOWKsRUFPGzd/KAm7JEb25a99lCxKje7s/UTr0LW7YOYCaUCYwwb4
         HR8uomFcwMpbpy8p0b2O1KLCOcPNSaFjLvW18JYw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBG9uPQG049540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 03:56:25 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:56:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:56:25 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tsJT084408;
        Mon, 16 Dec 2019 03:56:23 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 10/14] phy: cadence: Sierra: Change MAX_LANES of Sierra to 16
Date:   Mon, 16 Dec 2019 15:27:08 +0530
Message-ID: <20191216095712.13266-11-kishon@ti.com>
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

Sierra SERDES IP supports upto 16 lanes (though not all of it
will be enabled in a platform). Allow Sierra driver to support a
maximum of upto 16 lanes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 62bff4b043f0..665a6dbc7816 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -141,7 +141,7 @@
 #define SIERRA_PHY_PLL_CFG				0xe
 
 #define SIERRA_MACRO_ID					0x00007364
-#define SIERRA_MAX_LANES				4
+#define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
 
 static const struct reg_field macro_id_type =
@@ -199,6 +199,7 @@ struct cdns_sierra_phy {
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct clk *clk;
 	int nsubnodes;
+	u32 num_lanes;
 	bool autoconf;
 };
 
@@ -235,6 +236,18 @@ static struct regmap_config cdns_sierra_lane_cdb_config[] = {
 	SIERRA_LANE_CDB_REGMAP_CONF("1"),
 	SIERRA_LANE_CDB_REGMAP_CONF("2"),
 	SIERRA_LANE_CDB_REGMAP_CONF("3"),
+	SIERRA_LANE_CDB_REGMAP_CONF("4"),
+	SIERRA_LANE_CDB_REGMAP_CONF("5"),
+	SIERRA_LANE_CDB_REGMAP_CONF("6"),
+	SIERRA_LANE_CDB_REGMAP_CONF("7"),
+	SIERRA_LANE_CDB_REGMAP_CONF("8"),
+	SIERRA_LANE_CDB_REGMAP_CONF("9"),
+	SIERRA_LANE_CDB_REGMAP_CONF("10"),
+	SIERRA_LANE_CDB_REGMAP_CONF("11"),
+	SIERRA_LANE_CDB_REGMAP_CONF("12"),
+	SIERRA_LANE_CDB_REGMAP_CONF("13"),
+	SIERRA_LANE_CDB_REGMAP_CONF("14"),
+	SIERRA_LANE_CDB_REGMAP_CONF("15"),
 };
 
 static struct regmap_config cdns_sierra_common_cdb_config = {
@@ -548,6 +561,8 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 			}
 		}
 
+		sp->num_lanes += sp->phys[node].num_lanes;
+
 		gphy = devm_phy_create(dev, child, &ops);
 
 		if (IS_ERR(gphy)) {
@@ -561,6 +576,11 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	}
 	sp->nsubnodes = node;
 
+	if (sp->num_lanes > SIERRA_MAX_LANES) {
+		dev_err(dev, "Invalid lane configuration\n");
+		goto put_child2;
+	}
+
 	/* If more than one subnode, configure the PHY as multilink */
 	if (!sp->autoconf && sp->nsubnodes > 1)
 		regmap_field_write(sp->phy_pll_cfg_1, 0x1);
-- 
2.17.1

