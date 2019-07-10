Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AD9C004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51BC20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KWQnQYrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfGJIZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:25:40 -0400
Received: from ozlabs.org ([203.11.71.1]:33185 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfGJIZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:25:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45kC1Y6DMkz9sMQ;
        Wed, 10 Jul 2019 18:25:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562747138;
        bh=BQcSY58E8lgwsATwcKMa7GTpVoMjox+PYKqAeW/r5bs=;
        h=Date:From:To:Cc:Subject:From;
        b=KWQnQYrHAge7pKAGPfQA3GTE+/1ko6/wWwxfKIxngwp/oa4dY0iEcq0nAe8+T6pSI
         rWB/5yKjeQVuIzeBFK06EH7Ai6wst8zgHDWzWnepRR/S+Pf8XMMh/GcSDIAorHsusk
         2RJgNW8V1AWKy8UNlyC5aU1Qf63+5viyg25oC+aZfxuvzHRRTbTrHBJkP4A/UgkEjW
         BrylwL9Rf/k2z0M7FfWpI+LWN46eRkRNxkXvYhK1IaANH8UTX/24EbVitR/1R4Z4yj
         dzu6PNghKlPHTTbWaL9jREAMfdCnCaBUq/bqdZgdmfoC3Ez7v26R5gVUEFgCmfT9On
         Lae42rhqBxN3w==
Date:   Wed, 10 Jul 2019 18:25:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: linux-next: manual merge of the akpm-current tree with the iomap
 tree
Message-ID: <20190710182530.0f26a159@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0lberg+hkvK8LOI5Tbzyf.b"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0lberg+hkvK8LOI5Tbzyf.b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  fs/iomap.c

between commit:

  6610815a3343 ("iomap: move the page migration code into a separate file")

from the iomap tree and commit:

  70b7f3cfceee ("mm: migrate: remove unused mode argument")

from the akpm-current tree.

I fixed it up (I rmeoved the file and applied the merge fix patch below)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 10 Jul 2019 18:21:35 +1000
Subject: [PATCH] mm: migrate: fix for fs/iomap.c splitting

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/iomap/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/migrate.c b/fs/iomap/migrate.c
index a25874700f95..9ef266e27286 100644
--- a/fs/iomap/migrate.c
+++ b/fs/iomap/migrate.c
@@ -17,7 +17,7 @@ iomap_migrate_page(struct address_space *mapping, struct =
page *newpage,
 {
 	int ret;
=20
-	ret =3D migrate_page_move_mapping(mapping, newpage, page, mode, 0);
+	ret =3D migrate_page_move_mapping(mapping, newpage, page, 0);
 	if (ret !=3D MIGRATEPAGE_SUCCESS)
 		return ret;
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/0lberg+hkvK8LOI5Tbzyf.b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0loPoACgkQAVBC80lX
0Gwoewf/QcFzo8hZzNC1k7F7UDQx+zg689qkXhcF8qbgBUxlCju5logiW+fnQoJj
jAdBThBZQhOy0nRrbwkYHen5UgzHx/ZQv2G/lkLYsIhFtNMqe8pN4rJ/3iivbdai
1akRuhCDbSvgbCM+tE7y9tQmLAfDjC5uAsnAv1EnbTqGQtYWx5z0It2UMqMh2E4m
mwFO/uDTdNXjFfxFq5Q2codAZATDvlsqEUPJVyHCBrwXwoS23/bbPWCpZhPzEvka
hliUM+YuPsH8wuvgiDWwjSMv9mUJ9rArAK3zYDQgc1LaG2OMvICgG0/LlsX6qsJX
YUV1XjUQWV4Ud9Uolw775PSTYEA4cQ==
=42dm
-----END PGP SIGNATURE-----

--Sig_/0lberg+hkvK8LOI5Tbzyf.b--
