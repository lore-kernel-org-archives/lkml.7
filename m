Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B3FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BC92063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfCGHxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:53:35 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:44950 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:53:35 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44FNDC3z2vz1rRDW;
        Thu,  7 Mar 2019 08:53:31 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44FNDC3KWvz1qrhv;
        Thu,  7 Mar 2019 08:53:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id DCKlt9HRrjf4; Thu,  7 Mar 2019 08:53:30 +0100 (CET)
X-Auth-Info: mOvLEDqH9Eq7Dzz3v788MwLnQ9BaZLX6aAmrJWtMnUk=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  7 Mar 2019 08:53:30 +0100 (CET)
Date:   Thu, 7 Mar 2019 08:53:29 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Zack Weinberg <zackw@panix.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: [Y2038] Question regarding support of old time interfaces
 beyond y2038
Message-ID: <20190307085329.2b6cbeb7@jawa>
In-Reply-To: <CAKCAbMjiW8=X1u8nm6nEkAz+MyF=msN97Fr59=v01HbHb=U6UA@mail.gmail.com>
References: <20190305162351.5aadde66@jawa>
        <CAKCAbMjiW8=X1u8nm6nEkAz+MyF=msN97Fr59=v01HbHb=U6UA@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_O84/=n1/JGR/xZjBb97pa1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_O84/=n1/JGR/xZjBb97pa1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Zack,

> On Tue, Mar 5, 2019 at 10:24 AM Lukasz Majewski <lukma@denx.de> wrote:
> > From other discussion [4] - regarding the following system calls:
> >  time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
> > alarm, getitimer, setitimer, select, utime, utimes, futimesat, and
> >  {old,new}{l,f,}stat{,64}.
> >
> > "These all pass 32-bit time_t arguments on 32-bit
> >  architectures and are replaced by other interfaces (e.g. posix
> >  timers and clocks, statx). C libraries implementing 64-bit time_t
> > in 32-bit architectures have to implement the handles by wrapping
> >  around the newer interfaces." =20
>=20
> 1) We should be clear that most of these will continue to be supported
> as C library interfaces even if they are not system calls.  Some of
> them are obsolete enough and/or rarely used enough that we might not
> bother (the older ways to set the system clock, for instance).

The question here is about the decision if even the old time APIs shall
be supported on 32 bit systems which are going to be Y2038 proof (like
the 'stime').

>=20
> 2) I know of one case where the new interfaces don't cover all of the
> functionality of the old ones: timers started by setitimer continue to
> run after an execve, timers started by timer_create don't.  This means
> setitimer(ITIMER_VIRTUAL) can be used to impose a CPU time limit on a
> program you didn't write, and timer_create can't.  If new kernels are
> not going to have setitimer as a primitive, we need some other way of
> getting the same effect.
>=20
> zw




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/_O84/=n1/JGR/xZjBb97pa1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlyAzfkACgkQAR8vZIA0
zr2nggf7BGowmvktUvdEQr5elh3XlSHx1uP8Q0WooEI8BU3DJR6t9sn7Bl7dq/kV
PuxcQjxFSoxeosDZo7GHJ3olbf/yEP4jgsVOrsrUl4poB7yX2bj5kydh2FW1e7AC
xXGfzfgzcIOOh3cL5tkOvMSzvsJDuPtOXKw/N6zyLXJ610mwWMnrDFBWXNBqknNB
Tfu4lkc7KNufhxPhPqKSes8BhPNyRvXAaY3uihkSoHrubM1W27qaxq0UnFBio8Pj
MhE02W4jLBUX38F03G2GT4y1ZoRqHkIAkmlGd86z/7jU+UcPezdG/MJ/xkfjiQfF
hx4NMsyb2cPwkOBXHQDtNxauKgMt7g==
=8Pen
-----END PGP SIGNATURE-----

--Sig_/_O84/=n1/JGR/xZjBb97pa1--
