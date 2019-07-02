Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95233C0650E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6512321721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fqdIMhxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGBDIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:08:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36645 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfGBDIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:08:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45d8MK3zhKz9s3Z;
        Tue,  2 Jul 2019 13:08:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562036909;
        bh=b+pxQIHEwABrogiJc5St+07sp0mTOhDIyp585ZClwlg=;
        h=Date:From:To:Cc:Subject:From;
        b=fqdIMhxjfHobGOSwMF30nwNL90Ufd75otaArEqsJ3tThJdnhNR0f8chYVdj4eD7NB
         VH3MgZAFTko55Z7v3xkhe0kppqBYYhVohQdgjHqIutYzAGB3QsZr0+nnCbL2iYz9WV
         v769UXPhuzOB7NMOWIWHizVlkm1DCzcaDGuvXGv4LKZ6XP+BIVMQ43Lw3Wb7h9aCxF
         X+84Iso8DMr4WjFJ/YQ0rqn9FZPzUxfErER7L/ep3H5mAam0IAJ7yoYoCqLGshs2o/
         I1lgEiR9bmlXV6vDivF8nofypbHBVMcf3nAKsYJO89JECUz+g90V0rR5acHUMdc1Dh
         9G6j7ukLkCfRQ==
Date:   Tue, 2 Jul 2019 13:08:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Bodong Wang <bodong@mellanox.com>
Subject: linux-next: manual merge of the mlx5-next tree with Linus' tree
Message-ID: <20190702130828.5f2f7f4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MnKInLvmYLmnZ=2ThzO1.yq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MnKInLvmYLmnZ=2ThzO1.yq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mlx5-next tree got conflicts in:

  drivers/net/ethernet/mellanox/mlx5/core/eswitch.c

between commits:

  02f3afd97556 ("net/mlx5: E-Switch, Correct type to u16 for vport_num and =
int for vport_index")

from Linus' tree and commit:

  5f5d2536be8d ("net/mlx5: E-Switch, Use correct flags when configuring vla=
n")

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

diff --cc drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 67e76979bb42,89f52370e770..000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@@ -1552,7 -1552,8 +1552,8 @@@ static void node_guid_gen_from_mac(u64=20
  static void esw_apply_vport_conf(struct mlx5_eswitch *esw,
  				 struct mlx5_vport *vport)
  {
 -	int vport_num =3D vport->vport;
 +	u16 vport_num =3D vport->vport;
+ 	int flags;
 =20
  	if (esw->manager_vport =3D=3D vport_num)
  		return;

--Sig_/MnKInLvmYLmnZ=2ThzO1.yq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ayq0ACgkQAVBC80lX
0GxcPQgAlQYGwrpY5OgM1JDKJQeTwI8Sc80eTB2OFsxDRBNniRKS4MYFtekVm13a
YmlXmP/LdQWhs6ie61s92/A68fzVBqM8zRg34ZizKfUdvDBC+KDs4VBSLBTBEvs6
05kZA5BpeZnfTKaJUKF0nHJVvXJIRRWUErChC2B7mE4PEXon17AYZ1LwR5Lqs1JE
WvtYs9V2fwJP9SIbvOxMmsqF7K0am23+3QRDKe27XYhDuXCpgGHUCHbkkJBtPxFL
S6Vc100n3de++Gw5PDwkvq9uIwKB+gpK/iKsmq56MnaaV1bmell2wY6eVFWznnHX
A0MShSj9PVkmUdS+FhHmpivWCzSFWw==
=HxpG
-----END PGP SIGNATURE-----

--Sig_/MnKInLvmYLmnZ=2ThzO1.yq--
