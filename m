Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC06C282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCF52064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V4b5ZvRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfDSTID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:08:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54687 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfDSTH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190419141954euoutp025019ad8ea9fb9959c2e62c4df734aa7d~W5fyMnj6t2305123051euoutp02S
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:19:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190419141954euoutp025019ad8ea9fb9959c2e62c4df734aa7d~W5fyMnj6t2305123051euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555683594;
        bh=e1otwkQK+fB5VuiaZ9MgX/wxgSli2eIV2J0L45UYMdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4b5ZvRFSfZkzzUlXRe8Xts8zNeW5+TcFFmItbIn8NeuFoG9v5tlLu7TWMWbgA/Ql
         1bNHMGoBWJu2VUfcWWkAea52YwzxyTffIrFB0m/QiggO2MqgcrvMcy54sIfNrLQg9g
         rdm15dV2mPXDaz4y4AmZiZ/AOdca+oItlz0C0EGI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190419141952eucas1p1ad4237b85af492bf192c8cf0831c9d76~W5fxHWWxl0188401884eucas1p1P;
        Fri, 19 Apr 2019 14:19:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FD.4B.04377.809D9BC5; Fri, 19
        Apr 2019 15:19:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190419141952eucas1p11dc36f30c873a947122e0f7e8d55a3bb~W5fwVYOjV2568825688eucas1p10;
        Fri, 19 Apr 2019 14:19:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419141951eusmtrp182221d5655f3c759af35b5b986a98c4f~W5fwHU8zB1902919029eusmtrp1B;
        Fri, 19 Apr 2019 14:19:51 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-30-5cb9d908fb65
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 31.12.04146.709D9BC5; Fri, 19
        Apr 2019 15:19:51 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141951eusmtip205da8a4bb5849df5fae85fc6dddd8ccb~W5fvVd0qR3043530435eusmtip2A;
        Fri, 19 Apr 2019 14:19:51 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v6 09/10] ARM: dts: exynos: add DMC device for exynos5422
Date:   Fri, 19 Apr 2019 16:19:27 +0200
Message-Id: <1555683568-20882-10-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHe89tZ6PJaYa+pBgNorLysvrwQhJKRSeDrA/1QYWaepjVtmrH
        S2bE8ta0bKFd1DIdJNpSKlsy12W1Ta10WmTMTLtJCjWDcHbRtJxH8dvvufyf//O8vDQuc5HL
        6IPaDE6nVarllIRoaf/Ts55+25oc1Ve9Dt2tuE0ij2+ERDWubhLd+jEEUPmLagx1ndUg49A3
        HPX03BEhd55XhPr1oei17RqFxkpdAFX0PMZQk2tQhN6dbqCQ03uGRPbeePRuMgD9fPYZxAay
        P8fLCPaq/hXBtlYNithmczHFluZ/p9in3x9i7HmLGbD3OnPZseaw3eJESUwapz6YxekiNx+Q
        pJumKoijt2KPT7VOk3pwMboEiGnIbIT9tWNUCZDQMqYBQGv+c0wIfABOmKpJIRgD8EGeG8xL
        Gnt7caFQD6C30r0gsRY9mpHQNMVEQKv5mF+wlMmFAx77rABnvBh0T/wm/IVAZgd0ON6QfiaY
        lbDI6xH5WcrshMZOEyW4hcG33cW4n8UzedtNy+yykHkvgp+6RzG/GWS2wr7yVKE/EH7tsIgE
        DoWd5ecIgXmoLzXNXXASDhmr53o2QWfHq9mdcWYNvG2LFCbGwa6CEAEDYN/oEn8zPoNlLVdw
        IS2FhiKZMGM1tJx7iQkcBOsbL8/NZmGb5xIQHuc6gI6+YeoCWF614FULgBkEc5m8RsXxCi2X
        HcErNXymVhWRekTTDGb+Vud0h88KbH9THIChgXyx9ElZa7KMVGbxORoHgDQuXyqNS7Mky6Rp
        ypwTnO7Ifl2mmuMdIIQm5MHS3EUfk2SMSpnBHea4o5xuvorR4mV6ULDd2dRoTMg+1OBM6jJ8
        MRjFzrrCJXVRx9V7U/s3kHn3V61IdtZ8+Frp9hkwGG5f+yCephT/Vp1qqPuIi9OzCkxBwJkS
        XKzY2N4mGrbfVWgLvZuObdl2kf10I3Ggfdf1eHEMp+InK/eNTyWUvnx0ITrmqnpPjjKgYsTX
        kvrrkpzg05XR4biOV/4HihENI1cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7rsN3fGGBy5YmyxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsK/M1gKVjtU/N35j7WBcYphFyMnh4SAicSaK1eY
        uxi5OIQEljJK9M59wwiREJOYtG87O4QtLPHnWhcbRNEnRonHzfNYuxg5ONgE9CR2rCoEqRER
        qJfof3MJrIZZoIFZYs32q6wgCWEBT4lDhyBsFgFVibY318GG8gp4S/SfXsgGsUBO4ua5TmYQ
        mxMovmvlFrC4kICXxIZre5kmMPItYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERhL2479
        3LyD8dLG4EOMAhyMSjy8BybtjBFiTSwrrsw9xCjBwawkwuuYsiVGiDclsbIqtSg/vqg0J7X4
        EKMp0FETmaVEk/OBcZ5XEm9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNT
        qoGxq2rPxq9HzeZNVOeYdfJv7KuPjenbvMqE5v92EuKrLeI5dUl1lddi5xPRu+zKejZoX5n4
        9uPr75p/wg5MEX2a9L/uh9vCRW9ZGOTWfP4WcV6fo+vkK8W+xxWsV7Uvi11OUwutv56V6dJ8
        4TbrGe9Tty3K7f2O776hv0hJsuY5h/+UVPVNNa7flViKMxINtZiLihMBnm0LF7sCAAA=
