Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D422133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfCHPO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:14:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48414 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCHPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:14:25 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7A4F280589; Fri,  8 Mar 2019 16:14:15 +0100 (CET)
Date:   Fri, 8 Mar 2019 16:14:22 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, tony@atomide.com,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: dts: omap4-droid4: Update backlight dt
 properties
Message-ID: <20190308151422.GA10378@amd>
References: <20190307220947.20057-1-dmurphy@ti.com>
 <20190307220947.20057-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20190307220947.20057-2-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Update the properties for the lm3532 device node for droid4.
> With this change the backlight LED string and the keypad
> LED strings will be controlled separately.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 27 +++++++++++++++++-------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> index e21ec929f096..94e3d53dbcf3 100644
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
> =20
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/leds-lm3532.h>
>  #include "omap443x.dtsi"
>  #include "motorola-cpcap-mapphone.dtsi"
> =20
> @@ -383,20 +384,30 @@
>  };
> =20
>  &i2c1 {
> -	lm3532@38 {
> +	led-controller@38 {
>  		compatible =3D "ti,lm3532";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
>  		reg =3D <0x38>;
> =20
>  		enable-gpios =3D <&gpio6 12 GPIO_ACTIVE_HIGH>;
> =20
> -		lcd_backlight: backlight {
> -			compatible =3D "ti,lm3532-backlight";
> +		ramp-up-ms =3D <LM3532_RAMP_1024us>;
> +		ramp-down-ms =3D <LM3532_RAMP_65536us>;

I guess dt people will have some comments here. I'd expect

ramp-up-us =3D <1024> would be more natural.

> +		lcd_backlight: led@0 {
> +			reg =3D <0>;
> +			led-sources =3D <2>;
> +			ti,led-mode =3D <LM3532_BL_MODE_MANUAL>;
> +			label =3D "backlight";

Ok, so we'll have lm3532::backlight. That is not too useful, as it
does not tell userland what kaclight it is.

main_display::backlight ?

OTOH this one is not too important as backlight subsystem should
handle this.

> +		led@1 {
> +			reg =3D <1>;
> +			led-sources =3D <1>;
> +			ti,led-mode =3D <LM3532_BL_MODE_MANUAL>;
> +			label =3D "keypad";

I guess best variant would be inputX::backlight here, but that might
be tricky to implement.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyChs4ACgkQMOfwapXb+vIv/ACgr+bHsUANQodAGVuN1nwjp+Hk
EsQAn3mJlgxw10AjQts0YNXx0d/CPN7q
=E/DJ
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
