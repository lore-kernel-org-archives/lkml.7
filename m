Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6273F2063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfCGHr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:47:57 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:37138 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:47:57 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44FN5j4H3sz1r2tT;
        Thu,  7 Mar 2019 08:47:53 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44FN5j3mQ0z1qrht;
        Thu,  7 Mar 2019 08:47:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id I8xNU0h7eey9; Thu,  7 Mar 2019 08:47:52 +0100 (CET)
X-Auth-Info: R11V2e9QPk0WWIrDs49LgWO/hYCeYbOH2yqfbIUa4XQ=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  7 Mar 2019 08:47:52 +0100 (CET)
Date:   Thu, 7 Mar 2019 08:47:44 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: [Y2038] Question regarding support of old time interfaces
 beyond y2038
Message-ID: <20190307084619.299d8692@jawa>
In-Reply-To: <CAK8P3a2J-NHyYASqUB=oNP++EgEV075fj=HapGU6-Gx_MXBGAQ@mail.gmail.com>
References: <20190305162351.5aadde66@jawa>
        <CAK8P3a2J-NHyYASqUB=oNP++EgEV075fj=HapGU6-Gx_MXBGAQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aGcDOv8bf_ZCsww=8nd30jT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aGcDOv8bf_ZCsww=8nd30jT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

> On Tue, Mar 5, 2019 at 4:24 PM Lukasz Majewski <lukma@denx.de> wrote:
> >
> > Dear Arnd,
> >
> > In your "playground" repository [1] (branch: y2038), the time
> > functions (stime, settimeofday, etc) are not converted in Linux to
> > be Y2038 aware (as for example clock_settime{64}() is). =20
>=20
> Correct. FWIW, this is now merged into the mainline kernel.
>=20

The arch/arm/tools/syscall.tbl
linux-next 20190306
SHA1: cf08baa29613dd899954089e7cc7dba1d478b365

Has now:

403	common	clock_gettime64			sys_clock_gettime
404	common	clock_settime64			sys_clock_settime
405	common	clock_adjtime64			sys_clock_adjtime
406	common	clock_getres_time64		sys_clock_getres
407	common	clock_nanosleep_time64		sys_clock_nanosleep
408	common	timer_gettime64			sys_timer_gettime
409	common	timer_settime64			sys_timer_settime
410	common	timerfd_gettime64		sys_timerfd_gettime
411	common	timerfd_settime64		sys_timerfd_settime
412	common	utimensat_time64		sys_utimensat
413	common	pselect6_time64			sys_pselect6
414	common	ppoll_time64			sys_ppoll
416	common	io_pgetevents_time64		sys_io_pgetevents
417	common	recvmmsg_time64			sys_recvmmsg
418	common	mq_timedsend_time64		sys_mq_timedsend
419	common	mq_timedreceive_time64		sys_mq_timedreceive
420	common	semtimedop_time64		sys_semtimedop
421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
422	common	futex_time64			sys_futex
423	common	sched_rr_get_interval_time64
sys_sched_rr_get_interval

> > I've also searched on the Internet and I've found some old
> > discussions regarding them:
> >
> > SHA1:  d33c577cccd0b3e5bb2425f85037f26714a59363 [2]
> > From commit message:
> >
> > "The time, stime, utime, utimes, and futimesat system calls are only
> > used on older architectures, and we do not provide y2038 safe
> > variants of them, as they are replaced by clock_gettime64,
> > clock_settime64, and utimensat_time64."
> >
> > Moreover, the stime has been even explicitly marked as obsolete [3].
> >
> >
> > From other discussion [4] - regarding the following system calls:
> >  time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
> > alarm, getitimer, setitimer, select, utime, utimes, futimesat, and
> >  {old,new}{l,f,}stat{,64}.
> >
> > "These all pass 32-bit time_t arguments on 32-bit
> >  architectures and are replaced by other interfaces (e.g. posix
> >  timers and clocks, statx). C libraries implementing 64-bit time_t
> > in 32-bit architectures have to implement the handles by wrapping
> >  around the newer interfaces."
> >
> >
> >
> >
> > Has something changed since then? Has any new idea for conversion
> > emerged? =20
>=20
> No, this has been the plan for many years now.

Ok.

>=20
> > After observing the development of y2038 on playground [1], I can
> > deduce that new interfaces are only going to be supported and
> > converted (clock_settime64/clock_gettime64, etc.)
> >
> > Considering the above - would it be best to drop Y2038 support on 32
> > bit machines for old syscalls (stime and friends) and for some
> > others (settimeofday/gettimeofday) write Y2038 wrappers based on
> > new time kernel API (clock_gettime/settime) in the C library (i.e.
> > glibc)? =20
>=20
> There are multiple dimensions to what you are asking here:
>=20
> - On the user space interface, the C library (glibc, musl,
> uclibc, ...) implements a set of interfaces for time management. The
>   set that is implemented here is defined by POSIX and other
>   standards and decided by the respective C library implementation.
>   All functions that get implemented here have to use the same
>   definition of time_t however, so if there is both a clock_gettime()
>   function and a time() function, they must either both use 32-bit
>   time_t or both must use 64-bit time_t. Both can be implemented
>   on top of any kernel interface for getting the time (time,
> gettimeofday, clock_gettime, clock_gettime64), but the only sensible
> implementation is to use clock_gettime64() in order to have the full
> range and resolution.

I see. I just would like to be sure that the "old" API calls (for
example the settimeofday, gettimeofday, stime, etc) are not recommended
(planned?) for conversion to have 64 bit interfaces (like
clock_{get|set}time).

>=20
> - The kernel has a growing set of system calls, i.e. we tend to
>   only add new ones but not take old ones away. In many cases,
>   a new syscall is a superset of the old one (e.g. oldstat, newstat
>   stat64, xstat), any architecture that had an old version has
>   to keep it around, but new architectures only ever provide the
>   most recent variant.
>=20
>      Arnd




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/aGcDOv8bf_ZCsww=8nd30jT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlyAzKAACgkQAR8vZIA0
zr1QVQf+Mau3HTmwZFMYblgOKZ7QqTrgsRuAy9/tpwJZYNlXFfKjs2Nj2d+lLyZ0
7BYetfZf7Vkl3V7IMHYWHZR43sX7iqF1Rym6byBCwaUvGVKKraSmjUcMr3uSpIdq
GL2OqDcCNdBYMkaXMcE+NJR6ti5qFNWqaWSZZfL6TtelDSPamCto8n8I2R2rFW/f
qvka2DFVA+2j/bbgfMlAX8fLGTn33i7dbfNvjPOzdQSPCt3bKnIqaSaq9mVVispU
OAy2aC+tYYjk5AeV/BjeDUJrPazbaq32EzBDbkrUBYxAu4GpQs3Pyl9WGKGRd4mp
otcxGiveaLsPSOvUnohcm6sho2RGAg==
=+1Io
-----END PGP SIGNATURE-----

--Sig_/aGcDOv8bf_ZCsww=8nd30jT--
