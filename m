Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC28C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29E2206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="So+zrwn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfC1CEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:04:53 -0400
Received: from ozlabs.org ([203.11.71.1]:44925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfC1CEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:04:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44V7VB65pJz9sPP;
        Thu, 28 Mar 2019 13:04:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553738690;
        bh=1PCXjpmLPgl+TKF83cTdCR1lVSCMYgT52sJCb1ZsutU=;
        h=Date:From:To:Cc:Subject:From;
        b=So+zrwn8BQ5tLT//Hrjaq7BwXP7NBCnrkKNstE3X+oPbR1NbaPLwmyEj5G0HxSYuz
         fp6P3UA2lFH6CpcfM3h3RIrR0vgEkO72UXNx7SV9IrxXN5ptHW0Jg4VltEIhKsr1yy
         kRrgdJJ4p7GZE7+QX8A+Y9cKJ+yV8RXL0r5nBMX5nbPQZLf2VgC5bicpczv4rAlEdb
         Ooy9tMGRffV7leHVJipmXvxxhdfqW5zLEVOlR6ZZ/0HF54BRFmmLfnlXTWpaJBiB1/
         jOoErzQgzRR7anmd2p69wyiCwOhG7Qql3zjwFMoHO8fqLcCzkE+GMBvCDixFZPpi26
         2pgwe4kGIQp2w==
Date:   Thu, 28 Mar 2019 13:04:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the pidfd tree
Message-ID: <20190328130449.1b6334b6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//=5FdznmUlmW7Bpp8qftFJQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//=5FdznmUlmW7Bpp8qftFJQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

After merging the pidfd tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

kernel/pid.c: In function '__do_sys_pidfd_open':
kernel/pid.c:652:7: error: 'fd' redeclared as different kind of symbol
  long fd =3D -EINVAL;
       ^~
In file included from kernel/pid.c:40:
kernel/pid.c:649:46: note: previous definition of 'fd' was here
 SYSCALL_DEFINE4(pidfd_open, pid_t, pid, int, fd, int, pidfd,
                                         ~~~~~^~
include/linux/syscalls.h:117:27: note: in definition of macro '__SC_DECL'
 #define __SC_DECL(t, a) t a
                           ^
include/linux/syscalls.h:112:35: note: in expansion of macro '__MAP3'
 #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
                                   ^~~~~~
include/linux/syscalls.h:115:22: note: in expansion of macro '__MAP4'
 #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                      ^~~~~
include/linux/syscalls.h:253:36: note: in expansion of macro '__MAP'
  static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
                                    ^~~~~
include/linux/syscalls.h:226:2: note: in expansion of macro '__SYSCALL_DEFI=
NEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
include/linux/syscalls.h:218:36: note: in expansion of macro 'SYSCALL_DEFIN=
Ex'
 #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
kernel/pid.c:649:1: note: in expansion of macro 'SYSCALL_DEFINE4'
 SYSCALL_DEFINE4(pidfd_open, pid_t, pid, int, fd, int, pidfd,
 ^~~~~~~~~~~~~~~
kernel/pid.c:663:7: error: 'procfd' undeclared (first use in this function)=
; did you mean 'pidfd'?
   if (procfd !=3D -1 || pidfd !=3D -1)
       ^~~~~~
       pidfd
kernel/pid.c:663:7: note: each undeclared identifier is reported only once =
for each function it appears in

Caused by commit

  9170fba40db0 ("pid: add pidfd_open()")

I have used the version of the pifd tree from next-20190327 for today.

Please do *not* use linux-next as a development tree (I have seen several
different version of this code over the past few days :-().  The rules
for linux-next included code include:
"
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch)."
--=20
Cheers,
Stephen Rothwell

--Sig_//=5FdznmUlmW7Bpp8qftFJQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlycK8EACgkQAVBC80lX
0Gz/Mwf/ft0Rk8vI7Foboq9hZ5mME9ACTbQsNk0x6104F/aQBEkPvryIsACJanv9
BZMeeoRmlFmQoVS6Oef7gidSDcvwNcm9xVygyoI0z37elPVZBN+ycvkhG32nz4I4
dt4jeWyWi73eMv0/OlqCFgHU29OW2OpcwBuTWQPjtBj/JPsGG85sYQXFIdn2HW1m
Zi8MO7PH/JMyBdgFrGTZei64ZqJkWSsNX3mAQlbwPeHsa2jiaMwqMz5fyU3k2nEl
5LnZIbV7mWPFFFYIFso87SzP9twmYIGY17IF30A1rl3EOQAlzvxjQYrLahhrL0zW
FHPm/F3MxUZQHCgl1muqNh2vlR+HTg==
=5XrG
-----END PGP SIGNATURE-----

--Sig_//=5FdznmUlmW7Bpp8qftFJQ--
