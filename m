Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ADAC2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720B824679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOCQ5mBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLFSqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:46:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33236 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfLFSqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:46:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13so2448155pls.0;
        Fri, 06 Dec 2019 10:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4bdwKxSNWK5BWyINk+HzQDIpWu/B7jQUeXjA7APZjo=;
        b=IOCQ5mBXyjWFkS9TXSjGOveAENAla9ESYZ31r9Dl5jS1b79zs6xWdWHPqRd3SrMYZ3
         zS2NpLOfp78BhgDBgxoonulFW6d3D8Z49rjbTdkVHlJJbs6oi3xs8OeXG3YnYvcuycVF
         dWVBUlS6oeXzDhpGo5gL7Smot5DTl7FPevplwDVWDzVMwiXc4rOoLfjd0n/r4AnmBpwK
         nmXGwrJ2zZfxNbMuEx/o/93cLfFfTVCPLv8EZak41xG1NI4ZgY+N/XN2DcTJt73pUFZz
         eJc2E1TTNasw/oF0SXNaFvmlWpsATITaYZu9tcs3K0Ja3KD/BQgE7TxmO++P3Qmd9g+U
         VtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4bdwKxSNWK5BWyINk+HzQDIpWu/B7jQUeXjA7APZjo=;
        b=kQKebqmGIthT45XZK3YIEkS0XoEvsmJDyPDUYuOsb4RBSBmsTJf9rSaQwkz3VqJC9V
         1tz+x8RY4gPaagr7CgTN9p7DTJihR+8mZXjuo+n/x/zbabdcIDEu1cjuZXdaba6lgNUH
         CxLZKD5yQUv5RuCJ5fE4HJ6Dzh8weg/Ssl9KjJcCIt2HpdsipJc7QOfySsBaJ4bQKSSt
         z+biXFiloRgn88WDKDHHo+2FLGhkGzaQeYrkmb/QZv6mAgF2uSmP5bgmk97dVaOEapNg
         1TN2XwAZgJElr46vqzQugjAa7Ut3IHczeDRAn4czFSpjDd3WP0D9LBHhAOUoIoshIFZd
         JDpw==
X-Gm-Message-State: APjAAAWYmoVzVEQAcc1qB21ufCMJ/WdlupVEImsWul3fAuQ2LXkNfGZl
        CSmkBiF7NIy1N97bpZSVtDY=
X-Google-Smtp-Source: APXvYqzAkqk6sls+s4gxGmJzuU/fKCFRgPpC70mSrT4+p2kE5yngx2IgoEvSFws63kxG4p373fzh1w==
X-Received: by 2002:a17:90a:a48c:: with SMTP id z12mr17312557pjp.38.1575658006227;
        Fri, 06 Dec 2019 10:46:46 -0800 (PST)
Received: from localhost.localdomain ([103.51.73.190])
        by smtp.gmail.com with ESMTPSA id p4sm16777039pfb.157.2019.12.06.10.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 10:46:45 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 8/8] arm: rockchip: drop unused field from rk8xx i2c node
Date:   Fri,  6 Dec 2019 18:45:36 +0000
Message-Id: <20191206184536.2507-9-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206184536.2507-1-linux.amoon@gmail.com>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unused rockchip,system-power-controller from rk8xx
i2c node.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/rk3036-kylin.dts        | 1 -
 arch/arm/boot/dts/rk3188-px3-evb.dts      | 1 -
 arch/arm/boot/dts/rk3288-evb-rk808.dts    | 1 -
 arch/arm/boot/dts/rk3288-phycore-som.dtsi | 1 -
 arch/arm/boot/dts/rk3288-popmetal.dts     | 1 -
 arch/arm/boot/dts/rk3288-tinker.dtsi      | 1 -
 arch/arm/boot/dts/rk3288-veyron.dtsi      | 1 -
 arch/arm/boot/dts/rk3288-vyasa.dts        | 1 -
 arch/arm/boot/dts/rv1108-elgin-r1.dts     | 1 -
 arch/arm/boot/dts/rv1108-evb.dts          | 1 -
 10 files changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index fb3cf005cc90..0a7290ab718d 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -118,7 +118,6 @@ rk808: pmic@1b {
 		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_int &global_pwroff>;
-		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
 		clock-output-names = "xin32k", "rk808-clkout2";
diff --git a/arch/arm/boot/dts/rk3188-px3-evb.dts b/arch/arm/boot/dts/rk3188-px3-evb.dts
index c32e1d441cf7..334fa510995c 100644
--- a/arch/arm/boot/dts/rk3188-px3-evb.dts
+++ b/arch/arm/boot/dts/rk3188-px3-evb.dts
@@ -88,7 +88,6 @@ rk808: pmic@1c {
 		reg = <0x1c>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PB3 IRQ_TYPE_LEVEL_LOW>;
-		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
 		clock-output-names = "xin32k", "rk808-clkout2";
diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index 16788209625b..4b280c4b4850 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -17,7 +17,6 @@ rk808: pmic@1b {
 		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_int &global_pwroff>;
-		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
 		clock-output-names = "xin32k", "rk808-clkout2";
diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
index 77a47b9b756d..2076566a2c97 100644
--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -148,7 +148,6 @@ rk818: pmic@1c {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_int>;
-		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
 
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index 6a51940398b5..251668fee14d 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -168,7 +168,6 @@ rk808: pmic@1b {
 		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_int &global_pwroff>;
-		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
 		clock-output-names = "xin32k", "rk808-clkout2";
diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 0aeef23ca3db..15fc1caca852 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -154,7 +154,6 @@ rk808: pmic@1b {
 				<&gpio0 12 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_int &global_pwroff &dvs_1 &dvs_2>;
-		rockchip,system-power-controller;
 		wakeup-source;
 
 		vcc1-supply = <&vcc_sys>;
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 7525e3dd1fc1..d7663ebc798f 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -221,7 +221,6 @@ rk808: pmic@1b {
 		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_int_l>;
-		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
 
diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index ba06e9f97ddc..98e48ecb473e 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -167,7 +167,6 @@ rk808: pmic@1b {
 		clock-output-names = "xin32k", "rk808-clkout2";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_int &global_pwroff>;
-		rockchip,system-power-controller;
 		wakeup-source;
 
 		vcc1-supply = <&vcc_sys>;
diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index b1db924710c8..39acc472774d 100644
--- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -67,7 +67,6 @@ rk805: pmic@18 {
 		reg = <0x18>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
-		rockchip,system-power-controller;
 
 		vcc1-supply = <&vcc_sys>;
 		vcc2-supply = <&vcc_sys>;
diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 30f3d0470ad9..e21817237792 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -80,7 +80,6 @@ rk805: pmic@18 {
 		reg = <0x18>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
-		rockchip,system-power-controller;
 
 		vcc1-supply = <&vcc_sys>;
 		vcc2-supply = <&vcc_sys>;
-- 
2.24.0

