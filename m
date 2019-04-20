Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2F9C282E4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C406721479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfDTONm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 10:13:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbfDTONm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 10:13:42 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 077F55220B089999B9AC;
        Sat, 20 Apr 2019 22:13:31 +0800 (CST)
Received: from SHA1000170415.huawei.com (100.106.92.139) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Sat, 20 Apr 2019 22:14:14 +0800
From:   Wanglai Shi <shiwanglai@hisilicon.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <xuwei5@hisilicon.com>, <mike.leach@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <leo.yan@linaro.org>, <suzhuangluan@hisilicon.com>,
        Wanglai Shi <shiwanglai@hisilicon.com>
Subject: [PATCH v4] arm64: dts: hi3660: Add CoreSight support
Date:   Sat, 20 Apr 2019 22:00:35 +0800
Message-ID: <1555768835-68555-1-git-send-email-shiwanglai@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.106.92.139]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings for the CoreSight trace components
on hi3660, which is used by 96boards Hikey960.

Signed-off-by: Wanglai Shi <shiwanglai@hisilicon.com>
---
 .../arm64/boot/dts/hisilicon/hi3660-coresight.dtsi | 456 +++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   2 +
 2 files changed, 458 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
new file mode 100644
index 0000000..d607f2f
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * dtsi for Hisilicon Hi3660 Coresight
+ *
+ * Copyright (C) 2016-2018 Hisilicon Ltd.
+ *
+ * Author: Wanglai Shi <shiwanglai@hisilicon.com>
+ *
+ */
+/ {
+	soc {
+		/* A53 cluster internals */
+		etm@ecc40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xecc40000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu0>;
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+							<&cluster0_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		etm@ecd40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xecd40000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu1>;
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+							<&cluster0_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		etm@ece40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xece40000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu2>;
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+							<&cluster0_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		etm@ecf40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xecf40000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu3>;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+							<&cluster0_funnel_in3>;
+					};
+				};
+			};
+		};
+
+		funnel@ec801000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0xec801000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					cluster0_funnel_out: endpoint {
+						remote-endpoint =
+							<&cluster0_etf_in>;
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
+					cluster0_funnel_in0: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					cluster0_funnel_in1: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					cluster0_funnel_in2: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					cluster0_funnel_in3: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+			};
+		};
+
+		etf@ec802000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0xec802000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					cluster0_etf_in: endpoint {
+						remote-endpoint =
+							<&cluster0_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					cluster0_etf_out: endpoint {
+						remote-endpoint =
+							<&combo_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		/* A73 cluster internals */
+		etm@ed440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xed440000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu4>;
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint =
+							<&cluster1_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		etm@ed540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xed540000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu5>;
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint =
+							<&cluster1_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		etm@ed640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xed640000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu6>;
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint =
+							<&cluster1_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		etm@ed740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0xed740000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu7>;
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint =
+							<&cluster1_funnel_in3>;
+					};
+				};
+			};
+		};
+
+		funnel@ed001000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0xed001000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+			out-ports {
+				port {
+					cluster1_funnel_out: endpoint {
+						remote-endpoint =
+							<&cluster1_etf_in>;
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
+					cluster1_funnel_in0: endpoint {
+						remote-endpoint = <&etm4_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					cluster1_funnel_in1: endpoint {
+						remote-endpoint = <&etm5_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					cluster1_funnel_in2: endpoint {
+						remote-endpoint = <&etm6_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					cluster1_funnel_in3: endpoint {
+						remote-endpoint = <&etm7_out>;
+					};
+				};
+			};
+		};
+
+		etf@ed002000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0xed002000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					cluster1_etf_in: endpoint {
+						remote-endpoint =
+							<&cluster1_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					cluster1_etf_out: endpoint {
+						remote-endpoint =
+							<&combo_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		/* An invisible combo funnel between clusters and top funnel */
+		funnel {
+			compatible = "arm,coresight-static-funnel";
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					combo_funnel_out: endpoint {
+						remote-endpoint =
+							<&top_funnel_in>;
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
+					combo_funnel_in0: endpoint {
+						remote-endpoint =
+							<&cluster0_etf_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					combo_funnel_in1: endpoint {
+						remote-endpoint =
+							<&cluster1_etf_out>;
+					};
+				};
+			};
+		};
+
+		/* Top internals */
+		funnel@ec031000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0xec031000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					top_funnel_out: endpoint {
+						remote-endpoint =
+							<&top_etf_in>;
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
+					top_funnel_in: endpoint {
+						remote-endpoint =
+							<&combo_funnel_out>;
+					};
+				};
+			};
+		};
+
+		etf@ec036000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0xec036000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					top_etf_in: endpoint {
+						remote-endpoint =
+							<&top_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					top_etf_out: endpoint {
+						remote-endpoint =
+							<&replicator_in>;
+					};
+				};
+			};
+		};
+
+		replicator {
+			compatible = "arm,coresight-static-replicator";
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint =
+							<&top_etf_out>;
+					};
+				};
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					replicator0_out0: endpoint {
+						remote-endpoint = <&etr_in>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					replicator0_out1: endpoint {
+						remote-endpoint = <&tpiu_in>;
+					};
+				};
+			};
+		};
+
+		etr@ec033000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0xec033000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint =
+							<&replicator0_out0>;
+					};
+				};
+			};
+		};
+
+		tpiu@ec032000 {
+			compatible = "arm,coresight-tpiu", "arm,primecell";
+			reg = <0 0xec032000 0 0x1000>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					tpiu_in: endpoint {
+						remote-endpoint =
+							<&replicator0_out1>;
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index a4a3d08..8f2fede 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1246,3 +1246,5 @@
 		};
 	};
 };
+
+#include "hi3660-coresight.dtsi"
-- 
2.7.4

