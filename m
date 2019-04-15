Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AACC10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7158C21473
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pEpd3TxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfDODGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 23:06:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34941 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfDODGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 23:06:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jD0g1Ccgz9s0W;
        Mon, 15 Apr 2019 13:06:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555297572;
        bh=0ykiVWvQy0kVCQjQbOXBXXBNW2ew5lv9aSRv+xw+CFA=;
        h=Date:From:To:Cc:Subject:From;
        b=pEpd3TxUxlNgrruvxVv6deBSHWtAiljXTGmzlHwGq+8ecA9r9lEkfrFEKJbFnSE7D
         s5SDc2THWkDQQjJIVvT3KhJaBrLLSABRavDyjTdHQLkjzJDqA9PhNEi4S9hOOi2ZDd
         Lq580cMyiWUnFCMEwxlq7GrKQWk12xBY8MIvCVJpdoc15cRzGcZSr4jChTJd7x5vSR
         xAKMXiMxCFXLnls07AHaChEVZ/ebAB8ZBFIhW+F68kKJS823DAyONQXm8UkdgFLLJF
         tsPXRnrpmpz+2d/mSo3HXY0a978vrduOKlrwYdnCqMFzN1hGd83T1aKNjfruGnr22L
         U79P2D7CF4WAQ==
Date:   Mon, 15 Apr 2019 13:06:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the block tree with Linus' tree
Message-ID: <20190415130608.02fabb3e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=J8r8IqDgri+FzYRlvZxeQ7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=J8r8IqDgri+FzYRlvZxeQ7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  include/linux/bvec.h

between commit:

  1200e07f3ad4 ("block: don't use for-inside-for in bio_for_each_segment_al=
l")

from Linus' tree and commit:

  52d52d1c98a9 ("block: only allow contiguous page structs in a bio_vec")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/bvec.h
index 3bc91879e1e2,44b0f4684190..000000000000
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@@ -156,8 -151,8 +151,8 @@@ static inline void bvec_advance(const s
  {
  	struct bio_vec *bv =3D &iter_all->bv;
 =20
 -	if (bv->bv_page) {
 +	if (iter_all->done) {
- 		bv->bv_page =3D nth_page(bv->bv_page, 1);
+ 		bv->bv_page++;
  		bv->bv_offset =3D 0;
  	} else {
  		bv->bv_page =3D bvec->bv_page;

--Sig_/=J8r8IqDgri+FzYRlvZxeQ7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyz9SEACgkQAVBC80lX
0Gxv8Qf9HviITxbq1Z99gQvQYXLk/ueVvIET4kSn0+uHxpmVPv2VGvYzhxJSeTrM
qXNk3LhSDkK5hsRppwZVUr046VW730r2ZgFZM/kwsyJidlf1BPhLJP8r7H6quGN6
ROloInRb0awkKlYfl0UjMkWnmFvQnStyu2IkL8cW7rhTPt4fgUXGB/2sfTZw+g/J
Iqj/f/XPufg4AsuZ+HlElg5+pMKRNB13eg4Go46wUlRqujdF9dGMm6wwA0uG43SN
kKUvRA568jhn0kkFwCikQ0kZw1/ncAxYNDzPrx09YNoLtz/1s5mpi9Kn7Ri9gzyf
AZJnqjze2CIV9x2jo0VfwmBtl6qKaw==
=z3TK
-----END PGP SIGNATURE-----

--Sig_/=J8r8IqDgri+FzYRlvZxeQ7--
