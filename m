Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1244C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9919C208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oOjhENZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfFGOrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:47:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54851 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbfFGOro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:47:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so2376600wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPTyfVIwA34LPg5YDvt9kvbQsjNuXGIsGhvwwUrhRvE=;
        b=oOjhENZqL4BhiLGy7B2SBUqZvF7HNB+Ur1xaBXLbkm9NDN7Wkxmv7Vn5iGauOR0BF/
         J/nlHAa6pwsIQsnWpFMnrHygtnbVU211VIDTH+eGKlf0K8dvS8qOJv3j9MRR6m0b6QF1
         c8g8TMX/8Gny7E+W+4eC3qHWXiTDPv27VPRFGqs39ax/KM5jtxrb2GgbwxZOZhQtkcHf
         meLo0oJwYZjBCggIl1Jt+vULGFaNDtLUcZRjR0kjoyzpP34NRtCqp4yhyna1iB57+12W
         Y1/iIu0aWZ8qtUtpbytmj2QAaM9xLz5HAEk45cdqhePq8a+CUcGkAA5msHhXjbmxQiAc
         pBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPTyfVIwA34LPg5YDvt9kvbQsjNuXGIsGhvwwUrhRvE=;
        b=ngVTGkKUvVfbsrzEetYYar6+hjjv2UG8lEKGNut84IRvDJvbf3AmMbjuPZDnU0O1Xp
         xy+IQSvWLHLHYEnY3fmnmn9z5UVCyohkjQD9CA4anSUFbInaO3c4TjLouWRNO8JF3Vqf
         2NVzxTwh77LE4OVJBSjK3puJkCwOiJYfLY8UoluTDvZ9dttD4/7tvOecfeQ+hc6/8orf
         MddU7F3bYHY7KwXaevWOE+y0QJq65rkIw+N6D6BzK5G6xa71C6PYHKXhRQGBnBMoxH+y
         f33nCmT4hwgnEd89HYFoP/Lzy2mrWnMazsDPPipuE4EWvl6IgNEsFoN9RuWLCCBFf5b5
         ATeg==
X-Gm-Message-State: APjAAAUxKdQ7f69wcmk7O81VySfyZyY0IW3Cv2foMIcSmMBI7BF4NyIj
        vqB0yLlxAR+hEn86bE7ka2e4wQ==
X-Google-Smtp-Source: APXvYqwWILUiwv79FHy2wYdmky8oGaRLMAzo72z4Mc1oYEnJ9iaUVsVj578xtD5mptsqtY9zca9QSg==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr3830844wme.12.1559918862691;
        Fri, 07 Jun 2019 07:47:42 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q20sm5184516wra.36.2019.06.07.07.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 07:47:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/3] arm64: dts: meson-g12a-sei510: Enable Wifi SDIO module
Date:   Fri,  7 Jun 2019 16:47:35 +0200
Message-Id: <20190607144735.3829-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607144735.3829-1-narmstrong@baylibre.com>
References: <20190607144735.3829-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SEI510 embeds an AP6398S SDIO module, let's add the
corresponding SDIO, PWM clock and mmc-pwrseq nodes.

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index be1d9ed6d521..a1821d850a6d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -128,6 +128,20 @@
 			no-map;
 		};
 	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+	};
 };
 
 &cec_AO {
@@ -174,11 +188,47 @@
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
 &saradc {
 	status = "okay";
 	vref-supply = <&vddio_ao1v8>;
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
+	vqmmc-supply = <&vddio_ao1v8>;
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

