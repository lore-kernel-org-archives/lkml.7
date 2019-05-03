Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8248C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A3E2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JaYHuUbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfECKsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:48:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36423 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfECKsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:48:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id v80so2719196pfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 03:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzeisKrbd3NVmsuHkycqQpZOOZrTkWkXq9WqgrEgfB0=;
        b=JaYHuUbP9s75WQ/WiGrEuulQNNGYORAeMSOkH3HzsxPQrs/nzwS9L4hUoDT34F2xfn
         9e99AfPrndhTYVchadnaUZeewH6jOAqvWEaqck/WTr5Gy6slmD3ZksNS5ZnOuE5P9Zli
         TtpYK7WSP1/TBxYtukB9xjN9sh4up41WU7Siw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzeisKrbd3NVmsuHkycqQpZOOZrTkWkXq9WqgrEgfB0=;
        b=Vpd23uMy6ch04JPrCl44KzpHcEsEy6Ng4Szqp1yIwGErhMOE/Q7Kb3XFzJQwyCMuXp
         S4TIwP/LVu3acr44v0oIu8dUhG++D0RVrrv7vd3wVohFc6UykY54GsF7gptU7zAvPxF9
         zq0tfEdRvY6+i4Q7dTq/2FDyDa9UX2upYseykenU1an6uMJW45cT0URFTQfarnuII3lk
         wsFey5dSTMjczjuw1g/7hM/MZuyQP6Mbg0blVI//FX9dpMWfeZ/6uPfc9vstC7dEF2Yn
         ej8OTjXJ9xhiGmlwcknGaj0BVMJ6Y7nEa2aQ4SS3ssaUZEPiGsLgVzMONpZF7so6bFC5
         sxwA==
X-Gm-Message-State: APjAAAVm290ERI4Urdyu5z9Zy7MQZUgjyjO/tHaQ+VE8JrPSSU9t/ChW
        2ky40cIfOMLmAhFCxwXbu8eAFw==
X-Google-Smtp-Source: APXvYqxyS/Viee8AeBaGT8IO9dn1bdGJz/q7gyZVY+P0K1JdPh+FtA+JdVDYOCKK3s8CgrrCjEdZUQ==
X-Received: by 2002:a62:b418:: with SMTP id h24mr9669983pfn.145.1556880502238;
        Fri, 03 May 2019 03:48:22 -0700 (PDT)
Received: from localhost.localdomain ([49.206.203.165])
        by smtp.gmail.com with ESMTPSA id k9sm1965479pga.22.2019.05.03.03.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 03:48:21 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 3/3] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable GT911 CTP
Date:   Fri,  3 May 2019 16:17:53 +0530
Message-Id: <20190503104753.27562-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190503104753.27562-1-jagan@amarulasolutions.com>
References: <20190503104753.27562-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix GT911 CTP is bound with Oceanic 5205 5inMFD board.

The CTP connected to board with,
- SDA, SCK from i2c0
- GPIO-LD0 as AVDD28 supply
- PH4 gpio as interrupt pin
- PH11 gpio as reset pin
- X axis is inverted
- Y axis is inverted

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- none
Changes for v4:
- drop i2c1 pinctrl
Changes for v3:
- Use 2.8v for reg_ldo_io0
Changes for v2:
- drop i2c1, bias-pull-up


 .../sun50i-a64-oceanic-5205-5inmfd.dts        | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
index 6a2154525d1e..787ebd805a3b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -37,6 +37,22 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+		AVDD28-supply = <&reg_ldo_io0>;			/* VDD_CTP: GPIO0-LDO */
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH11 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+};
+
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -52,6 +68,13 @@
 	regulator-name = "vcc-phy";
 };
 
+&reg_ldo_io0 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vdd-ctp";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.18.0.321.gffc6fa0e3

