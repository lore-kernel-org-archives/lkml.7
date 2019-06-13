Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A1AC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8208F20673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KFFB0qfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392963AbfFMQpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:45:42 -0400
Received: from ozlabs.org ([203.11.71.1]:48185 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbfFMFxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 01:53:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45PXwm2j90z9s5c;
        Thu, 13 Jun 2019 15:53:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560405224;
        bh=XFQvhiLejuLfZHZHzD4qIdC0evQEitD0UMR+TBNmrDQ=;
        h=Date:From:To:Cc:Subject:From;
        b=KFFB0qfKhX/dJwzPzGr+n/DMV/sIp3f7L+FcoVzFY8AG/tghV5n04tcw0WNeboPWa
         Rq7JMLgzQEhno4YhgHmrGnOhPXdSjWFEEHt22gswO3ny4s/A+FlaxoK0ii3fZ2oSpl
         ASgqPCR2bEBsT3A/ldlbIYTyJxbaor9xTSXwqlMH8jBr0BKVqJlKNclZzLE1Os1Fc+
         w4Jf+w/wShS8e/oUAeTDu8tNuKNq0eUBX1Dpl/E1zZmYBiwH31d4C0H8jCahxQsvVA
         xfzfc//lAsVc7OrexUCa1Krm+joaQ/Tdw2KrEvlsvuZ5Teskji4XA9Kw+YkLVoMC+J
         b/Lt/x9D9auFA==
Date:   Thu, 13 Jun 2019 15:53:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: linux-next: manual merge of the char-misc tree with the driver-core
 tree
Message-ID: <20190613155344.64fce8b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U4N4kI9k/xWKLnuuvxrCEXi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U4N4kI9k/xWKLnuuvxrCEXi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/misc/vmw_balloon.c

between commit:

  225afca60b8a ("vmw_balloon: no need to check return value of debugfs_crea=
te functions")

from the driver-core tree and commits:

  83a8afa72e9c ("vmw_balloon: Compaction support")
  5d1a86ecf328 ("vmw_balloon: Add memory shrinker")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/misc/vmw_balloon.c
index fdf5ad757226,043eed845246..000000000000
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@@ -1553,15 -1942,26 +1932,24 @@@ static int __init vmballoon_init(void
  	if (x86_hyper_type !=3D X86_HYPER_VMWARE)
  		return -ENODEV;
 =20
- 	for (page_size =3D VMW_BALLOON_4K_PAGE;
- 	     page_size <=3D VMW_BALLOON_LAST_SIZE; page_size++)
- 		INIT_LIST_HEAD(&balloon.page_sizes[page_size].pages);
-=20
-=20
  	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
 =20
+ 	error =3D vmballoon_register_shrinker(&balloon);
+ 	if (error)
+ 		goto fail;
+=20
 -	error =3D vmballoon_debugfs_init(&balloon);
 -	if (error)
 -		goto fail;
 +	vmballoon_debugfs_init(&balloon);
 =20
+ 	/*
+ 	 * Initialization of compaction must be done after the call to
+ 	 * balloon_devinfo_init() .
+ 	 */
+ 	balloon_devinfo_init(&balloon.b_dev_info);
+ 	error =3D vmballoon_compaction_init(&balloon);
+ 	if (error)
+ 		goto fail;
+=20
+ 	INIT_LIST_HEAD(&balloon.huge_pages);
  	spin_lock_init(&balloon.comm_lock);
  	init_rwsem(&balloon.conf_sem);
  	balloon.vmci_doorbell =3D VMCI_INVALID_HANDLE;

--Sig_/U4N4kI9k/xWKLnuuvxrCEXi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0B5OgACgkQAVBC80lX
0GxkTgf/RYWZ6v9hX/MnklSXgcgWAgzRuGzVzUfYl9gfy3bW0KZI4wxdqbummx5m
F/+Y6QsnOuLSwGjUBlR/Nk1bCAKTV7qPqY1SBJD9sFjt5Z5pGEAkDzI/flatV5tv
jB96Wr3Z/5dkqDIycEeoAdM2241iSZx0rxYo1tUwWlBfoJ3xdC+7/rcJweoSvhgd
c9DIDstLJJuHO82AcLqwYK+LdCRemVbywVU25LxgxVVcoEZQburqmpBv6BEmzXF3
uiSdXBD68z583JYiZD5DN8Rtajzvdq96XDWxRxXTkjb4pcYO3EUMKRmYNWaIPKKv
l4o8AbVhboykwOlx3/IgxDRTjwiqPw==
=vazS
-----END PGP SIGNATURE-----

--Sig_/U4N4kI9k/xWKLnuuvxrCEXi--
