Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EA7C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9851E206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL+/WaCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKZNhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:37:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41461 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfKZNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:37:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id s18so644756pfd.8;
        Tue, 26 Nov 2019 05:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PJJmAn9+iiP+EIIPXeCfCU5GCKc3tnqtF9QuTwOAxck=;
        b=KL+/WaCkMRk4NvtjYC0qrnhtkEiQIlg2VPXwQ2mtmFHFUQEJS20Nz4f3NJbHrR2tyO
         YeiN5ZhzlkkbcKnBOkzbHI9j6E4oud9db8/3TLfxPqIiGNqHQNxZGFDqCzPzFfgeCgAl
         e8AQvrtw/ZhrE6lXlr3mSQfg7HXQrwxsFUs3QLyeJENp0rIeuQLwugjImN+Varj14NMz
         2J9suJyLA9RMZupwPP6txwfMEX9/cGi9yBR0MPK/7ThWyQeqRfi/JSzRnlO8qtB9fM/K
         kPqj2mIuLzFhhV8GrcF5JMMFk998OAhazyVvp19RSmqTc7aOCLicuqFqHcxEyH6t0/pU
         jYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PJJmAn9+iiP+EIIPXeCfCU5GCKc3tnqtF9QuTwOAxck=;
        b=uMDaWDpATLCdC8fn2qdmPFSIYDc+rttGdcW10yubRi3x0++eLD1gyfdxonqKGsp7MJ
         UvJSi2V7LmeuTghuMlRJbQRDoyClv+dhytzvSWbUnYrmmUIZBM++xXNsXJnF4tCRc2Pu
         5Rr/C3je40vNlh2RQv3KhfpHI0zlvZtLFqq93esx4dg8kOkBTu3wx34LiDyVswA5pAfa
         5tTCpUHCTYdU6umcFGWg9bf7IgMPDUvDp5xFvHE6msZVicDRSbjq2j+bA0NYkX/xPvz2
         LGw1IIUO6Mppn6Z9fbAQNwJqXweyoeF9KiJSYpaefy3Onc1BvKE9sBFao+U+WecS0LhD
         vULw==
X-Gm-Message-State: APjAAAVG46sFC2KjZsHiQ2LnwiTGa89mZrfNkEMhduwrtYC4Oj4lSq/F
        sH9c4dpLpQ0BipznOyn9qY0=
X-Google-Smtp-Source: APXvYqwDp/TSNy31xwRpQsSSAIa1D75XoUXADWcKxaaZNigp8t9SyGGfJHWvoaSTa1WNrk5aVzL6hw==
X-Received: by 2002:a65:4387:: with SMTP id m7mr31094525pgp.449.1574775465335;
        Tue, 26 Nov 2019 05:37:45 -0800 (PST)
Received: from cnn ([2402:3a80:473:c4b3:a194:63c9:69fb:ee71])
        by smtp.gmail.com with ESMTPSA id s18sm13210501pfc.120.2019.11.26.05.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 05:37:44 -0800 (PST)
Date:   Tue, 26 Nov 2019 19:07:26 +0530
From:   Manikandan <manikandan.hcl.ers.epl@gmail.com>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     andrew@aj.id.au, joel@jms.id.au, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH v3] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20191126133726.GA2578@cnn>
References: <20191125130420.GA24018@cnn>
 <7F15A2E0-14C7-4C86-B589-35619A390B72@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7F15A2E0-14C7-4C86-B589-35619A390B72@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 07:23:32PM +0000, Vijay Khemka wrote:
