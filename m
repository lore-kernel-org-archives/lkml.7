Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BA5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D5B2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gQit15oC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbfDRM1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:27:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52665 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388903AbfDRM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:27:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so2548796wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LXGEYk4K+okXhUn64svYw/ZBNWm7+B5TLkuBGuWEQmA=;
        b=gQit15oCYCC9aWPcHOhHKKq+TSn9uItSjSTA6OObWkDQ6MEBWHd/m1QPoG256ZkGoz
         Frt5mO6C0+knz97SDHm74ZizOfUjqLyji7x6a2zQHFbGMflOfyEMNzZdmMT66+xK9wxW
         CbdHcTwoY/YjAzRM0u4zjbJgSUdZn0Yfqf7ANivLUQSkH0es9QZLtusveCVpJaEEAwhu
         QGrG+S6nJL8pR5dn2JLiJZ0eK241KEMpkWz9VS+KsRk8bUhQQrGaqGFI7mENdMoD23ei
         M6vPmeO5txu4izoVyUEp9MxeUh2cY+dQs+7nT36UTqNSZ8NfZIWlPr3IchNpoYCEG5qN
         Uw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LXGEYk4K+okXhUn64svYw/ZBNWm7+B5TLkuBGuWEQmA=;
        b=h3puyC4wtmyaSxgha2KRviFjF5MtBRwkZ6oRbnNlRoK1UcO11qynSJO7kn938y+e1h
         pKWpDSts4AUZOJfm3QfTrAKed7MEFs6KQqrbL6Yj1dnGrixAEfiwUFA8p/HmUfNYojp8
         XVOH6hQMRkyJBP6YwI7qkGTPtRr1uWHWS5JlwtaK/9XZdmz6Hf+R6u0e58kUsV9OWx3F
         ow1kTJv7mN3ys3PnFAbX7rf2VCmjQ2EPd5O+5RIhtpuD5U3xDmNzZih1WUPtIFoh6MPj
         Wt7BbFOW0pC8n0KMvY7JA1i17TZ5qCviOfuAUGa2YoM4iWQPmbZchasBYHB6EiKpy06o
         rK7Q==
X-Gm-Message-State: APjAAAUWbPWPGz6PRq1RRvTKIiyctDASHNue8330B074f2YXtyW6QTrJ
        mUVZUE4VT+L0oQlEsPpoT3gkGA==
X-Google-Smtp-Source: APXvYqwtakNaqLOOMAKuhZh+uKmy0xZsJBRCTHmeLiRCf6P5QShKy9weKWWCDyem162jB3wg2OpF+A==
X-Received: by 2002:a1c:e185:: with SMTP id y127mr3135773wmg.76.1555590447577;
        Thu, 18 Apr 2019 05:27:27 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z14sm1510110wro.81.2019.04.18.05.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 05:27:26 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 3/6] arm64: dts: meson: fix mmc pin bias
