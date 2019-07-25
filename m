Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983EEC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7507E2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbfGYPSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:18:34 -0400
Received: from verein.lst.de ([213.95.11.211]:36197 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389047AbfGYPSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:18:33 -0400
Received: by verein.lst.de (Postfix, from userid 2005)
        id DC20968B02; Thu, 25 Jul 2019 17:18:29 +0200 (CEST)
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190722150414.9F97668B20@verein.lst.de>
Subject: [PATCH v3 6a/7] dt-bindings: Add ANX6345 DP/eDP transmitter binding
Message-Id: <20190725151829.DC20968B02@verein.lst.de>
Date:   Thu, 25 Jul 2019 17:18:29 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The anx6345 is an ultra-low power DisplayPort/eDP transmitter designed
for portable devices.

Add a binding document for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../devicetree/bindings/display/bridge/anx6345.yaml |   90 ++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/anx6345.yaml b/Documentation/devicetree/bindings/display/bridge/anx6345.yaml
new file mode 100644
index 000000000000..0af092d101c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/anx6345.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/anx6345.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analogix ANX6345 eDP Transmitter Device Tree Bindings
+
+maintainers:
+  - Torsten Duwe <duwe@lst.de>
+
+description: |
+  The ANX6345 is an ultra-low power Full-HD eDP transmitter designed for
+  portable devices.
+
+properties:
+  compatible:
+    const: analogix,anx6345
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device
+
+  reset-gpios:
+    maxItems: 1
+    description: active low GPIO to use for reset
+
+  dvdd12-supply:
+    maxItems: 1
+    description: Regulator for 1.2V digital core power.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  dvdd25-supply:
+    maxItems: 1
+    description: Regulator for 2.5V digital core power.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  ports:
+    type: object
+    minItems: 1
+    maxItems: 2
+    description: |
+      Video port 0 for LVTTL input,
+      Video port 1 for eDP output (panel or connector)
+      using the DT bindings defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - dvdd12-supply
+  - dvdd25-supply
+  - ports
+
+examples:
+ - |
+  anx6345: anx6345@38 {
+      compatible = "analogix,anx6345";
+      reg = <0x38>;
+      reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
+      dvdd25-supply = <&reg_dldo2>;
+      dvdd12-supply = <&reg_fldo1>;
+
+      ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          anx6345_in: port@0 {
+              #address-cells = <1>;
+              #size-cells = <0>;
+              reg = <0>;
+              anx6345_in_tcon0: endpoint@0 {
+                  reg = <0>;
+                  remote-endpoint = <&tcon0_out_anx6345>;
+              };
+          };
+
+          anx6345_out: port@1 {
+              #address-cells = <1>;
+              #size-cells = <0>;
+              reg = <1>;
+
+              anx6345_out_panel: endpoint@0 {
+                  reg = <0>;
+                  remote-endpoint = <&panel_in_edp>;
+              };
+          };
+      };
+  };
