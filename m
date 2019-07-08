Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E0C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD66E21707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Yglw3gx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfGHXUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:20:08 -0400
Received: from ozlabs.org ([203.11.71.1]:37431 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfGHXUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:20:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jLyX5607z9sN4;
        Tue,  9 Jul 2019 09:20:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562628005;
        bh=29ZFwWy9ou/Nl3/TnDctw7MIBF9U4PbQyVC6Fyn3xpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yglw3gx7NFcJgzBUv4c6OwWlKYpzx7sWCfEnwyxhwNNAi9vz2zWX6CUfzw33e8hnn
         4ysE12f0xllGoWbPFOGcTa3IwTvNxHTJu1H7ZaCcFhuTgsx3raSW5OG9DONmY91FB8
         +BTTOpVSNyv3UiLiTfhzVPUK4OmYcnEP9gxF6yAAMqc3R6s8y3vNDfTFGWjTEYzjnd
         BunKCM/GfeRHXwjMzUG3gMb6fsC6J+cEZ2+7yQb2DIYmuSy7Zz6dNsEDrOiOZAopyk
         2lkNCT0YVeytSf4BQiHAnCaaXgkrBW85O1YkjBiOtKPikytVP/H9iSxQsc5EVy6733
         nOsWR3w2BTEKw==
Date:   Tue, 9 Jul 2019 09:20:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190709092003.6087a9c4@canb.auug.org.au>
In-Reply-To: <20190613155344.64fce8b9@canb.auug.org.au>
References: <20190613155344.64fce8b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1e01G77HmLeK=CYrjp0RpJD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1e01G77HmLeK=CYrjp0RpJD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 13 Jun 2019 15:53:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the char-misc tree got a conflict in:
>=20
>   drivers/misc/vmw_balloon.c
>=20
> between commit:
>=20
>   225afca60b8a ("vmw_balloon: no need to check return value of debugfs_cr=
eate functions")
>=20
> from the driver-core tree and commits:
>=20
>   83a8afa72e9c ("vmw_balloon: Compaction support")
>   5d1a86ecf328 ("vmw_balloon: Add memory shrinker")
>=20
> from the char-misc tree.
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
> diff --cc drivers/misc/vmw_balloon.c
> index fdf5ad757226,043eed845246..000000000000
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@@ -1553,15 -1942,26 +1932,24 @@@ static int __init vmballoon_init(void
>   	if (x86_hyper_type !=3D X86_HYPER_VMWARE)
>   		return -ENODEV;
>  =20
> - 	for (page_size =3D VMW_BALLOON_4K_PAGE;
> - 	     page_size <=3D VMW_BALLOON_LAST_SIZE; page_size++)
> - 		INIT_LIST_HEAD(&balloon.page_sizes[page_size].pages);
> -=20
> -=20
>   	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
>  =20
> + 	error =3D vmballoon_register_shrinker(&balloon);
> + 	if (error)
> + 		goto fail;
> +=20
>  -	error =3D vmballoon_debugfs_init(&balloon);
>  -	if (error)
>  -		goto fail;
>  +	vmballoon_debugfs_init(&balloon);
>  =20
> + 	/*
> + 	 * Initialization of compaction must be done after the call to
> + 	 * balloon_devinfo_init() .
> + 	 */
> + 	balloon_devinfo_init(&balloon.b_dev_info);
> + 	error =3D vmballoon_compaction_init(&balloon);
> + 	if (error)
> + 		goto fail;
> +=20
> + 	INIT_LIST_HEAD(&balloon.huge_pages);
>   	spin_lock_init(&balloon.comm_lock);
>   	init_rwsem(&balloon.conf_sem);
>   	balloon.vmci_doorbell =3D VMCI_INVALID_HANDLE;

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/1e01G77HmLeK=CYrjp0RpJD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jz6MACgkQAVBC80lX
0Gz3Kwf+N6auBRYxel7zls7Vvoiwx41cqdla7fVdMeNYbCXvZX1+tWEQM9XKFSA+
h8Q14dwEXl/TJBf2IWoJjqlUuY294CcgENn/rFSyHcpzu6vthOh2gzjcsXVSnLiA
ZmeHbP9obSEaENEXxN9aZTRGemOPxV8/+X0onw8vZysfX9t8zUSv4QdgM7hHayIl
Hst1/QXJOw+q48vUOvgv74pH4nccSubARTqo7+FlJzcpq5TMaeZ9zR1m0Xoz8FWQ
TmKh+xPT5/Gf1ubANsbg7RB3FUr7SuMfwD9/djlMWBSRxc9xRUOxq2CoibkdIZiF
vh2g5yjgRQ+95vU/hUqA0VJqWfansA==
=RT3+
-----END PGP SIGNATURE-----

--Sig_/1e01G77HmLeK=CYrjp0RpJD--
