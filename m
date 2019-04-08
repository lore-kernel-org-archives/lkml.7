Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7133C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF4520880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gF06Ia9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDHJbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:31:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36566 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHJbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:31:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so13907093wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=87mASUM9ygudYeEf9hAinsvtXlIr8NTEMYy6/2B799Q=;
        b=gF06Ia9GhqXcCc8ydP5kQwY4S68JuX8eNFLO1ZL1FkAs30UbnCNuQNqjBDt3ZiK2wO
         JvFVUGATFXWhkz9nBNqihVh/kRzklKk6HzqcT1nCndcj3osHgxPhJStkPrhs/YQJD4Gp
         /gfoDKUwHNiWsLefdneAsj05ZUovYwqwz56uVUNP0DKRCUgOYErOq2daeWhcIzq/or2S
         MCem0OFzAG4UP5EeUsvTn4mT3JBId6sYkyesrdXP8m6N8KNqY0FWGQAAZO2vf1xNYpfs
         yTfK4kuY7O6dWdanoLN8CYSEvYEW4cXcYAJbywyR4WPv3YpICwZj2jHvoE8A9IXD7BP/
         xH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=87mASUM9ygudYeEf9hAinsvtXlIr8NTEMYy6/2B799Q=;
        b=BMlEJ+yYRUTAvfoY3spClvIjx722wjuPf0LFug3diJTWuR5ysbfNiNAN1Qvym496E7
         5ZleIsXvF/5NXK/AWeAH6zuIuUcIhr6mxek0sc5k3TEGJGiR/jPVTNvt/uAau4bo7RxX
         zZpwDNoId+9fHLlG7YoJ40Y9Ldhv6cH9gbaqpQliu3Ngvd9Wb7q60+Pjd7VH2muItxQt
         7Gekj0/geWhus1HK+t7vIil7VZhvqWb4Vthh5D7lPrhAovc3yGBggRffTOUwr8GtoUFB
         obV8uoW175iFoRScGcM8RUbYOn6BkiNSghMnXWXhOirfZbJke3DmMrL7jNEZu/rwLI2z
         80CA==
X-Gm-Message-State: APjAAAWOW3EJQSm2MiL28O4PN5prSLMOZdI69d3chp16qBibMWUPk1WO
        fwGB7Pui8CBowTMPllWuqkagKA==
X-Google-Smtp-Source: APXvYqwoTSPxMuBUBF1VfymLN3vYxhA5xZ7jzQXV6UaUiGdrEw45E9DWI6L18fL2b4PcO6U+F/Q6VA==
X-Received: by 2002:a1c:81cc:: with SMTP id c195mr17510418wmd.61.1554715901986;
        Mon, 08 Apr 2019 02:31:41 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c10sm36777427wru.83.2019.04.08.02.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:31:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] arm64: dts: meson-g12a: Add VPU and HDMI related nodes
Date:   Mon,  8 Apr 2019 11:31:35 +0200
Message-Id: <20190408093139.27161-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408093139.27161-1-narmstrong@baylibre.com>
References: <20190408093139.27161-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VPU and HDMI display support.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 131 ++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 858ddd68665c..a696612f8f44 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -109,6 +109,37 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff600000 0x0 0x200000>;
 
+			hdmi_tx: hdmi-tx@0 {
+				compatible = "amlogic,meson-g12a-dw-hdmi";
+				reg = <0x0 0x0 0x0 0x10000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
+				resets = <&reset RESET_HDMITX_CAPB3>,
+					 <&reset RESET_HDMITX_PHY>,
+					 <&reset RESET_HDMITX>;
+				reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
+				clocks = <&clkc CLKID_HDMI>,
+					 <&clkc CLKID_HTX_PCLK>,
+					 <&clkc CLKID_VPU_INTR>;
+				clock-names = "isfr", "iahb", "venci";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+
+				/* VPU VENC Input */
+				hdmi_tx_venc_port: port@0 {
+					reg = <0>;
+
+					hdmi_tx_in: endpoint {
+						remote-endpoint = <&hdmi_tx_out>;
+					};
+				};
+
+				/* TMDS Output */
+				hdmi_tx_tmds_port: port@1 {
+					reg = <1>;
+				};
+			};
+
 			periphs: bus@34400 {
 				compatible = "simple-bus";
 				reg = <0x0 0x34400 0x0 0x400>;
@@ -138,6 +169,23 @@
 						gpio-ranges = <&periphs_pinctrl 0 0 86>;
 					};
 
