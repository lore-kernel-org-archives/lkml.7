Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92910C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BFB218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uC1w7In2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfCUOKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:10:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54787 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:10:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so2918408wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jfIovEfHpCgqOEUBk/fq2zpws17rw5wQZ1jxN4cAsMA=;
        b=uC1w7In23JDSckIbYALpbUQJVxsXPN1JNyf2zP2ZQSPvMOz5d4bbBIRwKJbrfeOhJ0
         fKHZQnZAkARLDAUz/PodhpTW57hiKbK/gqFMc3NmgAs6KclseGPpyyqd4zNZ9I8TBOFr
         YRdEyr+KMmfC9jpMdo47b+CjdSdvLe9GNw1vLUJcwxI1FDdYFSD0eHqH9BuanWEEK4cq
         Ar3MAU+gAtE1hW3ATaSfygKgmY4Sr4k4mPQVU++1JO+ucdU795N6QPY3A3/5BjiRtVm0
         N3TGQwnM9z9WmA7JDEJcMeSVMX7XjhdCjV5Cc6/pYhyI94cIbRRi3Fv4beagUENd7B9O
         VcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfIovEfHpCgqOEUBk/fq2zpws17rw5wQZ1jxN4cAsMA=;
        b=jR7f2GJpBoF+oEWoxVgqNkITj13xwqCiCTDoBA4XuHIueUI3VDCxQZj2BOBUVpCkEE
         m7OdyEQKA18sworjep9Snppn/P+G2RDpglqim4QPM+eKpbTCo79i89oWJ2WGm/JwpxBm
         ncPwuq5GuZ2YUgtk8vei/39l5uDJW6vYGZVASL46Ppq0Z6rMYeUQejq/yx9g95CG5M9a
         6FxIO/CtVy1L0Uo+JPIQhFPcIx/JuIMYUJP3ev4K+XBMt64mnv2Zuc/W9qg9Jc2B2QMM
         /Dfxlv+ygsLR/6Av8uO1oJaXgC3bgmtJWQWy3HN7U2j26UD61fW+UVKNpjeCRRe6O23q
         ug4w==
X-Gm-Message-State: APjAAAXbg6gqcoYbaAXHzB35O01TIA4xiUp2rvajerhap3aHiqrJB6fA
        P7525ikPb1vj+6pySDknFM+Z0Q==
X-Google-Smtp-Source: APXvYqw4hHA+v9pYN6BzrhewCIRCO3+yVVk29YgWW5nU8DsrcUJ7RfbT9sMbZwdJdUHejps86UFMIQ==
X-Received: by 2002:a1c:1b10:: with SMTP id b16mr2789761wmb.90.1553177418018;
        Thu, 21 Mar 2019 07:10:18 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-20-74.w90-86.abo.wanadoo.fr. [90.86.223.74])
        by smtp.gmail.com with ESMTPSA id z14sm7513921wrv.78.2019.03.21.07.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:10:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/4] ARM: dts: da850: add cpu node and operating points to DT
Date:   Thu, 21 Mar 2019 15:10:08 +0100
Message-Id: <20190321141010.19612-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321141010.19612-1-brgl@bgdev.pl>
References: <20190321141010.19612-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

This adds a cpu node and operating points to the common da850.dtsi file.

Additionally, a regulator is added to the LEGO EV3 board along with
some board-specific CPU configuration.

Regulators need to be hooked up on other boards to get them working.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts     | 31 +++++++++++++++
 arch/arm/boot/dts/da850-lego-ev3.dts | 30 +++++++++++++++
 arch/arm/boot/dts/da850.dtsi         | 56 ++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 26f453dc8370..f29ed9010812 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -155,12 +155,43 @@
 			};
 		};
 	};
+
+	cvdd: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "cvdd";
+		regulator-min-microvolt = <1300000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &ref_clk {
 	clock-frequency = <24000000>;
 };
 
+&cpu {
+	cpu-supply = <&cvdd>;
+};
+
+/* LCDK has a fixed CVDD of 1.3V, so only op points >= 300MHz are valid */
+
+&opp_100 {
+	status = "disabled";
+};
+
+&opp_200 {
+	status = "disabled";
+};
+
+&opp_375 {
+	status = "okay";
+};
+
+&opp_456 {
+	status = "okay";
+};
+
 &pmx_core {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index 66fcadf0ba91..553717f84483 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -125,6 +125,15 @@
 		amp-supply = <&amp>;
 	};
 
+	cvdd: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "cvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	/*
 	 * This is a 5V current limiting regulator that is shared by USB,
 	 * the sensor (input) ports, the motor (output) ports and the A/DC.
@@ -204,6 +213,27 @@
 	clock-frequency = <24000000>;
 };
 
+&cpu {
+	cpu-supply = <&cvdd>;
+};
+
+/* since we have a fixed regulator, we can't run at these points */
+&opp_100 {
+	status = "disabled";
+};
+
+&opp_200 {
+	status = "disabled";
+};
+
+/*
+ * The SoC is actually the 456MHz version, but because of the fixed regulator
+ * This is the fastest we can go.
+ */
+&opp_375 {
+	status = "okay";
+};
+
 &pmx_core {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 559659b399d0..ee61d1253b58 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -20,6 +20,62 @@
 		reg = <0xc0000000 0x0>;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu: cpu@0 {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+			reg = <0>;
+			clocks = <&psc0 14>;
+			operating-points-v2 = <&opp_table>;
+		};
+	};
+
+	opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp_100: opp100-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1000000 950000 1050000>;
+		};
+
+		opp_200: opp110-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1100000 1050000 1160000>;
+		};
+
+		opp_300: opp120-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1200000 1140000 1320000>;
+		};
+
+		/*
+		 * Original silicon was 300MHz max, so higher frequencies
+		 * need to be enabled on a per-board basis if the chip is
+		 * capable.
+		 */
+
+		opp_375: opp120-375000000 {
+			status = "disabled";
+			opp-hz = /bits/ 64 <375000000>;
+			opp-microvolt = <1200000 1140000 1320000>;
+		};
+
+		opp_415: opp130-415000000 {
+			status = "disabled";
+			opp-hz = /bits/ 64 <415000000>;
+			opp-microvolt = <1300000 1250000 1350000>;
+		};
+
+		opp_456: opp130-456000000 {
+			status = "disabled";
+			opp-hz = /bits/ 64 <456000000>;
+			opp-microvolt = <1300000 1250000 1350000>;
+		};
+	};
+
 	arm {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.20.1

