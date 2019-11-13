Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8988222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWmr4oCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKMHy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:54:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41686 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfKMHy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:54:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id p26so1080382pfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 23:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=j+Rmv2QRAZYFyDr3XTcc91Xq1BkHJOJyHUbLmK3uyjE=;
        b=EWmr4oCGTUOzMqW+1jc0P2r19e+QrgsqyHNH3sqJz3QEt2Nn4gyszV+2UbYNbW2Hqh
         ZfC34ffwyvUNDR/38Joc8hmLiT+nG5kUfd59xhl5Byy7ngaRJeGeJ+PeHquftjgCzqFx
         t4aTze0EbaRne2ZCvRnRG8W7s7pxdrzPy8N76fFwXW7XOL9FFEInM6LDg/vwKIilfgce
         eV5lbec7qowiV+ctD0ElsJO5hinA9N+pt+8VVgdKExeeHoiLLEjGROXuAv04ButTv7F3
         IcTAMudoieosMS/a5RhSNgK0xU3mT20glY4lYp1jhyFPChvNqh7OiZIw1vVmbv3n66AZ
         S8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=j+Rmv2QRAZYFyDr3XTcc91Xq1BkHJOJyHUbLmK3uyjE=;
        b=HWog5fRTsP5JWMFQll4ZFmPr+63DSA2tMrKIatwk241SLYd9r3+COZvszZfnE6zFsR
         RNaLcOxAKhZZsfv6/ibACnqQV/Q5C4Tcyp58YI1LreZU52Jvb8F1bIqztZVgGYQ/BwaY
         zPaoUBzbNB0inwsPzQ/LdmWXoNvAw/NKb3+gV/xlE96jqFu3IYkMhaKLbMb/i4oLMRDH
         61baLePefT3kKvpUMp7/e92fnIjQvyfA5fcjSV+fPwEicMIqAoOXEhcNCptIhbzBBwW9
         YrMsWki3oYLYF5A2QWVYdpDkhY/vssHdxeh/i+J7ZmbSQbN4uJlWCzGPGRUvkak8qvOC
         LDpg==
X-Gm-Message-State: APjAAAX9GSeI/72aTohPzv8sfAwXpsE/4xhnRx3lWuxOqXkoBvA/pRLZ
        /ipMTxRPzptpFlm2AQ0F9H8=
X-Google-Smtp-Source: APXvYqxqoxY0is1FxRiQlDqKpd0kAw3py/0rUml68SyOdW1Ib8vHlnVyRyOp8PzvsRWhhjby3kzqqg==
X-Received: by 2002:a62:e81a:: with SMTP id c26mr2743341pfi.246.1573631698055;
        Tue, 12 Nov 2019 23:54:58 -0800 (PST)
Received: from cnn ([2402:3a80:45d:2426:a502:3b3e:c9a:ed61])
        by smtp.gmail.com with ESMTPSA id j4sm2901584pjf.25.2019.11.12.23.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 23:54:57 -0800 (PST)
Date:   Wed, 13 Nov 2019 13:24:53 +0530
From:   manikandan-e <manikandan.hcl.ers.epl@gmail.com>
To:     joel@jms.id.au
Cc:     linux-kernel@vger.kernel.org, andrew@aj.id.au, manikandan.e@hcl.com
Subject: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20191113075452.GA12657@cnn>
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
in the Yosemite V2 platorm based on AST2500 SoC.

This patch adds linux device tree entry related to
Yosemite V2 specific devices connected to BMC SoC.

Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
---
 .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 168 +++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
new file mode 100644
index 0000000..ab6ff7f
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018 Facebook Inc.
+// Author:
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Facebook Yosemitev2 BMC";
+	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
+	aliases {
+		serial0 = &uart1;
+		serial4 = &uart5;
+	};
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
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
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&lpc_ctrl {
+	// Enable lpc clock
+	status = "okay";
+};
+
+&vuart {
+	// VUART Host Console
+	status = "okay";
+};
+
+&uart1 {
+	// Host Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart2 {
+	// SoL Host Console
+	status = "okay";
+};
+
+&uart3 {
+	// SoL BMC Console
+	status = "okay";
+};
+
+&uart5 {
+	// BMC Console
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+};
+
+&adc {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+	//FRU EEPROM
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+	tmp421@4e {
+	//INLET TEMP
+		compatible = "ti,tmp421";
+		reg = <0x4e>;
+	};
+	//OUTLET TEMP
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	//HSC
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+	//MEZZ_TEMP_SENSOR
+	tmp421@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	//MEZZ_FRU
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&pwm_tacho {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+};
-- 
2.7.4

