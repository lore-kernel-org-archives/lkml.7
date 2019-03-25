Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04597C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A1820870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="unWjUbO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfCYKPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:15:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40005 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfCYKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:15:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so9352386wri.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoab4q66SflsReoALbDgKiwEnwXi2XyBPYUBOHzp7t4=;
        b=unWjUbO6Ch2azEZc1/BUGuIJ+na9DBHks1DS8GwWQ51NyxdemjvbXVxyCybM3PnakQ
         4QYXOGQMQtW2EPekXAkW0dT1/YNNwP0SoaVIesX6POMy452VERFF4/Fw0aYdVUv+l0jK
         95+WtExEX3n6P347bN0lF8SlDA94VmuU3TSyAR4ATJrZJY9e3vJe0BUocidw2iJR6bOA
         kkrwxBY2NS8HqcDEyeLGBGxinBDC+6B8eyUBfE4C1DTBJ4rRjkmSxtpX04W7g+1T3THv
         LPlrsjIMwAhxCRq/PQZCkkJnQpbCDxoWxB1uFW3ZfvA9bmTo3iMsOFQ2GlX7mRrlwljJ
         4eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoab4q66SflsReoALbDgKiwEnwXi2XyBPYUBOHzp7t4=;
        b=XxkF6ScoHqSakB5qN/8pLrvtgP6PeTnaomjNtl/0xXDSosEr3H+WQvmMtfMaVuAHn/
         jrS12MqWzNy/V17jtUkL+/Ph+KgXi3DWDfLJEHqyGTQdv7pV70AnqqkYVgehQBZq5LNe
         UpOzQnu+hc9rxs4j+WqMDOoUlCc6MM3mhRLGy61WkbdxZZHbaHYDgEe5qJy2NWWbZTm0
         RV22X53BJJxlaCafrF6S3Uoif7iH/jVkUmpgM0iNyafhPr9kPXYaCeBrXmiI4hMOA8A0
         CcSo6PTO8YDsZi5/dx7Ze8IjPyLAMW/exrmmQi0mTqngHrOY9DRwNlMKD59mlkcpGa84
         XsHg==
X-Gm-Message-State: APjAAAU16o738YWyEOc6TLF7sPEPmiB2fqRpJLWNpuazk1yxrxvvybuZ
        sq2zDdmEz/jd+P1bwSHyIaqQxCfX5OX6oQ==
X-Google-Smtp-Source: APXvYqxkiZKmgF6aN+zHudSL0A7vUghhhzuSPZ6F7zd3zPZQwakOVlt++fn7s0EgmJs5W6hGjUsrWA==
X-Received: by 2002:adf:f101:: with SMTP id r1mr4984471wro.251.1553508898985;
        Mon, 25 Mar 2019 03:14:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v14sm20049484wrr.20.2019.03.25.03.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:14:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 3/6] arm64: dts: meson-g12a-sei510: Add ADC Key and BT support
Date:   Mon, 25 Mar 2019 11:14:50 +0100
Message-Id: <20190325101453.3009-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325101453.3009-1-narmstrong@baylibre.com>
References: <20190325101453.3009-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the :
- ADC Touch key
- Bluetooth Module on UART A

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 43d57e20294a..ebdad5a192f1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -7,6 +7,7 @@
 
 #include "meson-g12a.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 
 / {
@@ -17,6 +18,19 @@
 		serial0 = &uart_AO;
 	};
 
+	adc_keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-onoff {
+			label = "On/Off";
+			linux,code = <KEY_POWER>;
+			press-threshold-microvolt = <1700000>;
+		};
+	};
+
 	ao_5v: regulator-ao_5v {
 		compatible = "regulator-fixed";
 		regulator-name = "AO_5V";
@@ -87,7 +101,23 @@
 		vin-supply = <&vddao_3v3>;
 		regulator-always-on;
 	};
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao1v8>;
+};
+
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
 
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &uart_AO {
-- 
2.21.0

