Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A76C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D5920842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Wae1Jtit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfCEKTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:19:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54973 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfCEKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:19:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190305101928euoutp0189d4cbbf729244c41e088a3db0c73df9~JCMBVAilp0539305393euoutp01J
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 10:19:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190305101928euoutp0189d4cbbf729244c41e088a3db0c73df9~JCMBVAilp0539305393euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551781168;
        bh=9yr4qRVQkXZOec8agyeSNlIohIYaDFOzDtfGULMZs7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wae1JtitxDVXZHOr1rA0BEh+dvNtrxlPUchD/MT3d4h7IfTnFV74bV2HViQFjVmoz
         35ikMiqtddw70o/zwyErknYoRzOegBGIlTsRvh6wyYzekMPP5M2O+/qHn0MMgxTJTC
         FicEfDLpEAlp90B2DPbockCmzpD4ETDI9Dk2Hd5g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190305101927eucas1p26b76197492fade845e770a84f258ddd7~JCMAIxnxF2250822508eucas1p2y;
        Tue,  5 Mar 2019 10:19:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id ED.CB.04806.F2D4E7C5; Tue,  5
        Mar 2019 10:19:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb~JCL-fTo4x2211722117eucas1p2v;
        Tue,  5 Mar 2019 10:19:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190305101926eusmtrp21a3115d13b2f7e4fa5fc21940a153a12~JCL-QiSNu2083020830eusmtrp25;
        Tue,  5 Mar 2019 10:19:26 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-85-5c7e4d2f24f2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.1F.04128.E2D4E7C5; Tue,  5
        Mar 2019 10:19:26 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101925eusmtip1a72151e354e308855fbfb7b1b10f3e74~JCL_saCs73045730457eusmtip1s;
        Tue,  5 Mar 2019 10:19:25 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v5 4/8] dt-bindings: devfreq: add Exynos5422 DMC device
 description
Date:   Tue,  5 Mar 2019 11:19:07 +0100
Message-Id: <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87r6vnUxBkf38lpsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgieKySUnNySxLLdK3S+DKeLx5FlPBMb2K623C
        DYw/VboYOTkkBEwkVj+ZztLFyMUhJLCCUWLBwWlsEM4XRomTs7dBOZ8ZJTrvTWeGaXn0aR87
        iC0ksJxRYtY2D7iO14teA83i4GAT0JPYsaoQpEZEoFrizvX9zCA1zAJvGSVm3vzCApIQFgiV
        uHL4ChOIzSKgKrHpRQdYnFfAU2Lu7CssEMvkJG6e6wRbzCngJbF/4XqwQRICk9kldre2MEIU
        uUhcfdnFCmELS7w6voUdwpaR+L9zPhOEXSxxtmMVG4RdI9F+cgdUjbXE4eMXWUGOZhbQlFi/
        Sx8i7Cjx9cUhsLCEAJ/EjbeCIGFmIHPSNlA4gIR5JTrahCCqNSS29FyAWiQmsXzNNKjhHhJz
        JrRDQ3cuo0THjatMExjlZyEsW8DIuIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwoZz+
        d/zrDsZ9f5IOMQpwMCrx8GaY1cYIsSaWFVfmHmKU4GBWEuH9I14XI8SbklhZlVqUH19UmpNa
        fIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoHRc9Ma5nmih7hkdyWwTWN4smvN/EPz
        1T1v+G6Nknt6+09ryGwnFd2EiXtnxjxStlx8dL54xt9eUU/um2X1xtvMrtiaFebtF5v0Xbt7
        7WJf34Ur2t2kpgifVrt8PfigxNoo5h0T74n973VZ9nO2468FHb473IqSijYc+Ddp3tsNAkvK
        a5QbT+qkK7EUZyQaajEXFScCAIHMwrEkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xu7p6vnUxBiv+y1psnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeLx5FlPBMb2K623CDYw/VboYOTkkBEwkHn3ax97F
        yMUhJLCUUWLfj79sEAkxiUn7trND2MISf651gcWFBD4xSuzfW93FyMHBJqAnsWNVIUhYRKBe
        ov/NJTaQOcwC3xklDj2ZwAiSEBYIlpjRfpcZxGYRUJXY9KKDBcTmFfCUmDv7CgvEfDmJm+c6
        wWo4Bbwk9i9czwyxy1Ni6teFLBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIDPBt
        x35u2cHY9S74EKMAB6MSD2+GWW2MEGtiWXFl7iFGCQ5mJRHeP+J1MUK8KYmVValF+fFFpTmp
        xYcYTYGOmsgsJZqcD4y+vJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwc
        nFINjOUy673koz86TtxqOZ+B5Wd97u932kseGF7bmMfNLrlAYULz3rhPnbwSIf7vvu+o8vFX
        W89jcKr+qPGyYNYLjDoH2n6sCpsaeK9lZXwqx462LvewF6bHdQK2dApf52bTfPlvdxfH3e7L
        0R+ztStEFwSflDSWqMtft4ONd6b6lrsbV8du8BU/rsRSnJFoqMVcVJwIADkDpHiGAgAA
