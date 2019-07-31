Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F66C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FC9206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xf8gQRDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfGaFeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 01:34:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45579 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfGaFeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 01:34:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45z2DF2D9Xz9s00;
        Wed, 31 Jul 2019 15:34:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564551261;
        bh=RjcSgGU0j8Vi7wKToYS3TQABMsDm1KKdRwr2clomXRs=;
        h=Date:From:To:Cc:Subject:From;
        b=Xf8gQRDkGm3N09STO/4l0duRm74c1/o9SqTlRxpVK24hPQeImUx6MxYYkFHumAhbE
         I/CDY0+1GxiailJlpQ9FwHP8MuoFfXYBuZHy7vBveE8M3RXKTiz/eIsC+HfjNFTNrs
         PTxGClnWKfDF2A1XXhgqodvFKYlOT/ZuDiqOd3VrPIIGlTr9961LLepjDLyC0NEZsH
         uXmlYKEGaClYwTJgD2q1EV7q00VHgt+sKM+KRuYZxeDZrY+fWM7+oq1DJo6zCWgB1/
         vQkHRjRm7j/y+fsV2c0tnUoh6c2e+Jp5DxcxdN9tp526WtFSoq9RSWOgEefA79zT/J
         9mZtB/bpMFcUA==
Date:   Wed, 31 Jul 2019 15:34:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20190731153419.7b728744@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RVaztRR.13XAL2aXFk8lo/g";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RVaztRR.13XAL2aXFk8lo/g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allnoconfig)
failed like this:

x86_64-linux-gnu-ld: kernel/sched/core.o: in function `cpuidle_poll_time':
core.c:(.text+0x230): multiple definition of `cpuidle_poll_time'; arch/x86/=
kernel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/loadavg.o: in function `cpuidle_poll_time=
':
loadavg.c:(.text+0x0): multiple definition of `cpuidle_poll_time'; arch/x86=
/kernel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/clock.o: in function `cpuidle_poll_time':
clock.c:(.text+0x0): multiple definition of `cpuidle_poll_time'; arch/x86/k=
ernel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/cputime.o: in function `cpuidle_poll_time=
':
cputime.c:(.text+0x0): multiple definition of `cpuidle_poll_time'; arch/x86=
/kernel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/idle.o: in function `cpuidle_poll_time':
idle.c:(.text+0xd0): multiple definition of `cpuidle_poll_time'; arch/x86/k=
ernel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/fair.o: in function `cpuidle_poll_time':
fair.c:(.text+0xb20): multiple definition of `cpuidle_poll_time'; arch/x86/=
kernel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/rt.o: in function `cpuidle_poll_time':
rt.c:(.text+0x790): multiple definition of `cpuidle_poll_time'; arch/x86/ke=
rnel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/deadline.o: in function `cpuidle_poll_tim=
e':
deadline.c:(.text+0xce0): multiple definition of `cpuidle_poll_time'; arch/=
x86/kernel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/wait.o: in function `cpuidle_poll_time':
wait.c:(.text+0x1d0): multiple definition of `cpuidle_poll_time'; arch/x86/=
kernel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/wait_bit.o: in function `cpuidle_poll_tim=
e':
wait_bit.c:(.text+0x50): multiple definition of `cpuidle_poll_time'; arch/x=
86/kernel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/swait.o: in function `cpuidle_poll_time':
swait.c:(.text+0x30): multiple definition of `cpuidle_poll_time'; arch/x86/=
kernel/process.o:process.c:(.text+0xc0): first defined here
x86_64-linux-gnu-ld: kernel/sched/completion.o: in function `cpuidle_poll_t=
ime':
completion.c:(.text+0x0): multiple definition of `cpuidle_poll_time'; arch/=
x86/kernel/process.o:process.c:(.text+0xc0): first defined here

Caused by commit

  259231a04561 ("cpuidle: add poll_limit_ns to cpuidle_device structure")

I have added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 31 Jul 2019 15:29:52 +1000
Subject: [PATCH] cpuidle: header file stubs must be "static inline"

An x86_64 allmodconfig build produces these errors:

x86_64-linux-gnu-ld: kernel/sched/core.o: in function `cpuidle_poll_time':
core.c:(.text+0x230): multiple definition of `cpuidle_poll_time'; arch/x86/=
kernel/process.o:process.c:(.text+0xc0): first defined here

(and more)

Fixes: 259231a04561 ("cpuidle: add poll_limit_ns to cpuidle_device structur=
e")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/cpuidle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index ba535a1a47d5..1a9f54eb3aa1 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -170,7 +170,7 @@ static inline int cpuidle_enter(struct cpuidle_driver *=
drv,
 				struct cpuidle_device *dev, int index)
 {return -ENODEV; }
 static inline void cpuidle_reflect(struct cpuidle_device *dev, int index) =
{ }
-extern u64 cpuidle_poll_time(struct cpuidle_driver *drv,
+static inline u64 cpuidle_poll_time(struct cpuidle_driver *drv,
 			     struct cpuidle_device *dev)
 {return 0; }
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/RVaztRR.13XAL2aXFk8lo/g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1BKFsACgkQAVBC80lX
0Gz76wgAotDqYciT0eu0wsizxIBOntIf2FJTNGrTm+FUBP7ly6oqpaZNqFe6B7qx
mUmqxjKt3+HZLxZ6sMlSkLqzpfcJttxUk2qbs7azf3EqGJmbeyHNhNi3CHuovFVH
IDXWj11V5Vs1VbNRbBH09rpBUjZg0dBIao5h4ITkJTTKKFGkce29W2syfNh92p7N
rULuyGZt+V0o7JNIjBsopGiqGMyD4tGzWUfs3Dnqjm+TpFZI3xQnmG/a/ffSX3n0
AhZad6SL/q5PC4ibWz+7OvfDF1nIDQMdfwsgvrAcIKVnVD9a4JQC0lU4bth4be/3
LPTW01rIomEG7BrtSwYE5e5ikea+iQ==
=++q7
-----END PGP SIGNATURE-----

--Sig_/RVaztRR.13XAL2aXFk8lo/g--
