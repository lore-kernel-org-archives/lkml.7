Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0555C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB4F206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmr2o97m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfGGWzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:55:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35957 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbfGGWzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:55:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so11904862qkl.3;
        Sun, 07 Jul 2019 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nm5vm3X+mNcOl3Z9t9oLSfBjdbTmjXNJFOHYo6M7ByI=;
        b=Pmr2o97mXjXJfRZtQ3zVvwJLDhW7s6vJhAZnryOQC5Q2aHlRWI8evVNapZH21zMCw+
         BDMYEqdnoBsk+NHfvp+xrlJhDeco/xGiT7W6ujQdjN4My1bQ+/3tbXmUH+Z39Ee4QxTT
         3icSVNXBGyFwS8ZdogdLj/A5sBKLQ2ji2rwTv+JipxgF7JzhYXs6RzGt6RXYUwYGunkx
         OJMuNFHQS3psU79C5GvQdWje77c7cNmxpkVjkuyACTiryoYtTqWt92XS63H4SBzTBRpt
         w7bkK57lXj+8+KZ+hBbTOuyl3R88yv94Glnvd47y0qNPIqLPZpl2+SoXXI3nK6llEEbw
         tKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nm5vm3X+mNcOl3Z9t9oLSfBjdbTmjXNJFOHYo6M7ByI=;
        b=VMa9O1N9IRCnQIQaMaZaVQ9m2iw88YlPfMUY/GxYL9T9MR1wdvQtZimodOhCgMdoTt
         ttEJ+sXg98hpRSF5A7yCHSjEaWMD5yPahUwPf7XtGzOLLvpk2VdZU7/Z6N+xLWVA00o4
         9hic5Tww5/CuPhcYdvMu73JX+KHLzeAqj6/tpI8/HeylsspL8mzCMgCUHd0n9AJa6YuB
         QuKv3/XJVzu3q1RL4PPBF4/XP4gGnLe5hCoyQMZwWegcw/xgIDVs3hd1C9DHwlo8tT33
         WES/lJyZIM/AWqDt6Rwp8XUGhfI4TRDH+YnHbNmjL/O2nrbQRXemwNxG7bztWwxBJR+k
         e1lQ==
X-Gm-Message-State: APjAAAWfKyINJNw7VgUX2PhVPodoaBW1P0HJFPnW1D5BlSwswoMGmXhr
        /cFNxygG/bkTrjdWJ9msTUo=
X-Google-Smtp-Source: APXvYqy+kDyAyBwOoa1PVcqTFolxhZIif5Y3flZryv24DXPRc25Saal7xSvKt47UWqr7ODYM0tdZlQ==
X-Received: by 2002:a37:6984:: with SMTP id e126mr11654286qkc.487.1562540106081;
        Sun, 07 Jul 2019 15:55:06 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t2sm8217556qth.33.2019.07.07.15.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:55:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/13] dt-bindings: memory: tegra30: Convert to Tegra124 YAML
Date:   Mon,  8 Jul 2019 01:54:18 +0300
Message-Id: <20190707225424.9562-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707225424.9562-1-digetx@gmail.com>
References: <20190707225424.9562-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra30 binding will actually differ from the Tegra124 a tad, in
particular the EMEM configuration description. Hence rename the binding
to Tegra124 during of the conversion to YAML.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../nvidia,tegra124-mc.yaml                   | 156 ++++++++++++++++++
 .../memory-controllers/nvidia,tegra30-mc.txt  | 123 --------------
 2 files changed, 156 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
