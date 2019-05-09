Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FF1C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D657206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FMfm5OAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEIFiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 01:38:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfEIFiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 01:38:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4502Ds5gWGz9s9T;
        Thu,  9 May 2019 15:38:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557380285;
        bh=+ucXOT5wwHiR4LJTXn2l7ekAEklAWbguhnrkwSeReFE=;
        h=Date:From:To:Cc:Subject:From;
        b=FMfm5OAoaNuW/KypYPUF+J5BEV/0vQP4IVdz15fUIG0ZNOkGfAodgKbPfMHf0lvDq
         cy0teFs3z+Pve8CHFU1ULJUW3qzrOJ3ZC1xMdbosgpCL6VKzY8vI20PuE+nXMdFnkL
         dLZB6/WkK3b3eH+R7M6dUfuVIm3Ymrwl7/yPQO2QDsnIMioSO4b4MxBqsHxv736CEV
         Cq8QvQ4vecDe+77hSd4wtEADkdWIbYSkXUJZ27YVOAQh5ccqEfP7N+O15aLTmZzVfG
         EnCDRTx5UZMi+JwZnr564Ov4Q6csb40be1Zit7HhRx56pjmJPXPspPjvkfr0qb3Snu
         QSgrtcaxaK2Fg==
Date:   Thu, 9 May 2019 15:38:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: linux-next: manual merge of the akpm-current tree with the rdma
 tree
Message-ID: <20190509153805.6dfbb8ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N6r_ntWNktjFpZVHC1q.JuC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N6r_ntWNktjFpZVHC1q.JuC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  drivers/infiniband/core/umem.c

between commit:

  db6c6774af0d ("RDMA/umem: Remove hugetlb flag")

from the rdma tree and commit:

  c041ba1a3294 ("mm/gup: replace get_user_pages_longterm() with FOLL_LONGTE=
RM")

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

diff --cc drivers/infiniband/core/umem.c
index 0a23048db523,31191f098e73..000000000000
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@@ -295,10 -189,11 +295,11 @@@ struct ib_umem *ib_umem_get(struct ib_u
 =20
  	while (npages) {
  		down_read(&mm->mmap_sem);
- 		ret =3D get_user_pages_longterm(cur_base,
+ 		ret =3D get_user_pages(cur_base,
  				     min_t(unsigned long, npages,
  					   PAGE_SIZE / sizeof (struct page *)),
- 				     gup_flags, page_list, NULL);
+ 				     gup_flags | FOLL_LONGTERM,
 -				     page_list, vma_list);
++				     page_list, NULL);
  		if (ret < 0) {
  			up_read(&mm->mmap_sem);
  			goto umem_release;

--Sig_/N6r_ntWNktjFpZVHC1q.JuC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzTvL0ACgkQAVBC80lX
0GzYdgf+NxNeHbwWOAcxbKB8cTD8a0wOTgWJkq0xlwxRVf7I6r1vfD3CA3gcrgD8
Mc+OfxE7roMfUTmSzIWw+zRffnC+yZoxt2xntOxH8+qA+qwfp6vFLCOp65wFYDsB
+3h6J5kv58Eu3+WRtu0/2aU/3Nv1JCVvONhv/cj/+8e3UjuwmyA71YtvwfeFla8R
dB853U3wstWXgYG7rbnZarfkkIeXU2AZSud8sO1YE7/QhDI6PYQ9CF7rlvSaQf57
Rzo/TAlhBwNWr3ZNTATqSp9OSzWg4rYtVWvPlN42VlvBjCE32FUuzKPrUCnE5nff
GldaAGipKirhMxn22nDicA2TRKqyIQ==
=ouBp
-----END PGP SIGNATURE-----

--Sig_/N6r_ntWNktjFpZVHC1q.JuC--
