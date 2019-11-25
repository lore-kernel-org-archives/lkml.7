Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA32C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E65E20679
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI6IsimL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfKYOnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:43:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37694 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:43:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id bb5so6606395plb.4;
        Mon, 25 Nov 2019 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/FRN7AT6tWZXDlZiFJ0UfwFKWjqZZWjeoWJsd3yOPw=;
        b=RI6IsimLtUFGeNpJH1Bsc/NgF24vRBtg+SWahmWPP7KUZC63PbUBn3qvRTMP9yB/F4
         /gO5yr+9bzgyb3F7FkErLx/4LAAdYHXXuHLetGVhLq0JEv0r61Hu9/0Lq6cRCECxPmi9
         FigfVU/zkSy/Os3te2YaFLX/VjB3iWYALs3e/7aySYoYCv9am7DqZsJTiIpe4SVhXDyQ
         fU7GhEPMZnA1cSrpPVCn5BuDHwAfAYS54SUJCUvqt/HB+87Nkngg9aDkkpTcgFKUhYmk
         2ldgB4cYAQXuJVzdBHQoaYajVnUdxst5E7HgS/erakCk9MPWWmPfcg/USMlRdKgXFp8/
         D5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/FRN7AT6tWZXDlZiFJ0UfwFKWjqZZWjeoWJsd3yOPw=;
        b=lw3FzNm+z1alZktEbLP+vqXSa8QqNUcwTkAvIAAdGbPleFVQwGedY4yFBjvufQqycK
         1CkrrNymf9wD8HjVuuazHQEcDp9qBZt6kcq9Kf+x5HVLfvk1E6Rr1pmXyTy5MaYLKEMq
         A7HgtMh436+s230ZrfD+++13vbXCDVq7KedlVFxceCb9PfrFv+TuFcbhY/UGe4W0cIm5
         vNdtj652d98kr3yNzGwC5H8YuEXjOOd0tJqe2vaTL2LqRgWQ3ZNvpFbDtxLFYLc6vpmQ
         SXnZs4wY7TGcWrcEAXBzGtyhfZxjxiM4Hp843b8yuUu1GP/dgIq1gk55kk/ev2wQeYY/
         9fag==
X-Gm-Message-State: APjAAAUnUyCCO84uIIOjjpSYgJRy1RBtYLKkpThUgRPWENKdekazivoI
        hLcGj2r49hEoJw7EYe1MVpo=
X-Google-Smtp-Source: APXvYqxXyUsaxTFvs8K1DfiEgWYBWmITm1Pt6umt6L83cqSUP1mnggG6bc1qVsfuzRYkgzGkrb6ipg==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr38053107pjb.99.1574693017023;
        Mon, 25 Nov 2019 06:43:37 -0800 (PST)
Received: from cnn ([2402:3a80:42d:2c57:5d0d:9f5:fef:e996])
        by smtp.gmail.com with ESMTPSA id s2sm8623942pgv.48.2019.11.25.06.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 06:43:33 -0800 (PST)
Date:   Mon, 25 Nov 2019 20:13:27 +0530
From:   Manikandan <manikandan.hcl.ers.epl@gmail.com>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     joel@jms.id.au, vijaykhemka@fb.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH v2] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20191125144327.GA15417@cnn>
References: <20191118123707.GA5560@cnn>
 <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
 <D34D3A2F-9CD5-4924-8407-F6EB0A4C66B5@fb.com>
 <20191121074843.GA10607@cnn>
 <0fce7468-bb35-4d47-8d5d-abc228e99085@www.fastmail.com>
 <20191122103022.GA15913@cnn>
 <7402f01e-9678-4373-9326-d25d569d408a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7402f01e-9678-4373-9326-d25d569d408a@www.fastmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 08:36:30AM +1030, Andrew Jeffery wrote:
