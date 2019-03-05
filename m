Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42FA206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kNg4SHnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCEBs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:48:56 -0500
Received: from ozlabs.org ([203.11.71.1]:59819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCEBsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:48:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44D0DN4JjSz9s7T;
        Tue,  5 Mar 2019 12:48:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551750533;
        bh=ShQgTQjeKlxD37ib0onlL7JECSZ9Q7K1RPkhFVHxko8=;
        h=Date:From:To:Cc:Subject:From;
        b=kNg4SHnDBiqwFWQzUnD1YXP4E+pPWASGL/scTdWQB6P0H4T4QRXhnZHtNAyTJt9Uw
         QQdf0oqGShze/bqtuVcte+aEP/g6Y+b6i/4NnSZNi/G3AqSxBtnDuCfEZ93hCARSSk
         8H7SPgtN8STSIK9hhpLlV+cDfHgKCd/Xq9MAU1AEQhjLrBY0oaHkbC8hy5AFDdSkES
         hdTaWyR0J+ZiZSOjy16e3o418Vlhz2HvFx+SsyEmT/HTzVdk4dKhBnHf7pT+JCHhI9
         nHGX6MQrpNcyESFpwSaguGWf6HIHMyFL3HCvMrSnMIdVfkZDjcD6HPvffvvSBOcRfp
         FymfmkKHjkr5g==
Date:   Tue, 5 Mar 2019 12:48:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the block tree with Linus' tree
Message-ID: <20190305124844.05e44755@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B5zHwxVW_bqVsvYOIvnbPs/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B5zHwxVW_bqVsvYOIvnbPs/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  include/linux/fs.h

between commit:

  84c4e1f89fef ("aio: simplify - and fix - fget/fput for io_submit()")

from Linus' tree and commit:

  fb7e160019f4 ("fs: add an iopoll method to struct file_operations")

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

diff --cc include/linux/fs.h
index 76c7205d4f0d,80e1b199a4b1..000000000000
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -317,9 -310,8 +317,10 @@@ struct kiocb=20
  	int			ki_flags;
  	u16			ki_hint;
  	u16			ki_ioprio; /* See linux/ioprio.h */
+ 	unsigned int		ki_cookie; /* for ->iopoll */
 -} __randomize_layout;
 +
 +	randomized_struct_fields_end
 +};
 =20
  static inline bool is_sync_kiocb(struct kiocb *kiocb)
  {

--Sig_/B5zHwxVW_bqVsvYOIvnbPs/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx91XwACgkQAVBC80lX
0Gwb7AgAkCdTqpNCAv5Yaw+AQSwC74X/Iwl6PW20EwP8FpHsjomppf/C+Vf0qhMM
GPZJTyVlhQGASo/aRtQBQ80garQQY45CiXvqivgQe2cKyH6nuvdEfyvYmc42vEn3
u3WYLpdmBaXKOZvUXEp+hqtIngGz2aT3tVo4Vkgy+U6JTFJJZ50yf0sqlBhnqFzH
EXnHbM2GzOYFP0xW5HAEtrdgq61mhfBNZPGNlK6If25SU9mmAHFbuMp7pwV51AXO
OZ46SkmSKFlinv0KLa6Xm2OndQRnr0oDt6/KWdwTue0jjX32G4CHcnVLa9q3ml+h
09q5ziPSK78ifcUXp/tOoO373rPAbg==
=xU3a
-----END PGP SIGNATURE-----

--Sig_/B5zHwxVW_bqVsvYOIvnbPs/--
