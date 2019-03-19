Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9137C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC75520872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfCSSNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:13:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38172 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfCSSNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:13:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 0648E281416
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
Cc:     Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH v2 4/5] arm64: dts: rk3399: Add dfi and dmc nodes.
Date:   Tue, 19 Mar 2019 14:13:22 -0400
Message-Id: <20190319181323.22804-5-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319181323.22804-1-gael.portay@collabora.com>
References: <20190319181323.22804-1-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

These are required to support DDR DVFS on rk3399 platform. The patch also
introduces a new file with default DRAM settings.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---

Changes in v2:
- [PATCH 7/8] Reword the commit message to reflect the removal of
              rk3390-dram-default-timing.dts in v1.

Changes in v1:
- [RFC 8/10] Move rk3399-dram.h to dt-includes.
- [RFC 8/10] Put sdram default values under the dmc node.
- [RFC 8/10] Removed rk3399-dram-default-timing.dts

 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 49 +++++++++++++
 include/dt-bindings/power/rk3399-dram.h       | 73 +++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3399-dram.h

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
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index db9d948c0b03..8fe86a3e7658 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/power/rk3399-dram.h>
 #include <dt-bindings/power/rk3399-power.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -1885,6 +1886,54 @@
 		status = "disabled";
 	};
 
+	dfi: dfi@ff630000 {
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		compatible = "rockchip,rk3399-dfi";
+		rockchip,pmu = <&pmugrf>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+		status = "disabled";
+	};
+
+	dmc: dmc {
+		compatible = "rockchip,rk3399-dmc";
+		rockchip,pmu = <&pmugrf>;
+		devfreq-events = <&dfi>;
+		clocks = <&cru SCLK_DDRC>;
+		clock-names = "dmc_clk";
+		status = "disabled";
+		rockchip,ddr3_speed_bin = <21>;
+		rockchip,pd_idle = <0x40>;
+		rockchip,sr_idle = <0x2>;
+		rockchip,sr_mc_gate_idle = <0x3>;
+		rockchip,srpd_lite_idle	= <0x4>;
+		rockchip,standby_idle = <0x2000>;
+		rockchip,dram_dll_dis_freq = <300000000>;
+		rockchip,phy_dll_dis_freq = <125000000>;
+		rockchip,auto_pd_dis_freq = <666000000>;
+		rockchip,ddr3_odt_dis_freq = <333000000>;
+		rockchip,ddr3_drv = <DDR3_DS_40ohm>;
+		rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
+		rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
+		rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
+		rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
+		rockchip,lpddr3_odt_dis_freq = <333000000>;
+		rockchip,lpddr3_drv = <LP3_DS_34ohm>;
+		rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
+		rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
+		rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
+		rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
+		rockchip,lpddr4_odt_dis_freq = <333000000>;
+		rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
+		rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
+		rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
+		rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
+		rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
+		rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
+		rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3399-pinctrl";
 		rockchip,grf = <&grf>;
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

