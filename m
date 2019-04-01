Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25848C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4CF20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k3VSDY+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDAXuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:50:13 -0400
Received: from ozlabs.org ([203.11.71.1]:51635 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfDAXuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:50:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Y8GR0SKRz9sRk;
        Tue,  2 Apr 2019 10:50:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554162609;
        bh=3KuGHfxYoRQI4+fxh4dETcyKaRGfVPKxqivvckEsH7g=;
        h=Date:From:To:Cc:Subject:From;
        b=k3VSDY+ijIYCs6u1CIFASkhthjWNVnIUpojhTK9cCBw4RaqGcUxkmAgiPZckwMU5H
         /YjNSyf/BhRlLhfPL8h3NKR4Q9wmgXsm7hi3PT4hvLP5j+Pic1447MHGtvZHihHZG9
         CLiZLRM+8dTi+N38Di4Lm6TieIO5Q5/8iyQpSebtV+1742dgjKQuJWpFIQd6/7o0W3
         LyDh51nBKKq7o4lktqpmnDqkALGN73eO0RP5qVOr7d30rmafi/lUkFSOJ9YJQ0xOyM
         RQH1bBxGzo9bYuZM0wfeH/dLWJuINjPBZmcc0EJ4kNAJxShBiR+nTnvWGg/GY4k2Mi
         nndf8hi3LX4Pg==
Date:   Tue, 2 Apr 2019 10:50:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qiang Yu <yuq825@gmail.com>, Eric Anholt <eric@anholt.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190402105006.48f93e53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SZEXJadgHBuvyUe/0V=B28w"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SZEXJadgHBuvyUe/0V=B28w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/kernel.h:7,
                 from include/asm-generic/bug.h:18,
                 from arch/x86/include/asm/bug.h:83,
                 from include/linux/bug.h:5,
                 from include/linux/mmdebug.h:5,
                 from include/linux/gfp.h:5,
                 from include/linux/slab.h:15,
                 from drivers/gpu/drm/lima/lima_ctx.c:4:
drivers/gpu/drm/lima/lima_ctx.c: In function 'lima_ctx_create':
include/linux/limits.h:13:18: warning: passing argument 3 of 'xa_alloc' mak=
es pointer from integer without a cast [-Wint-conversion]
 #define UINT_MAX (~0U)
                  ^~~~~
drivers/gpu/drm/lima/lima_ctx.c:26:36: note: in expansion of macro 'UINT_MA=
X'
  err =3D xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
                                    ^~~~~~~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/idr.h:15,
                 from include/drm/drm_device.h:7,
                 from drivers/gpu/drm/lima/lima_device.h:7,
                 from drivers/gpu/drm/lima/lima_ctx.c:6:
include/linux/xarray.h:817:9: note: expected 'void *' but argument is of ty=
pe 'unsigned int'
   void *entry, struct xa_limit limit, gfp_t gfp)
   ~~~~~~^~~~~
drivers/gpu/drm/lima/lima_ctx.c:26:46: error: incompatible type for argumen=
t 4 of 'xa_alloc'
  err =3D xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
                                              ^~~
In file included from include/linux/radix-tree.h:31,
                 from include/linux/idr.h:15,
                 from include/drm/drm_device.h:7,
                 from drivers/gpu/drm/lima/lima_device.h:7,
                 from drivers/gpu/drm/lima/lima_ctx.c:6:
include/linux/xarray.h:817:32: note: expected 'struct xa_limit' but argumen=
t is of type 'struct lima_ctx *'
   void *entry, struct xa_limit limit, gfp_t gfp)
                ~~~~~~~~~~~~~~~~^~~~~

Caused by commit

  a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")

interacting with commit

  a3e4d3f97ec8 ("XArray: Redesign xa_alloc API")

from Linus' tree (v5.1-rc1).

I have applied the following patch for today.  It could be applied as
part of a merge of v5.1-rc1 into drm-misc.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 2 Apr 2019 10:45:32 +1100
Subject: [PATCH] drm/lima: update for xa_alloc API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/lima/lima_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_ct=
x.c
index c8d12f7c6894..bafa00d74cc5 100644
--- a/drivers/gpu/drm/lima/lima_ctx.c
+++ b/drivers/gpu/drm/lima/lima_ctx.c
@@ -23,7 +23,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_=
ctx_mgr *mgr, u32 *id)
 			goto err_out0;
 	}
=20
-	err =3D xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
+	err =3D xa_alloc(&mgr->handles, id, ctx, XA_LIMIT(*id, UINT_MAX), GFP_KER=
NEL);
 	if (err < 0)
 		goto err_out0;
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/SZEXJadgHBuvyUe/0V=B28w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyio64ACgkQAVBC80lX
0Gyxmwf7BUUcO3jO4XZMNB1v76C3+C8HGbIcponmP/SqlaVSm0ERkTwh5rpHCQJ6
ckz2pUVtQOKWoRyzU9PkE061Qg5piQjIfW6aFGvVba8uyW/jXNXN9SgSDs9ldin5
9HoQAW/5hcV/wiK/0kSd3lzcJUZw12PaVozlEGsp7M4hnnO5MXsxzvzWhJE3dwqK
Ptj2T+XJu++rg8M4JacRlrq2AOuiydUC2M8EHbzqYek/ouNVj9QqPrGvAtCHzSrz
AvAunWUXF/nmSbs+xvYUtyZ8rGN1iokwqEZeVZLqskWffnfsHVzBU+08czc5tkRI
DijfB9yTtCwQvAD/PxNcM/p2WBAUhw==
=OqG1
-----END PGP SIGNATURE-----

--Sig_/SZEXJadgHBuvyUe/0V=B28w--
