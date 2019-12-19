Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72FC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FADE2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="A8TtDM/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vnsH5DgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfLSJHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:07:20 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33345 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbfLSJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:07:19 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CAB5F50AE;
        Thu, 19 Dec 2019 04:07:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 19 Dec 2019 04:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=SOOfmKLvxRcz+
        8DUPnEW0vu/SfvtTEApShPAFQzhiUI=; b=A8TtDM/HFeGK33biCSEdsI2BMEFxb
        2rdCei4PzuXUM6h6PP9IZGq4a2TYHR3SRIknVc36xNcKYML5FTFgWIO4s369EI0a
        pf4NLtN87TDX0v4KSdtE3ZeE8OA9vLw6n0tzMWwJakFzwEmzof8UqIups3KcvTt5
        Wk7z23y/so1Gss9iv19x1sVBFreVFill6dGZ0UbHqpkNCK5gy/KCoYdr/ghNHBmG
        64KTc/Yl2mYgcPXjSm9RrWvzn39ik+PawiOxCHoyxy+1i3sU1YSAxcXcv8oOW1zH
        52idMSEFWrulH0+nbQvVdFKEGSw/+EO0wxaN/nYDzYn4NSyiqzEqmftWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=SOOfmKLvxRcz+8DUPnEW0vu/SfvtTEApShPAFQzhiUI=; b=vnsH5DgP
        56uIOrRXSF8JcKUIf2k3z6QHt7fyx97RpPsa6NNQ9gakBaK6vA0+2QinysrrMZZi
        X6Dw2HKiaqxMvmtDUKlY4nXkQzJDhmtgwnw/iJrkTWHFElLttE6CY/Z5v+c7gIai
        6ZCQUEJEikRBKHDj6T/R9hZ7/0sEHJ+T8ep9Lbi3OS+aCVotIBhmWTqDk+ufH+9b
        rY0L/0WKRPe0CAZCfwGs7/WAacdsjz4LZINcv8aqvfiIa8/HjCBhgX6DMOhARu+o
        Dohv8NOzs8JnCcWHeIafxjT/FJUkhBk8dVASE9XFGHKvLDgs0F0Ya21OENXBlO4A
        3DbOSWTeBG1IdQ==
X-ME-Sender: <xms:xT37Xf0a54LdFmKACk07P-2xLHjlFjxjFyhCj2MLlzuRP72jeajAeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdduudcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogevoh
    grshhtrghlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffojghfggfg
    sedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimh
    gvsegtvghrnhhordhtvggthheqnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhr
    ghenucfkphepledtrdekledrieekrdejieenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xT37XSttEBsK-N3jc7pkO3gaEkbxh9kLbWffVHGohBsjzp311scsAQ>
    <xmx:xT37XYC0R_GQ1MOipiQmU4vieAm7ZumYsu7fpj0r6FB1DaPZWFwoGg>
    <xmx:xT37Xe_oj-G_xWUDMFe7eZ2PCUdUtFDHMYo82LgVcoXK4Hctchflpw>
    <xmx:xT37Xb6pNp59xLWGbkYkpzjKYmTaOwbpCZ6dNMwv2u5faDI8F0Ia-A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0EFAC30609DC;
        Thu, 19 Dec 2019 04:07:16 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     p.zabel@pengutronix.de, Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, lee.jones@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 2/3] dt-bindings: mfd: Convert Allwinner legacy PRCM bindings to schemas
Date:   Thu, 19 Dec 2019 10:07:11 +0100
Message-Id: <20191219090712.947490-2-maxime@cerno.tech>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219090712.947490-1-maxime@cerno.tech>
References: <20191219090712.947490-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner SoCs have a legacy set of bindings (and a drivers to
support it in Linux) to support the PRCM unit found in most recent SoCs.

Now that we have the DT validation in place, let's split into separate file
and convert the device tree bindings for those controllers to schemas, and
mark them all as deprecated.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../mfd/allwinner,sun6i-a31-prcm.yaml         | 219 ++++++++++++++++++
 .../mfd/allwinner,sun8i-a23-prcm.yaml         | 200 ++++++++++++++++
 .../devicetree/bindings/mfd/sun6i-prcm.txt    |  59 -----
 3 files changed, 419 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/sun6i-prcm.txt

