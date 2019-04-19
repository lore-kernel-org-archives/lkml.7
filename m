Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A6AC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519312087F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aynAhBHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfDSTKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:10:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38838 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbfDSTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190419141949euoutp01440fe4123b5893e38e4b7e1b9ebedcc8~W5fuB-QJ82266922669euoutp01Y
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:19:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190419141949euoutp01440fe4123b5893e38e4b7e1b9ebedcc8~W5fuB-QJ82266922669euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555683589;
        bh=doi//6RRBueW9vrnOeLTSb6V8P5KiE7ED3Zkzd572qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aynAhBHLBVi4W90zAiN51Lqlk/aZjuFrMT3AGS+zACl/P0bC9FX+E1zhNMIq46hLK
         9e1ZHsCd1PfeHOUSvItZn7VlMqROC3PryC5tIpzPDLxSwaXXqAaj1tl0taxNg8y4+J
         Wz3sWOyU6e4Sao9IszGniVqQ3Xug6B3rj2beuF44=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190419141948eucas1p2432e9dab7c8950ca7185f295f27da2d1~W5ftM5kVi2700827008eucas1p2e;
        Fri, 19 Apr 2019 14:19:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BB.4B.04377.409D9BC5; Fri, 19
        Apr 2019 15:19:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc~W5fsYkTH52568825688eucas1p1w;
        Fri, 19 Apr 2019 14:19:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190419141947eusmtrp2ba38070a00a11a7cf16a4146c345dd29~W5fsKk27b2563425634eusmtrp2F;
        Fri, 19 Apr 2019 14:19:47 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-28-5cb9d9043032
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6D.90.04140.309D9BC5; Fri, 19
        Apr 2019 15:19:47 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141946eusmtip23371bb7d306d1966b5e9b2f5084884a1~W5frapTCm3043830438eusmtip2B;
        Fri, 19 Apr 2019 14:19:46 +0000 (GMT)
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
Subject: [PATCH v6 06/10] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
Date:   Fri, 19 Apr 2019 16:19:24 +0200
Message-Id: <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO7uPXa3JbUr+UElaCBW1HhYcMHpAyMUgQghkCTX1opGbtqvm
        K5pKj2nTsrKYmqnE1LTMRrURPVRaZGqStcykVMrXtHQmvbC63Fn/fX+f3/f3Pb9zOAyhbKOC
        mEP6NN6g1yaraF/yzpPvXevIPnvsBttQML51+SaFXbMjFK5q76Lw9elhhM8/q5Th50U6XDI8
        QeDu7mY57sx3y/FbYwh+6aigscfcjvDl7gcy3NQ+IMf9eXU0bnOfovDD3ijc/9MPzz0dQjv8
        ubmvpSRXbuwhObtlQM61NJhozlwwRXOPp+7LuGJbA+Jud+Rwnpble300vlsT+ORDGbxh/baD
        vkm1eS4qtTM4s6DXLTeikWWFiGGA3Qwus6YQ+TJKtg7B9FezTCpmEbjGTKRUeBDUOKvohYmX
        ZUkStyKYryon/030eppJ0USzarjXcKQQ+TABbA68cz0kRA/BumXQ+eMbKTb82Tj4/PiWXPST
        bBg0FkWKWMFGQdfAC5mogV0OfV0mQtQ+7G5w1NtoMQfYITk8cg/KJdMuOOcopSXtD+NOm5eH
        wG97lTdIAKO5Gkk6F4ZLKr2eCGhz9lDiDgS7Gm461kt4J4y9uOC9rx+8mVwqYuKvLL1ziZCw
        Ak6fVEruVWA7s7DxMrA2lnnDOZis7aCk17mCoL7mBn0WhVr+H3YVoQYUyKcLukRe2KTnj6oF
        rU5I1yeq41N0Lejv1+qYd87eQ45fca2IZZBqieJRqT1WSWkzhCxdKwKGUAUodibYYpWKBG1W
        Nm9IOWBIT+aFVhTMkKpARc6iD/uVbKI2jT/M86m8YaErY3yCjCghZl9T84nwiz1BprXZoZ8a
        LZEjafV3r1lmtl/iRn+ordawRSsD/HMr5q2a2V+CenyF7Ism6FUyrKyIKo5+kLm7pbbEFJoV
        3xlizz+/hYf3g6OuvXmTzo85hwviv83EvI7wHO9+Tb2pjHbfz5gQjs3tmZ7TlIeXDRAbLbi6
        uGyxihSStBvXEAZB+wf2G0+sVgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7rMN3fGGMx9qGaxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexuLG66wFZ6Urmq+8YW9gfC7WxcjBISFgInF5WkYX
        IxeHkMBSRok/N/awdTFyAsXFJCbt284OYQtL/LnWxQZR9IlR4tKFSYwgzWwCehI7VhWC1IgI
        1Ev0v7kEVsMs0MAssWb7VVaQhLBAgsT27klMIPUsAqoSa7rdQMK8Al4S5+5eYIKYLydx81wn
        M4jNKeAtsWvlFrAbhIBqNlzbyzSBkW8BI8MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwDja
        duznlh2MXe+CDzEKcDAq8fAemLQzRog1say4MvcQowQHs5IIr2PKlhgh3pTEyqrUovz4otKc
        1OJDjKZAN01klhJNzgfGeF5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4m
        Dk6pBsYtwlceC64KnBUz8/Ex2zMCRU9KDbpSOLcmSUlXvWJfd3EOm3Gn9PY7K2PnXWYuXF3N
        InWvWo5/p2q8X6DqqtVdvT9ezv3W05ngovTAb5vr7bRyqaX3Fm9nKPLxSbrv8M1NddEtj89T
        OcqC7hSvPZx8O99FeVWGhaW7mkf9vO1BqRocdft/XFViKc5INNRiLipOBADuAmQ9uQIAAA==
X-CMS-MailID: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds description for DT binding for a new Exynos5422 Dynamic
Memory Controller device.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../bindings/memory-controllers/exynos5422-dmc.txt | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
new file mode 100644
index 0000000..133b3cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
@@ -0,0 +1,73 @@
+* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
+
+The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
+memory chips are connected. The driver is to monitor the controller in runtime
+and switch frequency and voltage. To monitor the usage of the controller in
+runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
+is able to measure the current load of the memory.
+When 'userspace' governor is used for the driver, an application is able to
+switch the DMC and memory frequency.
+
+Required properties for DMC device for Exynos5422:
+- compatible: Should be "samsung,exynos5422-bus".
+- clock-names : the name of clock used by the bus, "bus".
+- clocks : phandles for clock specified in "clock-names" property.
+- devfreq-events : phandles for PPMU devices connected to this DMC.
+- vdd-supply : phandle for voltage regulator which is connected.
+- reg : registers of two CDREX controllers, chip information, clocks subsystem.
+- operating-points-v2 : phandle for OPPs described in v2 definition.
+- device-handle : phandle of the connected DRAM memory device. For more
+	information please refer to Documentation
+- devfreq-events : phandles of the PPMU events used by the controller.
+
+Example:
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
+	dmc: memory-controller@10c20000 {
+		compatible = "samsung,exynos5422-dmc";
+		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+			<0x10000000 0x1000>, <0x10030000 0x1000>;
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
+				<&clock CLK_CLKM_PHY1>;
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
+			        "clkm_phy1";
+		status = "okay";
+		operating-points-v2 = <&dmc_opp_table>;
+		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
+				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
+		operating-points-v2 = <&dmc_opp_table>;
+		device-handle = <&samsung_K3QF2F20DB>;
+		vdd-supply = <&buck1_reg>;
+	};
-- 
2.7.4

