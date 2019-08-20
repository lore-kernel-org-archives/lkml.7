Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55766C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C6022DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566331207;
	bh=r+/SYnbeYk+h1Ci9pD4s/cJ2GNMb4BbGPXN9KVMcdF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0K+iTvzcOU1UMzH2/rYCmNmg5my2Mc+/eGMmsm4MY/0GFKXtrRy4r+YelXuWp0fFQ
	 PHhRkC1ulJjMaBaxFNKKaldzpG0j8pjYB43YMmcY7iASmEHQN2SbwjLJqThbV0JztX
	 oZXjaue5SeLMGRm/VR4PTFkTGgXhJwcxOBOw4xnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfHTUAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:00:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46554 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbfHTUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:00:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id t24so5077523oij.13;
        Tue, 20 Aug 2019 13:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxYOyT61P/sF0sfDdACE9L8UXbg0s2XhgxpMMYfVm80=;
        b=JBG2qk9MjXDhy33i5JgObLKVDVX1cHNTc2vuwtxVxlVA6ge0lZemdXQvcRtn6OPoDN
         kxbogHWMeRbT/3A9ShEyuMrc3z2ftTkwdl1E8Etrx3gq9NBulF/gAXNNzF58mGX+Kyj5
         BRnsY08RKow35X94tGZNJb8GL+1SNlDtKKS3TfOuE/Nz7CDWbqGr1y8yZEhnPBGNFoYP
         ATxcuzGc441+JvdHUBgwJTlQt2KdajQhJRuM5yN6ynnnJqrBKIIiTokYU4X58zUy3Rwv
         OP2XgOx42j7+tRW2IrB93GM7bql27A1BeAAAUYRRGK6CeRm1MtN5Ggq/etidNk83CoY3
         6VOw==
X-Gm-Message-State: APjAAAXK4n406YSD9aM0ma8iAsTRk3AYUxO1v2bahTGdHKGqxPriLWpX
        v3PxE/sorsGzkd0+naFp6x9vGCY=
X-Google-Smtp-Source: APXvYqwxy+q6VAMCeZ/T/7MIPiOC+8P053JQcdZ1UNkCLaCuHpoUJPs2aTzh8a2zW0HYfUjSS1lsgg==
X-Received: by 2002:aca:c6d8:: with SMTP id w207mr1233115oif.94.1566331203739;
        Tue, 20 Aug 2019 13:00:03 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e22sm5082159oii.7.2019.08.20.13.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 13:00:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: Convert Arm Mali Bifrost GPU to DT schema
Date:   Tue, 20 Aug 2019 14:59:58 -0500
Message-Id: <20190820195959.6126-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820195959.6126-1-robh@kernel.org>
References: <20190820195959.6126-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Arm Bifrost GPU binding to DT schema format.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/gpu/arm,mali-bifrost.txt         |  92 --------------
 .../bindings/gpu/arm,mali-bifrost.yaml        | 115 ++++++++++++++++++
 2 files changed, 115 insertions(+), 92 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
deleted file mode 100644
index b8be9dbc68b4..000000000000
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
+++ /dev/null
@@ -1,92 +0,0 @@
-ARM Mali Bifrost GPU
-====================
-
-Required properties:
-
-- compatible :
-  * Since Mali Bifrost GPU model/revision is fully discoverable by reading
-    some determined registers, must contain the following:
-    + "arm,mali-bifrost"
-  * which must be preceded by one of the following vendor specifics:
-    + "amlogic,meson-g12a-mali"
-
-- reg : Physical base address of the device and length of the register area.
-
-- interrupts : Contains the three IRQ lines required by Mali Bifrost devices,
-  in the following defined order.
-
-- interrupt-names : Contains the names of IRQ resources in this exact defined
-  order: "job", "mmu", "gpu".
-
-Optional properties:
-
-- clocks : Phandle to clock for the Mali Bifrost device.
-
-- mali-supply : Phandle to regulator for the Mali device. Refer to
-  Documentation/devicetree/bindings/regulator/regulator.txt for details.
-
-- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
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
-- "amlogic,meson-g12a-mali"
-  Required properties:
-  - resets : Should contain phandles of :
-    + GPU reset line
-    + GPU APB glue reset line
-
-Example for a Mali-G31:
-
-gpu@ffa30000 {
-	compatible = "amlogic,meson-g12a-mali", "arm,mali-bifrost";
-	reg = <0xffe40000 0x10000>;
-	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "job", "mmu", "gpu";
-	clocks = <&clk CLKID_MALI>;
-	mali-supply = <&vdd_gpu>;
-	operating-points-v2 = <&gpu_opp_table>;
-	resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
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
diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
new file mode 100644
index 000000000000..51f63c9dac46
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/arm,mali-bifrost.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali Bifrost GPU
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  $nodename:
+    pattern: '^gpu@[a-f0-9]+$'
+
+  compatible:
+    items:
+      - enum:
+          - amlogic,meson-g12a-mali
+      - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
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
+    maxItems: 1
+
+  mali-supply:
+    maxItems: 1
+
+  operating-points-v2: true
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
+            const: amlogic,meson-g12a-mali
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
+    gpu@ffe40000 {
+      compatible = "amlogic,meson-g12a-mali", "arm,mali-bifrost";
+      reg = <0xffe40000 0x10000>;
+      interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "job", "mmu", "gpu";
+      clocks = <&clk 1>;
+      mali-supply = <&vdd_gpu>;
+      operating-points-v2 = <&gpu_opp_table>;
+      resets = <&reset 0>, <&reset 1>;
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

