Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E995C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF882089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKUFCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:02:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:36354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfKUFCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:02:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 355E0AFD4;
        Thu, 21 Nov 2019 05:02:18 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v5 1/9] dt-bindings: interrupt-controller: Add Realtek RTD1195/RTD1295 mux
Date:   Thu, 21 Nov 2019 06:02:00 +0100
Message-Id: <20191121050208.11324-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121050208.11324-1-afaerber@suse.de>
References: <20191121050208.11324-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Realtek RTD1295 and RTD1195 IRQ mux.

Acked-by: Rob Herring <robh@kernel.org>
[AF: Converted to YAML schema]
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v4 -> v5: Unchanged
 
 v3 -> v4:
 * Squashed RTD1195
 * Converted to YAML schema
 * Renamed file from realtek,rtd119x-mux to realtek,rtd1195-mux
 
 v2 -> v3:
 * Renamed non-iso irq mux to "misc" for clarity

 v1 -> v2:
 * Dropped reference to common interrupt.txt bindings (Rob)
 
 .../interrupt-controller/realtek,rtd1195-mux.yaml  | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml
new file mode 100644
index 000000000000..5cf3a28cedba
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/realtek,rtd1195-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTD1195/1295 IRQ Mux Controller
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - realtek,rtd1195-misc-irq-mux
+      - realtek,rtd1195-iso-irq-mux
+      - realtek,rtd1295-misc-irq-mux
+      - realtek,rtd1295-iso-irq-mux
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Specifies the interrupt line which is mux'ed.
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    interrupt-controller@98007000 {
+        compatible = "realtek,rtd1295-iso-irq-mux";
+        reg = <0x98007000 0x100>;
+        interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+    };
+...
-- 
2.16.4

