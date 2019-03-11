Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F62C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885BA2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xTNsRIDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfCKJ4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:56:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38529 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfCKJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so3566813wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vd80S55Frb6CGjHBLvPF+QFGjEdspA5jjiX4inId9o=;
        b=xTNsRIDydRcgWEh+tsTla52WubKGreooa9VLwv8JP6SkimjYefF8rx8p6emQJh26Jm
         wtlmKGwOyiADzlLZly43pzSH8ngPmwqPD8niYNnmVPAh2aRAZDH7xTFd5Nw5z9zikU1y
         NvJe8oz/CmLFVNBKd7pdKVJhtylR1YRRUS0w7W1NE/YoWua6qPJKYMPbUE3fn2D5UzcB
         efTdtwRW06z8WtFHAb10aVTDm6dZFfXJm49wAHnV+Cf2K6W3jOcSczG562ggX47YOQuG
         9hi7hid5FCDr40p7PeoPY6xkmXt7XWa+YrXppizOUHEV0HarOuv0K3E6gIU4tyqvgYWr
         KJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vd80S55Frb6CGjHBLvPF+QFGjEdspA5jjiX4inId9o=;
        b=C8TZNFLFfie6V83aXNBmLSbgvjAg9/YfCeLEV3Af4M1Ez+J5wYXzM2Ig2D5XG/k/fA
         RheoTtx2xAMWGkmpc0YAnOhcD+zUl0tsL6sZ2wVQHIPYKZPS3w77y9Dvz+SXPXwUmtBD
         hUCCuEU2Z/pZc5ajgFOJhuBy+YPWd3K4Q8PvJcVR8Why4EuXoK/EfllssM3h0yBQDzQE
         Ay5J8lJIMVNWGoWHho8/y/zAD7bCstRTTwRjIUHb4bEd2Ok4sOt7B3Um4+aBZKG+54p1
         qpce+yTJ+dVIVvXnD51Gv7tmJZZZzs+1NUIfmGzE5q/tLS1XiCcbatyNUA3v/qbx0fXV
         nr9g==
X-Gm-Message-State: APjAAAXgFcBDJvjwvfUfz/ojEeyPNL0rc4+k39QBuCcqoxUKdpRi49pU
        kuImBXvHtIN2h7OYiZiAr+d0Dg==
X-Google-Smtp-Source: APXvYqyFPBiX/Dzj3+1uGcZxa0ESCGxxzjzLSjAg4zYz/BoOSpwSCmtAQPGJePmtlVc6NgV2ysdnaA==
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr16982360wmj.150.1552298180816;
        Mon, 11 Mar 2019 02:56:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 05/11] arm64: dts: meson-g12a-sei510: add regulators
Date:   Mon, 11 Mar 2019 10:56:07 +0100
Message-Id: <20190311095613.11371-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

Add some regulators. Still missing
* VDD_EE (0.8V - PWM controlled)
* VDD_CPU(PWM controlled)
* VDDQ1_5

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 63c515fe4996..2b11b5893958 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -15,10 +15,36 @@
 		serial0 = &uart_AO;
 	};
 
+	ao_5v: regulator-ao_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "AO_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_in>;
+		regulator-always-on;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
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
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
@@ -31,6 +57,35 @@
 			no-map;
 		};
 	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_in>;
+		regulator-always-on;
+	};
+
+	vddao_3v3_t: regultor-vddao_3v3_t {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3_T";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
+	};
+
+	vddio_ao1v8: regulator-vddio_ao1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
 };
 
 &uart_AO {
-- 
2.20.1

