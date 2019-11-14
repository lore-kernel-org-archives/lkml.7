Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E69C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFBA206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0LLtYrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKNAJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:09:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38593 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKNAJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:09:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id w8so1776818plq.5;
        Wed, 13 Nov 2019 16:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qfqVRrP8pJ55LNT1IzE1hrfM0Ib8N8j0mvWTAA+BXF0=;
        b=B0LLtYrH5OZ9/iE0rY2VCiHjhY7dohyl/ZN8gPmCir77dP6fvJk+Ppc7641kDqJuDX
         ZG9122SlxaRz2/C8pivH84LrTZozyaQIPiqtBJD43Lk0G1Gs5kAt3zmz8EXxt0aj1M1w
         zwvTBA/i3+cAIwZk8xrlGvhWQ6Y7+vxOckOYet9HNuFrogxl5G8eH8a7fGe1hpqz955m
         dskWAAs3Yr5B+NQnvSFRjaqIdA83H3r6IjhbEuBgJLJKNdEqAOpP/zcYelHE9rhWmLLf
         gKCXtQoofPEcVqO/TXiPoA3TvvkWkO/ZA6kpKt6b3P4DXqVMgYAJcuWg31jhwQxe4JGv
         B2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qfqVRrP8pJ55LNT1IzE1hrfM0Ib8N8j0mvWTAA+BXF0=;
        b=mBgAwoUi9w+lX5I7FWlrJcIaQOE9RWFgsYliFrE2MyjPvxioF3DLCU4zZeTHzjRKNJ
         QFNOf9vbFc3WlbauUXO9cRQTLrA4agXWIg9AdSAwzhkEQ/i0EJKbseDi1oSLuqHGBDqe
         aQkkmY9Q9Id890WNtXbzER1tlLIg+IZQRF7Gus3iW+LlYW6uskSDVDjq2TbgrOJ08O+Y
         K9N81N9+tahNrJAlEIU4TFHJ8ROReRKVygya2PrqF0goN5aaUMrVU8pHr7QShhEpcbwm
         rPsyNpMNwYAdAuuNGI0RBLXlLBxUOIF5HoP8Q2Uzm0jiM822ADuTelWbXGGv/WjTcJJN
         PLdQ==
X-Gm-Message-State: APjAAAUkdOn3EEsDGXFHcYOHja5DLgKY2cndRTyJU2AfMIjOjCRpNY2o
        fG0iiZI+rt9+XMViaTAfgDrZpsS7ka8=
X-Google-Smtp-Source: APXvYqxAifQxOkHomF5n9FJPy2V+h66J1R0rJVnFhwZjZ3clwZagFL0JJMEzGHrMBGBkcQJEmBDF8A==
X-Received: by 2002:a17:902:b582:: with SMTP id a2mr6660607pls.103.1573690160938;
        Wed, 13 Nov 2019 16:09:20 -0800 (PST)
Received: from odroid.ad.adelaide.edu.au (staff-249-202.wireless.adelaide.edu.au. [129.127.249.202])
        by smtp.googlemail.com with ESMTPSA id b1sm3298910pjw.19.2019.11.13.16.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 16:09:20 -0800 (PST)
From:   Marian Mihailescu <mihailescu2m@gmail.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org
Cc:     Marian Mihailescu <mihailescu2m@gmail.com>
Subject: [PATCH v5] ARM: dts: exynos5420: add mali dt node and enable mali on Odroid XU3/4
Date:   Thu, 14 Nov 2019 10:39:00 +1030
Message-Id: <20191114000900.26962-1-mihailescu2m@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for Mali GPU for Exynos 542x SoC.
GPU is disabled by default, and is enabled for each board after the
regulator is defined. Tested on Odroid-XU4.

Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
---

Changes since v4:
- fixed so it applies for latest 5.4-rc7

Changes since v3:
- fixed compatible to match bindings

Changes since v2:
- separate patch for bindings
- fixed bindings typo

Changes since v1:
- used generic node and label for GPU
- added bindings for compatible
- fixed irq indentation
- fixed interrupt-names to match bindings
- added cooling cells for future TMU connection
- used generic node and label for GPU opp table
- removed always-on from SoC GPU regulator

---
 arch/arm/boot/dts/exynos5420.dtsi             | 50 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  6 +++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7d51e0f4ab79..9f30f7535c40 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -670,6 +670,56 @@
 			iommus = <&sysmmu_gscl1>;
 		};
 
+		gpu: gpu@11800000 {
+			compatible = "samsung,exynos5420-mali", "arm,mali-t628";
+			reg = <0x11800000 0x5000>;
+			interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+
+			clocks = <&clock CLK_G3D>;
+			clock-names = "core";
+			power-domains = <&g3d_pd>;
+			operating-points-v2 = <&gpu_opp_table>;
+
+			status = "disabled";
+			#cooling-cells = <2>;
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp@177000000 {
+					opp-hz = /bits/ 64 <177000000>;
+					opp-microvolt = <812500>;
+				};
+				opp@266000000 {
+					opp-hz = /bits/ 64 <266000000>;
+					opp-microvolt = <862500>;
+				};
+				opp@350000000 {
+					opp-hz = /bits/ 64 <350000000>;
+					opp-microvolt = <912500>;
+				};
+				opp-420000000 {
+					opp-hz = /bits/ 64 <420000000>;
+					opp-microvolt = <962500>;
+				};
+				opp-480000000 {
+					opp-hz = /bits/ 64 <480000000>;
+					opp-microvolt = <1000000>;
+				};
+				opp-543000000 {
+					opp-hz = /bits/ 64 <543000000>;
+					opp-microvolt = <1037500>;
+				};
+				opp-600000000 {
+					opp-hz = /bits/ 64 <600000000>;
+					opp-microvolt = <1150000>;
+				};
+			};
+		};
+
 		scaler_0: scaler@12800000 {
 			compatible = "samsung,exynos5420-scaler";
 			reg = <0x12800000 0x1294>;
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 829147e320e0..f880aeccbace 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -522,7 +522,6 @@
 				regulator-name = "vdd_g3d";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
-				regulator-always-on;
 				regulator-boot-on;
 
 				regulator-state-mem {
@@ -654,6 +653,11 @@
 	vtmu-supply = <&ldo7_reg>;
 };
 
+&gpu {
+	mali-supply = <&buck4_reg>;
+	status = "okay";
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
-- 
2.14.1

