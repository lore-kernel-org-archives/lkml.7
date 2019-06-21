Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21651C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC522208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561140148;
	bh=kOXrOATchPDjqjaXCZf5RTt6UsgtNnQOmhinsiIP4As=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZFKhxehsQfixOYfn8FK41ZOE2/TORJjflj+ilbFcNChQaYrwThD0VRyv6oXnUTMU5
	 /KcrLxWD3TmWL24zFBUFu6bW1P4OYCTu+CcN4/IuzLNgsVCks7suNpQ7v5KGIpHHDk
	 BKuxA6gsWuKX0brYQTAEzUsMbWCyyzhz9G1YCg8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFUSC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUSC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:02:26 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E74762070B;
        Fri, 21 Jun 2019 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561140145;
        bh=kOXrOATchPDjqjaXCZf5RTt6UsgtNnQOmhinsiIP4As=;
        h=From:To:Cc:Subject:Date:From;
        b=U2ZF4cs6LAR1BHvpT4BE4VkqFlx0BF7npjfh4eOOMKHbMwUNLAvnuvvU8lujqfe/d
         ttVViCvoYT+6LKe3YKk5SJ77aWbwV6pylRhJRASBonj3AnGu7L6R9tDd3EeJPTMzuv
         qIEJIff9HTbuw/w4zdLFNO3qtbY4hXka1UnsKzxg=
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
Subject: [PATCH v2 1/7] ARM: dts: exynos: Add GPU/Mali 400 node to Exynos3250
Date:   Fri, 21 Jun 2019 20:02:02 +0200
Message-Id: <20190621180208.25361-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for GPU (Mali 400) to Exynos3250.  This is still limited and
not tested:
1. No dynamic voltage and frequency scaling,
2. Not sure what to do with CLK_G3D clock responsible for gating entire
   IP block (it is now being disabled as unused).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Use samsung,exynos4210-mali compatible
2. Use CLK_G3D as bus clock (clock for entire IP block)
---
 arch/arm/boot/dts/exynos3250-artik5.dtsi |  5 ++++
 arch/arm/boot/dts/exynos3250-monk.dts    |  5 ++++
 arch/arm/boot/dts/exynos3250-rinato.dts  |  5 ++++
 arch/arm/boot/dts/exynos3250.dtsi        | 33 ++++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
index ace50e194a45..dee35e3a5c4b 100644
--- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
+++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
@@ -59,6 +59,11 @@
 	cpu0-supply = <&buck2_reg>;
 };
 
+&gpu {
+	mali-supply = <&buck3_reg>;
+	status = "okay";
+};
+
 &i2c_0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index e25765500e99..248bd372fe70 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -172,6 +172,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&buck3_reg>;
+	status = "okay";
+};
+
 &hsotg {
 	vusb_d-supply = <&ldo15_reg>;
 	vusb_a-supply = <&ldo12_reg>;
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 7479993755da..86c26a4edfd7 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -244,6 +244,11 @@
 	};
 };
 
+&gpu {
+	mali-supply = <&buck3_reg>;
+	status = "okay";
+};
+
 &i2c_0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 8ce3a7786b19..c17870a54acf 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -126,6 +126,39 @@
 		};
 	};
 
+	gpu: gpu@13000000 {
+		compatible = "samsung,exynos4210-mali", "arm,mali-400";
+		reg = <0x13000000 0x10000>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "gp",
+				  "gpmmu",
+				  "pp0",
+				  "ppmmu0",
+				  "pp1",
+				  "ppmmu1",
+				  "pp2",
+				  "ppmmu2",
+				  "pp3",
+				  "ppmmu3",
+				  "pmu";
+		clocks = <&cmu CLK_G3D>,
+			 <&cmu CLK_SCLK_G3D>;
+		clock-names = "bus", "core";
+		power-domains = <&pd_g3d>;
+		status = "disabled";
+		/* TODO: operating points for DVFS, assigned clock as 134 MHz */
+	};
+
 	pmu {
 		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.17.1

