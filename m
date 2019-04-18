Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FF1C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28196206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfDRO4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:56:46 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:44971 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRO4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:56:46 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id BC80C4000C;
        Thu, 18 Apr 2019 14:56:41 +0000 (UTC)
Date:   Thu, 18 Apr 2019 16:56:41 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable
 CAN
Message-ID: <20190418145641.q23tupopz2czjzc5@flea>
References: <20190418141658.10868-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ubqlaoup2nr4gj7m"
Content-Disposition: inline
In-Reply-To: <20190418141658.10868-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ubqlaoup2nr4gj7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 07:46:58PM +0530, Jagan Teki wrote:
> Oceanic 5205 5inMFD has MCP2515 CAN device connected via SPI1.
>
> - via SPI1 bus
> - vdd supplied by 5V supply along with PL2 enable pin
> - xceiver supply same as vdd
> - can oscillator connected at 20MHz
> - PB2 gpio as interrupt pin
> - PD6 gpio as RX_BUF1_CAN0
> - PD7 gpio as RX_BUF0_CAN0
>
> Tested-by: Tamas Papp <tamas@osukl.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../sun50i-a64-oceanic-5205-5inmfd.dts        | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> index f0cd6587f619..22535a297f51 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> @@ -21,6 +21,24 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	can_osc: can-osc {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <20000000>;
> +	};
> +
> +	reg_can_v5v: reg-can-v5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "reg-can-v5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* CAN_3V3_EN: PL2 */
> +		status = "okay";

You don't need the status property here.

> +	};
> +
>  };
>
>  &ehci0 {
> @@ -77,6 +95,31 @@
>  	status = "okay";
>  };
>
> +&pio {
> +	can_pins: can-pins {
> +		pins = "PD6",			/* RX_BUF1_CAN0 */
> +		       "PD7";			/* RX_BUF0_CAN0 */
> +		function = "gpio_in";
> +	};
> +};

That isn't needed. What are they used for, you're not tying them to
anything?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ubqlaoup2nr4gj7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLiQKQAKCRDj7w1vZxhR
xRf+AP9HjPtUm9E6M4+r2qWke+5hMF4d+A4bbuD9FzCcaMEJnAD/arISN0KgRAnn
8+tjI3HkIRFz/RZaKY8qQg1257S15QE=
=YwZr
-----END PGP SIGNATURE-----

--ubqlaoup2nr4gj7m--
