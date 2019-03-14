Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F67B2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfCNKOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:14:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60555 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCNKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:14:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 26ACC80373; Thu, 14 Mar 2019 11:14:13 +0100 (CET)
Date:   Thu, 14 Mar 2019 11:14:19 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/4] leds: netdev trigger: use memcpy in device_name_store
Message-ID: <20190314101419.GA14455@amd>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20190313202615.22883-2-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> If userspace doesn't end the input with a newline (which can easily
> happen if the write happens from a C program that does write(fd,
> iface, strlen(iface))), we may end up including garbage from a
> previous, longer value in the device_name. For example
>=20
> # cat device_name
>=20
> # printf 'eth12' > device_name
> # cat device_name
> eth12
> # printf 'eth3' > device_name
> # cat device_name
> eth32
>=20
> I highly doubt anybody is relying on this behaviour, so switch to
> simply copying the bytes (we've already checked that size is <
> IFNAMSIZ) and unconditionally zero-terminate it; of course, we also
> still have to strip a trailing newline.

  char device_name[IFNAMSIZ];

Ok, good catch reporting the bug, but are you sure the fix is right?

AFAICT the design is that device_name does _not_ have to be zero
terminated, and your fix incorrectly limits the size of device_name.

								Pavel
							=09
> index 3dd3ed46d473..ddc2b90ad7ec 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -122,7 +122,8 @@ static ssize_t device_name_store(struct device *dev,
>  		trigger_data->net_dev =3D NULL;
>  	}
> =20
> -	strncpy(trigger_data->device_name, buf, size);
> +	memcpy(trigger_data->device_name, buf, size);
> +	trigger_data->device_name[size] =3D '\0';

I'd do =3D 0 for consistency with code below.

I believe the strncpy() is right to use here, but code should be
modified so that zero-termination is not required.

>  	if (size > 0 && trigger_data->device_name[size - 1] =3D=3D '\n')
>  		trigger_data->device_name[size - 1] =3D 0;
> =20
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyKKXsACgkQMOfwapXb+vJOVQCfRaoUZM6KYRD3x+2fhWHxr/71
2FYAnR1TS3o2vz5/s0c2UMtMcMoCRdfE
=Cfdv
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