+					hdmitx_ddc_pins: hdmitx_ddc {
+						mux {
+							groups = "hdmitx_sda",
+								 "hdmitx_sck";
+							function = "hdmitx";
+							bias-disable;
+						};
+					};
+
+					hdmitx_hpd_pins: hdmitx_hpd {
+						mux {
+							groups = "hdmitx_hpd_in";
+							function = "hdmitx";
+							bias-disable;
+						};
+					};
+
 					uart_a_pins: uart-a {
 						mux {
 							groups = "uart_a_tx",
@@ -195,6 +243,19 @@
 				#phy-cells = <0>;
 			};
 
+			dmc: bus@38000 {
+				compatible = "simple-bus";
+				reg = <0x0 0x38000 0x0 0x400>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x38000 0x0 0x400>;
+
+				canvas: video-lut@48 {
+					compatible = "amlogic,canvas";
+					reg = <0x0 0x48 0x0 0x14>;
+				};
+			};
+
 			usb2_phy1: phy@3a000 {
 				compatible = "amlogic,g12a-usb2-phy";
 				reg = <0x0 0x3a000 0x0 0x2000>;
@@ -262,6 +323,50 @@
 					clock-names = "xtal", "mpeg-clk";
 				};
 
+				pwrc_vpu: power-controller-vpu {
+					compatible = "amlogic,meson-g12a-pwrc-vpu";
+					#power-domain-cells = <0>;
+					amlogic,hhi-sysctrl = <&hhi>;
+					resets = <&reset RESET_VIU>,
+						 <&reset RESET_VENC>,
+						 <&reset RESET_VCBUS>,
+						 <&reset RESET_BT656>,
+						 <&reset RESET_RDMA>,
+						 <&reset RESET_VENCI>,
+						 <&reset RESET_VENCP>,
+						 <&reset RESET_VDAC>,
+						 <&reset RESET_VDI6>,
+						 <&reset RESET_VENCL>,
+						 <&reset RESET_VID_LOCK>;
+					clocks = <&clkc CLKID_VPU>,
+						 <&clkc CLKID_VAPB>;
+					clock-names = "vpu", "vapb";
+					/*
+					 * VPU clocking is provided by two identical clock paths
+					 * VPU_0 and VPU_1 muxed to a single clock by a glitch
+					 * free mux to safely change frequency while running.
+					 * Same for VAPB but with a final gate after the glitch free mux.
+					 */
+					assigned-clocks = <&clkc CLKID_VPU_0_SEL>,
+							  <&clkc CLKID_VPU_0>,
+							  <&clkc CLKID_VPU>, /* Glitch free mux */
+							  <&clkc CLKID_VAPB_0_SEL>,
+							  <&clkc CLKID_VAPB_0>,
+							  <&clkc CLKID_VAPB_SEL>; /* Glitch free mux */
+					assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+								 <0>, /* Do Nothing */
+								 <&clkc CLKID_VPU_0>,
+								 <&clkc CLKID_FCLK_DIV4>,
+								 <0>, /* Do Nothing */
+								 <&clkc CLKID_VAPB_0>;
+					assigned-clock-rates = <0>, /* Do Nothing */
+							       <666666666>,
+							       <0>, /* Do Nothing */
+							       <0>, /* Do Nothing */
+							       <250000000>,
+							       <0>; /* Do Nothing */
+				};
+
 				ao_pinctrl: pinctrl@14 {
 					compatible = "amlogic,meson-g12a-aobus-pinctrl";
 					#address-cells = <2>;
@@ -341,6 +446,32 @@
 			};
 		};
 
+		vpu: vpu@ff900000 {
+			compatible = "amlogic,meson-g12a-vpu";
+			reg = <0x0 0xff900000 0x0 0x100000>,
+			      <0x0 0xff63c000 0x0 0x1000>;
+			reg-names = "vpu", "hhi";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			amlogic,canvas = <&canvas>;
+			power-domains = <&pwrc_vpu>;
+
+			/* CVBS VDAC output port */
+			cvbs_vdac_port: port@0 {
+				reg = <0>;
+			};
+
+			/* HDMI-TX output port */
+			hdmi_tx_port: port@1 {
+				reg = <1>;
+
+				hdmi_tx_out: endpoint {
+					remote-endpoint = <&hdmi_tx_in>;
+				};
+			};
+		};
+
 		gic: interrupt-controller@ffc01000 {
 			compatible = "arm,gic-400";
 			reg = <0x0 0xffc01000 0 0x1000>,
-- 
2.21.0

