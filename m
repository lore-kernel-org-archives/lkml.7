Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3763CC28EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79482083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Hhvg9v3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfFFWi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:38:29 -0400
Received: from ozlabs.org ([203.11.71.1]:49275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfFFWi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:38:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45KgYF0S3bz9s6w;
        Fri,  7 Jun 2019 08:38:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559860705;
        bh=xDTjvbUx94UD6ExeNFSIftf2hykJx3blXdG3qdLOZhQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Hhvg9v3WPVeUy9uO/2BoUGBJLCijlQRnbM8qgySL7BI/r+tyS/GkwWHoyQ9xlmHi6
         u5T/GIZSBO2qCtTtzzgQySrCAywL0gnI68uIyGK0sxr1ZKcMdmJSwlPtafGmHcsxtz
         gkyRnWlwdzY22LjXdG4KssmXGz9IM9iMLkXK/bn1rVnyndTdMM9q42VZ2rOffJyoDU
         anIk5KRmjClvFEPCJfNIJa7Hzhl64ALIS+QE1jVtPPS0G7IN0kIQ4AHJwkHyzqqZIH
         uXnTohdq8+/RaRtEXk1eYdP1fpzar1regRuQiLFyPdvt9tka9KUnjVdV8M021xqOO1
         9JMbic5lZJ/QA==
Date:   Fri, 7 Jun 2019 08:38:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "George G. Davis" <george_davis@mentor.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: linux-next: manual merge of the arm64 tree with the arm64-fixes
 tree
Message-ID: <20190607083819.4750ad83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ctqLA1ntecM4PElDOJm=BHC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ctqLA1ntecM4PElDOJm=BHC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm64 tree got a conflict in:

  arch/arm64/include/asm/thread_info.h

between commit:

  2b55d83e9a8c ("ARM64: trivial: s/TIF_SECOMP/TIF_SECCOMP/ comment typo fix=
")

from the arm64-fixes tree and commit:

  f086f67485c5 ("arm64: ptrace: add support for syscall emulation")

from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/include/asm/thread_info.h
index f1d032be628a,c285d1ce7186..000000000000
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@@ -75,7 -75,8 +75,8 @@@ void arch_release_task_struct(struct ta
   *  TIF_SYSCALL_TRACE	- syscall trace active
   *  TIF_SYSCALL_TRACEPOINT - syscall tracepoint for ftrace
   *  TIF_SYSCALL_AUDIT	- syscall auditing
+  *  TIF_SYSCALL_EMU     - syscall emulation active
 - *  TIF_SECOMP		- syscall secure computing
 + *  TIF_SECCOMP		- syscall secure computing
   *  TIF_SIGPENDING	- signal pending
   *  TIF_NEED_RESCHED	- rescheduling necessary
   *  TIF_NOTIFY_RESUME	- callback before returning to user

--Sig_/ctqLA1ntecM4PElDOJm=BHC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz5ldsACgkQAVBC80lX
0GxHewf9Fc5/0rjSBagFCBWV+GkyQvhht39LEkl5Wy2emp0CqSpytjmBFN2DTpOI
J0u3p/RlpalqQVVDr5TLFle9JmzoTMf0/gmIgdNb/HRcoBtbLQegpk2u7WAg/TYz
Qtw2TUet4I/X1aGjnN0Sa2tMwzI4h2T3OOvqHoow/crkMgN6oT+B1M0r+SoZFfAR
0IVCzP94o4meym5WrFfzQGSuWqxQS+rdfG6/jsjs9n8ZZZ9F1nsKJgNcX6asbU0Y
+Brv8+u/Sf6w+uEmIWCKpOoJESv+C5RBtbhq2efmkRkenTljT1hntJfNMaMHzyf1
fZcThIxJwyeZtMQksFAAhDzuy9qu7Q==
=gfRB
-----END PGP SIGNATURE-----

--Sig_/ctqLA1ntecM4PElDOJm=BHC--
