Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433E4C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 09:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE42206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 09:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PWCoM0k2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfECJKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 05:10:39 -0400
Received: from ozlabs.org ([203.11.71.1]:55695 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfECJKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 05:10:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wRDq2SBFz9s7T;
        Fri,  3 May 2019 19:10:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556874635;
        bh=OHrQnwt0Q+cyG0LJi49DTjxDdYF1gnPSBeIM2Vpb0NE=;
        h=Date:From:To:Cc:Subject:From;
        b=PWCoM0k2XwMQEAtQplF+QXOtZWyJdWWAekVLel19/7Qh19Hs1ArHUhLo5rRcR1Vq4
         i6R3u4XOPbsi00l5I1ms0vOos8/H+LP4DtB3sxkUPEXK15Xucf4zpaF2Vlsjfkn8iZ
         pBErVlexxTxNXGKTcv1r5SFh9pub/PTvoZclGlAmxpt59hgRFkZpGOINjs7vZ/qaKH
         Yk6H8latJ3jqzkcZxvk1X85mSVDTrsDz2lAD/FJvd9l5ZmBxpFyUyATFKRfHYG3Sbv
         TERCQ8KNghToRyW0g7EArTBOnptUnDZphwM0HOzF7ZkWvH8PpS62mlRGWTDgUOWoLs
         Y1sbJXfr+XJOA==
Date:   Fri, 3 May 2019 19:10:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: linux-next: manual merge of the akpm-current tree with the block
 tree
Message-ID: <20190503191033.6c56e4c0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/50NvD80NcihNTNGKrEpz2Nq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/50NvD80NcihNTNGKrEpz2Nq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  fs/sync.c

between commit:

  22f96b3808c1 ("fs: add sync_file_range() helper")

from the block tree and commit:

  9a8d18789a18 ("fs/sync.c: sync_file_range(2) may use WB_SYNC_ALL writebac=
k")

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

diff --cc fs/sync.c
index 01e82170545a,9e8cd90e890f..000000000000
--- a/fs/sync.c
+++ b/fs/sync.c
@@@ -292,10 -348,16 +292,16 @@@ int sync_file_range(struct file *file,=20
  	}
 =20
  	if (flags & SYNC_FILE_RANGE_WRITE) {
+ 		int sync_mode =3D WB_SYNC_NONE;
+=20
+ 		if ((flags & SYNC_FILE_RANGE_WRITE_AND_WAIT) =3D=3D
+ 			     SYNC_FILE_RANGE_WRITE_AND_WAIT)
+ 			sync_mode =3D WB_SYNC_ALL;
+=20
  		ret =3D __filemap_fdatawrite_range(mapping, offset, endbyte,
- 						 WB_SYNC_NONE);
+ 						 sync_mode);
  		if (ret < 0)
 -			goto out_put;
 +			goto out;
  	}
 =20
  	if (flags & SYNC_FILE_RANGE_WAIT_AFTER)
@@@ -305,68 -369,6 +311,71 @@@ out
  	return ret;
  }
 =20
 +/*
-  * sys_sync_file_range() permits finely controlled syncing over a segment=
 of
++ * ksys_sync_file_range() permits finely controlled syncing over a segmen=
t of
 + * a file in the range offset .. (offset+nbytes-1) inclusive.  If nbytes =
is
-  * zero then sys_sync_file_range() will operate from offset out to EOF.
++ * zero then ksys_sync_file_range() will operate from offset out to EOF.
 + *
 + * The flag bits are:
 + *
 + * SYNC_FILE_RANGE_WAIT_BEFORE: wait upon writeout of all pages in the ra=
nge
 + * before performing the write.
 + *
 + * SYNC_FILE_RANGE_WRITE: initiate writeout of all those dirty pages in t=
he
 + * range which are not presently under writeback. Note that this may bloc=
k for
 + * significant periods due to exhaustion of disk request structures.
 + *
 + * SYNC_FILE_RANGE_WAIT_AFTER: wait upon writeout of all pages in the ran=
ge
 + * after performing the write.
 + *
 + * Useful combinations of the flag bits are:
 + *
 + * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE: ensures that all pa=
ges
-  * in the range which were dirty on entry to sys_sync_file_range() are pl=
aced
++ * in the range which were dirty on entry to ksys_sync_file_range() are p=
laced
 + * under writeout.  This is a start-write-for-data-integrity operation.
 + *
 + * SYNC_FILE_RANGE_WRITE: start writeout of all dirty pages in the range =
which
 + * are not presently under writeout.  This is an asynchronous flush-to-di=
sk
 + * operation.  Not suitable for data integrity operations.
 + *
 + * SYNC_FILE_RANGE_WAIT_BEFORE (or SYNC_FILE_RANGE_WAIT_AFTER): wait for
 + * completion of writeout of all pages in the range.  This will be used a=
fter an
 + * earlier SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE operation to=
 wait
 + * for that operation to complete and to return the result.
 + *
-  * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT=
_AFTER:
++ * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT=
_AFTER
++ * (a.k.a. SYNC_FILE_RANGE_WRITE_AND_WAIT):
 + * a traditional sync() operation.  This is a write-for-data-integrity op=
eration
 + * which will ensure that all pages in the range which were dirty on entr=
y to
-  * sys_sync_file_range() are committed to disk.
++ * ksys_sync_file_range() are committed to disk.  It should be noted that=
 disk
++ * caches are not flushed by this call, so there are no guarantees here t=
hat the
++ * data will be available on disk after a crash.
 + *
 + *
 + * SYNC_FILE_RANGE_WAIT_BEFORE and SYNC_FILE_RANGE_WAIT_AFTER will detect=
 any
 + * I/O errors or ENOSPC conditions and will return those to the caller, a=
fter
 + * clearing the EIO and ENOSPC flags in the address_space.
 + *
 + * It should be noted that none of these operations write out the file's
 + * metadata.  So unless the application is strictly performing overwrites=
 of
 + * already-instantiated disk blocks, there are no guarantees here that th=
e data
 + * will be available after a crash.
 + */
 +int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 +			 unsigned int flags)
 +{
 +	int ret;
 +	struct fd f;
 +
 +	ret =3D -EBADF;
 +	f =3D fdget(fd);
 +	if (f.file)
 +		ret =3D sync_file_range(f.file, offset, nbytes, flags);
 +
 +	fdput(f);
 +	return ret;
 +}
 +
  SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
  				unsigned int, flags)
  {

--Sig_/50NvD80NcihNTNGKrEpz2Nq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzMBYkACgkQAVBC80lX
0GxNMwf/Qu+4OIxyC18LTMWiLlq/v2yt//xaEHH3u8b0ZI3i8IWdw0RQ/BUWDyHr
AWSuSnoS6NNxL0dN5a8TxtEuRwz+0bDosc8McDv4DvyPNU4EByq4BQR7vqoif97G
GDCX+rlb2Toa+ZbSwePvxvWTxqTi36OxoQ/4Okr8tASkjsd/j2nwU3LySjA8QBdR
jCIVQwdxt4gglBXrhUNIJSIO3stAKJjHtrDSLAIhxz80eC5D9R3oswoJMQ5IzYhX
9u0Dj0qNae951Xnm/s0Z9hNRs4Zq3POJJoHQo3BGvPQD7QpdyYZWGAABdtzst33U
LA94Y7DRU1eG+ouiNGUvY6RHzj6KgA==
=29qT
-----END PGP SIGNATURE-----

--Sig_/50NvD80NcihNTNGKrEpz2Nq--
