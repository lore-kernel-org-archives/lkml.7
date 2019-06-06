Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8ADC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C05520684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfFFNND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:13:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50643 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFNND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:13:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B3EDB80271; Thu,  6 Jun 2019 15:12:50 +0200 (CEST)
Date:   Thu, 6 Jun 2019 15:13:00 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Justin Chen <justinpopo6@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 189/276] iio: adc: ti-ads7950: Fix improper use of
 mlock
Message-ID: <20190606131300.GE27432@amd>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030537.017297326@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline
In-Reply-To: <20190530030537.017297326@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(stable removed from cc list)

> Indio->mlock is used for protecting the different iio device modes.
> It is currently not being used in this way. Replace the lock with
> an internal lock specifically used for protecting the SPI transfer
> buffer.
>=20
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/iio/adc/ti-ads7950.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>=20

> @@ -277,6 +280,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq=
, void *p)
>  	struct ti_ads7950_state *st =3D iio_priv(indio_dev);
>  	int ret;
> =20
> +	mutex_lock(&st->slock);
>  	ret =3D spi_sync(st->spi, &st->ring_msg);
>  	if (ret < 0)
>  		goto out;
> @@ -285,6 +289,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq=
, void *p)
>  					   iio_get_time_ns(indio_dev));
> =20
>  out:
> +	mutex_unlock(&st->slock);
>  	iio_trigger_notify_done(indio_dev->trig);
> =20
>  	return IRQ_HANDLED;

Does trigger_handler run from interrupt context? Prototype suggests
so... If so, it can not really take mutexes...

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz5EVwACgkQMOfwapXb+vJCHACdFbGlNmouCwE8ij5J2hpfSJCC
sisAn12ujluwRRJcjLn/IZ9asP/L6yc4
=jHLo
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
