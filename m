Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC1EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C65E206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q7B5q3AT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfCYKDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:03:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35889 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730368AbfCYKDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:03:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so9372660wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHgKHPDIn4oZfNwrx5bv3RspG5o23PVCYfzbn1lDJUs=;
        b=Q7B5q3ATRV1w5atycDojfRWSj9ivifyCBPYS0daY12qNapjkoK43b0eBqNHOXH+YrT
         fhq/EeatGShg/HYIOGfNihuD4tk3lqCbYzSjlhPBl5WvJpoWBjW5euAFPSFF5Ie/JfXR
         UTZTLWF8vePvsFRK1JdD2NvaZKsbwFCUq76EQk9VWxVLI9JEOTP4LIEcIsdQMS6tYEO5
         LnLSQ2LdmTXBu5/78E02kPukL7b1nVncAOo5t1lvxEGJopsW7HhgjdBzXbR2dHtyNlUh
         AXp2mIKH6W3m0v4TG7dnjpGhvgOXkQKLbEFwu5sFmXcB3wjAjtJvzY8bOeb27N0Z1VbR
         OKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHgKHPDIn4oZfNwrx5bv3RspG5o23PVCYfzbn1lDJUs=;
        b=WKRg5UPQprCvrIkM9QUpMoPwHz1tNPkyK7gfhpNrLsjiCVL73gA6o0If+MKc53AqT7
         wVqFiVp3bebLgXzmTWcnd3SOT3exqGVHmf/Au7b0hG/29v4apBNKC/W2LXAd/tp/EV0L
         diCb9kSPD/u3U5voqqZSFamkI2slBuN3in7H82cACVWe0BNcHGhX/ZkbMHcMIF2VI2hV
         dfyOatc4lODwBSgObSWkWrGB6I0plZ9yWwGoKvIE4KNSqT5p7X0xstBdwGOBUgRjqYcM
         I2GdVsKX25YU3ysOJ7oY8fL+bLkU7RBotxKKMALpvcyJoFJlmRBTPeW88vZoOvaezKLc
         ZsTw==
X-Gm-Message-State: APjAAAUoVb61liKhK+VtOsG/Tq0jF56FIofr+KT/BoS7g/pcujjHGYDF
        J5bYnQCUxcl2XLNXrYPX+EVPBw==
X-Google-Smtp-Source: APXvYqwZO5I+FBNv4f7hxmGJMhPBljwSh9//kLnLhGX78HWEVWmzOWflknEr0SGlVnObuIL1OMOxmQ==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr14574387wro.232.1553508223264;
        Mon, 25 Mar 2019 03:03:43 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g12sm11581215wrw.40.2019.03.25.03.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:03:42 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/3] arm64: dts: meson: g12a: Add SAR ADC node
Date:   Mon, 25 Mar 2019 11:03:37 +0100
Message-Id: <20190325100339.749-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325100339.749-1-narmstrong@baylibre.com>
References: <20190325100339.749-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the SAR ADC controller node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 4d04742b05c2..4b3be7e60b4d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/g12a-clkc.h>
+#include <dt-bindings/clock/g12a-aoclkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -282,6 +283,20 @@
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			saradc: adc@9000 {
+				compatible = "amlogic,meson-g12a-saradc",
+					     "amlogic,meson-saradc";
+				reg = <0x0 0x9000 0x0 0x48>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>,
+					 <&clkc_AO CLKID_AO_SAR_ADC>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_CLK>,
+					 <&clkc_AO CLKID_AO_SAR_ADC_SEL>;
+				clock-names = "clkin", "core", "adc_clk", "adc_sel";
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller@ffc01000 {
-- 
2.21.0

