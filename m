Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B55C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8331620854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfJOKoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:44:54 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44075 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfJOKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:44:53 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 70616C0005;
        Tue, 15 Oct 2019 10:44:47 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli+renesas@fpond.eu,
        VenkataRajesh.Kalakodima@in.bosch.com
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, airlied@linux.ie,
        daniel@ffwll.ch, koji.matsuoka.xm@renesas.com, muroya@ksk.co.jp,
        Harsha.ManjulaMallikarjun@in.bosch.com, ezequiel@collabora.com,
        seanpaul@chromium.org, linux-renesas-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: [PATCH v5 1/8] dt-bindings: display: renesas,cmm: Add R-Car CMM documentation
Date:   Tue, 15 Oct 2019 12:46:14 +0200
Message-Id: <20191015104621.62514-2-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015104621.62514-1-jacopo+renesas@jmondi.org>
References: <20191015104621.62514-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings documentation for the Renesas R-Car Display
Unit Color Management Module.

CMM is the image enhancement module available on each R-Car DU video
channel on R-Car Gen2 and Gen3 SoCs (V3H and V3M excluded).

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../bindings/display/renesas,cmm.yaml         | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/renesas,cmm.yaml

diff --git a/Documentation/devicetree/bindings/display/renesas,cmm.yaml b/Documentation/devicetree/bindings/display/renesas,cmm.yaml
new file mode 100644
index 000000000000..a57037b9e9ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/renesas,cmm.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/renesas,cmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car Color Management Module (CMM)
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+  - Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
+  - Jacopo Mondi <jacopo+renesas@jmondi.org>
+
+description: |+
+  Renesas R-Car color management module connected to R-Car DU video channels.
+  It provides image enhancement functions such as 1-D look-up tables (LUT),
+  3-D look-up tables (CLU), 1D-histogram generation (HGO), and color
+  space conversion (CSC).
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - renesas,r8a7795-cmm
+          - renesas,r8a7796-cmm
+          - renesas,r8a77965-cmm
+          - renesas,r8a77990-cmm
+          - renesas,r8a77995-cmm
+        - const: renesas,rcar-gen3-cmm
+      - items:
+        - const: renesas,rcar-gen2-cmm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7796-cpg-mssr.h>
+    #include <dt-bindings/power/r8a7796-sysc.h>
+
+    cmm0: cmm@fea40000 {
+         compatible = "renesas,r8a7796-cmm",
+                      "renesas,rcar-gen3-cmm";
+         reg = <0 0xfea40000 0 0x1000>;
+         power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+         clocks = <&cpg CPG_MOD 711>;
+         resets = <&cpg 711>;
+    };
--
2.23.0

