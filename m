Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B44AC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A642081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgAGK34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:29:56 -0500
Received: from sauhun.de ([88.99.104.3]:49270 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbgAGK34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:29:56 -0500
Received: from localhost (p5486CF8B.dip0.t-ipconnect.de [84.134.207.139])
        by pokefinder.org (Postfix) with ESMTPSA id 134CD2C05BA;
        Tue,  7 Jan 2020 11:29:55 +0100 (CET)
Date:   Tue, 7 Jan 2020 11:29:54 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Maxime Ripard <maxime@cerno.tech>, michal.lkml@markovi.net,
        Gilles.Muller@lip6.fr, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Brown <broonie@kernel.org>, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Julia.Lawall@lip6.fr, Thierry Reding <thierry.reding@gmail.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinnelle: Remove ptr_ret script
Message-ID: <20200107102954.GB1135@ninjato>
References: <20200107073629.325249-1-maxime@cerno.tech>
 <alpine.DEB.2.21.2001071106420.3004@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001071106420.3004@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 11:06:56AM +0100, Julia Lawall wrote:
>=20
>=20
> On Tue, 7 Jan 2020, Maxime Ripard wrote:
>=20
> > The ptr_ret script script addresses a number of situations where we end=
 up
> > testing an error pointer, and if it's an error returning it, or return 0
> > otherwise to transform it into a PTR_ERR_OR_ZERO call.
> >
> > So it will convert a block like this:
> >
> > if (IS_ERR(err))
> >     return PTR_ERR(err);
> >
> > return 0;
> >
> > into
> >
> > return PTR_ERR_OR_ZERO(err);
> >
> > While this is technically correct, it has a number of drawbacks. First,=
 it
> > merges the error and success path, which will make it harder for a revi=
ewer
> > or reader to grasp.
> >
> > It's also more difficult to extend if we were to add some code between =
the
> > error check and the function return, making the author essentially reve=
rt
> > that patch before adding new lines, while it would have been a trivial
> > addition otherwise for the rewiever.
> >
> > Therefore, since that script is only about cosmetic in the first place,
> > let's remove it since it's not worth it.
> >
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> Acked-by: Julia Lawall <julia.lawall@inria.fr>

Convincing patch description, good catch!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4UXaIACgkQFA3kzBSg
KbZSJA//eaZ9Y30oBx4dvR9MAfnqJNL8vx1eaSQyTcuwrb1agcOSP2yBfkZE+sH4
Co+Zly+1IjKpRE6r9zLFbv83rFFK4Lt6JA/L5tXTBIMxEXXA3Cb2plnpfsMbDq8I
ah6RUroz4n46w1Kd5cU78RB813tchIizvvhdWIbuSUqgeE6FurBJOW0ybrNOYO+8
L9q9tM5rKGZIfEs68rxMIZnL+MkcO+47jykNqrJOrqsX87pVJtoiY7uuH36OvuUn
7bgC8LWQJvRG3U7wKyugqZhqkLCfqUN1dAtYCEZC0IcrzUfZO6HNOK4dzOg9W8Xd
nVcLA7z0PEFDYdP1uMyprUT9HnwN4zktCF6Bm+xIMgMSI0ukiOaYnx4bFXMVecl0
JudONZisFLHZ9KzOfSzXhfv/Pltwzs0KUul8k6KYqRrHuC+lmFiV7juKccPX6Y3g
FIjd2K5S3ITQDXrbixxfEhRFaqhOflgtvYoNnHZYs4F7SoSJx3iR7RLpyNdlKXjp
fJWOohJo9xoOiphmueC6QO2hG18UXMEfP0CcJFUfU4WCGS//3rLlH9O/XZp2V/rU
9taGESdnSAubzx72/mvsi7fkYC/p5gvFFqRxOwFpDcOoaN0yrQ/2WlQ5//AazC0O
ZwinD8thAFb1EA7fGSYeVv6+37e8EnAX0T2M6YPs30UBW4yYczo=
=kiKB
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
