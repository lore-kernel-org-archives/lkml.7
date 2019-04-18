Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB58C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E83320656
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n2GAQy6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbfDRRri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:47:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42645 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389796AbfDRRrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:47:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so1430338pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgyCo4kvfvwJMN5IY06/QZqxQNQ+gwbYmank+FUuDRs=;
        b=n2GAQy6AL8NMr2Cq6SIdmL5Ahe6WTvHGXsMM+2unZJwR5OCBGAGUyYhfW02C5zNJwH
         r/pU0IuVpmKtN2G6uLk5A1b2TeX0WcMCIKYYbGVXppMgliMsF4hb9g9ZXv91DdDk7FHx
         A1j1J/1y+8n2Ag0RbcP/KPMLTH1GBAXBNxKz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgyCo4kvfvwJMN5IY06/QZqxQNQ+gwbYmank+FUuDRs=;
        b=QGbm9W7OSX5hfdxo2//1ZoXUPmpJRuXFP9Eu88IOHeltbanP+ikw82+ztBWggUspYE
         LZa18+55E9srVykEC5Gf1eDYXjC09+cxGeMdMwlLNnvp5/GYhKsft7ZZ6XYk7Kp4BzZu
         jqhkFXEqbOQmxuRSOcLFH+7adOIhPG/zP/huEewDPN+GQdR25AVVd3HTaYOZDFavZoA/
         SZGD9uw/PTFoxvw+N9aabv32q1PZ5jTZukPNjfuHlU9TT0h4onaXJoF/8FofF6kDzBhZ
         ozhAy6luMLh0mQLVKs8tMlAA8vmpd4Mn3gmYnkNbTd6MyGY9oP272wKvuwvcNs4/ICIN
         TD/w==
X-Gm-Message-State: APjAAAXIp31No6llsmq4Zs/qbc+4WiWdXQOvAe5+0yaOA5SWkaWjs7Ux
        bf48wWbEw9yxr0SCOnuOi1onQg==
X-Google-Smtp-Source: APXvYqwU7wFfbMgdlPxUORhEbEn7eTxSb7qBp/2g/T7jY+egLAC8gCL0oK3urPMpZZ0Omr5fvKmCxA==
X-Received: by 2002:a65:6645:: with SMTP id z5mr65454449pgv.251.1555609655055;
        Thu, 18 Apr 2019 10:47:35 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id j4sm5223547pgi.71.2019.04.18.10.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 10:47:34 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 2/3] arm64: dts: allwinner: a64-amarula-relic: Add GT5663 CTP node
Date:   Thu, 18 Apr 2019 23:17:19 +0530
Message-Id: <20190418174720.17230-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190418174720.17230-1-jagan@amarulasolutions.com>
References: <20190418174720.17230-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Goodix GT5663 capacitive touch controller node on
Amarula A64-Relic board.

The CTP connected to board with,
- SDA, SCK from i2c1
- GPIO-LD0 as AVDD28 supply
- PH4 gpio as interrupt pin
- PH8 gpio as reset pin
- X axis is inverted
- Y axis is inverted

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- drop i2c1 pinctrl
Changes for v3:
- Use 2.8v for reg_ldo_io0
Changes for v2:
- drop i2c1, bias-pull-up

 .../allwinner/sun50i-a64-amarula-relic.dts    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index c41131c03231..5634245d11db 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -97,6 +97,22 @@
 	bias-pull-up;
 };
 
+&i2c1 {
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt5663";
+		reg = <0x5d>;
+		AVDD28-supply = <&reg_ldo_io0>;			/* VCC-CTP: GPIO0-LDO */
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
@@ -260,6 +276,13 @@
 	regulator-name = "vdd-cpus";
 };
 
+&reg_ldo_io0 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vcc-ctp";
+	status = "okay";
+};
+
 &reg_rtc_ldo {
 	regulator-name = "vcc-rtc";
 };
-- 
2.18.0.321.gffc6fa0e3

