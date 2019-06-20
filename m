Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E6C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F407620B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SblfIPUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfFTDF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 23:05:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43439 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfFTDF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:05:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TmsJ0ZLQz9s4Y;
        Thu, 20 Jun 2019 13:05:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560999924;
        bh=QaFCNX3OUowNfBv/P8OXlaNhXbceCmWNBURqyz3+3vk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SblfIPUmgcDiTRpZ6z6MK4oxViUQ6bAsWSKakSVmbZbNdP8mn5dJb/ntKwr3kKx8S
         Y4nIxOoh6aML54HxAGaLwLXwDsKYbfi+9A3/iLW5OsswJJsW/6J5MVS6NaXL/eVorz
         2NbC2sOy2Y4Y12rr4zQaPiVXXbZn3a1GGgbyOiPP4i4ATbnXn3998+ULTiJpg6SbBb
         OiVnbOo3nfztkND4YeNWxnUMcy3qlNeZ5nXF+7F91JCJn3n8kWbFaoksgyyxWktTki
         UbL/iz7Lc5y4fR/Qhpl3gNGSjQSXVRz0h2+/pQ8JPKUAqVKcPiNE37WqyQKI8+jg/V
         CXdur/htfM+8g==
Date:   Thu, 20 Jun 2019 13:05:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with Linus' tree
Message-ID: <20190620130523.176d4ca5@canb.auug.org.au>
In-Reply-To: <20190617121959.55976690@canb.auug.org.au>
References: <20190617121959.55976690@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/euKSa5GIot+P+XpVrVMRuyU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/euKSa5GIot+P+XpVrVMRuyU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 17 Jun 2019 12:19:59 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi Leon,
>=20
> Today's linux-next merge of the mlx5-next tree got a conflict in:
>=20
>   include/linux/mlx5/eswitch.h
>=20
> between commit:
>=20
>   02f3afd97556 ("net/mlx5: E-Switch, Correct type to u16 for vport_num an=
d int for vport_index")
>=20
> from Linus' tree and commit:
>=20
>   82b11f071936 ("net/mlx5: Expose eswitch encap mode")
>=20
> from the mlx5-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc include/linux/mlx5/eswitch.h
> index e9a55c0d50fd,174eec0871d9..000000000000
> --- a/include/linux/mlx5/eswitch.h
> +++ b/include/linux/mlx5/eswitch.h
> @@@ -61,5 -62,16 +62,16 @@@ void *mlx5_eswitch_uplink_get_proto_dev
>   u8 mlx5_eswitch_mode(struct mlx5_eswitch *esw);
>   struct mlx5_flow_handle *
>   mlx5_eswitch_add_send_to_vport_rule(struct mlx5_eswitch *esw,
>  -				    int vport, u32 sqn);
>  +				    u16 vport_num, u32 sqn);
> +=20
> + #ifdef CONFIG_MLX5_ESWITCH
> + enum devlink_eswitch_encap_mode
> + mlx5_eswitch_get_encap_mode(const struct mlx5_core_dev *dev);
> + #else  /* CONFIG_MLX5_ESWITCH */
> + static inline enum devlink_eswitch_encap_mode
> + mlx5_eswitch_get_encap_mode(const struct mlx5_core_dev *dev)
> + {
> + 	return DEVLINK_ESWITCH_ENCAP_MODE_NONE;
> + }
> + #endif /* CONFIG_MLX5_ESWITCH */
>   #endif

This is now a conflict between Linus' tree and the rdma tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/euKSa5GIot+P+XpVrVMRuyU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0K9/MACgkQAVBC80lX
0GzcpwgAkRzLJxsJ9PEtIuB/1ndwzOu8ff49Df/KyvUOkvAXs0zTtEEpVDgUoYyd
raRa3uBPZzHOY5WxiJ6wQ7FLSf048agh4x2wT30WXp1NuHqdowW03J/+7onhc2YK
RDkXXXZqWLIcyKieIegVjaEXdTrJayYs62pJZlUh8bRrLHyMR1HDACjArOhdPrlT
zmU2HX1325OKVeXDkK/LS1aXdhTF3qxf/4At4LICkDBtuHfZvu8BCazmEwUP/w5b
rDtzYkmplSWkcNrj1O27NSRjtvl/7Gly96hrpS1nnjdMs3Ic1LAxGmR0bfPWkQpQ
HPZwCSfYHcPD+HBl5dYWwkrnlXb+zQ==
=gqPH
-----END PGP SIGNATURE-----

--Sig_/euKSa5GIot+P+XpVrVMRuyU--
