Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A579CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72458218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfDXOBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:01:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56671 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfDXOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:01:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4AE3C80772; Wed, 24 Apr 2019 16:01:20 +0200 (CEST)
Date:   Wed, 24 Apr 2019 16:01:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, dtor@google.com,
        linux@roeck-us.net, Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 22/26] leds: as3645a: Use generic support for
 composing LED names
Message-ID: <20190424140128.GD14360@amd>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-23-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-23-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Switch to using generic LED support for composing LED class
> device name.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>

> +static int as3645a_led_class_setup(struct as3645a *flash)
>  {
>  	struct led_classdev *fled_cdev =3D &flash->fled.led_cdev;
>  	struct led_classdev *iled_cdev =3D &flash->iled_cdev;
> +	struct led_init_data init_data;

Not initialized.

>  	struct led_flash_setting *cfg;
>  	int rval;
> =20
> -	iled_cdev->name =3D names->indicator;
>  	iled_cdev->brightness_set_blocking =3D as3645a_set_indicator_brightness;
>  	iled_cdev->max_brightness =3D
>  		flash->cfg.indicator_max_ua / AS_INDICATOR_INTENSITY_STEP;
>  	iled_cdev->flags =3D LED_CORE_SUSPENDRESUME;
> =20
> -	rval =3D led_classdev_register(&flash->client->dev, iled_cdev);
> +	init_data.fwnode =3D flash->indicator_node;
> +	init_data.devicename =3D AS_NAME;
> +	init_data.default_label =3D "indicator";

And struct has one more field:

	 +       /*
	 +        * indicates if LED name should always comprise
         devicename section;
	 +        * only LEDs exposed by drivers of hot-pluggable
         devices should
	 +        * set it to true
	 +        */
	 +       bool devname_mandatory;
	  };

I believe it would be cleaner to always initialize struct with zeros;
that way you can also expand it in future.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAbDgACgkQMOfwapXb+vKq5ACglcaCN/9FwvYniQtE1vovSced
OvYAoI/2Wc8TqlBTLFMD/nofn+dxGPQI
=K0fz
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
