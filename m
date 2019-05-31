Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A1AC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEB326461
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="auoLB1VP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="abRTm+US"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfEaGcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:32:41 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36049 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbfEaGcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:32:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 438CF21C1C;
        Fri, 31 May 2019 02:32:39 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Fri, 31 May 2019 02:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=eHsCSKwiL50isW9M7Os0oH0hIAtyWEL
        zv22cCRYdRhY=; b=auoLB1VP1juPgobrKAd1pVA5zUgmsi3DOyaz8trU6pX5cX1
        K/Io6kaR3fhdE4ol5fLtCyKAIwXHniGXbtjsL+NIegsRjNVC7DFtpHxxCmzhhNoe
        9ekM9pQ2Xqa7l4XjPFbD4QydRzgexJBirBQ1dbidlo/f8YKPkxAqVICNEDq7hBrZ
        IaVnhdt++O1T4njqZDIKq6Y/d+NgRUXwe1RHanLRN5tfQoF6CrP+og5xiflwGjdL
        Oy6Fc7QgBER0JggGhRFOTCfcKhouT34u9gVNJzfegJFgZ6+CHpR9vFgNL+FLqc+z
        Cl1ECKB6dLekiwpBgMPWO2f7SuDAhTmFJmVWkvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eHsCSK
        wiL50isW9M7Os0oH0hIAtyWELzv22cCRYdRhY=; b=abRTm+US9E9ZGIUSP4C/zM
        dKnlwOFNHFRyPH/OPxkOoD0VUrq+OIlX67rRkRSKt7FI1MW+y8Cq/3WUUr/XDD9d
        26M/1RD554hwtGF4WevSRZsMl7sgfJHXH0HpWxr6glKTm09KIpYj9ZkGgsJIiMlo
        V0UeALat+Tynmv+ilKzE+KQ/6c1CdyaUvYM0jHb3rwAlHDyC+cDhF+VPsOYT2AqF
        /l79N1HzisU+qHPN29yKksrVYXpyjqtvowcjwbkJiB4NPike7JPEGHqBaRkK3ZX1
        A5CtM2lm7UPa8Sn19ws2IQqxVecNnnvmfoYctFoszN6ED5TuobImJfqjljRCrpBQ
        ==
X-ME-Sender: <xms:hsrwXJF2ZJXV3OZfOuOgKU0Pdoe2XziXCq1l_JWB3pzLWJuTrFOr7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeftddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:hsrwXOhGorIKqygvxcZgdm6EGTh-zoqZhCaQCnrFDXlcS-bxgaoAIQ>
    <xmx:hsrwXEoKTJWTAQw_C6Ffe0YWAx733JMAx2QVIoaSkg4b8wXVsDsr7g>
    <xmx:hsrwXOKSrsA6Xzv15_iVwJnNXYb55uNaGDR9m1ZexPx1da3OmmFE8A>
    <xmx:h8rwXJug24ECwK9EX88qUWa0l4HNvxxdScC_G-aa3XjFvKhdP7lZzw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2D89DE00A1; Fri, 31 May 2019 02:32:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-555-g49357e1-fmstable-20190528v2
Mime-Version: 1.0
Message-Id: <2966b961-77ca-4371-949c-195b623e344b@www.fastmail.com>
In-Reply-To: <20190531061207.23079-1-a.filippov@yadro.com>
References: <20190531061207.23079-1-a.filippov@yadro.com>
Date:   Fri, 31 May 2019 16:02:37 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Alexander A. Filippov" <a.filippov@yadro.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "Joel Stanley" <joel@jms.id.au>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: aspeed: Add YADRO VESNIN BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander,

On Fri, 31 May 2019, at 15:42, Alexander Filippov wrote:
> VESNIN is an OpenPower machine with an Aspeed 2400 BMC SoC manufactured
> by YADRO.
> 
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 234 ++++++++++++++++++++
>  2 files changed, 235 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 834cce80d1b8..09a851a4705c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1261,6 +1261,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-opp-palmetto.dtb \
>  	aspeed-bmc-opp-romulus.dtb \
>  	aspeed-bmc-opp-swift.dtb \
> +	aspeed-bmc-opp-vesnin.dtb \

