Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF67C5070F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFBC2474C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTpEumY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfLMNvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:51:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33688 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMNvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:51:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id y206so1527858pfb.0;
        Fri, 13 Dec 2019 05:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ymqyf3ZzOKHzrjO49WfBXaPmL09jcKuafUFOn/7WrR0=;
        b=HTpEumY8ELx9uGBt9g/xDzvfDgkgQfOqBchv5PjqzQeyvS5cObNggKcmCb3UNxi/jh
         lH8Wrthu3f2BvMuy4aB3YBZ/YaGj16nw4hx2gp9xqpfMEvVwjdFdG/cotnrH9kTXamPA
         VxQtwpOp5+tjW+LcTt4Oo1USXDUKnnUA2ABLI0sAsQHlF2uZV92ZQ6Kd46Mvoagp/lku
         gX7KoNvSHEiwS5YWNpnNG3lD5Lp5BXZ8D/OWs1At06bNBCYOnT8Xv6OvKda1baIT+AYi
         1htJqU/FMpQkEYFwi05w4s8WgLjYlQpZgr59uvz7HhyglzmHD9sv/9dSziKSBfJ7JbD7
         C1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ymqyf3ZzOKHzrjO49WfBXaPmL09jcKuafUFOn/7WrR0=;
        b=tXNZZzId+/Yt/BpgFZGWt+PAIvKoabk/SkPKpgUrAiBtWJ8cczg/fZyMSszC45KzHG
         OqvVNEXHNTFY5GPImAhjrTSyjm4uyaArlwOFbbzVpY87bU599SU6OIL/mIeic1eUKA1O
         g+6lBKdhoz2Dyq8QSXlV68k+k1RFLngfebtv7+nZMYoBQ1yOIM8fjP/KpSEkFan4NZ8W
         2jBsi7cneCS0bIFeg+NucrXpr7hrRl7MBfl4p45HrCLavI3k+HeSYX4p907vtFwX1/j7
         e8Skf5IC7IBdcHDXiDQ6zSCVhOB8Fzd3u1iubRwmt+FfSATJKTnX6mSD9E614SB3h+IW
         tVfw==
X-Gm-Message-State: APjAAAVfLsJ0u7DPLoTYsQG3ykqgg+QT0HKmyvIg0N8uQpKR3Zgrn8bC
        okPIUX5zeKtSPhmrGMHxhFsugjGJ
X-Google-Smtp-Source: APXvYqzuZ7bLsEERfyor7dwMWxIJH9JkvW3kxNrSwI6c0aHQISu84lFn0uFL6hfVfqj7GltzzZj1HQ==
X-Received: by 2002:a62:788a:: with SMTP id t132mr16242050pfc.134.1576245098324;
        Fri, 13 Dec 2019 05:51:38 -0800 (PST)
Received: from cnn ([2402:3a80:47f:89b1:9c76:12d1:42df:9222])
        by smtp.gmail.com with ESMTPSA id p28sm10768389pgb.93.2019.12.13.05.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 05:51:37 -0800 (PST)
Date:   Fri, 13 Dec 2019 19:21:31 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     andrew@aj.id.au, joel@jms.id.au
Cc:     sdasari@fb.com, vijaykhemka@fb.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com, openbmc@lists.ozlabs.org
Subject: [PATCH v5] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20191213135131.GA1822@cnn>
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

Signed-off-by : Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Acked-by        : Andrew Jeffery <andrew@aj.id.au>
Reviewed-by  : Vijay Khemka <vkhemka@fb.com>
--- 
---      v5 - Spell and contributor name correction.
---           - License identifier changed to GPL-2.0-or-later.
---           - aspeed-gpio.h removed.
---           - FAN2 tacho channel changed.
---      v4 - Bootargs removed.
---      v3 - Uart1 Debug removed .
---      v2 - LPC and VUART removed .
---      v1 - Initial draft.
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

