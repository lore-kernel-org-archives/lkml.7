Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A980BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD57214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKKKLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:11:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:32506 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfKKKLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:11:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 02:11:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,292,1569308400"; 
   d="scan'208";a="354734522"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga004.jf.intel.com with ESMTP; 11 Nov 2019 02:11:40 -0800
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v6 2/2] dt-bindings: pinctrl: intel: Add for new SoC
Date:   Mon, 11 Nov 2019 18:11:30 +0800
Message-Id: <96537f8702501a45501d5a59ca029f92e36a9e4a.1573455324.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1573455324.git.rahul.tanwar@linux.intel.com>
References: <cover.1573455324.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1573455324.git.rahul.tanwar@linux.intel.com>
References: <cover.1573455324.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings document for pinmux & GPIO controller driver of
Intel Lightning Mountain SoC.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../bindings/pinctrl/intel,lgm-pinctrl.yaml        | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/intel,lgm-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/intel,lgm-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/intel,lgm-pinctrl.yaml
new file mode 100644
index 000000000000..d54a3bda1f4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/intel,lgm-pinctrl.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/pinctrl/intel,lgm-pinctrl.yaml#
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
+  Please refer to [1] for details of the common pinctrl bindings used by the
+  client devices.
+
+  [1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+properties:
+  compatible:
+    const: intel,lgm-pinctrl
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
+      function:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          A string containing the name of the function to mux to the group.
+
+      groups:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description:
+          An array of strings identifying the list of groups.
+
+      pins:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          List of pins to select with this function.
+
+      pinmux:
+        description: The applicable mux group.
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32-array"
+
+      bias-pull-up:
+        type: boolean
+      bias-pull-down:
+        type: boolean
+      drive-strength:
+        type: boolean
+      slew-rate:
+        type: boolean
+      drive-open-drain:
+        type: boolean
+      output-enable:
+        type: boolean
+
+    required:
+      - function
+      - groups
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
+          compatible = "intel,lgm-pinctrl";
+          reg = <0xe2880000 0x100000>;
+
+          # Client device subnode
+          uart0-pins: uart0 {
+                pins = <64>, /* UART_RX0 */
+                       <65>; /* UART_TX0 */
+                function = "CONSOLE_UART0";
+                pinmux = <1>,
+                         <1>;
+                groups = "CONSOLE_UART0";
+          };
+    };
+
+...
-- 
2.11.0

