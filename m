Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5878C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 04:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5A720825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 04:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LqTrC4Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfDOEVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 00:21:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56191 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfDOEVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 00:21:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jFgh5zHnz9s3q;
        Mon, 15 Apr 2019 14:21:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555302098;
        bh=yT5z1V22fHrycbsaVFf5vuhuIT2gSMgmJB+hF4p96pQ=;
        h=Date:From:To:Cc:Subject:From;
        b=LqTrC4Ac0kce2Sii/4V2okwvHn72qeDyJe17x6nsNFikQ+WuRwYYHsyS0M7h7ODG5
         Kc4ytLpBm/6FOtl9tYML3Mg28/wSbaOK+F70AuMFqfhCSro5eTeAjC5ztJVrnw3S2p
         432t42fKM3RuJWqTPIP7k+jZ0mG0j6m/cokBVdhrYtfDNOap8EC/HDUv1M8buhJEpT
         LAGLWLffR6XWWJWunV+qWmBwaS7Zk37kIZoLviysdfHvXBgYa19hiBc0xLYXMrNMZg
         YGk75QD4qUwA9AWWIwuROFOYKoCCN1sju5MTEEztcDk2f9RGI/TDs0/pDx/qVTOV+Z
         ZK4/HnjUP3s3w==
Date:   Mon, 15 Apr 2019 14:21:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: linux-next: manual merge of the tip tree with the arm64 tree
Message-ID: <20190415142134.0956422f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/t3_dEJ+Z55BQXx9L74Sbklh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t3_dEJ+Z55BQXx9L74Sbklh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/s390/include/asm/Kbuild

between commit:

  fdcd06a8ab77 ("arch: Use asm-generic header for asm/mmiowb.h")

from the arm64 tree and commit:

  46ad0840b158 ("locking/rwsem: Remove arch specific rwsem files")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/s390/include/asm/Kbuild
index bdc4f06a04c5,d5fadefea33c..000000000000
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@@ -20,8 -20,6 +20,7 @@@ generic-y +=3D local.
  generic-y +=3D local64.h
  generic-y +=3D mcs_spinlock.h
  generic-y +=3D mm-arch-hooks.h
 +generic-y +=3D mmiowb.h
- generic-y +=3D rwsem.h
  generic-y +=3D trace_clock.h
  generic-y +=3D unaligned.h
  generic-y +=3D word-at-a-time.h

--Sig_/t3_dEJ+Z55BQXx9L74Sbklh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly0Bs4ACgkQAVBC80lX
0Gw59gf/WtQapbHy3Zt/wrdgGGvPCPzxL6Vu2IqOx/8odyaKoS/iJg9UV5cx5/TV
cTEj+Voy2QoV4VH7GUMwNLuMf6sEPT5e1M9GChRa7+c6XpbMzGIwxbdg17/Gdwxo
okC4m0Vy0ik44xSCQQoyDbyj4+o6uNEPbDb03wXs3nkOJ/T2iq3iSBVAr/LYVNp9
/t/Za6n6nC9l/oO9U6zOSraTUYxTckpCadog8iU39LfH98K1hs6s7VYiNisaXsAb
H1dxpqNeQooh4eND1smLQ+nWWsAg/ffWuXN84kyJY1lIbFia6W/JdXp1OycftZyJ
RUagmd/6gJUNc4I4pXe6eupbIAgcig==
=70Xt
-----END PGP SIGNATURE-----

--Sig_/t3_dEJ+Z55BQXx9L74Sbklh--
