Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2890C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F50218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TxvAdR24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfGDKzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:55:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbfGDKzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:55:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fZdR68Drz9sPB;
        Thu,  4 Jul 2019 20:55:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562237740;
        bh=VX3OP2vOB4lxDG7NJNe8Z2zhCL88AkDSoq84IfXmnZo=;
        h=Date:From:To:Cc:Subject:From;
        b=TxvAdR24teojejG9+j487oUI+lWGfVicS0n/o2HyJ5CfckYYEnWpgE51BhaLxo2Na
         orxK386/D6o9AgBAMPY4fgQo6z4ne1tMOQQFZYr2PmjqmXcIu7Yfa/MZPA2uv5YCdl
         Gvenu3mCBB0sBffW/T9FIffYlgf4vv9wq426cyWS3qtluKSnFjkc1slXtaVgieks6x
         yn+mnJcWUgv78fj3O67cCEhyGhlFp+SWFUO47mAXDjpDn6RkHmnuMDHmSUZqrsZNj+
         KZ4XQ/Fedy03xZ8SfjtKntD2kX6xZr1t+S0Kt4bba/KKVJt10wtuhAQ8Q7XIc++bDZ
         +matFqSMgXXAg==
Date:   Thu, 4 Jul 2019 20:55:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: linux-next: manual merge of the akpm-current tree with the hmm tree
Message-ID: <20190704205536.32740b34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YpLR1nSqk3gkTNQK6MF/bnY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YpLR1nSqk3gkTNQK6MF/bnY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/memory_hotplug.c

between commit:

  514caf23a70f ("memremap: replace the altmap_valid field with a PGMAP_ALTM=
AP_VALID flag")

from the hmm tree and commit:

  db30f881e2d7 ("mm/hotplug: kill is_dev_zone() usage in __remove_pages()")

from the akpm-current tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/memory_hotplug.c
index 6166ba5a15f3,dfab21dc33dc..000000000000
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@@ -549,16 -537,14 +537,13 @@@ static void __remove_section(struct zon
   * sure that pages are marked reserved and zones are adjust properly by
   * calling offline_pages().
   */
- void __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
+ void __remove_pages(struct zone *zone, unsigned long pfn,
  		    unsigned long nr_pages, struct vmem_altmap *altmap)
  {
- 	unsigned long i;
--	unsigned long map_offset =3D 0;
- 	int sections_to_remove;
++	unsigned long map_offset;
+ 	unsigned long nr, start_sec, end_sec;
 =20
- 	/* In the ZONE_DEVICE case device driver owns the memory region */
- 	if (is_dev_zone(zone))
 -	if (altmap)
--		map_offset =3D vmem_altmap_offset(altmap);
++	map_offset =3D vmem_altmap_offset(altmap);
 =20
  	clear_zone_contiguous(zone);
 =20

--Sig_/YpLR1nSqk3gkTNQK6MF/bnY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0d2ygACgkQAVBC80lX
0GwxCAf+PSCBsgWB9aTWBqRcLPQNCYvEwLATf/jbUEYQ+sxBADk5vQqnGH/u2JQS
fFB0keGn9s7V8D0zbSGalbFF9h7hsm9ICJYh7KxBoH7Fil5AmKKAXCSXVcsRMn4Z
yPekK9f0ZLwDoUJIlBJS+CAhyVZnTJZpTADXuSHptdHa3kcgF96bfKmtoKidXjEb
SDIEptAgh0ZSL5oYann4FJb1OuolzXO8pZ0c8SzCdQqsYpjBO15US7llmpZ1v8xi
+bBaNuZiPzl+ta7HJPEo5big0JplgloBGs8n27HIzG52+YEDCogXewa4OLillkLC
9x/BxOKgC5UGeYnoXwSfiUlcKjXi3w==
=VWyx
-----END PGP SIGNATURE-----

--Sig_/YpLR1nSqk3gkTNQK6MF/bnY--
