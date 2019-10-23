Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FDDCA9EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCF8205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407958AbfJWWjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:39:13 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57332 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407932AbfJWWjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:39:13 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iNPHR-0004FB-Kh; Thu, 24 Oct 2019 00:39:01 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     kishon@ti.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bivvy.bi@rock-chips.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/3] dt-bindings: phy: add yaml binding for rockchip,px30-dsi-dphy
Date:   Thu, 24 Oct 2019 00:38:50 +0200
Message-Id: <20191023223851.3030-2-heiko@sntech.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023223851.3030-1-heiko@sntech.de>
References: <20191023223851.3030-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a yaml binding for the external dsi phy found on Rockchip
socs of the px30, rk3128 and rk3368 variants.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/phy/rockchip,px30-dsi-dphy.yaml  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
new file mode 100644
index 000000000000..c2e1a998a766
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,px30-dsi-dphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip MIPI DPHY with additional LVDS/TTL modes
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  "#phy-cells":
+    const: 0
+
+  "#clock-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - rockchip,px30-dsi-dphy
+      - rockchip,rk3128-dsi-dphy
+      - rockchip,rk3368-dsi-dphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PLL reference clock
+      - description: Module clock
+
+  clock-names:
+    items:
+      - const: ref
+      - const: pclk
+
+  power-domains:
+    maxItems: 1
+    description: phandle to the associated power domain
+
+  resets:
+    items:
+      - description: exclusive PHY reset line
+
+  reset-names:
+    items:
+      - const: apb
+
+required:
+  - "#phy-cells"
+  - "#clock-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi_dphy: phy@ff2e0000 {
+        compatible = "rockchip,px30-video-phy";
+        reg = <0x0 0xff2e0000 0x0 0x10000>;
+        clocks = <&pmucru 13>, <&cru 12>;
+        clock-names = "ref", "pclk";
+        #clock-cells = <0>;
+        resets = <&cru 12>;
+        reset-names = "apb";
+        #phy-cells = <0>;
+    };
+
+...
-- 
2.23.0

