Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A196C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D080A20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oFpypgQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDDFLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:11:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36073 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDDFLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:11:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so552687plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F1yQCM1He/iilKGVtAJa4AypI2f1GRQKckIjWBWCcqU=;
        b=oFpypgQDWiRhetUodQLYABcgBO4dJzTfbIo0X+AKxLUocp8xBFiygjBYKBOhrNqXLg
         tF2v78uwwADwV2YsRUdE7AP9u8Md3msCC69UGNVrHsb8SWtK56vyoAIjjTLYOKuUkEIP
         l1P0X8OGwswgUIba9EY0G5VjXJyHbg75lbATTjXbSOKT8h7ZqcaKULoprvobBoO9TnAw
         jJjazxamqWQlCAzUQSjfMP1dDW9ss+3N1i7YMRCr1n6peLjI4xa3i5WIFhP8peUK3P1f
         wAhimJHwjx0tEQF9+8VmSYpzAnTzl6OZ4Bfl5pY92csDyX5WRSPGITJFEZXrxBQNtwNP
         BW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1yQCM1He/iilKGVtAJa4AypI2f1GRQKckIjWBWCcqU=;
        b=JuDfqjCQr5YsohjH/nill37B0Bt/ifLRk8bwjmHlfvj3pqi4GL1B1i6s5kQE0fNxi/
         nk6FQp/DE7z/E6qu0N8s5atMPUpqiScWPWNkKCWgfW2fBfqx1I2nEUXn0TYI9k5XWV6u
         iLYcx4CnleA1HBAhgfQ9IuQZ3N38j538H7Vej2iq7L7lo9z07MlHAZMfZ4UgjVfB2LCY
         LzKZeIVDJm51rX7xliSsxizSXF0vdbHIwqVheIMVfVDt7yH9Azkkv3pVHg0UaTcVI/Tx
         NLgDGYsgLOgxysXjYWq1TJ4ER/rCf6MUp4eqPhoHTS1FL57CyLndxB0jRVYOzm7P+8Iy
         JfJQ==
X-Gm-Message-State: APjAAAVMhaCJBP66qTgBLUFeHB/RL1jA6TNCVqalFgRfchTo1oDxKxtZ
        hRCjgm5EGFoKl2IRF5sjvNfsCg==
X-Google-Smtp-Source: APXvYqw3kb8l0uD0BfFIe357cniIMpNb0XmXdHkkRgVEULM8Z8jAjD+zvlFY2Lo84ltYsCEDHs0EBg==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr4129707pla.306.1554354673204;
        Wed, 03 Apr 2019 22:11:13 -0700 (PDT)
