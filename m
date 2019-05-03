Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F91C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B202081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RJK/xJPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfECKsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:48:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35726 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECKsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:48:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id t87so2136413pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 03:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CtRnF3C3SrPtDzWYrijbevMMvebx7nVoCcCzEGjiz+k=;
        b=RJK/xJPim39XkImo/YtK9AQ7+Ap5N0NWwMJuNR+mnh6nqrfOjeUmbe8qd9c+Uszfrd
         v3AVl5w3xsN/5dcG9t9s0uD1h99zCtpA3wo1MMF3NvzQrStGK8jqpQiLPyZApEgouPwZ
         qIFFRAxY779YlEPdHOSUybfiJ/cD8QJ94tQQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CtRnF3C3SrPtDzWYrijbevMMvebx7nVoCcCzEGjiz+k=;
        b=mHTP9055Bj/O3tLHPS/IZRQ+fKX9AC4wc4etGnf1+z7c/iD/bcuFUM3kBUOWAYIS8q
         vRhYvTDyoePQMiMerhfh91P1ZHDMk3Ve56b/g978B/Cg9Avhi5qRD+1AjIqdof1OYY+b
         OxZnWHkEsxcOmbKeHG/kyqlaB5Xq7beclmNTxYk2JQnKVwMyTfXLff+KhSQN9KqdgtB2
         GUwid87PsDuSLZlAH9HcJua1ftD9pVrtSHo1y7Mctb1fbDJp8OqSkTicX5+G7yd161oN
         2lLIcILaENcYCqTrXPh6t+teH0+nHG8WuqXtC/dAZ3Y97C2XCNkxrO5k8hxjBbVNQISB
         scMA==
X-Gm-Message-State: APjAAAX0cmnx3DBspWlND5VeL4g14THbxmPqczFqNLKwpgtNLx1swdwW
        XJVRZ58wnXtKKxMjTO6Pc/VgWQ==
X-Google-Smtp-Source: APXvYqyIOUbBzj8SnfhhfLgP9Y7Ulu74W17b22tiSiG84nQI3rr/jZ4wles58cXdQHvH5gwgrOph3Q==
X-Received: by 2002:a63:8f4b:: with SMTP id r11mr9441799pgn.271.1556880490220;
        Fri, 03 May 2019 03:48:10 -0700 (PDT)
Received: from localhost.localdomain ([49.206.203.165])
        by smtp.gmail.com with ESMTPSA id k9sm1965479pga.22.2019.05.03.03.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 03:48:09 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 1/3] arm64: dts: allwinner: a64: move I2C pinctrl to dtsi
Date:   Fri,  3 May 2019 16:17:51 +0530
Message-Id: <20190503104753.27562-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one pinmuxing available for each I2C controller.

So, move pinctrl for i2c0, i2c1 from board dts files into SoC dtsi.

By moving these pinctrls the i2c1 node from Nanopi A64 just have a
status, which is disabled already so remove the entire node from it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- drop the i2c1 node from nanopi-a64 
Changes for v4:
- new patch

 arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts  | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts    | 6 ------
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts        | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts       | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi              | 4 ++++
 6 files changed, 4 insertions(+), 14 deletions(-)

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
index f4e78531f639..9b9d9157128c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -120,12 +120,6 @@
 };
 
 /* i2c1 connected with gpio headers like pine64, bananapi */
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-	status = "disabled";
-};
-
 &i2c1_pins {
 	bias-pull-up;
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

