Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1453C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF232166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dlnYmbcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393708AbfHWJEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:04:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51942 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393428AbfHWJE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:04:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id k1so8219273wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXVc7lr79gHa7m2sNFALcMUoOAv3CwAI7GPYmurLn+Y=;
        b=dlnYmbcANnHuvKUhYRq6DNpemyNnupwagFpk33KxETdLgDwAo5AJh5r39o0ZaiFcf4
         Iu5DRtWBLDNxf8U606dm5axMiAYRZ0VJVGskLwDp2JJzpbXMYysdD7CuS36qmYbXMEJV
         Lp6jhH8duM7wI2R0lU4Hg1dTY6TIfse0kMLI1MUBErLGl3WwV3ZPrmUcIZKGFbIbX3ln
         rFcdzbz0MheF07lxtuuxjAkD/y98oOt324His5BXmi/TcBGDv3ivhI4a0+CVof8Jt/mr
         76UO1KvUSE7IILRWvPezVVFv7W/NtCCKgFHXHIN43Yi4DWCQLwt+xrtzyREtF5d0QK/r
         oPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXVc7lr79gHa7m2sNFALcMUoOAv3CwAI7GPYmurLn+Y=;
        b=UQB4NxDyCvLyAqBDvQOiekbUti5S3Q5P2+8JIgMHkNVUfXG85ZyJac0F17/HmysIWH
         tTxpkSmUD3l+0uJHK/iZzeLB9GoV9gptdmjCWRAQOE9n1gNZcG/baIZHRDoj2zYXf7M5
         v2BhjUWBcwChJWqa4g0KXnFFYOe65yQU0kt5+J7HUf63KzHnClhnomsNTan9w9U2giNo
         ESLpxQymnutTUQnJ+eamgOQjiUUqNKUsikbsa7/iIkPKXiDji9udZcvdFgrV2Okf6PAf
         xdWnlGgLe/ZVXEEt1r7mflH6w67QqFZvcnf54ZfU4uOca+idaZQhN/k9IC36eQ2gTDUC
         S57g==
X-Gm-Message-State: APjAAAWj4oQ+QTjAKh62s8mK/3nR1o3XA8S3gsrmetHQlyaH90cDtRaV
        fHNgKbcsmu0vnVaegjflsDX6pA==
X-Google-Smtp-Source: APXvYqxN7cy3oKqmIjJgoY7BmWwjxQ/OHw4WYVk47lxGYWd9PJvgrlXL4tGEcSGkVLR9Ly5IjsAwYg==
X-Received: by 2002:a1c:ef14:: with SMTP id n20mr4026979wmh.89.1566551062982;
        Fri, 23 Aug 2019 02:04:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x26sm1625544wmj.42.2019.08.23.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:04:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] arm64: meson-g12: add Everything-Else power domain controller
Date:   Fri, 23 Aug 2019 11:04:16 +0200
Message-Id: <20190823090418.17148-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823090418.17148-1-narmstrong@baylibre.com>
References: <20190823090418.17148-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the VPU-centric power domain controller by the generic system-wide
Everything-Else power domain controller and setup the right power-domains
properties on the VPU, Ethernet & USB nodes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 92 ++++++++++---------
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  9 ++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  9 ++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    | 15 ++-
 4 files changed, 77 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index a921d6334e5b..8baa6318f180 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1426,6 +1426,53 @@
 						clocks = <&xtal>;
 						clock-names = "xtal";
 					};
+
+					pwrc: power-controller {
+						compatible = "amlogic,meson-g12a-pwrc";
+						#power-domain-cells = <1>;
+						amlogic,ao-sysctrl = <&rti>;
+						resets = <&reset RESET_VIU>,
+							 <&reset RESET_VENC>,
+							 <&reset RESET_VCBUS>,
+							 <&reset RESET_BT656>,
+							 <&reset RESET_RDMA>,
+							 <&reset RESET_VENCI>,
+							 <&reset RESET_VENCP>,
+							 <&reset RESET_VDAC>,
+							 <&reset RESET_VDI6>,
+							 <&reset RESET_VENCL>,
+							 <&reset RESET_VID_LOCK>;
+						reset-names = "viu", "venc", "vcbus", "bt656",
+							      "rdma", "venci", "vencp", "vdac",
+							      "vdi6", "vencl", "vid_lock";
+						clocks = <&clkc CLKID_VPU>,
+							 <&clkc CLKID_VAPB>;
+						clock-names = "vpu", "vapb";
+						/*
+						 * VPU clocking is provided by two identical clock paths
+						 * VPU_0 and VPU_1 muxed to a single clock by a glitch
+						 * free mux to safely change frequency while running.
+						 * Same for VAPB but with a final gate after the glitch free mux.
+						 */
+						assigned-clocks = <&clkc CLKID_VPU_0_SEL>,
+								  <&clkc CLKID_VPU_0>,
+								  <&clkc CLKID_VPU>, /* Glitch free mux */
+								  <&clkc CLKID_VAPB_0_SEL>,
+								  <&clkc CLKID_VAPB_0>,
+								  <&clkc CLKID_VAPB_SEL>; /* Glitch free mux */
+						assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+									 <0>, /* Do Nothing */
+									 <&clkc CLKID_VPU_0>,
+									 <&clkc CLKID_FCLK_DIV4>,
+									 <0>, /* Do Nothing */
+									 <&clkc CLKID_VAPB_0>;
+						assigned-clock-rates = <0>, /* Do Nothing */
+								       <666666666>,
+								       <0>, /* Do Nothing */
+								       <0>, /* Do Nothing */
+								       <250000000>,
+								       <0>; /* Do Nothing */
+					};
 				};
 			};
 
