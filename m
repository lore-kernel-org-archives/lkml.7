Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE548C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B621D20693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KzDK+Xwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfGHXvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:51:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfGHXvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:51:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jMfP5VVpz9s7T;
        Tue,  9 Jul 2019 09:51:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562629869;
        bh=bYmBK4EokF7DN4syu8N8YtdLfwRCXocvmrL9sk0VEOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KzDK+XwaUJjc+f0mDmngBWk9uzTJoSjERVPn5osWvXc4hj1r+inr6Ctl/Kt5GHXVr
         3lA6ku7aA2NvTF/7bgXeFKBBXjSq6xbNi96xiVvK+WlCjO56zrG284wuZK+p0/qgQR
         D2p0JmFS731d9OjVHLYTtrg+PrDsGbxIVMLoEfbob86v75dU4+JHJl0y5PqpMQRbv8
         G9tZ8DRpg4KFv5OeVv5Y6MyfNegOT7ZdCPaSFWjgPh3VILjOejFNREJj9fskKmjeeU
         2GbgbBFRvpIcVXrhjy7usJBgCf3zRhMftQsbqsdrY944IbRlJfR+QsduBj7lVFKAIo
         6BO8DvkcMEjUQ==
Date:   Tue, 9 Jul 2019 09:51:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190709095109.3b75679b@canb.auug.org.au>
In-Reply-To: <20190620153552.1392079c@canb.auug.org.au>
References: <20190620153552.1392079c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JAf6ezzsaM1jlJtn1/V9/8e"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JAf6ezzsaM1jlJtn1/V9/8e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 20 Jun 2019 15:35:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the char-misc tree got a conflict in:
>=20
>   drivers/misc/mei/debugfs.c
>=20
> between commit:
>=20
>   5666d896e838 ("mei: no need to check return value of debugfs_create fun=
ctions")
>=20
> from the driver-core tree and commit:
>=20
>   b728ddde769c ("mei: Convert to use DEFINE_SHOW_ATTRIBUTE macro")
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
> diff --cc drivers/misc/mei/debugfs.c
> index df6bf8b81936,47cfd5005e1b..000000000000
> --- a/drivers/misc/mei/debugfs.c
> +++ b/drivers/misc/mei/debugfs.c
> @@@ -233,22 -154,46 +154,21 @@@ void mei_dbgfs_deregister(struct mei_de
>    *
>    * @dev: the mei device structure
>    * @name: the mei device name
>  - *
>  - * Return: 0 on success, <0 on failure.
>    */
>  -int mei_dbgfs_register(struct mei_device *dev, const char *name)
>  +void mei_dbgfs_register(struct mei_device *dev, const char *name)
>   {
>  -	struct dentry *dir, *f;
>  +	struct dentry *dir;
>  =20
>   	dir =3D debugfs_create_dir(name, NULL);
>  -	if (!dir)
>  -		return -ENOMEM;
>  -
>   	dev->dbgfs_dir =3D dir;
>  =20
>  -	f =3D debugfs_create_file("meclients", S_IRUSR, dir,
>  -				dev, &mei_dbgfs_meclients_fops);
>  -	if (!f) {
>  -		dev_err(dev->dev, "meclients: registration failed\n");
>  -		goto err;
>  -	}
>  -	f =3D debugfs_create_file("active", S_IRUSR, dir,
>  -				dev, &mei_dbgfs_active_fops);
>  -	if (!f) {
>  -		dev_err(dev->dev, "active: registration failed\n");
>  -		goto err;
>  -	}
>  -	f =3D debugfs_create_file("devstate", S_IRUSR, dir,
>  -				dev, &mei_dbgfs_devstate_fops);
>  -	if (!f) {
>  -		dev_err(dev->dev, "devstate: registration failed\n");
>  -		goto err;
>  -	}
>  -	f =3D debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, di=
r,
>  -				&dev->allow_fixed_address,
>  -				&mei_dbgfs_allow_fa_fops);
>  -	if (!f) {
>  -		dev_err(dev->dev, "allow_fixed_address: registration failed\n");
>  -		goto err;
>  -	}
>  -	return 0;
>  -err:
>  -	mei_dbgfs_deregister(dev);
>  -	return -ENODEV;
>  +	debugfs_create_file("meclients", S_IRUSR, dir, dev,
> - 			    &mei_dbgfs_fops_meclients);
> ++			    &mei_dbgfs_meclients_fops);
>  +	debugfs_create_file("active", S_IRUSR, dir, dev,
> - 			    &mei_dbgfs_fops_active);
> ++			    &mei_dbgfs_active_fops);
>  +	debugfs_create_file("devstate", S_IRUSR, dir, dev,
> - 			    &mei_dbgfs_fops_devstate);
> ++			    &mei_dbgfs_devstate_fops);
>  +	debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
>  +			    &dev->allow_fixed_address,
> - 			    &mei_dbgfs_fops_allow_fa);
> ++			    &mei_dbgfs_allow_fa_fops);
>   }
> -=20

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/JAf6ezzsaM1jlJtn1/V9/8e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j1u0ACgkQAVBC80lX
0GyhyQf9FQt0FBrBQjpamrC9fp5pVC77qxrBjEZB6lJ/sEOJROGM2c+9vui6LvWX
Z/WbXzvpJ1texDifmB76cIlv6bsefhxzIKxBF4fC7ty4NOWATvHYJ0EqyLA8PjeO
lRrYLDOxpDz76Mvcy0L44+vdSOLuXa+XQwX2vE2JOE+7dmJOSyQVe+iy0V5jVcph
6jAtNw7j5fbwgxyd1/EM/0CSLMk0GNbnTBpED/pGyD+3/s7tgDln3e/4qoVaSqME
VEmjdtPxuScc7pylRr8vdN2vT7k8Ds9UidHoid/UM2sh8qhJNjyDKC94+gNVMVen
Sc0KDDTIm4UH9GdYy5HG3V/MbMDI3g==
=JMsA
-----END PGP SIGNATURE-----

--Sig_/JAf6ezzsaM1jlJtn1/V9/8e--
