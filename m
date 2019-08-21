Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E19C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EE42332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RmAQt0yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfHUWYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 18:24:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39208 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfHUWY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 18:24:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id i63so3700266wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VNEVJNmyyHrsV6A+ZpoAhZq6Wlxyq2Rn2IfeLizyW5M=;
        b=RmAQt0yrk4yeu8kHxu/ofDAzx+2cZEAdXYgfQpVRpzX8n+bKfVdHMRgTXXwQI5Vsp+
         z7/jDTXj1cY7aS1BFV3pDZPhCEB6zBkXuYpZXMq0P3/+WyAI6ypnOPtrOXb+1CvyLAz3
         6dyE7riK+GIKQijiJ3Rz+VM1K+xOhtwHY/xDnrMckeDGRbBLfWKZB2vR4ezsaxmNgKfo
         zM6I2ZzMRxgRGDbRcsquifk7qo/iHXbusGPEj2IcD0H8/+Hno7lVvO6koZCH/cE/bVj0
         BND/kPghyoQwXYDSp9XXs3BcfVeXnMUZb3hY2HW9SyC7tLmsItkw6pOLSLACjpOqq5mA
         qbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VNEVJNmyyHrsV6A+ZpoAhZq6Wlxyq2Rn2IfeLizyW5M=;
        b=S31cV4hTjIrvicYIfGICMWpvkBNqyN0blYS9UNeFEt0UICEuf1UtuZFbShCon1qOGu
         S9FUGfb/Ay989LQYWGvtT7K3AH2WdrZaQZy8efuNqu5TZy0+sapB2tuULm8KkhQ0bbMx
         gx0fyiz8Wed4MDLl1eOwyYrsw9OMeF3Qkn1I99hdI8BlA+jcbrFWMzEbFVCszsYdog+c
         8FvrLTs1f9QC8wR0LuzEw9s3uU3Z91gY6Gbgb8KWXRNBB0YOSvnw1Vv6s9N75dE4gbY6
         xZvG+BNa6vNbvNlj6Gu0smQpiTlMnG26SsxsbnVC1uCiqLuy5uw2zhZkHTgYRIAA77lv
         JNuw==
X-Gm-Message-State: APjAAAWABXJDwTphzbc6gxBtgZPmmfpm27A7xl0Efdf521g28Sux1SFi
        VTSsfeQqCcrFPf/EmJgJPSqhQVDokOQ=
X-Google-Smtp-Source: APXvYqzutcbJ1b6zo56rETKZr1zpTfUALmnpdpQJw6EUBhIgUTQ10movHoix6xnpijh+pYUNRfaXDw==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr2507957wmf.14.1566426267351;
        Wed, 21 Aug 2019 15:24:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id f197sm3548549wme.22.2019.08.21.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 15:24:26 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 3/6] arm64: dts: amlogic: g12: add temperature sensor
Date:   Thu, 22 Aug 2019 00:24:18 +0200
Message-Id: <20190821222421.30242-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821222421.30242-1-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu and ddr temperature sensors for G12 Socs

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 06e186ca41e3..ce13c7c2e454 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1353,6 +1353,26 @@
 				};
 			};
 
+			cpu_temp: temperature-sensor@34800 {
+				compatible = "amlogic,g12a-cpu-thermal",
+					     "amlogic,g12a-thermal";
+				reg = <0x0 0x34800 0x0 0x50>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
+			ddr_temp: temperature-sensor@34c00 {
+				compatible = "amlogic,g12a-ddr-thermal",
+					     "amlogic,g12a-thermal";
+				reg = <0x0 0x34c00 0x0 0x50>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
 			usb2_phy0: phy@36000 {
 				compatible = "amlogic,g12a-usb2-phy";
 				reg = <0x0 0x36000 0x0 0x2000>;
-- 
2.17.1