X-CMS-MailID: 20190419141952eucas1p11dc36f30c873a947122e0f7e8d55a3bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141952eucas1p11dc36f30c873a947122e0f7e8d55a3bb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141952eucas1p11dc36f30c873a947122e0f7e8d55a3bb
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141952eucas1p11dc36f30c873a947122e0f7e8d55a3bb@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of Dynamic Memory Controller and PPMU counters.
They are used by exynos5422-dmc driver.
There is a definition of the memory chip, hwich is then used during
calculation of timings for each OPP.
The algorithm in the driver needs these two sets to bound the timings.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi             | 120 ++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 120 ++++++++++++++++++++++++++
 2 files changed, 240 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff158..b687cd7 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/exynos5420.h>
 #include <dt-bindings/clock/exynos-audss-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pmu/exynos_ppmu.h>
 
 / {
 	compatible = "samsung,exynos5420", "samsung,exynos5";
@@ -235,6 +236,37 @@
 			status = "disabled";
 		};
 
+		dmc: memory-controller@10c20000 {
+			compatible = "samsung,exynos5422-dmc";
+			reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+				<0x10000000 0x1000>, <0x10030000 0x1000>;
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
+				 <&clock CLK_CLKM_PHY1>;
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
+				      "clkm_phy1";
+			status = "disabled";
+		};
+
 		nocp_mem0_0: nocp@10ca1000 {
 			compatible = "samsung,exynos5420-nocp";
 			reg = <0x10CA1000 0x200>;
@@ -271,6 +303,94 @@
 			status = "disabled";
 		};
 
