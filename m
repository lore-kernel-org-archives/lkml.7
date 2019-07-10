Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F4C73C65
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A49620693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iThLhAoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfGJBZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:25:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfGJBZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:25:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45k1hH68Znz9sNr;
        Wed, 10 Jul 2019 11:25:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562721904;
        bh=Mplpc+ScQIMcplkOolvxj8oC+zCo/Kw+CWEEKiYK6QQ=;
        h=Date:From:To:Cc:Subject:From;
        b=iThLhAoLtJ23JwcgavEK7yuTra83OTCUTo3iiSWOByOha6KKK8eCS3T1/a9cRyckk
         aQl1Bg9K91bj/tHE9dAHCN64mxj61F4QfJj3cSrnj7vnqDYHQUDzJX86JXzbLQ8dWY
         IbTRXk6hon01u2QAuRq8zR/CNAkHJjodFzbIiOZ6q1eqw5b7tIM2U0g4e5hbTaUru3
         0WXHO0CQAiX55AfyLNB2cJ9qWlui6unjJdmo9DCiWHxjHfq12sr1yzJtv7MDtBXE0+
         xYQG/47U1837Vz2CmQRzhhCJaWdd6C2kYocQ8fehLn0HX8+MizqT4ZkH/gMRV8KYXi
         IdYJkBW/TLJzQ==
Date:   Wed, 10 Jul 2019 11:25:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Subject: linux-next: manual merge of the iomap tree with Linus' tree
Message-ID: <20190710112503.30e2ad08@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/w8Z2ruBOddqr4cCayhOvFZm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w8Z2ruBOddqr4cCayhOvFZm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iomap tree got a conflict in:

  fs/iomap.c

between commits:

  147a60538d91 ("iomap: use bio_release_pages in iomap_dio_bio_end_io")
  ff896738be38 ("block: return from __bio_try_merge_page if merging occured=
 in the same page")
  79d08f89bb1b ("block: fix .bi_size overflow")

from Linus' tree and commits:

  c8934e8fa92f ("iomap: move the direct IO code into a separate file")
  66148f9b8b2e ("iomap: move the buffered read code into a separate file")
  79d08f89bb1b ("block: fix .bi_size overflow")

from the iomap tree.

I fixed it up (I removed the file and applied the following merge fix
patch) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 10 Jul 2019 11:18:41 +1000
Subject: [PATCH] iomap: fix for block changes and split of iomap.c

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/iomap/direct-io.c |  8 +-------
 fs/iomap/read.c      | 14 +++++++++-----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 33d303cf0e59..6885450496c9 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -174,13 +174,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
-		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
-			struct bvec_iter_all iter_all;
-			struct bio_vec *bvec;
-
-			bio_for_each_segment_all(bvec, bio, iter_all)
-				put_page(bvec->bv_page);
-		}
+		bio_release_pages(bio, false);
 		bio_put(bio);
 	}
 }
diff --git a/fs/iomap/read.c b/fs/iomap/read.c
index 117626cd7ead..6478436fd05a 100644
--- a/fs/iomap/read.c
+++ b/fs/iomap/read.c
@@ -143,7 +143,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, l=
off_t length, void *data,
 	struct iomap_readpage_ctx *ctx =3D data;
 	struct page *page =3D ctx->cur_page;
 	struct iomap_page *iop =3D iomap_page_create(inode, page);
-	bool is_contig =3D false;
+	bool same_page =3D false, is_contig =3D false;
 	loff_t orig_pos =3D pos;
 	unsigned poff, plen;
 	sector_t sector;
@@ -171,10 +171,14 @@ iomap_readpage_actor(struct inode *inode, loff_t pos,=
 loff_t length, void *data,
 	 * Try to merge into a previous segment if we can.
 	 */
 	sector =3D iomap_sector(iomap, pos);
-	if (ctx->bio && bio_end_sector(ctx->bio) =3D=3D sector) {
-		if (__bio_try_merge_page(ctx->bio, page, plen, poff, true))
-			goto done;
+	if (ctx->bio && bio_end_sector(ctx->bio) =3D=3D sector)
 		is_contig =3D true;
+
+	if (is_contig &&
+	    __bio_try_merge_page(ctx->bio, page, plen, poff, &same_page)) {
+		if (!same_page && iop)
+			atomic_inc(&iop->read_count);
+		goto done;
 	}
=20
 	/*
@@ -185,7 +189,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, l=
off_t length, void *data,
 	if (iop)
 		atomic_inc(&iop->read_count);
=20
-	if (!ctx->bio || !is_contig || bio_full(ctx->bio)) {
+	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
 		gfp_t gfp =3D mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 		int nr_vecs =3D (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/w8Z2ruBOddqr4cCayhOvFZm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0lPm8ACgkQAVBC80lX
0Gyh1Af8DIM7rWvpgB+zZrKHYeRjYRP0keOjh7orhDQYYwQ9iu70QLmrSbEfLyQ8
DLi+NQ1D0GXpB3OIT9xEv7HCHgYpQrhmm7Wmftzk7HgWgVm3HidqEzfm2fc0AAXM
3WRfjuRO+6X2W4NLqDWVdMAMym8DkRK9EaXwQEWhw7+XNlmYGIoHmCW34AfOdqG8
v1ELWo7etzEIxEiog7KZ8tB6/AEzcEayM0neMMU5HzHvAqLloV1fkoC76ei6bpqj
JkjssN6x+HFuon1QIKBf/2irF81L8qkmtWbra6xpqycTuHzdSfOSdKpWXAyADClq
vptRzBIaoZbf02bkBIXYI4Qa1cAOTw==
=JCzO
-----END PGP SIGNATURE-----

--Sig_/w8Z2ruBOddqr4cCayhOvFZm--
