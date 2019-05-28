Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA7C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E67821721
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyEbEcxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfE1XCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:02:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33164 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfE1XCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:02:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so269611pfk.0;
        Tue, 28 May 2019 16:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UhDRw3r3UGwm2vyQ38HyiVKpdnmKQn3bdX4h2mhrNw4=;
        b=iyEbEcxn6S/MuK024Xfl88KIaECfvI+zXln1AR9XOg8WZy8GokbylfZkMzKeynTUPN
         HtFLyoh6ec+Rd/1u2qefsNm0DuiD7dhMudBFqgylmPFCQhoIj/TYj6qLnuux+sdbr9d5
         Djvb68Oyzmal+nSgRtZv5za771gS8gBLPifkPYCpU7jYczVhthAyXblEN7KjV3EIK4Wd
         J0uIBsffT7IEkUSkvxoLap1v19xR4kivXL2EZt/u509hVifT+/LWjavKNAO88MkzRBAt
         P00qFtwH25EnhbInskB5HE26em2VnM/RJpwM54PGv851qtRFA8JibUub6yinXySPSjNd
         R9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UhDRw3r3UGwm2vyQ38HyiVKpdnmKQn3bdX4h2mhrNw4=;
        b=Y+P1MIxrDP77AVgehP9+hFsMUJJq28WxFUlFvobkfS/OR/Hp78LMk1/gYX1/Dj2+6p
         +9LtIeGvcVEUGBYTFWColcM4CHW4Dd9yscIG9E7PtiHx7eMjF57auMtUq5J8ogn30ohh
         e8Lj4PQyeg2clqlicdTBxS1oCnk6NR5HE8/l+xWoUc1IVeW8dSvJSJi83+V17WF+TZOn
         a3Wa7chtJVHTBdJ/UtaufrVdOQ0PD43tYIgsc1nRymj8giGCru4kQhfYyyWSFJLNSuvq
         AeHVsupdo2G7UtfTi65/0tITQM6iQDYMgSxMandVcykDlTWmlM4F4InZQ98Ql9x1vbDG
         P3Vw==
X-Gm-Message-State: APjAAAVWirsY8rgXhoxfJc4DB+Px+YHpWC1wqFZTOXA//zhDnTq48/WU
        TYRHlF8EPtPfNaRrIenwlDB3OTHe
X-Google-Smtp-Source: APXvYqypL8bzjXvnb1MD+6km7SNXH7zCKNwdFnUvmZfuP16nTTKhEk/IDuKtjgE3FGMJaclNa82XcA==
X-Received: by 2002:a17:90a:bb82:: with SMTP id v2mr8857173pjr.73.1559084531988;
        Tue, 28 May 2019 16:02:11 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13sm14369573pfh.13.2019.05.28.16.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:02:11 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/7] ARM: dts: Cygnus: Fix most DTC W=1 warnings
Date:   Tue, 28 May 2019 16:01:29 -0700
Message-Id: <20190528230134.27007-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528230134.27007-1-f.fainelli@gmail.com>
References: <20190528230134.27007-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the bulk of the unit_address_vs_reg warnings and unnecessary
\#address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus-clock.dtsi | 12 ++++++------
 arch/arm/boot/dts/bcm-cygnus.dtsi       |  6 +++---
 arch/arm/boot/dts/bcm911360_entphn.dts  |  2 --
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus-clock.dtsi b/arch/arm/boot/dts/bcm-cygnus-clock.dtsi
index 80b6ba4ca50c..52f91a12a99a 100644
--- a/arch/arm/boot/dts/bcm-cygnus-clock.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus-clock.dtsi
@@ -42,7 +42,7 @@ clocks {
 	};
 
 	/* Cygnus ARM PLL */
-	armpll: armpll {
+	armpll: armpll@19000000 {
 		#clock-cells = <0>;
 		compatible = "brcm,cygnus-armpll";
 		clocks = <&osc>;
@@ -67,7 +67,7 @@ clocks {
 		clock-mult = <1>;
 	};
 
-	genpll: genpll {
+	genpll: genpll@301d000 {
 		#clock-cells = <1>;
 		compatible = "brcm,cygnus-genpll";
 		reg = <0x0301d000 0x2c>, <0x0301c020 0x4>;
@@ -94,7 +94,7 @@ clocks {
 		clock-mult = <1>;
 	};
 
-	lcpll0: lcpll0 {
+	lcpll0: lcpll0@301d02c {
 		#clock-cells = <1>;
 		compatible = "brcm,cygnus-lcpll0";
 		reg = <0x0301d02c 0x1c>, <0x0301c020 0x4>;
@@ -103,7 +103,7 @@ clocks {
 				     "usb_phy", "smart_card", "ch5";
 	};
 
-	mipipll: mipipll {
+	mipipll: mipipll@180a9800 {
 		#clock-cells = <1>;
 		compatible = "brcm,cygnus-mipipll";
 		reg = <0x180a9800 0x2c>, <0x0301c020 0x4>, <0x180aa024 0x4>;
@@ -113,7 +113,7 @@ clocks {
 				     "ch5_unused";
 	};
 
-	asiu_clks: asiu_clks {
+	asiu_clks: asiu_clks@301d048 {
 		#clock-cells = <1>;
 		compatible = "brcm,cygnus-asiu-clk";
 		reg = <0x0301d048 0xc>, <0x180aa024 0x4>;
@@ -122,7 +122,7 @@ clocks {
 		clock-output-names = "keypad", "adc/touch", "pwm";
 	};
 
-	audiopll: audiopll {
+	audiopll: audiopll@180aeb00 {
 		#clock-cells = <1>;
 		compatible = "brcm,cygnus-audiopll";
 		reg = <0x180aeb00 0x68>;
diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 5f7b46503a51..2dac3efc7640 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -45,7 +45,7 @@
 		ethernet0 = &eth0;
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0 0>;
 	};
@@ -69,7 +69,7 @@
 		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	core {
+	core@19000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x19000000 0x1000000>;
 		#address-cells = <1>;
@@ -91,7 +91,7 @@
 			      <0x20100 0x100>;
 		};
 
-		L2: l2-cache {
+		L2: l2-cache@22000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x22000 0x1000>;
 			cache-unified;
diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index 53f990defd6a..b2d323f4a5ab 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -49,8 +49,6 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		hook {
 			label = "HOOK";
-- 
2.17.1

