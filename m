Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAB3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A801D218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfDXOFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:05:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56915 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfDXOFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:05:10 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F14DF809D9; Wed, 24 Apr 2019 16:04:58 +0200 (CEST)
Date:   Wed, 24 Apr 2019 16:05:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, dtor@google.com,
        linux@roeck-us.net, Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH v4 26/26] leds: an30259a: Use generic support for
 composing LED names
Message-ID: <20190424140507.GF14360@amd>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-27-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-27-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-17 22:54:39, Jacek Anaszewski wrote:
> Switch to using generic LED support for composing LED class
> device name.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Simon Shields <simon@lineageos.org>

> @@ -312,13 +306,20 @@ static int an30259a_probe(struct i2c_client *client)
>  	chip->regmap =3D devm_regmap_init_i2c(client, &an30259a_regmap_config);
> =20
>  	for (i =3D 0; i < chip->num_leds; i++) {
> +		struct led_init_data init_data;
> +
>  		an30259a_init_default_state(&chip->leds[i]);
>  		chip->leds[i].cdev.brightness_set_blocking =3D
>  			an30259a_brightness_set;
>  		chip->leds[i].cdev.blink_set =3D an30259a_blink_set;
> =20
> -		err =3D devm_led_classdev_register(&client->dev,
> -						 &chip->leds[i].cdev);
> +		init_data.fwnode =3D chip->leds[i].fwnode;
> +		init_data.devicename =3D AN30259A_NAME;
> +		init_data.default_label =3D ":";
> +
> +		err =3D devm_led_classdev_register_ext(&client->dev,
> +						 &chip->leds[i].cdev,
> +						 &init_data);
>  		if (err < 0)
>  			goto exit;
>  	}

Again, uninitialized field in init_data... AFAICT.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAbRMACgkQMOfwapXb+vLtWQCgtsoesGVMGHnNJ1R6dDT2LiLr
xS8AoIOJG2/DoSof86TJfxX9cIiDS7rm
=iEHy
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
