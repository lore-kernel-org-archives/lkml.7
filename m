Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95232C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0B82089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393975AbfIJPea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:34:30 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55873 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfIJPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:34:28 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7B4A424000A;
        Tue, 10 Sep 2019 15:34:25 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/2] dt-bindings: display: Add xylon logicvc bindings documentation
Date:   Tue, 10 Sep 2019 17:34:08 +0200
Message-Id: <20190910153409.111901-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910153409.111901-1-paul.kocialkowski@bootlin.com>
References: <20190910153409.111901-1-paul.kocialkowski@bootlin.com>
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
 .../bindings/display/xylon,logicvc.txt        | 188 ++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc.txt

diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc.txt b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
new file mode 100644
index 000000000000..eb4b1553888a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
@@ -0,0 +1,188 @@
+Xylon LogiCVC display controller
+
+The Xylon LogiCVC is a display controller that supports multiple layers.
+It is usually implemented as programmable logic and was optimized for use
+with Xilinx Zynq-7000 SoCs and Xilinx FPGAs.
+
+Because the controller is intended for use in a FPGA, most of the configuration
+of the controller takes place at logic configuration bitstream synthesis time.
+As a result, many of the device-tree bindings are meant to reflect the
+synthesis configuration. These do not allow configuring the controller
+differently than synthesis configuration.
+
+Layers are declared in the "layers" sub-node and have dedicated configuration.
+In version 3 of the controller, each layer has fixed memory offset and address
+starting from the video memory base address for its framebuffer. With version 4,
+framebuffers are configured with a direct memory address instead.
+
+Matching synthesis parameters are provided when applicable.
+
+Required properties:
+- compatible: Should be one of:
+  "xylon,logicvc-3.02.a-display"
+  "xylon,logicvc-4.01.a-display"
+- reg: Physical base address and size for the controller registers.
+- clocks: List of phandle and clock-specifier pairs, one for each entry
+  in 'clock-names'
+- clock-names: List of clock names that should at least contain:
+  - "vclk": The VCLK video clock input.
+- interrupts: The interrupt to use for VBLANK signaling.
+- xylon,display-interface: Display interface in use, should be one of:
+  - "lvds-4bits": 4-bit LVDS interface (C_DISPLAY_INTERFACE == 4).
+- xylon,display-colorspace: Display output colorspace in use, should be one of:
+  - "rgb": RGB colorspace (C_DISPLAY_COLOR_SPACE == 0).
+- xylon,display-depth: Display output depth in use (C_PIXEL_DATA_WIDTH).
+- xylon,row-stride: Fixed number of pixels in a framebuffer row (C_ROW_STRIDE).
+- xylon,layers-count: The number of available layers (C_NUM_OF_LAYERS).
+
+Optional properties:
+- memory-region: phandle to a node describing memory, as specified in:
+  Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+- clock-names: List of clock names that can optionally contain:
+  - "vclk2": The VCLK2 doubled-rate video clock input.
+  - "lvdsclk": The LVDS clock.
+  - "lvdsclkn": The LVDS clock inverted.
+- xylon,syscon: Syscon phandle representing the logicvc instance.
+- xylon,dithering: Dithering module is enabled (C_XCOLOR).
+- xylon,background-layer: The last layer is used to display a black background
+  (C_USE_BACKGROUND). It must still be registered.
+- xylon,layers-configurable: Configuration of layers' size, position and offset
+  is enabled (C_USE_SIZE_POSITION).
+
+Required sub-nodes:
+- layers: The description of the display controller layers, containing layer
+  sub-nodes that each describe a registered layer.
+- ports: The LogiCVC connection to an encoder input port. The connection
+  is modeled using the OF graph bindings, as specified in:
+  Documentation/devicetree/bindings/graph.txt
+
+Required layer properties:
+- reg: Layer index (from front to back, starting at 0).
+- xylon,layer-depth: Layer depth in use (C_LAYER_0_DATA_WIDTH).
+- xylon,layer-colorspace: Layer colorspace in use, should be one of:
+ - "rgb": RGB colorspace (C_LAYER_*_TYPE == 0).
+- xylon,layer-alpha-mode: Alpha mode for the layer, should be one of:
+ - "layer": Alpha is configured layer-wide (C_LAYER_*_ALPHA_MODE == 0).
+ - "pixel": Alpha is configured per-pixel (C_LAYER_*_ALPHA_MODE == 1).
+- xylon,layer-base-offset: offset in number of lines (C_LAYER_*_OFFSET) starting
+  from the video RAM base (C_VMEM_BASEADDR), only for version 3.
+- xylon,layer-buffer-offset: offset in number of lines (C_BUFFER_*_OFFSET)
+  starting from the layer base offset for the second buffer used in
+  double-buffering.
+
+Optional layer properties:
+- xylon,layer-primary: Layer should be registered as a primary plane (exactly
+  one is required).
+
+Example:
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		logicvc_cma: cma@1f800000 {
+			compatible = "shared-dma-pool";
+			size = <0x800000>;
+			alloc-ranges = <0x1f800000 0x800000>;
+			reusable;
+		};
+	};
+
+	logicvc: logicvc@43c00000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x43c00000 0x6000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		logicvc_display: display-engine@0 {
+			compatible = "xylon,logicvc-3.02.a-display";
+			reg = <0x0 0x6000>;
+			memory-region = <&logicvc_cma>;
+
+			clocks = <&logicvc_vclk 0>, <&logicvc_lvdsclk 0>;
+			clock-names = "vclk", "lvdsclk";
+
+			interrupt-parent = <&intc>;
+			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
+
+			xylon,syscon = <&logicvc>;
+
+			xylon,display-interface = "lvds-4bits";
+			xylon,display-colorspace = "rgb";
+			xylon,display-depth = <16>;
+			xylon,row-stride = <1024>;
+
+			xylon,layers-configurable;
+			xylon,layers-count = <5>;
+
+			layers {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				layer@0 {
+					reg = <0>;
+					xylon,layer-depth = <16>;
+					xylon,layer-colorspace = "rgb";
+					xylon,layer-alpha-mode = "layer";
+					xylon,layer-base-offset = <0>;
+					xylon,layer-buffer-offset = <480>;
+					xylon,layer-primary;
+				};
+
+				layer@1 {
+					reg = <1>;
+					xylon,layer-depth = <16>;
+					xylon,layer-colorspace = "rgb";
+					xylon,layer-alpha-mode = "layer";
+					xylon,layer-base-offset = <2400>;
+					xylon,layer-buffer-offset = <480>;
+				};
+
+				layer@2 {
+					reg = <2>;
+					xylon,layer-depth = <16>;
+					xylon,layer-colorspace = "rgb";
+					xylon,layer-alpha-mode = "layer";
+					xylon,layer-base-offset = <960>;
+					xylon,layer-buffer-offset = <480>;
+				};
+
+				layer@3 {
+					reg = <3>;
+					xylon,layer-depth = <16>;
+					xylon,layer-colorspace = "rgb";
+					xylon,layer-alpha-mode = "layer";
+					xylon,layer-base-offset = <480>;
+					xylon,layer-buffer-offset = <480>;
+				};
+
+				layer@4 {
+					reg = <4>;
+					xylon,layer-depth = <16>;
+					xylon,layer-colorspace = "rgb";
+					xylon,layer-alpha-mode = "layer";
+					xylon,layer-base-offset = <8192>;
+					xylon,layer-buffer-offset = <480>;
+				};
+			};
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				logicvc_out: port@1 {
+					reg = <1>;
+
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					logicvc_output: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&panel_input>;
+					};
+				};
+			};
+		};
+	};
-- 
2.23.0

