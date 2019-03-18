Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB33C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED152070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xZG2wIbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfCRKFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41929 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfCRKFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1so16281409wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyTVu6y/dDbn/Kx5YTVNiJNMsZW+Ml6FfRobJ2/iYLI=;
        b=xZG2wIblReXElzEDHMFnQ7bJBSuztu9HpMItiJxKZB+hvG9Wqv+hpUUnxBSPUwkNgX
         9CV0gNDrFhnnFgIEcOCTafjXcTtCP5WXecsQzw+t9/7SRTVb5JKQFYreeTevDZ1I1h0a
         vXXDwIpnXynG3TK/vwjyCU3TVRW/nqAXJ1rVQBt+XfQuYjgLETgrXLOnvZDrvFaKCt2y
         qEYYIEKiMxHfHkW86rWg4Dwh7k6JY3LKfu47dpW9OOi3RIWmR2YyNNEPGa5LtCFTQgm1
         4ilEAJ6Ukm9rhkPHRMjcA4UGs1WeVPpyHRsTzjYARKLyLaYmY2RgvQeaIb2Vx5T0XGNK
         MFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyTVu6y/dDbn/Kx5YTVNiJNMsZW+Ml6FfRobJ2/iYLI=;
        b=jycJMkRXqg/tUmoLnUvh+R5Tf6scs9om3O1e8rVnOVvCrJOxUB0nxsGd1OV5wCPMJG
         6WcHjr95ne8tNyAvjoO0ewcwpYlFUx3n2gzPUjohurFuQk6QLnLOLfTVjQ7zPHN+enqd
         z8qGQB4bE9QLgvhfizXIAEHwg3epFbN5CXK0DexwKiFdAbz7VWoObEWxCghPDQmSU+x4
         IshtvRZMmHGrjEaU8+bqp+2RVQsGHAR1XM4Tq3gFFLFF3HfpptJ6ZvWxv3pCIh2ZEOMC
         U0Ufa1+YIr+5aIWBVxTmNFlVUhR3goklzvqkOkp2M/pV7vW90or4bB2aA560GXWqjn5U
         aicw==
X-Gm-Message-State: APjAAAX55Ra8UjEiRlBPm+y/Zcxwpfp2EakBHyE2Vmk/cabh4bGt1JfF
        dG0dLFOwB03qK1nnHgAcbPhVgQ==
X-Google-Smtp-Source: APXvYqxTf4ES755Gsyz1mPIIMFjVm3ZD0yffSU/KrzviME+s8xa+NaPc4ZzzOkBBP+InTNFra4nMFw==
X-Received: by 2002:adf:e2ca:: with SMTP id d10mr11057150wrj.250.1552903506042;
        Mon, 18 Mar 2019 03:05:06 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 06/11] arm64: dts: meson-g12a-x96-max: add regulators
Date:   Mon, 18 Mar 2019 11:04:53 +0100
Message-Id: <20190318100458.5619-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume La Roque <glaroque@baylibre.com>

Add system regulators for the X96 Max Set-Top-Box.

Still missing
* VDD_EE (0.8V - PWM controlled)
* VDD_CPU (PWM controlled)

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 0edbd00b358f..5c37930b09e2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 
 #include "meson-g12a.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
 
 / {
 	compatible = "amediatech,x96-max", "amlogic,u200", "amlogic,g12a";
@@ -21,6 +23,71 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	flash_1v8: regulator-flash_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "FLASH_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	dc_in: regulator-dc_in {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_IN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	vcc_1v8: regulator-vcc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+		/* FIXME: actually controlled by VDDCPU_B_EN */
+	};
+
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_in>;
+
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+	};
+
+	vddao_1v8: regulator-vddao_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_in>;
+		regulator-always-on;
+	};
 };
 
 &uart_AO {
-- 
2.20.1

