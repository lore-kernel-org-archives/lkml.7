Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E674CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F18921D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439470AbfJYKa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:30:26 -0400
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:46379 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438845AbfJYKaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:30:24 -0400
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x9PATsr6052377
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 25 Oct 2019 18:29:54 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.79) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 25 Oct 2019 18:29:54
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 3/3] arm64: dts: Add Unisoc's SC9863A SoC support
Date:   Fri, 25 Oct 2019 18:29:15 +0800
Message-ID: <20191025102915.23677-4-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
References: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.79]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x9PATsr6052377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add basic DT to support Unisoc's SC9863A, with this patch,
the board sp9863a-1h10 can run into console.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/Makefile         |   3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 536 ++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi     | 188 ++++++++
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts |  40 ++
 4 files changed, 766 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts

diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dts/sprd/Makefile
index 2bdc23804f40..f4f1f5148cc2 100644
--- a/arch/arm64/boot/dts/sprd/Makefile
+++ b/arch/arm64/boot/dts/sprd/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb \
-			sp9860g-1h10.dtb
+			sp9860g-1h10.dtb	\
+			sp9863a-1h10.dtb
diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
new file mode 100644
index 000000000000..578d71a932d9
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unisoc SC9863A SoC DTS file
+ *
+ * Copyright (C) 2019, Unisoc Communications Inc.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "sharkl3.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+				core2 {
+					cpu = <&CPU2>;
+				};
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU4>;
+				};
+				core1 {
+					cpu = <&CPU5>;
+				};
+				core2 {
+					cpu = <&CPU6>;
+				};
+				core3 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x400>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x500>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x600>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x700>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+	};
+
+	idle-states {
+		entry-method = "arm,psci";
+		CORE_PD: core_pd {
+			compatible = "arm,idle-state";
+			entry-latency-us = <4000>;
+			exit-latency-us = <4000>;
+			min-residency-us = <10000>;
+			local-timer-stop;
+			arm,psci-suspend-param = <0x00010000>;
+		};
+	};
+
+	gic: interrupt-controller@14000000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		redistributor-stride = <0x0 0x20000>;	/* 128KB stride */
+		#redistributor-regions = <1>;
+		interrupt-controller;
+		reg = <0x0 0x14000000 0 0x20000>,	/* GICD */
+		      <0x0 0x14040000 0 0x100000>;	/* GICR */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		v2m_0: v2m@0 {
+			compatible = "arm,gic-v2m-frame";
+			msi-controller;
+			reg = <0 0 0 0x1000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* Physical Secure PPI */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Physical Non-Secure PPI */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Virtual PPI */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hipervisor PPI */
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		funnel@10001000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x10001000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_soc_out_port: endpoint {
+						remote-endpoint = <&etb_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_soc_in_port: endpoint {
+						remote-endpoint =
+						<&funnel_ca55_out_port>;
+					};
+				};
+			};
+		};
+
+		etb@10003000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x10003000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					etb_in: endpoint {
+						remote-endpoint =
+						<&funnel_soc_out_port>;
+					};
+				};
+			};
+		};
+
+		funnel@12001000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x12001000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_little_out_port: endpoint {
+						remote-endpoint =
+						<&etf_little_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_little_in_port0: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel_little_in_port1: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					funnel_little_in_port2: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					funnel_little_in_port3: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+			};
+		};
+
+		etf@12002000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x12002000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etf_little_out: endpoint {
+						remote-endpoint =
+						<&funnel_ca55_in_port0>;
+					};
+				};
+			};
+
+			in-port {
+				port {
+					etf_little_in: endpoint {
+						remote-endpoint =
+						<&funnel_little_out_port>;
+					};
+				};
+			};
+		};
+
+		etf@12003000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x12003000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etf_big_out: endpoint {
+						remote-endpoint =
+						<&funnel_ca55_in_port1>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					etf_big_in: endpoint {
+						remote-endpoint =
+						<&funnel_big_out_port>;
+					};
+				};
+			};
+		};
+
+		funnel@12004000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x12004000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_ca55_out_port: endpoint {
+						remote-endpoint =
+						<&funnel_soc_in_port>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_ca55_in_port0: endpoint {
+						remote-endpoint =
+						<&etf_little_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel_ca55_in_port1: endpoint {
+						remote-endpoint =
+						<&etf_big_out>;
+					};
+				};
+			};
+		};
+
+		funnel@12005000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x12005000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_big_out_port: endpoint {
+						remote-endpoint =
+						<&etf_big_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_big_in_port0: endpoint {
+						remote-endpoint = <&etm4_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel_big_in_port1: endpoint {
+						remote-endpoint = <&etm5_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					funnel_big_in_port2: endpoint {
+						remote-endpoint = <&etm6_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					funnel_big_in_port3: endpoint {
+						remote-endpoint = <&etm7_out>;
+					};
+				};
+			};
+		};
+
+		etm@13040000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x13040000 0 0x1000>;
+			cpu = <&CPU0>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+						<&funnel_little_in_port0>;
+					};
+				};
+			};
+		};
+
+		etm@13140000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x13140000 0 0x1000>;
+			cpu = <&CPU1>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+						<&funnel_little_in_port1>;
+					};
+				};
+			};
+		};
+
+		etm@13240000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x13240000 0 0x1000>;
+			cpu = <&CPU2>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+						<&funnel_little_in_port2>;
+					};
+				};
+			};
+		};
+
+		etm@13340000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x13340000 0 0x1000>;
+			cpu = <&CPU3>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+						<&funnel_little_in_port3>;
+					};
+				};
+			};
+		};
+
+		etm@13440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x13440000 0 0x1000>;
+			cpu = <&CPU4>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint =
+						<&funnel_big_in_port0>;
+					};
+				};
+			};
+		};
+
+		etm@13540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x13540000 0 0x1000>;
+			cpu = <&CPU5>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint =
+						<&funnel_big_in_port1>;
+					};
+				};
+			};
+		};
+
+		etm@13640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x13640000 0 0x1000>;
+			cpu = <&CPU6>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint =
+						<&funnel_big_in_port2>;
+					};
+				};
+			};
+		};
+
+		etm@13740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x13740000 0 0x1000>;
+			cpu = <&CPU7>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint =
+						<&funnel_big_in_port3>;
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/sprd/sharkl3.dtsi b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
new file mode 100644
index 000000000000..3ef233f70dc4
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unisoc Sharkl3 platform DTS file
+ *
+ * Copyright (C) 2019, Unisoc Communications Inc.
+ */
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ap_ahb_regs: syscon@20e00000 {
+			compatible = "syscon";
+			reg = <0 0x20e00000 0 0x10000>;
+		};
+
+		pub_apb_regs: syscon@300e0000 {
+			compatible = "syscon";
+			reg = <0 0x300e0000 0 0x10000>;
+		};
+
+		pub_ahb_regs: syscon@300f0000 {
+			compatible = "syscon";
+			reg = <0 0x300f0000 0 0x10000>;
+		};
+
+		aon_intc_regs: syscon@40200000 {
+			compatible = "syscon";
+			reg = <0 0x40200000 0 0x10000>;
+		};
+
+		pmu_regs: syscon@402b0000 {
+			compatible = "syscon";
+			reg = <0 0x402b0000 0 0x10000>;
+		};
+
+		aon_apb_regs: syscon@402e0000 {
+			compatible = "syscon";
+			reg = <0 0x402e0000 0 0x10000>;
+		};
+
+		anlg_phy_g1_regs: syscon@40350000 {
+			compatible = "syscon";
+			reg = <0 0x40350000 0 0x3000>;
+		};
+
+		anlg_phy_g2_regs: syscon@40353000 {
+			compatible = "syscon";
+			reg = <0 0x40353000 0 0x6000>;
+		};
+
+		anlg_phy_g4_regs: syscon@40359000 {
+			compatible = "syscon";
+			reg = <0 0x40359000 0 0x3000>;
+		};
+
+		anlg_phy_g5_regs: syscon@4035c000 {
+			compatible = "syscon";
+			reg = <0 0x4035c000 0 0x3000>;
+		};
+
+		anlg_phy_g7_regs: syscon@40363000 {
+			compatible = "syscon";
+			reg = <0 0x40363000 0 0x3000>;
+		};
+
+		anlg_wrap_wcn_regs: syscon@40366000 {
+			compatible = "syscon";
+			reg = <0 0x40366000 0 0x3000>;
+		};
+
+		wcn_regs: syscon@403a0000 {
+			compatible = "syscon";
+			reg = <0 0x403a0000 0 0x10000>;
+		};
+
+		ap_intc0_regs: syscon@40500000 {
+			compatible = "syscon";
+			reg = <0 0x40500000 0 0x10000>;
+		};
+
+		ap_intc1_regs: syscon@40510000 {
+			compatible = "syscon";
+			reg = <0 0x40510000 0 0x10000>;
+		};
+
+		ap_intc2_regs: syscon@40520000 {
+			compatible = "syscon";
+			reg = <0 0x40520000 0 0x10000>;
+		};
+
+		ap_intc3_regs: syscon@40530000 {
+			compatible = "syscon";
+			reg = <0 0x40530000 0 0x10000>;
+		};
+
+		ap_intc4_regs: syscon@40540000 {
+			compatible = "syscon";
+			reg = <0 0x40540000 0 0x10000>;
+		};
+
+		ap_intc5_regs: syscon@40550000 {
+			compatible = "syscon";
+			reg = <0 0x40550000 0 0x10000>;
+		};
+
+		mm_ahb_regs: syscon@60800000 {
+			compatible = "syscon";
+			reg = <0 0x60800000 0 0x10000>;
+		};
+
+		mm_vsp_ahb_regs: syscon@62000000 {
+			compatible = "syscon";
+			reg = <0 0x62000000 0 0x10000>;
+		};
+
+		ap_apb_regs: syscon@71300000 {
+			compatible = "syscon";
+			reg = <0 0x71300000 0 0x40000>;
+		};
+
+		ap-apb {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x70000000 0x10000000>;
+
+			uart0: serial@0 {
+				compatible = "sprd,sc9863-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x0 0x100>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+
+			uart1: serial@100000 {
+				compatible = "sprd,sc9863-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x100000 0x100>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+
+			uart2: serial@200000 {
+				compatible = "sprd,sc9863-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x200000 0x100>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+
+			uart3: serial@300000 {
+				compatible = "sprd,sc9863-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x300000 0x100>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+
+			uart4: serial@400000 {
+				compatible = "sprd,sc9863-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x400000 0x100>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+		};
+	};
+
+	ext_26m: ext-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "ext-26m";
+	};
+};
diff --git a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
new file mode 100644
index 000000000000..b6fbb5ca37e1
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unisoc SP9863A-1h10 boards DTS file
+ *
+ * Copyright (C) 2019, Unisoc Communications Inc.
+ */
+
+/dts-v1/;
+
+#include "sc9863a.dtsi"
+
+/ {
+	model = "Spreadtrum SP9863A-1H10 Board";
+
+	compatible = "sprd,sp9863a-1h10", "sprd,sc9863a";
+
+	sprd,sc-id = <9863 1 0x20000>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
-- 
2.20.1


