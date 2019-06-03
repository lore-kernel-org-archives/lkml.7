Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2ADC282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A1F27A72
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="UPwa2efQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GHPag7bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfFCB2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 21:28:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58905 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbfFCB2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:28:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A18E21B6B;
        Sun,  2 Jun 2019 21:28:49 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 02 Jun 2019 21:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=hP4Wp118CYUjOZy5FQ76Tf1KK73NL/j
        bE6MU60faow4=; b=UPwa2efQJr7pRU3x3FD40oq1h+NVmQfL6+foK9uBmdprtgB
        0rYCBHYdBkq9CmYxJOTqYIHdM+MXX0jqy/5I8uZazlQbjVyQqOeQlJFSdl3DMp1G
        wAObMQ8Zdh99gz0bHhvf/3FiXHOOsm9OPwQEWph4qG0ZD+e1rb0grNeWRbYy8Mxp
        U67XoMWxJaMv1NScKxlFV/k6lEK/0Gy3jvno5chDVzPNctGL1bew4u6jp2yMU/mB
        7BuWvGZ0V24PYUkJI55ROhgc9aqSc3zXWl/SuGTSXf1tGNnzYrL7MkYrClaaphOP
        6Fh8ACQ3szyRUuFSTcop4nbjJ+KtZiXTLxRCdlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hP4Wp1
        18CYUjOZy5FQ76Tf1KK73NL/jbE6MU60faow4=; b=GHPag7bu9prVLOr/gQW+vg
        1EqP341H8G0LzO22ffMQWplc7093cHGmbfIiXfB82xtCmZSIx7fP9NYLGifWiNMf
        vH/2F+rE+W56LR5Z0hbQKLIMab73LTqRtETzqRQEHZ3elsS8Gm26hNA+vzaa2sU/
        P28s0A+LC1cLrAJvcNpc9o5Bu50YDTF1EIiP6Ur4/nM5yRkpIoU/wcQirjQPTvVj
        wBduAYpb3gPenwkezNYjgvfUkitK44FuPAjB0UVnJ2YTPU8he7HNSBgTdnUqrYK+
        yRRLkbkjtzt6Nh3ZiDPy5HJgTzEJBYDh580oEurf5MpfOvvFY3hwy4DEuB+hYBFw
        ==
X-ME-Sender: <xms:z3f0XK6trGKcUl4rIR4_AyjGQDVei5MBnxz5EF1fa2vIGT9Hy5jahQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:z3f0XOkJa1VCZ4FXWsEm4i0KlnBejThtc9KZU3vwSvmImO64gUBLOg>
    <xmx:z3f0XJrTz28vU6FFJp8vNQJjGEY3IeRBfjyRbM3CbMpw45ugs8TQJQ>
    <xmx:z3f0XIBINBqEkki7BsU9BJL63I5dfTO15uh-FrVnGEpuXfKu3DMZvA>
    <xmx:0Xf0XPzokBWVa_sZ3yAOp_mOMvcpRECpfc065nc8JCUWYP29xBS_TQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AF983E00A2; Sun,  2 Jun 2019 21:28:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-555-g49357e1-fmstable-20190528v2
Mime-Version: 1.0
Message-Id: <246c9b25-1c05-4c2f-9185-c438c97ebdec@www.fastmail.com>
In-Reply-To: <20190531090950.13466-1-a.filippov@yadro.com>
References: <20190531090950.13466-1-a.filippov@yadro.com>
Date:   Mon, 03 Jun 2019 10:58:47 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Alexander A. Filippov" <a.filippov@yadro.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "Joel Stanley" <joel@jms.id.au>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ARM: dts: aspeed: Add YADRO VESNIN BMC
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 May 2019, at 18:40, Alexander Filippov wrote:
> VESNIN is an OpenPower machine with an Aspeed 2400 BMC SoC manufactured
> by YADRO.
> 
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 224 ++++++++++++++++++++
>  2 files changed, 225 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index dab2914fa293..64a956372fe1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1272,6 +1272,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-opp-lanyang.dtb \
>  	aspeed-bmc-opp-palmetto.dtb \
>  	aspeed-bmc-opp-romulus.dtb \
> +	aspeed-bmc-opp-vesnin.dtb \
>  	aspeed-bmc-opp-witherspoon.dtb \
>  	aspeed-bmc-opp-zaius.dtb \
>  	aspeed-bmc-portwell-neptune.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts 
> b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> new file mode 100644
> index 000000000000..0b9e29c3212e
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> @@ -0,0 +1,224 @@
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
