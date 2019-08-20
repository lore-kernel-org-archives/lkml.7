Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66947C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BDC216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566331211;
	bh=d1hDDRy02TR6rrVBC44AVXejCXzE4XjKzfuhyB/4zqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nDy/C3hBwYBAewe9em+8HitpreKkqsby6RviMqqXv0anQpMvvniZ1vFH8hfoAx2/a
	 CsJR7PGdOTXmnV4q2vqSMS3zpgfhjj+VSoiElXAzjH7P2Ikxqulydbr7AA/jUX3cZ2
	 hOmxl8WIQqcpBBJx1K+epdtaruaF+pWm+UZQBsu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfHTUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:00:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38799 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730744AbfHTUAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:00:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id p124so5100393oig.5;
        Tue, 20 Aug 2019 13:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9qdf6OuK28xHVuyTgCPEF7N3ZpxSCPg8pW5UrKyKfM=;
        b=ktXN5R8q1qt2DibVYjweVOxCKYocEGbQ1jNnoGDsuDBCsKjKp9FdOavyrzbc9A7RL+
         L2aRU//tN1/JSAsRerM2lpqZtapJdL3X/HambiVRvx/68mhJFx0UFR7GEi8HAa6CV+fP
         I3+i5JWviy/YjlzSe253u/MY6ZzXIix5e952Iy60EY79g6pcxo2OeY7zeLjeKYDhzvCX
         4bSmuKjmUZSkvj/0SzQUpNnx8QEsS40KMyrGaz7IqsYUCOoqyBZj9oRFhJlFSiOJgSTS
         VmEceFowpqpHZzjy+tWphRV0fCQoDrhCH9HNYuVfgF1uzA8C7NsN1CZtTLOpJHv7RRnf
         yGFQ==
X-Gm-Message-State: APjAAAV1nmCGegUrV1757nZqX9yFdXH0zkC7JNZF/5EVxhutPx3LYlaz
        IQQgm6tqbDJHS4sPDOK+aUTpUTw=
X-Google-Smtp-Source: APXvYqzaWy45AoBSXE/R8f4paArbKOH0i+adQ+8nfTwwoKp1b9FyR37fpC7lXEkLeubUORC4WIaa2w==
X-Received: by 2002:aca:5c3:: with SMTP id 186mr1269320oif.37.1566331204755;
        Tue, 20 Aug 2019 13:00:04 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e22sm5082159oii.7.2019.08.20.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 13:00:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: Convert Arm Mali Utgard GPU to DT schema
Date:   Tue, 20 Aug 2019 14:59:59 -0500
Message-Id: <20190820195959.6126-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820195959.6126-1-robh@kernel.org>
References: <20190820195959.6126-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Arm Utgard GPU binding to DT schema format.

'allwinner,sun8i-a23-mali' compatible was not documented, so add it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/gpu/arm,mali-utgard.txt          | 129 --------------
 .../bindings/gpu/arm,mali-utgard.yaml         | 166 ++++++++++++++++++
 2 files changed, 166 insertions(+), 129 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
