Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CB9C74A45
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A01620872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TmF19Edy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfGKFPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 01:15:11 -0400
Received: from ozlabs.org ([203.11.71.1]:39323 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfGKFPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 01:15:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45kklJ4BVfz9sBt;
        Thu, 11 Jul 2019 15:15:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562822108;
        bh=A15oo3lnPBgimcgWn2uZygbu1s4lzeQ81MYn/Qa33K4=;
        h=Date:From:To:Cc:Subject:From;
        b=TmF19EdyXP1K7C9nH/XuS3+7l8a+wYFgFHCLK1/OFJzTaS8X5OwRcW6PQH8VWMYPH
         0ShbiCyAOToFRs2xMQv9TgVNBobfTkv1v2h94Z3XnhimtHva4gaWXT8kpTnM8x5GT8
         veSzwLRQi2PXlEJWxyqQ+VlBkDuT2OgkXUF786L86tFnV3TSV4KdGA5sbLf9glAe1m
         tAnKquVK8OiPr1ZSz/1NEouSpuFNK7m7+MgvMyet9pwN9XatvQs4VSkHYz/PO55+uh
         h0xFwAqdUwZqChuK3L01LAWTbtrvB/6rdNYNWGkd3Yu8poKZE8wSUWWd9pmh5qoHHQ
         EF76t3vJDBgxw==
Date:   Thu, 11 Jul 2019 15:15:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20190711151507.7ec1fd18@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fQ6oCqxHszi+mJrDNm=bKkS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fQ6oCqxHszi+mJrDNm=bKkS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/f2fs/data.c: In function 'f2fs_merge_page_bio':
fs/f2fs/data.c:516:3: error: implicit declaration of function 'wbc_account_=
io'; did you mean 'blk_account_rq'? [-Werror=3Dimplicit-function-declaratio=
n]
   wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
   ^~~~~~~~~~~~~~
   blk_account_rq

Caused by commit

  34e51a5e1a6e ("blkcg, writeback: Rename wbc_account_io() to wbc_account_c=
group_owner()")

interacting with commit

  8648de2c581e ("f2fs: add bio cache for IPU")

from the f2fs tree.

I added the following merge fix patch or today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 11 Jul 2019 15:13:21 +1000
Subject: [PATCH] f2fs: fix for wbc_account_io rename

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 323306630f93..4eb2f3920140 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -513,7 +513,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	}
=20
 	if (fio->io_wbc)
-		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
+		wbc_account_cgroup_owner(fio->io_wbc, page, PAGE_SIZE);
=20
 	inc_page_count(fio->sbi, WB_DATA_TYPE(page));
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/fQ6oCqxHszi+mJrDNm=bKkS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0mxdsACgkQAVBC80lX
0Gyumgf/UyFml7MpbpYLD24HTtwSzldMXQGaillCox1LdkDuLoyaoFD46ik8w8Ob
Jsf9tsY7i6Qa/UxLdyeQ9d5VmHXvvCMHr3m9EoT7pD6D3GHGnzZrl1dtJ1pk6gr5
MfuWjM4nfBL6dRkfk9ncExi6bE7SpnReh5Om2+RfyVuHhKwfcqSLoiR2BoZZbSkI
/6IsAbypmqJMz2R80C7jcHC4a6UhW7d+Ec6zFGTC6l2OKxOEmcOZI+QDtOcHG1pJ
wh81kfAYZvJtC2TeIEVWrZZIERFDxiQZg/cty+BfZ4XNQKeMVohVVNHi1pZSy01Q
U3zzmRxikc0gFLdKUHUmRnONb9P5jw==
=yale
-----END PGP SIGNATURE-----

--Sig_/fQ6oCqxHszi+mJrDNm=bKkS--
