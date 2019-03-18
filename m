Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE8BC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ED420857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfCRLAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:00:20 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37565 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfCRLAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:00:19 -0400
X-Originating-IP: 90.88.22.102
Received: from aptenodytes (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1E17BC000A;
        Mon, 18 Mar 2019 11:00:12 +0000 (UTC)
Message-ID: <16d670d78c5616fb86898fdd8f8fa615177c31af.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH 04/14] pinctrl: sunxi: v3: really
 introduce support for V3
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     icenowy@aosc.io, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Date:   Mon, 18 Mar 2019 12:00:12 +0100
In-Reply-To: <20190312152256.35574-5-icenowy@aosc.io>
References: <20190312152256.35574-1-icenowy@aosc.io>
         <20190312152256.35574-5-icenowy@aosc.io>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

Le mardi 12 mars 2019 à 23:22 +0800, Icenowy Zheng a écrit :
> Introduce the GPIO pins that is only available on V3 (not on V3s) to the
> V3 pinctrl driver.

Thanks for working on this, I was actually close to submitting similar
patches for V3 support!

I just reviewed the definitions and found a mistakes about the LVDS
function (that should be 0x3 instead of 0x2).

Otherwise, things look good and match what I had came up with.

Cheers,

Paul

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c | 291 +++++++++++++++++++++--
>  drivers/pinctrl/sunxi/pinctrl-sunxi.h    |   2 +
>  2 files changed, 275 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> index 6704ce8e5e3d..54c210871a95 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> @@ -1,5 +1,5 @@
>  /*
> - * Allwinner V3s SoCs pinctrl driver.
> + * Allwinner V3/V3s SoCs pinctrl driver.
>   *
>   * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
>   *
> @@ -23,7 +23,7 @@
>  
>  #include "pinctrl-sunxi.h"
>  
> -static const struct sunxi_desc_pin sun8i_v3s_pins[] = {
> +static const struct sunxi_desc_pin sun8i_v3_v3s_pins[] = {
>  	/* Hole */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
> @@ -77,6 +77,30 @@ static const struct sunxi_desc_pin sun8i_v3s_pins[] = {
>  		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
>  		  SUNXI_FUNCTION(0x3, "uart0"),		/* RX */
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PB_EINT9 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(B, 10),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "jtag"),		/* MS */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/* PB_EINT10 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(B, 11),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "jtag"),		/* CK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),	/* PB_EINT11 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(B, 12),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "jtag"),		/* DO */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),	/* PB_EINT12 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(B, 13),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "jtag"),		/* DI */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 13)),	/* PB_EINT13 */
>  	/* Hole */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
> @@ -98,6 +122,180 @@ static const struct sunxi_desc_pin sun8i_v3s_pins[] = {
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "mmc2"),		/* D0 */
>  		  SUNXI_FUNCTION(0x3, "spi0")),		/* MOSI */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 4),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc2")),		/* D1 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 5),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc2")),		/* D2 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 6),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc2")),		/* D3 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 7),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc2")),		/* D4 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 8),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc2")),		/* D5 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 9),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc2")),		/* D6 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(C, 10),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc2")),		/* D7 */
> +	/* Hole */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 0),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D2 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* RXD3 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 1),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D3 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* RXD2 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 2),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D4 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* RXD1 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 3),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D5 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* RXD0 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 4),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D6 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* RXCK */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 5),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D7 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* RXCTL/RXDV */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 6),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D10 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* RXERR */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 7),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D11 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* TXD3 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 8),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D12 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* TXD2 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 9),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D13 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* TXD1 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 10),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D14 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* TXD0 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 11),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D15 */
> +		  SUNXI_FUNCTION(0x4, "emac")),		/* CRS */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 12),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D18 */
> +		  SUNXI_FUNCTION(0x2, "lvds"),		/* VP0 */

LVDS should be function 0x3.

> +		  SUNXI_FUNCTION(0x4, "emac")),		/* TXCK */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 13),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D19 */
> +		  SUNXI_FUNCTION(0x2, "lvds"),		/* VN0 */

Ditto about LVDS.

> +		  SUNXI_FUNCTION(0x4, "emac")),		/* TXCTL/TXEN */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 14),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D20 */
> +		  SUNXI_FUNCTION(0x2, "lvds"),		/* VP1 */

Ditto about LVDS.

> +		  SUNXI_FUNCTION(0x4, "emac")),		/* TXERR */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 15),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D21 */
> +		  SUNXI_FUNCTION(0x2, "lvds"),		/* VN1 */

Ditto about LVDS.

> +		  SUNXI_FUNCTION(0x4, "emac")),		/* CLKIN/COL */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 16),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D22 */
> +		  SUNXI_FUNCTION(0x2, "lvds"),		/* VP2 */

Ditto about LVDS.

> +		  SUNXI_FUNCTION(0x4, "emac")),		/* MDC */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 17),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* D23 */
> +		  SUNXI_FUNCTION(0x2, "lvds"),		/* VN2 */

Ditto about LVDS.