Received: from centauri.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id p2sm59727368pfi.73.2019.04.03.22.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 22:11:12 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 9/9] arm64: dts: qcom: qcs404: Add CPR and populate OPP tables
Date:   Thu,  4 Apr 2019 07:09:30 +0200
Message-Id: <20190404050931.9812-10-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404050931.9812-1-niklas.cassel@linaro.org>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 152 ++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 5747beb8d55a..3643dae09eb4 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -33,6 +33,8 @@
 			next-level-cache = <&L2_0>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		CPU1: cpu@101 {
@@ -43,6 +45,8 @@
 			next-level-cache = <&L2_0>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		CPU2: cpu@102 {
@@ -53,6 +57,8 @@
 			next-level-cache = <&L2_0>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		CPU3: cpu@103 {
@@ -63,6 +69,8 @@
 			next-level-cache = <&L2_0>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		L2_0: l2-cache {
@@ -72,17 +80,17 @@
 	};
 
 	cpu_opp_table: cpu_opp_table {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-qcom-cpu";
+		nvmem-cells = <&cpr_efuse_speedbin>;
 		opp-shared;
 
 		opp-1094400000 {
 			opp-hz = /bits/ 64 <1094400000>;
+			required-opps = <&cpr_opp1>;
 		};
 		opp-1248000000 {
 			opp-hz = /bits/ 64 <1248000000>;
-		};
-		opp-1401600000 {
-			opp-hz = /bits/ 64 <1401600000>;
+			required-opps = <&cpr_opp2>;
 		};
 	};
 
@@ -411,6 +419,11 @@
 			assigned-clock-rates = <19200000>;
 		};
 
+		tcsr: syscon@1937000 {
+			compatible = "qcom,tcsr-qcs404", "syscon";
+			reg = <0x1937000 0x25000>;
+		};
+
 		tcsr_mutex_regs: syscon@1905000 {
 			compatible = "syscon";
 			reg = <0x01905000 0x20000>;
@@ -812,6 +825,137 @@
 				status = "disabled";
 			};
 		};
+
+		qfprom: qfprom@a4000 {
+			compatible = "qcom,qfprom";
+			reg = <0xa4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cpr_efuse_speedbin: speedbin@13c {
+				reg = <0x13c 0x4>;
+				bits = <2 3>;
+			};
+			cpr_efuse_quot_offset1: qoffset1@231 {
+				reg = <0x231 0x4>;
+				bits = <4 7>;
+			};
+			cpr_efuse_quot_offset2: qoffset2@232 {
+				reg = <0x232 0x4>;
+				bits = <3 7>;
+			};
+			cpr_efuse_quot_offset3: qoffset3@233 {
+				reg = <0x233 0x4>;
+				bits = <2 7>;
+			};
+			cpr_efuse_init_voltage1: ivoltage1@229 {
+				reg = <0x229 0x4>;
+				bits = <4 6>;
+			};
+			cpr_efuse_init_voltage2: ivoltage2@22a {
+				reg = <0x22a 0x4>;
+				bits = <2 6>;
+			};
+			cpr_efuse_init_voltage3: ivoltage3@22b {
+				reg = <0x22b 0x4>;
+				bits = <0 6>;
+			};
+			cpr_efuse_quot1: quot1@22b {
+				reg = <0x22b 0x4>;
+				bits = <6 12>;
+			};
+			cpr_efuse_quot2: quot2@22d {
+				reg = <0x22d 0x4>;
+				bits = <2 12>;
+			};
+			cpr_efuse_quot3: quot3@230 {
+				reg = <0x230 0x4>;
+				bits = <0 12>;
+			};
+			cpr_efuse_ring1: ring1@228 {
+				reg = <0x228 0x4>;
+				bits = <0 3>;
+			};
+			cpr_efuse_ring2: ring2@228 {
+				reg = <0x228 0x4>;
+				bits = <4 3>;
+			};
+			cpr_efuse_ring3: ring3@229 {
+				reg = <0x229 0x4>;
+				bits = <0 3>;
+			};
+			cpr_efuse_revision: revision@218 {
+				reg = <0x218 0x4>;
+				bits = <3 3>;
+			};
+		};
+
+		cprpd: cpr@b018000 {
+			compatible = "qcom,qcs404-cpr", "qcom,cpr";
+			reg = <0xb018000 0x1000>;
+			interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
+			vdd-apc-supply = <&pms405_s3>;
+			#power-domain-cells = <0>;
+			operating-points-v2 = <&cpr_opp_table>;
+			acc-syscon = <&tcsr>;
+
+			nvmem-cells = <&cpr_efuse_quot_offset1>,
+				<&cpr_efuse_quot_offset2>,
+				<&cpr_efuse_quot_offset3>,
+				<&cpr_efuse_init_voltage1>,
+				<&cpr_efuse_init_voltage2>,
+				<&cpr_efuse_init_voltage3>,
+				<&cpr_efuse_quot1>,
+				<&cpr_efuse_quot2>,
+				<&cpr_efuse_quot3>,
+				<&cpr_efuse_ring1>,
+				<&cpr_efuse_ring2>,
+				<&cpr_efuse_ring3>,
+				<&cpr_efuse_revision>;
+			nvmem-cell-names = "cpr_quotient_offset1",
+				"cpr_quotient_offset2",
+				"cpr_quotient_offset3",
+				"cpr_init_voltage1",
+				"cpr_init_voltage2",
+				"cpr_init_voltage3",
+				"cpr_quotient1",
+				"cpr_quotient2",
+				"cpr_quotient3",
+				"cpr_ring_osc1",
+				"cpr_ring_osc2",
+				"cpr_ring_osc3",
+				"cpr_fuse_revision";
+
+			qcom,cpr-ref-clk = <19200>;
+			qcom,cpr-timer-delay-us = <5000>;
+			qcom,cpr-timer-cons-up = <0>;
+			qcom,cpr-timer-cons-down = <2>;
+			qcom,cpr-up-threshold = <1>;
+			qcom,cpr-down-threshold = <3>;
+			qcom,cpr-idle-clocks = <15>;
+			qcom,cpr-gcnt-us = <1>;
+			qcom,vdd-apc-step-up-limit = <1>;
+			qcom,vdd-apc-step-down-limit = <1>;
+		};
+
+		cpr_opp_table: opp-table {
+			compatible = "operating-points-v2-qcom-level";
+
+			cpr_opp1: opp1 {
+				opp-level = <1>;
+				qcom,opp-fuse-level = <1>;
+				opp-hz = /bits/ 64 <1094400000>;
+			};
+			cpr_opp2: opp2 {
+				opp-level = <2>;
+				qcom,opp-fuse-level = <2>;
+				opp-hz = /bits/ 64 <1248000000>;
+			};
+			cpr_opp3: opp3 {
+				opp-level = <3>;
+				qcom,opp-fuse-level = <3>;
+				opp-hz = /bits/ 64 <1401600000>;
+			};
+		};
 	};
 
 	timer {
-- 
2.20.1