@@ -1773,50 +1820,6 @@
 					clock-names = "xtal", "mpeg-clk";
 				};
 
-				pwrc_vpu: power-controller-vpu {
-					compatible = "amlogic,meson-g12a-pwrc-vpu";
-					#power-domain-cells = <0>;
-					amlogic,hhi-sysctrl = <&hhi>;
-					resets = <&reset RESET_VIU>,
-						 <&reset RESET_VENC>,
-						 <&reset RESET_VCBUS>,
-						 <&reset RESET_BT656>,
-						 <&reset RESET_RDMA>,
-						 <&reset RESET_VENCI>,
-						 <&reset RESET_VENCP>,
-						 <&reset RESET_VDAC>,
-						 <&reset RESET_VDI6>,
-						 <&reset RESET_VENCL>,
-						 <&reset RESET_VID_LOCK>;
-					clocks = <&clkc CLKID_VPU>,
-						 <&clkc CLKID_VAPB>;
-					clock-names = "vpu", "vapb";
-					/*
-					 * VPU clocking is provided by two identical clock paths
-					 * VPU_0 and VPU_1 muxed to a single clock by a glitch
-					 * free mux to safely change frequency while running.
-					 * Same for VAPB but with a final gate after the glitch free mux.
-					 */
-					assigned-clocks = <&clkc CLKID_VPU_0_SEL>,
-							  <&clkc CLKID_VPU_0>,
-							  <&clkc CLKID_VPU>, /* Glitch free mux */
-							  <&clkc CLKID_VAPB_0_SEL>,
-							  <&clkc CLKID_VAPB_0>,
-							  <&clkc CLKID_VAPB_SEL>; /* Glitch free mux */
-					assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
-								 <0>, /* Do Nothing */
-								 <&clkc CLKID_VPU_0>,
-								 <&clkc CLKID_FCLK_DIV4>,
-								 <0>, /* Do Nothing */
-								 <&clkc CLKID_VAPB_0>;
-					assigned-clock-rates = <0>, /* Do Nothing */
-							       <666666666>,
-							       <0>, /* Do Nothing */
-							       <0>, /* Do Nothing */
-							       <250000000>,
-							       <0>; /* Do Nothing */
-				};
-
 				ao_pinctrl: pinctrl@14 {
 					compatible = "amlogic,meson-g12a-aobus-pinctrl";
 					#address-cells = <2>;
@@ -2169,7 +2172,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			amlogic,canvas = <&canvas>;
-			power-domains = <&pwrc_vpu>;
 
 			/* CVBS VDAC output port */
 			cvbs_vdac_port: port@0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 733a9d46fc4b..eb5d177d7a99 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "meson-g12-common.dtsi"
+#include <dt-bindings/power/meson-g12a-power.h>
 
 / {
 	compatible = "amlogic,g12a";
@@ -110,6 +111,14 @@
 	};
 };
 
+&ethmac {
+	power-domains = <&pwrc PWRC_G12A_ETH_ID>;
+};
+
+&vpu {
+	power-domains = <&pwrc PWRC_G12A_VPU_ID>;
+};
+
 &sd_emmc_a {
 	amlogic,dram-access-quirk;
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index d5edbc1a1991..5628ccd54531 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include "meson-g12-common.dtsi"
+#include <dt-bindings/power/meson-g12a-power.h>
 
 / {
 	compatible = "amlogic,g12b";
@@ -101,6 +102,14 @@
 	compatible = "amlogic,g12b-clkc";
 };
 
+&ethmac {
+	power-domains = <&pwrc PWRC_G12A_ETH_ID>;
+};
+
+&vpu {
+	power-domains = <&pwrc PWRC_G12A_VPU_ID>;
+};
+
 &sd_emmc_a {
 	amlogic,dram-access-quirk;
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index e902d4f9165f..37064d7f66c1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include "meson-g12-common.dtsi"
+#include <dt-bindings/power/meson-sm1-power.h>
 
 / {
 	compatible = "amlogic,sm1";
@@ -59,10 +60,18 @@
 	compatible = "amlogic,meson-sm1-clk-measure";
 };
 
-&pwrc_vpu {
-	status = "disabled";
+&ethmac {
+	power-domains = <&pwrc PWRC_SM1_ETH_ID>;
+};
+
+&pwrc {
+	compatible = "amlogic,meson-sm1-pwrc";
 };
 
 &vpu {
-	status = "disabled";
+	power-domains = <&pwrc PWRC_SM1_VPU_ID>;
+};
+
+&usb {
+	power-domains = <&pwrc PWRC_SM1_USB_ID>;
 };
-- 
2.22.0

