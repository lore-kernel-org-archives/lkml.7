Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0728AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC66B22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567028709;
	bh=MjiH34m3D13cUdaSyDqBMLbF31r5OOxnmMOwGQT8UiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=afu3z5h96U0n8sVQjH/BxK4/gbigV2JCS/nI8YxM02Ua9VAPHPPcANuYClUoPL0b1
	 R1rb6XoW6Gv6goeISUFrV+qPw5P4YoT2GjB+RO5PtWfvW8tg712ZyMCHDYzs4wUYv1
	 TYe9QXIooVqCAlOKjuMc9oZYSFOZXiyDKvHAJ3Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfH1VpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:45:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43143 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfH1VpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:45:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so1327386otp.10;
        Wed, 28 Aug 2019 14:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wnrCQOU0UovoodpLBKXvpvoVYPF56aYnHH1OtT8mNs=;
        b=hL2kkhZSDVDpgUg9fdfcXA/ab3p/cg5oetVNP5ndpgQ+DA0BNaJ0MquXZthLFUexNx
         Mlc4QzivBqUFkrjOH1VF8vi/2o7hAwRz38HjtMyDs7LV2zvCDmZPJ7lEyQ5weiijWhtR
         QzUXgkw9Tw+2KN+mSFQ/w/5WuwWcZ/n8j9XveTyL4fzVJRLlZNngFt3yHDQxOc1cJkQG
         ShJhtukNm0YMmkeiReRABlFFb3urKUw6zXFjuWIi5hd0mfnXKVTQr/YiFBVE/A29LiFE
         TnGLdfRsSSmeGT2pPfE1j6LBjBH87X9uvsP0y2dlf1dDkvlyvMAoSTotS4x6SLFP5Gdk
         OlBA==
X-Gm-Message-State: APjAAAW3wMQFZFjIfxWkmefo01I1LkiyYQ3IAwDVXVLTt2ez5KOBCXbw
        TfoJJWNyY82kWm8BRsMWhhXKNe8=
X-Google-Smtp-Source: APXvYqzrK6k8sg39gUnv1AKxB7J13YD4gaipCI+eE1ao5M/HmJGNcTA2rJjCAtW2AIhwa7odz5jZEg==
X-Received: by 2002:a9d:5a85:: with SMTP id w5mr5071302oth.302.1567028704584;
        Wed, 28 Aug 2019 14:45:04 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id p11sm102431oto.4.2019.08.28.14.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:45:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 1/3] dt-bindings: Convert Arm Mali Midgard GPU to DT schema
Date:   Wed, 28 Aug 2019 16:45:00 -0500
Message-Id: <20190828214502.12293-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828214502.12293-1-robh@kernel.org>
References: <20190828214502.12293-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Arm Midgard GPU binding to DT schema format.

The 'clocks' property is now required. This simplifies the schema as
effectively all the users require 'clocks' already and the upstream
driver requires at least one clock.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/gpu/arm,mali-midgard.txt         | 119 -------------
 .../bindings/gpu/arm,mali-midgard.yaml        | 165 ++++++++++++++++++
 2 files changed, 165 insertions(+), 119 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
