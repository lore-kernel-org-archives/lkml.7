Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5302CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 09:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D872067B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 09:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfJ0JJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 05:09:57 -0400
Received: from mx1.unisoc.com ([222.66.158.135]:27261 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726079AbfJ0JJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 05:09:57 -0400
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x9R99ZfK087430
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 27 Oct 2019 17:09:35 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.79) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sun, 27 Oct 2019 17:09:42
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 1/2] arm64: dts: Add SC9863A clock nodes
Date:   Sun, 27 Oct 2019 17:09:02 +0800
Message-ID: <20191027090904.14349-2-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027090904.14349-1-chunyan.zhang@unisoc.com>
References: <20191027090904.14349-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.79]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x9R99ZfK087430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add clock devicetree nodes for SC9863A.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/sc9863a.dtsi | 94 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi | 21 ++++++
 2 files changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index 578d71a932d9..ceecf551fd01 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sprd,sc9863a-clk.h>
 #include "sharkl3.dtsi"
 
 / {
@@ -168,6 +169,99 @@
 	};
 
 	soc {
+		apahb_gate: apahb-gate {
+			compatible = "sprd,sc9863a-apahb-gate";
+			sprd,syscon = <&ap_ahb_regs>; /* 0x20e00000 */
+			clocks = <&aon_clk CLK_AP_AXI>;
+			#clock-cells = <1>;
+		};
+
+		ap_clk: clock-controller@21500000 {
+			compatible = "sprd,sc9863a-ap-clk";
+			reg = <0 0x21500000 0 0x1000>;
+			clocks = <&ext_32k>, <&ext_26m>,
+				 <&pll 0>, <&rpll 0>;
+			#clock-cells = <1>;
+		};
+
+		pmu_gate: pmu-gate {
+			compatible = "sprd,sc9863a-pmu-gate";
+			sprd,syscon = <&pmu_regs>; /* 0x402b0000 */
+			clocks = <&ext_26m>;
+			#clock-cells = <1>;
+		};
+
+		aon_clk: clock-controller@402d0000 {
+			compatible = "sprd,sc9863a-aon-clk";
+			reg = <0 0x402d0000 0 0x1000>;
+			clocks = <&ext_26m>, <&pll 0>,
+				 <&rpll 0>, <&dpll 0>;
+			#clock-cells = <1>;
+		};
+
+		aonapb_gate: aonapb-gate {
+			compatible = "sprd,sc9863a-aonapb-gate";
+			sprd,syscon = <&aon_apb_regs>; /* 0x402e0000 */
+			clocks = <&aon_clk CLK_AON_APB>;
+			#clock-cells = <1>;
+		};
+
+		pll: pll {
+			compatible = "sprd,sc9863a-pll";
+			sprd,syscon = <&anlg_phy_g2_regs>; /* 0x40353000 */
+			clocks = <&pmu_gate 0>;
+			#clock-cells = <1>;
+		};
+
+		mpll: mpll {
+			compatible = "sprd,sc9863a-mpll";
+			sprd,syscon = <&anlg_phy_g4_regs>; /* 0x40359000 */
+			clocks = <&pmu_gate 0>;
+			#clock-cells = <1>;
+		};
+
+		rpll: rpll {
+			compatible = "sprd,sc9863a-rpll";
+			sprd,syscon = <&anlg_phy_g5_regs>; /* 0x4035c000 */
+			clocks = <&pmu_gate 0>;
+			#clock-cells = <1>;
+		};
+
+		dpll: dpll {
+			compatible = "sprd,sc9863a-dpll";
+			sprd,syscon = <&anlg_phy_g7_regs>; /* 0x40363000 */
+			clocks = <&pmu_gate 0>;
+			#clock-cells = <1>;
+		};
+
+		mm_gate: mm-gate {
+			compatible = "sprd,sc9863a-mm-gate";
+			sprd,syscon = <&mm_ahb_regs>; /* 0x60800000 */
+			clocks = <&aon_clk CLK_MM_AHB>;
+			#clock-cells = <1>;
+		};
+
+		mm_clk: clock-controller@60900000 {
+			compatible = "sprd,sc9863a-mm-clk";
+			reg = <0 0x60900000 0 0x1000>; /* 0x60900000 */
+			clocks = <&aon_clk CLK_MM_AHB>;
+			#clock-cells = <1>;
+		};
+
+		vspahb_gate: vspahb-gate {
+			compatible = "sprd,sc9863a-vspahb-gate";
+			sprd,syscon = <&mm_vsp_ahb_regs>; /* 0x62000000 */
+			clocks = <&aon_clk CLK_MM_AHB>;
+			#clock-cells = <1>;
+		};
+
+		apapb_gate: apapb-gate {
+			compatible = "sprd,sc9863a-apapb-gate";
+			sprd,syscon = <&ap_apb_regs>; /* 0x71300000 */
+			clocks = <&ext_26m>;
+			#clock-cells = <1>;
+		};
+
 		funnel@10001000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0 0x10001000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/sprd/sharkl3.dtsi b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
index 3ef233f70dc4..938cd62e6636 100644
--- a/arch/arm64/boot/dts/sprd/sharkl3.dtsi
+++ b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
@@ -185,4 +185,25 @@
 		clock-frequency = <26000000>;
 		clock-output-names = "ext-26m";
 	};
+
+	ext_32k: ext-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ext_32k";
+	};
+
+	ext_4m: ext-4m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <4000000>;
+		clock-output-names = "ext-4m";
+	};
+
+	rco_100m: rco-100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "rco-100m";
+	};
 };
-- 
2.20.1


