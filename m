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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823F5FC6196
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3A2217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdEEXEf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbfKFWzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:55:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44362 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKFWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:55:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id f19so74195pgk.11;
        Wed, 06 Nov 2019 14:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WwmAXrpZu1baXaKN4OHedrq+hk5dzg0MV9DJtmeM5HE=;
        b=OdEEXEf0qkDqsHtYS7pq4C8nmslrlJTdjW9dPAIa1jbutFk3tUZXnW+4clWiI2ich0
         5YEQThPkDG0EnyQLLVbjZ7LahZg4By60KPsRfP+xE2+Q/su/4oMFO74cSKEgpFugWuo1
         MqxkWJ7xkke6p5RGvLvvHGRqSrK/ZYGxTcPVTOK7vgUy//4eItotPTNKeWQzJcTy5kZh
         vwzSn59Exx4C2nqYb2PFQQtBH0SWgKyAPq62hAnezeRhpL2jCvd+EhE33yz3SSvxpNgz
         DaPQT+etQDdqLZRNwXJSIzwKsF7zwGSh1e1NheSfVUXWEAVhdZIVJIEiTL8EzPi1K7KH
         1lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WwmAXrpZu1baXaKN4OHedrq+hk5dzg0MV9DJtmeM5HE=;
        b=WR3OiQKQGpNfwOD16eLT9lq5oOYbXrUL/ieptsfgXEKulIJJQmzOOMolCI8hODms4U
         Mye2K9SkRXJgLFHBStVdZOEIxBM66QiSmac+LkWKi7zLmLdt51oc7s3cLqcwbsXOpjBq
         HwdZzCozJY2k2kGVCkJtim0XM556eJBPYa4PC5RHV+Y27z+sYMNV3WKg08lxBJBGVQMA
         ePxbgYJlcIAgHUQALLUllFQQcF65vAbiUPuAbt0uQFbshPIhFELYLNQuL9g49G3V/DAy
         0jBlKpFEUpG/e0w6yo2vmqn8z7lVmuBjlhkuT8g2xkUTd+I66dsLRt8SH7UBSXW9TMSJ
         TeKQ==
X-Gm-Message-State: APjAAAXYroovfDTSD2y4zVbeQhAriyltO44xE+oJeUT3+laaXbHPwpCd
        ZnwQK33+S+L1RNspdX47th5yQpMYlB8=
X-Google-Smtp-Source: APXvYqx2gZUmxB7PHKNEnVpURy1RgEUrL9gwFxw9zOyKVDCH3QDFfNgLDcVtNEFtrylLD/GkuKsARQ==
X-Received: by 2002:a63:4104:: with SMTP id o4mr353589pga.169.1573080947192;
        Wed, 06 Nov 2019 14:55:47 -0800 (PST)
Received: from odroid.ad.adelaide.edu.au (staff-249-202.wireless.adelaide.edu.au. [129.127.249.202])
        by smtp.googlemail.com with ESMTPSA id y16sm32851pfo.62.2019.11.06.14.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:55:46 -0800 (PST)
From:   Marian Mihailescu <mihailescu2m@gmail.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org
Cc:     Marian Mihailescu <mihailescu2m@gmail.com>
Subject: [PATCH v4 2/2] ARM: dts: exynos5420: add mali dt node and enable mali on Odroid XU3/4
Date:   Thu,  7 Nov 2019 09:25:27 +1030
Message-Id: <20191106225527.9121-2-mihailescu2m@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20191106225527.9121-1-mihailescu2m@gmail.com>
References: <20191106225527.9121-1-mihailescu2m@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for Mali GPU for Exynos 542x SoC.
GPU is disabled by default, and is enabled for each board after the
regulator is defined. Tested on Odroid-XU4.

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

Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi             | 50 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  6 +++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7d51e0f4ab79..31b5f7ba0e3b 100644
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

