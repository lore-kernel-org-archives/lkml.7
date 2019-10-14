Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244A2C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75EE20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ghgp2c9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfJNJQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:16:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53394 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730438AbfJNJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:16:51 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9E9AxsD005158;
        Mon, 14 Oct 2019 11:16:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=TzO0r7o9/PEJtHkBtvTCBw9/8HDV911fk/ic2F7L7qI=;
 b=ghgp2c9WgGSHHr5+nhz/mDKH9QxNkZNlGYAFPeZiUoB6atMaTVmIL2laHfb6b6AwMc1Y
 3G/tQxjkh5VCuP7HU6LcjWwN0bbujUYUhBk6x4U6IkbwlhECSOCH3Z83/EuOEwlujUZR
 Y7jO+59CCrKjENVwgm32vP6qG3m1YCy4FU3WBFuTsYOGiBw/K0A2Xk+asjqwD6jJzroj
 6ZhmqHHH32C/bDY6fQfIPA2F3u4aEwuk3CsXG5nIXMH3tWp5R9Knkt/vd/vgDxVImW1g
 kga6ffoywByXhC+D6GkpZeorFvUBR2t8yeLlz77G8v8bolD/O8vGW86pKepK5GSUv35Z dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vk5qj1bqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 11:16:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF127100034;
        Mon, 14 Oct 2019 11:16:26 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D3992B8C45;
        Mon, 14 Oct 2019 11:16:26 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 14 Oct
 2019 11:16:26 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 14 Oct 2019 11:16:25
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <yannick.fertre@st.com>, <philippe.cornu@st.com>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3] dt-bindings: display: Convert stm32 display bindings to json-schema
Date:   Mon, 14 Oct 2019 11:16:22 +0200
Message-ID: <20191014091622.23562-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_06:2019-10-10,2019-10-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the STM32 display binding to DT schema format using json-schema.
Split the original bindings in two yaml files:
- one for display controller (ltdc)
- one for DSI controller

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
changes in v3:
- use (GPL-2.0-only OR BSD-2-Clause) license

changes in v2:
- use BSD-2-Clause license
- add panel property
- fix identation
- remove pinctrl-names: true
- remove pinctrl-[0-9]+: true
- rework ports block to include port@0 and port@1
- use const for #adress-cells and #size-cells
- add additionalProperties: false

 .../devicetree/bindings/display/st,stm32-dsi.yaml  | 151 +++++++++++++++++++++
 .../devicetree/bindings/display/st,stm32-ltdc.txt  | 144 --------------------
 .../devicetree/bindings/display/st,stm32-ltdc.yaml |  81 +++++++++++
 3 files changed, 232 insertions(+), 144 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
 create mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml

