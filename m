Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06821C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F95207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqmqiJqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfK0GH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 01:07:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35379 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfK0GH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 01:07:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id q13so10434953pff.2;
        Tue, 26 Nov 2019 22:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FYckdcYvzj5yK1e7XpJFaQ7ZpFtgpcz0P/S/HZ3xvbc=;
        b=ZqmqiJqoE/jt1cu2yQqkKYq/GZLwlraUdPfHsR1BcXf56lookmXWauSFqf6/mh+OzV
         gZYx2jfghiCjaZikO/hJUKVHFlW3XuNXD6Qh+rWxf1Xt+XpxSiSFHyQV8wEMCRdW527k
         1+cPwRBK91pFQfjNdk4zU38D+7QeohNGmkkfjtNVZuZsRoERAhH1eVZEd6XUigvcqaih
         7S9um0bFB42NqpsGz6qzSbjZmBl/E/34gBWJHVywE0ixP/yZRjWC+T4mYEaM8Ryjcbvu
         tUwwPilwOBKGaH0XO6LYjCD3Wtc21Ov7MuJBNQQ/5/6EMTWgDA6ODQrnQbHOd+baL5Wa
         qGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FYckdcYvzj5yK1e7XpJFaQ7ZpFtgpcz0P/S/HZ3xvbc=;
        b=nn5pRrBZRA3yn/aiZiaKcFR471oNaSicb3GEH4V7HZsy9L2R37qFwZNT80bqUNtwB8
         mwQP4OOZnIXNp47rv3gYEjlc0OjHWWLBXVNuP5lpS1aN+Th5ofpeui0GEIgzuYhIt49g
         Vvx3xveJ+fZ1QKNUH1vuOvt0Vw4WsJ6SuhfWY4u4jEzOnoo7g09NdrhgPeC54zRA+qqD
         IL/4ILX30UFV8DYKHz6WZf6Yn6eMm6XtVdGYmMFq/I5yXI9S6tsK/7R4avKQDAwqHoBY
         ntPldVDR0HYULkXab364FIwQ5QiST/i4f0PceqbkGHNkUl0p4Qqa1/uEAXEfGoeKjOSR
         3RnQ==
X-Gm-Message-State: APjAAAVm+qoRB0aJD+s2XFbCfo2ayKNfPr309uowgn1O67AsiH5xBhb6
        3IUU6pNn1Jm9bXAa8Ge6aNe47EAB
X-Google-Smtp-Source: APXvYqwbTFj6Fo4PP7TnD4CtCIlZf0uINATN7YR0vii6I/AkHjGTEghYrHOvHZkCUimSJGSWPIWcXw==
X-Received: by 2002:aa7:90d0:: with SMTP id k16mr46075750pfk.131.1574834876438;
        Tue, 26 Nov 2019 22:07:56 -0800 (PST)
Received: from cnn ([2402:3a80:463:98d9:a194:63c9:69fb:ee71])
        by smtp.gmail.com with ESMTPSA id u24sm14614802pfh.48.2019.11.26.22.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 22:07:55 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:37:47 +0530
From:   manikandan-e <manikandan.hcl.ers.epl@gmail.com>
To:     vijaykhemka@fb.com
Cc:     andrew@aj.id.au, joel@jms.id.au, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: [PATCH v4] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20191127060747.GA30829@cnn>
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
 .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 150 +++++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
new file mode 100644
index 0000000..44e2b17
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
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
+	status = "okay";
+	//FSC
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