new file mode 100644
index 000000000000..eed9ed8ee111
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
@@ -0,0 +1,156 @@
+# SPDX-License-Identifier: (GPL-2.0)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra124-mc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra124 SoC Memory Controller
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  Tegra124 SoC features a hybrid 2x32-bit / 1x64-bit memory controller.
+  These are interleaved to provide high performance with the load shared across
+  two memory channels. The Tegra124 Memory Controller handles memory requests
+  from internal clients and arbitrates among them to allocate memory bandwidth
+  for DDR3L and LPDDR3 SDRAMs.
+
+properties:
+  compatible:
+    const: nvidia,tegra124-mc
+
+  reg:
+    maxItems: 1
+    description:
+      Physical base address.
+
+  clocks:
+    maxItems: 1
+    description:
+      Memory Controller clock.
+
+  clock-names:
+    items:
+      - const: mc
+
+  interrupts:
+    maxItems: 1
+    description:
+      Memory Controller interrupt.
+
+  "#reset-cells":
+    const: 1
+
+  "#iommu-cells":
+    const: 1
+
+patternProperties:
+  "^emc-timings-[0-9]+$":
+    properties:
+      nvidia,ram-code:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Value of RAM_CODE this timing set is used for.
+
+    patternProperties:
+      "^timing-[0-9]+$":
+        properties:
+          clock-frequency:
+            description:
+              Memory clock rate in Hz.
+            minimum: 1000000
+            maximum: 1066000000
+
+          nvidia,emem-configuration:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            description: |
+              Values to be written to the EMEM register block. See section
+              "15.6.1 MC Registers" in the TRM.
+            items:
+              - description: MC_EMEM_ARB_CFG
+              - description: MC_EMEM_ARB_OUTSTANDING_REQ
+              - description: MC_EMEM_ARB_TIMING_RCD
+              - description: MC_EMEM_ARB_TIMING_RP
+              - description: MC_EMEM_ARB_TIMING_RC
+              - description: MC_EMEM_ARB_TIMING_RAS
+              - description: MC_EMEM_ARB_TIMING_FAW
+              - description: MC_EMEM_ARB_TIMING_RRD
+              - description: MC_EMEM_ARB_TIMING_RAP2PRE
+              - description: MC_EMEM_ARB_TIMING_WAP2PRE
+              - description: MC_EMEM_ARB_TIMING_R2R
+              - description: MC_EMEM_ARB_TIMING_W2W
+              - description: MC_EMEM_ARB_TIMING_R2W
+              - description: MC_EMEM_ARB_TIMING_W2R
+              - description: MC_EMEM_ARB_DA_TURNS
+              - description: MC_EMEM_ARB_DA_COVERS
+              - description: MC_EMEM_ARB_MISC0
+              - description: MC_EMEM_ARB_MISC1
+              - description: MC_EMEM_ARB_RING1_THROTTLE
+
+        required:
+          - clock-frequency
+          - nvidia,emem-configuration
+
+        additionalProperties: false
+
+    required:
+      - nvidia,ram-code
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#reset-cells"
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller@70019000 {
+        compatible = "nvidia,tegra124-mc";
+        reg = <0x0 0x70019000 0x0 0x1000>;
+        clocks = <&tegra_car 32>;
+        clock-names = "mc";
+
+        interrupts = <0 77 4>;
+
+        #iommu-cells = <1>;
+        #reset-cells = <1>;
+
+        emc-timings-3 {
+            nvidia,ram-code = <3>;
+
+            timing-12750000 {
+                clock-frequency = <12750000>;
+
+                nvidia,emem-configuration = <
+                    0x40040001 /* MC_EMEM_ARB_CFG */
+                    0x8000000a /* MC_EMEM_ARB_OUTSTANDING_REQ */
+                    0x00000001 /* MC_EMEM_ARB_TIMING_RCD */
+                    0x00000001 /* MC_EMEM_ARB_TIMING_RP */
+                    0x00000002 /* MC_EMEM_ARB_TIMING_RC */
+                    0x00000000 /* MC_EMEM_ARB_TIMING_RAS */
+                    0x00000002 /* MC_EMEM_ARB_TIMING_FAW */
+                    0x00000001 /* MC_EMEM_ARB_TIMING_RRD */
+                    0x00000002 /* MC_EMEM_ARB_TIMING_RAP2PRE */
+                    0x00000008 /* MC_EMEM_ARB_TIMING_WAP2PRE */
+                    0x00000003 /* MC_EMEM_ARB_TIMING_R2R */
+                    0x00000002 /* MC_EMEM_ARB_TIMING_W2W */
+                    0x00000003 /* MC_EMEM_ARB_TIMING_R2W */
+                    0x00000006 /* MC_EMEM_ARB_TIMING_W2R */
+                    0x06030203 /* MC_EMEM_ARB_DA_TURNS */
+                    0x000a0402 /* MC_EMEM_ARB_DA_COVERS */
+                    0x77e30303 /* MC_EMEM_ARB_MISC0 */
+                    0x70000f03 /* MC_EMEM_ARB_MISC1 */
+                    0x001f0000 /* MC_EMEM_ARB_RING1_THROTTLE */
+                >;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
deleted file mode 100644
index a878b5908a4d..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
+++ /dev/null
@@ -1,123 +0,0 @@
-NVIDIA Tegra Memory Controller device tree bindings
-===================================================
-
-memory-controller node
-----------------------
-
-Required properties:
-- compatible: Should be "nvidia,tegra<chip>-mc"
-- reg: Physical base address and length of the controller's registers.
-- clocks: Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-  - mc: the module's clock input
-- interrupts: The interrupt outputs from the controller.
-- #reset-cells : Should be 1. This cell represents memory client module ID.
-  The assignments may be found in header file <dt-bindings/memory/tegra30-mc.h>
-  or in the TRM documentation.
-
-Required properties for Tegra30, Tegra114, Tegra124, Tegra132 and Tegra210:
-- #iommu-cells: Should be 1. The single cell of the IOMMU specifier defines
-  the SWGROUP of the master.
-
-This device implements an IOMMU that complies with the generic IOMMU binding.
-See ../iommu/iommu.txt for details.
-
-emc-timings subnode
--------------------
-
-The node should contain a "emc-timings" subnode for each supported RAM type (see field RAM_CODE in
-register PMC_STRAPPING_OPT_A).
-
-Required properties for "emc-timings" nodes :
-- nvidia,ram-code : Should contain the value of RAM_CODE this timing set is used for.
-
-timing subnode
---------------
-
-Each "emc-timings" node should contain a subnode for every supported EMC clock rate.
-
-Required properties for timing nodes :
-- clock-frequency : Should contain the memory clock rate in Hz.
-- nvidia,emem-configuration : Values to be written to the EMEM register block. For the Tegra124 SoC
-(see section "15.6.1 MC Registers" in the TRM), these are the registers whose values need to be
-specified, according to the board documentation:
-
-	MC_EMEM_ARB_CFG
-	MC_EMEM_ARB_OUTSTANDING_REQ
-	MC_EMEM_ARB_TIMING_RCD
-	MC_EMEM_ARB_TIMING_RP
-	MC_EMEM_ARB_TIMING_RC
-	MC_EMEM_ARB_TIMING_RAS
-	MC_EMEM_ARB_TIMING_FAW
-	MC_EMEM_ARB_TIMING_RRD
-	MC_EMEM_ARB_TIMING_RAP2PRE
-	MC_EMEM_ARB_TIMING_WAP2PRE
-	MC_EMEM_ARB_TIMING_R2R
-	MC_EMEM_ARB_TIMING_W2W
-	MC_EMEM_ARB_TIMING_R2W
-	MC_EMEM_ARB_TIMING_W2R
-	MC_EMEM_ARB_DA_TURNS
-	MC_EMEM_ARB_DA_COVERS
-	MC_EMEM_ARB_MISC0
-	MC_EMEM_ARB_MISC1
-	MC_EMEM_ARB_RING1_THROTTLE
-
-Example SoC include file:
-
-/ {
-	mc: memory-controller@70019000 {
-		compatible = "nvidia,tegra124-mc";
-		reg = <0x0 0x70019000 0x0 0x1000>;
-		clocks = <&tegra_car TEGRA124_CLK_MC>;
-		clock-names = "mc";
-
-		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-
-		#iommu-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-	sdhci@700b0000 {
-		compatible = "nvidia,tegra124-sdhci";
-		...
-		iommus = <&mc TEGRA_SWGROUP_SDMMC1A>;
-		resets = <&mc TEGRA124_MC_RESET_SDMMC1>;
-	};
-};
-
-Example board file:
-
-/ {
-	memory-controller@70019000 {
-		emc-timings-3 {
-			nvidia,ram-code = <3>;
-
-			timing-12750000 {
-				clock-frequency = <12750000>;
-
-				nvidia,emem-configuration = <
-					0x40040001 /* MC_EMEM_ARB_CFG */
-					0x8000000a /* MC_EMEM_ARB_OUTSTANDING_REQ */
-					0x00000001 /* MC_EMEM_ARB_TIMING_RCD */
-					0x00000001 /* MC_EMEM_ARB_TIMING_RP */
-					0x00000002 /* MC_EMEM_ARB_TIMING_RC */
-					0x00000000 /* MC_EMEM_ARB_TIMING_RAS */
-					0x00000002 /* MC_EMEM_ARB_TIMING_FAW */
-					0x00000001 /* MC_EMEM_ARB_TIMING_RRD */
-					0x00000002 /* MC_EMEM_ARB_TIMING_RAP2PRE */
-					0x00000008 /* MC_EMEM_ARB_TIMING_WAP2PRE */
-					0x00000003 /* MC_EMEM_ARB_TIMING_R2R */
-					0x00000002 /* MC_EMEM_ARB_TIMING_W2W */
-					0x00000003 /* MC_EMEM_ARB_TIMING_R2W */
-					0x00000006 /* MC_EMEM_ARB_TIMING_W2R */
-					0x06030203 /* MC_EMEM_ARB_DA_TURNS */
-					0x000a0402 /* MC_EMEM_ARB_DA_COVERS */
-					0x77e30303 /* MC_EMEM_ARB_MISC0 */
-					0x70000f03 /* MC_EMEM_ARB_MISC1 */
-					0x001f0000 /* MC_EMEM_ARB_RING1_THROTTLE */
-				>;
-			};
-		};
-	};
-};
-- 
2.22.0

