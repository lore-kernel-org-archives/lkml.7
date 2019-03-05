Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB16C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B953B20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qp+lRQQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfCEKTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:19:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54982 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbfCEKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:19:31 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190305101929euoutp0153091f84c42ab646d5805f439e7bb2be~JCMB3Z_yo0639006390euoutp01C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 10:19:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190305101929euoutp0153091f84c42ab646d5805f439e7bb2be~JCMB3Z_yo0639006390euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551781169;
        bh=U+XkYGzOzHO4FdBY95QReTEXxOpex9u5qj5CuGysNac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qp+lRQQGg/MoRWamkwxB5tsgDFu4eEUGFxp5N8q4GJajL++AUGapSlGmW00wpB1nv
         OqpITRQc/frdrm9T0dgMmOYTVcdqK8WLaH+KIectYVFqoxwiA1mK/6GTGB1hwKt9Vp
         NyyKJXtTltDNiGjt5gu+ayIiyz6Fq81oqqHSCfrA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190305101928eucas1p25af37a45aa90c69514914dc69ebd2024~JCMBVnmTK2248022480eucas1p2I;
        Tue,  5 Mar 2019 10:19:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AD.9E.04294.03D4E7C5; Tue,  5
        Mar 2019 10:19:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190305101927eucas1p250bbcbccb43590edd2b9ccf06cce2023~JCMAj0XNF2248522485eucas1p2C;
        Tue,  5 Mar 2019 10:19:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190305101927eusmtrp212a18a9cde2ce5ecf806d3e0eddc2ea7~JCMAeCubq2083020830eusmtrp2B;
        Tue,  5 Mar 2019 10:19:27 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-96-5c7e4d30857f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DB.1F.04128.F2D4E7C5; Tue,  5
        Mar 2019 10:19:27 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101927eusmtip1464d4d8888ae595c650c4b2734c131d4~JCL-33JBy2991729917eusmtip1K;
        Tue,  5 Mar 2019 10:19:27 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v5 6/8] DT: arm: exynos: add DMC device for exynos5422
Date:   Tue,  5 Mar 2019 11:19:09 +0100
Message-Id: <1551781151-5562-7-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7oGvnUxBuvfiFtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgieKySUnNySxLLdK3S+DK2PLmMlPBVt2KD2t3
        MTUw3lbqYuTkkBAwkZjx/DxLFyMXh5DACkaJvvPLmSCcL4wS16c/Z4ZwPjNKXOs7xQ7T0jZx
        LSNEYjmjxPr/0xFani/bAVTFwcEmoCexY1UhSIOIQLXEnev7wSYxC7xllJh58wsLSEJYwE1i
        0ZNeVpB6FgFViQ2rdEHCvAKeEqt2NUMtk5O4ea6TGcTmFPCS2L9wPTNEfDK7xNR7mRC2i0TX
        1vtQcWGJV8e3QPXKSPzfOZ8Jwi6WONuxig3CrpFoP7kDqsZa4vDxi2AnMAtoSqzfpQ8RdpT4
        17oR7BMJAT6JG28FQcLMQOakbdOZIcK8Eh1tQhDVGhJbei5ALRKTWL5mGtRwD4m9m1pYIYEz
        l1Hi/9J3rBMY5WchLFvAyLiKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMKGc/nf8yw7G
        XX+SDjEKcDAq8fBmmNXGCLEmlhVX5h5ilOBgVhLh/SNeFyPEm5JYWZValB9fVJqTWnyIUZqD
        RUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qB0eBYdUX525NHlhsras6zuKwbzPQxIfLceq8Y
        W1GgU19ee1512XpZYjVvacHbtGe2eqo3eRsEeWNZNSeXSliEnWivY1B984ythzehsHdZl0KT
        qqGDWIFfcfceLffyQ+oWV7snl3l1ZbaemeBc7sBg9iArQWFv4b6tJ4O2OvvPu8++W1PORYml
        OCPRUIu5qDgRANH4SdwkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xu7r6vnUxBsfW6llsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DL2PLmMlPBVt2KD2t3MTUw3lbqYuTkkBAwkWibuJax
        i5GLQ0hgKaPE7z9zmCESYhKT9m1nh7CFJf5c62KDKPrEKPF69XqWLkYODjYBPYkdqwpBakQE
        6iX631wCq2EW+M4ocejJBEaQhLCAm8SiJ72sIPUsAqoSG1bpgoR5BTwlVu1qhpovJ3HzXCfY
        Xk4BL4n9C9eD2UJANVO/LmSZwMi3gJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmCIbzv2
        c8sOxq53wYcYBTgYlXh4M8xqY4RYE8uKK3MPMUpwMCuJ8P4Rr4sR4k1JrKxKLcqPLyrNSS0+
        xGgKdNNEZinR5Hxg/OWVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCU
        amA0fRG39tNH7dP5dnwGXMcUH8yYumPViguPk87NON3+S+f4pg9ef25rn7qwc+aFjF/f0roa
        pU4ZPeGudfpddOus1Zkvn16feHA/86Gt8qfnR39VL3RrjdJqCeRrPDajQMeg8eT+VUF7SpPa
        5i702+rhNVHz4fOZIlOe9ygER35r/5Rz2mPmC8aF7UosxRmJhlrMRcWJADBvMh6HAgAA
