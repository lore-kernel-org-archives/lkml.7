Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B6C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2650524679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLTIRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:17:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57908 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfLTIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:17:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C47B4293281
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Jitao Shi <jitao.shi@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ulrich Hecht <uli@fpond.eu>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v22 1/2] Documentation: bridge: Add documentation for ps8640 DT properties
Date:   Fri, 20 Dec 2019 09:17:37 +0100
Message-Id: <20191220081738.1895-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220081738.1895-1-enric.balletbo@collabora.com>
References: <20191220081738.1895-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jitao Shi <jitao.shi@mediatek.com>

Add documentation for DT properties supported by
ps8640 DSI-eDP converter.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Ulrich Hecht <uli@fpond.eu>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
I maintained the ack from Rob Herring and the review from Philipp
because in essence the only thing I did is migrate to YAML format and
check that no errors are reported via dtbs_check. Just let me know if
you're not agree.

Apart from this note that I removed the mode-sel property because is not
used and I renamed sleep-gpios to powerdown-gpios.

Changes in v22:
- Migrate to YAML format (Maxime Ripart)
- Remove mode-sel property.
- Rename sleep-gpios to powerdown-gpios.

Changes in v21: None
Changes in v19: None
Changes in v18: None
Changes in v17: None
Changes in v16: None
Changes in v15: None
Changes in v14: None
Changes in v13: None
Changes in v12: None
Changes in v11: None

 .../bindings/display/bridge/ps8640.yaml       | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ps8640.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/ps8640.yaml b/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
new file mode 100644
index 000000000000..5dff93641bea
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/ps8640.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MIPI DSI to eDP Video Format Converter Device Tree Bindings
+
+maintainers:
+  - Nicolas Boichat <drinkcat@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
+description: |
+  The PS8640 is a low power MIPI-to-eDP video format converter supporting
+  mobile devices with embedded panel resolutions up to 2048 x 1536. The
+  device accepts a single channel of MIPI DSI v1.1, with up to four lanes
+  plus clock, at a transmission rate up to 1.5Gbit/sec per lane. The
+  device outputs eDP v1.4, one or two lanes, at a link rate of up to
+  3.24Gbit/sec per lane.
+
+properties:
+  compatible:
+    const: parade,ps8640
+
+  reg:
+    maxItems: 1
+    description: Base I2C address of the device.
+
+  powerdown-gpios:
+    maxItems: 1
+    description: GPIO connected to active low powerdown.
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to active low reset.
+
+  vdd12-supply:
+    maxItems: 1
+    description: Regulator for 1.2V digital core power.
+
+  vdd33-supply:
+    maxItems: 1
+    description: Regulator for 3.3V digital core power.
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
+        description: |
+          Video port for DSI input
+
+      port@1:
+        type: object
+        description: |
+          Video port for eDP output (panel or connector).
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - reg
+  - powerdown-gpios
+  - reset-gpios
+  - vdd12-supply
+  - vdd33-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ps8640: edp-bridge@18 {
+            compatible = "parade,ps8640";
+            reg = <0x18>;
+            powerdown-gpios = <&pio 116 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&pio 115 GPIO_ACTIVE_LOW>;
+            vdd12-supply = <&ps8640_fixed_1v2>;
+            vdd33-supply = <&mt6397_vgp2_reg>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    ps8640_in: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    ps8640_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                   };
+                };
+            };
+        };
+    };
+
-- 
2.20.1

