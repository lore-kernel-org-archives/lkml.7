Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0245C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F28920675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UJVsd9rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbfDROR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:17:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45181 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389209AbfDROR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:17:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so1232051plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGgAiu5VY4540GgNnynKeXs+gbdV/xnZr4APrSZdW00=;
        b=UJVsd9rSiqR3LBV73sq5cU+6PZPsRVK/XGS6KtpoOYEwXwztLFGB2OPhVx3ipGyvjI
         cL67gIjYi2wlqtHfUMw+IL6W0gV+wKFtR1011zkGDQAjwSTFgfhkVKOgtm3x5LyUJ53X
         JYj0wFBhlwFMpU3zoAGiWI4EYwRcHb1zYjAyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGgAiu5VY4540GgNnynKeXs+gbdV/xnZr4APrSZdW00=;
        b=mIsPo8hTaDkF0pEhak9ifQdbjqsG84+2K7qqsYkgCKzAOQpJ2K79abicTlR00JojaV
         NofMIlvICw6GkfpviTPON6e+mG183ubbJj3yjGGPeY8IIek3ZFbxrtrJXlHvrO3KtEoX
         FdRu5Fw8YwZuQP/O6xhpXleD+Ng7UPh3WVlO97OBn1pFsgQyc0rT3CaQNT+mqAndu/wt
         rj77k8UMmbEUWHIppomeicKHMQp/0kwjyhj0fgkTYwKzug+gOG44BIjBOGM9j6C0I61D
         dn1O10Q1zXtc+TkbPziw2/JZwqVy53lw6zLwnEk7zbDkiRD2gBZWMOzOvQWvBleieWDC
         lJOw==
X-Gm-Message-State: APjAAAVJdSu/7RrpvhhkEntXvk12vVQklWX43QVtaGwnEwv2A7L5kGzM
        Nyg6u+6/Ws/nq41MY/OBDc7bAA==
X-Google-Smtp-Source: APXvYqxgc2FOhNQztP+Mg98lDAPl7CTxCF5gsVLGTcRUYYJXK6JypJshoIGEj7l8jL0UyeE8GQTm8g==
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr79964404plb.233.1555597076157;
        Thu, 18 Apr 2019 07:17:56 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id q74sm6208939pfc.111.2019.04.18.07.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 07:17:55 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable CAN
Date:   Thu, 18 Apr 2019 19:46:58 +0530
Message-Id: <20190418141658.10868-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oceanic 5205 5inMFD has MCP2515 CAN device connected via SPI1.

- via SPI1 bus
- vdd supplied by 5V supply along with PL2 enable pin
- xceiver supply same as vdd
- can oscillator connected at 20MHz
- PB2 gpio as interrupt pin
- PD6 gpio as RX_BUF1_CAN0
- PD7 gpio as RX_BUF0_CAN0

Tested-by: Tamas Papp <tamas@osukl.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../sun50i-a64-oceanic-5205-5inmfd.dts        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
index f0cd6587f619..22535a297f51 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -21,6 +21,24 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	can_osc: can-osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <20000000>;
+	};
+
+	reg_can_v5v: reg-can-v5v {
+		compatible = "regulator-fixed";
+		regulator-name = "reg-can-v5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* CAN_3V3_EN: PL2 */
+		status = "okay";
+	};
+
 };
 
 &ehci0 {
@@ -77,6 +95,31 @@
 	status = "okay";
 };
 
+&pio {
+	can_pins: can-pins {
+		pins = "PD6",			/* RX_BUF1_CAN0 */
+		       "PD7";			/* RX_BUF0_CAN0 */
+		function = "gpio_in";
+	};
+};
+
+&spi1 {
+	status = "okay";
+
+	can@0 {
+		compatible = "microchip,mcp2515";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&can_pins>;
+		interrupt-parent = <&pio>;
+		interrupts = <1 2 IRQ_TYPE_EDGE_FALLING>;	/* INT_CAN0: PB2 */
+		clocks = <&can_osc>;
+		vdd-supply = <&reg_can_v5v>;
+		xceiver-supply = <&reg_can_v5v>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.18.0.321.gffc6fa0e3

