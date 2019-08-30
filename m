Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD9C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9542342A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PfpcOMF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfH3AQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:16:40 -0400
Received: from ozlabs.org ([203.11.71.1]:51419 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfH3AQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:16:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46KKlm2Mlzz9sN6;
        Fri, 30 Aug 2019 10:16:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567124196;
        bh=g5NGWNARkNDvpAI12TjAprP6jJ76TkUM5e9Q9OcBPN0=;
        h=Date:From:To:Cc:Subject:From;
        b=PfpcOMF42mhnP8oLbq3PJBFpPaXjIX8gNfuNeVxRanYkG2F590OOBcAQosakCrWTm
         7BGZfEohFundO2ea7ey6dLeMZzab1uK0jCww3joh+1izlmPP64QxcmjZOcsf0+7Lwv
         1x1DQUsKj1VwrszEMgUqD2crMYGPoTnMlfOnuS9ilKbNdeFt+u/MakUR1LSAF7JJ+M
         8IuQdigRCEpPPbZL1F4tWIWHtT+gDrptAlrflm9vo6p6fZWmgtMEmnkQ4HIKx1FmJT
         WdiRYjrHPX+fWpc4UzUeYYyhotFe3cCnYetvb6BAey9gotxQjmGM0mafZYY8F9MI3s
         xk7veVw4OuHog==
Date:   Fri, 30 Aug 2019 10:16:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <ren_guo@c-sky.com>, Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the csky tree with the dma-mapping tree
Message-ID: <20190830101634.21dca185@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PRcj0/Yawm.MCDGpYYaNiWW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PRcj0/Yawm.MCDGpYYaNiWW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the csky tree got a conflict in:

  arch/csky/mm/dma-mapping.c

between commit:

  8e3a68fb55e0 ("dma-mapping: make dma_atomic_pool_init self-contained")

from the dma-mapping tree and commit:

  4af9027d3f40 ("csky/dma: Fixup cache_op failed when cross memory ZONEs")

from the csky tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/csky/mm/dma-mapping.c
index 602a60d47a94,106ef02a8f89..000000000000
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@@ -14,33 -14,12 +14,6 @@@
  #include <linux/version.h>
  #include <asm/cache.h>
 =20
- void arch_dma_prep_coherent(struct page *page, size_t size)
 -static int __init atomic_pool_init(void)
--{
- 	if (PageHighMem(page)) {
- 		unsigned int count =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
-=20
- 		do {
- 			void *ptr =3D kmap_atomic(page);
- 			size_t _size =3D (size < PAGE_SIZE) ? size : PAGE_SIZE;
-=20
- 			memset(ptr, 0, _size);
- 			dma_wbinv_range((unsigned long)ptr,
- 					(unsigned long)ptr + _size);
-=20
- 			kunmap_atomic(ptr);
-=20
- 			page++;
- 			size -=3D PAGE_SIZE;
- 			count--;
- 		} while (count);
- 	} else {
- 		void *ptr =3D page_address(page);
-=20
- 		memset(ptr, 0, size);
- 		dma_wbinv_range((unsigned long)ptr, (unsigned long)ptr + size);
- 	}
 -	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
--}
 -postcore_initcall(atomic_pool_init);
--
  static inline void cache_op(phys_addr_t paddr, size_t size,
  			    void (*fn)(unsigned long start, unsigned long end))
  {

--Sig_/PRcj0/Yawm.MCDGpYYaNiWW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1oauIACgkQAVBC80lX
0GzVyQf+PEyj5yFHMX/BLhINUl3JIg44T0Ejk81hGmZx6HdebSWtSEdiA6TLY6Ht
QebgZ9MM6+aw5FIJpx38MvvzruWnMTh0L0gpdpfNbpTIg7nYCnvflRTsxVoHUGah
sjzAXfp9CqkvObhHfNnArRCP53yvW74MhO9xjGhppsD7mqe5nvmdBNOdeCvNrRW3
iE5nBBIo2x1yhyki4RsT6JqqXq241koY9GCe+uTWgtliL4Mrrq2u2uoMLYTxLQ5W
5oNGFltKafOUaAjpaqYg9l8gPV89EiUIglMce4/VPhRfIrUmjc5Uhh4kaQFk/kzJ
JoIspUaXaVA7Wp9BHVHWhgXjnlytpw==
=mpiq
-----END PGP SIGNATURE-----

--Sig_/PRcj0/Yawm.MCDGpYYaNiWW--
