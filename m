Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD77C06516
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5908A2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Birj6ebV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfGDKKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:10:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57273 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfGDKKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:10:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fYcl45xgz9s8m;
        Thu,  4 Jul 2019 20:09:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562235000;
        bh=blyyOb94IIVwlpXFZU6A5FCGAdm1fRJWRwE28lb5jSc=;
        h=Date:From:To:Cc:Subject:From;
        b=Birj6ebVqamhFgSPMk3utkGdmAqxqyK07HuEpILDZ3PFklA/uuufX0t4+fOg7EgeN
         a2lPeNOCtRwqqcxerV/qfCwTnBV+cLkgj//XgH6ubVOuXI/5tkOnmWABZ6MhGGG7+z
         MCV7FBYsjVAuvaEnHRWvgkQBBjnyxL1DJIsqNArmeSxgGlwCO2Dk9RNyyoWRohOF9u
         CeEsv4RF6duc0dLCXCml8wZjubWUMGXXIbyhUgaZkOtvHL6rxjmv/++JMpJXTPIFLC
         mo3r6+62r4fnUPsp5V72xrZDBcjlEpXXP8JFshNDhu/D5z5vMPh7TeApN2Th3Bps2J
         uMJEBJlRs65Iw==
Date:   Thu, 4 Jul 2019 20:09:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the akpm-current tree with the hmm tree
Message-ID: <20190704200956.016f2297@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Q5_3A=y2kD4X2Kpg60cfmgg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q5_3A=y2kD4X2Kpg60cfmgg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  include/linux/mm.h

between commit:

  25b2995a35b6 ("mm: remove MEMORY_DEVICE_PUBLIC support")

from the hmm tree and commit:

  0a470a2d114a ("mm: clean up is_device_*_page() definitions")

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

diff --cc include/linux/mm.h
index d405a7cff62a,12980954daf9..000000000000
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@@ -950,27 -953,15 +950,7 @@@ static inline bool put_devmap_managed_p
  	}
  	return false;
  }
-=20
- static inline bool is_device_private_page(const struct page *page)
- {
- 	return is_zone_device_page(page) &&
- 		page->pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE;
- }
-=20
- #ifdef CONFIG_PCI_P2PDMA
- static inline bool is_pci_p2pdma_page(const struct page *page)
- {
- 	return is_zone_device_page(page) &&
- 		page->pgmap->type =3D=3D MEMORY_DEVICE_PCI_P2PDMA;
- }
- #else /* CONFIG_PCI_P2PDMA */
- static inline bool is_pci_p2pdma_page(const struct page *page)
- {
- 	return false;
- }
- #endif /* CONFIG_PCI_P2PDMA */
-=20
  #else /* CONFIG_DEV_PAGEMAP_OPS */
 -static inline void dev_pagemap_get_ops(void)
 -{
 -}
 -
 -static inline void dev_pagemap_put_ops(void)
 -{
 -}
 -
  static inline bool put_devmap_managed_page(struct page *page)
  {
  	return false;
@@@ -978,14 -970,27 +959,19 @@@
 =20
  static inline bool is_device_private_page(const struct page *page)
  {
- 	return false;
+ 	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
+ 		IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
+ 		is_zone_device_page(page) &&
+ 		page->pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE;
  }
 =20
 -static inline bool is_device_public_page(const struct page *page)
 -{
 -	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
 -		IS_ENABLED(CONFIG_DEVICE_PUBLIC) &&
 -		is_zone_device_page(page) &&
 -		page->pgmap->type =3D=3D MEMORY_DEVICE_PUBLIC;
 -}
 -
  static inline bool is_pci_p2pdma_page(const struct page *page)
  {
- 	return false;
+ 	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
+ 		IS_ENABLED(CONFIG_PCI_P2PDMA) &&
+ 		is_zone_device_page(page) &&
+ 		page->pgmap->type =3D=3D MEMORY_DEVICE_PCI_P2PDMA;
  }
- #endif /* CONFIG_DEV_PAGEMAP_OPS */
 =20
  /* 127: arbitrary random number, small enough to assemble well */
  #define page_ref_zero_or_close_to_overflow(page) \

--Sig_/Q5_3A=y2kD4X2Kpg60cfmgg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0d0HQACgkQAVBC80lX
0GzZhgf/TZMB8ASoiZgkLnlRwb3CTJBbFkayZsDZuvg1ibBnfni4lQdQS6aeXui5
4ei4ELeNqvtL4cy0jPIFvV+uXoUMn3MCDIa6SBYiUg/5Zm3kVX7nu21DwRheZdm0
EtoehGRmxNuxqttzBNVz2GTadpYOmJNPzBQz+3897s7Zxr0KNSXql7qAcVYOcyNf
3QsxazsiLGwi5OwlonCTs/jX8lQzGUZjhi4pIxdhOQ9OYX08W4oTJ06bS2U3Vh7q
5WrbjKzRaRGhionHRd2GXHxd8G77JniLrU1gBar08DnWbQuVger8vmwolRcCY+MI
gKSH+xuP5CZML5R1ch+GNQB9t6PvOA==
=KpjQ
-----END PGP SIGNATURE-----

--Sig_/Q5_3A=y2kD4X2Kpg60cfmgg--
