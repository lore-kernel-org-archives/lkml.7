Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB9FC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E12820870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FMd8hoQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfHVIOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:14:35 -0400
Received: from ozlabs.org ([203.11.71.1]:35833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbfHVIOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:14:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Dcks3Xwcz9sBp;
        Thu, 22 Aug 2019 18:14:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1566461671;
        bh=1qipXZre+VKA22NNoJrU9n75jH0fsWQJKXkIA+6pu4k=;
        h=Date:From:To:Cc:Subject:From;
        b=FMd8hoQxOvzfN4ht6L59hjn21AcYORZ2E7wg4kBB35lwLVtFjnll7DtbYa+WUmcIY
         AvNYWPEwCxD3GJrJXNQxDcwmp+NVJ0SgAjsEF/6GTxVeqTnwamuK+ykuUWXl34XuqJ
         1z543TjcxVhlurQEBphnonZGgjpY3CBO+VHNyxPhG6x4PCgNpbJ/J1dvVie92fSD0f
         rNzqum6r5vAoe+QWthuYr+Vt2EXjJuueEx8wWz5IXlKDovl9oAcnr7K6TEyNAvodZ3
         B861+TOoVJuBmCDXVB1DJKKwDzXTMQ0hcM6zwgEe1eLLUnXSkTgsQ+MVxVA2g6oTSx
         JB2iELbqZ7sJQ==
Date:   Thu, 22 Aug 2019 18:14:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Subject: linux-next: manual merge of the akpm-current tree with the hmm tree
Message-ID: <20190822181416.7cfc075b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KD4nYZZOqJ4xiem3O4jiWiX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KD4nYZZOqJ4xiem3O4jiWiX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  include/linux/memremap.h

between commit:

  6869b7b20659 ("memremap: provide a not device managed memremap_pages")

from the hmm tree and commit:

  1ed60e3c73e6 ("/proc/kpageflags: do not use uninitialized struct pages")

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

diff --cc include/linux/memremap.h
index bef51e35d8d2,2cfc3c289d01..000000000000
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@@ -122,8 -124,7 +122,9 @@@ static inline struct vmem_altmap *pgmap
  }
 =20
  #ifdef CONFIG_ZONE_DEVICE
+ bool pfn_zone_device_reserved(unsigned long pfn);
 +void *memremap_pages(struct dev_pagemap *pgmap, int nid);
 +void memunmap_pages(struct dev_pagemap *pgmap);
  void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
  void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
  struct dev_pagemap *get_dev_pagemap(unsigned long pfn,

--Sig_/KD4nYZZOqJ4xiem3O4jiWiX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1eTtgACgkQAVBC80lX
0GyxtAgAl3/Z4vECEWXoPNecjy435ekigeVVyOHyZztfm9A+irRmCzzrmsV0+WrB
LXEr/G0+UnFSAS/PdoBDHQgOdSjGC6+f3wBSclnMaFiP5vzQbJfjcazioE1EC3Xk
2VqUmDk8JIAb30O3GGOxTwUXcxNcgK1j7xt6w9PWkNBnbO/SN0FMcLhMRlSSq6Vj
GO7McYp6OIBE4FtUTN2KdgpW8z0oGXVaXu1Jp1cnnufE3IE9cv94p+l6T0eqqazf
KBXwrUCOqnn3LkAu4dzB0UnoAlyL3dxz1RKOdaXEE7VQcVoF4e4cNjzf6N2CPVz1
7h+IvjnTWFjZrM5sR3EAHU2o9W92Zg==
=dMwY
-----END PGP SIGNATURE-----

--Sig_/KD4nYZZOqJ4xiem3O4jiWiX--
