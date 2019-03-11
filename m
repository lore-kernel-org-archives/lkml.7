Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C18CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5B8206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RGJNY07d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfCKJ5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:57:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35009 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfCKJ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id t18so4317819wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MSNQTLqMB/8h3L0fCnZ1wRymG/adNoTDMkerJITNlY=;
        b=RGJNY07df0n0jjZPwALiz5w2XOskz7MC3nvGBA0RukWuLqFXaemuMNSzxzlLpORAde
         YpnNtHajDYuFJZ58QhgL9Tr/haPLbpL4h5GY9sAL9cQiXeGecXvfNoNNjAHRGHDbHqw/
         RwWBdvi7cjE8DTzrNAPverd3yXaeiLaDxg6FjJurfCCqe89f8SzjnatBPDJQqNL+ATSb
         9C8z1EkIW9ZwheSnWyBYAvCcr055w5wuQW+p+4VAptPftuZvx64RsnmzmEwxDRkbuopk
         Pn0DBmKQ8Yj6zHhXG57J/B9LBgZ/EJmBL0FLbYzE1bNFWKfO2fcFarJ21KC4wymm/95D
         mdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MSNQTLqMB/8h3L0fCnZ1wRymG/adNoTDMkerJITNlY=;
        b=N2FMbVsRV0GH7jmHEgeu+ZVdUIgu2IclMZJSSMkbBgd+DLu1klLrDEUPFJw2fRMlcq
         a6NtvMlqBS+isQpMFlP+ZYJjTEDBGaE8m152jDcKnPbJjHH/+1oY8uI3PNKPrP+qsYFY
         hFw4osu8ttACXcTHiMqMSxa6KQE73hQUF6ZSX9gOmJja0ozVhm6Hqv+I+byDZwgSR4tI
         /1tBP+lAoIkdxBPqKlLsGoOU6mk8WqZqLXVyPAb6N28DaovzvLDrVvl3J/LPupIUUs9o
         Oa47zA7Y/R4A2gVgDytCOazO5GmIR+OPOVUmo8mVG2rQ6Yj0V3s2Fghn/jzpEwlpi7Lx
         jErA==
X-Gm-Message-State: APjAAAXAYXvIT5XdU1Ofp0rzpCI5tAUUJ0MHem4iQwTIM0DHAM+w3IDX
        TDBrd4+D6baLNW1YPY9+u2EkIR+2e1dehQ==
X-Google-Smtp-Source: APXvYqzy6AxK7m7X0/HRKIqJMolEaNRyk1YblL79Pj5DcTJ/AAFCC6EVX2k0jYZX2oQ1/Sl9rQf5pA==
X-Received: by 2002:adf:f690:: with SMTP id v16mr19993910wrp.139.1552298183370;
        Mon, 11 Mar 2019 02:56:23 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] arm64: dts: meson-g12a-sei510: Add ADC Key and BT support
Date:   Mon, 11 Mar 2019 10:56:10 +0100
Message-Id: <20190311095613.11371-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
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
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 2b11b5893958..3d230545122e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 
 #include "meson-g12a.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
 
 / {
 	compatible = "seirobotics,sei510", "amlogic,g12a";
@@ -15,6 +17,19 @@
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
@@ -85,7 +100,23 @@
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

