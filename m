Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E986C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB772084B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YCejDFsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfLCNtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:49:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36143 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLCNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:49:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so1734847pls.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OCWpHuwLWEhr7hIE1xHLzHS/SChie+3Ub/J71wXFl6s=;
        b=YCejDFszbgh/fsLnX6AJBgPdhu8ZsJzFunj9aKQmZvh+wCvve+g5aHlIuMfa+1ynz0
         prFZM453x5/N7rFzc1qbyovEO9ayK07RdlfHONJYvbK3jIpI6vzgEDPHWlNpGi59EnxL
         5QVzChQLI6OzT7gWd5eLQJ8b3CnY9cJF3ckaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OCWpHuwLWEhr7hIE1xHLzHS/SChie+3Ub/J71wXFl6s=;
        b=S8BQghst0bcW6uOY5/g0mAcP5CYE1bhuy7MGTKwKU9fX9extJXZWZcpnXavrsdh88C
         U0Cup364bTALSNql2U16mY5UGDwYKkJVv6MONQiV5XaLNi3+jSL7ml11EIqksnHGUDZb
         Ofkx8wWwhnRh88Y/YHOTqASmEOhbx2q/ypvZpiAJq3T0H+J/d4TLZffAxnEWzDnmuV/3
         Zc8G/v9yx34NdywnajX/4kP/+MdTXzQKP/avdp/F1JFLp+kNHRoh7AN6QAd7lrYIB/J7
         kgscs7GCvsUtZsRntQ5TRv9xIlQttWfsiX7uftsAa0tuziU07Jpr2lcLxkVutYz8n/oR
         jI2w==
X-Gm-Message-State: APjAAAWu0uhupxfhIjvoDidMmMaKWtXXWKP6Wq9so85sskYe6WWfSEqH
        xVDOfZpfp67QDzwysOR7WNkxgw==
X-Google-Smtp-Source: APXvYqxyjJik0DwefsyvMQoynNr131hjpVdWIN2ZYDMEUJp5dwOWSvM6iaWt5R1OJTMvh7CpsJ1lDA==
X-Received: by 2002:a17:902:760c:: with SMTP id k12mr4928882pll.33.1575380946137;
        Tue, 03 Dec 2019 05:49:06 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.29])
        by smtp.gmail.com with ESMTPSA id y144sm4397892pfb.188.2019.12.03.05.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 05:49:05 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [DO NOT MERGE] [PATCH v12 7/7] arm64: dts: allwinner: bananapi-m64: Enable Bananapi S070WV20-CT16 DSI panel
Date:   Tue,  3 Dec 2019 19:18:16 +0530
Message-Id: <20191203134816.5319-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191203134816.5319-1-jagan@amarulasolutions.com>
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Bananapi S070WV20-CT16 DSI panel to
BPI-M64 board.

DSI panel connected via board DSI port with,
- DLDO1 as VCC-DSI supply
- DCDC1 as VDD supply
- PD7 gpio for lcd enable pin
- PD6 gpio for lcd reset pin
- PD5 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v12:
- none

 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 208373efee49..6beaecdd802a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -45,6 +45,7 @@
 #include "sun50i-a64.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "BananaPi-M64";
@@ -56,6 +57,14 @@
 		serial1 = &uart1;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <2>;
+		enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PD5 */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -116,6 +125,24 @@
 	status = "okay";
 };
 
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;		/* VCC3V3-DSI */
+	status = "okay";
+
+	panel@0 {
+		compatible = "bananapi,s070wv20-ct16-icn6211";
+		reg = <0>;
+		enable-gpios = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PD7 */
+		reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD6 */
+		vdd-supply = <&reg_dcdc1>;
+		backlight = <&backlight>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -206,6 +233,10 @@
 	status = "okay";
 };
 
+&r_pwm {
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.18.0.321.gffc6fa0e3

