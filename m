Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3965B214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbfDRLYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:24:03 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41875 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbfDRLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:24:02 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 37E1B6000E;
        Thu, 18 Apr 2019 11:23:57 +0000 (UTC)
Date:   Thu, 18 Apr 2019 13:23:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 1/2] arm64: dts: allwinner: a64-amarula-relic: Add
 GT5663 CTP node
Message-ID: <20190418112357.qic227rdwordmzyh@flea>
References: <20190418083543.11695-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a2pbzqfiss63fc44"
Content-Disposition: inline
In-Reply-To: <20190418083543.11695-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a2pbzqfiss63fc44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 02:05:42PM +0530, Jagan Teki wrote:
> Add Goodix GT5663 capacitive touch controller node on
> Amarula A64-Relic board.
>
> The CTP connected to board with,
> - SDA, SCK from i2c1
> - GPIO-LD0 as AVDD28 supply
> - PH4 gpio as interrupt pin
> - PH8 gpio as reset pin
> - X axis is inverted
> - Y axis is inverted
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - drop i2c1, bias-pull-up
>
>  .../allwinner/sun50i-a64-amarula-relic.dts    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> index 3575db216016..3819ce396073 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> @@ -49,6 +49,24 @@
>  	bias-pull-up;
>  };
>
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;

That's the default already

> +	status = "okay";
> +
> +	touchscreen@5d {
> +		compatible = "goodix,gt5663";
> +		reg = <0x5d>;
> +		AVDD28-supply = <&reg_ldo_io0>;			/* VCC-CTP: GPIO0-LDO */
> +		interrupt-parent = <&pio>;
> +		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
> +		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
> +		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
> +		touchscreen-inverted-x;
> +		touchscreen-inverted-y;
> +	};
> +};
> +
>  &mmc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins>;
> @@ -212,6 +230,13 @@
>  	regulator-name = "vdd-cpus";
>  };
>
> +&reg_ldo_io0 {
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;

The name of that regulator is AVDD28, which indicates that it would be
a 2.8V regulator?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--a2pbzqfiss63fc44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLheTQAKCRDj7w1vZxhR
xcuMAQDENJX3u2tb51Ouqd0KaweSmp82cNl08J3eeEk3EXwx1AD/ZbROxKtQ4oO7
zIxGGqxjWWXz43UJCj2XnFglwPybcAI=
=KSHf
-----END PGP SIGNATURE-----

--a2pbzqfiss63fc44--
