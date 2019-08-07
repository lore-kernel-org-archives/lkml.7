Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0397AC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02D420880
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="md5e9IaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfHGGjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:39:46 -0400
Received: from ozlabs.org ([203.11.71.1]:43863 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfHGGjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:39:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463MLR0dTsz9sBF;
        Wed,  7 Aug 2019 16:39:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565159984;
        bh=0GEKGTSUc4dvmLeq8qcdD6/gYU+tU39PQ3kY6AgRwEw=;
        h=Date:From:To:Cc:Subject:From;
        b=md5e9IaRhJGIQcn2l3vd6z1USqstbJG50opH5RiSYiljfSVZ1oOmWW1yAZOVA917x
         MzZFdkDL3dJAlrCnpF4BNwgSHO+9SLmFryTf/Iy4OGsub1TNaqw25DMhjp1uCZOICz
         JIRFHpbyxzv0hP4W/7pJ7bLaLBovGjFWig+vVuiXkYtUqO2mNznnC5wnWZEfwAVEET
         GxDUwM4beSHJ2uHu/lc7rw7dwintA6EDtfMMRaqsO5fRWWIFx02X3KQg5bDXNX4MT8
         TECrONQcuw62RGaWlvphJHkC198vtYyddXvRF0tyxmKCvBh3H12r1X9aq39zKtkEmo
         sykYLKpqG9uYg==
Date:   Wed, 7 Aug 2019 16:39:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: linux-next: manual merge of the akpm-current tree with the arm64
 tree
Message-ID: <20190807163942.4f2018b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t4o3uwHLkn7V0CflIBKoRww";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t4o3uwHLkn7V0CflIBKoRww
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/arm64/include/asm/processor.h

between commit:

  b907b80d7ae7 ("arm64: remove pointless __KERNEL__ guards")

from the arm64 tree and commit:

  cd6ee3f76f64 ("arm64, mm: move generic mmap layout functions to mm")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/include/asm/processor.h
index ec70762519df,65e2de00913f..000000000000
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@@ -280,8 -281,8 +280,6 @@@ static inline void spin_lock_prefetch(c
  		     "nop") : : "p" (ptr));
  }
 =20
- #define HAVE_ARCH_PICK_MMAP_LAYOUT
 -#endif
--
  extern unsigned long __ro_after_init signal_minsigstksz; /* sigframe size=
 */
  extern void __init minsigstksz_setup(void);
 =20

--Sig_/t4o3uwHLkn7V0CflIBKoRww
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1Kci4ACgkQAVBC80lX
0GxRSgf/fiaSAqgaP8A9eC7cQyoEhmn4Me58n5csUa+JmFtW39L2bwrthJcsYnJD
Byxtbt/pWqmnxk+yNg0cwcxw/B5paOT8hSumjQDIzq32wMxdkhHUU/zBHa4/OHpR
WlSqR4/76fHdgtFpgMnTNgxPK+XCGOA1OhcVeP0YOtxmrpqkadhZKZ8OkLduwHtH
L7QsPnhKPc+5DTanIMxr2mx8B1V1WmR4NELp1d2KIyEkJ7PB9CNm1gS0xqgAgY6C
6TYeYUI893y3Cg7DSiJ+GkExcThk3w/qt8gzSyCh3sMjW/YRb9x8EJc2Cro0tMw+
tbGIJvQTeaGFfNHIpw3jGfri3IArbw==
=nVuQ
-----END PGP SIGNATURE-----

--Sig_/t4o3uwHLkn7V0CflIBKoRww--