deleted file mode 100644
index 9b298edec5b2..000000000000
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ /dev/null
@@ -1,119 +0,0 @@
-ARM Mali Midgard GPU
-====================
-
-Required properties:
-
-- compatible :
-  * Must contain one of the following:
-    + "arm,mali-t604"
-    + "arm,mali-t624"
-    + "arm,mali-t628"
-    + "arm,mali-t720"
-    + "arm,mali-t760"
-    + "arm,mali-t820"
-    + "arm,mali-t830"
-    + "arm,mali-t860"
-    + "arm,mali-t880"
-  * which must be preceded by one of the following vendor specifics:
-    + "allwinner,sun50i-h6-mali"
-    + "amlogic,meson-gxm-mali"
-    + "samsung,exynos5433-mali"
-    + "rockchip,rk3288-mali"
-    + "rockchip,rk3399-mali"
-
-- reg : Physical base address of the device and length of the register area.
-
-- interrupts : Contains the three IRQ lines required by Mali Midgard devices.
-
-- interrupt-names : Contains the names of IRQ resources in the order they were
-  provided in the interrupts property. Must contain: "job", "mmu", "gpu".
-
-
-Optional properties:
-
-- clocks : Phandle to clock for the Mali Midgard device.
-
-- clock-names : Specify the names of the clocks specified in clocks
-  when multiple clocks are present.
-    * core: clock driving the GPU itself (When only one clock is present,
-      assume it's this clock.)
-    * bus: bus clock for the GPU
-
-- mali-supply : Phandle to regulator for the Mali device. Refer to
-  Documentation/devicetree/bindings/regulator/regulator.txt for details.
-
-- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
-  for details.
-
-- #cooling-cells: Refer to Documentation/devicetree/bindings/thermal/thermal.txt
-  for details.
-
-- resets : Phandle of the GPU reset line.
-
-Vendor-specific bindings
-------------------------
-
-The Mali GPU is integrated very differently from one SoC to
-another. In order to accommodate those differences, you have the option
-to specify one more vendor-specific compatible, among:
-
-- "allwinner,sun50i-h6-mali"
-  Required properties:
-  - clocks : phandles to core and bus clocks
-  - clock-names : must contain "core" and "bus"
-  - resets: phandle to GPU reset line
-
-- "amlogic,meson-gxm-mali"
-  Required properties:
-  - resets : Should contain phandles of :
-    + GPU reset line
-    + GPU APB glue reset line
-
-Example for a Mali-T760:
-
-gpu@ffa30000 {
-	compatible = "rockchip,rk3288-mali", "arm,mali-t760";
-	reg = <0xffa30000 0x10000>;
-	interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "job", "mmu", "gpu";
-	clocks = <&cru ACLK_GPU>;
-	mali-supply = <&vdd_gpu>;
-	operating-points-v2 = <&gpu_opp_table>;
-	power-domains = <&power RK3288_PD_GPU>;
-	#cooling-cells = <2>;
-};
-
-gpu_opp_table: opp_table0 {
-	compatible = "operating-points-v2";
-
-	opp@533000000 {
-		opp-hz = /bits/ 64 <533000000>;
-		opp-microvolt = <1250000>;
-	};
-	opp@450000000 {
-		opp-hz = /bits/ 64 <450000000>;
-		opp-microvolt = <1150000>;
-	};
-	opp@400000000 {
-		opp-hz = /bits/ 64 <400000000>;
-		opp-microvolt = <1125000>;
-	};
-	opp@350000000 {
-		opp-hz = /bits/ 64 <350000000>;
-		opp-microvolt = <1075000>;
-	};
-	opp@266000000 {
-		opp-hz = /bits/ 64 <266000000>;
-		opp-microvolt = <1025000>;
-	};
-	opp@160000000 {
-		opp-hz = /bits/ 64 <160000000>;
-		opp-microvolt = <925000>;
-	};
-	opp@100000000 {
-		opp-hz = /bits/ 64 <100000000>;
-		opp-microvolt = <912500>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
new file mode 100644
index 000000000000..b99a43bb471a
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/arm,mali-midgard.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali Midgard GPU
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  $nodename:
+    pattern: '^gpu@[a-f0-9]+$'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+             - allwinner,sun50i-h6-mali
+          - const: arm,mali-t720
+      - items:
+          - enum:
+             - amlogic,meson-gxm-mali
+          - const: arm,mali-t820
+      - items:
+          - enum:
+             - rockchip,rk3288-mali
+          - const: arm,mali-t760
+      - items:
+          - enum:
+             - rockchip,rk3399-mali
+          - const: arm,mali-t860
+      - items:
+          - enum:
+             - samsung,exynos5433-mali
+          - const: arm,mali-t760
+
+          # "arm,mali-t604"
+          # "arm,mali-t624"
+          # "arm,mali-t628"
+          # "arm,mali-t830"
+          # "arm,mali-t880"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Job interrupt
+      - description: MMU interrupt
+      - description: GPU interrupt
+
+  interrupt-names:
+    items:
+      - const: job
+      - const: mmu
+      - const: gpu
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: bus
+
+  mali-supply:
+    maxItems: 1
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  operating-points-v2: true
+
+  "#cooling-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h6-mali
+    then:
+      properties:
+        clocks:
+          minItems: 2
+      required:
+        - clock-names
+        - resets
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amlogic,meson-gxm-mali
+    then:
+      properties:
+        resets:
+          minItems: 2
+      required:
+        - resets
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu@ffa30000 {
+      compatible = "rockchip,rk3288-mali", "arm,mali-t760";
+      reg = <0xffa30000 0x10000>;
+      interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "job", "mmu", "gpu";
+      clocks = <&cru 0>;
+      mali-supply = <&vdd_gpu>;
+      operating-points-v2 = <&gpu_opp_table>;
+      power-domains = <&power 0>;
+      #cooling-cells = <2>;
+    };
+
+    gpu_opp_table: opp_table0 {
+      compatible = "operating-points-v2";
+
+      opp@533000000 {
+        opp-hz = /bits/ 64 <533000000>;
+        opp-microvolt = <1250000>;
+      };
+      opp@450000000 {
+        opp-hz = /bits/ 64 <450000000>;
+        opp-microvolt = <1150000>;
+      };
+      opp@400000000 {
+        opp-hz = /bits/ 64 <400000000>;
+        opp-microvolt = <1125000>;
+      };
+      opp@350000000 {
+        opp-hz = /bits/ 64 <350000000>;
+        opp-microvolt = <1075000>;
+      };
+      opp@266000000 {
+        opp-hz = /bits/ 64 <266000000>;
+        opp-microvolt = <1025000>;
+      };
+      opp@160000000 {
+        opp-hz = /bits/ 64 <160000000>;
+        opp-microvolt = <925000>;
+      };
+      opp@100000000 {
+        opp-hz = /bits/ 64 <100000000>;
+        opp-microvolt = <912500>;
+      };
+    };
+
+...
-- 
2.20.1

