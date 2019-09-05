Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A22C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2F020828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY5nPbSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfIEIKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:10:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39515 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfIEIKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:10:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id s12so1224475pfe.6;
        Thu, 05 Sep 2019 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UKSyScUJ3tWhZqWmcbBMp/7C5WaFYHAGiecinJw7UKg=;
        b=dY5nPbSW378wxgrmqKRLBV7eO/24goMT9MyJNFw742sM6y1X+KJzqKsDR9kZkah4Wq
         3qM9bDFTK9LmM/JQk6xq6m41E+YViF3obQct8JRxnRPz6BHbKHv5iTH+5JI+DTBwVFfW
         cHWySglEPAjl3CapUJNzNzKdaOlEHa+IxxmxdZdYP7EZDSTrSBlP3+FHjaZb2G9CWg1+
         GBdcP5Fx83WIOVF2RgTBzNO00gAKK/FcRv71IrWP92IqO0Ss7ZQs/j8ybExLRj+1eb5j
         QAOyofDLd2lIZcRk7qaUBiVS4P4c+MSlMPPOFKbC2EgfSpWPsZygmCitmR0U/xcmBwY4
         cnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UKSyScUJ3tWhZqWmcbBMp/7C5WaFYHAGiecinJw7UKg=;
        b=GNdGbTcYPiS/v4q0sSbmGJGVqMT65w7o63gdAjst83EddW80+jpLXB7Fa8B7pHTMJZ
         lUwCMZJCPnxgzsy3BL72+rn2giFCgd6Mf6ZWPjb+WH01cAMSJv3k1rwAiQleOQhlK1nd
         cR49b+ckce3PCp3Z1VR+T7aiIppNEoxsShh3OBoZE3m2aQS7xBqZ0OFebozEf3zTdemz
         WhMCyRPiyL3se/QXeNm4pNJDq/bescKAH7POnZcOQHjMe79Q9ap4TwdGEHx1hdk57yJG
         1ptmsPYSE+UpJHm5kEjJfKo88JjGPeDrtW5tOEjglDMscYYP20v76VEsG36iAs9auh2j
         PT7A==
X-Gm-Message-State: APjAAAUFh7LFcOV/t0nsBYRhIxj3P70NJGFvPQ8sOuYwbMNxmht9Bp9Q
        YmHLQwtlHyoIiW0nykcdKMKi1Fr7
X-Google-Smtp-Source: APXvYqwe9M9Je969fgbbZZ9kkG3EHFtM+EaeJyJHcefWzFELOza1FKQBz060wt5M9gVd/LBTdl35cw==
X-Received: by 2002:a17:90a:bd08:: with SMTP id y8mr2535907pjr.89.1567671039789;
        Thu, 05 Sep 2019 01:10:39 -0700 (PDT)
Received: from localhost.localdomain ([49.216.8.243])
        by smtp.gmail.com with ESMTPSA id r18sm1195220pfc.3.2019.09.05.01.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 01:10:39 -0700 (PDT)
From:   jamestai.sky@gmail.com
X-Google-Original-From: james.tai@realtek.com
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        CY_Huang <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        "james.tai" <james.tai@realtek.com>
Subject: [PATCH] ARM: dts: realtek: Add support for Realtek RTD16XX evaluation board
Date:   Thu,  5 Sep 2019 16:08:35 +0800
Message-Id: <20190905080835.1376-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james.tai" <james.tai@realtek.com>

This patch adds a generic devicetree board file and a dtsi for
Realtek RTD16XX platform.

Signed-off-by: james.tai <james.tai@realtek.com>
---
 arch/arm/boot/dts/Makefile            |   2 +
 arch/arm/boot/dts/rtd1619-mjolnir.dts |  34 +++++++++
 arch/arm/boot/dts/rtd16xx.dtsi        | 101 ++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 arch/arm/boot/dts/rtd1619-mjolnir.dts
 create mode 100644 arch/arm/boot/dts/rtd16xx.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9159fa2cea90..4a37d54e78d1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1286,3 +1286,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-opp-zaius.dtb \
 	aspeed-bmc-portwell-neptune.dtb \
 	aspeed-bmc-quanta-q71l.dtb
+dtb-$(CONFIG_ARCH_RTD16XX) += \
+	rtd1619-mjolnir.dtb
diff --git a/arch/arm/boot/dts/rtd1619-mjolnir.dts b/arch/arm/boot/dts/rtd1619-mjolnir.dts
new file mode 100644
index 000000000000..75cf74eb0862
--- /dev/null
+++ b/arch/arm/boot/dts/rtd1619-mjolnir.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+/dts-v1/;
+
+#include "rtd16xx.dtsi"
+
+/ {
+	model= "Realtek Mjolnir Evaluation Board";
+	model_hex= <0x00000653>;
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlycon";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	uart0: serial0@98007800 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x0 0x98007800 0x0 0x400>,
+			<0x0 0x98007000 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <0 68 4>;
+		clock-frequency = <27000000>;
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/rtd16xx.dtsi b/arch/arm/boot/dts/rtd16xx.dtsi
new file mode 100644
index 000000000000..9f928bdabc42
--- /dev/null
+++ b/arch/arm/boot/dts/rtd16xx.dtsi
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/{
+	compatible = "realtek,rtd1619";
+	interrupt-parent = <&gic>;
+	#address-cells = <0x2>;
+	#size-cells = <0x2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		A55_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x000>;
+			next-level-cache = <&a55_l2>;
+		};
+
+		A55_1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x100>;
+			cpu-release-addr = <0x98007f30>;
+		};
+
+		A55_2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x200>;
+			cpu-release-addr = <0x98007f30>;
+		};
+
+		A55_3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x300>;
+			cpu-release-addr = <0x98007f30>;
+		};
+
+		A55_4: cpu@4 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x400>;
+			cpu-release-addr = <0x98007f30>;
+		};
+
+		A55_5: cpu@5 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55", "arm,armv8";
+			reg = <0x500>;
+			cpu-release-addr = <0x98007f30>;
+		};
+
+		a55_l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	arm_psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	gic: interrupt-controller@ff100000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		redistributor-stride = <0x0 0x20000>;
+		#redistributor-regions = <1>;
+		reg = <0x0 0xff100000 0x0 0x10000>, /* GICD */
+			<0x0 0xff140000 0x0 0x200000>; /* GICR */
+		interrupts = <GIC_PPI 9 4>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | 8)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | 8)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | 8)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | 8)>;
+		clock-frequency = <27000000>;
+	};
+
+	osc27M: osc27M {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+		clock-output-names = "osc27M";
+	};
+};
-- 
2.17.1

