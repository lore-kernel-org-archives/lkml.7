Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502C2C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2966F216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrRHvC78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfGEJ65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:58:57 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:45941 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfGEJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:58:54 -0400
Received: by mail-lf1-f49.google.com with SMTP id u10so5922551lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pEaC9vh6OUt5Yw3W6CBMkrWKJe0qMyPzPLc3TIBi7pI=;
        b=jrRHvC78XK7DAJD6zwlnK62gRSEHlf0dPpyGjTmrtsLKOTI5ykiwAJ2gS4gSKp5Os+
         7YXesuyWOS6hsuOM6Mogbydpjl9q9iAgilSCGS9SDdKNF4obc6aIydJMOIERx7QJHN2+
         Ie/7GiYjdnP192CwyGmgYjB/EcXEGqB+kux79S85Jr4EB7/l+oUoCSTpwGtfODWfsJUd
         suxBixSAi5iQDSg8NTpWnezRCi3Qseh0DlX+UGjns80NcxcZH2uxretW9u/cAwQ2F+r5
         SXrBulvf2fuwgLTBa0f1jTD9QUw1EsuJvbpG7cNT6zJuXpIm3b57eVcn7EfGkjxs7DEu
         Qq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pEaC9vh6OUt5Yw3W6CBMkrWKJe0qMyPzPLc3TIBi7pI=;
        b=tvT/SArihhc0Y5UgrT/OIIIovR9eXlKsTBjteLaKDqrwkaVkCLmE8CeTkLKqN1G3ZC
         zL75GW/s3M0iUfqBu074M4KB2AU5xTZ9fHxFbdoeN2sss31Z0iANpVuRmmTznawYsDjZ
         4MLWgwYqHOpKPfGQR64Od0DU142hV8+zR21kOAQmE1gduHVKVGRHSSLn6rz9AbzxVW3w
         QlwFGaCuBXfl7zg7TmpbVDonQaka5JFMWJsMsydEpBdT7b05G8HqY/+FVAdKKf3KA/bv
         VGsUpFTlqCZsaW9979kIkQNuZi6K7BLm6WXsL4OoFtuGVjfpz/0gTuMZxBuiiWnAnnvP
         Pq5Q==
X-Gm-Message-State: APjAAAVJAgbRrL1Cu9xSk+EJzsAgeu7Co96iWNIbmxhy9BuV4iOQb438
        Ywua317eDRjxVSVWboCIdawGzQ==
X-Google-Smtp-Source: APXvYqz8GpKnkffIYeWMsLMyV1KfvSkdaepOy8qDCSAJOz8BCjYEaYCSOAWxOaQx5yVUs2MO/AL71g==
X-Received: by 2002:ac2:5938:: with SMTP id v24mr1515252lfi.161.1562320731559;
        Fri, 05 Jul 2019 02:58:51 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id m5sm1152111lfa.47.2019.07.05.02.58.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:58:51 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] arm64: dts: qcom: qcs404: Add CPR and populate OPP table
Date:   Fri,  5 Jul 2019 11:57:22 +0200
Message-Id: <20190705095726.21433-12-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705095726.21433-1-niklas.cassel@linaro.org>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
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
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 145 +++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ff9198740431..5b6276c3ec42 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -38,7 +38,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		CPU1: cpu@101 {
@@ -51,7 +52,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		CPU2: cpu@102 {
@@ -64,7 +66,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		CPU3: cpu@103 {
@@ -77,7 +80,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		L2_0: l2-cache {
@@ -101,20 +105,40 @@
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
+			opp-hz = /bits/ 64 <1094400000>;
+		};
+		cpr_opp2: opp2 {
+			opp-level = <2>;
+			qcom,opp-fuse-level = <2>;
+			opp-hz = /bits/ 64 <1248000000>;
+		};
+		cpr_opp3: opp3 {
+			opp-level = <3>;
+			qcom,opp-fuse-level = <3>;
+			opp-hz = /bits/ 64 <1401600000>;
 		};
 	};
 
@@ -294,6 +318,62 @@
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
@@ -901,6 +981,55 @@
 			clock-names = "xo";
 		};
 
+		cprpd: cpr@b018000 {
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
+
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
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.21.0

