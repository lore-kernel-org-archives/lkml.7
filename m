Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B3CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1A020883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rxyG/Xbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfE0NWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36159 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfE0NWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so16951714wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B15kJiNx0gB5GZgy154+cF2VY43Rpy+WChAQDJEB4z4=;
        b=rxyG/XbxOY9xO0y8sz7iyV/GR+qomMOMyrjb46om9LbLfzHg+biOdo3QrM6hV19Wye
         2RDnWMDDZXA2XaWC+ixE+k79juVBbkN9/GqFFk/x/Nyyr3G3l8ALH3meaEZAotFvrElm
         BPz7tcSanuoSSu60aB755pCVvWBjgcaxfQWa6kWkVk5Nffcn87IzYwzFZYZG9Pm1bU5j
         zdDsKtxX9Db3wfQTAPOE0KjSNjwhQzXlnDmBL4WOpgVJA3LUOWcscEeM3ooZUKWnfr4J
         b+aa7hPn5TEA9MxVjJk6ZTUeKFZx6AJn8AhKbnC9ij52i6wQdgCZ3yKUiVzyda02xbom
         dIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B15kJiNx0gB5GZgy154+cF2VY43Rpy+WChAQDJEB4z4=;
        b=Zj29FxnM9KIIHi2IEkrnPxxp/RM7wkPsb7YZZmHTOlWgJnXc7Pzqlmq+bAGfBTvGcX
         85COfhoE8TNtcykHhcDJHTaRVTbzia66D2C2GSNcTUvVwN7WYV6RgfU1Mz487ErT9kEN
         Ti1+7ine+Er+he3uMjWpjzLoq36G2Ie/no/7yldP+HvaBOrVmeU1nfduAeiwyxj1gZlI
         l0VaVA/289scA+XdGobckJhrfp/wCjh0ZiFIkSe9OnTBaypg8Zi5+/DRl2MWD26BZpUq
         sex0GAL4ho9p8kf9vNpNdHVFKeViw2HZlMzvdV4QFiCuVUiep/tg/4O638EfjWeRerJ7
         gBqg==
X-Gm-Message-State: APjAAAXpuGDFrOZ9KcGw7SN3jdiAIX7C3oKIIM4s6l7g4bI9aMd3LzTr
        U3YelIOXzj4w4sNDN+xQW2SSwQ==
X-Google-Smtp-Source: APXvYqwNQZvfpu+TITjMJMn64RyU9BPmMPPPawWMAjqT5Dub5Vb5xePuM97dcekNw6lWKErVTVOkFA==
X-Received: by 2002:adf:e30d:: with SMTP id b13mr58410891wrj.246.1558963326793;
        Mon, 27 May 2019 06:22:06 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: [PATCH 05/10] arm64: dts: meson-gxbb-vega-s95: fix regulators
Date:   Mon, 27 May 2019 15:21:55 +0200
Message-Id: <20190527132200.17377-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the regulator names with other GXBB SoCS for upcoming
SARADC support and SDIO/SDCard fixes.
Also fix how regulators are passed to MMC controllers & USB.

Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 623bcb6594b1..760730d4e87b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -28,10 +28,10 @@
 		};
 	};
 
-	usb_vbus: regulator-usb0-vbus {
+	usb_pwr: regulator-usb-pwrs {
 		compatible = "regulator-fixed";
 
-		regulator-name = "USB0_VBUS";
+		regulator-name = "USB_PWR";
 
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
@@ -40,18 +40,25 @@
 		enable-active-high;
 	};
 
-	vcc_3v3: regulator-vcc_3v3 {
+	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
-		regulator-name = "VCC_3V3";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
 
-	vcc_1v8: regulator-vcc_1v8 {
+	vcc_3v3: regulator-vcc_3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "VCC_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 	};
 
 	emmc_pwrseq: emmc-pwrseq {
@@ -133,8 +140,8 @@
 
 	mmc-pwrseq = <&sdio_pwrseq>;
 
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&vcc_1v8>;
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddio_boot>;
 
 	brcmf: wifi@1 {
 		reg = <1>;
@@ -156,7 +163,8 @@
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
-	vmmc-supply = <&vcc_3v3>;
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vcc_3v3>;
 };
 
 /* eMMC */
@@ -176,7 +184,7 @@
 
 	mmc-pwrseq = <&emmc_pwrseq>;
 	vmmc-supply = <&vcc_3v3>;
-	vmmcq-sumpply = <&vcc_1v8>;
+	vqmmc-supply = <&vddio_boot>;
 };
 
 &uart_AO {
@@ -187,7 +195,7 @@
 
 &usb0_phy {
 	status = "okay";
-	phy-supply = <&usb_vbus>;
+	phy-supply = <&usb_pwr>;
 };
 
 &usb1_phy {
-- 
2.21.0

