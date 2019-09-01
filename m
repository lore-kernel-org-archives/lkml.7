Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B85C3A5A7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 10:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A227B2190F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 10:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfIAK0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 06:26:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47989 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfIAK0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 06:26:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7577382318; Sun,  1 Sep 2019 12:26:20 +0200 (CEST)
Date:   Sun, 1 Sep 2019 12:26:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] leds: is31fl32xx: Use struct_size() helper
Message-ID: <20190901102633.GB29681@amd>
References: <20190830181448.GA24483@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20190830181448.GA24483@embeddedor>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-08-30 13:14:48, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>=20
> struct is31fl32xx_priv {
> 	...
>         struct is31fl32xx_led_data leds[0];
> };
>=20
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
>=20
> So, replace the following function:
>=20
> static inline size_t sizeof_is31fl32xx_priv(int num_leds)
> {
>        return sizeof(struct is31fl32xx_priv) +
>                      (sizeof(struct is31fl32xx_led_data) * num_leds);
> }
>=20
> with:
>=20
> struct_size(priv, leds, count)
>=20
> This code was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1rnNkACgkQMOfwapXb+vIPxgCgpsICdNpvVqiE62UuGfp0t9A8
QVQAn3e0reKEOTT22eUmr3FMkDGRBvUU
=L98W
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