X-CMS-MailID: 20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds description for DT binding for a new Exynos5422 Dynamic
Memory Controller device.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/devfreq/exynos5422-dmc.txt | 177 +++++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt

diff --git a/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
new file mode 100644
index 0000000..0e73e98
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
@@ -0,0 +1,177 @@
+* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
+
+The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
+memory chips are connected. The driver is to monitor the controller in runtime
+and switch frequency and voltage. To monitor the usage of the controller in
+runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
+is able to measure the current load of the memory.
+When 'userspace' governor is used for the driver, an application is able to
+switch the DMC frequency.
+
+Required properties for DMC device for Exynos5422:
+- compatible: Should be "samsung,exynos5422-bus".
+- clock-names : the name of clock used by the bus, "bus".
+- clocks : phandles for clock specified in "clock-names" property.
+- devfreq-events : phandles for PPMU devices connected to this DMC.
+
+The example definition of a DMC and PPMU devices declared in DT is shown below:
+
+	ppmu_dmc0_0: ppmu@10d00000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d00000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
+				event-name = "ppmu-event3-dmc0_0";
+			};
+		};
+	};
+
+
+	ppmu_dmc0_1: ppmu@10d10000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d10000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
+				event-name = "ppmu-event3-dmc0_1";
+			};
+		};
+	};
+
+	ppmu_dmc1_0: ppmu@10d10000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d60000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
+				event-name = "ppmu-event3-dmc1_0";
+			};
+		};
+	};
+
+	ppmu_dmc1_1: ppmu@10d70000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d70000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
+				event-name = "ppmu-event3-dmc1_1";
+			};
+		};
+	};
+
+	dmc: memory-controller@10c20000 {
+		compatible = "samsung,exynos5422-dmc";
+		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+			<0x10000000 0x1000>;
+		clocks = 	<&clock CLK_FOUT_SPLL>,
+				<&clock CLK_MOUT_SCLK_SPLL>,
+				<&clock CLK_FF_DOUT_SPLL2>,
+				<&clock CLK_FOUT_BPLL>,
+				<&clock CLK_MOUT_BPLL>,
+				<&clock CLK_SCLK_BPLL>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+				<&clock CLK_MOUT_MCLK_CDREX>,
+				<&clock CLK_DOUT_CLK2X_PHY0>,
+				<&clock CLK_CLKM_PHY0>,
+				<&clock CLK_CLKM_PHY1>,
+				<&clock CLK_CDREX_PAUSE>,
+				<&clock CLK_CDREX_TIMING_SET>;
+		clock-names =	"fout_spll",
+				"mout_sclk_spll",
+				"ff_dout_spll2",
+				"fout_bpll",
+				"mout_bpll",
+				"sclk_bpll",
+				"mout_mx_mspll_ccore",
+				"mout_mx_mspll_ccore_phy",
+				"mout_mclk_cdrex",
+				"dout_clk2x_phy0",
+				"clkm_phy0",
+			        "clkm_phy1",
+			        "clk_cdrex_pause",
+			        "clk_cdrex_timing_set";
+		status = "okay";
+		operating-points-v2 = <&dmc_opp_table>;
+		devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
+				<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
+	};
+
+The needed timings of DRAM memory are stored in dedicated nodes.
+There are two nodes with regular timings and for bypass mode.
+
+	dmc_bypass_mode: bypass_mode {
+		compatible = "samsung,dmc-bypass-mode";
+
+		freq-hz = <400000000>;
+		volt-uv = <887500>;
+		dram-timing-row = <0x365a9713>;
+		dram-timing-data = <0x4740085e>;
+		dram-timing-power = <0x543a0446>;
+	};
+
+	dram_timing: timing {
+		compatible = "samsung,dram-timing";
+
+		dram-timing-names = "165MHz", "206MHz", "275MHz", "413MHz",
+				    "543MHz", "633MHz", "728MHz", "825MHz";
+		dram-timing-row = <0x11223185>, <0x112331C6>, <0x12244287>,
+				  <0x1B35538A>, <0x244764CD>, <0x2A48758F>,
+				  <0x30598651>, <0x365A9713>;
+		dram-timing-data = <0x2720085E>, <0x2720085E>, <0x2720085E>,
+				   <0x2720085E>, <0x3730085E>, <0x3730085E>,
+				   <0x3730085E>, <0x4740085E>;
+		dram-timing-power = <0x140C0225>, <0x180F0225>, <0x1C140225>,
+				    <0x2C1D0225>, <0x38270335>, <0x402D0335>,
+				    <0x4C330336>, <0x543A0446>;
+	};
+
+The frequencies supported by the DMC are stored in OPP table v2.
+
+	dmc_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <165000000>;
+			opp-microvolt = <875000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <206000000>;
+			opp-microvolt = <875000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <275000000>;
+			opp-microvolt = <875000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <413000000>;
+			opp-microvolt = <887500>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <543000000>;
+			opp-microvolt = <937500>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <633000000>;
+			opp-microvolt = <1012500>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <728000000>;
+			opp-microvolt = <1037500>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <825000000>;
+			opp-microvolt = <1050000>;
+		};
+	};
+
-- 
2.7.4

