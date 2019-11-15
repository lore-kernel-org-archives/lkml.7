Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB88C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081D320748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yG/n0v4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfKOMSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:18:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38666 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfKOMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:18:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so10477014ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 04:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GzXbFQkPrKMVsons+QpYWmVJ2fxp7Rx5snNgvCvieVY=;
        b=yG/n0v4MhRYVnb5vUXGkRi6oDV6K/u1lsPBGqqDtMe9eQPej0mbaUgAxww7zpeDK3V
         0yAsmiPtDAfY89uW8P19F6ARJ03M6WTr8BJ/Qgo82odDvha5POqGBBtsEFiek1YoOUMs
         +Rgk4MvL/tX7GyolCqh71czAJXhVeYhVCzX8tS6Ix5JvtzkB7/oxMFEz4vgV4zVHIx8D
         79iMkpCODZXATEcqCTGdIw9ICPeSxz4GUmIX5oFsZ1CuanHEQtNuISSmvmoK7zyNASvH
         aKY2eXwIDPXiv5Yn2cjuwUSmX0z/mLlKFwd8eRcaH3DBDOEQ4r3xjZqdVZN2//o/jQLk
         oNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GzXbFQkPrKMVsons+QpYWmVJ2fxp7Rx5snNgvCvieVY=;
        b=qxs8qtZlMt6xsXub8xzLHFM3+sBjlyNAzVYWcPX8LjSKxOiEFoy9tSpRcrPoGl6HOZ
         jl4eAcLjNgXebmJEYiWyVGjk0g/nx5xy6vUluoh3W6QiwsCDW64NseTa3TMt8FiTzwry
         J+PJTgm24V8HhltYeO/i3Fte+vj8h1Mnrv4MU+l9bk5ptS1kuiWtRdb5EEt5342BuQkv
         b9VVW3TglzJ8eS35X8eEvwV8opo3Df2G2VRBlG5z9GduMbfEjvvmOwdcxqny5ggt1/9J
         6S4qL5x0JRUNPZ/AmGPMJGwNgyi/0SyJH+M1JqvwWjKkKK7fJEOnYMFqk7q2kruaeobw
         ySrw==
X-Gm-Message-State: APjAAAVrXbtlJdweBED3W5qLuYuHrFnsNWTOSVq1VlzfM/cyFK1+nnU0
        XqdDU2ji6+6D3BTBBY5NqNE1JQ==
X-Google-Smtp-Source: APXvYqxJkeCD/5wb5eD1Fvas043368L7QAtHjtM9zm9+kZzqByV7eg8Jzd+QpcMMOcm4VKUxwP+C/A==
X-Received: by 2002:a2e:9659:: with SMTP id z25mr11200659ljh.132.1573820279064;
        Fri, 15 Nov 2019 04:17:59 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id c16sm331070lfp.93.2019.11.15.04.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 04:17:58 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] arm64: dts: qcom: qcs404: Add CPR and populate OPP table
Date:   Fri, 15 Nov 2019 13:15:40 +0100
Message-Id: <20191115121544.2339036-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115121544.2339036-1-niklas.cassel@linaro.org>
References: <20191115121544.2339036-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPR and populate OPP table.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 132 +++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index d03782e7bc11..30b9c7f8f200 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -44,7 +44,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cpr>;
+			power-domain-names = "cpr";
 		};
 
 		CPU1: cpu@101 {
@@ -57,7 +58,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cpr>;
+			power-domain-names = "cpr";
 		};
 
 		CPU2: cpu@102 {
@@ -70,7 +72,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cpr>;
+			power-domain-names = "cpr";
 		};
 
 		CPU3: cpu@103 {
@@ -83,7 +86,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cpr>;
+			power-domain-names = "cpr";
 		};
 
 		L2_0: l2-cache {
@@ -107,20 +111,37 @@
 	};
 
 	cpu_opp_table: cpu-opp-table {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-kryo-cpu";
 		opp-shared;
 
 		opp-1094400000 {
 			opp-hz = /bits/ 64 <1094400000>;
-			opp-microvolt = <1224000 1224000 1224000>;
+			required-opps = <&cpr_opp1>;
 		};
 		opp-1248000000 {
 			opp-hz = /bits/ 64 <1248000000>;
-			opp-microvolt = <1288000 1288000 1288000>;
+			required-opps = <&cpr_opp2>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 <1401600000>;
-			opp-microvolt = <1384000 1384000 1384000>;
+			required-opps = <&cpr_opp3>;
+		};
+	};
+
+	cpr_opp_table: cpr-opp-table {
+		compatible = "operating-points-v2-qcom-level";
+
+		cpr_opp1: opp1 {
+			opp-level = <1>;
+			qcom,opp-fuse-level = <1>;
+		};
+		cpr_opp2: opp2 {
+			opp-level = <2>;
+			qcom,opp-fuse-level = <2>;
+		};
+		cpr_opp3: opp3 {
+			opp-level = <3>;
+			qcom,opp-fuse-level = <3>;
 		};
 	};
 
@@ -310,6 +331,62 @@
 			tsens_caldata: caldata@d0 {
 				reg = <0x1f8 0x14>;
 			};
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
 		};
 
 		rng: rng@e3000 {
@@ -952,6 +1029,45 @@
 			clocks = <&sleep_clk>;
 		};
 
+		cpr: power-controller@b018000 {
+			compatible = "qcom,qcs404-cpr", "qcom,cpr";
+			reg = <0x0b018000 0x1000>;
+			interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&xo_board>;
+			clock-names = "ref";
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
+		};
+
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.23.0

