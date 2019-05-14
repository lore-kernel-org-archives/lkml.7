Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F057621537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q61k1/l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfENO1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:27:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35283 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfENO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:27:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so3061757wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NB4wFjsFSmLfPCJtbXxNDuKBTIpaZx/di4/nDYzLvsw=;
        b=Q61k1/l5razWWfxeUvhVAYiLE0WM9LBaIr63QF4XvYHXPSVIF616RTdrRmvtVwKxcT
         9yFVjGu4dAiDGoO49zauwVTOrXyZRD3AKdcudlUfhRbnifMDlF37YQoi1uTRsMgwI16U
         fcef79cqgUrwPNE66QQyTlS/5TB6tOmglEyC+bAPk/qZw81gs7DBjNxvp941DXIvMPn8
         1jQpAI+nFwBsJHRjvDFww5bO5saxgiGlH3BTl0G5dtAcc4WMRXdW/HRL571wPFGOGZOE
         xCIwbmI/vvno9QLys6EpgePvUtAL7mzFXG22A0oDnyURC0qtziTAcAdwu4s6PXQgiTLS
         9kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NB4wFjsFSmLfPCJtbXxNDuKBTIpaZx/di4/nDYzLvsw=;
        b=d/mdH/mESRDjr345vIuwjMQEDcmKsGqewyyeSBa+2J9jUbMKiN/4P/+D32rnsrzNo/
         IiHCeJd/lbdfGU1VBWyU8lGAGIsPTO5/aP+DiuXHy8e5Ctp6qw5gLWuTE67LaV3e3NEY
         loaRtp0gPWot6ELfVj7d2tznRwKok8H6WuypJUl3jOGE0WlBlFV+OHsQLdLmE5qhwcsT
         lPzshK1xjpIbLj9YW1ycp0oERhGyBNFxVlzLJBhamc1pFC7UeTdSgvxCDwG4/KiiYyDH
         wGKcx7B/IIfQruY6gFZ+vzukdyX/aptVpjJkxys4byhSH1SngKllV5X5AS850zQnHCfA
         qukw==
X-Gm-Message-State: APjAAAU1z50PGlRauhIZGDJyI87pGCFcnJCzW9IAHeL7vVbJI5dvOyAd
        gkyEz+wO2gTHLakrP/mRXwA6Bg==
X-Google-Smtp-Source: APXvYqyU/3/fAV3BzkuHwXh/rWhZl4YtsLU5i/fvV85xMyst/sryZBpu7rtso6l4dHngK5PtK7KAVg==
X-Received: by 2002:a1c:be0b:: with SMTP id o11mr15873789wmf.63.1557844019631;
        Tue, 14 May 2019 07:26:59 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm12343642wru.52.2019.05.14.07.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:26:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] arm64: dts: meson: g12a: add tdm
Date:   Tue, 14 May 2019 16:26:45 +0200
Message-Id: <20190514142649.1127-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514142649.1127-1-jbrunet@baylibre.com>
References: <20190514142649.1127-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devices and pinctrl definitions for the tdm interfaces of
the g12a SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 658 ++++++++++++++++++++
 1 file changed, 658 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 935a84b9f836..40a82ddda79f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -20,6 +20,39 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	tdmif_a: audio-controller-0 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_A";
+		clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
+		clock-names = "mclk", "sclk", "lrclk";
+		status = "disabled";
+	};
+
+	tdmif_b: audio-controller-1 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_B";
+		clocks = <&clkc_audio AUD_CLKID_MST_B_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>;
+		clock-names = "mclk", "sclk", "lrclk";
+		status = "disabled";
+	};
+
+	tdmif_c: audio-controller-2 {
+		compatible = "amlogic,axg-tdm-iface";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TDM_C";
+		clocks = <&clkc_audio AUD_CLKID_MST_C_MCLK>,
+			 <&clkc_audio AUD_CLKID_MST_C_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_C_LRCLK>;
+		clock-names = "mclk", "sclk", "lrclk";
+		status = "disabled";
+	};
+
 	cpus {
 		#address-cells = <0x2>;
 		#size-cells = <0x0>;
@@ -428,6 +461,42 @@
 						};
 					};
 
