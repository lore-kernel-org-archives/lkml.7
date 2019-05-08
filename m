Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512F1C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 03:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5B521019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 03:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="trPxV2m4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfEHDoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 23:44:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfEHDoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 23:44:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zMly1fVwz9s55;
        Wed,  8 May 2019 13:44:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557287054;
        bh=Ylec96D19WPOU0Bx4Ri080v/kfToIm71hmLcwiyAkg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=trPxV2m4GF86uZri4+/pnCUtYOVhP6t2vcYBeAZJJQmYyWB1//jZsGTAa6spV/2Lc
         iX2H00XXnfx7uJwMFFj2EZEI8Lukl6Xlr3iZfwxqeIXx+675S1E/F9ohuDUAiQpzC5
         yDJeUbz1jaiboMPlqBrxeTgQ4tCVdxB7W+/CXSxEO2psaG89m+lu2BaUKFk7j82poU
         fnGITodiKsOnPsaCPvQPdpt/+xme3kJ3cmlCtbrqN85INGmWwQ1RX5s0XHi+aZ3poM
         js6Qq8fBrmhYDNtLLnENUwLZnx54cgzTHFeU8FYIT2TaGXC5MkddlhH7Kb5QU53qft
         TBQJXNsjfnvqg==
Date:   Wed, 8 May 2019 13:44:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: linux-next: manual merge of the staging tree with the block
 tree
Message-ID: <20190508134413.26a13d00@canb.auug.org.au>
In-Reply-To: <20190501170528.2d86d133@canb.auug.org.au>
References: <20190501170528.2d86d133@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PTiqtRjs/NzDhQUMKyeXWF="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PTiqtRjs/NzDhQUMKyeXWF=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 1 May 2019 17:05:28 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the staging tree got conflicts in:
>=20
>   drivers/staging/erofs/data.c
>   drivers/staging/erofs/unzip_vle.c
>=20
> between commit:
>=20
>   2b070cfe582b ("block: remove the i argument to bio_for_each_segment_all=
")
>=20
> from the block tree and commit:
>=20
>   14a56ec65bab ("staging: erofs: support IO read error injection")
>=20
> from the staging tree.
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
> diff --cc drivers/staging/erofs/data.c
> index 9f04d7466c55,c64ec76643d4..000000000000
> --- a/drivers/staging/erofs/data.c
> +++ b/drivers/staging/erofs/data.c
> @@@ -17,11 -17,18 +17,17 @@@
>  =20
>   static inline void read_endio(struct bio *bio)
>   {
> + 	struct super_block *const sb =3D bio->bi_private;
>  -	int i;
>   	struct bio_vec *bvec;
> - 	const blk_status_t err =3D bio->bi_status;
> + 	blk_status_t err =3D bio->bi_status;
>   	struct bvec_iter_all iter_all;
>  =20
> + 	if (time_to_inject(EROFS_SB(sb), FAULT_READ_IO)) {
> + 		erofs_show_injection_info(FAULT_READ_IO);
> + 		err =3D BLK_STS_IOERR;
> + 	}
> +=20
>  -	bio_for_each_segment_all(bvec, bio, i, iter_all) {
>  +	bio_for_each_segment_all(bvec, bio, iter_all) {
>   		struct page *page =3D bvec->bv_page;
>  =20
>   		/* page is already locked */
> diff --cc drivers/staging/erofs/unzip_vle.c
> index 59b9f37d5c00,a2e03c932102..000000000000
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@@ -843,14 -844,13 +844,12 @@@ static void z_erofs_vle_unzip_kickoff(v
>  =20
>   static inline void z_erofs_vle_read_endio(struct bio *bio)
>   {
> - 	const blk_status_t err =3D bio->bi_status;
> + 	struct erofs_sb_info *sbi =3D NULL;
> + 	blk_status_t err =3D bio->bi_status;
>  -	unsigned int i;
>   	struct bio_vec *bvec;
> - #ifdef EROFS_FS_HAS_MANAGED_CACHE
> - 	struct address_space *mc =3D NULL;
> - #endif
>   	struct bvec_iter_all iter_all;
>  =20
>  -	bio_for_each_segment_all(bvec, bio, i, iter_all) {
>  +	bio_for_each_segment_all(bvec, bio, iter_all) {
>   		struct page *page =3D bvec->bv_page;
>   		bool cachemngd =3D false;
>  =20

This conflict is now between the block tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/PTiqtRjs/NzDhQUMKyeXWF=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzSUI0ACgkQAVBC80lX
0GznYgf+PLM8FVE3+eBJHgcShX3cPz6dCuWcOYWHXHcCWT5gnmOqutY1Xrbn1NFG
l0XjkULZPCPJOgsWoVqKA/bJzav17VCR/ArGToeGP3YzCe6COuYSP7tq5WtFiZT7
JktCqCSOWcmQBkXDWcNkv8Ie84cUOR738hX2CG45tUvhYYw+6sVrlJ7NWtoF7n2d
3WuZufHUryMyJ9NKWlnUpIHu2G0R83nCsyUYEl5qsHgfTDi7ZJkPXDdMksq6tIfl
kBM1JZs+WqecuP6kUtRNlUai9sBl/iOkSnQk84KnrrVJSn8GzHL8+I0Zbx2YJuqn
ySO/viGKh+18hUQrv85y758ZVwWmeA==
=aat7
-----END PGP SIGNATURE-----

--Sig_/PTiqtRjs/NzDhQUMKyeXWF=--