deleted file mode 100644
index ba895efe3039..000000000000
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ /dev/null
@@ -1,129 +0,0 @@
-ARM Mali Utgard GPU
-===================
-
-Required properties:
-  - compatible
-    * Must be one of the following:
-      + "arm,mali-300"
-      + "arm,mali-400"
-      + "arm,mali-450"
-    * And, optionally, one of the vendor specific compatible:
-      + allwinner,sun4i-a10-mali
-      + allwinner,sun7i-a20-mali
-      + allwinner,sun8i-h3-mali
-      + allwinner,sun50i-a64-mali
-      + allwinner,sun50i-h5-mali
-      + amlogic,meson8-mali
-      + amlogic,meson8b-mali
-      + amlogic,meson-gxbb-mali
-      + amlogic,meson-gxl-mali
-      + samsung,exynos4210-mali
-      + rockchip,rk3036-mali
-      + rockchip,rk3066-mali
-      + rockchip,rk3188-mali
-      + rockchip,rk3228-mali
-      + rockchip,rk3328-mali
-      + stericsson,db8500-mali
-      + hisilicon,hi6220-mali
-
-  - reg: Physical base address and length of the GPU registers
-
-  - interrupts: an entry for each entry in interrupt-names.
-    See ../interrupt-controller/interrupts.txt for details.
-
-  - interrupt-names:
-    * ppX: Pixel Processor X interrupt (X from 0 to 7)
-    * ppmmuX: Pixel Processor X MMU interrupt (X from 0 to 7)
-    * pp: Pixel Processor broadcast interrupt (mali-450 only)
-    * gp: Geometry Processor interrupt
-    * gpmmu: Geometry Processor MMU interrupt
-
-  - clocks: an entry for each entry in clock-names
-  - clock-names:
-    * bus: bus clock for the GPU
-    * core: clock driving the GPU itself
-
-Optional properties:
-  - interrupt-names and interrupts:
-    * pmu: Power Management Unit interrupt, if implemented in hardware
-
-  - memory-region:
-    Memory region to allocate from, as defined in
-    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
-
-  - mali-supply:
-    Phandle to regulator for the Mali device, as defined in
-    Documentation/devicetree/bindings/regulator/regulator.txt for details.
-
-  - operating-points-v2:
-    Operating Points for the GPU, as defined in
-    Documentation/devicetree/bindings/opp/opp.txt
-
-  - power-domains:
-    A power domain consumer specifier as defined in
-    Documentation/devicetree/bindings/power/power_domain.txt
-
-Vendor-specific bindings
-------------------------
-
-The Mali GPU is integrated very differently from one SoC to
-another. In order to accomodate those differences, you have the option
-to specify one more vendor-specific compatible, among:
-
-  - allwinner,sun4i-a10-mali
-    Required properties:
-      * resets: phandle to the reset line for the GPU
-
-  - allwinner,sun7i-a20-mali
-    Required properties:
-      * resets: phandle to the reset line for the GPU
-
-  - allwinner,sun50i-a64-mali
-    Required properties:
-      * resets: phandle to the reset line for the GPU
-
-  - allwinner,sun50i-h5-mali
-    Required properties:
-      * resets: phandle to the reset line for the GPU
-
-  - amlogic,meson8-mali and amlogic,meson8b-mali
-    Required properties:
-      * resets: phandle to the reset line for the GPU
-
-  - Rockchip variants:
-    Required properties:
-      * resets: phandle to the reset line for the GPU
-
-  - stericsson,db8500-mali
-    Required properties:
-      * interrupt-names and interrupts:
-        + combined: combined interrupt of all of the above lines
-
-  - hisilicon,hi6220-mali
-    Required properties:
-      * resets: phandles to the reset lines for the GPU
-
-Example:
-
-mali: gpu@1c40000 {
-	compatible = "allwinner,sun7i-a20-mali", "arm,mali-400";
-	reg = <0x01c40000 0x10000>;
-	interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "gp",
-			  "gpmmu",
-			  "pp0",
-			  "ppmmu0",
-			  "pp1",
-			  "ppmmu1",
-			  "pmu";
-	clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
-	clock-names = "bus", "core";
-	resets = <&ccu RST_BUS_GPU>;
-};
-
diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
new file mode 100644
index 000000000000..d3883ba09174
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/arm,mali-utgard.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali Utgard GPU
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+  - Maxime Ripard <maxime.ripard@free-electrons.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  $nodename:
+    pattern: '^gpu@[a-f0-9]+$'
+  compatible:
+    oneOf:
+      - items:
+          - const: allwinner,sun8i-a23-mali
+          - const: allwinner,sun7i-a20-mali
+          - const: arm,mali-400
+      - items:
+          - enum:
+              - allwinner,sun4i-a10-mali
+              - allwinner,sun7i-a20-mali
+              - allwinner,sun8i-h3-mali
+              - allwinner,sun50i-a64-mali
+              - rockchip,rk3036-mali
+              - rockchip,rk3066-mali
+              - rockchip,rk3188-mali
+              - rockchip,rk3228-mali
+              - samsung,exynos4210-mali
+              - stericsson,db8500-mali
+          - const: arm,mali-400
+      - items:
+          - enum:
+              - allwinner,sun50i-h5-mali
+              - amlogic,meson8-mali
+              - amlogic,meson8b-mali
+              - amlogic,meson-gxbb-mali
+              - amlogic,meson-gxl-mali
+              - hisilicon,hi6220-mali
+              - rockchip,rk3328-mali
+          - const: arm,mali-450
+
+      # "arm,mali-300"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 4
+    maxItems: 20
+
+  interrupt-names:
+    allOf:
+      - additionalItems: true
+        minItems: 4
+        maxItems: 20
+        items:
+          # At least enforce the first 2 interrupts
+          - const: gp
+          - const: gpmmu
+      - items:
+          # Not ideal as any order and combination are allowed
+          enum:
+            - gp        # Geometry Processor interrupt
+            - gpmmu     # Geometry Processor MMU interrupt
+            - pp        # Pixel Processor broadcast interrupt (mali-450 only)
+            - pp0       # Pixel Processor X interrupt (X from 0 to 7)
+            - ppmmu0    # Pixel Processor X MMU interrupt (X from 0 to 7)
+            - pp1
+            - ppmmu1
+            - pp2
+            - ppmmu2
+            - pp3
+            - ppmmu3
+            - pp4
+            - ppmmu4
+            - pp5
+            - ppmmu5
+            - pp6
+            - ppmmu6
+            - pp7
+            - ppmmu7
+            - pmu       # Power Management Unit interrupt (optional)
+            - combined  # stericsson,db8500-mali only
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: bus
+      - const: core
+
+  memory-region: true
+
+  mali-supply:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
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
+            enum:
+              - allwinner,sun4i-a10-mali
+              - allwinner,sun7i-a20-mali
+              - allwinner,sun50i-a64-mali
+              - allwinner,sun50i-h5-mali
+              - amlogic,meson8-mali
+              - amlogic,meson8b-mali
+              - hisilicon,hi6220-mali
+              - rockchip,rk3036-mali
+              - rockchip,rk3066-mali
+              - rockchip,rk3188-mali
+              - rockchip,rk3228-mali
+              - rockchip,rk3328-mali
+    then:
+      required:
+        - resets
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mali: gpu@1c40000 {
+      compatible = "allwinner,sun7i-a20-mali", "arm,mali-400";
+      reg = <0x01c40000 0x10000>;
+      interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "gp",
+            "gpmmu",
+            "pp0",
+            "ppmmu0",
+            "pp1",
+            "ppmmu1",
+            "pmu";
+      clocks = <&ccu 1>, <&ccu 2>;
+      clock-names = "bus", "core";
+      resets = <&ccu 1>;
+    };
+
+...
-- 
2.20.1

