Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180272083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QugRlEE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfCVNbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:31:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38857 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfCVNbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:31:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so2366392wrm.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jfIovEfHpCgqOEUBk/fq2zpws17rw5wQZ1jxN4cAsMA=;
        b=QugRlEE//kMhL72IXnfJGGv/Wr7S7/VXNDSEUB/8jXK1n02IGjO59LEOjt2fYt57mz
         uj9gBB0m19brSCMbJRs/mtVLOi5SplAzV7oITYsImYIBBfZlajHOzMLG2vbTkaX2Pz6A
         z0eM2T7ZpJ0lI4iv7rBFwZ47pigAuilB6/WVlBuHKARjS+PxpUi/jure+l3qnWlhjzpw
         bQoIOXy9iB+Qezp3nMUo2AhJKOOzSOD9YH837m7z/gucfiodNXUSb2J/6CIg3EtvrhN8
         nMnymdhjOwBoGxA8GMtZV3m4oEVcP2oAHiMrVVgeamszceqbUwtTr8gKvgx5A8zhcLey
         CclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfIovEfHpCgqOEUBk/fq2zpws17rw5wQZ1jxN4cAsMA=;
        b=ufS8bZxxac5+5xpPlLaSSaOsUG9kHhYErVmyoTFUOuNs7LFJ/J4SO+NPmEiuFm/4aj
         1QIe11r83JfgUJTo9W8CCJDHPo/+WPoNnQ+T34mdI7wm2kKeMm0uNZ0A8mhOjy3cxbs1
         2La1AhnSpSgSmq5awA8A3hv4qK+pWycZB7sEPngqG2Ar6xxhUfln9tsp1nDfooqq6zkL
         d0wzS1w3lj563qv9AfMHJt8Y3nsxlzsIQeLdNfsSj5QbqZMllP7aar0k/7E3GNivJlFm
         Je7KakQY/lu51+5Mg9a5Jd8jIfgQnb8pnqmIEJoygxjzOh4kJrr1mUXPJHwpdpjkPd09
         zYSQ==
X-Gm-Message-State: APjAAAUvyK8To5j0+5YbStcjeJv2bG+SA2fbNUzZfCS7vQ3uqnP3Sd8v
        31Wn8aceovovqSwi/MRB8BWTvQ==
X-Google-Smtp-Source: APXvYqxY/3qLIBFz783Tddg8txhgtuhzK0gsifLBV/EJYDgmYeaV8/AR2IxiA0hdJRBloiAttm/33Q==
X-Received: by 2002:adf:e591:: with SMTP id l17mr5773548wrm.238.1553261471784;
        Fri, 22 Mar 2019 06:31:11 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o15sm4684345wrj.59.2019.03.22.06.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:31:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/4] ARM: dts: da850: add cpu node and operating points to DT
Date:   Fri, 22 Mar 2019 14:31:03 +0100
Message-Id: <20190322133105.5945-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322133105.5945-1-brgl@bgdev.pl>
References: <20190322133105.5945-1-brgl@bgdev.pl>
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

