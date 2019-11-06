Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA1CC5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CB9206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyjF+UFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfKFGZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:25:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45257 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfKFGZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:25:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id z4so12029150pfn.12;
        Tue, 05 Nov 2019 22:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2z2zzwrYZ89SfiCuWmgXUPVWQMuF3fw9rReYi+2N7KE=;
        b=AyjF+UFgW43piHCYUZKLwAxP4I/dTqeJJR8QAxrE4FXSu6JTVNGGua0F2U0rS9awZ0
         ng5nGCzhxTTxFVaRHnAktFDqqsq8DukOob1HZdnU/dcS1+tWZS9ZrsC0WDDtcG/AVj3/
         ZD9R4S8yTCrVNsI5JupLyNa6Jc6agB6bZkZ74a+tjvt/yQhPSFAaEzKnRqihcDBbPmCc
         PoceSfGHdK5UY1Mxor7p1hOsh3UBHLO2HSbV/zWMp508VVfgvno0MlhgOCxNqTRvan+f
         vRNX79UO4gkEbRNxYpJ4aLUFSD+UVem9zF1n6JRZXdCyUiMmKHjh0cpK8lUZ7BmzrK7u
         k9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2z2zzwrYZ89SfiCuWmgXUPVWQMuF3fw9rReYi+2N7KE=;
        b=Qn4YctS5Iy0WqGLZ7eIDFLJncxpYeaQXXDl02KF7XiUJfrTg0Hk6+yJxF1/VDte+19
         abPXU1RD0HTSQNjMprQxPR2OFxFhtwWacjowKC8q7pb1fO714riFrIMOHj+ckzGO3UQh
         0Tvg6o+OESvsT1qcvs8XgEFuFPTplp5Uw2DAYhr9FRwHDNLfl058ScLx8f855lT2+JV0
         eVWvkYN434buJt+6Q2T5FVSp5NcxPdSOHKasaKeELf91eHnskAE75XY/CQjK9m8f+cyW
         U0BBs2cpHgA6D9dP7kpqTvCpcs4+Na50OMJsZgfRQJXiecweHnhOvWQpHQh40V201cVe
         8LPg==
X-Gm-Message-State: APjAAAX9R25csdfVHg2n/6NuAuJA5V1vOgkD/7XKFIb1KLm6XP3+TEhi
        s7/rJI6oLW191okW5vWkEfY/beUZfJg=
X-Google-Smtp-Source: APXvYqwVKVpY4Yu383X57nPEcilngoPHxaetzEiFo6tuZQucqF7xzatqr8jYSwt82c+XX66eLgyrMA==
X-Received: by 2002:a17:90a:1089:: with SMTP id c9mr1640780pja.8.1573021528406;
        Tue, 05 Nov 2019 22:25:28 -0800 (PST)
Received: from odroid.ad.adelaide.edu.au (staff-249-202.wireless.adelaide.edu.au. [129.127.249.202])
        by smtp.googlemail.com with ESMTPSA id l22sm20384453pgj.4.2019.11.05.22.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 22:25:27 -0800 (PST)
From:   Marian Mihailescu <mihailescu2m@gmail.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org
Cc:     memeka <mihailescu2m@gmail.com>
Subject: [PATCH] ARM: dts: exynos5420: add mali dt bindings and enable mali on Odroid XU3/4
Date:   Wed,  6 Nov 2019 16:55:11 +1030
Message-Id: <20191106062511.3262-1-mihailescu2m@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: memeka <mihailescu2m@gmail.com>

Add device tree bindings and nodes for Mali GPU for Exynos 542x SoC.
GPU is disabled by default, and is enabled for each board after the regulator
is defined. Tested on Odroid-XU4.

Changes since v1:
- used generic node and label for GPU
- added bindings for compatible
- fixed irq indentation
- fixed interrupt-names to match bindings
- added cooling cells for future TMU connection
- used generic node and label for GPU opp table
- removed always-on from SoC GPU regulator

Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |  5 ++-
 arch/arm/boot/dts/exynos5420.dtsi                  | 50 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  6 ++-
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index 47bc1ac36426..e8868cb587de 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -38,9 +38,12 @@ properties:
           - enum:
              - samsung,exynos5433-mali
           - const: arm,mali-t760
+      - items:
+          - enum:
+             - samsung,exynis5420-mali
+          - const: arm,mali-t628
 
           # "arm,mali-t624"
-          # "arm,mali-t628"
           # "arm,mali-t830"
           # "arm,mali-t880"
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7d51e0f4ab79..31b5f7ba0e3b 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -670,6 +670,56 @@
 			iommus = <&sysmmu_gscl1>;
 		};
 
+		gpu: gpu@11800000 {
+			compatible = "samsung,exynos5422-mali", "arm,mali-t628";
+			reg = <0x11800000 0x5000>;
+			interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
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
index 422692b20c46..ce774f7b2ce0 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -522,7 +522,6 @@
 				regulator-name = "vdd_g3d";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
-				regulator-always-on;
 				regulator-boot-on;
 
 				regulator-state-mem {
@@ -659,6 +658,11 @@
 	status = "okay";
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

