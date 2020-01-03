Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415F3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222952253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgACS3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:29:16 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:39346 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgACS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:29:15 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 205D51C210C; Fri,  3 Jan 2020 19:29:13 +0100 (CET)
Date:   Fri, 3 Jan 2020 19:29:11 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 071/114] kernel: sysctl: make drop_caches write-only
Message-ID: <20200103182911.GE14328@amd>
References: <20200102220029.183913184@linuxfoundation.org>
 <20200102220036.228967185@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
In-Reply-To: <20200102220036.228967185@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Johannes Weiner <hannes@cmpxchg.org>
>=20
> [ Upstream commit 204cb79ad42f015312a5bbd7012d09c93d9b46fb ]
>=20
> Currently, the drop_caches proc file and sysctl read back the last value
> written, suggesting this is somehow a stateful setting instead of a
> one-time command.  Make it write-only, like e.g.  compact_memory.

I have no problem with that, but is it good idea for stable?

Plus, I seem to recall that drop_caches was somehow dangerous,
debugging-only stuff, one should not use on production system. Did
that get fixed in the meantime?

Best regards,
								Pavel
							=09
> @@ -1411,7 +1411,7 @@ static struct ctl_table vm_table[] =3D {
>  		.procname	=3D "drop_caches",
>  		.data		=3D &sysctl_drop_caches,
>  		.maxlen		=3D sizeof(int),
> -		.mode		=3D 0644,
> +		.mode		=3D 0200,
>  		.proc_handler	=3D drop_caches_sysctl_handler,
>  		.extra1		=3D &one,
>  		.extra2		=3D &four,

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4Ph/cACgkQMOfwapXb+vKyewCfYGsGaL15ikZRERDm/pxgfBWU
vTQAn3NSUiTWplLsT2H6o0QHeo59SVpW
=vtP8
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
