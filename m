Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C83C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971122087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfCEPYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:24:09 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:47708 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfCEPYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:24:09 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44DLK02DXYz1rfMk;
        Tue,  5 Mar 2019 16:24:04 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44DLK01jw8z1qvXV;
        Tue,  5 Mar 2019 16:24:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 5wMNqAfVZar3; Tue,  5 Mar 2019 16:24:02 +0100 (CET)
X-Auth-Info: BvxictbL9H7KgMLVAgjhtzmAJqwFYBst81mD9Fwq7KU=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  5 Mar 2019 16:24:02 +0100 (CET)
Date:   Tue, 5 Mar 2019 16:23:51 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Joseph Myers <joseph@codesourcery.com>,
        libc-alpha@sourceware.org
Subject: [Y2038] Question regarding support of old time interfaces beyond
 y2038
Message-ID: <20190305162351.5aadde66@jawa>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U6Mt1c/ACWt.uM4j5lcQ_X_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U6Mt1c/ACWt.uM4j5lcQ_X_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Arnd,

In your "playground" repository [1] (branch: y2038), the time functions
(stime, settimeofday, etc) are not converted in Linux to be Y2038 aware
(as for example clock_settime{64}() is).

I've also searched on the Internet and I've found some old discussions
regarding them:

SHA1:  d33c577cccd0b3e5bb2425f85037f26714a59363 [2]
=46rom commit message:

"The time, stime, utime, utimes, and futimesat system calls are only
used on older architectures, and we do not provide y2038 safe variants
of them, as they are replaced by clock_gettime64, clock_settime64,
and utimensat_time64."

Moreover, the stime has been even explicitly marked as obsolete [3].


=46rom other discussion [4] - regarding the following system calls:
 time, stime, gettimeofday, settimeofday, adjtimex, nanosleep, alarm,
 getitimer, setitimer, select, utime, utimes, futimesat, and
 {old,new}{l,f,}stat{,64}.

"These all pass 32-bit time_t arguments on 32-bit
 architectures and are replaced by other interfaces (e.g. posix
 timers and clocks, statx). C libraries implementing 64-bit time_t in
 32-bit architectures have to implement the handles by wrapping
 around the newer interfaces."




Has something changed since then? Has any new idea for conversion
emerged?



After observing the development of y2038 on playground [1], I can deduce
that new interfaces are only going to be supported and converted
(clock_settime64/clock_gettime64, etc.)

Considering the above - would it be best to drop Y2038 support on 32
bit machines for old syscalls (stime and friends) and for some others
(settimeofday/gettimeofday) write Y2038 wrappers based on new time
kernel API (clock_gettime/settime) in the C library (i.e. glibc)?




Note:

[1] -
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/tree/ke=
rnel/time/time.c?h=3Dy2038
[2] - git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
[3] -=20
https://elixir.bootlin.com/linux/v2.6.32/source/arch/arm/include/asm/unistd=
.h#L419
[4] - https://lists.linaro.org/pipermail/y2038/2017-November/002387.html


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/U6Mt1c/ACWt.uM4j5lcQ_X_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlx+lIgACgkQAR8vZIA0
zr32BQgAyxT4NNpx0F9Xj1EXXunxDrKEsCni69+pBPwGifM+zkOtJShFOCLOefRR
KXFblSM21PpnoknEXmc2WO/Q13fuu2wmACwaQVNQLKOdEGKfkeRfR1lM3Hk17l6y
TIBcSLnMu7Vco4UVOQAXJ5rre85U4fJioaLg9BbcUFkFI7Y2uFXHTRJ9rA8mEsaa
YQDOyZd+B3dRe8Oeu/d7lt+/fL4SEl4CSj92OulXSZ/fD+EOuuos6bT09TUarX9w
xepmsOahJ/vT1b6RAS5RW1bsBiG0ESN/S4Pk7bEZmAP6l8ZDzsMV3tJfMSIfMs4W
XuZmbZV6fLudrFXDzuROwtqQ6DeVvg==
=PzDo
-----END PGP SIGNATURE-----

--Sig_/U6Mt1c/ACWt.uM4j5lcQ_X_--
