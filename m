Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CD0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAABC20725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="izt5sIo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLPJ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:56:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58836 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLPJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uYET106184;
        Mon, 16 Dec 2019 03:56:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490194;
        bh=Dp1c8McrlzT08m2GtipwVgtlhr0EKQPJGCmLbB+VZUs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=izt5sIo4Db19Ch1dgWxIFufgUzX/s6pc7OH4NeqV98ZkzBoTwXoG6clUSgkP3f51j
         lFahlCLoXIYzCDE/3HM6a4MRTr0Zj8mbiBdXUGAdalyIJ6YV0TszUSPh5BSy9UJNi5
         7Qnl53AolZMnfzVIZDKtBdmLmKqz0LpkJXZdLopI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBG9uYTh125520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 03:56:34 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:56:34 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:56:33 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tsJW084408;
        Mon, 16 Dec 2019 03:56:31 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
Date:   Mon, 16 Dec 2019 15:27:11 +0530
Message-ID: <20191216095712.13266-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216095712.13266-1-kishon@ti.com>
References: <20191216095712.13266-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
PHY but a wrapper used to configure some of the input signals to the
SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
 SERDES]
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
new file mode 100644
index 000000000000..fd4204a960a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -0,0 +1,204 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/ti,phy-j721e-wiz.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI J721E WIZ (SERDES Wrapper)
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+properties:
+  compatible:
+      enum:
+          - ti,j721e-wiz-16g
+          - ti,j721e-wiz-10g
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+    description: clock-specifier to represent input to the WIZ
+
+  clock-names:
+    items:
+      - const: fck
+      - const: core_ref_clk
+      - const: ext_ref_clk
+
+  num-lanes:
+    minimum: 1
+    maximum: 4
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  ranges: true
+
+  assigned-clocks:
+    maxItems: 2
+
+  assigned-clock-parents:
+    maxItems: 2
+
+patternProperties:
+   "^pll[0|1]-refclk$":
+    type: object
+    description: |
+      WIZ node should have subnodes for each of the PLLs present in
+      the SERDES.
+    properties:
+      clocks:
+        maxItems: 2
+        description: Phandle to clock nodes representing the two inputs to PLL.
+
+      "#clock-cells":
+        const: 0
+
+      assigned-clocks:
+        maxItems: 1
+
+      assigned-clock-parents:
+        maxItems: 1
+
+    required:
+      - clocks
+      - "#clock-cells"
+      - assigned-clocks
+      - assigned-clock-parents
+
+   "^cmn-refclk1?-dig-div$":
+    type: object
+    description: |
+      WIZ node should have subnodes for each of the PMA common refclock
+      provided by the SERDES.
+    properties:
+      clocks:
+        maxItems: 1
+        description: Phandle to the clock node representing the input to the
+          divider clock.
+
+      "#clock-cells":
+        const: 0
+
+    required:
+      - clocks
+      - "#clock-cells"
+
+   "^refclk-dig$":
+    type: object
+    description: |
+      WIZ node should have subnode for refclk_dig to select the reference
+      clock source for the reference clock used in the PHY and PMA digital
+      logic.
+    properties:
+      clocks:
+        maxItems: 4
+        description: Phandle to four clock nodes representing the inputs to
+          refclk_dig
+
+      "#clock-cells":
+        const: 0
+
+      assigned-clocks:
+        maxItems: 1
+
+      assigned-clock-parents:
+        maxItems: 1
+
+    required:
+      - clocks
+      - "#clock-cells"
+      - assigned-clocks
+      - assigned-clock-parents
+
+   "^serdes@[0-9a-f]+$":
+    type: object
+    description: |
+      WIZ node should have '1' subnode for the SERDES. It could be either
+      Sierra SERDES or Torrent SERDES. Sierra SERDES should follow the
+      bindings specified in
+      Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
+      Torrent SERDES should follow the bindings specified in
+      Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
+
+required:
+  - compatible
+  - power-domains
+  - clocks
+  - clock-names
+  - num-lanes
+  - "#address-cells"
+  - "#size-cells"
+  - "#reset-cells"
+  - ranges
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    wiz@5000000 {
+           compatible = "ti,j721e-wiz-16g";
+           #address-cells = <1>;
+           #size-cells = <1>;
+           power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
+           clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
+           clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+           assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
+           assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
+           num-lanes = <2>;
+           #reset-cells = <1>;
+           ranges = <0x5000000 0x0 0x5000000 0x10000>;
+
+           pll0-refclk {
+                  clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
+                  #clock-cells = <0>;
+                  assigned-clocks = <&wiz1_pll0_refclk>;
+                  assigned-clock-parents = <&k3_clks 293 13>;
+           };
+
+           pll1-refclk {
+                  clocks = <&k3_clks 293 0>, <&dummy_cmn_refclk1>;
+                  #clock-cells = <0>;
+                  assigned-clocks = <&wiz1_pll1_refclk>;
+                  assigned-clock-parents = <&k3_clks 293 0>;
+           };
+
+           cmn-refclk-dig-div {
+                  clocks = <&wiz1_refclk_dig>;
+                  #clock-cells = <0>;
+           };
+
+           cmn-refclk1-dig-div {
+                  clocks = <&wiz1_pll1_refclk>;
+                  #clock-cells = <0>;
+           };
+
+           refclk-dig {
+                  clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+                  #clock-cells = <0>;
+                  assigned-clocks = <&wiz0_refclk_dig>;
+                  assigned-clock-parents = <&k3_clks 292 11>;
+           };
+
+           serdes@5000000 {
+                  compatible = "cdns,ti,sierra-phy-t0";
+                  reg-names = "serdes";
+                  reg = <0x5000000 0x10000>;
+                  #address-cells = <1>;
+                  #size-cells = <0>;
+                  resets = <&serdes_wiz0 0>;
+                  reset-names = "sierra_reset";
+                  clocks = <&wiz0_cmn_refclk_dig_div>, <&wiz0_cmn_refclk1_dig_div>;
+                  clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+           };
+    };
-- 
2.17.1

