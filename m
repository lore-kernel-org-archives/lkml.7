Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B838DC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7D42173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQj4QWR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfLLNIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:08:07 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36094 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbfLLNIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:08:07 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so1027096pjc.3;
        Thu, 12 Dec 2019 05:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=m70cX1ccVQcNfsKFfTZkLfHn+4sYxmeVX2PubKBQQYk=;
        b=eQj4QWR7HnvXJxzOEyWU2YU3ey9CVqVCmQ1zWc/J+X23rHezy3cYLlcid7D/47kcXT
         cw1Xl3gf7c1eV3Z+f7pi2g4lyW5Lat/1iyVte3e1KhzsaaUd1CCjrKHRlxmH24+wUngu
         DkppcS3jHLfnkbe0wzUq9i5Xkq2QDY9tgfFPOQYgX5M5XqYQFKFEM6hS4LwqJpId/UCn
         7AQZZ845vOQuqAIJbLuBNS/YQ36zyYhlHwo892o3iXyXae+6tVYrQYk/14/vmx0k6SyL
         2O5wXC5gqEJvGylY96c8yZauKRduqgoa0Ih6eoVYXYqqWcxCvaQTF9gc/Jnj5N6EhPMw
         TbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=m70cX1ccVQcNfsKFfTZkLfHn+4sYxmeVX2PubKBQQYk=;
        b=G+YSc636zuDgwk+4va9EqoswPb/uzPUciZu199asbnu3x4uiLoExX8H4Wy2hSMZJAh
         WcC5Puo1ctlWwIk0wrpSC4lX4ZakYS2bKD/gJ4Kiv+2wc8f3klueaBjos/edWWn8LrwK
         edM2lbXpR8piceivKo8251JNt3wno86Xj5on4iAsKTsw372DiV2MPBR4CGyEJ3bl7VbH
         XklLW07k6j1lVa5DF4X8/ze1S0OTRrnVs9Pz3rN4VESo/WP+4TQVGqHWBw0zXjU/w2X7
         FI4JvP80jZCxrlYypaRTWdJq743onini6gQgifq/hDKQIaBjeXypBvHGMXlzFjVTWbgY
         guQQ==
X-Gm-Message-State: APjAAAX+awHhFO+Yufeh6pqqzhbgNdpy/wOy31gkuW1IYbrBZRfYv6Kn
        3kGlLqpPxijgwljcB779FoY=
X-Google-Smtp-Source: APXvYqwf7VM4nbjuXimflPq6vJbRg+SwKMix0ZmX48Mq7CN4j8H3LLurUPCFFa8AMR0/wpiOvODwjQ==
X-Received: by 2002:a17:902:b598:: with SMTP id a24mr9064883pls.247.1576156086662;
        Thu, 12 Dec 2019 05:08:06 -0800 (PST)
Received: from cnn ([2402:3a80:457:6a63:7070:9118:7874:2897])
        by smtp.gmail.com with ESMTPSA id v8sm6627508pff.151.2019.12.12.05.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 05:08:06 -0800 (PST)
Date:   Thu, 12 Dec 2019 18:37:58 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     andrew@aj.id.au, joel@jms.id.au
Cc:     sdasari@fb.com, vijaykhemka@fb.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: [PATCH v4 2/2] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20191212130758.GA7388@cnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Yosemite V2 is a facebook multi-node server
platform that host four OCP server. The BMC
in the Yosemite V2 platform based on AST2500 SoC.

This patch adds linux device tree entry related to
Yosemite V2 specific devices connected to BMC SoC.

--- Reviews summary
--- v4[2/2] - Spell and contributor name correction.
---         - License identifier changed to GPL-2.0-or-later.
---         - aspeed-gpio.h removed.
---         - FAN2 tacho channel changed.
---      v4 - Bootargs removed.
---      v3 - Uart1 Debug removed .
---      v2 - LPC and VUART removed .
---      v1 - Initial draft.

Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Acked-by   : Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Vijay Khemka <vkhemka@fb.com>
---
 .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 148 +++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
new file mode 100644
index 0000000..ffd7f4c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2018 Facebook Inc.
+
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+/ {
+	model = "Facebook Yosemitev2 BMC";
+	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
+	aliases {
+		serial4 = &uart5;
+	};
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	iio-hwmon {
+		// VOLATAGE SENSOR
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
+		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
+		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
+		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+	};
+};
+
+&uart5 {
+	// BMC Console
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+			&pinctrl_adc1_default
+			&pinctrl_adc2_default
+			&pinctrl_adc3_default
+			&pinctrl_adc4_default
+			&pinctrl_adc5_default
+			&pinctrl_adc6_default
+			&pinctrl_adc7_default
+			&pinctrl_adc8_default
+			&pinctrl_adc9_default
+			&pinctrl_adc10_default
+			&pinctrl_adc11_default
+			&pinctrl_adc12_default
+			&pinctrl_adc13_default
+			&pinctrl_adc14_default
+			&pinctrl_adc15_default>;
+};
+
+&i2c8 {
+	//FRU EEPROM
+	status = "okay";
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&i2c9 {
+	//INLET & OUTLET TEMP
+	status = "okay";
+	tmp421@4e {
+		compatible = "ti,tmp421";
+		reg = <0x4e>;
+	};
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+};
+
+&i2c10 {
+	//HSC
+	status = "okay";
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c11 {
+	//MEZZ_TEMP_SENSOR
+	status = "okay";
+	tmp421@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+};
+
+&i2c12 {
+	//MEZZ_FRU
+	status = "okay";
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&pwm_tacho {
+	//FSC
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+};
-- 
2.7.4