The patch doesn't apply to upstream - the Swift machine only exists in the
OpenBMC kernel tree. Please rebase the patch onto upstream and resend.

>  	aspeed-bmc-opp-witherspoon.dtb \
>  	aspeed-bmc-opp-zaius.dtb \
>  	aspeed-bmc-portwell-neptune.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts 
> b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> new file mode 100644
> index 000000000000..20f07f5bb4f4
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2019 YADRO
> +/dts-v1/;
> +
> +#include "aspeed-g4.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Vesnin BMC";
> +	compatible = "yadro,vesnin-bmc", "aspeed,ast2400";
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200 earlyprintk";
> +	};
> +
> +	memory {
> +		reg = <0x40000000 0x20000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		vga_memory: framebuffer@5f000000 {
> +			no-map;
> +			reg = <0x5f000000 0x01000000>; /* 16MB */
> +		};
> +		flash_memory: region@5c000000 {
> +			no-map;
> +			reg = <0x5c000000 0x02000000>; /* 32M */
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		heartbeat {
> +			gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_LOW>;
> +		};
> +		power_red {
> +			gpios = <&gpio ASPEED_GPIO(N, 1) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		id_blue {
> +			gpios = <&gpio ASPEED_GPIO(O, 0) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		alarm_red {
> +			gpios = <&gpio ASPEED_GPIO(N, 6) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		alarm_yel {
> +			gpios = <&gpio ASPEED_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		button_checkstop {
> +			label = "checkstop";
> +			linux,code = <74>;
> +			gpios = <&gpio ASPEED_GPIO(P, 5) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		button_identify {
> +			label = "identify";
> +			linux,code = <152>;
> +			gpios = <&gpio ASPEED_GPIO(O, 7) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +        label = "bmc";
> +#include "openbmc-flash-layout.dtsi"
> +	};
> +};
> +
> +&spi {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1debug_default>;

Is this how the board is strapped? I'm asking in case it's just copy/paste
from Palmetto, which was (unfortunately) strapped this way.

> +
> +	flash@0 {
> +		status = "okay";
> +		label = "pnor";
> +		m25p,fast-read;
> +	};
> +};
> +
> +&mac0 {
> +	status = "okay";
> +
> +	use-ncsi;
> +	no-hw-checksum;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +};
> +
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&lpc_ctrl {
> +	status = "okay";
> +	memory-region = <&flash_memory>;
> +	flash = <&spi>;
> +};
> +
> +&ibt {
> +	status = "okay";
> +};
> +
> +&lpc_host {
> +    sio_regs: regs {
> +        compatible = "aspeed,bmc-misc";

The patches for this are not upstream, and won't make it in their current
form. Please drop this node from the patch.

> +    };
> +};
> +
> +&mbox {
> +	status = "okay";

This driver is not upstream either, and we plan on dropping it from the
OpenBMC tree too. Please remove this node from the patch.

Cheers,

Andrew

> +};
> +
> +&uart3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd2_default &pinctrl_rxd2_default>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +		pagesize = <64>;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	tmp75@49 {
> +		compatible = "ti,tmp75";
> +		reg = <0x49>;
> +	};
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
> +
> +	occ-hwmon@50 {
> +		compatible = "ibm,p8-occ-hwmon";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +
> +	occ-hwmon@51 {
> +		compatible = "ibm,p8-occ-hwmon";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +
> +	w83795g@2f {
> +		compatible = "nuvoton,w83795g";
> +		reg = <0x2f>;
> +	};
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +
> +	occ-hwmon@56 {
> +		compatible = "ibm,p8-occ-hwmon";
> +		reg = <0x56>;
> +	};
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
> +
> +	occ-hwmon@57 {
> +		compatible = "ibm,p8-occ-hwmon";
> +		reg = <0x57>;
> +	};
> +};
> +
> +&i2c12 {
> +	status = "okay";
> +
> +	rtc@68 {
> +		compatible = "maxim,ds3231";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&i2c13 {
> +	status = "okay";
> +};
> +
> +&vuart {
> +	status = "okay";
> +};
> -- 
> 2.20.1
> 
>
