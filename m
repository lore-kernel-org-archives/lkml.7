Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0985C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF0320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbTNQPj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfDHJWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:22:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46458 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:22:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so15390690wrw.13;
        Mon, 08 Apr 2019 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Drmj5S812DhG9xDTRVR1/a4G8d/V4pYo2Se3iooGie8=;
        b=CbTNQPj45q22p425ENMWn1WxVFuNgOK5Gs5pLSjCyeJndWPW3qG8J4ZhgOnPP3XF3U
         UlCdr3GgnjyzlqgC0HJ4Ugs6P6tkrwcHQ81sYTlCUfP5kgE9SlHV2PkoCagW1OwQHRHN
         ZZRpMHEdqV+KzRBKMPwSU4u6f3cLgXmOOwJlkjjgYfsWCeUTMEry+vZ/I51k+gOqbl3V
         U3o40BPa4xxH5BnPJgsofh9SaXmOkTiKsgjClw44+/ipSth2k8Z0Kcfvc+mYc4hktqaM
         +aTN1z4rdZ16A/UgmHYTuwLF4sKVdBwVZ7AZkXNsuH7kRvX9kK+gPJ4+e8Lovxili8jJ
         biog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Drmj5S812DhG9xDTRVR1/a4G8d/V4pYo2Se3iooGie8=;
        b=NzTTZgvIOMG9MZlBhG5WwfwCuKqO7rXTJmrrGOj/LhvHMFGMP6+MbRTgrMsqu8kE+/
         iFp8xbSU3bI8B2N/aHxp/reH7UazCmF4Fep9b+MtUd/WS4//HSXZ5zZbu7aO54xxZzjh
         bzLm8uQrXUWebtOlYttE0iklDkXZIwS4fX7a/Q3RbtieUFT1+eVCQBRSBzfsmeSD0anU
         APFrD5QSTttqQtu2Y8mJsAjjvDd9CEswipCGuomJLVkR+fK5cp0Lg765rCiuzG0tlPcH
         5Rwo0FbkGu+JykHpVjRf6mqLD57LQSb+IZVBwIk8zGTgaFYWb0F4W4wexAymhogjmbmb
         mEig==
X-Gm-Message-State: APjAAAVKTrgsQkcA1z3nIuYps7gFzwVj0gKVKP3PNfzyxe5CbHbXvvo8
        ya9ZKqTfpPNrpQbdykcwMNs=
X-Google-Smtp-Source: APXvYqwrxsNX9lGuylAJU7kOwTOeHTGI2UiZjzsTuTnrofREbDGXCuUO50AR41rHkGESyBzaAGfaHw==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr19241410wrn.29.1554715348360;
        Mon, 08 Apr 2019 02:22:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id u17sm22671883wmu.36.2019.04.08.02.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 02:22:27 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 1/6] arm64: dts: allwinner: h6: move MMC pinctrl to dtsi
Date:   Mon,  8 Apr 2019 11:26:14 +0200
Message-Id: <20190408092619.23152-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408092619.23152-1-peron.clem@gmail.com>
References: <20190408092619.23152-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one pinmuxing available for each MMC controller.

Move the pinctrl to the SOC

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts  | 4 ----
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi          | 4 ++++
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index b2526dac2fcf..62e27948a3fa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -56,8 +56,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index bdb8470fc8dc..4802902e128f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -104,8 +104,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
@@ -113,8 +111,6 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_cldo1>;
 	vqmmc-supply = <&reg_bldo2>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 3e4bb0b0de69..006d3b6418af 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -278,6 +278,8 @@
 			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		        pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -306,6 +308,8 @@
 			resets = <&ccu RST_BUS_MMC2>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.17.1

