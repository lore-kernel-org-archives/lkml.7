Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA1CC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 20:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76E32054F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 20:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfEEUql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 16:46:41 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46735 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEEUql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 16:46:41 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44xyZz6tFyz1rWTR;
        Sun,  5 May 2019 22:46:35 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44xyZz6Bvwz1rN3N;
        Sun,  5 May 2019 22:46:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 7i7h1doJJxDc; Sun,  5 May 2019 22:46:33 +0200 (CEST)
X-Auth-Info: VRVxY4GhWIAzO707IXEb/OTysBqrgWSgwGuFsiB94Oc=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  5 May 2019 22:46:33 +0200 (CEST)
Date:   Sun, 5 May 2019 22:46:23 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Stepan Golosunov <stepan@golosunov.pp.ru>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        Arnd Bergmann <arnd@arndb.de>, Paul Eggert <eggert@cs.ucla.edu>
Subject: Re: [PATCH v2 2/7] y2038: Introduce __ASSUME_64BIT_TIME define
Message-ID: <20190505224623.0212d919@jawa>
In-Reply-To: <20190505141053.gzff6q4j33x5vpiy@sghpc.golosunov.pp.ru>
References: <20190414220841.20243-1-lukma@denx.de>
        <20190429104613.16209-1-lukma@denx.de>
        <20190429104613.16209-3-lukma@denx.de>
        <alpine.DEB.2.21.1904292138430.21580@digraph.polyomino.org.uk>
        <20190430110505.2a0c7d1a@jawa>
        <alpine.DEB.2.21.1905021431060.4027@digraph.polyomino.org.uk>
        <20190505141053.gzff6q4j33x5vpiy@sghpc.golosunov.pp.ru>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/i/ewWc4wg6kMKW48ipw7YbJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i/ewWc4wg6kMKW48ipw7YbJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 5 May 2019 18:10:54 +0400
Stepan Golosunov <stepan@golosunov.pp.ru> wrote:

> 02.05.2019 =D0=B2 15:04:18 +0000 Joseph Myers =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB:
> > On Tue, 30 Apr 2019, Lukasz Majewski wrote:
> >  =20
> > >  - The need for explicit clearing padding when calling syscalls
> > > (as to be better safe than sorry in the future - there was related
> > >    discussion started by Stepan). =20
> >=20
> > This really isn't a difficult question.  What it comes down to is
> > whether the Linux kernel, in the first release version with these
> > syscalls (we don't care about old -rc versions; what matters is the
> > actual 5.1 release), ignores the padding.
> >=20
> > If 5.1 *release* ignores the padding, that is part of the
> > kernel/userspace ABI, in accordance with the kernel principle of
> > not breaking userspace. Thus, it is something userspace can rely
> > on, now and in the future.
> >=20
> > If 5.1 release does not ignore the padding, syscall presence does
> > not mean the padding is ignored by the kernel and so glibc needs to
> > clear padding. Of course, it needs to clear padding in a *copy* of
> > the value provided by the user unless the glibc API in question
> > requires the timespec value in question to be in writable memory.
> >=20
> > So, which is (or will be) the case in 5.1 release?  Padding ignored
> > or not?  If more complicated (ignored for some architectures / ABIs
> > but not for others, or depending on whether compat syscalls are in
> > use), then say so - give a precise description of the exact
> > circumstances under which the padding around a 32-bit tv_nsec will
> > or will not be ignored by the kernel on input from userspace. =20
>=20
> In current linux git it looks like padding is correctly ignored in
> 32-bit kernels (because kernel itself has 32-bit tv_nsec there) but
> the code to clear it on compat syscalls in 64-bit kernels seems to be
> broken.
>=20
> The patch to fix this is at
>=20
> https://lore.kernel.org/lkml/20190429131951.471701-1-arnd@arndb.de/
>=20
> but it doesn't seem like it has reached Linus yet.
>=20

I hope that this patch will be pulled soon (before final cut) - for that
reason we can assume that the padding is ignored by the kernel and
hence do not explicitly clear it in glibc (as it was done in sent
patches)

>=20
> (Hmm.  I think that old ipc and socketcall syscalls in 32-bit kernels
> are broken without that patch too.  They would try to read
> __kernel_timespec when callers are passing old_timespec32.)

Please correct me if I'm wrong, but this problem is related to x32
machines (and not to ARM 32 bit ones with Y2038).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/i/ewWc4wg6kMKW48ipw7YbJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlzPS6AACgkQAR8vZIA0
zr2U9wgAx55Q2wg69sFMJgWdNJlcRX8An59Q3dNlxHfg97f8d+UK38mZjausITBj
5PWZv4p1jR7Aec3LSEOxYqVjOjFdc6Avs1QpYejNL4rZ4OQhvhtU+qFFLLwITwlR
nMTfmQ6hAWqR5us/vbuSBEexMA9B044d/fUKGv839IrhmQ0uqJqo3T8UCmEV7Cpp
uGnheXxPiDV1OZraPqY+z5t/c+eppVLWAjR78L4D84/EQYq4Kk9lkFv1uCROpSWN
XHUzPN0vWQe5vaqwwO6WTCy8Jg+zbcZTK6dhwqc7oCvlZGqAWVeDEedKzzrwaOd0
eZm3B1pedP7YBqIOjis9+eyfH3YFdA==
=pz2n
-----END PGP SIGNATURE-----

--Sig_/i/ewWc4wg6kMKW48ipw7YbJ--
