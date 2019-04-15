Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9848C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9A8218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353298;
	bh=Y5TjgtdGJPsZ8tV3HabzkpD9mGYfF7hgz8fGx7LB2Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mrw5qHYWBnCyWIXZFHGj5LNv/vQ5b354IsMQ4pyWb/r7xK0OK3Pcz+KrNr7/A6zJW
	 lD2wVJhZdyd88JpvApwnNx6H/oNKeZwEORNwdIzeLKs1cbFUMIISj1rPZXvuVJNxyw
	 ZrQVjD0Dcx3bTvuejenK5/KZTZ+BG3SW0JXpbCSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfDOSe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfDOSe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:34:56 -0400
Received: from localhost.localdomain (unknown [194.230.158.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A125B20880;
        Mon, 15 Apr 2019 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353296;
        bh=Y5TjgtdGJPsZ8tV3HabzkpD9mGYfF7hgz8fGx7LB2Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Md2zptC8spqxgF7K1J0MSJKq0f92nWgic86EgzFnRmUt2FcZzvDtalttEkiyEpFI2
         BV057BS0G3cH4jgKAcyCkIBK2itm5BhwbxZdDQxHHMQ8fURAGXKlM3ZGD1C1FU8fev
         R67UwQaW3XIQMTGavVKx5vXs8myaPpHlp676eWHc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/2] arm64: dts: exynos: Move fixed-clocks out of soc
Date:   Mon, 15 Apr 2019 20:34:40 +0200
Message-Id: <20190415183440.19697-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190415183440.19697-1-krzk@kernel.org>
References: <20190415183440.19697-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XXTI fixed-clock is the input to the SoC therefore it should not be
inside the soc node.  This also fixes DTC W=1 warning:

    arch/arm64/boot/dts/exynos/exynos7.dtsi:90.17-94.5:
        Warning (simple_bus_reg): /soc/xxti: missing or empty reg/ranges property

While moving, change the name of the xxti node to match the generic type
of device (following DeviceTree specification).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 13 +++++++------
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 13 +++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 62cedf9855cf..d29d13f4694f 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -41,6 +41,13 @@
 		interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
 	};
 
+	xxti: clock {
+		/* XXTI */
+		compatible = "fixed-clock";
+		clock-output-names = "oscclk";
+		#clock-cells = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -260,12 +267,6 @@
 			reg = <0x10000000 0x100>;
 		};
 
-		xxti: xxti {
-			compatible = "fixed-clock";
-			clock-output-names = "oscclk";
-			#clock-cells = <0>;
-		};
-
 		cmu_top: clock-controller@10030000 {
 			compatible = "samsung,exynos5433-cmu-top";
 			reg = <0x10030000 0x1000>;
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index f83ad4c491f2..077d23478901 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -38,6 +38,13 @@
 				     <&cpu_atlas2>, <&cpu_atlas3>;
 	};
 
+	fin_pll: clock {
+		/* XXTI */
+		compatible = "fixed-clock";
+		clock-output-names = "fin_pll";
+		#clock-cells = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -87,12 +94,6 @@
 			reg = <0x10000000 0x100>;
 		};
 
-		fin_pll: xxti {
-			compatible = "fixed-clock";
-			clock-output-names = "fin_pll";
-			#clock-cells = <0>;
-		};
-
 		gic: interrupt-controller@11001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.17.1