> 
> ﻿On 11/25/19, 5:04 AM, "manikandan-e" <manikandan.hcl.ers.epl@gmail.com> wrote:
> 
>     The Yosemite V2 is a facebook multi-node server
>     platform that host four OCP server. The BMC
>     in the Yosemite V2 platorm based on AST2500 SoC.
>     
>     This patch adds linux device tree entry related to
>     Yosemite V2 specific devices connected to BMC SoC.
> Nit: comments inline. Otherwise
> Reviewed-by: Vijay Khemka <vijaykhemka@fb.com>
>     
> 
>     Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
>     ---
>      .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 151 +++++++++++++++++++++
>      1 file changed, 151 insertions(+)
>      create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>     
>     diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>     new file mode 100644
>     index 0000000..09bffcd
>     --- /dev/null
>     +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>     @@ -0,0 +1,151 @@
>     +// SPDX-License-Identifier: GPL-2.0+
>     +// Copyright (c) 2018 Facebook Inc.
>     +/dts-v1/;
>     +
>     +#include "aspeed-g5.dtsi"
>     +#include <dt-bindings/gpio/aspeed-gpio.h>
>     +
>     +/ {
>     +	model = "Facebook Yosemitev2 BMC";
>     +	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
>     +	aliases {
>     +		serial4 = &uart5;
>     +	};
>     +	chosen {
>     +		stdout-path = &uart5;
>     +		bootargs = "console=ttyS4,115200 earlyprintk";
> bootargs are not required as it is overwritten by uboot. And baud rate is 57600
           
          As of now SPL and U-boot Baudrate based 115200 baudrate. Do we need to change it there. I understand that we can use SERIAL_CONSOLES           in meta-facebook.
          Do i need to remove 'console=ttyS4.115200' or complete bootargs . If we remove bootargs, how can add any bootargs params in future.

>     +	};
>     +
>     +	memory@80000000 {
>     +		reg = <0x80000000 0x20000000>;
>     +	};
>     +
>     +	iio-hwmon {
>     +		// VOLATAGE SENSOR
>     +		compatible = "iio-hwmon";
>     +		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
>     +		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
>     +		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
>     +		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
>     +	};
>     +};
>     +
>     +&fmc {
>     +	status = "okay";
>     +	flash@0 {
>     +		status = "okay";
>     +		m25p,fast-read;
>     +#include "openbmc-flash-layout.dtsi"
>     +	};
>     +};
>     +
>     +&spi1 {
>     +	status = "okay";
>     +	pinctrl-names = "default";
>     +	pinctrl-0 = <&pinctrl_spi1_default>;
>     +	flash@0 {
>     +		status = "okay";
>     +		m25p,fast-read;
>     +		label = "pnor";
>     +	};
>     +};
>     +
>     +&uart5 {
>     +	// BMC Console
>     +	status = "okay";
>     +};
>     +
>     +&mac0 {
>     +	status = "okay";
>     +	pinctrl-names = "default";
>     +	pinctrl-0 = <&pinctrl_rmii1_default>;
>     +	use-ncsi;
>     +};
>     +
>     +&adc {
>     +	status = "okay";
>     +        pinctrl-names = "default";
> Use tab for alignment


Checkpatch didn't shown any issue warning .As i checked in many dts file , format is same.
It will helpful if i get more clarification. 

>     +	pinctrl-0 = <&pinctrl_adc0_default
>     +			&pinctrl_adc1_default
>     +			&pinctrl_adc2_default
>     +			&pinctrl_adc3_default
>     +			&pinctrl_adc4_default
>     +			&pinctrl_adc5_default
>     +			&pinctrl_adc6_default
>     +			&pinctrl_adc7_default
>     +			&pinctrl_adc8_default
>     +			&pinctrl_adc9_default
>     +			&pinctrl_adc10_default
>     +			&pinctrl_adc11_default
>     +			&pinctrl_adc12_default
>     +			&pinctrl_adc13_default
>     +			&pinctrl_adc14_default
>     +			&pinctrl_adc15_default>;
>     +};
>     +
>     +&i2c8 {
>     +	status = "okay";
>     +	//FRU EEPROM
>     +	eeprom@51 {
>     +		compatible = "atmel,24c64";
>     +		reg = <0x51>;
>     +		pagesize = <32>;
>     +	};
>     +};
>     +
>     +&i2c9 {
>     +	status = "okay";
>     +	tmp421@4e {
>     +	//INLET TEMP
>     +		compatible = "ti,tmp421";
>     +		reg = <0x4e>;
>     +	};
>     +	//OUTLET TEMP
>     +	tmp421@4f {
>     +		compatible = "ti,tmp421";
>     +		reg = <0x4f>;
>     +	};
>     +};
>     +
>     +&i2c10 {
>     +	status = "okay";
>     +	//HSC
>     +	adm1278@40 {
>     +		compatible = "adi,adm1278";
>     +		reg = <0x40>;
>     +	};
>     +};
>     +
>     +&i2c11 {
>     +	status = "okay";
>     +	//MEZZ_TEMP_SENSOR
>     +	tmp421@1f {
>     +		compatible = "ti,tmp421";
>     +		reg = <0x1f>;
>     +	};
>     +};
>     +
>     +&i2c12 {
>     +	status = "okay";
>     +	//MEZZ_FRU
>     +	eeprom@51 {
>     +		compatible = "atmel,24c64";
>     +		reg = <0x51>;
>     +		pagesize = <32>;
>     +	};
>     +};
>     +
>     +&pwm_tacho {
>     +	status = "okay";
>     +	//FSC
>     +	pinctrl-names = "default";
>     +	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
>     +	fan@0 {
>     +		reg = <0x00>;
>     +		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
>     +	};
>     +	fan@1 {
>     +		reg = <0x01>;
>     +		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
>     +	};
>     +};
>     -- 
>     2.7.4
>     
>     
> 
