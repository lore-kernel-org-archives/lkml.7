Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1AFC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE6B20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437101AbfHIQYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:24:43 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:58948 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406171AbfHIQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:24:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D3A35FB02;
        Fri,  9 Aug 2019 18:24:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3YWp7d4m5v1w; Fri,  9 Aug 2019 18:24:26 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B904E41DAD; Fri,  9 Aug 2019 18:24:23 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 2/3] dt-bindings: display/bridge: Add binding for NWL mipi dsi host controller
Date:   Fri,  9 Aug 2019 18:24:22 +0200
Message-Id: <9c906bb6592424acdb1a67447a482e010a113b49.1565367567.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1565367567.git.agx@sigxcpu.org>
References: <cover.1565367567.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../bindings/display/bridge/nwl-dsi.yaml      | 155 ++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
new file mode 100644
index 000000000000..5ed8bc4a4d18
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/imx-nwl-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Northwest Logic MIPI-DSI on imx SoCs
+
+maintainers:
+  - Guido Gúnther <agx@sigxcpu.org>
+  - Robert Chiras <robert.chiras@nxp.com>
+
+description: |
+  NWL MIPI-DSI host controller found on i.MX8 platforms. This is a dsi bridge for
+  the SOCs NWL MIPI-DSI host controller.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: fsl,imx8mq-nwl-dsi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: DSI core clock
+      - description: RX_ESC clock (used in escape mode)
+      - description: TX_ESC clock (used in escape mode)
+      - description: PHY_REF clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: rx_esc
+      - const: tx_esc
+      - const: phy_ref
+
+  phys:
+    maxItems: 1
+    description:
+      A phandle to the phy module representing the DPHY
+
+  phy-names:
+    items:
+      - const: dphy
+
+  power-domains:
+    maxItems: 1
+    description:
+      A phandle to the power domain
+
+  resets:
+    maxItems: 4
+    description:
+      A phandle to the reset controller
+
+  reset-names:
+    items:
+      - const: byte
+      - const: dpi
+      - const: esc
+      - const: pclk
+
+  mux-sel:
+    maxItems: 1
+    description:
+      A phandle to the MUX register set
+
+  port:
+    type: object
+    description:
+      A input put or output port node.
+
+  ports:
+    type: object
+    description:
+      A node containing DSI input & output port nodes with endpoint
+      definitions as documented in
+      Documentation/devicetree/bindings/graph.txt.
+
+patternProperties:
+  "^panel@[0-9]+$": true
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8mq-nwl-dsi
+    then:
+      required:
+        - resets
+        - reset-names
+        - mux-sel
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+
+examples:
+ - |
+
+   mipi_dsi: mipi_dsi@30a00000 {
+              #address-cells = <1>;
+              #size-cells = <0>;
+              compatible = "fsl,imx8mq-nwl-dsi";
+              reg = <0x30A00000 0x300>;
+              clocks = <&clk 163>, <&clk 244>, <&clk 245>, <&clk 164>;
+              clock-names = "core", "rx_esc", "tx_esc", "phy_ref";
+              interrupts = <0 34 4>;
+              power-domains = <&pgc_mipi>;
+              resets = <&src 0>, <&src 1>, <&src 2>, <&src 3>;
+              reset-names = "byte", "dpi", "esc", "pclk";
+              mux-sel = <&iomuxc_gpr>;
+              phys = <&dphy>;
+              phy-names = "dphy";
+
+              panel@0 {
+                      compatible = "...";
+                      port@0 {
+                           panel_in: endpoint {
+                                     remote-endpoint = <&mipi_dsi_out>;
+                           };
+                      };
+              };
+
+              ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                           reg = <0>;
+                           mipi_dsi_in: endpoint {
+                                        remote-endpoint = <&lcdif_mipi_dsi>;
+                           };
+                    };
+                    port@1 {
+                           reg = <1>;
+                           mipi_dsi_out: endpoint {
+                                         remote-endpoint = <&panel_in>;
+                           };
+                    };
+              };
+      };
-- 
2.20.1