diff --git a/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml b/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
new file mode 100644
index 000000000000..d131759ccaf3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
@@ -0,0 +1,219 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/allwinner,sun6i-a31-prcm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A31 PRCM Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+deprecated: true
+
+properties:
+  compatible:
+    const: allwinner,sun6i-a31-prcm
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^.*_(clk|rst)$":
+    type: object
+
+    properties:
+      compatible:
+        enum:
+          - allwinner,sun4i-a10-mod0-clk
+          - allwinner,sun6i-a31-apb0-clk
+          - allwinner,sun6i-a31-apb0-gates-clk
+          - allwinner,sun6i-a31-ar100-clk
+          - allwinner,sun6i-a31-clock-reset
+          - fixed-factor-clock
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: allwinner,sun6i-a31-apb0-clk
+
+        then:
+          properties:
+            "#clock-cells":
+              const: 0
+
+            # Already checked in the main schema
+            compatible: true
+
+            clocks:
+              maxItems: 1
+
+            clock-output-names:
+              maxItems: 1
+
+            phandle: true
+
+          required:
+            - "#clock-cells"
+            - compatible
+            - clocks
+            - clock-output-names
+
+          additionalProperties: false
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: allwinner,sun6i-a31-apb0-gates-clk
+
+        then:
+          properties:
+            "#clock-cells":
+              const: 1
+              description: >
+                This additional argument passed to that clock is the
+                offset of the bit controlling this particular gate in
+                the register.
+
+            # Already checked in the main schema
+            compatible: true
+
+            clocks:
+              maxItems: 1
+
+            clock-output-names:
+              minItems: 1
+              maxItems: 32
+
+            phandle: true
+
+          required:
+            - "#clock-cells"
+            - compatible
+            - clocks
+            - clock-output-names
+
+          additionalProperties: false
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: allwinner,sun6i-a31-ar100-clk
+
+        then:
+          properties:
+            "#clock-cells":
+              const: 0
+
+            # Already checked in the main schema
+            compatible: true
+
+            clocks:
+              maxItems: 4
+              description: >
+                The parent order must match the hardware programming
+                order.
+
+            clock-output-names:
+              maxItems: 1
+
+            phandle: true
+
+          required:
+            - "#clock-cells"
+            - compatible
+            - clocks
+            - clock-output-names
+
+          additionalProperties: false
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: allwinner,sun6i-a31-clock-reset
+
+        then:
+          properties:
+            "#reset-cells":
+              const: 1
+
+            # Already checked in the main schema
+            compatible: true
+
+            phandle: true
+
+          required:
+            - "#reset-cells"
+            - compatible
+
+          additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sun6i-a31-ccu.h>
+
+    prcm@1f01400 {
+        compatible = "allwinner,sun6i-a31-prcm";
+        reg = <0x01f01400 0x200>;
+
+        ar100: ar100_clk {
+            compatible = "allwinner,sun6i-a31-ar100-clk";
+            #clock-cells = <0>;
+            clocks = <&rtc 0>, <&osc24M>,
+                     <&ccu CLK_PLL_PERIPH>,
+                     <&ccu CLK_PLL_PERIPH>;
+            clock-output-names = "ar100";
+        };
+
+        ahb0: ahb0_clk {
+            compatible = "fixed-factor-clock";
+            #clock-cells = <0>;
+            clock-div = <1>;
+            clock-mult = <1>;
+            clocks = <&ar100>;
+            clock-output-names = "ahb0";
+        };
+
+        apb0: apb0_clk {
+            compatible = "allwinner,sun6i-a31-apb0-clk";
+            #clock-cells = <0>;
+            clocks = <&ahb0>;
+            clock-output-names = "apb0";
+        };
+
+        apb0_gates: apb0_gates_clk {
+            compatible = "allwinner,sun6i-a31-apb0-gates-clk";
+            #clock-cells = <1>;
+            clocks = <&apb0>;
+            clock-output-names = "apb0_pio", "apb0_ir",
+                                 "apb0_timer", "apb0_p2wi",
+                                 "apb0_uart", "apb0_1wire",
+                                 "apb0_i2c";
+        };
+
+        ir_clk: ir_clk {
+            #clock-cells = <0>;
+            compatible = "allwinner,sun4i-a10-mod0-clk";
+            clocks = <&rtc 0>, <&osc24M>;
+            clock-output-names = "ir";
+        };
+
+        apb0_rst: apb0_rst {
+            compatible = "allwinner,sun6i-a31-clock-reset";
+            #reset-cells = <1>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml b/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
new file mode 100644
index 000000000000..aa5e683b236c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
@@ -0,0 +1,200 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/allwinner,sun8i-a23-prcm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A23 PRCM Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+deprecated: true
+
+properties:
+  compatible:
+    const: allwinner,sun8i-a23-prcm
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^.*(clk|rst|codec).*$":
+    type: object
+
+    properties:
+      compatible:
+        enum:
+          - fixed-factor-clock
+          - allwinner,sun8i-a23-apb0-clk
+          - allwinner,sun8i-a23-apb0-gates-clk
+          - allwinner,sun6i-a31-clock-reset
+          - allwinner,sun8i-a23-codec-analog
+
+    required:
+      - compatible
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: allwinner,sun8i-a23-apb0-clk
+
+        then:
+          properties:
+            "#clock-cells":
+              const: 0
+
+            # Already checked in the main schema
+            compatible: true
+
+            clocks:
+              maxItems: 1
+
+            clock-output-names:
+              maxItems: 1
+
+            phandle: true
+
+          required:
+            - "#clock-cells"
+            - compatible
+            - clocks
+            - clock-output-names
+
+          additionalProperties: false
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: allwinner,sun8i-a23-apb0-gates-clk
+
+        then:
+          properties:
+            "#clock-cells":
+              const: 1
+              description: >
+                This additional argument passed to that clock is the
+                offset of the bit controlling this particular gate in
+                the register.
+
+            # Already checked in the main schema
+            compatible: true
+
+            clocks:
+              maxItems: 1
+
+            clock-output-names:
+              minItems: 1
+              maxItems: 32
+
+            phandle: true
+
+          required:
+            - "#clock-cells"
+            - compatible
+            - clocks
+            - clock-output-names
+
+          additionalProperties: false
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: allwinner,sun6i-a31-clock-reset
+
+        then:
+          properties:
+            "#reset-cells":
+              const: 1
+
+            # Already checked in the main schema
+            compatible: true
+
+            phandle: true
+
+          required:
+            - "#reset-cells"
+            - compatible
+
+          additionalProperties: false
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: allwinner,sun8i-a23-codec-analog
+
+        then:
+          properties:
+            # Already checked in the main schema
+            compatible: true
+
+            phandle: true
+
+          required:
+            - compatible
+
+          additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    prcm@1f01400 {
+        compatible = "allwinner,sun8i-a23-prcm";
+        reg = <0x01f01400 0x200>;
+
+        ar100: ar100_clk {
+            compatible = "fixed-factor-clock";
+            #clock-cells = <0>;
+            clock-div = <1>;
+            clock-mult = <1>;
+            clocks = <&osc24M>;
+            clock-output-names = "ar100";
+        };
+
+        ahb0: ahb0_clk {
+            compatible = "fixed-factor-clock";
+            #clock-cells = <0>;
+            clock-div = <1>;
+            clock-mult = <1>;
+            clocks = <&ar100>;
+            clock-output-names = "ahb0";
+        };
+
+        apb0: apb0_clk {
+            compatible = "allwinner,sun8i-a23-apb0-clk";
+            #clock-cells = <0>;
+            clocks = <&ahb0>;
+            clock-output-names = "apb0";
+        };
+
+        apb0_gates: apb0_gates_clk {
+            compatible = "allwinner,sun8i-a23-apb0-gates-clk";
+            #clock-cells = <1>;
+            clocks = <&apb0>;
+            clock-output-names = "apb0_pio", "apb0_timer",
+                                 "apb0_rsb", "apb0_uart",
+                                 "apb0_i2c";
+        };
+
+        apb0_rst: apb0_rst {
+            compatible = "allwinner,sun6i-a31-clock-reset";
+            #reset-cells = <1>;
+        };
+
+        codec_analog: codec-analog {
+            compatible = "allwinner,sun8i-a23-codec-analog";
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
deleted file mode 100644
index daa091c2e67b..000000000000
--- a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-* Allwinner PRCM (Power/Reset/Clock Management) Multi-Functional Device
-
-PRCM is an MFD device exposing several Power Management related devices
-(like clks and reset controllers).
-
-Required properties:
- - compatible: "allwinner,sun6i-a31-prcm" or "allwinner,sun8i-a23-prcm"
- - reg: The PRCM registers range
-
-The prcm node may contain several subdevices definitions:
- - see Documentation/devicetree/bindings/clock/sunxi.txt for clock devices
- - see Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt for reset
-   controller devices
-
-
-Example:
-
-	prcm: prcm@1f01400 {
-		compatible = "allwinner,sun6i-a31-prcm";
-		reg = <0x01f01400 0x200>;
-
-		/* Put subdevices here */
-		ar100: ar100_clk {
-			compatible = "allwinner,sun6i-a31-ar100-clk";
-			#clock-cells = <0>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
-		};
-
-		ahb0: ahb0_clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clock-div = <1>;
-			clock-mult = <1>;
-			clocks = <&ar100_div>;
-			clock-output-names = "ahb0";
-		};
-
-		apb0: apb0_clk {
-			compatible = "allwinner,sun6i-a31-apb0-clk";
-			#clock-cells = <0>;
-			clocks = <&ahb0>;
-			clock-output-names = "apb0";
-		};
-
-		apb0_gates: apb0_gates_clk {
-			compatible = "allwinner,sun6i-a31-apb0-gates-clk";
-			#clock-cells = <1>;
-			clocks = <&apb0>;
-			clock-output-names = "apb0_pio", "apb0_ir",
-					"apb0_timer01", "apb0_p2wi",
-					"apb0_uart", "apb0_1wire",
-					"apb0_i2c";
-		};
-
-		apb0_rst: apb0_rst {
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			#reset-cells = <1>;
-		};
-	};
-- 
2.23.0