diff --git a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
new file mode 100644
index 000000000000..8dd727c7533e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/st,stm32-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 DSI host controller
+
+maintainers:
+  - Philippe Cornu <philippe.cornu@st.com>
+  - Yannick Fertre <yannick.fertre@st.com>
+
+description:
+  The STMicroelectronics STM32 DSI controller uses the Synopsys DesignWare MIPI-DSI host controller.
+
+properties:
+  compatible:
+    const: st,stm32-dsi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Module Clock
+      - description: DSI bus clock
+      - description: Pixel clock
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: ref
+      - const: px_clk
+    minItems: 2
+    maxItems: 3
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: apb
+
+  phy-dsi-supply:
+    maxItems: 1
+    description:
+        Phandle of the regulator that provides the supply voltage.
+
+  ports:
+    type: object
+    description:
+      A node containing DSI input & output port nodes with endpoint
+      definitions as documented in
+      Documentation/devicetree/bindings/media/video-interfaces.txt
+      Documentation/devicetree/bindings/graph.txt
+    properties:
+      port@0:
+        type: object
+        description:
+          DSI input port node, connected to the ltdc rgb output port.
+
+      port@1:
+        type: object
+        description:
+          DSI output port node, connected to a panel or a bridge input port"
+
+patternProperties:
+  "^(panel|panel-dsi)@[0-9]$":
+    type: object
+    description:
+      A node containing the panel or bridge description as documented in
+      Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
+    properties:
+      port@0:
+        type: object
+        description:
+          Panel or bridge port node, connected to the DSI output port (port@1)
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    #include <dt-bindings/gpio/gpio.h>
+    dsi: dsi@5a000000 {
+        compatible = "st,stm32-dsi";
+        reg = <0x5a000000 0x800>;
+        clocks = <&rcc DSI_K>, <&clk_hse>, <&rcc DSI_PX>;
+        clock-names = "pclk", "ref", "px_clk";
+        resets = <&rcc DSI_R>;
+        reset-names = "apb";
+        phy-dsi-supply = <&reg18>;
+        
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              port@0 {
+                    reg = <0>;
+                    dsi_in: endpoint {
+                        remote-endpoint = <&ltdc_ep1_out>;
+                    };
+              };
+
+              port@1 {
+                    reg = <1>;
+                    dsi_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                    };
+              };
+        };
+
+        panel-dsi@0 {
+              compatible = "orisetech,otm8009a";
+              reg = <0>;
+              reset-gpios = <&gpioe 4 GPIO_ACTIVE_LOW>;
+              power-supply = <&v3v3>;
+
+              port {
+                    panel_in: endpoint {
+                        remote-endpoint = <&dsi_out>;
+                    };
+              };
+        };
+    };
+
+...
+
+
diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
deleted file mode 100644
index 60c54da4e526..000000000000
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+++ /dev/null
@@ -1,144 +0,0 @@
-* STMicroelectronics STM32 lcd-tft display controller
-
-- ltdc: lcd-tft display controller host
-  Required properties:
-  - compatible: "st,stm32-ltdc"
-  - reg: Physical base address of the IP registers and length of memory mapped region.
-  - clocks: A list of phandle + clock-specifier pairs, one for each
-    entry in 'clock-names'.
-  - clock-names: A list of clock names. For ltdc it should contain:
-      - "lcd" for the clock feeding the output pixel clock & IP clock.
-  - resets: reset to be used by the device (defined by use of RCC macro).
-  Required nodes:
-  - Video port for DPI RGB output: ltdc has one video port with up to 2
-    endpoints:
-      - for external dpi rgb panel or bridge, using gpios.
-      - for internal dpi input of the MIPI DSI host controller.
-      Note: These 2 endpoints cannot be activated simultaneously.
-
-* STMicroelectronics STM32 DSI controller specific extensions to Synopsys
-  DesignWare MIPI DSI host controller
-
-The STMicroelectronics STM32 DSI controller uses the Synopsys DesignWare MIPI
-DSI host controller. For all mandatory properties & nodes, please refer
-to the related documentation in [5].
-
-Mandatory properties specific to STM32 DSI:
-- #address-cells: Should be <1>.
-- #size-cells: Should be <0>.
-- compatible: "st,stm32-dsi".
-- clock-names:
-  - phy pll reference clock string name, must be "ref".
-- resets: see [5].
-- reset-names: see [5].
-
-Mandatory nodes specific to STM32 DSI:
-- ports: A node containing DSI input & output port nodes with endpoint
-  definitions as documented in [3] & [4].
-  - port@0: DSI input port node, connected to the ltdc rgb output port.
-  - port@1: DSI output port node, connected to a panel or a bridge input port.
-- panel or bridge node: A node containing the panel or bridge description as
-  documented in [6].
-  - port: panel or bridge port node, connected to the DSI output port (port@1).
-Optional properties:
-- phy-dsi-supply: phandle of the regulator that provides the supply voltage.
-
-Note: You can find more documentation in the following references
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/reset/reset.txt
-[3] Documentation/devicetree/bindings/media/video-interfaces.txt
-[4] Documentation/devicetree/bindings/graph.txt
-[5] Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
-[6] Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
-
-Example 1: RGB panel
-/ {
-	...
-	soc {
-	...
-		ltdc: display-controller@40016800 {
-			compatible = "st,stm32-ltdc";
-			reg = <0x40016800 0x200>;
-			interrupts = <88>, <89>;
-			resets = <&rcc STM32F4_APB2_RESET(LTDC)>;
-			clocks = <&rcc 1 CLK_LCD>;
-			clock-names = "lcd";
-
-			port {
-				ltdc_out_rgb: endpoint {
-				};
-			};
-		};
-	};
-};
-
-Example 2: DSI panel
-
-/ {
-	...
-	soc {
-	...
-		ltdc: display-controller@40016800 {
-			compatible = "st,stm32-ltdc";
-			reg = <0x40016800 0x200>;
-			interrupts = <88>, <89>;
-			resets = <&rcc STM32F4_APB2_RESET(LTDC)>;
-			clocks = <&rcc 1 CLK_LCD>;
-			clock-names = "lcd";
-
-			port {
-				ltdc_out_dsi: endpoint {
-					remote-endpoint = <&dsi_in>;
-				};
-			};
-		};
-
-
-		dsi: dsi@40016c00 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "st,stm32-dsi";
-			reg = <0x40016c00 0x800>;
-			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
-			clock-names = "pclk", "ref";
-			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
-			reset-names = "apb";
-			phy-dsi-supply = <&reg18>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					dsi_in: endpoint {
-						remote-endpoint = <&ltdc_out_dsi>;
-					};
-				};
-
-				port@1 {
-					reg = <1>;
-					dsi_out: endpoint {
-						remote-endpoint = <&dsi_in_panel>;
-					};
-				};
-
-			};
-
-			panel-dsi@0 {
-				reg = <0>; /* dsi virtual channel (0..3) */
-				compatible = ...;
-				enable-gpios = ...;
-
-				port {
-					dsi_in_panel: endpoint {
-						remote-endpoint = <&dsi_out>;
-					};
-				};
-
-			};
-
-		};
-
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
new file mode 100644
index 000000000000..94a4137f7236
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/st,stm32-ltdc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 lcd-tft display controller
+
+maintainers:
+  - Philippe Cornu <philippe.cornu@st.com>
+  - Yannick Fertre <yannick.fertre@st.com>
+
+properties:
+  compatible:
+    const: st,stm32-ltdc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: lcd
+
+  resets:
+    maxItems: 1
+
+  port:
+    type: object
+    description:
+      "Video port for DPI RGB output. 
+      ltdc has one video port with up to 2 endpoints:
+      - for external dpi rgb panel or bridge, using gpios.
+      - for internal dpi input of the MIPI DSI host controller.
+      Note: These 2 endpoints cannot be activated simultaneously.
+      Please refer to the bindings defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt."
+
+  dma-ranges:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    ltdc: display-controller@40016800 {
+        compatible = "st,stm32-ltdc";
+        reg = <0x5a001000 0x400>;
+        interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&rcc LTDC_PX>;
+        clock-names = "lcd";
+        resets = <&rcc LTDC_R>;
+
+        port {
+             ltdc_out_dsi: endpoint {
+                     remote-endpoint = <&dsi_in>;
+             };
+        };
+    };
+
+...
+
-- 
2.15.0

