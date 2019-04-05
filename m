Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA3EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E04218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQQzlQ8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfDEMVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:21:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55661 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEMVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:21:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so6424813wmf.5;
        Fri, 05 Apr 2019 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46RvsyQgP1RoEDvMsSxeDBpDPAwvdLggPdqx+sYXb44=;
        b=NQQzlQ8oyurLiGvOc61xEPIn51/EvKDwEOAvsDNP+efWcFg+ctcAnS+cvTjLuZRcH7
         9q3MO5/nwCkGyRp1JlvbOi/jGJLqmFa1o6+WMDszEm5Osv88+WLsJE8jFVCz+af38CUD
         Tjj+MT963zmPTaOsGkn0KacHj5NHRbfJHJQIibyVvl9emxSRcuWJo+O+w2knW98moT9q
         wyQSr2wz2a0pUmkUORkqy1gRU5xemS9nknvXZw5jPokYso4fyXnVASWqf7yrq9/UhOO0
         fyAfd5+ZLHeSoJ4zlghC/cYdX/Jg5nRMcvJo9tg8DOBH0jCqDrbipFUILURP8eAnGbIk
         YwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46RvsyQgP1RoEDvMsSxeDBpDPAwvdLggPdqx+sYXb44=;
        b=RD2tjW5yIIhFOvSXoiTVV6Aa7qivRWG/u4jQVWWlJYinzVVljhjZFEGv/R95o+RJCL
         giUbbb/mcIDRcqu4t0YM4umhdeGyeGGcs3bO1hvWt8tYr49sIlcvD5K5INpWIhcv0Qmg
         8VesznAlLpUKdbYoZdgCjjg8ToX+tElLOveTacUfuUkD+y2jR25zuH/eZFyyeSdD+fve
         iKhKauR4MXjS4uh9hPT3slD+HmZ9PVxFZ42BvSxADgsssm4YMYXo25AZEfB1NE5iYWP4
         BvlGWAGmQLNU/3ccwa43Vu5fXPvLua6elX7C6/TMGL4duNCLSwQH0XLK0Y/eUacZqOKI
         q99g==
X-Gm-Message-State: APjAAAXz2c3gf8EL5uj1ioG6YKszmdomLablEgFbwlrVk2emy1j5Ltwz
        B83cYRHotCeerPtK1uJ1Iwg=
X-Google-Smtp-Source: APXvYqzZ5a6WYpRpoQoWqoIhCv/0zlpQ1ls75qK7dcAgY2AfvMIwJnoGYprxE1RPlvSBNLCOrAq2EA==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr7923762wmh.128.1554466893353;
        Fri, 05 Apr 2019 05:21:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id d14sm34454123wro.79.2019.04.05.05.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 05:21:32 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 3/5] arm64: dts: allwinner: h6: move MMC pinctrl to dtsi
Date:   Fri,  5 Apr 2019 14:24:44 +0200
Message-Id: <20190405122446.2101-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405122446.2101-1-peron.clem@gmail.com>
References: <20190405122446.2101-1-peron.clem@gmail.com>
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
index fd2af5095425..88b3a13f2360 100644
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
index 8b0b7675a53c..d8b0138be3d6 100644
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
index 91fecab58836..93ad756c0c95 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -273,6 +273,8 @@
 			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		        pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -301,6 +303,8 @@
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