Date:   Thu, 18 Apr 2019 14:27:11 +0200
Message-Id: <20190418122714.30805-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418122714.30805-1-jbrunet@baylibre.com>
References: <20190418122714.30805-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clk pin does not require bias, data strobe should be pulled low.
The rest of the pin (data and cmd) are pulled up.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  4 +--
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 31 ++++++++++++----
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   | 35 +++++++++++++------
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    | 35 +++++++++++++------
 4 files changed, 76 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 75fe1a2c49d0..4cd2d5951822 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -482,8 +482,8 @@
 
 /* emmc storage */
 &sd_emmc_c {
-	status = "disabled";
-	pinctrl-0 = <&emmc_pins>;
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 34704fecf756..38169c85e91f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -299,7 +299,7 @@
 				};
 
 				emmc_pins: emmc {
-					mux {
+					mux-0 {
 						groups = "emmc_nand_d0",
 							 "emmc_nand_d1",
 							 "emmc_nand_d2",
@@ -308,14 +308,26 @@
 							 "emmc_nand_d5",
 							 "emmc_nand_d6",
 							 "emmc_nand_d7",
-							 "emmc_clk",
-							 "emmc_cmd",
-							 "emmc_ds";
+							 "emmc_cmd";
+						function = "emmc";
+						bias-pull-up;
+					};
+
+					mux-1 {
+						groups = "emmc_clk";
 						function = "emmc";
 						bias-disable;
 					};
 				};
 
+				emmc_ds_pins: emmc_ds {
+					mux {
+						groups = "emmc_ds";
+						function = "emmc";
+						bias-pull-down;
+					};
+				};
+
 				emmc_clk_gate_pins: emmc_clk_gate {
 					mux {
 						groups = "BOOT_8";
@@ -559,13 +571,18 @@
 				};
 
 				sdio_pins: sdio {
-					mux {
+					mux-0 {
 						groups = "sdio_d0",
 							 "sdio_d1",
 							 "sdio_d2",
 							 "sdio_d3",
-							 "sdio_cmd",
-							 "sdio_clk";
+							 "sdio_cmd";
+						function = "sdio";
+						bias-pull-up;
+					};
+
+					mux-1 {
+						groups = "sdio_clk";
 						function = "sdio";
 						bias-disable;
 					};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index a60d3652beee..f734faaf7b78 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -381,10 +381,15 @@
 		};
 
 		emmc_pins: emmc {
-			mux {
+			mux-0 {
 				groups = "emmc_nand_d07",
-				       "emmc_cmd",
-				       "emmc_clk";
+				       "emmc_cmd";
+				function = "emmc";
+				bias-pull-up;
+			};
+
+			mux-1 {
+				groups = "emmc_clk";
 				function = "emmc";
 				bias-disable;
 			};
@@ -394,7 +399,7 @@
 			mux {
 				groups = "emmc_ds";
 				function = "emmc";
-				bias-disable;
+				bias-pull-down;
 			};
 		};
 
@@ -436,13 +441,18 @@
 		};
 
 		sdcard_pins: sdcard {
-			mux {
+			mux-0 {
 				groups = "sdcard_d0",
 				       "sdcard_d1",
 				       "sdcard_d2",
 				       "sdcard_d3",
-				       "sdcard_cmd",
-				       "sdcard_clk";
+				       "sdcard_cmd";
+				function = "sdcard";
+				bias-pull-up;
+			};
+
+			mux-1 {
+				groups = "sdcard_clk";
 				function = "sdcard";
 				bias-disable;
 			};
@@ -457,13 +467,18 @@
 		};
 
 		sdio_pins: sdio {
-			mux {
+			mux-0 {
 				groups = "sdio_d0",
 				       "sdio_d1",
 				       "sdio_d2",
 				       "sdio_d3",
-				       "sdio_cmd",
-				       "sdio_clk";
+				       "sdio_cmd";
+				function = "sdio";
+				bias-pull-up;
+			};
+
+			mux-1 {
+				groups = "sdio_clk";
 				function = "sdio";
 				bias-disable;
 			};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 3093ae421b17..c959456bacc6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -326,10 +326,15 @@
 		};
 
 		emmc_pins: emmc {
-			mux {
+			mux-0 {
 				groups = "emmc_nand_d07",
-				       "emmc_cmd",
-				       "emmc_clk";
+				       "emmc_cmd";
+				function = "emmc";
+				bias-pull-up;
+			};
+
+			mux-1 {
+				groups = "emmc_clk";
 				function = "emmc";
 				bias-disable;
 			};
@@ -339,7 +344,7 @@
 			mux {
 				groups = "emmc_ds";
 				function = "emmc";
-				bias-disable;
+				bias-pull-down;
 			};
 		};
 
@@ -381,13 +386,18 @@
 		};
 
 		sdcard_pins: sdcard {
-			mux {
+			mux-0 {
 				groups = "sdcard_d0",
 				       "sdcard_d1",
 				       "sdcard_d2",
 				       "sdcard_d3",
-				       "sdcard_cmd",
-				       "sdcard_clk";
+				       "sdcard_cmd";
+				function = "sdcard";
+				bias-pull-up;
+			};
+
+			mux-1 {
+				groups = "sdcard_clk";
 				function = "sdcard";
 				bias-disable;
 			};
@@ -402,13 +412,18 @@
 		};
 
 		sdio_pins: sdio {
-			mux {
+			mux-0 {
 				groups = "sdio_d0",
 				       "sdio_d1",
 				       "sdio_d2",
 				       "sdio_d3",
-				       "sdio_cmd",
-				       "sdio_clk";
+				       "sdio_cmd";
+				function = "sdio";
+				bias-pull-up;
+			};
+
+			mux-1 {
+				groups = "sdio_clk";
 				function = "sdio";
 				bias-disable;
 			};
-- 
2.20.1

