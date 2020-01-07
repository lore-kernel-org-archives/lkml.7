Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E122EC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EF220880
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgAGWCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:02:08 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:49054 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgAGWCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:02:07 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C7EC91C259A; Tue,  7 Jan 2020 23:02:05 +0100 (CET)
Date:   Tue, 7 Jan 2020 23:02:05 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 006/115] iio: adc: max9611: Fix too short conversion
 time delay
Message-ID: <20200107220204.GA619@amd>
References: <20200107205240.283674026@linuxfoundation.org>
 <20200107205243.776152935@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20200107205243.776152935@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> Fix this by increasing the delay from 1000-2000 =B5s to 3000-3300 =B5s.
>=20
> Note that this issue has always been present, but it was exposed by the
> aformentioned commit.

> +++ b/drivers/iio/adc/max9611.c
> @@ -92,6 +92,12 @@
>  #define MAX9611_TEMP_SCALE_NUM		1000000
>  #define MAX9611_TEMP_SCALE_DIV		2083
> =20
> +/*
> + * Conversion time is 2 ms (typically) at Ta=3D25 degreeC
> + * No maximum value is known, so play it safe.
> + */
> +#define MAX9611_CONV_TIME_US_RANGE	3000, 3300
> +
>  struct max9611_dev {
>  	struct device *dev;
>  	struct i2c_client *i2c_client;

This is evil. It looks like a constant, but it is two
constants. Just... don't do this.

What about

     static inline usleep_conversion(void) { usleep_range(3000, 3300); }

? (Plus, normally we use bigger ranges to make the job of highres
infrastructure easier. 3 to 6ms would be typical.)..

Best regards,
								Pavel

> -	/*
> -	 * need a delay here to make register configuration
> -	 * stabilize. 1 msec at least, from empirical testing.
> -	 */
> -	usleep_range(1000, 2000);
> +	/* need a delay here to make register configuration stabilize. */
> +
> +	usleep_range(MAX9611_CONV_TIME_US_RANGE);
> =20
>  	ret =3D i2c_smbus_read_word_swapped(max9611->i2c_client, reg_addr);
>  	if (ret < 0) {
> @@ -510,7 +514,7 @@ static int max9611_init(struct max9611_dev *max9611)
>  			MAX9611_REG_CTRL2, 0);
>  		return ret;
>  	}
> -	usleep_range(1000, 2000);
> +	usleep_range(MAX9611_CONV_TIME_US_RANGE);
> =20
>  	return 0;
>  }

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4U/9wACgkQMOfwapXb+vKcAACglAXT31mK/lo5WLqTEKvReuTq
YHkAnRU+WnTCfgTyv5+c05Omvtus0oRk
=Kz86
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
