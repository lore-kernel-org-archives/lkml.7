Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6EEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8E82087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wmzI1eQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfCYIJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:09:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60496 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbfCYIJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:09:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P89JV9024648;
        Mon, 25 Mar 2019 03:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553501359;
        bh=8yZACXx3zQ5PlcI3+3uGL1g1pNCyWUs2yA7H0kvr23g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wmzI1eQbVimXM6wYVFODQwo1AdN84WmC4Nz5q+OnFwd46yoq1Ch9WPjBp6EInLnWD
         3E+oEl6B/cz8bRVyZ5TvbM5dZvYlQH+QJR+Qhziq5cn8c88IleIdyK+zynrvrHs8dn
         TaQYJwnU3uFZPQR44Agwu4nek7FDnRUBg+5258cQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P89JQs108773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:09:19 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:09:18 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:09:18 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P89AkZ019470;
        Mon, 25 Mar 2019 03:09:17 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 3/5] dt-bindings: phy: ti: Add dt binding documentation for SERDES in AM654x SoC
Date:   Mon, 25 Mar 2019 13:38:13 +0530
Message-ID: <20190325080815.6056-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325080815.6056-1-kishon@ti.com>
References: <20190325080815.6056-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654x has two SERDES instances. Each instance has three input clocks
(left input, externel reference clock and right input) and two output
clocks (left output and right output) in addition to a PLL mux clock
which the SERDES uses for Clock Multiplier Unit (CMU refclock).
The PLL mux clock can select from one of the three input clocks.
The right output can select between left input and external reference
clock while the left output can select between the right input and
external reference clock.

The left and right input reference clock of SERDES0 and SERDES1
respectively are connected to the SoC clock. In the case of two lane
SERDES personality card, the left input of SERDES1 is connected to
the right output of SERDES0 in a chained fashion.

See section "Reference Clock Distribution" of AM65x Sitara Processors
TRM (SPRUID7 – April 2018) for more details.

Add dt-binding documentation in order to represent all these different
configurations in device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/phy/ti,phy-am654-serdes.txt      | 81 +++++++++++++++++++
 include/dt-bindings/phy/phy-am654-serdes.h    | 13 +++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
 create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
new file mode 100644
index 000000000000..25a9206147ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
@@ -0,0 +1,81 @@
+TI AM654 SERDES
+
+Required properties:
+ - compatible: Should be "ti,phy-am654-serdes"
+ - reg : Address and length of the register set for the device.
+ - reg-names: Should be "serdes" which corresponds to the register space
+	populated in "reg".
+ - #phy-cells: determine the number of cells that should be given in the
+	phandle while referencing this phy. Should be "2". The 1st cell
+	corresponds to the phy type (should be one of the types specified in
+	include/dt-bindings/phy/phy.h) and the 2nd cell should be the serdes
+	lane function.
+	If SERDES0 is referenced 2nd cell should be:
+		0 - USB3
+		1 - PCIe0 Lane0
+		2 - ICSS2 SGMII Lane0
+	If SERDES1 is referenced 2nd cell should be:
+		0 - PCIe1 Lane0
+		1 - PCIe0 Lane1
+		2 - ICSS2 SGMII Lane1
+ - clocks: List of clock-specifiers representing the input to the SERDES.
+	Should have 3 items representing the left input clock, external
+	reference clock and right input clock in that order.
+ - clock-output-names: List of clock names for each of the clock outputs of
+	SERDES. Should have 3 items for CMU reference clock,
+	left output clock and right output clock in that order.
+ - assigned-clocks: As defined in
+	Documentation/devicetree/bindings/clock/clock-bindings.txt
+ - assigned-clock-parents: As defined in
+	Documentation/devicetree/bindings/clock/clock-bindings.txt
+ - #clock-cells: Should be <1> to choose between the 3 output clocks.
+	Defined in Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+   The following macros are defined in dt-bindings/phy/phy-am654-serdes.h
+   for selecting the correct reference clock. This can be used while
+   specifying the clocks created by SERDES.
+	=> AM654_SERDES_CMU_REFCLK
+	=> AM654_SERDES_LO_REFCLK
+	=> AM654_SERDES_RO_REFCLK
+
+ - mux-controls: phandle to the multiplexer
+
+Example:
+
+Example for SERDES0 is given below. It has 3 clock inputs;
+left input reference clock as indicated by <&k3_clks 153 4>, external
+reference clock as indicated by <&k3_clks 153 1> and right input
+reference clock as indicated by <&serdes1 AM654_SERDES_LO_REFCLK>. (The
+right input of SERDES0 is connected to the left output of SERDES1).
+
+SERDES0 registers 3 clock outputs as indicated in clock-output-names. The
+first refers to the CMU reference clock, second refers to the left output
+reference clock and the third refers to the right output reference clock.
+
+The assigned-clocks and assigned-clock-parents is used here to set the
+parent of left input reference clock to MAINHSDIV_CLKOUT4 and parent of
+CMU reference clock to left input reference clock.
+
+serdes0: serdes@900000 {
+	compatible = "ti,phy-am654-serdes";
+	reg = <0x0 0x900000 0x0 0x2000>;
+	reg-names = "serdes";
+	#phy-cells = <2>;
+	power-domains = <&k3_pds 153>;
+	clocks = <&k3_clks 153 4>, <&k3_clks 153 1>,
+			<&serdes1 AM654_SERDES_LO_REFCLK>;
+	clock-output-names = "serdes0_cmu_refclk", "serdes0_lo_refclk",
+				"serdes0_ro_refclk";
+	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
+	assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
+	ti,serdes-clk = <&serdes0_clk>;
+	mux-controls = <&serdes_mux 0>;
+	#clock-cells = <1>;
+};
+
+Example for PCIe consumer node using the SERDES PHY specifier is given below.
+&pcie0_rc {
+        num-lanes = <2>;
+        phys = <&serdes0 PHY_TYPE_PCIE 1>, <&serdes1 PHY_TYPE_PCIE 1>;
+        phy-names = "pcie-phy0", "pcie-phy1";
+};
diff --git a/include/dt-bindings/phy/phy-am654-serdes.h b/include/dt-bindings/phy/phy-am654-serdes.h
new file mode 100644
index 000000000000..e8d901729ed9
--- /dev/null
+++ b/include/dt-bindings/phy/phy-am654-serdes.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for AM654 SERDES.
+ */
+
+#ifndef _DT_BINDINGS_AM654_SERDES
+#define _DT_BINDINGS_AM654_SERDES
+
+#define AM654_SERDES_CMU_REFCLK	0
+#define AM654_SERDES_LO_REFCLK	1
+#define AM654_SERDES_RO_REFCLK	2
+
+#endif /* _DT_BINDINGS_AM654_SERDES */
-- 
2.17.1

