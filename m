Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7733C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AACF21D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="viPQ8tCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbfJDJBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:01:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51476 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbfJDJBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:01:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so4962352wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U5+Cq6R9X8Ufmg5BHS6gLuKOFiO9TF8ekxmK0Vlflyo=;
        b=viPQ8tCIuO7ifXLvNehlr170Hq0zRhmeOFrDlSW18zUQ5/HH6olShlD6ANOlc4C/vY
         kU+qPChmbAcsbdcDid5YvQRbwpIQ/F253wo7GyfaTLtU2O99Y9XaN7359UKyFVHpU32q
         nKPuj81jP6TMBVySWqi34lgjfNKZaXCClyjw8xigwf3lDiSV4Fe4ww1QKXrR7eAqokMC
         BbwHnam7DBMqgwrDBBafgCPmGvY88qoJb4FsRw2N42Q5hEdkw9L0C95aV6jS6Q1D7Vq/
         1Iwh6bXTp2lhXvBFETZztO/oRRWDsvDXevuT+lZLzsZgA5PfkvfkHly2/hI34UG1NePl
         HScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U5+Cq6R9X8Ufmg5BHS6gLuKOFiO9TF8ekxmK0Vlflyo=;
        b=VFBHNww5r66Slx+chepxQY7GFw8/RxwqmEjEt076S4YEcSNS3/DqAbOaqvEr7o7ds2
         q4GvFfr1bsTNZx66M81M0imAryADDqKj2xxjwpTOLuejbeX9JcNxleF+OMUgBQ7Rulxo
         ZhZZG/s8x8/nqVew5U69kvNdlYturwgkFFtigFT4+2rSygfQwx2///kGXbl4JXAbwYPw
         JSQ8jzbr8osIxYDPam6PMUjnoSO8XQ0OOK/no9gG2/oUR0KaGlgr/w9nE09bl6BHpMfz
         qjIU5Pkr3LJVoAV8vTf+Fr0J8ShncYV7gQaUToPJXFQ/21b9vlNUiyHhFqMOyR+PiXmH
         peeg==
X-Gm-Message-State: APjAAAU48Icjp4hRrshbI7Ez2dMliWYjPPjTuJtoHRwFRNhUcrv7EqIy
        Pu5YRYvu7Y/mjXL7V13T4APK1Q==
X-Google-Smtp-Source: APXvYqx9RmbwsTK8Iq4RgR8Gbz/TiRWN/uUkE7o5hGA2Hoy7bdPG4yIVs2IxmPHUV9GF3MTE7XKdGw==
X-Received: by 2002:a1c:ed02:: with SMTP id l2mr9784178wmh.155.1570179680626;
        Fri, 04 Oct 2019 02:01:20 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v8sm7765170wra.79.2019.10.04.02.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:01:19 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 3/7] arm64: dts: amlogic: g12: add temperature sensor
Date:   Fri,  4 Oct 2019 11:01:10 +0200
Message-Id: <20191004090114.30694-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu and ddr temperature sensors for G12 Socs

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 38d70ce1cfc7..0660d9ef6a86 100644
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

