Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DC4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C640208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eqpJtEhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfFGOrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:47:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34074 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfFGOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:47:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so4244470wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZkZr6EziWsPNbkH40RoVyz/4NEqFV1sE9ycOq6JdzQ=;
        b=eqpJtEhpH+OXz8eQ5Au51p7DYK/OWw2oSYWxJqlNVdEnI71fvOcr/E5+N+gdn1pUe3
         v9tUucsG1pIVpd5sqmfpnmts843CPSFB42eEpmDQb8BhJlgPKAH/qGSUdQyv7KYk57Kt
         LjW7h3V+7V9gFsaVoGWBHrMx4AoCy1JDblj8xksshzoh4+PN56NbpqKAinTzGeCHSucM
         znwVx9TmGxqyLcjdHK1FPdQw7dpwPpdair3kWj06MtTosDkXEU99QEvyLXmuHVBqlPna
         DOLAoNyJNj4HYPpJJOle9JjI/9MdZYqfBSuhStGtNZ75Id4Yjov4ib8/cD4k8LwTZji9
         nm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZkZr6EziWsPNbkH40RoVyz/4NEqFV1sE9ycOq6JdzQ=;
        b=beY+6lMc4C9YVDHOVuDRRfwmMbRtcDKPVqRf9dMKHZ38ZVRtzN/4o02m+ZiuJf/6iS
         aa0wyWizH4kLU7v41OzrZ2HvzvnqZQhDCOCBQ8N6qHnFQMT6CLlA65bh8jm1IKiyzHT+
         /83m+DdZHXvrF5ZHABnSY3VbMK3rW1guYC1WACrpEbUIRLMfGdbFZvZWXl0lh/wG9zLr
         V/iv2B7pTCWgwV+UdctTxZ9zIg0AdOdNgHsm5tMVUw+B7A9otzH3cinUJh27K5J5Tbge
         OIvCSo62JqKTOOnMOZxMdN5a2A2k541Ey9l2Fmc5uDNhN8ySxfFeGZVqs/8MlwoZEwOJ
         kw6A==
X-Gm-Message-State: APjAAAUe0Lre1WD2cw86HpkeY3TD+fERHefpSm9S+0auBw7iIm/Xe4xj
        A+7r4iBLq7QWSaBTetLeThpHyA==
X-Google-Smtp-Source: APXvYqyDd2VI/H4vsvCIyOTgJOV/JMwi2X8GQ5jPzrFPlCxLzMvdW2iCCef0MhC5PTSOKQc9dwebdw==
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr3980950wms.8.1559918861330;
        Fri, 07 Jun 2019 07:47:41 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q20sm5184516wra.36.2019.06.07.07.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 07:47:40 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/3] arm64: dts: meson-g12a-x96-max: Enable Wifi SDIO Module
Date:   Fri,  7 Jun 2019 16:47:34 +0200
Message-Id: <20190607144735.3829-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607144735.3829-1-narmstrong@baylibre.com>
References: <20190607144735.3829-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X96 Max embeds an AP6398S SDIO module, let's add the
corresponding SDIO, PWM clock and mmc-pwrseq nodes.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 69aae6c03dc5..345c9277cc4c 100644
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
@@ -155,6 +169,14 @@
 	pinctrl-names = "default";
 };
 
+&pwm_ef {
+	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin0";
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
@@ -178,6 +200,34 @@
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

