Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F76C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E9822DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566331214;
	bh=bbPgwOfacamIw6XEr0jX8ZS2sXxPby4C03F8bXxUXs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vKEBRnKrGgtcu/JkbMgAJgS9TnM9Xz157sFu1Y93PPmdEr/ZI4aiM4JQ41jbMzVaQ
	 tD5Y9wkEtuoUFqhdAUqhqr+ohHXvtBCaoZrC4t9TgC/31oziAablWEekD3kRFfwxgC
	 wcMwq98bJtuaoeH9hK77wHeWh7Ss3l7FzYP3wSEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfHTUAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:00:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46553 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTUAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:00:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id t24so5077455oij.13;
        Tue, 20 Aug 2019 13:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xp1mwVvsj/2inAIwWOULguGqWOlKMJGQ9M60Vravw4Q=;
        b=m7d+UAE96rfk2Np8Vi2TTVexXRhEOyEX5oT5LH56A3Rodnu0sgfc7433unj9PQJ8hL
         Mbon+ITmHFDCYgMyuy2ArOw0tDpcG5i2LHUkilJG0tQY+zdlURpFJU7vOb8Ldve5NY2O
         pQZXLNKoD0cG/BRkLMEIElAoRJ+h5zjcCp+HeUiamV9iQWb/yBwE2DBZ/GtSaCTYo/dO
         38nW7sTP3o6C9aKBGDLgSpVokN9TnXL4cTTq0T73K7tJ47Kq7wTtffNO6L3atgbvL+SS
         pJOmTxZy9kpUj9trVCeBacYzcZwlHmAw7qJ5RddtWS90tllvg5xQ4EVp7lfaPiDEW7Wq
         Bkrw==
X-Gm-Message-State: APjAAAWdOwcqnc3BnuRWl2VO8DARaqbwy7ka5R/6HGVoUy+ykoAR5OOp
        dBrDqTY8Ft09lxyYMzv6FqgucEI=
X-Google-Smtp-Source: APXvYqx5YB2qhcqioK+5whT74eUq0jYOHbPAnb1saLP8Njx6ijPIYaMXdLlXobw8s+lAyGInzVZssw==
X-Received: by 2002:aca:ec87:: with SMTP id k129mr1268913oih.80.1566331202439;
        Tue, 20 Aug 2019 13:00:02 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e22sm5082159oii.7.2019.08.20.13.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 13:00:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: Convert Arm Mali Midgard GPU to DT schema
Date:   Tue, 20 Aug 2019 14:59:57 -0500
Message-Id: <20190820195959.6126-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820195959.6126-1-robh@kernel.org>
References: <20190820195959.6126-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Arm Midgard GPU binding to DT schema format.

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
index 000000000000..24c4af74fb8d
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
+        - clocks
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

