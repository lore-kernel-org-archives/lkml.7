Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCBE20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D9n9W/Wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfCYKPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:15:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42510 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbfCYKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:14:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so5897578wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mONwxENhpKvTTQwCoB1Esyjq9hiq9z607IfSptpkVMk=;
        b=D9n9W/WrhVnLyL14ZrVWWRMVU7NxLkg4o76ElZp6yLWBsLpiC26p5JWjtySyUyh3v1
         +tsIdKdw1UWSZNG+dBtb3nqWgikFvBVS8cH/sTeFTYWimpv+RgvfV8csX8RwXAppaEcW
         EGvNVHe6Dp7ZawdRJcR2JM/i6a/vWXZbqCypp/8/fBQuRQ1PR6BZYBLSOzd8ofNhJQDT
         iOKuupwE6xe2HEscaa7jhxLzv+CIXb5e8b4WIQIdve6Q8RKfugFYcpBSqNgwk631FuEc
         lRJ6zowts3tEWXtdUHq0eHsKYKJaQ4lv9YM+PhS8KsvM1vxIuMFkpOZLr3PMTRsy8gWJ
         HWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mONwxENhpKvTTQwCoB1Esyjq9hiq9z607IfSptpkVMk=;
        b=otb4YfpA/y68PeGQ1WkQrR5trKa3KIJ+/2H+PA+DO0c+jnVkVgznwYOKsekCKUHC0L
         DgsvkDjnmjjJ07oSouJzoEJXiHILzbVBZJ2zU49ilBezNVvDZ6OUtszYNXngphyNQboi
         22wvEYQN8YaqJdjCGBmBC0wlX6kPoLdhx4amcVO1zDvnvUmc85CYsZeTABKyaSmH6xfN
         kgascQegoJlBSIULFM0J9ikRshruDf6seSwTIZqIlGwmdAK8tY7czCpgT3SmPX39qHBJ
         jP/XlMNwLAVIeStTMqwjM+pprJQ3ySyJu5kpYGTGt+O3DCgkRu5kiFEyIfda6nguE7Sz
         tU+w==
X-Gm-Message-State: APjAAAXqfAf6FoR8dgQzk0rHpr2chb9N+0d+/u59daYH4giykglwc/bk
        W1hwwtE+GMICnxIQMGKExS52rHgdTTH7VQ==
X-Google-Smtp-Source: APXvYqwY6vtF1bLLpkIF8ZiE5nBSl9EjUTCXx3wj95kqnSeBvfs2nPQ312T+uvVklUxQjj3p2kR9Gw==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr11531637wru.36.1553508896881;
        Mon, 25 Mar 2019 03:14:56 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v14sm20049484wrr.20.2019.03.25.03.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:14:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 1/6] arm64: dts: meson-g12a-x96-max: add regulators
Date:   Mon, 25 Mar 2019 11:14:48 +0100
Message-Id: <20190325101453.3009-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325101453.3009-1-narmstrong@baylibre.com>
References: <20190325101453.3009-1-narmstrong@baylibre.com>
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
index 0edbd00b358f..0ba28491e2b0 100644
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
+		enable-active-low;
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
2.21.0

