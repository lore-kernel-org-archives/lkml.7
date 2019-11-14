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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 23:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D235520724
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 23:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj1k0Zeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKNXn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 18:43:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41502 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKNXn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:43:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id h4so4777529pgv.8;
        Thu, 14 Nov 2019 15:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZYhq15YwccvfLxkq49KVbLEPyVEbIDDpU1pgaz8wyAE=;
        b=bj1k0ZehY8AB0Eteth/GmaSEqBlXEe2ORKMrG5EbIJxX58qUGwmAXypawx5J6rCIPF
         P9owqTmhhzxHUIyDizQK5Nvx4p0ecSeFgWSlYvI+WBpNMWVesZCk3vvFBnvosuSNRRyg
         hAy7p3/Aqi3qpYN5+gXd7D4P1PFDfl3GPHtyTRpmF9A+dy3XjWjnyFgIs38sEf9dPPvC
         My3AJZYF+D1+2OdAif1uwZv0pBbxSxCm8W0kKpqmGQIenbM1HG0Pqd1F0d00n4vI+XGG
         Da0yAfWDCcnHbzzpQD05GzjLa27a0arnDFjBG615hp+c7uZ1W/MxbFfO9jmJmtO6nBrg
         sneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZYhq15YwccvfLxkq49KVbLEPyVEbIDDpU1pgaz8wyAE=;
        b=F0++ui4zXqhYta8QURkKu9EZnSPVnrUMtLI1R9ccIho30/p2f/rtWOyM0fi7k6Fy2G
         nsS/J0+P9esy5SFoQCErtLK7mQ93T0JZsyLbKQ6+LCgF79IJnaw0cOV9K9BFfNICUwJn
         78haj6rMnHRIbLF2VXe549SQem8FVDL1tJ2dCFQ07IaP+6Q40zJdpgy/LXb4alVe3ANN
         XaC0xtmpajxUWSoOdR9dqMpUZ9PMSZJPy7aA/71gp3nPXks4DcRfcN5LoqKZn0bEWBLN
         hn1LOXfbc+YMUk+KvihOOEoXrBgOpSz+Zm0eVjynrDdj+OhXBnghMnnRnz1fdM3Bll9c
         H6wg==
X-Gm-Message-State: APjAAAXa9GSu5XdaYYofDv/FzsWlmX6bKh5WsNo1yqy/g6cZcEiWF5kI
        aqNgaGAN0eZu6jhGcu4ojig+QL5hLCA=
X-Google-Smtp-Source: APXvYqwd6WSlfd+in49pie+JJllRKfigCdGdxPsRtSCHhzspFAjwd6fzyuLv9GTBl+xKk4Q125261w==
X-Received: by 2002:a17:90a:37e4:: with SMTP id v91mr15976576pjb.8.1573775005841;
        Thu, 14 Nov 2019 15:43:25 -0800 (PST)
Received: from odroid.ad.adelaide.edu.au (staff-249-202.wireless.adelaide.edu.au. [129.127.249.202])
        by smtp.googlemail.com with ESMTPSA id e17sm7953140pgg.5.2019.11.14.15.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 15:43:25 -0800 (PST)
From:   Marian Mihailescu <mihailescu2m@gmail.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org
Cc:     Marian Mihailescu <mihailescu2m@gmail.com>
Subject: [PATCH v6] ARM: dts: exynos5420: add mali dt node and enable mali on Odroid XU3/4
Date:   Fri, 15 Nov 2019 10:12:11 +1030
Message-Id: <20191114234211.1032-1-mihailescu2m@gmail.com>
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

Changes since v5:
- fixed compile warnings

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
index 7d51e0f4ab79..8c354902c3f8 100644
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
+				opp-177000000 {
+					opp-hz = /bits/ 64 <177000000>;
+					opp-microvolt = <812500>;
+				};
+				opp-266000000 {
+					opp-hz = /bits/ 64 <266000000>;
+					opp-microvolt = <862500>;
+				};
+				opp-350000000 {
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