+		ppmu_dmc0_0: ppmu@10d00000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d00000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event0_dmc0_0: ppmu-event0-dmc0_0 {
+					event-name = "ppmu-event0-dmc0_0";
+					event-data-type = <PPMU_RO_DATA_CNT>;
+				};
+				ppmu_event1_dmc0_0: ppmu-event1-dmc0_0 {
+					event-name = "ppmu-event1-dmc0_0";
+					event-data-type = <PPMU_WO_DATA_CNT>;
+				};
+				ppmu_event3_dmc0_0: ppmu-event3-dmc0_0 {
+					event-name = "ppmu-event3-dmc0_0";
+					event-data-type = <(PPMU_RO_DATA_CNT |
+						PPMU_WO_DATA_CNT)>;
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
+				ppmu_event0_dmc0_1: ppmu-event0-dmc0_1 {
+					event-name = "ppmu-event0-dmc0_1";
+					event-data-type = <PPMU_RO_DATA_CNT>;
+				};
+				ppmu_event1_dmc0_1: ppmu-event1-dmc0_1 {
+					event-name = "ppmu-event1-dmc0_1";
+					event-data-type = <PPMU_WO_DATA_CNT>;
+				};
+				ppmu_event3_dmc0_1: ppmu-event3-dmc0_1 {
+					event-name = "ppmu-event3-dmc0_1";
+					event-data-type = <(PPMU_RO_DATA_CNT |
+						PPMU_WO_DATA_CNT)>;
+				};
+			};
+		};
+
+		ppmu_dmc1_0: ppmu@10d60000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d60000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event0_dmc1_0: ppmu-event0-dmc1_0 {
+					event-name = "ppmu-event0-dmc1_0";
+					event-data-type = <PPMU_RO_DATA_CNT>;
+				};
+				ppmu_event1_dmc1_0: ppmu-event1-dmc1_0 {
+					event-name = "ppmu-event1-dmc1_0";
+					event-data-type = <PPMU_WO_DATA_CNT>;
+				};
+				ppmu_event3_dmc1_0: ppmu-event3-dmc1_0 {
+					event-name = "ppmu-event3-dmc1_0";
+					event-data-type = <(PPMU_RO_DATA_CNT |
+						PPMU_WO_DATA_CNT)>;
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
+				ppmu_event0_dmc1_1: ppmu-event0-dmc1_1 {
+					event-name = "ppmu-event0-dmc1_1";
+					event-data-type = <PPMU_RO_DATA_CNT>;
+				};
+				ppmu_event1_dmc1_1: ppmu-event1-dmc1_1 {
+					event-name = "ppmu-event1-dmc1_1";
+					event-data-type = <PPMU_WO_DATA_CNT>;
+				};
+				ppmu_event3_dmc1_1: ppmu-event3-dmc1_1 {
+					event-name = "ppmu-event3-dmc1_1";
+					event-data-type = <(PPMU_RO_DATA_CNT |
+						PPMU_WO_DATA_CNT)>;
+				};
+			};
+		};
+
 		gsc_pd: power-domain@10044000 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044000 0x20>;
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 25d95de1..76bf0dbf 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -34,6 +34,95 @@
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
+	samsung_K3QF2F20DB: lpddr3 {
+		compatible	= "Samsung,K3QF2F20DB","jedec,lpddr3";
+		density		= <16384>;
+		io-width	= <32>;
+
+		tRFC-min-tck		= <17>;
+		tRRD-min-tck		= <2>;
+		tRPab-min-tck		= <2>;
+		tRPpb-min-tck		= <2>;
+		tRCD-min-tck		= <3>;
+		tRC-min-tck		= <6>;
+		tRAS-min-tck		= <5>;
+		tWTR-min-tck		= <2>;
+		tWR-min-tck		= <7>;
+		tRTP-min-tck		= <2>;
+		tW2W-C2C-min-tck	= <0>;
+		tR2R-C2C-min-tck	= <0>;
+		tWL-min-tck		= <8>;
+		tDQSCK-min-tck		= <5>;
+		tRL-min-tck		= <14>;
+		tFAW-min-tck		= <5>;
+		tXSR-min-tck		= <12>;
+		tXP-min-tck		= <2>;
+		tCKE-min-tck		= <2>;
+		tCKESR-min-tck		= <2>;
+		tMRD-min-tck		= <5>;
+
+		timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
+			compatible	= "jedec,lpddr3-timings";
+			min-freq	= <100000000>;
+			max-freq	= <800000000>;
+			tRFC		= <65000>;
+			tRRD		= <6000>;
+			tRPab		= <12000>;
+			tRPpb		= <12000>;
+			tRCD		= <10000>;
+			tRC		= <33750>;
+			tRAS		= <23000>;
+			tWTR		= <3750>;
+			tWR		= <7500>;
+			tRTP		= <3750>;
+			tW2W-C2C	= <0>;
+			tR2R-C2C	= <0>;
+			tFAW		= <25000>;
+			tXSR		= <70000>;
+			tXP		= <3750>;
+			tCKE		= <3750>;
+			tCKESR		= <3750>;
+			tMRD		= <7000>;
+		};
+	};
 };
 
 &adc {
@@ -132,6 +221,21 @@
 	cpu-supply = <&buck2_reg>;
 };
 
+&dmc {
+	devfreq-events = <&ppmu_event0_dmc0_0>, <&ppmu_event1_dmc0_0>,
+			<&ppmu_event3_dmc0_0>,
+			<&ppmu_event0_dmc0_1>,<&ppmu_event1_dmc0_1>,
+			<&ppmu_event3_dmc0_1>,
+			<&ppmu_event0_dmc1_0>, <&ppmu_event1_dmc1_0>,
+			<&ppmu_event3_dmc1_0>,
+			<&ppmu_event0_dmc1_1>,<&ppmu_event1_dmc1_1>,
+			<&ppmu_event3_dmc1_1>;
+	device-handle = <&samsung_K3QF2F20DB>;
+	operating-points-v2 = <&dmc_opp_table>;
+	vdd-supply = <&buck1_reg>;
+	status = "okay";
+};
+
 &hsi2c_4 {
 	status = "okay";
 
@@ -540,6 +644,22 @@
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

