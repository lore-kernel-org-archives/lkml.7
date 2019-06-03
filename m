Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81390C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A6E28075
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gEBC5aL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfFCKEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:04:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35493 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfFCKED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:04:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so11377753wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9lcLmPi8XMHiXaXMu2ntTG9e0dgqGl+ZMcMDCcYGe4=;
        b=gEBC5aL1kPVPR+LUHjfVvz0ksvv2DkipPibJaPYpBIPdIqcM+Wcug6FummvXcULaSt
         /Ak+nz2LW/+jWrdpXj/9L3uqCtc/L/EQhvRcc+qNcnX+sa7SEKxtWOQmPJc+djEPENPL
         ag8UllJ6ZX10pf/GraIjEOQZE+zOnxTzDRK7nWjNgtib/eG3aucWdr1ZVJu/DJ64w9J2
         eGtUk6ICjuCy73lD1JthOtI4xIwTtmD6KtJColr4X0ifGIEAfakyl+9LAP6HVYhw9xPv
         ipt8IIFLV7TXnaHsvB9MpKt745rrzjKVNxLpXCcD6NGOCkhz2U60c9CV9mZhFlJk/RdP
         1OMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9lcLmPi8XMHiXaXMu2ntTG9e0dgqGl+ZMcMDCcYGe4=;
        b=fk69fjwEVIkoL5ZZFXqaKJrkWIlB7rBTItejPpDm7zkPzppxgLY4OE9/IrrJd1l5UA
         z72sYtNfKyG9oXFJoWxUm/GnismIoenwHNp1g6lpTc1/lIucT8+nQWvnPp4Y41oZSmj9
         x+JNIyy3Rr2zPI5FBjYthjIeT4G2ETjMuNvIqrfW7EazUbOVjy58EhjRv1nBy/sqCaN6
         ZBIuSncBYuvaEnqMIbffDPjqyeU7maKP/xW8/oknnJSr62o8X+rghYdx71f4TDP7idUC
         VazciWb0d7rxv5v1iQychHgfllB/+wp+mUzJVBtlA83TEFeF5tNoOk7jANMjMUrTpHAI
         Jjaw==
X-Gm-Message-State: APjAAAVJzRlalsOF6qyqBeOKC4vov2O3cviICcpI0EmfSfWsDXH/rVO9
        u7AXX74GVFLVXvO5n0N1wahpag==
X-Google-Smtp-Source: APXvYqwdNaVQrH1Hfwg41zEcu8yAiSsSfc+9kG7/WdtS15tQvV/Gq7PthCS+3NtUj9DsCTd99kW1+w==
X-Received: by 2002:adf:e30d:: with SMTP id b13mr1845319wrj.246.1559556241668;
        Mon, 03 Jun 2019 03:04:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o3sm11282098wrv.94.2019.06.03.03.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 03:04:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/4] arm64: dts: meson-g12a-x96-max: Enable Wifi SDIO Module
Date:   Mon,  3 Jun 2019 12:03:56 +0200
Message-Id: <20190603100357.16799-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603100357.16799-1-narmstrong@baylibre.com>
References: <20190603100357.16799-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X96 Max embeds an AP6398S SDIO module, let's add the
corresponding SDIO, PWM clock and mmc-pwrseq nodes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 69aae6c03dc5..8b263ec1e7a2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -50,6 +50,13 @@
 		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+
 	flash_1v8: regulator-flash_1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "FLASH_1V8";
@@ -114,6 +121,13 @@
 		vin-supply = <&dc_in>;
 		regulator-always-on;
 	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+	};
 };
 
 &cec_AO {
@@ -155,6 +169,12 @@
 	pinctrl-names = "default";
 };
 
+&pwm_ef {
+	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
@@ -178,6 +198,34 @@
 	dr_mode = "host";
 };
 
+/* SDIO */
+&sd_emmc_a {
+	status = "okay";
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	max-frequency = <100000000>;
+
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddao_1v8>;
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
 /* SD card */
 &sd_emmc_b {
 	status = "okay";
-- 
2.21.0

