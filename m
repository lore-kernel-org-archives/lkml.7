Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F679C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3B120850
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDTLVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:21:39 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56851 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfDTLVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:21:38 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44mVlx5kslz1rXtq;
        Sat, 20 Apr 2019 13:21:33 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44mVlx4f2Hz1qxGG;
        Sat, 20 Apr 2019 13:21:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 0zXgdUdpc1ui; Sat, 20 Apr 2019 13:21:31 +0200 (CEST)
X-Auth-Info: 0lcDhO+OqyKF/kbbv7hPg32S9blV6NnktvXtWjc/iDs=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 20 Apr 2019 13:21:31 +0200 (CEST)
Date:   Sat, 20 Apr 2019 13:21:12 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Stepan Golosunov <stepan@golosunov.pp.ru>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        libc-alpha@sourceware.org, Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] y2038: linux: Provide __clock_settime64
 implementation
Message-ID: <20190420132112.131f449b@jawa>
In-Reply-To: <20190420002009.l65upn2t3qqoj5uy@sghpc.golosunov.pp.ru>
References: <20190414220841.20243-1-lukma@denx.de>
        <20190414220841.20243-4-lukma@denx.de>
        <20190420002009.l65upn2t3qqoj5uy@sghpc.golosunov.pp.ru>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gHFwm=nXHDn7y45V02exrgO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gHFwm=nXHDn7y45V02exrgO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stepan,

> 15.04.2019 =D0=B2 00:08:38 +0200 Lukasz Majewski =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB:
> > +# if defined __NR_clock_settime64
> > +  /* Make sure that passed __timespec64 struct pad is 0.  */
> > +  struct __timespec64 ts =3D *tp;
> > +  ts.tv_pad =3D 0;
> > +  return INLINE_SYSCALL_CALL (clock_settime64, clock_id, &ts); =20
>=20
> Isn't kernel supposed to zero out padding on its own?
> At least comment in kernel's get_timespec64 says so:
>=20
> 	/* Zero out the padding for 32 bit systems or in compat mode
> */ if (IS_ENABLED(CONFIG_64BIT_TIME) && in_compat_syscall())
> 		kts.tv_nsec &=3D 0xFFFFFFFFUL;
>=20

For ARM (and x86) 32 bit machines I do use following syscalls (like
clock_settime64):
https://elixir.bootlin.com/linux/v5.1-rc4/source/arch/arm/tools/syscall.tbl=
#L420

which are providing 64 bit time support on 32 bit systems.

Yes. In those systems the upper part (32 bits) of tv_nsec is cleared up
with mask in the kernel. However, I would prefer not to pass random data
to the kernel, and hence I do clear it up explicitly in glibc.

> The code looks buggy though. It fails to zero out the padding in
> 32-bit kernels.

For the 32 bit systems without Y2038 support enabled in glibc - the
clock_settime would be used, which corresponds to sys_clock_settime32()
in the kernel.

> That part is probably broken since
> 98f76206b3350 ("compat: Cleanup in_compat_syscall() callers").
>=20
> And, hmm, is CONFIG_64BIT_TIME enabled anywhere?

When I do use clock_settime64 on the glibc side (with _TIME_BITS=3D64), I
do not need to enable such config in the kernel.=20

If the kernel supports this call (5.1+), then use it, otherwise
fallback to clock_settime().

For 64 bit systems, I do not change the execution path.

If you are interested, please look on the following repo (which has
some more commits than those posted to the mailing list):
https://github.com/lmajewski/y2038_glibc/commits/Y2038-2.29-glibc-__clock-i=
nternal-struct-timespec-v1

And meta layer for testing.

https://github.com/lmajewski/meta-y2038

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/gHFwm=nXHDn7y45V02exrgO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAly7AKkACgkQAR8vZIA0
zr20sQf/XdyoGUl95nNc+94/Jvj7G7gRr5BbAjQJrvowpdLlCeJwo3+ug6q6Gho3
4AVbj0vKxAyw+POKqgxYwf2W+T/hIvhvU68k2n6rsxSBWGEabV11hH82lHNbcXr/
V1ody8acvmDsmWV7JQ+i10qqi2rtGd0alt/use02OIEJjQ74qZJpTRu54H9iv4b9
huFOlPELBJwu+jBWE/58RYqFKGAKxQEMlnw1J6m/AkHx21fx9PIYHhp2UG3I2DNC
ld6CpcbxuZd2F+92RSqpRlLtUEm/V3a1sUlv/1UdJ/TJUCWSgYfBUTA4bwW3Pmlh
Y1YYqWEBBaG0ShyiA9P1HjDAAFTr1A==
=KsVo
-----END PGP SIGNATURE-----

--Sig_/gHFwm=nXHDn7y45V02exrgO--
