Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF9EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA9B2339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1BiiCed9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfHULll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:41:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40437 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfHULl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:41:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id c5so1593096wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXVc7lr79gHa7m2sNFALcMUoOAv3CwAI7GPYmurLn+Y=;
        b=1BiiCed95tDSvHVGTZllJjEiEJMFAZX3aD6cXcJBpCYemPQaGTPNJ9lk4GsAgvu5Pu
         y4Wvilxp2y6EajxG+jDTiWymetYAqhePfVDIC0iSMtQJyVwkTWXfc/XVnMkWPEaD1av2
         dhAWYscKj+3KtZ6REmEqofnEfDUSqrpjkewdok2v8RHt1wd/wq/U1Ub+X77kD1TVHjrZ
         4B7UB+beTzk3VZFtjoKe+VI1G4dDPcU3QxCAatCyhOtLw+PWo+lE+NKoV1Axl+Qp8FO9
         IAGEDFW79L7tPqmcY98bXSt3tctsWWwYP1PZNDf9WK7MnX2IJaGfSE8pokzGzlLt6gPo
         1Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXVc7lr79gHa7m2sNFALcMUoOAv3CwAI7GPYmurLn+Y=;
        b=RtHpr0jbKLTvgHntIRLN9C+QJlIU1/iy99jXo5C7LSixD3CudOcGpD8tKW9pTYWZ5m
         p+nQ97qsFX1+ll1q7hf+wSUHOIKPSd8QWfbQ5kjw7d5eLrwzC7Sd4KN7S1rzv1BsYtcD
         GKhnEkKiqKbWATyReVIT4fhx8yjJEo+5/qN2RbFZ9NZ5AdI8p0SIxGsX+jh4lVLhaRje
         olzeN7gQFDSjqVh0pyRXRp4AjT5IqaF9iN939VmfGgYs8yPdxUvxdVQwXh7Ti/Njcb4j
         Ukv9WM9Vr0xf0yqGy4q80qRPNvyFnbrUN915AvZjbQZvdCmbf02FFsgqBbnxmnmlDlka
         pxRg==
X-Gm-Message-State: APjAAAXdA6IgqFBZ7/KQHcU/NYe9WFBS5vGZ26P77j2+cd7OYdL0xlcC
        ojRYd3zPn3Z+VyY06Zd6vw2IRg==
X-Google-Smtp-Source: APXvYqwzpbcA3BoowKeJ2lY/IYM8N9VambEPsXXvQjL+XeoEJlr/Yk8FGH1G9BzSvx8SaUUtHNblEQ==
X-Received: by 2002:a1c:c4:: with SMTP id 187mr5357676wma.132.1566387686043;
        Wed, 21 Aug 2019 04:41:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g12sm24049686wrv.9.2019.08.21.04.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 04:41:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: meson-g12: add Everything-Else power domain controller
Date:   Wed, 21 Aug 2019 13:41:19 +0200
Message-Id: <20190821114121.10430-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821114121.10430-1-narmstrong@baylibre.com>
References: <20190821114121.10430-1-narmstrong@baylibre.com>
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

