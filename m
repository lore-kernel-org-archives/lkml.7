Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A52C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB25520883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WsFoC+BP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDHH7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:59:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53990 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfDHH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:59:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so13139610wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oco+RqLjRDLjReN+OS1UN1Z5Z9iWM/GxVr51ER1fU8o=;
        b=WsFoC+BPiBGxQAtIvxBqWVRBNqIF9Ua/nKMgxcXLP3hDT/VyVphJmb93BMZ9x2Cb2I
         5OegoyFxbhvoQL+HTqWp0l3ms4/yauCihDE7q6F0fHZ5hRhwco/68tnY46/hcAf6y212
         Bb3j2VwGKTrWg3SCLgJ1Pb30IJfZymrFnKpfRRGxJ4KrttUTHXpzjB1pdQjwYhT4EZ6b
         QBlvnQ4uBbcgnNru+chF5x3UQ2SfBNeqhJewNvC/3HqPLtkjGqxcZptv5T7ToV+rDog1
         z7huTecS63wIn6I8n6x32VF159RuLJHwZc1TU5tuHjczAK/E2TYNwf/0WFuHNhoNxK6B
         YHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oco+RqLjRDLjReN+OS1UN1Z5Z9iWM/GxVr51ER1fU8o=;
        b=IYCrBmqWFaq9zeE4zYcAiU4p2ZQBH2pkCFbDSvEZ0yE57wL7r5nLiU6FYNKTml3GxS
         QC2Dgbf0VmmBlup3wvZHLkmbgb7qyOfGZVVoRVqkGObEv6MVcxFKsJ5/9Tu3aj0bnULN
         /f6WKt3SDluxPNJOyZqusZaL2T16URz8rO5oo6M/d7QgVmXg1ozLtpFld0j05Vfili5J
         0c1bEXP8lo0bRccsvV7X+Up5cpDLX9SJtHHaG3jsz2SsPpJEOMGvabvgaY03n19aNi4i
         T1dUo2H7LAZ9PvTpO3gZFREhaahQJFhO1vEU+/FyoSOb4JzLhdmwuVd8IzI7Joj91Bqx
         igDA==
X-Gm-Message-State: APjAAAW+c1HrJEmypYY+zPtypZLhZ8Sc1q5pxeBMGJpueJTjhAUDDL8Y
        fLaJznCdLySAaxj0dGBgGFALDg==
X-Google-Smtp-Source: APXvYqyy8aO8xuKv7QnEi6O1UQNPwS4TjFBnCEjxuMdR1k2QxJA668r04Puk17v3sbZ29Vhya+Y9qQ==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr17463267wma.40.1554710373954;
        Mon, 08 Apr 2019 00:59:33 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-12-194.w90-86.abo.wanadoo.fr. [90.86.215.194])
        by smtp.gmail.com with ESMTPSA id o17sm31658711wrw.73.2019.04.08.00.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 00:59:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points to DT
Date:   Mon,  8 Apr 2019 09:59:22 +0200
Message-Id: <20190408075924.2284-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408075924.2284-1-brgl@bgdev.pl>
References: <20190408075924.2284-1-brgl@bgdev.pl>
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
2.21.0

