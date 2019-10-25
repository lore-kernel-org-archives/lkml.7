Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD520CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5E021D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439888AbfJYLOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:14:41 -0400
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:46521 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503751AbfJYLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:14:40 -0400
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x9PBEGiE067272
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 25 Oct 2019 19:14:16 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.79) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 25 Oct 2019 19:14:17
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 3/5] dt-bindings: clk: sprd: add bindings for sc9863a clock controller
Date:   Fri, 25 Oct 2019 19:13:36 +0800
Message-ID: <20191025111338.27324-4-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025111338.27324-1-chunyan.zhang@unisoc.com>
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.79]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x9PBEGiE067272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


add a new bindings to describe sc9863a clock compatible string.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/clock/sprd,sc9863a-clk.txt       | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.txt

diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.txt b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.txt
new file mode 100644
index 000000000000..a73ae5574c82
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.txt
@@ -0,0 +1,59 @@
+Unisoc SC9863A Clock Binding
+------------------------
+
+Required properties:
+- compatible: should contain the following compatible strings:
+	- "sprd,sc9863a-ap-clk"
+	- "sprd,sc9863a-pmu-gate"
+	- "sprd,sc9863a-pll"
+	- "sprd,sc9863a-mpll"
+	- "sprd,sc9863a-rpll"
+	- "sprd,sc9863a-dpll"
+	- "sprd,sc9863a-aon-clk"
+	- "sprd,sc9863a-apahb-gate"
+	- "sprd,sc9863a-aonapb-gate"
+	- "sprd,sc9863a-mm-gate"
+	- "sprd,sc9863a-mm-clk"
+	- "sprd,sc9863a-vspahb-gate"
+	- "sprd,sc9863a-apapb-gate"
+
+- #clock-cells: must be 1
+
+- clocks : Should be the input parent clock(s) phandle for the clock, this
+	   property here just simply shows which clock group the clocks'
+	   parents are in, since each clk node would represent many clocks
+	   which are defined in the driver.  The detailed dependency
+	   relationship (i.e. how many parents and which are the parents)
+	   are implemented in driver code.
+
+Optional properties:
+
+- reg:	Contain the registers base address and length. It must be configured
+	only if no 'sprd,syscon' under the node.
+
+- sprd,syscon: phandle to the syscon which is in the same address area with
+	       the clock, and so we can get regmap for the clocks from the
+	       syscon device.
+
+Example:
+	ap_clk: clock-controller@21500000 {
+		compatible = "sprd,sc9863a-ap-clk";
+		reg = <0 0x21500000 0 0x1000>;
+		clocks = <&ext_32k>, <&ext_26m>,
+			 <&pll 0>, <&rpll 0>;
+		#clock-cells = <1>;
+	};
+
+	pmu_gate: pmu-gate {
+		compatible = "sprd,sc9863a-pmu-gate";
+		sprd,syscon = <&pmu_regs>; /* 0x402b0000 */
+		clocks = <&ext_26m>;
+		#clock-cells = <1>;
+	};
+
+	pll: pll {
+		compatible = "sprd,sc9863a-pll";
+		sprd,syscon = <&anlg_phy_g2_regs>; /* 0x40353000 */
+		clocks = <&pmu_gate 0>;
+		#clock-cells = <1>;
+	};
-- 
2.20.1


