Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB13C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDAC20675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mwqwPElR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfENJQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:16:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33585 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENJQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:16:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so9945991wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 02:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQxKZYI/w8DMXMSBGmGRGcJhp1dgIyZNVNnv6yd34UI=;
        b=mwqwPElROfHEc3Bz9sh7TzW90jpe117C1IEvXl20A2ih7GihRMBg/5AtdkYB58EpKX
         WMdoYrQRVrTh7p5bJmFQJsnoQLMecuqWBPRaHBYzJDj367jbJ8wX1KntMczNOHNw1mM2
         vDNO79ghUwWSc6uCwkxo1Xgbu/BRkJawUBbwBRy8aRlVrB5pXdV0t0VDiFUcvLOhDHJO
         /TKvPJiLeIz+z4QOGD1ryi+u0kbZTN1CWnrAMl0iMysN4R/P0Mlpsrk3eOcE2Rm2dNCD
         9X+6me/HJs6Q+g4PpxKQ28as9tcEkqqkjPC4140f53dvkg5jWNgXU+BRRlqu/J+mXZGS
         YMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQxKZYI/w8DMXMSBGmGRGcJhp1dgIyZNVNnv6yd34UI=;
        b=XnG94B9FDTm+TTOLn2zb5pLtfgSTvHp2Ip/8YFOdEn7zDEA0PVINEouz0OdKX5IHel
         ojH7r6H74VPekFNHfOVdMdRTGaEauaa5DNI5JkzSFAcPiLGKIba9IAfeA26VLycH+H8d
         hGSRXYaGLu3c9iF9cWkrDhTl/ZOVUZATTgw7tZVk54PYS1jppW7swbhTfqI2Y/iNPjw/
         oIL5vc8cUCdu2LBojLCd/63huV05oih+Zw1TpADWgxe/l7zgWJ9fr1mP29O3T151B2ov
         ZY+BkFkHH4hg107s5BxA/0zfvhidTXVeHMN8zfRWK5VTBTMpcKAJYvGeBCujkIbJG8NU
         8A0A==
X-Gm-Message-State: APjAAAW4eG+Woh241qwNmJM81OkvYjgQQ8glQ3j5LyBBWot9y4nKtxHb
        8xAJ2J+6wsvhJHfo5NfVxlFt9A==
X-Google-Smtp-Source: APXvYqwQvWBm2vnZF+njyEJ2UyL/mdGZxyMvdaLonnBOMXS9Fe73FCQduk5t12exPRvhXF8DLy+t6Q==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr8179544wrx.145.1557825375605;
        Tue, 14 May 2019 02:16:15 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y40sm17737158wrd.96.2019.05.14.02.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 02:16:15 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: meson: g12a: add mmc nodes
Date:   Tue, 14 May 2019 11:16:09 +0200
Message-Id: <20190514091611.15278-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514091611.15278-1-jbrunet@baylibre.com>
References: <20190514091611.15278-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add port B (sdcard) and port C (eMMC) pinctrl and controllers nodes to
the g12a DT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 124 ++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 2f4f4dd54cba..b2f08fc96568 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -185,6 +185,48 @@
 						};
 					};
 
+					emmc_pins: emmc {
+						mux-0 {
+							groups = "emmc_nand_d0",
+								 "emmc_nand_d1",
+								 "emmc_nand_d2",
+								 "emmc_nand_d3",
+								 "emmc_nand_d4",
+								 "emmc_nand_d5",
+								 "emmc_nand_d6",
+								 "emmc_nand_d7",
+								 "emmc_cmd";
+							function = "emmc";
+							bias-pull-up;
+							drive-strength-microamp = <4000>;
+						};
+
+						mux-1 {
+							groups = "emmc_clk";
+							function = "emmc";
+							bias-disable;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					emmc_ds_pins: emmc-ds {
+						mux {
+							groups = "emmc_nand_ds";
+							function = "emmc";
+							bias-pull-down;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					emmc_clk_gate_pins: emmc_clk_gate {
+						mux {
+							groups = "BOOT_8";
+							function = "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
 					hdmitx_ddc_pins: hdmitx_ddc {
 						mux {
 							groups = "hdmitx_sda",
@@ -290,6 +332,64 @@
 						};
 					};
 
+					sdcard_c_pins: sdcard_c {
+						mux-0 {
+							groups = "sdcard_d0_c",
+								 "sdcard_d1_c",
+								 "sdcard_d2_c",
+								 "sdcard_d3_c",
+								 "sdcard_cmd_c";
+							function = "sdcard";
+							bias-pull-up;
+							drive-strength-microamp = <4000>;
+						};
+
+						mux-1 {
+							groups = "sdcard_clk_c";
+							function = "sdcard";
+							bias-disable;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					sdcard_clk_gate_c_pins: sdcard_clk_gate_c {
+						mux {
+							groups = "GPIOC_4";
+							function = "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					sdcard_z_pins: sdcard_z {
+						mux-0 {
+							groups = "sdcard_d0_z",
+								 "sdcard_d1_z",
+								 "sdcard_d2_z",
+								 "sdcard_d3_z",
+								 "sdcard_cmd_z";
+							function = "sdcard";
+							bias-pull-up;
+							drive-strength-microamp = <4000>;
+						};
+
+						mux-1 {
+							groups = "sdcard_clk_z";
+							function = "sdcard";
+							bias-disable;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					sdcard_clk_gate_z_pins: sdcard_clk_gate_z {
+						mux {
+							groups = "GPIOZ_6";
+							function = "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
 					uart_a_pins: uart-a {
 						mux {
 							groups = "uart_a_tx",
@@ -759,6 +859,30 @@
 			};
 		};
 
+		sd_emmc_b: sd@ffe05000 {
+			compatible = "amlogic,meson-axg-mmc";
+			reg = <0x0 0xffe05000 0x0 0x800>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+			clocks = <&clkc CLKID_SD_EMMC_B>,
+				 <&clkc CLKID_SD_EMMC_B_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "core", "clkin0", "clkin1";
+			resets = <&reset RESET_SD_EMMC_B>;
+		};
+
+		sd_emmc_c: mmc@ffe07000 {
+			compatible = "amlogic,meson-axg-mmc";
+			reg = <0x0 0xffe07000 0x0 0x800>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+			clocks = <&clkc CLKID_SD_EMMC_C>,
+				 <&clkc CLKID_SD_EMMC_C_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "core", "clkin0", "clkin1";
+			resets = <&reset RESET_SD_EMMC_C>;
+		};
+
 		usb: usb@ffe09000 {
 			status = "disabled";
 			compatible = "amlogic,meson-g12a-usb-ctrl";
-- 
2.20.1

