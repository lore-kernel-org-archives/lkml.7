Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE90EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29A02171F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KYF9hpGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfGaPf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:35:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42839 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfGaPfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:35:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so20284637wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zwXMQFf4O72zRXvxhXDpjn4gC2DC6LZbFolWqJXYtrg=;
        b=KYF9hpGEUbp0s0D642XDycTGprN3nqCsZUHBJdEKiex/mFMiZiWZ5/jd45H50ptbNU
         gw8EOQxt0VEWOwPRO9cHC+8Ray13wzLmL2meqCrouR1exyscsJduepsVv0tVycyMKrAx
         og2pGcy/PFs9xB5pIxirKZzAjqQ0hmhI1FvPVk7wCeTN1b8iueOtfp9RDkH0HQq5AOqO
         BIsh5KY+3D+v4FETW04yDsEQrdHpBzqHuVwgLELR/iZMZZ12GTAcLO3jy8qP0z/lXN89
         pH+/vGjHdLe0f0U+b/34BBcYccDIKZpHm9TC2KQ8QAL/lNqMRJSWt0F//+Yg0kpY8hxP
         PrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zwXMQFf4O72zRXvxhXDpjn4gC2DC6LZbFolWqJXYtrg=;
        b=hEkegIeCH2S9BtuOPcTJMKz2VEekqd+Orh2Id/N9Q0SQ0QeUEvXdnC5MpacYb4/f9c
         mbzim6BySPRIYXfcylKWC0a0rJEstKQBy/EDEN08Jzzx46ZFmrrbk1QLUaKvjkGGfZtv
         gC/Bsb2y6dVlHbTGNFh1eD6We5KnjQPlh6PAbLget8fJnBkyEhJAidXkV8MTIl/uGx4T
         XPQELw11KK1vm+zNcSYR282aCwN/zJCgy8hnLPmRUcNipRDrhdn5fkLxWht1UyW0lAQN
         q4SkLwqxeYSfNtu3zAo1PYt/bX3osUAPnEkXIA8boca9ot7bm9OyFfWCcQfNAGBkcwcw
         65Bg==
X-Gm-Message-State: APjAAAXA47LlpfhkUXPApxS1v8xPH3hOPLLxFViD9VZ3LUjx4q3NfUV4
        qP9MGtM91PAFQXoJXQXhMlr6ng==
X-Google-Smtp-Source: APXvYqzoxnNYY2vWzgJ9XlUvY8Co2H5qYLxlbwUS/OxtwDXdbJ0v1wfkv4b07TjdDvzHYrdxfIXyZQ==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr91580852wrp.277.1564587334955;
        Wed, 31 Jul 2019 08:35:34 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i13sm62834396wrr.73.2019.07.31.08.35.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:35:34 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/6] arm64: dts: amlogic: g12: add temperature sensor
Date:   Wed, 31 Jul 2019 17:35:26 +0200
Message-Id: <20190731153529.30159-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731153529.30159-1-glaroque@baylibre.com>
References: <20190731153529.30159-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu and ddr temperature sensors for G12 Socs

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 06e186ca41e3..7f862a3490fb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1353,6 +1353,28 @@
 				};
 			};
 
+			cpu_temp: temperature-sensor@34800 {
+				compatible = "amlogic,g12-cpu-thermal",
+					     "amlogic,g12-thermal";
+				reg = <0x0 0x34800 0x0 0x50>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				status = "okay";
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
+			ddr_temp: temperature-sensor@34c00 {
+				compatible = "amlogic,g12-ddr-thermal",
+					     "amlogic,g12-thermal";
+				reg = <0x0 0x34c00 0x0 0x50>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				status = "okay";
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
 			usb2_phy0: phy@36000 {
 				compatible = "amlogic,g12a-usb2-phy";
 				reg = <0x0 0x36000 0x0 0x2000>;
-- 
2.17.1

