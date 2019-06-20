Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA756C48BE0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E542080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iogtbNTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbfFTCGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:06:45 -0400
Received: from ozlabs.org ([203.11.71.1]:38631 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfFTCGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:06:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TlYY6Kgcz9s5c;
        Thu, 20 Jun 2019 12:06:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560996401;
        bh=SQXJ7gG6M2UUcliCziXzEpGOzPbxFfd06GTVc+nkWek=;
        h=Date:From:To:Cc:Subject:From;
        b=iogtbNTRYNCtPDVkk20sU3TO4H0nGlrfGf0SQS071srKVWOiKV0vVmVrGCLRQJ/Cq
         mlaNsVSlCDoD17l52OxHEibWamEHy9TsyDF5IWRd3RqZngqk/P+d061gjlhzaAAOkj
         qMxXejqFgklprmB8VXQZHe2nsUpkZN/gKxRnsUK5nyBpEqZEq6n9uLusAp6NRCq5cA
         wNUT4O7sdb+pwWe2lKHzQ2WeDPZJPJvCPACYLteSCsVUSlXeBSMM3g9zOIPAeHtsdA
         1CNKFLunVJCcAP2C/+r3dV/Jbs+dZB+TiYYbLZj3tO5JtcYBTvPG8i7VBJSe+Z3MaK
         Q6Xe6I3moGRWA==
Date:   Thu, 20 Jun 2019 12:06:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: linux-next: manual merge of the rdma tree with Linus' tree
Message-ID: <20190620120640.5dbcc599@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U+fnxZlKklAnbeOwIoLHtwa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U+fnxZlKklAnbeOwIoLHtwa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  include/rdma/ib_verbs.h

between commit:

  dc1435c00fcd ("RDMA/srp: Rename SRP sysfs name after IB device rename tri=
gger")

from Linus' tree and commit:

  0e2d00eb6fd4 ("RDMA: Add NLDEV_GET_CHARDEV to allow char dev discovery an=
d autoload")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/rdma/ib_verbs.h
index 54873085f2da,6f09fcc21d7a..000000000000
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@@ -2698,7 -2690,9 +2690,10 @@@ struct ib_client=20
  	const char *name;
  	void (*add)   (struct ib_device *);
  	void (*remove)(struct ib_device *, void *client_data);
 +	void (*rename)(struct ib_device *dev, void *client_data);
+ 	int (*get_nl_info)(struct ib_device *ibdev, void *client_data,
+ 			   struct ib_client_nl_info *res);
+ 	int (*get_global_nl_info)(struct ib_client_nl_info *res);
 =20
  	/* Returns the net_dev belonging to this ib_client and matching the
  	 * given parameters.

--Sig_/U+fnxZlKklAnbeOwIoLHtwa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0K6jAACgkQAVBC80lX
0Gzwywf/ZPPUWpZKze62xyMeUG0TAes1MlkoFIr87x45g0Xvqll0elRqZgFjkRsb
iJSCdZknEfO6mdW4YR4XNCxZikxOcA6ptcCX/Ph7Xst8f2XFikVhp8545XYmKGKU
1IoGxqXt5mTT3hYJ2zd7+0B00YaItOvVIG2yH40en1q11CyeJ2Hf3P8ewwwoqW18
fQBDZd0LnsttEveqtDT5jeTCTWE7f9FAzU7SDAccok0ExONxEaUcvUWsrakIJXon
eKErHaRqCtjxijGZPAEr/KunQAZiD8H1IDnES+rlARpUwxDIeNejcQYub0fw4tkU
Hi/TMtXWZWN08Nb1SQJczsooyScWMA==
=CDtS
-----END PGP SIGNATURE-----

--Sig_/U+fnxZlKklAnbeOwIoLHtwa--
