Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F4CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F36120857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCRLUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:20:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59933 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfCRLU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:20:29 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0AFBD8056F; Mon, 18 Mar 2019 12:20:20 +0100 (CET)
Date:   Mon, 18 Mar 2019 12:20:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/6] leds: netdev trigger: use memcpy in
 device_name_store
Message-ID: <20190318112027.GA6101@amd>
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20190314140619.3309-2-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-03-14 15:06:14, Rasmus Villemoes wrote:
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
>=20
> This is also preparation for future patches.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyPfvsACgkQMOfwapXb+vKOvgCgqiyTfYd0+V2ObT2VRP6kXG3J
upAAn17RsHq8Gx6/q0Ui7GNZEKg1GBfd
=ZsZF
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
