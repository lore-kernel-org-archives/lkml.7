Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D935AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38AE2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iaDRYruC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfCYO7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:59:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38744 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCYO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:59:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id a188so9426321wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+rJnw6/sLHLZof/jwuQ07YQV1SUtaCLQpNMQKKSMv3Q=;
        b=iaDRYruCuNTMOcQdfqL3S0Jz+ip20OJQX4W0O828+b5XA1e4x3NW4yzTDaarMh4v9E
         8py6NFinhYXYWD4DK1r6e+cZjeXmXfXF9bZACMEL//O5zD60g6yPUa3R7+xNoXBU1RTx
         flhJvx1mIl4IHam5TnOHZEGZXe+rbFi4OEUBzG1g+96WKQZVDUNaUC1/KMY+BBqp3hRP
         F9aB/H/tRNZmQxpOzhYOgzRlP5wgzj7tzg8kYLbHDZC0KdwZK6MtUBeR8SDQ3q67qbRm
         PhMP3DydDsdilgmbdGvijILO62dBtPuvrlWRdMC2EW4Z32O0k+Yd1lUhg98qKwQpENjY
         2JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+rJnw6/sLHLZof/jwuQ07YQV1SUtaCLQpNMQKKSMv3Q=;
        b=PKFJLPD9Ry7A6ITAaLQikgD/QBJvo0zpKHEEMU9Ea1khfK6JseEJXaILodTqEYfa6B
         wL/2rW4MdcgWAC5QfA9B8HKnYlsappLF8sPiacrFI6eknIFxMiMhhy2sK0T51ZmGDaLS
         jqG67hmpw6nkUyCgw0YB5Lsu5shPnjtWwNy5GAg63FOaoL2Uf3ctgZqgQB0ERbcRF4nT
         9qrDuH3rtken67jsYp99Sgu7r09AWYnYo3a8JT9uiivtPjbKMCKp7iufSy8EoJCr3SRp
         CMaT7uVTflhgUhVm0Z4xEAi/1FRnIjzEOgr0euZePnupcr+xlB1Me3OIIO9W75fasmoy
         j7Zw==
X-Gm-Message-State: APjAAAUxDPV1bMBzWhqK6BjYtVRH3xjm71Vm3gtPqBEyfAtzqH89p2Rk
        eEEg9M3Noqn8j0eIo93gnq1b/1/5nnDEXw==
X-Google-Smtp-Source: APXvYqxuE4LLvTbBcNQoODorycPIwVUqrNlNMY4/nJ+V1JDWS8T+pSmvX9xsibLn4BjxVyez0BLGFg==
X-Received: by 2002:a1c:495:: with SMTP id 143mr5598598wme.78.1553525958622;
        Mon, 25 Mar 2019 07:59:18 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d11sm12836156wmb.19.2019.03.25.07.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:59:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64: dts: meson-g12a: Add VPU and HDMI related nodes
Date:   Mon, 25 Mar 2019 15:59:10 +0100
Message-Id: <20190325145914.32391-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325145914.32391-1-narmstrong@baylibre.com>
References: <20190325145914.32391-1-narmstrong@baylibre.com>
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
index c762e2309b2b..b0ff649bca46 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -101,6 +101,37 @@
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
@@ -130,6 +161,23 @@
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
@@ -187,6 +235,19 @@
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
@@ -254,6 +315,50 @@
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
@@ -333,6 +438,32 @@
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

