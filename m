Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2F4FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAE02082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Oa4uQPWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405117AbfJPLc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:32:28 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50402 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405101AbfJPLcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:32:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GBWH6b097221;
        Wed, 16 Oct 2019 06:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571225537;
        bh=lu2aQMjEO+OiMZpRh1hPo2mocSefRsjFC/UXdwkkxKU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Oa4uQPWJmTFq2ojCyQJEjopnK6B85t0jI6tVV4B5+vf4MoRPRPARPt0G5XMnDLr/u
         XNjjPQq3kdb0J5IBqRzxBNUP26Oapmg8nBt8YIOD6l5ePR+9jaMWPGSJaEQnl1MzHI
         lI2ia2i9Nz8vTPu3vhNPKW4dijXK86exuXdpIgu0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GBWHM9114223
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 06:32:17 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 06:32:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 06:32:10 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GBVkmG097485;
        Wed, 16 Oct 2019 06:32:14 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 12/13] dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
Date:   Wed, 16 Oct 2019 17:01:16 +0530
Message-ID: <20191016113117.12370-13-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016113117.12370-1-kishon@ti.com>
References: <20191016113117.12370-1-kishon@ti.com>
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

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
 SERDES]
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/phy/ti,phy-j721e-wiz.txt         | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
new file mode 100644
index 000000000000..19b4c3e855d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
@@ -0,0 +1,95 @@
+TI J721E WIZ (SERDES Wrapper)
+
+Required properties:
+ - compatible: Should be "ti,j721e-wiz-16g" for Sierra phy wrapper,
+	       or "ti,j721e-wiz-10g" for Torrent phy wrapper.
+ - #address-cells : should be 2 to indicate the child node should use 2 cell
+     for address
+ - #size-cells: should be 2 to indicate the child node should use 2 cell for
+     size
+ - power-domains: As documented by the generic PM domain bindings in
+     Documentation/devicetree/bindings/power/power_domain.txt.
+ - clocks: clock-specifier to represent input to the WIZ required for WIZ
+     module to be functional
+ - num-lanes: Represents thenumber of lanes enabled in the SoC
+     Should be '2' for Sierra wrapper in J721E
+     Should be '4' for Torrent wrapper in J721E
+ - #reset-cells: As documented by the generic reset bindings in
+     Documentation/devicetree/bindings/reset/reset.txt
+     Should be '1'
+ - ranges: Empty ranges property to describe 1:1 translation between parent
+     address space and child address space
+
+Optional properties:
+assigned-clocks and assigned-clock-parents: As documented in the generic
+clock bindings in Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required subnodes:
+ - Clock Subnode: WIZ node should have '3' subnodes for each of the clock
+     selects it supports. The clock subnodes should have the following names
+	1) pll0_refclk
+	2) pll1_refclk
+	3) refclk_dig
+     Each of these subnodes should clocks, clock-output-names, #clock-cells,
+     assigned-clocks and assigned-clock-parents. All these properties are
+     documented in the generic clock bindings in
+     Documentation/devicetree/bindings/clock/clock-bindings.txt
+ - SERDES Subnode: WIZ node should have '1' subnode for the SERDES
+     *) Sierra SERDES should follow the bindings specified in
+        Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
+     *) Torrent SERDES should follow the bindings specified in
+        Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
+
+Example: Example shows binding for SERDES_16G (Sierra SERDES with WIZ wrapper)
+serdes_wiz0: wiz@5000000 {
+	compatible = "ti,j721e-wiz-16g";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
+	clocks = <&k3_clks 292 5>;
+	num-lanes = <2>;
+	#reset-cells = <1>;
+	ranges;
+
+	pll0_refclk: pll0_refclk {
+		clocks = <&k3_clks 292 11>, <&cmn_refclk>;
+		clock-output-names = "pll0_refclk";
+		#clock-cells = <0>;
+		assigned-clocks = <&pll0_refclk>;
+		assigned-clock-parents = <&k3_clks 292 11>;
+	};
+
+	pll1_refclk: pll1_refclk {
+		clocks = <&k3_clks 292 0>, <&cmn_refclk1>;
+		clock-output-names = "pll1_refclk";
+		#clock-cells = <0>;
+		assigned-clocks = <&pll1_refclk>;
+		assigned-clock-parents = <&k3_clks 292 0>;
+	};
+
+	refclk_dig: refclk_dig {
+		clocks = <&k3_clks 292 11>, <&k3_clks 292 0>,
+			 <&cmn_refclk>, <&cmn_refclk1>;
+		clock-output-names = "refclk_dig";
+		#clock-cells = <0>;
+		assigned-clocks = <&refclk_dig>;
+		assigned-clock-parents = <&k3_clks 292 11>;
+	};
+
+	serdes0: serdes@5000000 {
+		compatible = "cdns,ti,sierra-phy-t0";
+		reg-names = "serdes";
+		reg = <0x00 0x5000000 0x00 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		resets = <&serdes_wiz0 0>;
+		reset-names = "sierra_reset";
+		pcie0_phy0: link@0 {
+			reg = <0>;
+			cdns,num-lanes = <2>;
+			#phy-cells = <0>;
+			cdns,phy-type = <PHY_TYPE_PCIE>;
+			resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
+		};
+	};
+};
-- 
2.17.1

