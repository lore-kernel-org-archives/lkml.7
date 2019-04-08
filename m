Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C392C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392F820880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oJH54g7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDHBbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 21:31:38 -0400
Received: from ozlabs.org ([203.11.71.1]:34341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfDHBbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 21:31:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44ctDh26v9z9sQy;
        Mon,  8 Apr 2019 11:31:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554687093;
        bh=kDemFqGAM78mj83b/vdhlp3WyRmlQcXYrytykVZiYYI=;
        h=Date:From:To:Cc:Subject:From;
        b=oJH54g7f4FEIahH8au+8LBWWvDrrFlyLfjn7SFM/s6X5RiGCVxihOKhFEuhztHBJC
         /wy/2ZRYkhra+aGiflSDgiGN12s0zRyJKiYjOW1cjiFBU/PWwXVAQr5Zh34Sa4eQHh
         iJC6drqnauVYRhqXPah0QqWYGvVC6lCpv+ma+U/3UiDQUIHXhlWr0QTUqOmH8cZcwt
         DuMdoiSTrY/3NM/XRcTE6TasO8Zrxcn3xnhusL9l3jpJv9qG7MegrRAkbXq/KuNwMs
         MiaTGGnXqaBKg18WjvWHmorhORlg7c6aBZ/gUahdsSeNuZFUiynONJnNBzo4y1Wu1z
         YJRgUQqh6fVew==
Date:   Mon, 8 Apr 2019 11:31:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: linux-next: manual merge of the audit tree with Linus' tree
Message-ID: <20190408113131.222f480a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YA13TXinWxi=57RCNhi.iwP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YA13TXinWxi=57RCNhi.iwP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the audit tree got conflicts in:

  arch/mips/kernel/ptrace.c
  kernel/seccomp.c

between commit:

  b35f549df1d7 ("syscalls: Remove start and number from syscall_get_argumen=
ts() args")

from Linus' tree and commit:

  16add411645c ("syscall_get_arch: add "struct task_struct *" argument")

from the audit tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/mips/kernel/ptrace.c
index 3a62f80958e1,2ead6ff919b7..000000000000
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@@ -1418,8 -1418,8 +1418,8 @@@ asmlinkage long syscall_trace_enter(str
  		unsigned long args[6];
 =20
  		sd.nr =3D syscall;
- 		sd.arch =3D syscall_get_arch();
+ 		sd.arch =3D syscall_get_arch(current);
 -		syscall_get_arguments(current, regs, 0, 6, args);
 +		syscall_get_arguments(current, regs, args);
  		for (i =3D 0; i < 6; i++)
  			sd.args[i] =3D args[i];
  		sd.instruction_pointer =3D KSTK_EIP(current);
diff --cc kernel/seccomp.c
index df27e499956a,36f36ab00f48..000000000000
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@@ -148,8 -148,8 +148,8 @@@ static void populate_seccomp_data(struc
  	unsigned long args[6];
 =20
  	sd->nr =3D syscall_get_nr(task, regs);
- 	sd->arch =3D syscall_get_arch();
+ 	sd->arch =3D syscall_get_arch(task);
 -	syscall_get_arguments(task, regs, 0, 6, args);
 +	syscall_get_arguments(task, regs, args);
  	sd->args[0] =3D args[0];
  	sd->args[1] =3D args[1];
  	sd->args[2] =3D args[2];

--Sig_/YA13TXinWxi=57RCNhi.iwP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyqpHMACgkQAVBC80lX
0Gy01Af/XeCzjLJfHa4aJdS9laNaWzt/uoB0ern40eoTLG/FY61TbgI/Vw2hDAzG
rvz2fo/Mt373SQf/LTHLzktDAgrGZaketo1KMPJvQQ6fR2A0UyfNQU/aNl9Q+L+O
QNP0YVraJj7mm7gJ8juTtOEWKkCCrMPuhMr8wojhCW661Q3xCSAm2I5aL/dAZJFv
OhEuLvLNRJh3U1SlX9W/6cmJCm0S/6eMvk2SBshm6EwuZN5eDeTv8bPiDfUpp8Sp
TSlx9ymcC6G2uS06VbRujHia5Xjh8u+loIg0nkCi5de94Fx/EecZusp0s2Bv8r3n
9C42uc5fp8gBRRH8oA6tvi+1cAOoWg==
=GhgX
-----END PGP SIGNATURE-----

--Sig_/YA13TXinWxi=57RCNhi.iwP--
