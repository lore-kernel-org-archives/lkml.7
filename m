Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B1DC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBB12176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLRGUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:20:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:57078 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfLRGUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 01:20:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 22:20:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,328,1571727600"; 
   d="scan'208";a="221931738"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2019 22:20:27 -0800
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yixin.zhu@linux.intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH] dt-bindings: pinctrl: intel: Update to use generic bindings
Date:   Wed, 18 Dec 2019 14:20:24 +0800
Message-Id: <20191218062024.25475-1-rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 5.5 adds generic pin mux & cfg node schema. Update pinctrl bindings
for LGM to use these newly added schemas. Also, rename filename to match
the compatible string.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/pinctrl/intel,lgm-io.yaml  |  76 ++++++++++++++
 .../bindings/pinctrl/intel,lgm-pinctrl.yaml        | 116 ---------------------
 2 files changed, 76 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/intel,lgm-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml b/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
new file mode 100644
index 000000000000..a386fb520510
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/pinctrl/intel,lgm-io.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Lightning Mountain SoC pinmux & GPIO controller binding
+
+maintainers:
+  - Rahul Tanwar <rahul.tanwar@linux.intel.com>
+
+description: |
+  Pinmux & GPIO controller controls pin multiplexing & configuration including
+  GPIO function selection & GPIO attributes configuration.
+
+allOf:
+  - $ref: pincfg-node.yaml#
+  - $ref: pinmux-node.yaml#
+
+properties:
+  compatible:
+    const: intel,lgm-io
+
+  reg:
+    maxItems: 1
+
+# Client device subnode's properties
+patternProperties:
+  '-pins$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+
+    properties:
+      function: true
+      group: true
+      pins: true
+      pinmux: true
+      bias-pull-up: true
+      bias-pull-down: true
+      drive-strength: true
+      slew-rate: true
+      drive-open-drain: true
+      output-enable: true
+
+    required:
+      - function
+      - group
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  # Pinmux controller node
+  - |
+    pinctrl: pinctrl@e2880000 {
+        compatible = "intel,lgm-io";
+        reg = <0xe2880000 0x100000>;
+
+        uart0-pins {
+             pins = <64>, /* UART_RX0 */
+                    <65>; /* UART_TX0 */
+             function = "CONSOLE_UART0";
+             pinmux = <1>,
+                      <1>;
+             groups = "CONSOLE_UART0";
+          };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/pinctrl/intel,lgm-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/intel,lgm-pinctrl.yaml
deleted file mode 100644
index 240d429f773b..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/intel,lgm-pinctrl.yaml
+++ /dev/null
@@ -1,116 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/bindings/pinctrl/intel,lgm-pinctrl.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Intel Lightning Mountain SoC pinmux & GPIO controller binding
-
-maintainers:
-  - Rahul Tanwar <rahul.tanwar@linux.intel.com>
-
-description: |
-  Pinmux & GPIO controller controls pin multiplexing & configuration including
-  GPIO function selection & GPIO attributes configuration.
-
-  Please refer to [1] for details of the common pinctrl bindings used by the
-  client devices.
-
-  [1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
-properties:
-  compatible:
-    const: intel,lgm-io
-
-  reg:
-    maxItems: 1
-
-# Client device subnode's properties
-patternProperties:
-  '-pins$':
-    type: object
-    description:
-      Pinctrl node's client devices use subnodes for desired pin configuration.
-      Client device subnodes use below standard properties.
-
-    properties:
-      function:
-        $ref: /schemas/types.yaml#/definitions/string
-        description:
-          A string containing the name of the function to mux to the group.
-
-      groups:
-        $ref: /schemas/types.yaml#/definitions/string-array
-        description:
-          An array of strings identifying the list of groups.
-
-      pins:
-        $ref: /schemas/types.yaml#/definitions/uint32-array
-        description:
-          List of pins to select with this function.
-
-      pinmux:
-        description: The applicable mux group.
-        allOf:
-          - $ref: "/schemas/types.yaml#/definitions/uint32-array"
-
-      bias-pull-up:
-        type: boolean
-
-      bias-pull-down:
-        type: boolean
-
-      drive-strength:
-        description: |
-          Selects the drive strength for the specified pins in mA.
-          0: 2 mA
-          1: 4 mA
-          2: 8 mA
-          3: 12 mA
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [0, 1, 2, 3]
-
-      slew-rate:
-        type: boolean
-        description: |
-          Sets slew rate for specified pins.
-          0: slow slew
-          1: fast slew
-
-      drive-open-drain:
-        type: boolean
-
-      output-enable:
-        type: boolean
-
-    required:
-      - function
-      - groups
-
-    additionalProperties: false
-
-required:
-  - compatible
-  - reg
-
-additionalProperties: false
-
-examples:
-  # Pinmux controller node
-  - |
-    pinctrl: pinctrl@e2880000 {
-        compatible = "intel,lgm-pinctrl";
-        reg = <0xe2880000 0x100000>;
-
-        uart0-pins {
-             pins = <64>, /* UART_RX0 */
-                    <65>; /* UART_TX0 */
-             function = "CONSOLE_UART0";
-             pinmux = <1>,
-                      <1>;
-             groups = "CONSOLE_UART0";
-          };
-    };
-
-...
-- 
2.11.0

