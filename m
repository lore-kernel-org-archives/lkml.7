Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D420FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BD021925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lD4nJLSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405082AbfJPLcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:32:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50376 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405061AbfJPLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:32:14 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GBWCi1097204;
        Wed, 16 Oct 2019 06:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571225532;
        bh=0wNKaASInt1k8YuOc3I1egQn9FpeL+eFcyUOwrqISs4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lD4nJLSAoj2O/iX0oyUT3qrcugpojM4Zbk/iUS6inDn9tfNBiRDPraw0nU/rkXfW4
         LXJsUsk6SP23vzfc6y+FYrczhvAUABSE3uvEDLHVVvKB9XmBYxneHWrU3xSD0zeF0x
         VR9gEDYqYqzwAd5uSrLIU/CClwwHfrsSHPuAQGjU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GBWCGP114125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 06:32:12 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 06:32:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 06:32:12 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GBVkmE097485;
        Wed, 16 Oct 2019 06:32:10 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 10/13] phy: cadence: Sierra: Change MAX_LANES of Sierra to 16
Date:   Wed, 16 Oct 2019 17:01:14 +0530
Message-ID: <20191016113117.12370-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016113117.12370-1-kishon@ti.com>
References: <20191016113117.12370-1-kishon@ti.com>
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
index 82f7617b2dac..dd54a0ab89b7 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -139,7 +139,7 @@
 #define SIERRA_PHY_PLL_CFG				0xe
 
 #define SIERRA_MACRO_ID					0x00007364
-#define SIERRA_MAX_LANES				4
+#define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
 
 static const struct reg_field macro_id_type =
@@ -197,6 +197,7 @@ struct cdns_sierra_phy {
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct clk *clk;
 	int nsubnodes;
+	u32 num_lanes;
 	bool autoconf;
 };
 
@@ -233,6 +234,18 @@ static struct regmap_config cdns_sierra_lane_cdb_config[] = {
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
@@ -546,6 +559,8 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 			}
 		}
 
+		sp->num_lanes += sp->phys[node].num_lanes;
+
 		gphy = devm_phy_create(dev, child, &ops);
 
 		if (IS_ERR(gphy)) {
@@ -559,6 +574,11 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
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

