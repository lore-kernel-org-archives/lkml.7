Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB372070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TsN+9sj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfCRKFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38438 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfCRKFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so12026783wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrU7oOZF/XD8UT4BF226LZ7D8K1QM3Y0TXhUURbvrB0=;
        b=TsN+9sj+Hz+Sa6E4DPKcieTcPZJrb2JZbT2uLEeOV/z9stXQgJB33zafHM7LXV7zG8
         oXrWCACLEQTI9pJk+PuceITOTywgor9UfADMbgkz1sKS3CbR9POjfTmmmKrAskc5WLUM
         tDQG146IqhUg5AqdyyqU2jWrK4bXVyYA0unqv510MckRExi8M3khA826CpmEpj48ksCs
         t9sAtScQluR0BSCZ+flK+FWF8L0rB1mWR9h2HwaBVtq3rvMaGQVKsgQxtvMMgjOr+DQz
         /0cNK7eK2p/lOFZNJQpG+y4sWnXOG45nEDYj9BBWv22ddiQyZqpb/bPQOvWg/a2W2Yvn
         p+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrU7oOZF/XD8UT4BF226LZ7D8K1QM3Y0TXhUURbvrB0=;
        b=g2i5Ml1RpaLH6+BTVYfK/kPtifhmAx1sFUkEoPl5g7aZe+q64Wl+KFKiyPgnuMqFaH
         4IrFY9wXUfhE9AFvui/k5N1tGuGnZd6Y3s597xdNvEHrk0CN3EKPtfHWXbE4nZ0WkcWT
         W3xNEYQG6NxJgqzxa/aW3S9qzYVho2GxI2nZPtHQNQ8+8JqePLXuVyQoFv6dVVd8FEYt
         q5bX9CV1KPXTzI1ixHUtzq/qUCxEEC2/7eF+6yW+9QqI9fevFBrn+hwjx76g1uoesj32
         dDCgXousIeuc6CcPIbwWZfl5wiv+nFq9luRXgd8l10U4Zn854oyQo5NYxfg7mztX0U+o
         A6TA==
X-Gm-Message-State: APjAAAVOVi8hqbPAnTWoq8FhV+Tn1eu14kGCc5bpDZGMHh12N3wuw6Ue
        KrIxvYz/gj+M/oMvyf1eTRYozA==
X-Google-Smtp-Source: APXvYqxwhCV+9YHPpEYO2QBp5e/pxcjvrA3D3nHEn0mXz9CPZi2TS3xuPDpz+DqLLY9lxx+6p548RQ==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr9876623wma.57.1552903505087;
        Mon, 18 Mar 2019 03:05:05 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 05/11] arm64: dts: meson-g12a-sei510: add regulators
Date:   Mon, 18 Mar 2019 11:04:52 +0100
Message-Id: <20190318100458.5619-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
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
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 63c515fe4996..43d57e20294a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 
 #include "meson-g12a.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
 
 / {
 	compatible = "seirobotics,sei510", "amlogic,g12a";
@@ -15,10 +17,36 @@
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
@@ -31,6 +59,35 @@
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

