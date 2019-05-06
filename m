Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5704C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B76A2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dwUU0wqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfEFFHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 01:07:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfEFFHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 01:07:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44y9hX3h3Tz9s4V;
        Mon,  6 May 2019 15:07:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557119229;
        bh=FMiZOhRHChN5HmB9f6Nh4VABzWfps63z4dJBq75TmeA=;
        h=Date:From:To:Cc:Subject:From;
        b=dwUU0wqP6XlfwDxlLDscq+XJ6rPjfLsud2j3ukrsImA9c7ooXRyjUs2XlxE9N9Xi8
         qj5LFwOC4ufIZkojpUwykuCDIB0HgoWF6CHJysbVYnpDu4YJwFUA9Y0mQ0NaYxyc1N
         3JSBUYhsWVR9T2PWqV/v+69LN4emPAISg2DXZym1U6guYVWsSP6ZYIZOnc/VAyfhNT
         weK2EkanW6QGMh0gzR8AARJhc9yHS8+/77H5RO4NSKuadyGnw9+5xN1lEITqtp9v79
         FmBVdbpA2A4JlnzhxDPDkxZw/RdzVRWcZJzb1xKEGcphble9VgerMtf8mCsLzVuS+S
         TZQR3XIgb2rMg==
Date:   Mon, 6 May 2019 15:07:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Abhi Das <adas@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20190506150707.618f013d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gcMpqtS=NShUJ79kEyb321h"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gcMpqtS=NShUJ79kEyb321h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/gfs2/lops.c: In function 'gfs2_end_log_read':
fs/gfs2/lops.c:394:49: error: macro "bio_for_each_segment_all" passed 4 arg=
uments, but takes just 3
  bio_for_each_segment_all(bvec, bio, i, iter_all) {
                                                 ^
fs/gfs2/lops.c:394:2: error: 'bio_for_each_segment_all' undeclared (first u=
se in this function); did you mean 'bio_first_page_all'?
  bio_for_each_segment_all(bvec, bio, i, iter_all) {
  ^~~~~~~~~~~~~~~~~~~~~~~~
  bio_first_page_all
fs/gfs2/lops.c:394:2: note: each undeclared identifier is reported only onc=
e for each function it appears in
fs/gfs2/lops.c:394:26: error: expected ';' before '{' token
  bio_for_each_segment_all(bvec, bio, i, iter_all) {
                          ^                        ~
                          ;

Caused by commit

  2b070cfe582b ("block: remove the i argument to bio_for_each_segment_all")

interacting with commit

  e21e191994af ("gfs2: read journal in large chunks")

from the gfs2 tree.

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 6 May 2019 14:57:42 +1000
Subject: [PATCH] gfs2: fix for "block: remove the i argument to bio_for_eac=
h_segment_all"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/gfs2/lops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 3b3dd2ef53f7..33ab662c9aac 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -388,10 +388,9 @@ static void gfs2_end_log_read(struct bio *bio)
 {
 	struct page *page;
 	struct bio_vec *bvec;
-	int i;
 	struct bvec_iter_all iter_all;
=20
-	bio_for_each_segment_all(bvec, bio, i, iter_all) {
+	bio_for_each_segment_all(bvec, bio, iter_all) {
 		page =3D bvec->bv_page;
 		if (bio->bi_status) {
 			int err =3D blk_status_to_errno(bio->bi_status);
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/gcMpqtS=NShUJ79kEyb321h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzPwPsACgkQAVBC80lX
0GwaqQf+Kb93aXAqHVmB3fNXzovRjENYa+yP4ysCuDIp+VjqvWM9OQicrMA4Ma44
DECEBder32fMiEMuj1m2SMt7+jYAxZbKvd7lg4EU+v2XLWPnFFrPLG4Vay7x3YM6
iqbzUi+AcDIIpuPKBta/o41KDWQLkI8MVMVAVbTNka0PKnMT9c20KeK77gi+rZMc
fg+imuEQgvztuYLS1+BpZAVxTpD4IQ+eJdTEIob9M9ZWMTibGWZ391C1YCSoOi4H
QmJXxx1XSnPOp7ivw0jESunwjBr/kwPglbqTxfiVg9E56zVI3Kw7HoWSQLlcxgvQ
jfTYQLR0MBJS6j1osKybBDFV7mefpA==
=CEyL
-----END PGP SIGNATURE-----

--Sig_/gcMpqtS=NShUJ79kEyb321h--
