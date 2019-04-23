Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A8AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A29E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfDWPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:45:50 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42201 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbfDWPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:45:41 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44pSTD4BClz1r90x;
        Tue, 23 Apr 2019 17:45:36 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44pSTD3Sl9z1qsc2;
        Tue, 23 Apr 2019 17:45:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ynfPWFXJXCX6; Tue, 23 Apr 2019 17:45:34 +0200 (CEST)
X-Auth-Info: byM0R9GdDHxtuvjnhRoZgTa4oXGHn+n2Tlkp7iYQMeI=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 23 Apr 2019 17:45:34 +0200 (CEST)
Date:   Tue, 23 Apr 2019 17:45:24 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Stepan Golosunov <stepan@golosunov.pp.ru>,
        Joseph Myers <joseph@codesourcery.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] y2038: linux: Provide __clock_settime64
 implementation
Message-ID: <20190423174524.486d7833@jawa>
In-Reply-To: <CAK8P3a1+2H_XAZVivutv98S5Op8HENVfxP=zh39VPcLCx2okQg@mail.gmail.com>
References: <20190414220841.20243-1-lukma@denx.de>
        <20190414220841.20243-4-lukma@denx.de>
        <20190420002009.l65upn2t3qqoj5uy@sghpc.golosunov.pp.ru>
        <20190420132112.131f449b@jawa>
        <20190422090710.bmxdhhankurhafxq@sghpc.golosunov.pp.ru>
        <CAK8P3a1+2H_XAZVivutv98S5Op8HENVfxP=zh39VPcLCx2okQg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qTpx=9eA/uQSaz4olOo3n50"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qTpx=9eA/uQSaz4olOo3n50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Arnd and Stepan,

> On Mon, Apr 22, 2019 at 11:07 AM Stepan Golosunov
> <stepan@golosunov.pp.ru> wrote:
> > 20.04.2019 =D0=B2 13:21:12 +0200 Lukasz Majewski =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB:
> > Is it? The kernel (5.1-rc6) code looks to me like
> >
> >         /* Zero out the padding for 32 bit systems or in compat
> > mode */ if (false && false)
> >                 kts.tv_nsec &=3D 0xFFFFFFFFUL;
> >
> > in 32-bit kernels. And like
> >
> >         if (false && true)
> >                 kts.tv_nsec &=3D 0xFFFFFFFFUL;
> >
> > for COMPAT syscalls in 64-bit kernels.
> >
> > It should probably be changed into
> >
> >         if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
> >                 kts.tv_nsec &=3D 0xFFFFFFFFUL;
> >
> > (Or into something like
> >
> >         if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()
> > && !COMPAT_USE_64BIT_TIME) kts.tv_nsec &=3D 0xFFFFFFFFUL;
> >
> > if x32 should retain 64-bit tv_nsec.) =20
>=20
> I think the problem is that at some point CONFIG_64BIT_TIME was
> meant to be enabled on both 32-bit and 64-bit kernels, but the
> definition got changed along  the way.
>=20
> We probably just want
>=20
>         if (in_compat_syscall() )
>                kts.tv_nsec &=3D 0xFFFFFFFFUL;
>=20
> here, which would then truncate the nanoseconds for all compat
> mode including x32. For native mode, we don't need to truncate
> it, since timespec64 has a 32-bit 'tv_nsec' field in the kernel.
>=20
> > > However, I would prefer not to pass random data
> > > to the kernel, and hence I do clear it up explicitly in glibc. =20
> >
> > If the kernel does not ignore padding on its own, then zeroing it
> > out is required everywhere timespec is passed to kernel, including
> > via code not known to glibc. (Does anyone promise that there won't
> > be any ioctls that accept timespec, for example?) That seems to be
> > error-prone (and might requre copying larger structes).
> >
> > On the other hand, if kernel 5.1+ ignores padding as intended there
> > is no need to create additional copy of structs in glibc code that
> > calls into clock_settime64 (or into timer_settime64 that accepts
> > larger struct, for example). =20

Ok, I think I see your point:

- As kernel is ignoring padding, there is no need to copy the structure
  and set the padding to 0.

However, in patch:
[PATCH 1/6] y2038: Introduce internal for glibc struct __timespec64

The internal (for glibc) structure has been introduced - it has 32 bit
tv_nsec and 32 bit padding. As it is passed to the kernel - the padding
can have random values and hence shall be zeroed before passing to the
kernel.

The rationale for 32 bit tv_nsec is to be as close as possible to what
is exported by glibc (64 bit tv_sec and 32 bit tv_nsec) for Y2038.

I'm now wondering if it would be better to have glibc internal struct
__timespec64 having both fields 64 bit (as it would be easier to pass
it to Linux).


>=20
> The intention is that the kernel ignores the padding. If you find
> another place in the kernel that forget that, we should fix it.
>=20

Thanks Arnd for clarification.

> > > > And, hmm, is CONFIG_64BIT_TIME enabled anywhere? =20
> >
> > I guess that the remaining CONFIG_64BIT_TIME in kernel should be
> > replaced with CONFIG_COMPAT_32BIT_TIME or removed. =20
>=20
> We should remove CONFIG_64BIT_TIME. CONFIG_COMPAT_32BIT_TIME
> is still needed to identify architectures that don't have it, in
> particular riscv32.
>=20
>        Arnd




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/qTpx=9eA/uQSaz4olOo3n50
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAly/MxUACgkQAR8vZIA0
zr1XyQgAqg69TF4+MYb9Yj3B7URssWkktI1+/1W5RjAd7AFp4iRVLZ0IssHVOe65
PkZt141IibAatOfPil/Uo45udW0BG3NUdouGGBFBrd7PdyfraedcGJS3e0ecIMd4
eKEvlHdjSnkzE8E/AN5Kbf2GkGt+KDNVxFaWOol/1KMxlSzicaS6Gg5v+T1d0Yzx
4LLrRHXf/IeY/toCIMKVE2HIMBKuQ8h6+ZBJ1rDK4ktfMSjdeHNtvoShmCYbX1Nf
7tgmMKiwP3rOI6zqnXGc2IuL3vQLmo78FXMWO0BAMSEYaSLnljVifqxEcCULqdru
zuSJ7v4WS1c3iByTKzpCylCx4DDQVQ==
=pMfZ
-----END PGP SIGNATURE-----

--Sig_/qTpx=9eA/uQSaz4olOo3n50--