> 
> 
> On Fri, 22 Nov 2019, at 21:00, Manikandan wrote:
> > 
> > From 9a17872b5faf2c00ab0b572bac0072e44a3d8b91 Mon Sep 17 00:00:00 2001
> > From: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
> > Date: Thu, 21 Nov 2019 11:57:07 +0530
> > Subject: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
> > 
> > The Yosemite V2 is a facebook multi-node server
> > platform that host four OCP server. The BMC
> > in the Yosemite V2 platorm based on AST2500 SoC.
> > 
> > This patch adds linux device tree entry related to
> > Yosemite V2 specific devices connected to BMC SoC.
> > 
> > Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
> > ---
> >  .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 152 +++++++++++++++++++++
> >  1 file changed, 152 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > 
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts 
> > b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > new file mode 100644
> > index 0000000..5f9a2e1
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > @@ -0,0 +1,152 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright (c) 2018 Facebook Inc.
> > +/dts-v1/;
> > +
> > +#include "aspeed-g5.dtsi"
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +
> > +/ {
> > +	model = "Facebook Yosemitev2 BMC";
> > +	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
> > +	aliases {
> > +		serial0 = &uart1;
> 
> Is this necessary now that you're not enabling uart1?
   Removed in dts.
> 
> But otherwise:
> 
> Acked-by: Andrew Jeffery <andrew@aj.id.au>
> 
> However, I'm guessing you copy/pasted the patch as we still have the
> reply text at the bottom. Copy/paste can lead to mangled whitespace
> or other errors that prevent the patch from being applied cleanly. I
> recommend getting set up and familiar with `git send-email` to give
> your patch the best chance of being applied without trouble. The
> `git format-patch` / `git send-email` pair also take care of iterating
> on your patch with e.g. the `-v` switch that injects the version number
> of the patch in the appropriate places.
> 
> Andrew
> 
 Thanks for input. I have done patch version based on 'git format-patch' and send patch as v3 using mutt.

> > +		serial4 = &uart5;
> > +	};
> > +	chosen {
> > +		stdout-path = &uart5;
> > +		bootargs = "console=ttyS4,115200 earlyprintk";
> > +	};
> > +
> > +	memory@80000000 {
> > +		reg = <0x80000000 0x20000000>;
> > +	};
> > +
> > +	iio-hwmon {
> > +		// VOLATAGE SENSOR
> > +		compatible = "iio-hwmon";
> > +		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
> > +		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
> > +		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
> > +		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
> > +	};
> > +};
> > +
> > +&fmc {
> > +	status = "okay";
> > +	flash@0 {
> > +		status = "okay";
> > +		m25p,fast-read;
> > +#include "openbmc-flash-layout.dtsi"
> > +	};
> > +};
> > +
> > +&spi1 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_spi1_default>;
> > +	flash@0 {
> > +		status = "okay";
> > +		m25p,fast-read;
> > +		label = "pnor";
> > +	};
> > +};
> > +
> > +&uart5 {
> > +	// BMC Console
> > +	status = "okay";
> > +};
> > +
> > +&mac0 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_rmii1_default>;
> > +	use-ncsi;
> > +};
> > +
> > +&adc {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_adc0_default
> > +		&pinctrl_adc1_default
> > +		&pinctrl_adc2_default
> > +		&pinctrl_adc3_default
> > +		&pinctrl_adc4_default
> > +		&pinctrl_adc5_default
> > +		&pinctrl_adc6_default
> > +		&pinctrl_adc7_default
> > +		&pinctrl_adc8_default
> > +		&pinctrl_adc9_default
> > +		&pinctrl_adc10_default
> > +		&pinctrl_adc11_default
> > +		&pinctrl_adc12_default
> > +		&pinctrl_adc13_default
> > +		&pinctrl_adc14_default
> > +		&pinctrl_adc15_default>;
> > +};
> > +
> > +&i2c8 {
> > +	status = "okay";
> > +	//FRU EEPROM
> > +	eeprom@51 {
> > +		compatible = "atmel,24c64";
> > +		reg = <0x51>;
> > +		pagesize = <32>;
> > +	};
> > +};
> > +
> > +&i2c9 {
> > +	status = "okay";
> > +	tmp421@4e {
> > +	//INLET TEMP
> > +		compatible = "ti,tmp421";
> > +		reg = <0x4e>;
> > +	};
> > +	//OUTLET TEMP
> > +	tmp421@4f {
> > +		compatible = "ti,tmp421";
> > +		reg = <0x4f>;
> > +	};
> > +};
> > +
> > +&i2c10 {
> > +	status = "okay";
> > +	//HSC
> > +	adm1278@40 {
> > +		compatible = "adi,adm1278";
> > +		reg = <0x40>;
> > +	};
> > +};
> > +
> > +&i2c11 {
> > +	status = "okay";
> > +	//MEZZ_TEMP_SENSOR
> > +	tmp421@1f {
> > +		compatible = "ti,tmp421";
> > +		reg = <0x1f>;
> > +	};
> > +};
> > +
> > +&i2c12 {
> > +	status = "okay";
> > +	//MEZZ_FRU
> > +	eeprom@51 {
> > +		compatible = "atmel,24c64";
> > +		reg = <0x51>;
> > +		pagesize = <32>;
> > +	};
> > +};
> > +
> > +&pwm_tacho {
> > +	status = "okay";
> > +	//FSC
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> > +	fan@0 {
> > +		reg = <0x00>;
> > +		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> > +	};
> > +	fan@1 {
> > +		reg = <0x01>;
> > +		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
> > +	};
> > +};
> > -- 
> > 2.7.4
> > 
> > 
> > On Fri, Nov 22, 2019 at 09:16:39AM +1030, Andrew Jeffery wrote:
> > > 
> > > 
> > > On Thu, 21 Nov 2019, at 18:18, Manikandan wrote:
> > > > 
> > > > Hi Andrew/Vijay,
> > > > 
> > > > Thanks for the review .
> > > > 
> > > > The following changes done in dts and tested in Facebook Yosemite V2 
> > > > BMC platform,
> > > >   1. LPC feature removed as not supported .
> > > >   2. VUART feature removed as not supported.
> > > >   3. Host UART feature removed
> > > >   4. ADC pinctrl details added in dts.
> > > 
> > > Can you please re-send the patch as a v2 and inline to the mail rather than
> > > as an attachment?
> > > 
> > > Cheers,
> > > 
> > > Andrew
> >
