Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2AEC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA769206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugY99uCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLWJav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:30:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42730 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfLWJas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:30:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so8509537pgb.9;
        Mon, 23 Dec 2019 01:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8tX50BrKCAet3F0yJGlo9yzdS9aF8SwNQ6hNK9VrFQ=;
        b=ugY99uCgvRHOLYbI7XpbRN09Qh56/qa4QE5hOTt/PyJWqFDzp7V79Fr3gVNxRlioNS
         Qsc7CZz/yeUFpg45IENLRULgz0afAAnfk0vhv6I/SyhQthq1SDAeVoQP6VMcqJ2ELSKP
         2j6BSEX9iO3UdGlPr4Pahqi3i7993uGmHu03MsdxQJ7J6mxjCNiwgrLJbb2qhHjTF9Bx
         uF0jJhbOZEwsaH5w1tZjM/hmg3oxuqewgbyPRyPzFRgMgyb1bmqmY9iUaBvGqKX+TsXJ
         tBeD9eX3hjaBczbNP56ndaKeEvEM+im/9UHgSS2ZTnxHSBIX/3J5kvF0KV3smNhAsdGG
         OGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8tX50BrKCAet3F0yJGlo9yzdS9aF8SwNQ6hNK9VrFQ=;
        b=I/r1QBWXaTL6L5EqgGFOWvbFaTvdz1BISSoxepzlHDIl7qufzlOk+mRb35trtoBHG0
         8SAErzKSc5wgXXURGDQBRIAl/yV/LwlHK9KeD48oX54gsqxDIFRotdFEmm+/n6L8fKEH
         0jaG9IcMfMk6IBpEHdUul+CoQ3nXwxirLMr0FC05LoBaM2z1+ZLOtLRQjnwRRY33RX3A
         a1xh6dnz/qBsHkxeBoUtxYGQwTqo1A9O4TzTbEeEgOq4b/vqWoxzUuORvs4qhxTzpsvg
         tfsNpJLZ386CuctbQhqJHvkGcn9IELiEvGvPVsyBsOxS/uSkur4haiIfe8qrNBLz4sOi
         2ewQ==
X-Gm-Message-State: APjAAAWTBJsDGJw/dKiNaDcWdVYmV9x9pQj30R+GSwtVbNpO12PihBrS
        2C9FOQ90wbTgcrr9o+Jqf4A=
X-Google-Smtp-Source: APXvYqzZs42QrZP5lEE1tkaAWzWiiPap4DLdfu9Y7x07/+eWKcjDjMn3lc6ZbBFNiurLDnD93lWVgA==
X-Received: by 2002:a65:420d:: with SMTP id c13mr31045579pgq.101.1577093446556;
        Mon, 23 Dec 2019 01:30:46 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id i127sm24625970pfc.55.2019.12.23.01.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:30:45 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v5 3/3] arm64: dts: Add Unisoc's SC9863A SoC support
Date:   Mon, 23 Dec 2019 17:29:48 +0800
Message-Id: <20191223092948.24824-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191223092948.24824-1-zhang.lyra@gmail.com>
References: <20191223092948.24824-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add basic DT to support Unisoc's SC9863A, with this patch,
the board sp9863a-1h10 can run into console.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/Makefile         |   3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 523 ++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi     |  78 ++++
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts |  39 ++
 4 files changed, 642 insertions(+), 1 deletion(-)
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
index 000000000000..cd80756c888d
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unisoc SC9863A SoC DTS file
+ *
+ * Copyright (C) 2019, Unisoc Inc.
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
+				core4 {
+					cpu = <&CPU4>;
+				};
+				core5 {
+					cpu = <&CPU5>;
+				};
+				core6 {
+					cpu = <&CPU6>;
+				};
+				core7 {
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
+		CORE_PD: core-pd {
+			compatible = "arm,idle-state";
+			entry-latency-us = <4000>;
+			exit-latency-us = <4000>;
+			min-residency-us = <10000>;
+			local-timer-stop;
+			arm,psci-suspend-param = <0x00010000>;
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
+		gic: interrupt-controller@14000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			redistributor-stride = <0x0 0x20000>;	/* 128KB stride */
+			#redistributor-regions = <1>;
+			interrupt-controller;
+			reg = <0x0 0x14000000 0 0x20000>,	/* GICD */
+			      <0x0 0x14040000 0 0x100000>;	/* GICR */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
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
+				port {
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
index 000000000000..0222128b10f7
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unisoc Sharkl3 platform DTS file
+ *
+ * Copyright (C) 2019, Unisoc Inc.
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
+		apb@70000000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x70000000 0x10000000>;
+
+			uart0: serial@0 {
+				compatible = "sprd,sc9863a-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x0 0x100>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+
+			uart1: serial@100000 {
+				compatible = "sprd,sc9863a-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x100000 0x100>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+
+			uart2: serial@200000 {
+				compatible = "sprd,sc9863a-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x200000 0x100>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+
+			uart3: serial@300000 {
+				compatible = "sprd,sc9863a-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x300000 0x100>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+
+			uart4: serial@400000 {
+				compatible = "sprd,sc9863a-uart",
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
index 000000000000..5c32c1596337
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unisoc SP9863A-1h10 boards DTS file
+ *
+ * Copyright (C) 2019, Unisoc Inc.
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
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+		bootargs = "earlycon";
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

