Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B63C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7144F2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCGOnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:43:23 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:44003 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:43:23 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44FYK31cKyz1rQF9;
        Thu,  7 Mar 2019 15:43:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44FYK310Ygz1qvWk;
        Thu,  7 Mar 2019 15:43:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id hCbpygteNcTb; Thu,  7 Mar 2019 15:43:17 +0100 (CET)
X-Auth-Info: Kqb0OniKf1BLGcV4iBX5iWTIgKkr8M+f2vNucr4kSXA=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  7 Mar 2019 15:43:17 +0100 (CET)
Date:   Thu, 7 Mar 2019 15:43:10 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zack Weinberg <zackw@panix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: [Y2038] Question regarding support of old time interfaces
 beyond y2038
Message-ID: <20190307154310.677b59dd@jawa>
In-Reply-To: <CAK8P3a3GotM4WY9dJK8yPujxLgHXtnes=nMUKq5fJ4hTkZWqzg@mail.gmail.com>
References: <20190305162351.5aadde66@jawa>
        <CAKCAbMjiW8=X1u8nm6nEkAz+MyF=msN97Fr59=v01HbHb=U6UA@mail.gmail.com>
        <20190307085329.2b6cbeb7@jawa>
        <CAK8P3a3GotM4WY9dJK8yPujxLgHXtnes=nMUKq5fJ4hTkZWqzg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Q98z70ZktCWVDQFA=CGt6MF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q98z70ZktCWVDQFA=CGt6MF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

> On Thu, Mar 7, 2019 at 8:53 AM Lukasz Majewski <lukma@denx.de> wrote:
> >
> > Hi Zack,
> > =20
> > > On Tue, Mar 5, 2019 at 10:24 AM Lukasz Majewski <lukma@denx.de>
> > > wrote: =20
> > > > From other discussion [4] - regarding the following system
> > > > calls: time, stime, gettimeofday, settimeofday, adjtimex,
> > > > nanosleep, alarm, getitimer, setitimer, select, utime, utimes,
> > > > futimesat, and {old,new}{l,f,}stat{,64}.
> > > >
> > > > "These all pass 32-bit time_t arguments on 32-bit
> > > >  architectures and are replaced by other interfaces (e.g. posix
> > > >  timers and clocks, statx). C libraries implementing 64-bit
> > > > time_t in 32-bit architectures have to implement the handles by
> > > > wrapping around the newer interfaces." =20
> > >
> > > 1) We should be clear that most of these will continue to be
> > > supported as C library interfaces even if they are not system
> > > calls.  Some of them are obsolete enough and/or rarely used
> > > enough that we might not bother (the older ways to set the system
> > > clock, for instance). =20
> >
> > The question here is about the decision if even the old time APIs
> > shall be supported on 32 bit systems which are going to be Y2038
> > proof (like the 'stime'). =20
>=20
> See my other reply. In the kernel, it won't be supported (the old
> syscall is of course still there, but we may have an option to remove
> all time32 interfaces).=20

To be more specific:

I'm thinking of settimeofday/gettimeofday syscalls.

In the kernel we use internally do_sys_settimeofday64() to support
clock_settime() and settimeofday()

The internal (in-kernel) representation for those two is struct
timespec64.

If I may ask - why settimeofday64() and gettimeofday64() are not
implemented?

Is it because the same result can be achieved with clock_settime64(tv64)
+ settimeofday(NULL, tz) ?
(The drawback is two syscalls instead of one).




I've also stumbled upon the __kernel_timex introduction on the
playground branch:

"time: Add struct __kernel_timex"
2c620ff93d9fbd5d644760d4c21d389078ec1080

This one introduces the:
struct __kernel_timex_timeval {
	__kernel_time64_t tv_sec;
	long long tv_usec;
};

This code is "protected" by CONFIG_64BIT_TIME.=20

Is there any plan to explicitly introduce:

struct __kernel_timeval {
       __kernel_time64_t tv_sec;
       long ong tv_usec;
}

and convert settimeofday()/gettimeofday() ?


Thanks in advance for your help.

> In glibc, it's probably there in a y2038-safe
> way since it is there now, other C libraries may take other decisions
> that are independent of y2038.
>=20
>       Arnd




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Q98z70ZktCWVDQFA=CGt6MF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlyBLf4ACgkQAR8vZIA0
zr2a6Qf/TXYk5PbhiSqbg/wp6rw9fE+4/hbv2Vz2bbdfQhVAU8MTVFYc6og0i7+o
sPzB1VfaB+9GgINMhL/Ltn5C03zp1+RkUsh6xaoClBzG9OQV9azts9Ez9OIyr6Bi
GHlngWKO87OfMeW+OPA5NIDzBUTeLDqiv4vGKfmqnf0RjtH9DjAYk1oMXPuiU2Dc
m3y4TQYwse7zBhMHCBHkotpA/G2Uu7UJuQa+9JHsRNzERMwo7X75630kDTG0YJWo
1f/gDr5nOEeSofV0NrTXhcQDJ08mEYdr3AlKmxu5F+8vSgSR2cLJLS8hQY9RUQkw
sbr3yLduVItATbP1mfu2lsRnJvn8qg==
=FLrJ
-----END PGP SIGNATURE-----

--Sig_/Q98z70ZktCWVDQFA=CGt6MF--
