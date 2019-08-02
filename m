Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261BBC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 02:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24F820840
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 02:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="goYxbeEW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUnYSHPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfHBCzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 22:55:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38477 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727848AbfHBCzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 22:55:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FEA021FB6;
        Thu,  1 Aug 2019 22:55:21 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 01 Aug 2019 22:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm3; bh=l5LjbiKcknm05fGmRdJT/jtA1vdx+I7
        zKZnQjtWUt1I=; b=goYxbeEWRGcdU+zqyYVdpOxlXl6x7gs4YowEEszRohKJ8Lg
        Oi6qXNiul8z4uvaY6xxWk3H8KYSTldLCM6nkks5zTo0+d0EubyFiXXjdU/TeclKe
        RqvFpiRkwxzkh9fvBXxFK/KcTPoTefjaYO6io97LXSOhHWJoPZgMgo1VlITgJb8Z
        9O93X1vbZfYBfXotroAxm7iqzz+w5Qtj8wVVf87Rq+r9/nB4ExvGQzrHXf9nWJuk
        ejKUCSJhFz42eNAOHMtMk4++lsat1pS6BMywYzOC0Zx0BW8uD5ZJdv8MXFVU5Qqv
        /nPnUd3DKOq5m5wAio/CvxAoetW3QBKdfiTTG3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=l5Ljbi
        Kcknm05fGmRdJT/jtA1vdx+I7zKZnQjtWUt1I=; b=nUnYSHPRUiB4kabHqt0sia
        ua5nekb97I/gDIa3MpkBB7Rs3tegWB6zlkTunCcXWLRxpkcCJmIS5mqp1Fyuq2dz
        Tg3hYDIWbjnlit3CUaeGifSyl9HPkEtX/hFQYE0hFlVOFgr1ZxvTtDRDNUdgjwXf
        gkk2SylaPI3BAE7Klkym0bo7sjr4oOXiQyYkcng4foEVsFfuSz+CNF323QbDYQKy
        W9kkmHm+fEhNJ1iNTAvrFFOs+bgk/+dap+/ffJLyQJgMThHxUJCMtF3wkEBSOdry
        druNpA72QC2x74SUrvgsP75qy4qUuymrG6q4K+z17uLwEGp+v3KB74VuC0FtFDsg
        ==
X-ME-Sender: <xms:F6ZDXZl2Lg9AZ_0N0_bSCiIvPNKYvUhOZrwoz7Z7SLcBDiZRsZhGSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleekgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:F6ZDXWRHUertP7XXnSE7MwHzCnVwYJqjLiphIM6DWdC2ICHGyqHAbw>
    <xmx:F6ZDXbB1pXdegQrbxJgmHBrdembKwekJxnMhtt6vbOQULjI1taUAxw>
    <xmx:F6ZDXWowztH4Cc8iSWYxDn9sTwWDIoaTXWev7XZtqdZSJABvwAsPSw>
    <xmx:GaZDXZijaswA4fpfKoBE1EXyUk3eNodMaxsEOAAWi7ajBuftaBxR8g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8975AE00A2; Thu,  1 Aug 2019 22:55:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-799-g925e343-fmstable-20190729v1
Mime-Version: 1.0
Message-Id: <b9755ff0-20a9-44f0-9778-59183ded72be@www.fastmail.com>
In-Reply-To: <20190802010155.489238-1-taoren@fb.com>
References: <20190802010155.489238-1-taoren@fb.com>
Date:   Fri, 02 Aug 2019 12:25:39 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Tao Ren" <taoren@fb.com>, "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH] ARM: dts: aspeed: Add Facebook Wedge100 BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2019, at 10:32, Tao Ren wrote:
> Add initial version of device tree for Facebook Wedge100 AST2400 BMC
> platform.
> 
> Signed-off-by: Tao Ren <taoren@fb.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-facebook-wedge100.dts | 149 ++++++++++++++++++
>  2 files changed, 150 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 39a05a10a2a2..d71504ed82d3 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1273,6 +1273,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-cmm.dtb \
>  	aspeed-bmc-facebook-minipack.dtb \
>  	aspeed-bmc-facebook-tiogapass.dtb \
> +	aspeed-bmc-facebook-wedge100.dtb \
>  	aspeed-bmc-facebook-yamp.dtb \
>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-inspur-fp5280g2.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts 
> b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
> new file mode 100644
> index 000000000000..ccd700467ea7
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2018 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g4.dtsi"
> +
> +/ {
> +	model = "Facebook Wedge 100 BMC";
> +	compatible = "facebook,wedge100-bmc", "aspeed,ast2400";
> +
> +	aliases {
> +		/*
> +		 * Override the default uart aliases to avoid breaking
> +		 * the legacy applications.
> +		 */
> +		serial0 = &uart5;
> +		serial1 = &uart1;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart3;
> +		bootargs = "debug console=ttyS2,9600n8 root=/dev/ram rw";
> +	};
> +
> +	memory@40000000 {
> +		reg = <0x40000000 0x20000000>;
> +	};
> +};
> +
> +&wdt1 {
> +	status = "okay";
> +	aspeed,reset-type = "system";
> +};
> +
> +&wdt2 {
> +	status = "okay";
> +	aspeed,reset-type = "system";
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "fmc0";
> +#include "facebook-bmc-flash-layout.dtsi"
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd1_default
> +		     &pinctrl_rxd1_default>;
> +};
> +
> +&uart3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd3_default
> +		     &pinctrl_rxd3_default>;
> +};
> +
> +&uart4 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd4_default
> +		     &pinctrl_rxd4_default>;
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&mac1 {
> +	status = "okay";
> +	no-hw-checksum;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +
> +	i2c-switch@70 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;
> +	};
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +};
> +
> +&i2c10 {
> +	status = "okay";
> +};
> +
> +&i2c11 {
> +	status = "okay";
> +};
> +
> +&i2c12 {
> +	status = "okay";
> +};
> +
> +&i2c13 {
> +	status = "okay";
> +};
> +
> +&vhub {
> +	status = "okay";
> +};
> -- 
> 2.17.1
> 
>
