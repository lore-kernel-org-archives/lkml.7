Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F39C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318C9217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bdb0VXzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbfDRRrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:47:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32850 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRRrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:47:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so1509518plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtYAgeoDRvkZXjuaeeVMz/xlUo2hw1CKgw3jYjzF/Mg=;
        b=bdb0VXzPs91HOFcIiaHwHVDNmKQwUl+qCEBD9U8Xyd9x7SeKjehXwwyqlrHVgtCkge
         v5KdQZRztjphEFB8U0u4V+HPecARqK0LWm/DfKgjZUY0hMw9wGz3mDM0yxR0EcaiANWq
         oC8uGGgZ5SUTgS4KdP6Pkuwx9H7cOzkAxz3U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtYAgeoDRvkZXjuaeeVMz/xlUo2hw1CKgw3jYjzF/Mg=;
        b=as5xv/VzktXysRE+mNQUd7qiiLf3slIej+8XmDVxeyjXIO0RbFSZ63s0tTzJ84zP55
         iCWotFc5FAFgvCW6Gjk4Rin3/Ne2W6G7L5YLtUbYon8i/TwWpIBNKChMwkS9Ze1BG4ZM
         Na6diaIAt4stgwg9JQJ0BN67OdeXyiYuIeijiP8TEX2+3fik/NYNFO6vH06QZAPsDCTc
         DDU3R5zDQkj1qkl9UTkjqexlPhrq4y0IJYZGzlIkBCf50t/er5sKuNv1b9GaxcA7aZUG
         Xba528JoECWsWHfC6R6L0UDvsLkHxo+Labe5u6acOC/v+HHn5PFt912SYwlQlsZEQYuD
         C1hw==
X-Gm-Message-State: APjAAAX4zbEsEOAwTC0Duh2RRB1TUVc4ODREXxOigzl7GwhjBabsihyu
        eDx0RsKIS9Px+qAyKuITHlK0Yw==
X-Google-Smtp-Source: APXvYqy/3/XGaX8Bljdkzbk33RK4EFtwXGrQXCmUoYElYC4I68WddjDATKhIRhoWtSU6qirA0wgoAA==
X-Received: by 2002:a17:902:110c:: with SMTP id d12mr68666870pla.47.1555609651317;
        Thu, 18 Apr 2019 10:47:31 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id j4sm5223547pgi.71.2019.04.18.10.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 10:47:30 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 1/3] arm64: dts: allwinner: a64: Move I2C pinctrl to dtsi
Date:   Thu, 18 Apr 2019 23:17:18 +0530
Message-Id: <20190418174720.17230-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one pinmuxing available for each I2C controller.

So, move pinctrl for i2c0, i2c1 from board dts files into SoC dtsi.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- new patch

 arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts  | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts    | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts        | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts       | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi              | 4 ++++
 6 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 019ae09ea0fd..c41131c03231 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -85,8 +85,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	sensor@48 {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 0a56c0c23ba1..c2a6b73b17cf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -145,8 +145,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index f4e78531f639..bef4abf6fa25 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -121,8 +121,6 @@
 
 /* i2c1 connected with gpio headers like pine64, bananapi */
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "disabled";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index b7ac6374b178..409523cb0950 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -122,8 +122,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index 0ec46b969a75..12afc52e169e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -92,8 +92,6 @@
  */
 &i2c0 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8c5b521e6389..b275c6d35420 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -842,6 +842,8 @@
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C0>;
 			resets = <&ccu RST_BUS_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -853,6 +855,8 @@
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C1>;
 			resets = <&ccu RST_BUS_I2C1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.18.0.321.gffc6fa0e3

