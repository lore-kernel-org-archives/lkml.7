Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3195FC43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 22:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C8E2068F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="l11f+KSK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AXJj1iu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKXWFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 17:05:05 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54903 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726842AbfKXWFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 17:05:04 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C47D227D1;
        Sun, 24 Nov 2019 17:05:03 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 24 Nov 2019 17:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=w7VW6B5fKWHMLGaL/fpHr6+gZSU1LDe
        1lQlUb/zRF1U=; b=l11f+KSKlTkXQ25Iu7y5FHMzsyMiDhjWcAGWqBg1Fpfv+LZ
        3azFi3TTFlZyb9DuHia/B7y6Bk62cOYI6K60CpQ6KLWiOk9NOaQ/5/6z+sNrUgnB
        +KRhIE/1BDrUq6cmW4kC4auzgNSoCXZPTgH4ZeS50VQwh2cNMO4m6cx4nObM+ILS
        LuIQZYcpFaqBErB7GpC/m3iEq8WSiCURdUtABzGxdczryfA8js9F0cVAk3frfILP
        +OQEMsX0TaY0L+j4vicRS6A7hntrJuE8pPsESycoJK+wlsSJAGCicWw7Re5bOQc1
        ky5+JIljaeGZ1Gj2FRiIooi8QFTK5pGrfc21Rzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=w7VW6B
        5fKWHMLGaL/fpHr6+gZSU1LDe1lQlUb/zRF1U=; b=AXJj1iu9HfKbaJxwQg2c5k
        Mp3+wnXqpZD2kGOXiygk/Yj3DS3kNNPoCAIOvYfc2aM484zh8Lr5uC6kUOxJiUvR
        XBOZ7ZKGcZ7yMWO829np8+pxgAapzONMFiAhMCrg3uqBgm5lkpIc7DIZAC/MupBc
        hnl8rxdwle3TI6YG9izQPr1sSyypvJYdG0GMjROHwS+81IEqXgLZwCC+nex9L/8k
        MGqfbUbUq+MajUaSnRkmijy8FC2u44L/j6EiB1XuzEO01eusRhvk+G/5WfT/sMCS
        Dr+l7ojV9WNs0l+UK0FsfsbX5mP/Yo+/UfDpMRqE9w5ItIyUcMjphf/+VY8WeIBQ
        ==
X-ME-Sender: <xms:jv7aXSlx4PtFry02C5P87ZYbIeg1McnXmwkfbfhIOfXtscju1VM-WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehkedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:jv7aXf_nkcHGpAUj1zvvYRHx0z7UwzsQgAr2OLol7pUGeaTOs3qZJQ>
    <xmx:jv7aXXKT1EwIq5zkU_yoUpXyt4pf4IeraURUar-h2sGoJYc_fn9xUA>
    <xmx:jv7aXQnJq0yhXqdR9Ilhk8mOW9QAGzwMFohFGcn9yucKwek0kKfCBQ>
    <xmx:j_7aXUNplr6oEMfWGjkUa-5rA-LNp9Sza_WzRIA_oNnsbTp6GY6l0A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0F474E00A5; Sun, 24 Nov 2019 17:05:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <7402f01e-9678-4373-9326-d25d569d408a@www.fastmail.com>
In-Reply-To: <20191122103022.GA15913@cnn>
References: <20191118123707.GA5560@cnn>
 <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
 <D34D3A2F-9CD5-4924-8407-F6EB0A4C66B5@fb.com> <20191121074843.GA10607@cnn>
 <0fce7468-bb35-4d47-8d5d-abc228e99085@www.fastmail.com>
 <20191122103022.GA15913@cnn>
Date:   Mon, 25 Nov 2019 08:36:30 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     manikandan-e <manikandan.hcl.ers.epl@gmail.com>
Cc:     "Joel Stanley" <joel@jms.id.au>,
        "Vijay Khemka" <vijaykhemka@fb.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH v2] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Nov 2019, at 21:00, Manikandan wrote:
