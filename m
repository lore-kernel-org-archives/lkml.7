Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F55720840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LJYbRSl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfCGPNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:13:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43344 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfCGPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:13:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so17844737wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g90x653fp10tWOEz2NsdqDP+qS+7JhLDzpCoi1kfPmo=;
        b=LJYbRSl9e48UyWFjWVOS8FsXzY4tY+BP+USZp0/nQIfYHijpq6xi+i273vkKLTAgLS
         Gvz8XxOWomYScRLdMdoWBn11HheL/WRcSGssxAwChbwLEItkEo6bem9id5x1Wvlb2wHQ
         OVGFruqk9cex+jsIqoQWSqdID87eWamQHjKuxOsZt07AIHMgsA6xghybwMo0GwirdPDH
         3Wp+8p1eNM5DR63q/BDI3UApDxaoqo5KVB755zzXQFxaTEmxEHH/z/bFaOkR0J8SFA9b
         T5OPKB5F0rq8TweQOHKrytI53vy7iebQQVzvQblfBpHDU6MN/wNn2JoUCW3KhZhDBwM1
         7aeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g90x653fp10tWOEz2NsdqDP+qS+7JhLDzpCoi1kfPmo=;
        b=bNdlZdMEEHNQc6d30Mi4QHopcc4smdlWcXvkkmkfsoyJO3GYGATkr2EraL6ZEXeKgl
         YWca8m1COgGAqH4EHIrPOTKOaLcwhRMjEjTtcuJ+RGrLmd8oHpG9LOEATNiAanJxS/JX
         AbA+xY0t3bHheZo46TE6Y7fsUHFNEOrq2LlZjx/S/FqFZqJ0fXqAMS6An4AtpdlK0WRZ
         LwfbwWVqYi6+EVUUKqEgAFmca6D8jzGuqztkGYIlc7QEXIL49zzB6VYwdzMyFBZcZpLS
         xxRKcEK7l3izvzyt3jV/bbE07FgWuajBMJuq98Galb1DqrBaQHL3IOBOC6ztQINJepfy
         qyxg==
X-Gm-Message-State: APjAAAUFGmiOl1Lap5qwm2rnigcObpV6RHU/UzdMFWMmMG79QmB5DRJn
        pZfLGLILDfk1P2DsryBYGBUAHQ==
X-Google-Smtp-Source: APXvYqyjTkFCM+4w0UmrWDhrI9RijhFS56AiX4SNVemfSJpcl7INIj7i7WGwmtPnMV/qrVG+QhgUgw==
X-Received: by 2002:adf:a49c:: with SMTP id g28mr6968409wrb.147.1551971628621;
        Thu, 07 Mar 2019 07:13:48 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r15sm5756563wrt.37.2019.03.07.07.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 07:13:48 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] arm64: dts: meson: g12a: Add UART A, B & C nodes and pins
Date:   Thu,  7 Mar 2019 16:13:38 +0100
Message-Id: <20190307151342.7381-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307151342.7381-1-narmstrong@baylibre.com>
References: <20190307151342.7381-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the 2 UART nodes in the EE power domain with the corresponding
pinctrl nodes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 82 +++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 2a700bb45d04..50e2cd36e08b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -113,6 +113,61 @@
 						#gpio-cells = <2>;
 						gpio-ranges = <&periphs_pinctrl 0 0 86>;
 					};
+
+					uart_a_pins: uart_a {
+						mux {
+							groups = "uart_a_tx",
+								 "uart_a_rx";
+							function = "uart_a";
+							bias-disable;
+						};
+					};
+
+					uart_a_cts_rts_pins: uart_a_cts_rts {
+						mux {
+							groups = "uart_a_cts",
+								 "uart_a_rts";
+							function = "uart_a";
+							bias-disable;
+						};
+					};
+
+					uart_ao_a_c_pins: uart_ao_a_c {
+						mux {
+							groups = "uart_ao_a_rx_c",
+								 "uart_ao_a_tx_c";
+							function = "uart_ao_a_c";
+							bias-disable;
+						};
+					};
+
+					uart_b_pins: uart_b {
+						mux {
+							groups = "uart_b_tx",
+								 "uart_b_rx";
+							function = "uart_b";
+							bias-disable;
+						};
+					};
+
+					uart_c_pins: uart_c {
+						mux {
+							groups = "uart_c_tx",
+								 "uart_c_rx";
+							function = "uart_c";
+							bias-disable;
+						};
+					};
+
+					uart_c_cts_rts_pins: uart_c_cts_rts {
+						mux {
+							groups = "uart_c_cts",
+								 "uart_c_rts";
+							function = "uart_c";
+							bias-disable;
+						};
+					};
+				};
 			};
 
 			hiu: bus@3c000 {
@@ -256,6 +311,33 @@
 				compatible = "amlogic,meson-g12a-clk-measure";
 				reg = <0x0 0x18000 0x0 0x10>;
 			};
+
+			uart_C: serial@22000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x22000 0x0 0x18>;
+				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+
+			uart_B: serial@23000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x23000 0x0 0x18>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+
+			uart_A: serial@24000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x24000 0x0 0x18>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.20.1

