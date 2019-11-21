Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5942FC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20391206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O18KP3c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKUHsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:48:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34542 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUHsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:48:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so1256895pff.1;
        Wed, 20 Nov 2019 23:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0AHoXKBeiHfVOAlJ8eUc0ml1SVtw0bxVrUMv8+xZmSY=;
        b=O18KP3c8MuNE/peTVtVbsMFGzxa1d5zRbE/0MI9YjODcfKHC70NvuQ/hEGRuqgtFze
         i2StBN7mcK+1Ab4mfoEd46g3Sg71PXE9XIK840GAsqZw4ZbKc7NhOV28xordQFsZ9dJG
         ciPgbl8tJxg79uEBDlCbh7hgQ0EZk3KPUnmT5NJZRRxaDW35bOecLOwXTnmLMqaE6yO2
         j3lz5c+aHbLOPPgk3L+h5y1G37rgrGL9Xgm2zypiBeoaLmU97YMeiuABQmAssPol6clI
         xjalaikZ0rPqXKhf9nwDhVyOHoIsIhcGL+3HKrgLdBbjD7Bo6qp3MH2VwMNQMmxKrXnN
         kinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0AHoXKBeiHfVOAlJ8eUc0ml1SVtw0bxVrUMv8+xZmSY=;
        b=hNjO6DP5ASHp/QT7tnF6dpAVfZBprmM4FjFUJgLBsdgmR+1kFb2BzeCAgQRbFG3vfh
         KDthFIuA3aLp1pZX9I0dHNks6v/1iqofGzmSpV5DbcwNfGuXZGqexTAEZ3UicrIMX1gb
         0RAkXEWdlj/7SS/0BdeVhGgpoVHe3Jm4L57RSsYcIemPXKPtDTVIOubRAIK2JznmsrTn
         C2N/108qNrsrRLLgTSm38Ch+skqazr46F99d5bqJaApqKRLCFx+NIsOVrYeeBZjthsIM
         HFDtlwA9B1UO1B/5bh+3hsYXjnistvNh8UFm4Cr8YOoK/D9ugrwGcpmMVCvQLhmi9gGw
         U2Vw==
X-Gm-Message-State: APjAAAVkFQpC7s3FKo1NG3604hR1rKUQiMSbj4kqtfexNzKZkS6pDOPg
        rp+/qJNXP3OrvxRuZRiVOG2PERWr
X-Google-Smtp-Source: APXvYqzvkWa/OpRByvNc2AbV0OfSnNxlcYaG+GEMcyVJa9xbmT9KIDL/JW+GeWTt7/FITTZev9uwmA==
X-Received: by 2002:aa7:8690:: with SMTP id d16mr8978023pfo.117.1574322532634;
        Wed, 20 Nov 2019 23:48:52 -0800 (PST)
Received: from cnn ([2402:3a80:474:4290:5d90:34b2:635a:ec78])
        by smtp.gmail.com with ESMTPSA id s26sm2000234pfh.66.2019.11.20.23.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 23:48:52 -0800 (PST)
Date:   Thu, 21 Nov 2019 13:18:44 +0530
From:   Manikandan <manikandan.hcl.ers.epl@gmail.com>
To:     Vijay Khemka <vijaykhemka@fb.com>, andrew@aj.id.au
Cc:     joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20191121074843.GA10607@cnn>
References: <20191118123707.GA5560@cnn>
 <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
 <D34D3A2F-9CD5-4924-8407-F6EB0A4C66B5@fb.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D34D3A2F-9CD5-4924-8407-F6EB0A4C66B5@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Hi Andrew/Vijay,

Thanks for the review .

The following changes done in dts and tested in Facebook Yosemite V2 BMC platform,
  1. LPC feature removed as not supported .
  2. VUART feature removed as not supported.
  3. Host UART feature removed as not in the current scope.
  4. ADC pinctrl details added in dts.

Thanks
Mani.E