> +		  SUNXI_FUNCTION(0x4, "emac")),		/* MDIO */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 18),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* CLK */
> +		  SUNXI_FUNCTION(0x2, "lvds")),		/* VPC */

Ditto about LVDS.

> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 19),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* DE */
> +		  SUNXI_FUNCTION(0x2, "lvds")),		/* VNC */

Ditto about LVDS.

> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 20),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* HSYNC */
> +		  SUNXI_FUNCTION(0x2, "lvds")),		/* VP3 */

Ditto about LVDS.

> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(D, 21),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd"),		/* VSYNC */
> +		  SUNXI_FUNCTION(0x2, "lvds")),		/* VN3 */

Ditto about LVDS.

>  	/* Hole */
>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
> @@ -291,34 +489,91 @@ static const struct sunxi_desc_pin sun8i_v3s_pins[] = {
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D3 */
>  		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PG_EINT5 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(G, 6),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* TX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),	/* PG_EINT6 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(G, 7),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* RX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 7)),	/* PG_EINT7 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(G, 8),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 8)),	/* PG_EINT8 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(G, 9),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 9)),	/* PG_EINT9 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(G, 10),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s"),		/* SYNC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 10)),	/* PG_EINT10 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(G, 11),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s"),		/* BCLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 11)),	/* PG_EINT11 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(G, 12),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s"),		/* DOUT */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 12)),	/* PG_EINT12 */
> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(G, 13),
> +		  PINCTRL_SUN8I_V3,
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s"),		/* DIN */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 13)),	/* PG_EINT13 */
>  };
>  
> -static const unsigned int sun8i_v3s_pinctrl_irq_bank_map[] = { 1, 2 };
> +static const unsigned int sun8i_v3_v3s_pinctrl_irq_bank_map[] = { 1, 2 };
>  
> -static const struct sunxi_pinctrl_desc sun8i_v3s_pinctrl_data = {
> -	.pins = sun8i_v3s_pins,
> -	.npins = ARRAY_SIZE(sun8i_v3s_pins),
> +static const struct sunxi_pinctrl_desc sun8i_v3_v3s_pinctrl_data = {
> +	.pins = sun8i_v3_v3s_pins,
> +	.npins = ARRAY_SIZE(sun8i_v3_v3s_pins),
>  	.irq_banks = 2,
> -	.irq_bank_map = sun8i_v3s_pinctrl_irq_bank_map,
> +	.irq_bank_map = sun8i_v3_v3s_pinctrl_irq_bank_map,
>  	.irq_read_needs_mux = true
>  };
>  
> -static int sun8i_v3s_pinctrl_probe(struct platform_device *pdev)
> +static int sun8i_v3_v3s_pinctrl_probe(struct platform_device *pdev)
>  {
> -	return sunxi_pinctrl_init(pdev,
> -				  &sun8i_v3s_pinctrl_data);
> +	unsigned long variant = (unsigned long)of_device_get_match_data(&pdev->dev);
> +
> +	return sunxi_pinctrl_init_with_variant(pdev, &sun8i_v3_v3s_pinctrl_data,
> +					       variant);
>  }
>  
> -static const struct of_device_id sun8i_v3s_pinctrl_match[] = {
> -	{ .compatible = "allwinner,sun8i-v3s-pinctrl", },
> -	{}
> +static const struct of_device_id sun8i_v3_v3s_pinctrl_match[] = {
> +	{
> +		.compatible = "allwinner,sun8i-v3-pinctrl",
> +		.data = (void *)PINCTRL_SUN8I_V3
> +	},
> +	{
> +		.compatible = "allwinner,sun8i-v3s-pinctrl",
> +		.data = (void *)PINCTRL_SUN8I_V3S
> +	},
> +	{ },
>  };
>  
> -static struct platform_driver sun8i_v3s_pinctrl_driver = {
> -	.probe	= sun8i_v3s_pinctrl_probe,
> +static struct platform_driver sun8i_v3_v3s_pinctrl_driver = {
> +	.probe	= sun8i_v3_v3s_pinctrl_probe,
>  	.driver	= {
> -		.name		= "sun8i-v3s-pinctrl",
> -		.of_match_table	= sun8i_v3s_pinctrl_match,
> +		.name		= "sun8i-v3-v3s-pinctrl",
> +		.of_match_table	= sun8i_v3_v3s_pinctrl_match,
>  	},
>  };
> -builtin_platform_driver(sun8i_v3s_pinctrl_driver);
> +builtin_platform_driver(sun8i_v3_v3s_pinctrl_driver);
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> index ee15ab067b5f..cfff6b02ddae 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> @@ -94,6 +94,8 @@
>  #define PINCTRL_SUN4I_A10	BIT(6)
>  #define PINCTRL_SUN7I_A20	BIT(7)
>  #define PINCTRL_SUN8I_R40	BIT(8)
> +#define PINCTRL_SUN8I_V3	BIT(9)
> +#define PINCTRL_SUN8I_V3S	BIT(10)
>  
>  struct sunxi_desc_function {
>  	unsigned long	variant;
> -- 
> 2.18.1
> 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

