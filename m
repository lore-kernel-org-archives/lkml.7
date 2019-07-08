Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC92C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074132086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PNE9fPP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfGHLnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:43:35 -0400
Received: from ozlabs.org ([203.11.71.1]:41919 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfGHLne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:43:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45j3Vp66yHz9sNT;
        Mon,  8 Jul 2019 21:43:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562586211;
        bh=fVX79QzuP3XmjxHGLGEV10dVgDN3UaHzkPoTyKKYOcA=;
        h=Date:From:To:Cc:Subject:From;
        b=PNE9fPP4AtS+EAZZ57DdHy5A7YADnOLwCPwb62eA6/pj0cH30EhWbzn+VeJHpY0o0
         +OPK11rsLVRQhBc4T2CX//KkOibzFzQmJEqEdejdqKop73tMwe59NU0koXI1gfLsRO
         YtJ4svZ04DY48nIQ76DYBI3mAOj2wwvT0ZNSAU2+2U3a2OOVbvXs9aZpInxTqN2Lon
         6k5X5p7/uOaI8oxjwhhQmw6QacI81/wOsT4qxXl26NOIweqy1b/dlCm7+pRQq1maV9
         roPT8Wi9a4PbKVJyNy9MrMxHtgb9OZy0c17f3NHG7b+fp2tmW3F7ZPYMmfQJWqysqy
         htoarpWhoj7JA==
Date:   Mon, 8 Jul 2019 21:43:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: linux-next: manual merge of the akpm-current tree with the powerpc
 tree
Message-ID: <20190708214328.6271f3f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/a7GmsKm5bIq+lDE.W6JsJ0O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a7GmsKm5bIq+lDE.W6JsJ0O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/powerpc/include/asm/pgtable.h

between commit:

  d6eacedd1f0e ("powerpc/book3s: Use config independent helpers for page ta=
ble walk")

from the powerpc tree and commit:

  be66a174b253 ("mm/nvdimm: add is_ioremap_addr and use that to check iorem=
ap address")

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

diff --cc arch/powerpc/include/asm/pgtable.h
index bf7d771f342e,64145751b2fd..000000000000
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@@ -140,30 -140,20 +140,44 @@@ static inline void pte_frag_set(mm_cont
  }
  #endif
 =20
 +#ifndef pmd_is_leaf
 +#define pmd_is_leaf pmd_is_leaf
 +static inline bool pmd_is_leaf(pmd_t pmd)
 +{
 +	return false;
 +}
 +#endif
 +
 +#ifndef pud_is_leaf
 +#define pud_is_leaf pud_is_leaf
 +static inline bool pud_is_leaf(pud_t pud)
 +{
 +	return false;
 +}
 +#endif
 +
 +#ifndef pgd_is_leaf
 +#define pgd_is_leaf pgd_is_leaf
 +static inline bool pgd_is_leaf(pgd_t pgd)
 +{
 +	return false;
 +}
 +#endif
 +
+ #ifdef CONFIG_PPC64
+ #define is_ioremap_addr is_ioremap_addr
+ static inline bool is_ioremap_addr(const void *x)
+ {
+ #ifdef CONFIG_MMU
+ 	unsigned long addr =3D (unsigned long)x;
+=20
+ 	return addr >=3D IOREMAP_BASE && addr < IOREMAP_END;
+ #else
+ 	return false;
+ #endif
+ }
+ #endif /* CONFIG_PPC64 */
+=20
  #endif /* __ASSEMBLY__ */
 =20
  #endif /* _ASM_POWERPC_PGTABLE_H */

--Sig_/a7GmsKm5bIq+lDE.W6JsJ0O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jLGAACgkQAVBC80lX
0Gw5TAf/UQ4Pcsr9wkHps9+Deq0YFrVCMpV0JfwT89naPooO9ldiZw/yjqtKFnIA
8SldhZM8UVYcm+3Yvk41kxtsQZCBv/LzkGxtSu0HtcE8gK4FrEXK6CQSaaVIgGlM
dta3LaWJJMUc+mXInQeWbsbAQQKT7m0Afmhocx6l1u1ZApLGzqCL9yHWLWaU28vv
UWDEGT+6GB+MROd7LkW+a17HCApVVvBqE39hitNBjIxWrnWqGxMwt3tvABbFYUvK
4cEs257dyqnXmdHZDw+93zYSuf4/WEquVaPnA++Yz6pKtTOVBDbGlMMBfYrk8exO
43dPlNGCror53Ym/K7Kug9vqRSo5iA==
=BNce
-----END PGP SIGNATURE-----

--Sig_/a7GmsKm5bIq+lDE.W6JsJ0O--
