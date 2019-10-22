Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4294CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7989721783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfJVDyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 23:54:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49216 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730359AbfJVDyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 23:54:52 -0400
X-UUID: eaa763e80c2c4dc084d4e5010da78248-20191022
X-UUID: eaa763e80c2c4dc084d4e5010da78248-20191022
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <anthony.huang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2084867818; Tue, 22 Oct 2019 11:54:45 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Oct 2019 11:54:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Oct 2019 11:54:43 +0800
From:   Anthony Huang <anthony.huang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Anthony Huang <anthony.huang@mediatek.com>
Subject: [RFC PATCH 1/2] dt-bindings: soc: mediatek: Add document for mmdvfs driver
Date:   Tue, 22 Oct 2019 11:51:52 +0800
Message-ID: <1571716313-10215-2-git-send-email-anthony.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1571716313-10215-1-git-send-email-anthony.huang@mediatek.com>
References: <1571716313-10215-1-git-send-email-anthony.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document describes the properties what mtk mmdvfs
device node support.

Signed-off-by: Anthony Huang <anthony.huang@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/mmdvfs.txt    |  149 ++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mmdvfs.txt

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mmdvfs.txt b/Documentation/devicetree/bindings/soc/mediatek/mmdvfs.txt
new file mode 100644
index 0000000..bf33d79
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mmdvfs.txt
@@ -0,0 +1,149 @@
+Mediatek MMDVFS driver binding
+=========================================
+
+The Mediatek MMDVFS(Multimedia Dynamic Voltage and Frequency Scaling) driver
+is used to set clk for Mediatek multimedia hardwares, such as display, camera,
+mdp and video codec. MMDVFS driver reads which clock muxes and clock sources
+are used on this platform from DTS, and sets current clock according to current
+voltage informed by regulator callback.
+
+
+Required properties:
+- compatible : shall contain "mediatek,mmdvfs".
+- operating-points-v2: contains any one of opp tables for multimedia modules.
+                       MMDVFS uses it to get voltage setting on this platform.
+- mediatek,support_mux: contains a list of clock mux names defined
+                        in clock-names.
+- mediatek,mux_*: a series of properties with "mediatek,mux_" prefix.
+		  Each property represents one clock mux, and its value is a
+		  list of all the clock sources for it. The postfix * and every
+		  item in the property must be from the clock-names.
+- clock, clock-names: lists all clock muxes and clock sources for multimedia
+		      hardwares.
+
+Optional properties:
+If the platform needs frequency hopping for some clock sources, these following
+properties should be set.
+
+- mediatek,support_hopping: a list of clock names supporting frequency hopping.
+- mediatek,hopping_*: a cell with the same size as opp numbers of an opp table
+		      for any MM module and each entry represents the clock
+		      rate for each opp. For example, the first entry is the
+		      clock rate set in opp-0, and the second entry is the
+		      clock rate set in opp-1.
+- mediatek,action: a cell with one entry.
+		   It represents the action taken when setting clocks.
+		   0 or this property is not set:
+		   	Do not set frequency hopping and just set clock mux.
+		   1:
+		   	If the voltage is increasing, set frequency hopping
+		   	first. If the voltage is decreasing, set clock mux
+		   	first.
+
+Example:
+	opp_table_mm: opp-table-mm {
+		compatible = "operating-points-v2";
+
+		opp-0 {
+			opp-hz = /bits/ 64 <315000000>;
+			opp-microvolt = <650000>;
+		};
+		opp-1 {
+			opp-hz = /bits/ 64 <450000000>;
+			opp-microvolt = <725000>;
+		};
+		opp-2 {
+			opp-hz = /bits/ 64 <606000000>;
+			opp-microvolt = <825000>;
+		};
+	};
+
+	opp_table_cam: opp-table-cam {
+		compatible = "operating-points-v2";
+
+		opp-0 {
+			opp-hz = /bits/ 64 <315000000>;
+			opp-microvolt = <650000>;
+		};
+		opp-1 {
+			opp-hz = /bits/ 64 <416000000>;
+			opp-microvolt = <725000>;
+		};
+		opp-2 {
+			opp-hz = /bits/ 64 <560000000>;
+			opp-microvolt = <825000>;
+		};
+	};
+	.... /* Other opp tables for multimedia modules */
+
+	mmdvfs {
+		compatible = "mediatek,mmdvfs";
+
+		operating-points-v2 = <&opp_table_mm>;
+
+		mediatek,support_mux = "mm", "cam", "img", "ipe",
+			"venc", "vdec", "dpe", "ccu";
+
+		mediatek,mux_mm = "clk_mmpll_d5_d2",
+			"clk_mmpll_d7", "clk_tvdpll_mainpll_d2_ck";
+		mediatek,mux_cam = "clk_mmpll_d5_d2",
+			"clk_univpll_d3", "clk_adsppll_d5";
+		mediatek,mux_img = "clk_mmpll_d5_d2",
+			"clk_univpll_d3", "clk_tvdpll_mainpll_d2_ck";
+		mediatek,mux_ipe = "clk_mmpll_d5_d2",
+			"clk_univpll_d3", "clk_mainpll_d2";
+		mediatek,mux_venc = "clk_mainpll_d3",
+			"clk_mmpll_d7", "clk_mmpll_d5";
+		mediatek,mux_vdec = "clk_univpll_d2_d2",
+			"clk_univpll_d3", "clk_univpll_d2";
+		mediatek,mux_dpe = "clk_mainpll_d3",
+			"clk_mmpll_d7", "clk_mainpll_d2";
+		mediatek,mux_ccu = "clk_mmpll_d5_d2",
+			"clk_univpll_d3", "clk_adsppll_d5";
+
+		mediatek,support_hopping = "clk_mmpll_ck";
+		mediatek,hopping_clk_mmpll_ck = <630000000 630000000 650000000>;
+		mediatek,action = <1>;
+
+
+		clocks = <&topckgen CLK_TOP_MM>,
+			<&topckgen CLK_TOP_CAM>,
+			<&topckgen CLK_TOP_IMG>,
+			<&topckgen CLK_TOP_IPE>,
+			<&topckgen CLK_TOP_VENC>,
+			<&topckgen CLK_TOP_VDEC>,
+			<&topckgen CLK_TOP_DPE>,
+			<&topckgen CLK_TOP_CCU>,
+			<&topckgen CLK_TOP_MMPLL_D5>,
+			<&topckgen CLK_TOP_UNIVPLL_D2>,
+			<&topckgen CLK_TOP_TVDPLL_MAINPLL_D2_CK>,
+			<&topckgen CLK_TOP_ADSPPLL_D5>,
+			<&topckgen CLK_TOP_MAINPLL_D2>,
+			<&topckgen CLK_TOP_MMPLL_D6>,
+			<&topckgen CLK_TOP_MMPLL_D7>,
+			<&topckgen CLK_TOP_UNIVPLL_D3>,
+			<&topckgen CLK_TOP_MAINPLL_D3>,
+			<&topckgen CLK_TOP_MMPLL_D5_D2>,
+			<&topckgen CLK_TOP_UNIVPLL_D2_D2>,
+			<&topckgen CLK_TOP_MMPLL_CK>;
+		clock-names = "mm",
+			"cam",
+			"img",
+			"ipe",
+			"venc",
+			"vdec",
+			"dpe",
+			"ccu",
+			"clk_mmpll_d5",
+			"clk_univpll_d2",
+			"clk_tvdpll_mainpll_d2_ck",
+			"clk_adsppll_d5",
+			"clk_mainpll_d2",
+			"clk_mmpll_d6",
+			"clk_mmpll_d7",
+			"clk_univpll_d3",
+			"clk_mainpll_d3",
+			"clk_mmpll_d5_d2",
+			"clk_univpll_d2_d2",
+			"clk_mmpll_ck";
+	};
-- 
1.7.9.5

