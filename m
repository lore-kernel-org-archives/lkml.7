Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30451C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DDD20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfDSTFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:05:20 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:57216 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbfDSTFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:05:18 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 6C1654D67A;
        Fri, 19 Apr 2019 15:39:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 58oG05-c-REi; Fri, 19 Apr 2019 15:39:32 +0200 (CEST)
Date:   Fri, 19 Apr 2019 23:39:18 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Oleg Nesterov <oleg@redhat.com>, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, jannh@google.com, dhowells@redhat.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH v2 2/5] clone: add CLONE_PIDFD
Message-ID: <20190419133918.7uedlqgc6cvt7fjt@yavin>
References: <20190418101841.4476-1-christian@brauner.io>
 <20190418101841.4476-3-christian@brauner.io>
 <20190418131206.GB13701@redhat.com>
 <20190418132822.untjt7erfvbbiz7a@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vpeoutzg3boqufdk"
Content-Disposition: inline
In-Reply-To: <20190418132822.untjt7erfvbbiz7a@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vpeoutzg3boqufdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-04-18, Christian Brauner <christian@brauner.io> wrote:
> > Why O_CLOEXEC? I am just curious, I do not really care.
>=20
> I think that having the file descriptor O_CLOEXEC by default is a good
> security measure in general. Most of the time you do not want to pass a
> file descriptor through exec() (apart from 0,1,2) and it is usually more
> of an issue when you accidently do it then when you accidently don't. So
> if users really care about passing a pidfd they should do so by removing
> the O_CLOEXEC flag explicitly.
> (New file descriptors should probably all default to that but that's just
> my opinion.)
> Another thing is that for a pidfds it makes even more sense to have them
> cloexec by default. You don't want to *unintentionally* leak an fd that
> can be used to operate on a process.

There is another factor as well -- if you want to set O_CLOEXEC in a
multi-threaded process you can't be sure that another thread didn't fork
in between you getting the fd_install'd and the userspace process
setting O_CLOEXEC (leading to the fd leaking outside the current
process). This is why a lot of syscalls have a way to get an O_CLOEXEC
fd from the outset.

So I'm +1 on doing O_CLOEXEC by default -- you can always disable it
safely but enabling it safely isn't so simple (and I don't think it
makes much sense to add the mechanism to pass PIDFD_CLOEXEC as well,
given how tight the flags are getting).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--vpeoutzg3boqufdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAly5z4YACgkQSnvnv3De
m58UxRAAgcnnb4NwtWMB9j9vrcjC5M89nkbun9n1RzZA2iKOiguktbzuFqgI3A7F
+M1vvVsOGP5oNDGDXiSX9klXhY+nMQazNBJx0vB0CEQAVY2nL3l+qy0XEEjlgyZ4
/VbXsEI6/SaYKUmDIHmQPKq0QCjC69s5L0O7R1bsnoH5YUVk6m7RNBAMxQ+EZ/Fn
BhV0WAiBsjOk6fM12RpbWFeEV5cg9UB4OI+75S1zpirhVsMo1d0xtDwD/2dEfrAl
undKn+rDuhh5/ULP76drQ9XWnB24F9qiqvx2/H8vrCLYY8vOmhanC1Xii2HaXKPQ
8ggaFeDY3/rO6h2TIXNzW6d5bj8ezveiOtMngVaIeAXCi0se13iCYcRzVjPHGwBw
/V+NaHktML75wazFadXkMp0rlyWr6ua6lClnCz8TN2cEonHHRJQKIz4rr+JedqQh
rl9svBSn7kP+6A0H6ch1s2Lx+dcSMIBA05HFM9S8RoKUn3i0OM8DZzkikcctGwid
Dc2HASNmm3lCWg030Fdym+p4Ndzl1Dr9IFCLV/Zwso8rsbaFGoY4nMa1TLUmbS+w
7cmgFd+imZrlcbrTTUvVsYBGPZ5G9EYbIefO/PqVlARxK7aa3urQFj4pjyKTodUI
1Ou6fi1anhOAp1JOkxlXIdrLfB5RvoxcH3sUKizN33QjBT/zIzU=
=enJD
-----END PGP SIGNATURE-----

--vpeoutzg3boqufdk--
