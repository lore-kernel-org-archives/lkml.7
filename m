Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACAAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF37208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uxLcmLKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408889AbfITMPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:15:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36185 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408843AbfITMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:15:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190920121527euoutp024216b19907adff0ea6450b8276d82fde~GJJGK56SW2978829788euoutp023
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 12:15:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190920121527euoutp024216b19907adff0ea6450b8276d82fde~GJJGK56SW2978829788euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568981727;
        bh=tX5jVwMHMpIeMs2o0N1LffP2nPaWeoVSu75Ha/QQEvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxLcmLKzE5qXFNLfcgWnvN3zekSvm2yCzawEKD0Nf/MCf3oXemriI+x5q5nLSJ8pl
         VB5xbJryBfMB4mJtVtaENbV59iE9Iu5nra+Nwrs6vfiElVZFxO3euCtaarkxvyKDt7
         r/1Et+dXJ2yYrW88nJhOSy3Zss+TBCIyV4SOaBWE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190920121526eucas1p254a2394a82fbc200acd33fa0d7a2c0af~GJJFKNRvT1857318573eucas1p28;
        Fri, 20 Sep 2019 12:15:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 81.55.04309.ED2C48D5; Fri, 20
        Sep 2019 13:15:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190920121525eucas1p27562c205c41200221540b720c9084fb4~GJJEM1F791035610356eucas1p2N;
        Fri, 20 Sep 2019 12:15:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190920121525eusmtrp221d95f0f41c2c2c77447b03c6e7a1577~GJJD7jcHx1406614066eusmtrp2D;
        Fri, 20 Sep 2019 12:15:25 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-89-5d84c2dec1fe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.CA.04117.DD2C48D5; Fri, 20
        Sep 2019 13:15:25 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190920121524eusmtip2eeb5da43d4ed2b6d212a5a37e3d5aa97~GJJDXXtVU1487014870eusmtip2j;
        Fri, 20 Sep 2019 12:15:24 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Maciej Falkowski <m.falkowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/2] ARM: dts: exynos: split phandle in dmas property
Date:   Fri, 20 Sep 2019 14:14:30 +0200
Message-Id: <20190920121431.31678-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUhTUQDFu3vbe09p8ZqaFw2NQYn5lVH0IpOEhJFGH/4RZDNnPqbppuw5
        P6FMrXSESRDaNDUy06lrLR1q86O5Ws5w2sRSck2wWqEQToplaM6n9t/vnHsO53K5OMJr4Pjh
        6dIcSiYVZfJRT7bujcsSZjOUCQ/UNRPktHqUQ06MG1jk/dk5lGwwrkmLRYORvybKWaS1tw4l
        ayz9LNJeqkbJDuMMRj75MM4ib/YZMXJo/jbnBFegcZaggvb6diDoUc5gAq2qAhVUdqqAwKkN
        OIte9IxKpTLTcylZRHSyZ9qIzYFl6/3z7S1/OMVA66MAHjgkDkGDWY8ogCfOI1oAVHybQhmx
        BGDNWOOGcAJ4d2KRvVmxjk9vVJ4CaLxhZm1VVP31wJ1CiUioWFCgbvYmrsHhqcdsdwghvrOg
        1dnFUQAc9yJiYceS3J1hE3uhQf8bcdtc4jhccZ1nxgJhm2YQcbMHcQ42VWrXtyDRjMGv5jIW
        EzoJdc0KDsNe8IepE2N4N1ztadgolAI4O9qBMeIOgNaSGsCkjsEh0/j6hRAiGD7rjWDsGFix
        1I25bUjsgB8XdrptZA3v6aoRxubC8ls8Jr0PKk3qrdlXY+8RhgXQoXZizPs0AbjqmudUgUDl
        /7FGAFTAl5LTEjFFH5RSeeG0SELLpeLwK1kSLVj7NiMrpqVu0Ps3xQAIHPC3c/fklQp5HFEu
        XSAxAIgjfG9u3eESIY+bKioopGRZl2XyTIo2AH+czfflFm2zJ/IIsSiHyqCobEq2ecrCPfyK
        gQT3T2pdULTHDQgtjY0G07LsJxqbGhXyueuLOFw37Zh85Ii/0G4ObTg6lR/UNuSMjrHJfZ67
        hq8nZOyi33bVLldPFi6eITUvW9/1VRUNXh0bCEuoHQy2Lb9AP80FhSqFqpWCgAch9tPeyUH6
        15WquNJT0qToI8PxtsRLUSkPcT6bThNF7kdktOgf5WoeMTIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4Pd27h1piDWa95be4te4cq8WVi4eY
        LKY+fMJmMf8IkHv+/AZ2i29XOpgsLu+aw2Yx4/w+JosHzevYLNYeuctusfT6RSaL1r1H2C0O
        v2lndeD12PC5ic1jzbw1jB47Z91l99i0qpPNo2/LKkaPz5vkAtii9GyK8ktLUhUy8otLbJWi
        DS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJO33vBXrBHuuLBil+sDYybRLsY
        OTkkBEwkLl+8xdzFyMUhJLCUUWLrkS2sEAkZiZPTGqBsYYk/17rYIIo+MUqcXARRxCZgKNH1
        FiIhItDEKLHx30kWEIdZ4COTRMuTe4xdjBwcwgKuEmu/lII0sAioShza850ZJMwrYCvx72cQ
        xAJ5idUbDjCD2JwCgRJL+jYxgdhCAgESO288ZJvAyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66
        XnJ+7iZGYOhvO/Zzyw7GrnfBhxgFOBiVeHgVyptjhVgTy4orcw8xSnAwK4nwzjFtihXiTUms
        rEotyo8vKs1JLT7EaAp000RmKdHkfGBc5pXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnN
        Tk0tSC2C6WPi4JRqYKz7f+Z7yebGK3+ZTkwoDzJfrLRZhy/x/MWL7TeDbzzNy/Q9HC09RWIl
        q51PzzaDl2Gtt42eS60KOrl6fkNd8qkzJmm3hFM3//Lru22ufeZKoen0/jbWJaafTki+Zd+o
        bKk/e/3S57q285b1T/vOeijrW16Tgn9ij4TEfPPpqZF3D3LedzS780KJpTgj0VCLuag4EQAU
        sYCikwIAAA==