On Wed, Nov 20, 2019 at 06:50:15AM +0000, Vijay Khemka wrote:
> 
> 
> ﻿On 11/19/19, 9:56 PM, "Linux-aspeed on behalf of Andrew Jeffery" <linux-aspeed-bounces+vijaykhemka=fb.com@lists.ozlabs.org on behalf of andrew@aj.id.au> wrote:
> 
>     
>     
>     On Mon, 18 Nov 2019, at 23:07, manikandan-e wrote:
>     > The Yosemite V2 is a facebook multi-node server
>     > platform that host four OCP server. The BMC
>     > in the Yosemite V2 platorm based on AST2500 SoC.
>     > 
>     > This patch adds linux device tree entry related to
>     > Yosemite V2 specific devices connected to BMC SoC.
>     > 
>     > Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
>     > ---
>     >  .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 170 +++++++++++++++++++++
>     >  1 file changed, 170 insertions(+)
>     >  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>     > 
>     > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts 
>     > b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>     > new file mode 100644
>     > index 0000000..46a285a
>     > --- /dev/null
>     > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>     > @@ -0,0 +1,170 @@
>     > +// SPDX-License-Identifier: GPL-2.0+
>     > +// Copyright (c) 2018 Facebook Inc.
>     > +// Author:
>     > +/dts-v1/;
>     > +
>     > +#include "aspeed-g5.dtsi"
>     > +#include <dt-bindings/gpio/aspeed-gpio.h>
>     > +
>     > +/ {
>     > +	model = "Facebook Yosemitev2 BMC";
>     > +	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
>     > +	aliases {
>     > +		serial0 = &uart1;
>     > +		serial4 = &uart5;
>     > +	};
>     > +	chosen {
>     > +		stdout-path = &uart5;
>     > +		bootargs = "console=ttyS4,115200 earlyprintk";
>     > +	};
>     > +
>     > +	memory@80000000 {
>     > +		reg = <0x80000000 0x20000000>;
>     > +	};
>     > +
>     > +	iio-hwmon {
>     > +		// VOLATAGE SENSOR
>     > +		compatible = "iio-hwmon";
>     > +		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
>     > +		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
>     > +		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
>     > +		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
>     > +	};
>     > +};
>     > +
>     > +&fmc {
>     > +	status = "okay";
>     > +	flash@0 {
>     > +		status = "okay";
>     > +		m25p,fast-read;
>     > +#include "openbmc-flash-layout.dtsi"
>     > +	};
>     > +};
>     > +
>     > +&spi1 {
>     > +	status = "okay";
>     > +	pinctrl-names = "default";
>     > +	pinctrl-0 = <&pinctrl_spi1_default>;
>     > +	flash@0 {
>     > +		status = "okay";
>     > +		m25p,fast-read;
>     > +		label = "pnor";
>     > +	};
>     > +};
>     > +
>     > +&lpc_snoop {
>     > +	status = "okay";
>     > +	snoop-ports = <0x80>;
>     > +};
> No lpc in Yosemite so please remove.
> 
>     > +
>     > +&lpc_ctrl {
>     > +	// Enable lpc clock
>     > +	status = "okay";
> Same here remove.
>     
>     Something I'm intending to fix in the devicetrees using LPC is to hog
>     the pins in the pinctrl node. You should consider doing the same here.
>     
>     > +};
>     > +
>     > +&vuart {
>     > +	// VUART Host Console
>     > +	status = "okay";
>     > +};
> No Vuart.
> 
>     > +
>     > +&uart1 {
>     > +	// Host Console
>     > +	status = "okay";
>     > +	pinctrl-names = "default";
>     > +	pinctrl-0 = <&pinctrl_txd1_default
>     > +		     &pinctrl_rxd1_default>;
>     > +};
>     > +
>     > +&uart2 {
>     > +	// SoL Host Console
>     > +	status = "okay";
> 
> uart1-4 are all assigned for 4 multiple hosts so define accordingly.  
>     
>     Also needs pinctrl configuration.
>     
>     > +};
>     > +
>     > +&uart3 {
>     > +	// SoL BMC Console
>     > +	status = "okay";
>     
>     Again needs pinctrl.
>     
>     > +};
>     > +
>     > +&uart5 {
>     > +	// BMC Console
>     > +	status = "okay";
>     > +};
>     > +
>     > +&mac0 {
>     > +	status = "okay";
>     > +
>     > +	pinctrl-names = "default";
>     > +	pinctrl-0 = <&pinctrl_rmii1_default>;
>     > +	use-ncsi;
>     > +};
>     > +
>     > +&adc {
>     > +	status = "okay";
>     
>     Strongly suggest adding the pinctrl properties here to ensure
>     exclusive access for the ADC pins.
>     
>     Otherwise it looks reasonable.
>     
>     Andrew
>     
> 

--gKMricLos+KVdGMg
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-ARM-dts-aspeed-Adding-Facebook-Yosemite-V2-BMC.patch"

From 9a17872b5faf2c00ab0b572bac0072e44a3d8b91 Mon Sep 17 00:00:00 2001
From: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
Date: Thu, 21 Nov 2019 11:57:07 +0530
Subject: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC

The Yosemite V2 is a facebook multi-node server
platform that host four OCP server. The BMC
in the Yosemite V2 platorm based on AST2500 SoC.

This patch adds linux device tree entry related to
Yosemite V2 specific devices connected to BMC SoC.

Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
---
 .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 152 +++++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
new file mode 100644
index 0000000..5f9a2e1
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -0,0 +1,152 @@
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
+		&pinctrl_adc1_default
+		&pinctrl_adc2_default
+		&pinctrl_adc3_default
+		&pinctrl_adc4_default
+		&pinctrl_adc5_default
+		&pinctrl_adc6_default
+		&pinctrl_adc7_default
+		&pinctrl_adc8_default
+		&pinctrl_adc9_default
+		&pinctrl_adc10_default
+		&pinctrl_adc11_default
+		&pinctrl_adc12_default
+		&pinctrl_adc13_default
+		&pinctrl_adc14_default
+		&pinctrl_adc15_default>;
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


--gKMricLos+KVdGMg--
