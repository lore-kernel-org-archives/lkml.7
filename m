Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31E6C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E6E20675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="liumHEsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfEHBEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:04:08 -0400
Received: from ozlabs.org ([203.11.71.1]:39871 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEHBEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:04:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zJC850gHz9s3Z;
        Wed,  8 May 2019 11:04:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557277444;
        bh=8ZS+dMJ4KJBiayooZvNVdfg99/3xmmuWNUyBV5TFx6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=liumHEsxjRD9uMeulghD73DDweo93k3XbbbMc5V/OPTIHCm0pRO5bEBzTB58JGvE0
         JNRCqpCrgsIke2ALWl7ETR+EROySLylKB/my4wmfW80V0cSjISCEvYE6sNXXl5Xa6F
         eekA4AhNXNzpl2adFoKsqGymKm2Ef9xwbnnaQpd1PIhIMzHMtw30R1XO3+r8eJ4K9T
         rDSbM6Rnuw50n62WUVrsw1BJfrA2mGKz2LayRl8F5oee7ofZZw6Z134phdkmhg16h0
         Jsp5FECxzWk+FugiCulpW8RuR6Gz4LKuhM730yr9PJNfNJTh5LGTSxS9gt9TKXdiLJ
         VqI0jDQ6RRxBA==
Date:   Wed, 8 May 2019 11:04:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs tree with the fscrypt tree
Message-ID: <20190508110404.1e9f823e@canb.auug.org.au>
In-Reply-To: <20190503110951.2df97b8c@canb.auug.org.au>
References: <20190503110951.2df97b8c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6Td3SDucDvHsj3+BWYMfs7e"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6Td3SDucDvHsj3+BWYMfs7e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 3 May 2019 11:09:51 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the vfs tree got a conflict in:
>=20
>   fs/ext4/super.c
>   fs/f2fs/super.c
>=20
> between commit:
>=20
>   2c58d548f570 ("fscrypt: cache decrypted symlink target in ->i_link")
>=20
> from the fscrypt tree and commits:
>=20
>   94053139d482 ("ext4: make use of ->free_inode()")
>   d01718a050d0 ("f2fs: switch to ->free_inode()")
>=20
> from the vfs tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> Thanks, Al, for the heads up and example merge.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/ext4/super.c
> index 489cdeeab789,981f702848e7..000000000000
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@@ -1111,12 -1107,8 +1111,9 @@@ static int ext4_drop_inode(struct inod
>   	return drop;
>   }
>  =20
> - static void ext4_i_callback(struct rcu_head *head)
> + static void ext4_free_in_core_inode(struct inode *inode)
>   {
> - 	struct inode *inode =3D container_of(head, struct inode, i_rcu);
> -=20
>  +	fscrypt_free_inode(inode);
> -=20
>   	kmem_cache_free(ext4_inode_cachep, EXT4_I(inode));
>   }
>  =20
> diff --cc fs/f2fs/super.c
> index f7605b3ff1f9,9924eac76254..000000000000
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@@ -1000,12 -1000,8 +1000,9 @@@ static void f2fs_dirty_inode(struct ino
>   	f2fs_inode_dirtied(inode, false);
>   }
>  =20
> - static void f2fs_i_callback(struct rcu_head *head)
> + static void f2fs_free_inode(struct inode *inode)
>   {
> - 	struct inode *inode =3D container_of(head, struct inode, i_rcu);
> -=20
>  +	fscrypt_free_inode(inode);
> -=20
>   	kmem_cache_free(f2fs_inode_cachep, F2FS_I(inode));
>   }
>  =20

This is now a conflict between the fscrypt tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/6Td3SDucDvHsj3+BWYMfs7e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzSKwQACgkQAVBC80lX
0Gw/9gf/fHsJodGjCS6j7dxLcZX0XPCyx1oirunp3jw3JtZdfMce1pYaHKyOhFr/
rMUl1+i/0+JtJU5R5dIwfA3+mQvDTyNERgAjloHHMQeKNj59GTAA2CC/YgmE8NX9
UOshFr3jhhDCCinrruespZvQX5wHJ2fY5L+nokhq4sbnbm2hj/A0XeDspLmka5D8
fFikoQDBa/Y0pVjLphSkm/Do06ZaksAecrLjD4liCCEmJwXS6oepWvBSgrXZ0RNy
iAmaLid5msoQCjF3wClN8YNEpaItMJ6kXOikLM/+B7Couc+IcWVbACQ4nc/tz4Nx
GwqXd2Rvay6O5aM/up0/vG5FJdDStA==
=aVsW
-----END PGP SIGNATURE-----

--Sig_/6Td3SDucDvHsj3+BWYMfs7e--
