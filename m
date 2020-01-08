Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CB3C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1F8206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UMKviDcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgAHIaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:30:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56180 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:30:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0088UGvx129217;
        Wed, 8 Jan 2020 02:30:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578472216;
        bh=OXxUci0KUCdGYZId9cqKL8rIYfQAjqBnFgpBE40z2ug=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UMKviDcxC7x1jcpzaNlJuNe9NmzZOoxGG+Dq+j0B91IzwvPJvHbR/fgCinmMkBsNd
         UVLTi6iH38W+e6PYDH7gsUrwx0V4BshglXoCobXAX89ikZfBFaHWKP1yrU9Mj8sPDa
         7WXGr5hQ4V5Q0b3zZpMfAMotMDSUelbGreUuiEiw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0088UGZX108345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 02:30:16 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 02:30:15 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 02:30:15 -0600
Received: from jadmar.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0088U8va048698;
        Wed, 8 Jan 2020 02:30:13 -0600
From:   Jyri Sarha <jsarha@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <yamonkar@cadence.com>,
        <sjakhade@cadence.com>, <robh+dt@kernel.org>, <kishon@ti.com>,
        <jsarha@ti.com>, <rogerq@ti.com>
Subject: [PATCH v2 2/2] phy: ti: j721e-wiz: Implement DisplayPort mode to the wiz driver
Date:   Wed, 8 Jan 2020 10:30:08 +0200
Message-ID: <08f35af7ad6b948bd6ccab9f0807e36b6ddfb1c3.1578471433.git.jsarha@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578471433.git.jsarha@ti.com>
References: <cover.1578471433.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For DisplayPort use we need to set WIZ_CONFIG_LANECTL register's
P_STANDARD_MODE bits to "mode 3". In the DisplayPort use also the
P_ENABLE bits of the same register are set to P_ENABLE instead of
P_ENABLE_FORCE, so that the DisplayPort driver can enable and disable
the lane as needed. The DisplayPort mode is selected according to
"cdns,phy-type"-properties found in link subnodes under the managed
serdes (see "ti,sierra-phy-t0" and "ti,j721e-serdes-10g" devicetree
bindings for details). All other values of "cdns,phy-type"-property
but PHY_TYPE_DP will set P_STANDARD_MODE bits to 0 and P_ENABLE bits
to force enable.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 59 +++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index b5f6019e5c7d..22bc04846cdb 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
+#include <dt-bindings/phy/phy.h>
 
 #define WIZ_SERDES_CTRL		0x404
 #define WIZ_SERDES_TOP_CTRL	0x408
@@ -78,6 +79,8 @@ static const struct reg_field p_enable[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANECTL(3), 30, 31),
 };
 
+enum p_enable { P_ENABLE = 2, P_ENABLE_FORCE = 1, P_ENABLE_DISABLE = 0 };
+
 static const struct reg_field p_align[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANECTL(0), 29, 29),
 	REG_FIELD(WIZ_LANECTL(1), 29, 29),
@@ -220,6 +223,7 @@ struct wiz {
 	struct reset_controller_dev wiz_phy_reset_dev;
 	struct gpio_desc	*gpio_typec_dir;
 	int			typec_dir_delay;
+	u32 lane_phy_type[WIZ_MAX_LANES];
 };
 
 static int wiz_reset(struct wiz *wiz)
@@ -242,12 +246,17 @@ static int wiz_reset(struct wiz *wiz)
 static int wiz_mode_select(struct wiz *wiz)
 {
 	u32 num_lanes = wiz->num_lanes;
+	enum wiz_lane_standard_mode mode;
 	int ret;
 	int i;
 
 	for (i = 0; i < num_lanes; i++) {
-		ret = regmap_field_write(wiz->p_standard_mode[i],
-					 LANE_MODE_GEN4);
+		if (wiz->lane_phy_type[i] == PHY_TYPE_DP)
+			mode = LANE_MODE_GEN1;
+		else
+			mode = LANE_MODE_GEN4;
+
+		ret = regmap_field_write(wiz->p_standard_mode[i], mode);
 		if (ret)
 			return ret;
 	}
@@ -707,7 +716,7 @@ static int wiz_phy_reset_assert(struct reset_controller_dev *rcdev,
 		return ret;
 	}
 
-	ret = regmap_field_write(wiz->p_enable[id - 1], false);
+	ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE_DISABLE);
 	return ret;
 }
 
@@ -734,7 +743,11 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
 		return ret;
 	}
 
-	ret = regmap_field_write(wiz->p_enable[id - 1], true);
+	if (wiz->lane_phy_type[id - 1] == PHY_TYPE_DP)
+		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE);
+	else
+		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE_FORCE);
+
 	return ret;
 }
 
@@ -761,6 +774,40 @@ static const struct of_device_id wiz_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, wiz_id_table);
 
+static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
+{
+	struct device_node *serdes, *subnode;
+
+	serdes = of_get_child_by_name(dev->of_node, "serdes");
+	if (!serdes) {
+		dev_err(dev, "%s: Getting \"serdes\"-node failed\n", __func__);
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(serdes, subnode) {
+		u32 reg, num_lanes = 1, phy_type = PHY_NONE;
+		int ret, i;
+
+		ret = of_property_read_u32(subnode, "reg", &reg);
+		if (ret) {
+			dev_err(dev,
+				"%s: Reading \"reg\" from \"%s\" failed: %d\n",
+				__func__, subnode->name, ret);
+			return ret;
+		}
+		of_property_read_u32(subnode, "cdns,num-lanes", &num_lanes);
+		of_property_read_u32(subnode, "cdns,phy-type", &phy_type);
+
+		dev_dbg(dev, "%s: Lanes %u-%u have phy-type %u\n", __func__,
+			reg, reg + num_lanes - 1, phy_type);
+
+		for (i = reg; i < reg + num_lanes; i++)
+			wiz->lane_phy_type[i] = phy_type;
+	}
+
+	return 0;
+}
+
 static int wiz_probe(struct platform_device *pdev)
 {
 	struct reset_controller_dev *phy_reset_dev;
@@ -844,6 +891,10 @@ static int wiz_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = wiz_get_lane_phy_types(dev, wiz);
+	if (ret)
+		return ret;
+
 	wiz->dev = dev;
 	wiz->regmap = regmap;
 	wiz->num_lanes = num_lanes;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

