Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38481C742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1731F2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfGLJrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:47:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50843 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726050AbfGLJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:47:38 -0400
X-UUID: fbf825e923e2446aa5c3e5c35cd7687e-20190712
X-UUID: fbf825e923e2446aa5c3e5c35cd7687e-20190712
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1616458437; Fri, 12 Jul 2019 17:47:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 12 Jul 2019 17:47:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 12 Jul 2019 17:47:23 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        "Owen Chen" <owen.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wsd_upstream@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v6 6/8] soc: mediatek: add MT6765 scpsys and subdomain support
Date:   Fri, 12 Jul 2019 17:43:42 +0800
Message-ID: <1562924653-10056-7-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mars Cheng <mars.cheng@mediatek.com>

This adds scpsys support for MT6765
Add subdomain support for MT6765:
isp, mm, connsys, mfg, and cam.

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 130 ++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index ea5a221a16e9..ff124c514e9c 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -16,6 +16,7 @@
 
 #include <dt-bindings/power/mt2701-power.h>
 #include <dt-bindings/power/mt2712-power.h>
+#include <dt-bindings/power/mt6765-power.h>
 #include <dt-bindings/power/mt6797-power.h>
 #include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/power/mt7623a-power.h>
@@ -869,6 +870,120 @@ static const struct scp_subdomain scp_subdomain_mt2712[] = {
 	{MT2712_POWER_DOMAIN_MFG_SC2, MT2712_POWER_DOMAIN_MFG_SC3},
 };
 
+/*
+ * MT6765 power domain support
+ */
+#define SPM_PWR_STATUS_MT6765			0x0180
+#define SPM_PWR_STATUS_2ND_MT6765		0x0184
+
+static const struct scp_domain_data scp_domain_data_mt6765[] = {
+	[MT6765_POWER_DOMAIN_VCODEC] = {
+		.name = "vcodec",
+		.sta_mask = BIT(26),
+		.ctl_offs = 0x300,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT6765_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = BIT(5),
+		.ctl_offs = 0x308,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.subsys_clk_prefix = "isp",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2A8, 0x2AC, 0, 0x258,
+				BIT(20), BIT(20)),
+			BUS_PROT(SMI_TYPE, 0x3C4, 0x3C8, 0, 0x3C0,
+				BIT(2), BIT(2)),
+		},
+	},
+	[MT6765_POWER_DOMAIN_MM] = {
+		.name = "mm",
+		.sta_mask = BIT(3),
+		.ctl_offs = 0x30C,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.basic_clk_id = {"mm"},
+		.subsys_clk_prefix = "mm",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2A8, 0x2AC, 0, 0x258,
+				BIT(16) | BIT(17), BIT(16) | BIT(17)),
+			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
+				BIT(10) | BIT(11), BIT(10) | BIT(11)),
+			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
+				BIT(1) | BIT(2), BIT(1) | BIT(2)),
+		},
+	},
+	[MT6765_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = BIT(1),
+		.ctl_offs = 0x32C,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
+				BIT(13), BIT(13)),
+			BUS_PROT(IFR_TYPE, 0x2A8, 0x2AC, 0, 0x258,
+				BIT(18), BIT(18)),
+			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
+				BIT(14) | BIT(16), BIT(14) | BIT(16)),
+		},
+	},
+	[MT6765_POWER_DOMAIN_MFG_ASYNC] = {
+		.name = "mfg_async",
+		.sta_mask = BIT(23),
+		.ctl_offs = 0x334,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.basic_clk_id = {"mfg"},
+	},
+	[MT6765_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = BIT(4),
+		.ctl_offs = 0x338,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
+				BIT(25), BIT(25)),
+			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
+				BIT(21) | BIT(22), BIT(21) | BIT(22)),
+		}
+	},
+	[MT6765_POWER_DOMAIN_CAM] = {
+		.name = "cam",
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x344,
+		.sram_pdn_bits = GENMASK(8, 9),
+		.sram_pdn_ack_bits = GENMASK(12, 13),
+		.subsys_clk_prefix = "cam",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2A8, 0x2AC, 0, 0x258,
+				BIT(19) | BIT(21), BIT(19) | BIT(21)),
+			BUS_PROT(IFR_TYPE, 0x2A0, 0x2A4, 0, 0x228,
+				BIT(20), BIT(20)),
+			BUS_PROT(SMI_TYPE, 0x3C4, 0x3C8, 0, 0x3C0,
+				BIT(3), BIT(3)),
+		}
+	},
+	[MT6765_POWER_DOMAIN_MFG_CORE0] = {
+		.name = "mfg_core0",
+		.sta_mask = BIT(7),
+		.ctl_offs = 0x34C,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+};
+
+static const struct scp_subdomain scp_subdomain_mt6765[] = {
+	{MT6765_POWER_DOMAIN_MM, MT6765_POWER_DOMAIN_CAM},
+	{MT6765_POWER_DOMAIN_MM, MT6765_POWER_DOMAIN_ISP},
+	{MT6765_POWER_DOMAIN_MM, MT6765_POWER_DOMAIN_VCODEC},
+	{MT6765_POWER_DOMAIN_MFG_ASYNC, MT6765_POWER_DOMAIN_MFG},
+	{MT6765_POWER_DOMAIN_MFG, MT6765_POWER_DOMAIN_MFG_CORE0},
+};
+
 /*
  * MT6797 power domain support
  */
@@ -1363,6 +1478,18 @@ static const struct scp_soc_data mt2712_data = {
 	.bus_prot_reg_update = false,
 };
 
+static const struct scp_soc_data mt6765_data = {
+	.domains = scp_domain_data_mt6765,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt6765),
+	.subdomains = scp_subdomain_mt6765,
+	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt6765),
+	.regs = {
+		.pwr_sta_offs = SPM_PWR_STATUS_MT6765,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6765,
+	},
+	.bus_prot_reg_update = true,
+};
+
 static const struct scp_soc_data mt6797_data = {
 	.domains = scp_domain_data_mt6797,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt6797),
@@ -1429,6 +1556,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt2712-scpsys",
 		.data = &mt2712_data,
+	}, {
+		.compatible = "mediatek,mt6765-scpsys",
+		.data = &mt6765_data,
 	}, {
 		.compatible = "mediatek,mt6797-scpsys",
 		.data = &mt6797_data,
-- 
2.18.0

