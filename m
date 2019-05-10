Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CFBC04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27C0216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cFKNU0Oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfEJPxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:53:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38170 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfEJPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:53:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id f2so8031243wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3EP7z+/Y2988kk6BnMUMk36B6V5NCtniTm81fwS2Dbs=;
        b=cFKNU0OcqMqoiGb6m1ldgJj9kCbZxCY5yi5zRW2m86v+sUh5A61vwHwpqkVX2pEEY5
         49PmLzkcpQRVolhLvdPmOz6Xy4SkgFcvFZ44srHes/W92AcadceBhgPHxfjAhqC/lzIX
         1UjyJ4MDmU9TlkoKjZjcH8hdm/nN+Gg0RznJ5LfVcZRHxJpvDA8ZGfcCDVJC2NuASqir
         QOm+SMuND8jf8pv8Pk0o6NTMWLVorhWNqvxZYFPnwg9klVyu6Zy6l1Vbz0dHTegi6lRK
         GnK89aVmmHSOWFoP3Mg2R7niF0PzggghPdOemyUS3bneafLw1dj48Xwb85KqOElPm9FE
         7ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3EP7z+/Y2988kk6BnMUMk36B6V5NCtniTm81fwS2Dbs=;
        b=Gat6uIxDfnqZL8nqVZFMg786hgdl4B6YuEd/CW/jOshjt62XJt5ppm/23lE9l7bNVn
         iETsqP5dxCl0OIGMei0q9W/j8LV7O9RA7Hx/bqZVrxQxEOxOHy2Gb6dOFk/2OyUdHw3K
         AoBkf4ghrnQTs5CcK4ewmKqHMXrK1Re6nwlIRejdM8IyBL9ffAFnmCXed8rSasrdhh9K
         Ki4rywXDkRbEb0YYBlqW8obkGwV7ulyP/cg+ioB+qVo4vdHbWDbV54lkPn7q3guQ48IM
         mht1CQtC6Z4dnbAKgUBWiz7Zo/38IR/NFBlgPEINnMgieVllHXQbGIxPf8+ahj5g+g6m
         GWgg==
X-Gm-Message-State: APjAAAVB8SVPvLV7BQ6hkEggNnA0FSWnbHz27iZUn3sHM/hDS9xoIsKc
        RgyOTnoO3INFoDACP70gNMEU9gwkkE4=
X-Google-Smtp-Source: APXvYqzh5gxUQdGkHLy2eVNCwryHDhyE+udqXnPcENAHefOjrlKuTk9eRsj7JcKr+/pK4merSPzd+g==
X-Received: by 2002:a1c:20c9:: with SMTP id g192mr7438658wmg.76.1557503611487;
        Fri, 10 May 2019 08:53:31 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id u14sm5333860wrn.30.2019.05.10.08.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 08:53:30 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: meson: sei510: consistently order nodes
Date:   Fri, 10 May 2019 17:53:26 +0200
Message-Id: <20190510155327.5759-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510155327.5759-1-jbrunet@baylibre.com>
References: <20190510155327.5759-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like order boards, order nodes by address then node names then aliases.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 92 +++++++++----------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 34b40587e5ef..61fb30047d7f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -14,10 +14,6 @@
 	compatible = "seirobotics,sei510", "amlogic,g12a";
 	model = "SEI Robotics SEI510";
 
-	aliases {
-		serial0 = &uart_AO;
-	};
-
 	adc_keys {
 		compatible = "adc-keys";
 		io-channels = <&saradc 0>;
@@ -31,13 +27,8 @@
 		};
 	};
 
-	ao_5v: regulator-ao_5v {
-		compatible = "regulator-fixed";
-		regulator-name = "AO_5V";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_in>;
-		regulator-always-on;
+	aliases {
+		serial0 = &uart_AO;
 	};
 
 	chosen {
@@ -54,23 +45,6 @@
 		};
 	};
 
-	dc_in: regulator-dc_in {
-		compatible = "regulator-fixed";
-		regulator-name = "DC_IN";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-	};
-
-	emmc_1v8: regulator-emmc_1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "EMMC_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vddao_3v3>;
-		regulator-always-on;
-	};
-
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -87,12 +61,30 @@
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
 
-	reserved-memory {
-		/* TEE Reserved Memory */
-		bl32_reserved: bl32@5000000 {
-			reg = <0x0 0x05300000 0x0 0x2000000>;
-			no-map;
-		};
+	ao_5v: regulator-ao_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "AO_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_in>;
+		regulator-always-on;
+	};
+
+	dc_in: regulator-dc_in {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_IN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	emmc_1v8: regulator-emmc_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "EMMC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
 	};
 
 	vddao_3v3: regulator-vddao_3v3 {
@@ -122,6 +114,14 @@
 		vin-supply = <&vddao_3v3>;
 		regulator-always-on;
 	};
+
+	reserved-memory {
+		/* TEE Reserved Memory */
+		bl32_reserved: bl32@5000000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+	};
 };
 
 &cec_AO {
@@ -144,6 +144,18 @@
 	};
 };
 
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vddio_ao1v8>;
@@ -161,18 +173,6 @@
 	};
 };
 
-&hdmi_tx {
-	status = "okay";
-	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
-	pinctrl-names = "default";
-};
-
-&hdmi_tx_tmds_port {
-	hdmi_tx_tmds_out: endpoint {
-		remote-endpoint = <&hdmi_connector_in>;
-	};
-};
-
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.20.1

