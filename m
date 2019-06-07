Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBB4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B013A208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m/K9VzHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfFGOrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:47:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40786 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfFGOrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:47:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so2448692wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/q31YJBntN7aERDn31WI4iT/fxCa5CdKI5jVgevLIGg=;
        b=m/K9VzHsqgtdqCgZnn8FiXFVa2tmOrV/uYTohpN41eUsEfmLuX4FjOkht0Es8GNV8M
         1rjOE/orKbGwIzp34kaqjOM/wWt7ZozDMQAdgZVG3UNqGaWECo/TbXHqW+u8zISJeXM2
         0H8/udl2i10r6WquXUwgiOsODs8vMYvOHya23dQ2JFbxx3YF+jffpCKHX36cHvlmy1Vo
         EPlhXiTqUHA/iEptOv6wCIlS1kJC1JirNrXHkaZqlL5aMmxFZMCEa9Ns3M8siQ7Exfl4
         /b5sdGGxvPBHz0YxcRzrGR5HsIkZEeDznqlljPXo607dbxGJdX8sYySfaPRrORFZljcn
         IU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/q31YJBntN7aERDn31WI4iT/fxCa5CdKI5jVgevLIGg=;
        b=FldjbHXCfq2xCfaGV4l9AbEUFebd7TtM+d3bjvzZGopkWXg2TxIl7AMF6ZObch8cQp
         cRHRAP8zYExzDtUgkKzkU5LJoClA0N7U1mzrNAZeF/QpDMRZNR4pmkbK3SbICcp5DT2I
         tmed4k4la7uvBRWlxrZ64mpU+uoqobUo8qDECD7GZ/WrRwWQy7zAucNkN5vA5GV7+GpI
         iaYJFxR3wC822XumstkODMJXEUm2dmd4lB8LyKJgOg8wz0tabxLkBGfTRGUqKsOHf1Vu
         F+NS0pOoFRH3Oi3LYfF5XgiHkpIn7aDj4Uif/vCdlE4GhWorImv4Fy1oP/tL0WfO2yI9
         l9qA==
X-Gm-Message-State: APjAAAUHsN42Gbz/gj/6v8Zp/oeWbRM7fOiPq6LbkeQjwfHp14YyBbqW
        6/GjnUf5fgl8ipc+wi0Bp5jR2whB/2XVYg==
X-Google-Smtp-Source: APXvYqx7nN0vbFi+WM1m4IK4O4uZDD/Xl1Qx+n1xucGQ8GFrcb+e0WJvGAdiLqpAfIS5NRuz4n7VyA==
X-Received: by 2002:a5d:6243:: with SMTP id m3mr3374922wrv.41.1559918860294;
        Fri, 07 Jun 2019 07:47:40 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q20sm5184516wra.36.2019.06.07.07.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 07:47:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/3] arm64: dts: meson-g12a-x96-max: add support for sdcard and emmc
Date:   Fri,  7 Jun 2019 16:47:33 +0200
Message-Id: <20190607144735.3829-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607144735.3829-1-narmstrong@baylibre.com>
References: <20190607144735.3829-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume La Roque <glaroque@baylibre.com>

Add nodes to support SDCard and onboard eMMC on the X96 Max.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 5cdc263b03e6..69aae6c03dc5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -45,6 +45,11 @@
 		};
 	};
 
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
 	flash_1v8: regulator-flash_1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "FLASH_1V8";
@@ -172,3 +177,38 @@
 	status = "okay";
 	dr_mode = "host";
 };
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddao_3v3>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	max-frequency = <100000000>;
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&flash_1v8>;
+};
-- 
2.21.0

