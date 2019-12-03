Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A9C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7162073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLCPGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:06:16 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57923 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfLCPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:06:14 -0500
X-Originating-IP: 90.76.211.102
Received: from localhost.localdomain (lfbn-1-2154-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 84E651BF20B;
        Tue,  3 Dec 2019 15:06:10 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 1/3] dt-bindings: display: Document the Xylon LogiCVC display controller
Date:   Tue,  3 Dec 2019 16:06:04 +0100
Message-Id: <20191203150606.317062-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203150606.317062-1-paul.kocialkowski@bootlin.com>
References: <20191203150606.317062-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xylon LogiCVC is a display controller implemented as programmable
logic in Xilinx FPGAs.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../display/xylon,logicvc-display.yaml        | 313 ++++++++++++++++++
 1 file changed, 313 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml

diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
new file mode 100644
index 000000000000..817fcced764f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
@@ -0,0 +1,313 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Bootlin
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/display/xylon,logicvc-display.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Xylon LogiCVC display controller
+
+maintainers:
+  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+
+description: |
+  The Xylon LogiCVC is a display controller that supports multiple layers.
+  It is usually implemented as programmable logic and was optimized for use
+  with Xilinx Zynq-7000 SoCs and Xilinx FPGAs.
+
+  Because the controller is intended for use in a FPGA, most of the
+  configuration of the controller takes place at logic configuration bitstream
+  synthesis time. As a result, many of the device-tree bindings are meant to
+  reflect the synthesis configuration and must not be configured differently.
+  Matching synthesis parameters are provided when applicable.
+
+  Layers are declared in the "layers" sub-node and have dedicated configuration.
+  In version 3 of the controller, each layer has fixed memory offset and address
+  starting from the video memory base address for its framebuffer. In version 4,
+  framebuffers are configured with a direct memory address instead.
+
+properties:
+  compatible:
+    enum:
+      - xylon,logicvc-3.02.a-display
+      - xylon,logicvc-4.01.a-display
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      # vclk is required and must be provided as first item.
+      - const: vclk
+      # Other clocks are optional and can be provided in any order.
+      - enum:
+          - vclk2
+          - lvdsclk
+          - lvdsclkn
+      - enum:
+          - vclk2
+          - lvdsclk
+          - lvdsclkn
+      - enum:
+          - vclk2
+          - lvdsclk
+          - lvdsclkn
+
+  interrupts:
+    maxItems: 1
+
+  memory-region:
+    maxItems: 1
+
+  xylon,display-interface:
+    enum:
+      # Parallel RGB interface (C_DISPLAY_INTERFACE == 0)
+      - parallel-rgb
+      # ITU-T BR656 interface (C_DISPLAY_INTERFACE == 1)
+      - bt656
+      # 4-bit LVDS interface (C_DISPLAY_INTERFACE == 2)
+      - lvds-4bits
+      # 3-bit LVDS interface (C_DISPLAY_INTERFACE == 4)
+      - lvds-3bits
+      # DVI interface (C_DISPLAY_INTERFACE == 5)
+      - dvi
+    description: Display output interface (C_DISPLAY_INTERFACE).
+
+  xylon,display-colorspace:
+    enum:
+      # RGB colorspace (C_DISPLAY_COLOR_SPACE == 0)
+      - rgb
+      # YUV 4:2:2 colorspace (C_DISPLAY_COLOR_SPACE == 1)
+      - yuv422
+      # YUV 4:4:4 colorspace (C_DISPLAY_COLOR_SPACE == 2)
+      - yuv444
+    description: Display output colorspace (C_DISPLAY_COLOR_SPACE).
+
+  xylon,display-depth:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: Display output depth (C_PIXEL_DATA_WIDTH).
+
+  xylon,row-stride:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: Fixed number of pixels in a framebuffer row (C_ROW_STRIDE).
+
+  xylon,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Syscon phandle representing the top-level logicvc instance, useful when
+      the parent node is not the top-level logicvc instance.
+
+  xylon,dithering:
+    $ref: "/schemas/types.yaml#/definitions/flag"
+    description: Dithering module is enabled (C_XCOLOR)
+
+  xylon,background-layer:
+    $ref: "/schemas/types.yaml#/definitions/flag"
+    description: |
+      The last layer is used to display a black background (C_USE_BACKGROUND).
+      The layer must still be registered.
+
+  xylon,layers-configurable:
+     $ref: "/schemas/types.yaml#/definitions/flag"
+     description: |
+       Configuration of layers' size, position and offset is enabled
+       (C_USE_SIZE_POSITION).
+
+  layers:
+    type: object
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^layer@[0-9]+$":
+        type: object
+
+        properties:
+          reg:
+            maxItems: 1
+
+          xylon,layer-depth:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            description: Layer depth (C_LAYER_X_DATA_WIDTH).
+
+          xylon,layer-colorspace:
+            enum:
+              # RGB colorspace (C_LAYER_X_TYPE == 0)
+              - rgb
+              # YUV packed colorspace (C_LAYER_X_TYPE == 0)
+              - yuv
+            description: Layer colorspace (C_LAYER_X_TYPE).
+
+          xylon,layer-alpha-mode:
+            enum:
+              # Alpha is configured layer-wide (C_LAYER_X_ALPHA_MODE == 0)
+              - layer
+              # Alpha is configured per-pixel (C_LAYER_X_ALPHA_MODE == 1)
+              - pixel
+            description: Alpha mode for the layer (C_LAYER_X_ALPHA_MODE).
+
+          xylon,layer-base-offset:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            description: |
+              Offset in number of lines (C_LAYER_X_OFFSET) starting from the
+              video RAM base (C_VMEM_BASEADDR), only for version 3.
+
+          xylon,layer-buffer-offset:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            description: |
+              Offset in number of lines (C_BUFFER_*_OFFSET) starting from the
+              layer base offset for the second buffer used in double-buffering.
+
+          xylon,layer-primary:
+            $ref: "/schemas/types.yaml#/definitions/flag"
+            description: |
+              Layer should be registered as a primary plane (exactly one is
+              required).
+
+        additionalProperties: false
+
+        required:
+          - reg
+          - xylon,layer-depth
+          - xylon,layer-colorspace
+          - xylon,layer-alpha-mode
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+      - layer@0
+
+    additionalProperties: false
+
+    description: |
+      The description of the display controller layers, containing layer
+      sub-nodes that each describe a registered layer.
+
+  ports:
+    type: object
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - xylon,display-interface
+  - xylon,display-colorspace
+  - xylon,display-depth
+  - xylon,row-stride
+  - layers
+  - ports
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    logicvc: logicvc@43c00000 {
+      compatible = "xylon,logicvc-3.02.a", "syscon", "simple-mfd";
+      reg = <0x43c00000 0x6000>;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      logicvc_display: display-engine@0 {
+        compatible = "xylon,logicvc-3.02.a-display";
+        reg = <0x0 0x6000>;
+
+        memory-region = <&logicvc_cma>;
+
+        clocks = <&logicvc_vclk 0>, <&logicvc_lvdsclk 0>;
+        clock-names = "vclk", "lvdsclk";
+
+        interrupt-parent = <&intc>;
+        interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
+
+        xylon,display-interface = "lvds-4bits";
+        xylon,display-colorspace = "rgb";
+        xylon,display-depth = <16>;
+        xylon,row-stride = <1024>;
+
+        xylon,layers-configurable;
+
+        layers {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          layer@0 {
+            reg = <0>;
+            xylon,layer-depth = <16>;
+            xylon,layer-colorspace = "rgb";
+            xylon,layer-alpha-mode = "layer";
+            xylon,layer-base-offset = <0>;
+            xylon,layer-buffer-offset = <480>;
+            xylon,layer-primary;
+          };
+
+          layer@1 {
+            reg = <1>;
+            xylon,layer-depth = <16>;
+            xylon,layer-colorspace = "rgb";
+            xylon,layer-alpha-mode = "layer";
+            xylon,layer-base-offset = <2400>;
+            xylon,layer-buffer-offset = <480>;
+          };
+
+          layer@2 {
+            reg = <2>;
+            xylon,layer-depth = <16>;
+            xylon,layer-colorspace = "rgb";
+            xylon,layer-alpha-mode = "layer";
+            xylon,layer-base-offset = <960>;
+            xylon,layer-buffer-offset = <480>;
+          };
+
+          layer@3 {
+            reg = <3>;
+            xylon,layer-depth = <16>;
+            xylon,layer-colorspace = "rgb";
+            xylon,layer-alpha-mode = "layer";
+            xylon,layer-base-offset = <480>;
+            xylon,layer-buffer-offset = <480>;
+          };
+
+          layer@4 {
+            reg = <4>;
+            xylon,layer-depth = <16>;
+            xylon,layer-colorspace = "rgb";
+            xylon,layer-alpha-mode = "layer";
+            xylon,layer-base-offset = <8192>;
+            xylon,layer-buffer-offset = <480>;
+          };
+        };
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          logicvc_out: port@1 {
+            reg = <1>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            logicvc_output: endpoint@0 {
+              reg = <0>;
+              remote-endpoint = <&panel_input>;
+            };
+          };
+        };
+      };
+    };
-- 
2.24.0

