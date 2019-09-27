Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BDAC388F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A9120872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MikSGlZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfI0SoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:44:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45399 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfI0SoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:44:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so4281956wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uFRkuroOBs+uKwTPCimySu+UhJ9t5OAbbzvyFqNj3Aw=;
        b=MikSGlZe0uqOkaubiy1RQV05Ryu/fAimSnGuIod6zI/bkIxwYw871JO1JwE51iYQm+
         4uj9azF9xbXtpyJHchneV3CO3wKJhdY0T9rqVgqLqpeMXKIj/L//AjglSvJtOTd5vEL4
         JeAGn/m7kMiX5bLtvKI3izvMAcPnpQFpuwUZIJZnK7YRsxmwaQ5NMDxjXC2xuXlZNh8u
         hON3DP8hubHBv9LVkP07y1Zg5PE6j6IIGKm0nh/Skxb6DcL0YHKdpbG3GcF1pPNEhUBQ
         IOetegYVw+Oldn5XB6Y4Ve53PBYtSEpB7wU8CO8pmuGh/UZa+NKEh+fQ3t/1QSedFd7I
         dqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uFRkuroOBs+uKwTPCimySu+UhJ9t5OAbbzvyFqNj3Aw=;
        b=VYlfX09x88/rdUsDZx4ds9m3anUHmW9g/8VicoM7hbvgZFfWcKIBqdYTt8qg/ULql/
         hGgurbn7c+mptSQ1pnKe3YqBCdP5KYGS8wWJ//q1O3hJfsnRj3LAYeWbKA+kCmyGxHzU
         59/4GKrfCURlsqIHDSGkmUtRumIdLV6i43XRrqtPRfDuQkEiIxEOhp3wFLmfSMb2dHcB
         ilzUEEECiL8HJAGesUcBCFZ8dot5naUAj963aMjdE1WuqQ0v/fOkrWhgRRwH8Fwt+2F9
         WljyVWX4GeYANzWANSz4dUZ6Z9NzI6TDZ3WPTD0zjvyAgohO60gEL8lsN4uTkVVzTbWA
         osRQ==
X-Gm-Message-State: APjAAAWZBww32I14lmnD+wGVdPPyJDmObF0kyy+vQQU5xuTZwOaTAtaz
        3C/MkulMLIKRTtzP4/kVkFsXyA==
X-Google-Smtp-Source: APXvYqywejFLNmLubXQ+lIajg77P8IR0wPRSPIhJuiMQsC6g7ImkqPZHkFpB+MQ5Po1oPHBJeOnLsA==
X-Received: by 2002:adf:f081:: with SMTP id n1mr4402788wro.273.1569609838776;
        Fri, 27 Sep 2019 11:43:58 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id r13sm6246272wrn.0.2019.09.27.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:43:58 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v6 3/7] arm64: dts: amlogic: g12: add temperature sensor
Date:   Fri, 27 Sep 2019 20:43:48 +0200
Message-Id: <20190927184352.28759-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927184352.28759-1-glaroque@baylibre.com>
References: <20190927184352.28759-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu and ddr temperature sensors for G12 Socs

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

