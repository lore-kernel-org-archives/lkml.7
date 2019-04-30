Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C163C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423462173E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ql4MxagX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfD3D6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 23:58:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730060AbfD3D6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:58:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tSSQ6DQFz9s9T;
        Tue, 30 Apr 2019 13:58:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556596727;
        bh=60QoE5PheWPk3/TqzSOXTiJAWSvXWl0GYLdzDyHstQY=;
        h=Date:From:To:Cc:Subject:From;
        b=Ql4MxagXKHDfXXVyThUhuznJ6iDnG4RueD1UZakXM9D6iHi+RmFI0KzSO61B/oV91
         lK87Lxic5SaE3nRzMLmEylVhPSOl6O+aOlUuaG5D9PgNYW5WEjPxTtbOoeu64e73y3
         h7mZdXVlDKySKDIC8BLyeyefa/zUBUqZkyGttbpSgCxbBWd+9+w67MB//uvTGpFUZk
         R+4bVWxWwwiRh52jru0/T8yAJz2/3gFmhj9P6UhZDmVzUO51+14df9xUkuuSKO1APT
         9hlRgtZdu/Fe+6McZxnObt0VVfahmBi3bhjR4/u9biTu1MnUbpa20POZgEYDoKEECU
         9mgTExLWVOFqA==
Date:   Tue, 30 Apr 2019 13:58:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vu Pham <vuhuong@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Mark Bloch <markb@mellanox.com>
Subject: linux-next: manual merge of the mlx5-next tree with the rdma tree
Message-ID: <20190430135846.0c17df6e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/x6h10r0CWB.mHV.8Wd_JDuP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x6h10r0CWB.mHV.8Wd_JDuP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leon,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  drivers/infiniband/hw/mlx5/main.c

between commit:

  35b0aa67b298 ("RDMA/mlx5: Refactor netdev affinity code")

from the rdma tree and commit:

  c42260f19545 ("net/mlx5: Separate and generalize dma device from pci devi=
ce")

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

diff --cc drivers/infiniband/hw/mlx5/main.c
index 6135a0b285de,fae6a6a1fbea..000000000000
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@@ -200,12 -172,18 +200,12 @@@ static int mlx5_netdev_event(struct not
 =20
  	switch (event) {
  	case NETDEV_REGISTER:
 +		/* Should already be registered during the load */
 +		if (ibdev->is_rep)
 +			break;
  		write_lock(&roce->netdev_lock);
- 		if (ndev->dev.parent =3D=3D &mdev->pdev->dev)
 -		if (ibdev->rep) {
 -			struct mlx5_eswitch *esw =3D ibdev->mdev->priv.eswitch;
 -			struct net_device *rep_ndev;
 -
 -			rep_ndev =3D mlx5_ib_get_rep_netdev(esw,
 -							  ibdev->rep->vport);
 -			if (rep_ndev =3D=3D ndev)
 -				roce->netdev =3D ndev;
 -		} else if (ndev->dev.parent =3D=3D mdev->device) {
++		if (ndev->dev.parent =3D=3D mdev->device)
  			roce->netdev =3D ndev;
 -		}
  		write_unlock(&roce->netdev_lock);
  		break;
 =20

--Sig_/x6h10r0CWB.mHV.8Wd_JDuP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzHx/YACgkQAVBC80lX
0Gzdcwf/TE5ogvk+bySoFuMFWxuO8ThJFKEgBwtNn3z3FV1lPop11h70cpNlLj0G
2ZHQE5KFv3hos740rD/WELzVBnJUjPndb4OPV3VtRj0WAdiI1XemQ7i5Jf87j6yd
LnpbcwtAF9jV2wjhJh5o9btd3RfqMpP4FDl6ew7PT5lMqcbyP+bBuWHScCsvW0jj
pT7xo3Pf6zwfxiJoRlVRt1aW9QR1XJPIaxAKna5PKrvYRo1Y2Q00KU7yJv0ub8WB
xfZJT6l8+Fa/jfqaZHHXZ8G9n16GHgYvq+6+OxkVYW4tIjRWgq1dwRAFja3M92up
EESHkiDITShEDV5vj04TQnCMGfORsQ==
=0oRm
-----END PGP SIGNATURE-----

--Sig_/x6h10r0CWB.mHV.8Wd_JDuP--