> 
> From 9a17872b5faf2c00ab0b572bac0072e44a3d8b91 Mon Sep 17 00:00:00 2001
> From: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
> Date: Thu, 21 Nov 2019 11:57:07 +0530
> Subject: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
> 
> The Yosemite V2 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V2 platorm based on AST2500 SoC.
> 
> This patch adds linux device tree entry related to
> Yosemite V2 specific devices connected to BMC SoC.
> 
> Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
> ---
>  .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 152 +++++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts 
> b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> new file mode 100644
> index 0000000..5f9a2e1
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2018 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Facebook Yosemitev2 BMC";
> +	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
> +	aliases {
> +		serial0 = &uart1;

Is this necessary now that you're not enabling uart1?

But otherwise:

Acked-by: Andrew Jeffery <andrew@aj.id.au>

However, I'm guessing you copy/pasted the patch as we still have the
reply text at the bottom. Copy/paste can lead to mangled whitespace
or other errors that prevent the patch from being applied cleanly. I
recommend getting set up and familiar with `git send-email` to give
your patch the best chance of being applied without trouble. The
`git format-patch` / `git send-email` pair also take care of iterating
on your patch with e.g. the `-v` switch that injects the version number
of the patch in the appropriate places.

Andrew

> +		serial4 = &uart5;
> +	};
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200 earlyprintk";
> +	};
> +
> +	memory@80000000 {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	iio-hwmon {
> +		// VOLATAGE SENSOR
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
> +		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
> +		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
> +		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
> +	};
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +#include "openbmc-flash-layout.dtsi"
> +	};
> +};
> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "pnor";
> +	};
> +};
> +
> +&uart5 {
> +	// BMC Console
> +	status = "okay";
> +};
> +
> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +	use-ncsi;
> +};
> +
> +&adc {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_default
> +		&pinctrl_adc1_default
> +		&pinctrl_adc2_default
> +		&pinctrl_adc3_default
> +		&pinctrl_adc4_default
> +		&pinctrl_adc5_default
> +		&pinctrl_adc6_default
> +		&pinctrl_adc7_default
> +		&pinctrl_adc8_default
> +		&pinctrl_adc9_default
> +		&pinctrl_adc10_default
> +		&pinctrl_adc11_default
> +		&pinctrl_adc12_default
> +		&pinctrl_adc13_default
> +		&pinctrl_adc14_default
> +		&pinctrl_adc15_default>;
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +	//FRU EEPROM
> +	eeprom@51 {
> +		compatible = "atmel,24c64";
> +		reg = <0x51>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +	tmp421@4e {
> +	//INLET TEMP
> +		compatible = "ti,tmp421";
> +		reg = <0x4e>;
> +	};
> +	//OUTLET TEMP
> +	tmp421@4f {
> +		compatible = "ti,tmp421";
> +		reg = <0x4f>;
> +	};
> +};
> +
> +&i2c10 {
> +	status = "okay";
> +	//HSC
> +	adm1278@40 {
> +		compatible = "adi,adm1278";
> +		reg = <0x40>;
> +	};
> +};
> +
> +&i2c11 {
> +	status = "okay";
> +	//MEZZ_TEMP_SENSOR
> +	tmp421@1f {
> +		compatible = "ti,tmp421";
> +		reg = <0x1f>;
> +	};
> +};
> +
> +&i2c12 {
> +	status = "okay";
> +	//MEZZ_FRU
> +	eeprom@51 {
> +		compatible = "atmel,24c64";
> +		reg = <0x51>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&pwm_tacho {
> +	status = "okay";
> +	//FSC
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> +	fan@0 {
> +		reg = <0x00>;
> +		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> +	};
> +	fan@1 {
> +		reg = <0x01>;
> +		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
> +	};
> +};
> -- 
> 2.7.4
> 
> 
> On Fri, Nov 22, 2019 at 09:16:39AM +1030, Andrew Jeffery wrote:
> > 
> > 
> > On Thu, 21 Nov 2019, at 18:18, Manikandan wrote:
> > > 
> > > Hi Andrew/Vijay,
> > > 
> > > Thanks for the review .
> > > 
> > > The following changes done in dts and tested in Facebook Yosemite V2 
> > > BMC platform,
> > >   1. LPC feature removed as not supported .
> > >   2. VUART feature removed as not supported.
> > >   3. Host UART feature removed as not in the current scope.
> > >   4. ADC pinctrl details added in dts.
> > 
> > Can you please re-send the patch as a v2 and inline to the mail rather than
> > as an attachment?
> > 
> > Cheers,
> > 
> > Andrew
>
