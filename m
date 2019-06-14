Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBA6C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658D720866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P2lgc1lC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfFNJGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:06:09 -0400
Received: from ozlabs.org ([203.11.71.1]:40073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFNJGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:06:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45QF8F5N3Zz9s9y;
        Fri, 14 Jun 2019 19:06:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560503166;
        bh=brxI8gMCmmu5kmwmOow/Lu58yc3Qc6LCPB/ETmJ1N2s=;
        h=Date:From:To:Cc:Subject:From;
        b=P2lgc1lCcbkkx3NFFwsHESPCidP3NVhzDITqlUSUVRfJjkyAvwGMroDPkvyosAmF1
         sKI8nzi2ZLMQrdRwxU0xZJ8WlC33CLThffMz/RZkd5sWeSUJ0rkurLL2ULyY0OzphX
         X+XbjclHhY0Tv3LwPZQOFPjPtVKmUmvn3IIbrtl0XhaO4Etr/l3om7+vSs+SzZKSFw
         cxalYzDJKfbRrBRoqqH+Lc82iqJjxqew6ZkHEoS5gNVUZPLFNiaTGRnoBpYuhGzZS2
         IKMxcg7lpYFhVFSqwWO7dr3c8EyTmbr9dUBXYa8TosEU9jgcD2EeYQXkL+c2P0tn3K
         HrN+hvEdhqXjw==
Date:   Fri, 14 Jun 2019 19:06:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@snapgear.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        YueHaibing <yuehaibing@huawei.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 m68knommu tree
Message-ID: <20190614190606.559dc8dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pX1EuH4MD3ui+PBuMS7nKLY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pX1EuH4MD3ui+PBuMS7nKLY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  fs/binfmt_flat.c

between commit:

  6071ecd874ac ("binfmt_flat: add endianess annotations")

from the m68knommu tree and commit:

  db543c385059 ("fs/binfmt_flat.c: remove set but not used variable 'inode'=
")

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

diff --cc fs/binfmt_flat.c
index 80d902fb46e3,7562d6aefbe4..000000000000
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@@ -429,9 -415,7 +429,8 @@@ static int load_flat_file(struct linux_
  	unsigned long textpos, datapos, realdatastart;
  	u32 text_len, data_len, bss_len, stack_len, full_data, flags;
  	unsigned long len, memp, memp_size, extra, rlim;
 -	u32 __user *reloc, *rp;
 +	__be32 __user *reloc;
 +	u32 __user *rp;
- 	struct inode *inode;
  	int i, rev, relocs;
  	loff_t fpos;
  	unsigned long start_code, end_code;

--Sig_/pX1EuH4MD3ui+PBuMS7nKLY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0DY34ACgkQAVBC80lX
0Gw/Owf8DKYzSweFuZJO/29VaTNugoe7A7RPQ3pdNgzARAUSANF5wTQcE1Cq3vp6
KaANvXkg8OiScbrVqZek4Kps2U5EkG/zDeX1cXwCX3bbrg9YukXUWCvNbJjLXRBq
IG0lqObzX/7kr3hZIjao1Lnv9Hoko8rBW6+rRpGD29kfblpVLn/f4U0pGYKAAOBR
o/uaG7Fqup2QyxOkjb+2TU0GHNF7kz9lX00v+JfliFc8VtNMF+A/p+VCSobTKt9G
PCrFURKd/PdzLegOODnMkoSMFIdBIfGplYpGqFds58w/gSB4aYZiIcVPfCyfky2P
X+MBcy2iuAc5reo41ZzDBhGjNo7Xrw==
=8dg1
-----END PGP SIGNATURE-----

--Sig_/pX1EuH4MD3ui+PBuMS7nKLY--
