Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C31DC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81127206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfFVRvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:51:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55232 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:51:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C595E80689; Sat, 22 Jun 2019 19:51:17 +0200 (CEST)
Date:   Sat, 22 Jun 2019 19:51:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jaegeuk@kernel.org,
        yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: Next 20190621: fails to link f2fs in x86-32
Message-ID: <20190622175127.GA1741@amd>
References: <20190621110311.GF24145@amd>
 <20190621214657.1624e5a4@canb.auug.org.au>
 <20190622174945.GA30317@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20190622174945.GA30317@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I get this during compilation:
> > >=20
> > >   CC      net/netfilter/core.o
> > >   In file included from net/netfilter/core.c:19:0:
> > >   ./include/linux/netfilter_ipv6.h: In function
> > >   =E2=80=98nf_ipv6_cookie_init_sequence=E2=80=99:
> > >   ./include/linux/netfilter_ipv6.h:174:2: error: implicit declaration
> > >   of function =E2=80=98__cookie_v6_init_sequence=E2=80=99
> > >   [-Werror=3Dimplicit-function-declaration]
> > >     return __cookie_v6_init_sequence(iph, th, mssp);
> > >       ^
> > >       ./include/linux/netfilter_ipv6.h: In function
> > >   =E2=80=98nf_cookie_v6_check=E2=80=99:
> > >   ./include/linux/netfilter_ipv6.h:189:2: error: implicit declaration
> > >   of function =E2=80=98__cookie_v6_check=E2=80=99
> > >   [-Werror=3Dimplicit-function-declaration]
> > >     return __cookie_v6_check(iph, th, cookie);
> > >       ^
> > >       cc1: some warnings being treated as errors
> > >       scripts/Makefile.build:278: recipe for target
> > >   'net/netfilter/core.o' failed
> > >   make[2]: *** [net/netfilter/core.o] Error 1
> > >   scripts/Makefile.build:498: recipe for target 'net/netfilter' failed
> > >   make[1]: *** [net/netfilter] Error 2
> > >=20
> > > Is it known?
> >=20
> > Yes, and should be fixed in next-20190621.
>=20
> Ok, that one is indeed gone. Now I'm getting failure in f2fs:
>=20
> ld: fs/f2fs/gc.o: in function `f2fs_resize_fs':
> gc.c:(.text+0x3a91): undefined reference to `__umoddi3'
> ld: gc.c:(.text+0x3b70): undefined reference to `__udivdi3'
> make: *** [Makefile:1052: vmlinux] Error 1
>=20
> I'll try compiling on on older gcc.

Same result:

fs/f2fs/gc.o: In function `f2fs_resize_fs':
gc.c:(.text+0x3a62): undefined reference to `__umoddi3'
gc.c:(.text+0x3b5e): undefined reference to `__udivdi3'
Makefile:1052: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1
make took 12 minutes 8 seconds

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0Oap8ACgkQMOfwapXb+vJy2QCgpxfvMHwFXmeGi/MbVsF074zo
5zoAoIaOIu3TsKhpO4eY6QODU+t7/5Kn
=eTP/
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
