Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44EAC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710D52148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH1QftuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfDHPYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:24:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39651 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbfDHPYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:24:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so15184728wmk.4;
        Mon, 08 Apr 2019 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cB4Fci5+eL0F4v750BTPYK26hGatMmqEXWw5wIknh0A=;
        b=kH1QftuVaiiU9HLhJKeV/h4klkXyIGtyMWhx1+50jXJwLYNMFhLabFR+P+Blphivt/
         fOT0sDfcQ6GU/FwgZrCffktPGtRIvCa7DBAjdvHMqvL3gIsiCexffl2cFp4pC1ySMrj+
         e9RKUho1+9h73afNa819Md0KHdM2jTGfRszSVMF1KMKKYEmbSOFdWyGw0S86Hl9kXTIt
         jax8WLwpdpjwr2OgoIaJO/4hQhMETnX2VLgdyXQJmcXfVyqR90fURENwLlmN4a/a5CFY
         gEjnIzsZM4XLpj3G/Elhogaz1f8L3uO+CH0VDSXCjRJru06XXamOV0zHO/JbG42mcwkL
         SrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cB4Fci5+eL0F4v750BTPYK26hGatMmqEXWw5wIknh0A=;
        b=ouqaWWkjsydJ1bJ8PHDhSU0yAMbW8lMDfbt7TEIx3QdZitua0P2HblhKokzjTFxUWu
         ljvSnGufhBHN8ZJjd8zZcUaZoke4XIf6LMj1I5Kkj9Q6Ap62lbn3GeqhSyPPrbAoymiu
         4kY6g/oHnMCGlwvnW3kPUsNFKWkr2WAquU5V6kNvP8lUOagtAa6JYB2QhN2yGL66ePQ6
         FH9mwFOywJ2TfbD8XiqF0gj4piIQFesgRMTV7AXIJ+DHTocOFjPMrBttdXTvQAONdNF2
         RtBKSPNl9aAtcD6LgwfN7ttY1+4GV8eLCgTq5AtrMVMGomS3s9V7dXYw5qyCQkBmjOs9
         tVCQ==
X-Gm-Message-State: APjAAAWHxfLfPLz8TOTy262SKpL8ytn49kzYvFJPr/x3PYAhmPLeMSQi
        gXAYeC+sggPBZpw+3HU5mDo=
X-Google-Smtp-Source: APXvYqyE9wy7qewcLtZEME4GJm/MGk68UROTEk+M7tC6zUI4IkkjP6uc09Dmf1rs7Tm+nyjUDSRllA==
X-Received: by 2002:a1c:9ec7:: with SMTP id h190mr18940785wme.105.1554737073625;
        Mon, 08 Apr 2019 08:24:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id o12sm32137298wrx.92.2019.04.08.08.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:24:32 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 1/6] arm64: dts: allwinner: h6: move MMC pinctrl to dtsi
Date:   Mon,  8 Apr 2019 17:27:50 +0200
Message-Id: <20190408152755.17405-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408152755.17405-1-peron.clem@gmail.com>
References: <20190408152755.17405-1-peron.clem@gmail.com>
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
index 3e4bb0b0de69..e0dc4a05c1ba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -278,6 +278,8 @@
 			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -306,6 +308,8 @@
 			resets = <&ccu RST_BUS_MMC2>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc2_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.17.1