X-CMS-MailID: 20190305101927eucas1p250bbcbccb43590edd2b9ccf06cce2023
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101927eucas1p250bbcbccb43590edd2b9ccf06cce2023
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101927eucas1p250bbcbccb43590edd2b9ccf06cce2023
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101927eucas1p250bbcbccb43590edd2b9ccf06cce2023@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of Dynamic Memory Controller and PPMU counters.
They are used by exynos5422-dmc driver.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi             | 83 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 87 +++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff158..fc00fda 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -235,6 +235,41 @@
 			status = "disabled";
 		};
 
+		dmc: memory-controller@10c20000 {
+			compatible = "samsung,exynos5422-dmc";
+			reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+				<0x10000000 0x1000>;
+			clocks = <&clock CLK_FOUT_SPLL>,
+				 <&clock CLK_MOUT_SCLK_SPLL>,
+				 <&clock CLK_FF_DOUT_SPLL2>,
+				 <&clock CLK_FOUT_BPLL>,
+				 <&clock CLK_MOUT_BPLL>,
+				 <&clock CLK_SCLK_BPLL>,
+				 <&clock CLK_MOUT_MX_MSPLL_CCORE>,
+				 <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+				 <&clock CLK_MOUT_MCLK_CDREX>,
+				 <&clock CLK_DOUT_CLK2X_PHY0>,
+				 <&clock CLK_CLKM_PHY0>,
+				 <&clock CLK_CLKM_PHY1>,
+				 <&clock CLK_CDREX_PAUSE>,
+				 <&clock CLK_CDREX_TIMING_SET>;
+			clock-names = "fout_spll",
+				      "mout_sclk_spll",
+				      "ff_dout_spll2",
+				      "fout_bpll",
+				      "mout_bpll",
+				      "sclk_bpll",
+				      "mout_mx_mspll_ccore",
+				      "mout_mx_mspll_ccore_phy",
+				      "mout_mclk_cdrex",
+				      "dout_clk2x_phy0",
+				      "clkm_phy0",
+				      "clkm_phy1",
+				      "clk_cdrex_pause",
+				      "clk_cdrex_timing_set";
+			status = "disabled";
+		};
+
 		nocp_mem0_0: nocp@10ca1000 {
 			compatible = "samsung,exynos5420-nocp";
 			reg = <0x10CA1000 0x200>;
@@ -271,6 +306,54 @@
 			status = "disabled";
 		};
 
+		ppmu_dmc0_0: ppmu@10d00000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d00000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
+					event-name = "ppmu-event3-dmc0_0";
+				};
+			};
+		};
+
+		ppmu_dmc0_1: ppmu@10d10000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d10000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
+					event-name = "ppmu-event3-dmc0_1";
+				};
+			};
+		};
+
+		ppmu_dmc1_0: ppmu@10d10000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d60000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
+					event-name = "ppmu-event3-dmc1_0";
+				};
+			};
+		};
+
+		ppmu_dmc1_1: ppmu@10d70000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d70000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
+					event-name = "ppmu-event3-dmc1_1";
+				};
+			};
+		};
+
 		gsc_pd: power-domain@10044000 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044000 0x20>;
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index bf09eab..6b28fb3 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -34,6 +34,69 @@
 			clock-frequency = <24000000>;
 		};
 	};
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
 };
 
 &bus_wcore {
@@ -127,6 +190,14 @@
 	cpu-supply = <&buck2_reg>;
 };
 
+&dmc {
+	devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
+			<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
+
+	operating-points-v2 = <&dmc_opp_table>;
+	status = "okay";
+};
+
 &hsi2c_4 {
 	status = "okay";
 
@@ -535,6 +606,22 @@
 	};
 };
 
+&ppmu_dmc0_0 {
+	status = "okay";
+};
+
+&ppmu_dmc0_1 {
+	status = "okay";
+};
+
+&ppmu_dmc1_0 {
+	status = "okay";
+};
+
+&ppmu_dmc1_1 {
+	status = "okay";
+};
+
 &tmu_cpu0 {
 	vtmu-supply = <&ldo7_reg>;
 };
-- 
2.7.4

