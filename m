Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD58C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F712073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfG2TPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:15:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38572 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbfG2TPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:15:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 818E3802BB; Mon, 29 Jul 2019 21:15:00 +0200 (CEST)
Date:   Mon, 29 Jul 2019 21:15:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] power: Replace strncmp with str_has_prefix
Message-ID: <20190729191511.GB2023@amd>
References: <20190729151454.9606-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20190729151454.9606-1-hslester96@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-07-29 23:14:54, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone.
> We had better use newly introduced
> str_has_prefix() instead of it.
>=20
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  kernel/power/hibernate.c | 8 ++++----
>  kernel/power/main.c      | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index cd7434e6000d..49d4bfdb2b67 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1188,15 +1188,15 @@ static int __init resume_offset_setup(char *str)
> =20
>  static int __init hibernate_setup(char *str)
>  {
> -	if (!strncmp(str, "noresume", 8)) {
> +	if (str_has_prefix(str, "noresume")) {
>  		noresume =3D 1;
> -	} else if (!strncmp(str, "nocompress", 10)) {
> +	} else if (str_has_prefix(str, "nocompress")) {
>  		nocompress =3D 1;

Ok, old code is bad, too... but this makes the error visible. We do
not want "noresumenextmonday" to set noresume =3D 1, right?

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0/Rb8ACgkQMOfwapXb+vInuwCgm63IL4aJrE7dX7FYi1KtYfOC
g7QAoIxTBaj1yYq/7ThkT594xjbmCZJI
=+PIY
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
