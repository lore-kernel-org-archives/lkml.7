Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62984C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA272070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561140156;
	bh=+9ohOiGJvzsfdxdaZ7ushjCiWCiAUtxItMfExsJy6aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2SK9c/wuvUbTAE08RztgS4MH8HxwydmLQ4V5Rcqv3Szg4CiupcGnCHfB8chs3YLSW
	 NeueL1so3hD2aTEWyTb0QWjYtTxnnMqIMwj6b37QG+Y52SEit8/cxZLSMlbO+LX+ES
	 nDoj3ZoTi653SA7DMupPMcZn+rHmoD+at5pb3vDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfFUSCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUSCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:02:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B372070B;
        Fri, 21 Jun 2019 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561140152;
        bh=+9ohOiGJvzsfdxdaZ7ushjCiWCiAUtxItMfExsJy6aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fovcbJeTqAWebQeHMR9VsOZ2R+LEgekORRRhKfZJhlbn1dB7xfsPmjLhHX423sys
         o7xO+690+48K00MUTDzp7lspIM7t+7OK08oGk6bdRBcYCjxQ2V4JHVVTS265DRGwtk
         +0nlTjexuqLJRxBW5CJykqnsYtEuBuJ3cBvOjTxw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joseph Kogut <joseph.kogut@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH v2 3/7] arm64: dts: exynos: Add GPU/Mali T760 node to Exynos5433
Date:   Fri, 21 Jun 2019 20:02:04 +0200
Message-Id: <20190621180208.25361-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621180208.25361-1-krzk@kernel.org>
References: <20190621180208.25361-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for GPU (Mali T760) to Exynos5433.  Missing element is the
cooling device.  Not tested on HW.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  5 ++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    | 51 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index d2de16645e10..6f90b0e62cba 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -350,6 +350,11 @@
 	pinctrl-0 = <&te_irq>;
 };
 
+&gpu {
+	mali-supply = <&buck6_reg>;
+	status = "okay";
+};
+
 &hdmi {
 	hpd-gpios = <&gpa3 0 GPIO_ACTIVE_HIGH>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index d29d13f4694f..a76f620f7f35 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -249,6 +249,57 @@
 		};
 	};
 
+	gpu: gpu@14ac0000 {
+		compatible = "samsung,exynos5433-mali", "arm,mali-t760";
+		reg = <0x14ac0000 0x5000>;
+		interrupts = <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "job", "mmu", "gpu";
+		clocks = <&cmu_g3d CLK_ACLK_G3D>;
+		clock-names = "core";
+		power-domains = <&pd_g3d>;
+		operating-points-v2 = <&gpu_opp_table>;
+		status = "disabled";
+
+		gpu_opp_table: opp_table {
+			compatible = "operating-points-v2";
+
+			opp-160000000 {
+				opp-hz = /bits/ 64 <160000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp-267000000 {
+				opp-hz = /bits/ 64 <267000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp-350000000 {
+				opp-hz = /bits/ 64 <350000000>;
+				opp-microvolt = <1025000>;
+			};
+			opp-420000000 {
+				opp-hz = /bits/ 64 <420000000>;
+				opp-microvolt = <1025000>;
+			};
+			opp-500000000 {
+				opp-hz = /bits/ 64 <500000000>;
+				opp-microvolt = <1075000>;
+			};
+			opp-550000000 {
+				opp-hz = /bits/ 64 <550000000>;
+				opp-microvolt = <1125000>;
+			};
+			opp-600000000 {
+				opp-hz = /bits/ 64 <600000000>;
+				opp-microvolt = <1150000>;
+			};
+			opp-700000000 {
+				opp-hz = /bits/ 64 <700000000>;
+				opp-microvolt = <1150000>;
+			};
+		};
+	};
+
 	psci {
 		compatible = "arm,psci";
 		method = "smc";
-- 
2.17.1

