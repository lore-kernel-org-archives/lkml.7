Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE358C48BE3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60572133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OvWH5QwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfFXHwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:52:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42827 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbfFXHwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:52:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XM2v2t7dz9s4Y;
        Mon, 24 Jun 2019 17:52:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561362760;
        bh=MEkWZxy8yWkkKdtyyG0r03VQogOTR4Q2scjrD0exlOM=;
        h=Date:From:To:Cc:Subject:From;
        b=OvWH5QwDyRRZ+oX410T3EgdKkOnWllxbh2n+Fqp0JRSZ1neQvB1GC5VGzQ3xzgv28
         lskIhsTmNr9UviuiogceJrqxAs8v6HqahQ/dmX/oY3W4a8cgoQtpfjMwCCh0cyrSUI
         vG5tc/zUIk9opfzxw/9lSPfVhMpAAga1VX0xmSdkjOupyAnyljX9SnY1Y/v3utGsCf
         iakShjlZi5ErcoDR9+DjeEQP+aAUvzDI7IFTzYgVIYQ7/jSqxoqeEouj/+ppXbzHs4
         /YqPS3Uf4xpwirHVBBiR/8iMeDwufPtdYOnMI2s9pUNq3rNCQVhxkMtncjw1bloMX3
         ArXalLj3xRmag==
Date:   Mon, 24 Jun 2019 17:52:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: linux-next: manual merge of the cgroup tree with the block tree
Message-ID: <20190624175238.5ce3db2f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VDHs3=S.BVa4PxjFRVw5N/I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VDHs3=S.BVa4PxjFRVw5N/I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cgroup tree got a conflict in:

  Documentation/block/bfq-iosched.txt

between commit:

  8060c47ba853 ("block: rename CONFIG_DEBUG_BLK_CGROUP to CONFIG_BFQ_CGROUP=
_DEBUG")

from the block tree and commit:

  99c8b231ae6c ("docs: cgroup-v1: convert docs to ReST and rename to *.rst")

from the cgroup tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/block/bfq-iosched.txt
index f02163fabf80,b2265cf6c9c3..000000000000
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@@ -537,10 -537,10 +537,10 @@@ or io.bfq.weight
 =20
  As for cgroups-v1 (blkio controller), the exact set of stat files
  created, and kept up-to-date by bfq, depends on whether
 -CONFIG_DEBUG_BLK_CGROUP is set. If it is set, then bfq creates all
 +CONFIG_BFQ_CGROUP_DEBUG is set. If it is set, then bfq creates all
  the stat files documented in
- Documentation/cgroup-v1/blkio-controller.txt. If, instead,
+ Documentation/cgroup-v1/blkio-controller.rst. If, instead,
 -CONFIG_DEBUG_BLK_CGROUP is not set, then bfq creates only the files
 +CONFIG_BFQ_CGROUP_DEBUG is not set, then bfq creates only the files
  blkio.bfq.io_service_bytes
  blkio.bfq.io_service_bytes_recursive
  blkio.bfq.io_serviced

--Sig_/VDHs3=S.BVa4PxjFRVw5N/I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QgUYACgkQAVBC80lX
0Gzuigf9FGi9hou12ZEtW6bqTOB1xUBIL3T/EiVcNF9qPdMaxCCNZC9iw+oTvV+m
HVQsqjXgHRIphIkHuBAMdhTn7TKnGCxvKK4tboSuCrxy+PG+YFCT5h/Cqt22QVq+
ldF2irMDPV4zGmzVSxFjACKpmxEOb9D0ozUafjqSyKjqppAXUtziMXXPu0ID1RsG
TtumF8aIZXk+oQUMsZszNYrx14/4EhM/4ol3TNr6SyLDMVIAWiBQKm4AIMAHx+BQ
WINHBalWn0eS+eXeKGq2FUCcadQfNr+kdkUS+kcRMzVY3v61k1VjcpeBTi0F7GsA
XLiP7n5j2YNP3UAjzD8qwT/7XIjk2g==
=4vKo
-----END PGP SIGNATURE-----

--Sig_/VDHs3=S.BVa4PxjFRVw5N/I--
