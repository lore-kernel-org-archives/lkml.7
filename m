Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12655C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D271F20652
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gjA8tgi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbfDQP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:27:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33247 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:27:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so4904643wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6d+R1BA43CR6//FSBQc7Q2qw1KEWApHiN8cbRKfTm8=;
        b=gjA8tgi3EC0qRbECr8Cct+TmYC5CMjj/GgU2OF86G8Y7rItYg8M34zayAY00WG6/iV
         S/n2o82YcarsmAtaVWAWaSYJMtC3pvDv27iA7MJ7Tzt0oYhWvKiSmP9ndCLrDIxzFkxa
         OtamkC9HMF7tHkfH9ZL+4OsoN95x6ZzyjzzA/dnJBPAw4LbhU5E4O/nA4biYe6XyUM9g
         MVM+WM8p664K1b5odzTZkvVBkgY/YhHTST0Q8AqmqVNMkDbPhXR1+HPAwiUHA/WBQQ7Q
         OU1xvPD/fdSHfokeXn4YmJpQ12bs/67Vq4WB5qW+GlJ/aSSBWHMc3YuHezHHMJc0d2UC
         JCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6d+R1BA43CR6//FSBQc7Q2qw1KEWApHiN8cbRKfTm8=;
        b=hWTw9vQ20Jv+WtXgPd8dvzkQJyvSjidRF2NSaEtQTez9OB4bOsOrtdg1LIEDfWbypW
         1sV7lie7kiPa4B/Uatjtpr+YuGCMRYb8z2a6DqzdZOi4bcrE4PeTwV30Ga/447m1z/Pm
         P0g/JNabk1zTOf7Irq4SMNRH3jTGxYzKD3dQ/h2LxJnsIRqEojtgc2I2x2f0KwjyHRvh
         9EroN0p9cQ4bUcjz+Rgd3dgsvHFDBdeKn9gbmDkYI63ypqm08bblyfVIbOKTt6/ZKJGf
         VwVvtfx7qRap5klnHgrrY0jcWEarHztQuHJu6PgGH5DY/pMS4IzmFdVbHY13R10k1yFf
         oXFw==
X-Gm-Message-State: APjAAAUSPPrOohVEDk3rwcNCTLBJjqyYOm3uY+GVEaK5ggNm1tbTjqfF
        e7mWuMqE0TOfNDcJqMfTGacOhg==
X-Google-Smtp-Source: APXvYqySHwHgtYV5A+bNAPIDIorcQDJ/an877+CTZrwmYfJX4K9jthTIVnRrsepE93cHfNfnfalQ6Q==
X-Received: by 2002:a1c:c18d:: with SMTP id r135mr30812979wmf.112.1555514827085;
        Wed, 17 Apr 2019 08:27:07 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-15-216.w90-86.abo.wanadoo.fr. [90.86.218.216])
        by smtp.gmail.com with ESMTPSA id v16sm75478817wru.76.2019.04.17.08.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:27:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 1/5] ARM: dts: da850: add cpu node and operating points to DT
Date:   Wed, 17 Apr 2019 17:26:57 +0200
Message-Id: <20190417152701.23391-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417152701.23391-1-brgl@bgdev.pl>
References: <20190417152701.23391-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

This adds a cpu node and operating points to the common da850.dtsi file.

All operating points above 300MHz are disabled by default.

Regulators need to be hooked up on a per-board basis.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 559659b399d0..0c9a8e78f748 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -20,6 +20,56 @@
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

