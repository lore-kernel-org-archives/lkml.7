Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA551C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE8B217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfI0KEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:04:37 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43473 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfI0KEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 06:04:20 -0400
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5FFA8240027;
        Fri, 27 Sep 2019 10:04:18 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 2/5] dt-bindings: mfd: Document the Xylon LogiCVC multi-function device
Date:   Fri, 27 Sep 2019 12:04:04 +0200
Message-Id: <20190927100407.1863293-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190927100407.1863293-1-paul.kocialkowski@bootlin.com>
References: <20190927100407.1863293-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LogiCVC is a display engine which also exposes GPIO functionality.
For this reason, it is described as a multi-function device that is expected
to provide register access to its children nodes for gpio and display.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../bindings/mfd/xylon,logicvc.yaml           | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml b/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
new file mode 100644
index 000000000000..abc9937506e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Bootlin
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mfd/xylon,logicvc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Xylon LogiCVC multi-function device
+
+maintainers:
+  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+
+description: |
+  The LogiCVC is a display controller that also contains a GPIO controller.
+  As a result, a multi-function device is exposed as parent of the display
+  and GPIO blocks.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xylon,logicvc-3.02.a
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - xylon,logicvc-3.02.a
+
+  required:
+    - compatible
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    logicvc: logicvc@43c00000 {
+      compatible = "xylon,logicvc-3.02.a", "syscon", "simple-mfd";
+      reg = <0x43c00000 0x6000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+    };
-- 
2.23.0