+					mclk0_a_pins: mclk0-a {
+						mux {
+							groups = "mclk0_a";
+							function = "mclk0";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					mclk1_a_pins: mclk1-a {
+						mux {
+							groups = "mclk1_a";
+							function = "mclk1";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					mclk1_x_pins: mclk1-x {
+						mux {
+							groups = "mclk1_x";
+							function = "mclk1";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					mclk1_z_pins: mclk1-z {
+						mux {
+							groups = "mclk1_z";
+							function = "mclk1";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
 					pwm_a_pins: pwm-a {
 						mux {
 							groups = "pwm_a";
@@ -574,6 +643,399 @@
 						};
 					};
 
+					tdm_a_din0_pins: tdm-a-din0 {
+						mux {
+							groups = "tdm_a_din0";
+							function = "tdm_a";
+							bias-disable;
+						};
+					};
+
+
+					tdm_a_din1_pins: tdm-a-din1 {
+						mux {
+							groups = "tdm_a_din1";
+							function = "tdm_a";
+							bias-disable;
+						};
+					};
+
+					tdm_a_dout0_pins: tdm-a-dout0 {
+						mux {
+							groups = "tdm_a_dout0";
+							function = "tdm_a";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_a_dout1_pins: tdm-a-dout1 {
+						mux {
+							groups = "tdm_a_dout1";
+							function = "tdm_a";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_a_fs_pins: tdm-a-fs {
+						mux {
+							groups = "tdm_a_fs";
+							function = "tdm_a";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_a_sclk_pins: tdm-a-sclk {
+						mux {
+							groups = "tdm_a_sclk";
+							function = "tdm_a";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_a_slv_fs_pins: tdm-a-slv-fs {
+						mux {
+							groups = "tdm_a_slv_fs";
+							function = "tdm_a";
+							bias-disable;
+						};
+					};
+
+
+					tdm_a_slv_sclk_pins: tdm-a-slv-sclk {
+						mux {
+							groups = "tdm_a_slv_sclk";
+							function = "tdm_a";
+							bias-disable;
+						};
+					};
+
+					tdm_b_din0_pins: tdm-b-din0 {
+						mux {
+							groups = "tdm_b_din0";
+							function = "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_din1_pins: tdm-b-din1 {
+						mux {
+							groups = "tdm_b_din1";
+							function = "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_din2_pins: tdm-b-din2 {
+						mux {
+							groups = "tdm_b_din2";
+							function = "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_din3_a_pins: tdm-b-din3-a {
+						mux {
+							groups = "tdm_b_din3_a";
+							function = "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_din3_h_pins: tdm-b-din3-h {
+						mux {
+							groups = "tdm_b_din3_h";
+							function = "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_dout0_pins: tdm-b-dout0 {
+						mux {
+							groups = "tdm_b_dout0";
+							function = "tdm_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_b_dout1_pins: tdm-b-dout1 {
+						mux {
+							groups = "tdm_b_dout1";
+							function = "tdm_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_b_dout2_pins: tdm-b-dout2 {
+						mux {
+							groups = "tdm_b_dout2";
+							function = "tdm_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_b_dout3_a_pins: tdm-b-dout3-a {
+						mux {
+							groups = "tdm_b_dout3_a";
+							function = "tdm_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_b_dout3_h_pins: tdm-b-dout3-h {
+						mux {
+							groups = "tdm_b_dout3_h";
+							function = "tdm_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_b_fs_pins: tdm-b-fs {
+						mux {
+							groups = "tdm_b_fs";
+							function = "tdm_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_b_sclk_pins: tdm-b-sclk {
+						mux {
+							groups = "tdm_b_sclk";
+							function = "tdm_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_b_slv_fs_pins: tdm-b-slv-fs {
+						mux {
+							groups = "tdm_b_slv_fs";
+							function = "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_b_slv_sclk_pins: tdm-b-slv-sclk {
+						mux {
+							groups = "tdm_b_slv_sclk";
+							function = "tdm_b";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din0_a_pins: tdm-c-din0-a {
+						mux {
+							groups = "tdm_c_din0_a";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din0_z_pins: tdm-c-din0-z {
+						mux {
+							groups = "tdm_c_din0_z";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din1_a_pins: tdm-c-din1-a {
+						mux {
+							groups = "tdm_c_din1_a";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din1_z_pins: tdm-c-din1-z {
+						mux {
+							groups = "tdm_c_din1_z";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din2_a_pins: tdm-c-din2-a {
+						mux {
+							groups = "tdm_c_din2_a";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din2_z_pins: tdm-c-din2-z {
+						mux {
+							groups = "tdm_c_din2_z";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din3_a_pins: tdm-c-din3-a {
+						mux {
+							groups = "tdm_c_din3_a";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_din3_z_pins: tdm-c-din3-z {
+						mux {
+							groups = "tdm_c_din3_z";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_dout0_a_pins: tdm-c-dout0-a {
+						mux {
+							groups = "tdm_c_dout0_a";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_dout0_z_pins: tdm-c-dout0-z {
+						mux {
+							groups = "tdm_c_dout0_z";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_dout1_a_pins: tdm-c-dout1-a {
+						mux {
+							groups = "tdm_c_dout1_a";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_dout1_z_pins: tdm-c-dout1-z {
+						mux {
+							groups = "tdm_c_dout1_z";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_dout2_a_pins: tdm-c-dout2-a {
+						mux {
+							groups = "tdm_c_dout2_a";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_dout2_z_pins: tdm-c-dout2-z {
+						mux {
+							groups = "tdm_c_dout2_z";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_dout3_a_pins: tdm-c-dout3-a {
+						mux {
+							groups = "tdm_c_dout3_a";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_dout3_z_pins: tdm-c-dout3-z {
+						mux {
+							groups = "tdm_c_dout3_z";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_fs_a_pins: tdm-c-fs-a {
+						mux {
+							groups = "tdm_c_fs_a";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_fs_z_pins: tdm-c-fs-z {
+						mux {
+							groups = "tdm_c_fs_z";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_sclk_a_pins: tdm-c-sclk-a {
+						mux {
+							groups = "tdm_c_sclk_a";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_sclk_z_pins: tdm-c-sclk-z {
+						mux {
+							groups = "tdm_c_sclk_z";
+							function = "tdm_c";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_c_slv_fs_a_pins: tdm-c-slv-fs-a {
+						mux {
+							groups = "tdm_c_slv_fs_a";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_slv_fs_z_pins: tdm-c-slv-fs-z {
+						mux {
+							groups = "tdm_c_slv_fs_z";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_slv_sclk_a_pins: tdm-c-slv-sclk-a {
+						mux {
+							groups = "tdm_c_slv_sclk_a";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
+					tdm_c_slv_sclk_z_pins: tdm-c-slv-sclk-z {
+						mux {
+							groups = "tdm_c_slv_sclk_z";
+							function = "tdm_c";
+							bias-disable;
+						};
+					};
+
 					uart_a_pins: uart-a {
 						mux {
 							groups = "uart_a_tx",
@@ -789,6 +1251,108 @@
 					#reset-cells = <1>;
 					clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
 				};
+
+				tdmin_a: audio-controller@300 {
+					compatible = "amlogic,g12a-tdmin",
+						     "amlogic,axg-tdmin";
+					reg = <0x0 0x300 0x0 0x40>;
+					sound-name-prefix = "TDMIN_A";
+					clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status = "disabled";
+				};
+
+				tdmin_b: audio-controller@340 {
+					compatible = "amlogic,g12a-tdmin",
+						     "amlogic,axg-tdmin";
+					reg = <0x0 0x340 0x0 0x40>;
+					sound-name-prefix = "TDMIN_B";
+					clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status = "disabled";
+				};
+
+				tdmin_c: audio-controller@380 {
+					compatible = "amlogic,g12a-tdmin",
+						     "amlogic,axg-tdmin";
+					reg = <0x0 0x380 0x0 0x40>;
+					sound-name-prefix = "TDMIN_C";
+					clocks = <&clkc_audio AUD_CLKID_TDMIN_C>,
+						 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status = "disabled";
+				};
+
+				tdmin_lb: audio-controller@3c0 {
+					compatible = "amlogic,g12a-tdmin",
+						     "amlogic,axg-tdmin";
+					reg = <0x0 0x3c0 0x0 0x40>;
+					sound-name-prefix = "TDMIN_LB";
+					clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status = "disabled";
+				};
+
+				tdmout_a: audio-controller@500 {
+					compatible = "amlogic,g12a-tdmout";
+					reg = <0x0 0x500 0x0 0x40>;
+					sound-name-prefix = "TDMOUT_A";
+					clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status = "disabled";
+				};
+
+				tdmout_b: audio-controller@540 {
+					compatible = "amlogic,g12a-tdmout";
+					reg = <0x0 0x540 0x0 0x40>;
+					sound-name-prefix = "TDMOUT_B";
+					clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status = "disabled";
+				};
+
+				tdmout_c: audio-controller@580 {
+					compatible = "amlogic,g12a-tdmout";
+					reg = <0x0 0x580 0x0 0x40>;
+					sound-name-prefix = "TDMOUT_C";
+					clocks = <&clkc_audio AUD_CLKID_TDMOUT_C>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK_SEL>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>,
+						 <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>;
+					clock-names = "pclk", "sclk", "sclk_sel",
+						      "lrclk", "lrclk_sel";
+					status = "disabled";
+				};
 			};
 
 			usb3_pcie_phy: phy@46000 {
@@ -925,6 +1489,100 @@
 						};
 					};
 
+					mclk0_ao_pins: mclk0-ao {
+						mux {
+							groups = "mclk0_ao";
+							function = "mclk0_ao";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_ao_b_din0_pins: tdm-ao-b-din0 {
+						mux {
+							groups = "tdm_ao_b_din0";
+							function = "tdm_ao_b";
+							bias-disable;
+						};
+					};
+
+					tdm_ao_b_din1_pins: tdm-ao-b-din1 {
+						mux {
+							groups = "tdm_ao_b_din1";
+							function = "tdm_ao_b";
+							bias-disable;
+						};
+					};
+
+					tdm_ao_b_din2_pins: tdm-ao-b-din2 {
+						mux {
+							groups = "tdm_ao_b_din2";
+							function = "tdm_ao_b";
+							bias-disable;
+						};
+					};
+
+					tdm_ao_b_dout0_pins: tdm-ao-b-dout0 {
+						mux {
+							groups = "tdm_ao_b_dout0";
+							function = "tdm_ao_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_ao_b_dout1_pins: tdm-ao-b-dout1 {
+						mux {
+							groups = "tdm_ao_b_dout1";
+							function = "tdm_ao_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_ao_b_dout2_pins: tdm-ao-b-dout2 {
+						mux {
+							groups = "tdm_ao_b_dout2";
+							function = "tdm_ao_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_ao_b_fs_pins: tdm-ao-b-fs {
+						mux {
+							groups = "tdm_ao_b_fs";
+							function = "tdm_ao_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_ao_b_sclk_pins: tdm-ao-b-sclk {
+						mux {
+							groups = "tdm_ao_b_sclk";
+							function = "tdm_ao_b";
+							bias-disable;
+							drive-strength-microamp = <3000>;
+						};
+					};
+
+					tdm_ao_b_slv_fs_pins: tdm-ao-b-slv-fs {
+						mux {
+							groups = "tdm_ao_b_slv_fs";
+							function = "tdm_ao_b";
+							bias-disable;
+						};
+					};
+
+					tdm_ao_b_slv_sclk_pins: tdm-ao-b-slv-sclk {
+						mux {
+							groups = "tdm_ao_b_slv_sclk";
+							function = "tdm_ao_b";
+							bias-disable;
+						};
+					};
+
 					uart_ao_a_pins: uart-a-ao {
 						mux {
 							groups = "uart_ao_a_tx",
-- 
2.20.1