X-CMS-MailID: 20190920121525eucas1p27562c205c41200221540b720c9084fb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190920121525eucas1p27562c205c41200221540b720c9084fb4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190920121525eucas1p27562c205c41200221540b720c9084fb4
References: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
        <CGME20190920121525eucas1p27562c205c41200221540b720c9084fb4@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Change representation of phandle array as then
dt-schema counts number of its items properly.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 14 +++++++-------
 arch/arm/boot/dts/exynos5410.dtsi |  6 +++---
 arch/arm/boot/dts/exynos5420.dtsi | 14 +++++++-------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index fc966c10cf49..44fdaad68f7c 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -586,9 +586,9 @@
 			compatible = "samsung,s5pv210-i2s";
 			status = "disabled";
 			reg = <0x03830000 0x100>;
-			dmas = <&pdma0 10
-				&pdma0 9
-				&pdma0 8>;
+			dmas = <&pdma0 10>,
+				<&pdma0 9>,
+				<&pdma0 8>;
 			dma-names = "tx", "rx", "tx-sec";
 			clocks = <&clock_audss EXYNOS_I2S_BUS>,
 				<&clock_audss EXYNOS_I2S_BUS>,
@@ -606,8 +606,8 @@
 			compatible = "samsung,s3c6410-i2s";
 			status = "disabled";
 			reg = <0x12D60000 0x100>;
-			dmas = <&pdma1 12
-				&pdma1 11>;
+			dmas = <&pdma1 12>,
+				<&pdma1 11>;
 			dma-names = "tx", "rx";
 			clocks = <&clock CLK_I2S1>, <&clock CLK_DIV_I2S1>;
 			clock-names = "iis", "i2s_opclk0";
@@ -621,8 +621,8 @@
 			compatible = "samsung,s3c6410-i2s";
 			status = "disabled";
 			reg = <0x12D70000 0x100>;
-			dmas = <&pdma0 12
-				&pdma0 11>;
+			dmas = <&pdma0 12>,
+				<&pdma0 11>;
 			dma-names = "tx", "rx";
 			clocks = <&clock CLK_I2S2>, <&clock CLK_DIV_I2S2>;
 			clock-names = "iis", "i2s_opclk0";
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index e6f78b1cee7c..a4b03d4c3de5 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -222,9 +222,9 @@
 		audi2s0: i2s@3830000 {
 			compatible = "samsung,exynos5420-i2s";
 			reg = <0x03830000 0x100>;
-			dmas = <&pdma0 10
-				&pdma0 9
-				&pdma0 8>;
+			dmas = <&pdma0 10>,
+				<&pdma0 9>,
+				<&pdma0 8>;
 			dma-names = "tx", "rx", "tx-sec";
 			clocks = <&clock_audss EXYNOS_I2S_BUS>,
 				<&clock_audss EXYNOS_I2S_BUS>,
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7d51e0f4ab79..2c131ad78c09 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -434,9 +434,9 @@
 		i2s0: i2s@3830000 {
 			compatible = "samsung,exynos5420-i2s";
 			reg = <0x03830000 0x100>;
-			dmas = <&adma 0
-				&adma 2
-				&adma 1>;
+			dmas = <&adma 0>,
+				<&adma 2>,
+				<&adma 1>;
 			dma-names = "tx", "rx", "tx-sec";
 			clocks = <&clock_audss EXYNOS_I2S_BUS>,
 				<&clock_audss EXYNOS_I2S_BUS>,
@@ -455,8 +455,8 @@
 		i2s1: i2s@12d60000 {
 			compatible = "samsung,exynos5420-i2s";
 			reg = <0x12D60000 0x100>;
-			dmas = <&pdma1 12
-				&pdma1 11>;
+			dmas = <&pdma1 12>,
+				<&pdma1 11>;
 			dma-names = "tx", "rx";
 			clocks = <&clock CLK_I2S1>, <&clock CLK_SCLK_I2S1>;
 			clock-names = "iis", "i2s_opclk0";
@@ -471,8 +471,8 @@
 		i2s2: i2s@12d70000 {
 			compatible = "samsung,exynos5420-i2s";
 			reg = <0x12D70000 0x100>;
-			dmas = <&pdma0 12
-				&pdma0 11>;
+			dmas = <&pdma0 12>,
+				<&pdma0 11>;
 			dma-names = "tx", "rx";
 			clocks = <&clock CLK_I2S2>, <&clock CLK_SCLK_I2S2>;
 			clock-names = "iis", "i2s_opclk0";
-- 
2.17.1



