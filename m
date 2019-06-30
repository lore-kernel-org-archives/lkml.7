Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A6AC5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 22:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBFB2089F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 22:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f7oqWPVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfF3WmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 18:42:19 -0400
Received: from ozlabs.org ([203.11.71.1]:44641 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfF3WmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 18:42:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cQVZ51w3z9s00;
        Mon,  1 Jul 2019 08:42:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561934535;
        bh=TvJkK4C8sV44GZEQRZ/lRxWlXQRHrK+ez8nGvd/bK7o=;
        h=Date:From:To:Cc:Subject:From;
        b=f7oqWPVWuBSf+N5rotTHfhNaaLrE6AsMiqzrAb+aacjP5hbPYPeE2259UakWC4cSH
         KJIlgUUIABsc5+85R4tpsEERSz8p8TzJ9qmKqbgBTj/KHxrC7DXnDGR17m5Ve/3P9t
         INHVIA7lV7VNzEA858ykNNt701McjZZXft3evUBZGfbgu7rSIW84UUjvrEUS4L/I52
         C/CKo7rqZCd/YUjbBytf47bCajCihJuwh2Q+agCODX8iM5qDjLm2x/8ABfhKU4hfC0
         Li5gQR6fv029hbZwNiBLW3cxH/o6hHTQR3MoAihPyCix0yqHMnSQvyrHKRQiqrvivu
         Ljn0qArl5KAag==
Date:   Mon, 1 Jul 2019 08:42:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fredrik Noring <noring@nocrew.org>
Subject: linux-next: manual merge of the dma-mapping tree with Linus' tree
Message-ID: <20190701084213.1056beab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SQL05sKDn7veRWekWBJHbSS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SQL05sKDn7veRWekWBJHbSS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dma-mapping tree got a conflict in:

  include/linux/genalloc.h

between commit:

  795ee30648c7 ("lib/genalloc: introduce chunk owners")

from Linus' tree and commit:

  cf394fc5f715 ("lib/genalloc.c: Add algorithm, align and zeroed family of =
DMA allocators")

from the dma-mapping tree.

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
index 205f62b8d291,ed641337df87..000000000000
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@@ -122,47 -116,21 +122,56 @@@ static inline int gen_pool_add(struct g
  	return gen_pool_add_virt(pool, addr, -1, size, nid);
  }
  extern void gen_pool_destroy(struct gen_pool *);
 -extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
 -extern unsigned long gen_pool_alloc_algo(struct gen_pool *, size_t,
 -		genpool_algo_t algo, void *data);
 +unsigned long gen_pool_alloc_algo_owner(struct gen_pool *pool, size_t siz=
e,
 +		genpool_algo_t algo, void *data, void **owner);
 +
 +static inline unsigned long gen_pool_alloc_owner(struct gen_pool *pool,
 +		size_t size, void **owner)
 +{
 +	return gen_pool_alloc_algo_owner(pool, size, pool->algo, pool->data,
 +			owner);
 +}
 +
 +static inline unsigned long gen_pool_alloc_algo(struct gen_pool *pool,
 +		size_t size, genpool_algo_t algo, void *data)
 +{
 +	return gen_pool_alloc_algo_owner(pool, size, algo, data, NULL);
 +}
 +
 +/**
 + * gen_pool_alloc - allocate special memory from the pool
 + * @pool: pool to allocate from
 + * @size: number of bytes to allocate from the pool
 + *
 + * Allocate the requested number of bytes from the specified pool.
 + * Uses the pool allocation function (with first-fit algorithm by default=
).
 + * Can not be used in NMI handler on architectures without
 + * NMI-safe cmpxchg implementation.
 + */
 +static inline unsigned long gen_pool_alloc(struct gen_pool *pool, size_t =
size)
 +{
 +	return gen_pool_alloc_algo(pool, size, pool->algo, pool->data);
 +}
 +
  extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
  		dma_addr_t *dma);
+ extern void *gen_pool_dma_alloc_algo(struct gen_pool *pool, size_t size,
+ 		dma_addr_t *dma, genpool_algo_t algo, void *data);
+ extern void *gen_pool_dma_alloc_align(struct gen_pool *pool, size_t size,
+ 		dma_addr_t *dma, int align);
+ extern void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_=
addr_t *dma);
+ extern void *gen_pool_dma_zalloc_algo(struct gen_pool *pool, size_t size,
+ 		dma_addr_t *dma, genpool_algo_t algo, void *data);
+ extern void *gen_pool_dma_zalloc_align(struct gen_pool *pool, size_t size,
+ 		dma_addr_t *dma, int align);
 -extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
 +extern void gen_pool_free_owner(struct gen_pool *pool, unsigned long addr,
 +		size_t size, void **owner);
 +static inline void gen_pool_free(struct gen_pool *pool, unsigned long add=
r,
 +                size_t size)
 +{
 +	gen_pool_free_owner(pool, addr, size, NULL);
 +}
 +
  extern void gen_pool_for_each_chunk(struct gen_pool *,
  	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
  extern size_t gen_pool_avail(struct gen_pool *);

--Sig_/SQL05sKDn7veRWekWBJHbSS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ZOsUACgkQAVBC80lX
0GzVYQf8DzGrgEwhjLgTFBKug6Z25iF4yKlXBPK5jvATA8wHxFiPUQDoANG7Jm4o
ihnBJsQHN8j9u24MQy+3pWij486+yOA8/5TqPo/TI5mgPD8qJf0bbq0UZCQ5zkax
8GZYPShvBVGWOEoYb/5uKKamFZhZkDoNJlPbHNU26TBf8pjTxAwr3pMNZqQrIj++
pnL7ITRs6JQp86fsB5YhUZ/HgPh1eb3a9DLd9M+9uBBB1bYySxZQAHPKD6QGGCC+
j6Nu58G3MNSeKFlVnqFznoqsTghJYgOADZZqyj5oDz1AK6kmOHzlDYjmcALS5V/y
8loDXZ2G9zn/HI/df0QdC/hn/Fn8FQ==
=urcz
-----END PGP SIGNATURE-----

--Sig_/SQL05sKDn7veRWekWBJHbSS--
