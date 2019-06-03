Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF9C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3923127B84
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SxuzK9oG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfFCFBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 01:01:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59529 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfFCFBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 01:01:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45HNDv1ry3z9sNC;
        Mon,  3 Jun 2019 15:01:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559538079;
        bh=UBqzdB6Lxax+3unelMIrwtK+PlVXo1q36OjfCyBjZgo=;
        h=Date:From:To:Cc:Subject:From;
        b=SxuzK9oGL3h050ZuL02+l/8gw05qmI/xdCodGlbMT5/6EmRHhTWaF8cFx4s+9idYX
         sEi7EjM4zdNV23r4F6D4gWdCSktIPzLUchZh4dMaXqMlvWahcLtpSol3bnG2qul0wL
         /wKiaMuVm3+uqxrEUBeZJ/MHfYi9dyR8WEY1QyhTKTpMxJYjX3rYkU3hd94yoRy4N5
         d2oVNO5VbX6MsmiJtegzzRaYZaanX93wkUlomNGQe2/3i5V1lOFRVyelQfRQ2dfMxz
         1U7YArFiHI2hy+EyCHmbFQ4U3lX9xlVfZm1gOWWLeyJ1BlRc58NYD5wXoEPTvS6Vm3
         CFbVPDRYCbN3g==
Date:   Mon, 3 Jun 2019 15:01:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fredrik Noring <noring@nocrew.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 dma-mapping tree
Message-ID: <20190603150118.73e2c3b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jeuklPm=Sjw9bTY1hdmFu_M"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jeuklPm=Sjw9bTY1hdmFu_M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  include/linux/genalloc.h

between commit:

  3334e1dc5d71 ("lib/genalloc: add gen_pool_dma_zalloc() for zeroed DMA all=
ocations")

from the dma-mapping tree and commit:

  1c6b703cba18 ("lib/genalloc: introduce chunk owners")

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

diff --cc include/linux/genalloc.h
index 6c62eeca754f,b0ab64879ccb..000000000000
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@@ -116,13 -124,47 +124,48 @@@ static inline int gen_pool_add(struct g
  	return gen_pool_add_virt(pool, addr, -1, size, nid);
  }
  extern void gen_pool_destroy(struct gen_pool *);
- extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
- extern unsigned long gen_pool_alloc_algo(struct gen_pool *, size_t,
- 		genpool_algo_t algo, void *data);
+ unsigned long gen_pool_alloc_algo_owner(struct gen_pool *pool, size_t siz=
e,
+ 		genpool_algo_t algo, void *data, void **owner);
+=20
+ static inline unsigned long gen_pool_alloc_owner(struct gen_pool *pool,
+ 		size_t size, void **owner)
+ {
+ 	return gen_pool_alloc_algo_owner(pool, size, pool->algo, pool->data,
+ 			owner);
+ }
+=20
+ static inline unsigned long gen_pool_alloc_algo(struct gen_pool *pool,
+ 		size_t size, genpool_algo_t algo, void *data)
+ {
+ 	return gen_pool_alloc_algo_owner(pool, size, algo, data, NULL);
+ }
+=20
+ /**
+  * gen_pool_alloc - allocate special memory from the pool
+  * @pool: pool to allocate from
+  * @size: number of bytes to allocate from the pool
+  *
+  * Allocate the requested number of bytes from the specified pool.
+  * Uses the pool allocation function (with first-fit algorithm by default=
).
+  * Can not be used in NMI handler on architectures without
+  * NMI-safe cmpxchg implementation.
+  */
+ static inline unsigned long gen_pool_alloc(struct gen_pool *pool, size_t =
size)
+ {
+ 	return gen_pool_alloc_algo(pool, size, pool->algo, pool->data);
+ }
+=20
  extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
  		dma_addr_t *dma);
 +void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t =
*dma);
- extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
+ extern void gen_pool_free_owner(struct gen_pool *pool, unsigned long addr,
+ 		size_t size, void **owner);
+ static inline void gen_pool_free(struct gen_pool *pool, unsigned long add=
r,
+                 size_t size)
+ {
+ 	gen_pool_free_owner(pool, addr, size, NULL);
+ }
+=20
  extern void gen_pool_for_each_chunk(struct gen_pool *,
  	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
  extern size_t gen_pool_avail(struct gen_pool *);

--Sig_/jeuklPm=Sjw9bTY1hdmFu_M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz0qZ4ACgkQAVBC80lX
0Gww3Af7BfIy8PAMS8/X58GYqmvxTsxE9AEP9trbAhPCoWFAj/EJupkDeRk64Bqm
lTMBDazfe2pRDL7on963n07SUMWvdAD+/EjyiMXAb9/IU2jQXpTpI5ILH4x//IEc
Cz5+iut8k9CnLduTnlko5+WeRyAXRNQxG4TLfu3+xLXtssOgIZjG4xvZcgf1GS3f
CO/8wCo3R2aCB4A3RXC5cMTEe5dhQiv3WMO+52dQFXZ7dl4c6H6mZU/8cAxLkx85
NNFG9ZErLmHP8Db/i+W4ZchEO4eoMjCnX54oYy8snzFuXya0ohB6qyzQYFg3OS0o
G1EBpFQwfPVELEsbTJnCx9nc33HycA==
=3jKI
-----END PGP SIGNATURE-----

--Sig_/jeuklPm=Sjw9bTY1hdmFu_M--
