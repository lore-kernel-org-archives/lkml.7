Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB05218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfCONZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:25:31 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52591 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfCONZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:25:31 -0400
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id DEA8B20019;
        Fri, 15 Mar 2019 13:25:25 +0000 (UTC)
Date:   Fri, 15 Mar 2019 14:25:25 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: bananapi-m64: Enable
 S070WV20-CT16 DSI panel
Message-ID: <20190315132525.te3vaiukcniavaz2@flea>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-7-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dgz7eolxcwybvexh"
Content-Disposition: inline
In-Reply-To: <20190315130825.9005-7-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgz7eolxcwybvexh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 06:38:25PM +0530, Jagan Teki wrote:
> This patch add support for Bananapi S070WV20-CT16 DSI panel to
> BPI-M64 board.
>=20
> Bananapi S070WV20-CT16 is a pure RGB output panel with ICN6211 DSI/RGB
> convertor bridge, so enable bridge along with associated panel.
>=20
> DSI panel connected via board DSI port with,
> - DLDO1 as VCC-DSI supply
> - PD6 gpio for reset pin
> - PD5 gpio for backlight enable pin
> - PD7 gpio for backlight vdd supply
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> index 7793ebb5d2b8..f31083aa4521 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> @@ -45,6 +45,7 @@
>  #include "sun50i-a64.dtsi"
> =20
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pwm/pwm.h>
> =20
>  / {
>  	model =3D "BananaPi-M64";
> @@ -56,6 +57,15 @@
>  		serial1 =3D &uart1;
>  	};
> =20
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels =3D <1 2 4 8 16 32 64 128 512>;
> +		default-brightness-level =3D <2>;
> +		enable-gpios =3D <&pio 3 5 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PD5 */
> +		power-supply =3D <&reg_vdd_backlight>;
> +	};
> +
>  	chosen {
>  		stdout-path =3D "serial0:115200n8";
>  	};
> @@ -91,6 +101,26 @@
>  		};
>  	};
> =20
> +	panel-connector {
> +		compatible =3D "bananapi,s070wv20-ct16", "simple-panel";
> +
> +		port {
> +			backlight =3D <&backlight>;
> +			panel_ep: endpoint {
> +				remote-endpoint =3D <&bridge_out_ep>;
> +			};
> +		};
> +	};
> +
> +	reg_vdd_backlight: vdd-backlight {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vdd-backlight";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		gpio =3D <&pio 3 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PD7 */
> +		enable-active-high;
> +	};
> +
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible =3D "mmc-pwrseq-simple";
>  		reset-gpios =3D <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> @@ -116,6 +146,33 @@
>  	status =3D "okay";
>  };
> =20
> +&dphy {
> +	status =3D "okay";
> +};
> +
> +&dsi {
> +	vcc-dsi-supply =3D <&reg_dldo1>;		/* VCC3V3-DSI */
> +	status =3D "okay";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	bridge@0 {
> +		compatible =3D "bananapi,icn6211", "chipone, icn6211";

There's a typo in the compatible

> +		reg =3D <0>;
> +		reset-gpios =3D <&pio 3 6 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD6 */
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		port@1 {
> +			reg =3D <1>;
> +
> +			bridge_out_ep: endpoint {
> +				remote-endpoint =3D <&panel_ep>;
> +			};
> +		};

The port here should be under a node called ports, with two ports,
which is what you documented in your binding.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dgz7eolxcwybvexh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIunxQAKCRDj7w1vZxhR
xYM6AP0SIg/izMSRFCknAA3uUJaO1O5Rcrbsj80n/CLeLI7QdgD/evp8LOuxuY4O
5oK17zZM11/DgJ4kx0mwDAB8k7QENQk=
=+9NT
-----END PGP SIGNATURE-----

--dgz7eolxcwybvexh--
