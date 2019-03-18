Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C32DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F092070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q2mm25yP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfCRKFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35890 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfCRKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so3632786wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTSmlAuPBb+wFgaEuXPpRyLK6j0/0XQ2Tmwdu0EaftU=;
        b=Q2mm25yPZpTAixhSBfuM11tBTZPawjVW8RLyhlZgr2LkqG/ArXBMqfPBD8oi0Cnf/M
         7WWOa2anbdQL7CoOhBlI6bV3FEeSAEBOXYnIbZjz+ovmroP9dC8HxQTvsMcYEzS2p3ro
         U7Kojl2qWPzl+NcA353n0+CEA6qe7I9SnZdYg6IDM/uQ/C4egsu3GBiR6y5Hag44szEE
         dP16aRBajcIr6ad/M1Oed689/4lS8/Uq8klpoYKxEboDDGn3ADCXhE/15HdNe/74+Vvh
         UPO3EjpZe8+ijiH4vrc+Q9UemFUIOUTUQY6d0I03WW/ZosBg1xvjYf835Njdp98BESbt
         Q2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTSmlAuPBb+wFgaEuXPpRyLK6j0/0XQ2Tmwdu0EaftU=;
        b=HodqEoGK8q7tLy6XPk2KMGHsH1eWTXaSt8ckt4wQcv62siIPRspEurbEf/LX9FvJNe
         GM/2fRaKPabHDXiSLkJ4hVXpqQFRFcfvuonCt+9PElw+kbxPJp5tTaJr6teJkLBzgZYb
         ZW/Oc2NcrgTCRlbEfagdDZ/Vk9yApmeGbfYlhdGIb0fyn2ltO/qKoEe48jLKqv535YUC
         J6BKf9XignGiGzpKDMlChNXiMhQt0X4lPvemCzYcYQ8rwiifXyCqqqyXuSP9G/qHykWh
         kdFSgV92JNyWjCtSXo3rBHgfujoBfO2UAwX7OLiiBu9AIZeVRsjFJKpLSCr/HkrhSNXr
         /rFw==
X-Gm-Message-State: APjAAAWCEg5RDenTh2rclB9rYy2gwOqNNDyBS0ZSJlCcA6iWcagsXUWb
        zOcw3L4CbhY4GPIlxBBahW5lWg==
X-Google-Smtp-Source: APXvYqwVQ1pVzmsB48agHDckPFiHVmwqyBVJ5BGRS7CkFn3MEPbM1qlEtrwYIxu8AYXsdVtnrT5dDw==
X-Received: by 2002:a1c:eb17:: with SMTP id j23mr10073625wmh.86.1552903508027;
        Mon, 18 Mar 2019 03:05:08 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] arm64: dts: meson-g12a-sei510: Add ADC Key and BT support
Date:   Mon, 18 Mar 2019 11:04:55 +0100
Message-Id: <20190318100458.5619-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
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
2.20.1

