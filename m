Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABD8C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D3B2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YiGOffgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfGDCrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:47:41 -0400
Received: from ozlabs.org ([203.11.71.1]:49351 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfGDCrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:47:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fMpL5xkVz9s8m;
        Thu,  4 Jul 2019 12:47:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562208458;
        bh=GVe4xrn2rOWFVcjZMJTJ2pwArPRGQ7EWoXRAyNj6knY=;
        h=Date:From:To:Cc:Subject:From;
        b=YiGOffgR/+4nR6IKGpQAxRNzGJG1jxoFiqD/4isKY5EgN4zec40nvKEhchD6t2M0v
         H/bdAGsif9c3/thrfKLllL9GU3lpihZiUy/Fabx3UXasyVUazkevGZ5u6dBLZJ9MZh
         zuBBT4sdeqkTKqhQ4xxLQJ8jD8F14dL/gXyrix6AQtOdHt34ruv9YL95jM7yfuIN3D
         6gVXiXr45xh32W0AxF5BsVP3Z4z17XigtPbaRcC7Yc76zJUaDoPQoym+jBa/Csqydk
         7B0OGAnVM7xxVVa5+7VYw4TkjWFTs83kdjKMkkNgAiJM0/Tpg5mLjMtJzgCyfKmizG
         TJwsyMV7i500g==
Date:   Thu, 4 Jul 2019 12:47:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: linux-next: manual merge of the mlx5-next tree with the rdma tree
Message-ID: <20190704124738.1e88cb69@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Kw=JJxg7OagalCIGq8.vbuP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Kw=JJxg7OagalCIGq8.vbuP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  drivers/infiniband/hw/mlx5/cq.c

between commit:

  e39afe3d6dbd ("RDMA: Convert CQ allocations to be under core responsibili=
ty")

from the rdma tree and commit:

  38164b771947 ("net/mlx5: mlx5_core_create_cq() enhancements")

from the mlx5-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/hw/mlx5/cq.c
index bfe3efdd77d7,4efbbd2fce0c..000000000000
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@@ -891,7 -891,8 +891,8 @@@ int mlx5_ib_create_cq(struct ib_cq *ibc
  	int entries =3D attr->cqe;
  	int vector =3D attr->comp_vector;
  	struct mlx5_ib_dev *dev =3D to_mdev(ibdev);
+ 	u32 out[MLX5_ST_SZ_DW(create_cq_out)];
 -	struct mlx5_ib_cq *cq;
 +	struct mlx5_ib_cq *cq =3D to_mcq(ibcq);
  	int uninitialized_var(index);
  	int uninitialized_var(inlen);
  	u32 *cqb =3D NULL;

--Sig_/Kw=JJxg7OagalCIGq8.vbuP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0daMoACgkQAVBC80lX
0Gy14AgAlHFOm16bEAUrmZltrSXr6+Rt2jBud18OPAcIhwSQ1HFmj7L6vVE6pD5Y
Wnm4xUuwNkaCZAdSWGID6cJjjOCaYwzPL+eZNpYsyvvauQLq/IqJmPTX90zZNGUL
owSu6JL57Hg2YnBX9qkduS+0qWY64HKZrqaheDNpo0r1qzY6wLk+Qz3LvB9E2FOu
mCjNf4HOMlaN3SYR8jlggODS4PTPvXqVpxd6qxg5P9fnT/E6mgBPpsDNcAIrZ0w4
GRlCpYvABoFgmXdooox7o/YDO1HyY4EkHIxpbFa2vhwilhX1LHBy59Q1PbQr6mnw
73uk32OliVCJpI/v06f6s7HZmvhULg==
=Nzdt
-----END PGP SIGNATURE-----

--Sig_/Kw=JJxg7OagalCIGq8.vbuP--
