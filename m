Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AD6C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2BC28070
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DdmABLlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfFCKEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:04:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55300 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfFCKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:04:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id 16so6073677wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 03:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMQH+YmMqEi+gsXseHBWQuJ/Imet99lfOVHmWm+WY1U=;
        b=DdmABLlIarebcQdqi3kcWqkFCKN8OCuNG59wewyDGcKAmrYKfr4JXLl1AP6wzl3YnU
         cafRtqasdDcyAiVJ1sbLHANKERnpmh+6duZfsY8gKWAXzaEw+YRofetU93bp1TwWWjT1
         2JQCeHyGP0sIj91aN+eYFRhbHw7QgLBofq5ImYTNMbTpKVhB3SI7gIdVQXuZs93/kyBY
         PHLRTZXOWh4QigbIJpr+9Plzf4c58yNlDaY1APglo5023V6SHJdFFiQgB5lpbkMjZGZh
         0j26+h44qPOXglXqXVh/dkcJ2Rfq5Qrmim/TrYizfEvchBGLPcnAvQplDPEl/jktQQJ5
         qilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMQH+YmMqEi+gsXseHBWQuJ/Imet99lfOVHmWm+WY1U=;
        b=QRsHXDbaskZGgTXx9u3w7/Iz0dBYzLvxWJc9LhShQs/tEnj4rY6BsbxnIgS8wRz0nu
         JnEUTiLnvJZMt3ErbB6hyU2E4/RDVex7lAzEOajB7Qqp65m0nOa25accSbdEEEJMn1UB
         UNLOICJLWBBrawypkc5pxM3LX45HKQ3CYcVxGe3iZpZhcipemMIHsStvQR82aJ7gDfGl
         jus7q49fbpKrOi7lCd0/t7DyeGNx82c/Kl+zJ1p2lP863T4VaWRMrSIq/cRGEgunYcm9
         wlx3o1vZ8+jQ52WKd5S787qC30Q1O8bhAnJEGty+UF9tzjTPqu5D6S9goHI/10upILGc
         UY2Q==
X-Gm-Message-State: APjAAAW5CLxOEn1q4E/YT0d8JHOvvGPbBqgJInJdQNRqmuCLa7GxJC8N
        eZQB6F2Ub+by35oh8lqsJRWwnQ==
X-Google-Smtp-Source: APXvYqxdgJNt/Z8H7RA95G1FQJxTUqwXFFclxWFD9X0UAVrW1pgptWbzt5ot7MgiYRg+s06Hj5jzqw==
X-Received: by 2002:a1c:5546:: with SMTP id j67mr1855939wmb.80.1559556242355;
        Mon, 03 Jun 2019 03:04:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o3sm11282098wrv.94.2019.06.03.03.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 03:04:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/4] arm64: dts: meson-g12a-sei510: Enable Wifi SDIO module
Date:   Mon,  3 Jun 2019 12:03:57 +0200
Message-Id: <20190603100357.16799-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603100357.16799-1-narmstrong@baylibre.com>
References: <20190603100357.16799-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SEI510 embeds an AP6398S SDIO module, let's add the
corresponding SDIO, PWM clock and mmc-pwrseq nodes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index be1d9ed6d521..5a97379f2417 100644
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
@@ -174,11 +188,45 @@
 	pinctrl-names = "default";
 };
 
+&pwm_ef {
+	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
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

