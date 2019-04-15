Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BFEC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BB020880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfDOVaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:30:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46948 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfDOVaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:30:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 41C022824B3
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH v4 5/5] arm64: dts: rockchip: Enable dmc and dfi nodes on gru.
Date:   Mon, 15 Apr 2019 17:29:48 -0400
Message-Id: <20190415212948.7736-6-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415212948.7736-1-gael.portay@collabora.com>
References: <20190415212948.7736-1-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY
Interface) nodes on gru boards so we can support DDR DVFS.

The patch also introduces a new file with default DRAM settings.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---

Changes in v4:
- [PATCH v3 5/5] Add board related DDR settings (moved from 4/5).

Changes in v3:
- [PATCH v2 5/5] Remove display_subsystem nodes.

Changes in v2:
- [PATCH 8/8] Move center-supply attribute of dmc node in file
              rk3399-gru-chromebook.dtsi (where ppvar_centerlogic is
	      defined).

Changes in v1: None

 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 46 ++++++++++++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++
 include/dt-bindings/power/rk3399-dram.h       | 73 +++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3399-dram.h

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 931640e9aed4..cfb81356c61e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -400,3 +400,7 @@ ap_i2c_tp: &i2c5 {
 		rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_none>;
 	};
 };
+
+&dmc {
+	center-supply = <&ppvar_centerlogic>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index da03fa9c5662..40e78186560b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/power/rk3399-dram.h>
 #include "rk3399.dtsi"
 #include "rk3399-op1-opp.dtsi"
 
@@ -289,6 +290,12 @@
 	status = "okay";
 };
 
+&dmc_opp_table {
+	opp04 {
+		opp-suspend;
+	};
+};
+
 /*
  * Set some suspend operating points to avoid OVP in suspend
  *
@@ -489,6 +496,45 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 };
 
+&dfi {
+	status = "okay";
+};
+
+&dmc {
+	status = "okay";
+	upthreshold = <25>;
+	downdifferential = <15>;
+	rockchip,ddr3_speed_bin = <21>;
+	rockchip,pd_idle = <0x40>;
+	rockchip,sr_idle = <0x2>;
+	rockchip,sr_mc_gate_idle = <0x3>;
+	rockchip,srpd_lite_idle	= <0x4>;
+	rockchip,standby_idle = <0x2000>;
+	rockchip,dram_dll_dis_freq = <300000000>;
+	rockchip,phy_dll_dis_freq = <125000000>;
+	rockchip,auto_pd_dis_freq = <666000000>;
+	rockchip,ddr3_odt_dis_freq = <333000000>;
+	rockchip,ddr3_drv = <DDR3_DS_40ohm>;
+	rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
+	rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
+	rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
+	rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
+	rockchip,lpddr3_odt_dis_freq = <333000000>;
+	rockchip,lpddr3_drv = <LP3_DS_34ohm>;
+	rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
+	rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
+	rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
+	rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
+	rockchip,lpddr4_odt_dis_freq = <333000000>;
+	rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
+	rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
+	rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
+	rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
+	rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
+	rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
+	rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;
+};
+
 &sdhci {
 	/*
 	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
index 69cc9b05baa5..c9e7032b01a8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
@@ -110,6 +110,31 @@
 			opp-microvolt = <1075000>;
 		};
 	};
+
+	dmc_opp_table: dmc_opp_table {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <666000000>;
+			opp-microvolt = <900000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <928000000>;
+			opp-microvolt = <900000>;
+		};
+	};
 };
 
 &cpu_l0 {
@@ -139,3 +164,7 @@
 &gpu {
 	operating-points-v2 = <&gpu_opp_table>;
 };
+
+&dmc {
+	operating-points-v2 = <&dmc_opp_table>;
+};
diff --git a/include/dt-bindings/power/rk3399-dram.h b/include/dt-bindings/power/rk3399-dram.h
new file mode 100644
index 000000000000..4b3d4a79923b
--- /dev/null
+++ b/include/dt-bindings/power/rk3399-dram.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR X11) */
+/*
+ * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * Author: Lin Huang <hl@rock-chips.com>
+ */
+
+#ifndef _DTS_DRAM_ROCKCHIP_RK3399_H
+#define _DTS_DRAM_ROCKCHIP_RK3399_H
+
+#define DDR3_DS_34ohm		34
+#define DDR3_DS_40ohm		40
+
+#define DDR3_ODT_DIS		0
+#define DDR3_ODT_40ohm		40
+#define DDR3_ODT_60ohm		60
+#define DDR3_ODT_120ohm		120
+
+#define LP2_DS_34ohm		34
+#define LP2_DS_40ohm		40
+#define LP2_DS_48ohm		48
+#define LP2_DS_60ohm		60
+#define LP2_DS_68_6ohm		68	/* optional */
+#define LP2_DS_80ohm		80
+#define LP2_DS_120ohm		120	/* optional */
+
+#define LP3_DS_34ohm		34
+#define LP3_DS_40ohm		40
+#define LP3_DS_48ohm		48
+#define LP3_DS_60ohm		60
+#define LP3_DS_80ohm		80
+#define LP3_DS_34D_40U		3440
+#define LP3_DS_40D_48U		4048
+#define LP3_DS_34D_48U		3448
+
+#define LP3_ODT_DIS		0
+#define LP3_ODT_60ohm		60
+#define LP3_ODT_120ohm		120
+#define LP3_ODT_240ohm		240
+
+#define LP4_PDDS_40ohm		40
+#define LP4_PDDS_48ohm		48
+#define LP4_PDDS_60ohm		60
+#define LP4_PDDS_80ohm		80
+#define LP4_PDDS_120ohm		120
+#define LP4_PDDS_240ohm		240
+
+#define LP4_DQ_ODT_40ohm	40
+#define LP4_DQ_ODT_48ohm	48
+#define LP4_DQ_ODT_60ohm	60
+#define LP4_DQ_ODT_80ohm	80
+#define LP4_DQ_ODT_120ohm	120
+#define LP4_DQ_ODT_240ohm	240
+#define LP4_DQ_ODT_DIS		0
+
+#define LP4_CA_ODT_40ohm	40
+#define LP4_CA_ODT_48ohm	48
+#define LP4_CA_ODT_60ohm	60
+#define LP4_CA_ODT_80ohm	80
+#define LP4_CA_ODT_120ohm	120
+#define LP4_CA_ODT_240ohm	240
+#define LP4_CA_ODT_DIS		0
+
+#define PHY_DRV_ODT_Hi_Z	0
+#define PHY_DRV_ODT_240		240
+#define PHY_DRV_ODT_120		120
+#define PHY_DRV_ODT_80		80
+#define PHY_DRV_ODT_60		60
+#define PHY_DRV_ODT_48		48
+#define PHY_DRV_ODT_40		40
+#define PHY_DRV_ODT_34_3	34
+
+#endif /* _DTS_DRAM_ROCKCHIP_RK3399_H */
-- 
2.21.0

