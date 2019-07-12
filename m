Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA9C742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A91208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BB/aUiEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfGLAof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:44:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfGLAoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:44:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45lDhb2PSBz9sMr;
        Fri, 12 Jul 2019 10:44:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562892271;
        bh=l/JfEetmGiTQbE17ezOkcEKybuDLnf5J4bq6IQRRqlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BB/aUiEpr9AQnfhDGVIFpi2HfCrmTgjh9XNd0p9Dg/5pl73jFmZcoBj/VRb0kUvR6
         W1rO/ZCA0jBCENPF/ZqBnZ1nZbefbM3h3GI2rujifGy5yqW0768ZTpUWx8SgyAQX7l
         3pzRMmTVcBKpPkfw1EdiH/cYctX0SCXwUDg51yBe30XK49P0saHiiynQyvZ5Mcd3FW
         1Gio6+yMshLi254mJdR7TLTs6JwFMf4B35vKGEym+G8BGyVroHHJLS8mXj7scHqjcq
         7xRf58qxUQh113Ri/bEOYg2PsRlvn25C2qp10rLxIoW99QwtOLikm4eSNPhcuwwMox
         R57XvkY4c/sgA==
Date:   Fri, 12 Jul 2019 10:44:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: linux-next: build failure after merge of the char-misc tree
Message-ID: <20190712104430.739f1b61@canb.auug.org.au>
In-Reply-To: <20190708192345.53fce4cf@canb.auug.org.au>
References: <20190708192345.53fce4cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mQvolzmOpIqHqWuZ0oeUFXj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mQvolzmOpIqHqWuZ0oeUFXj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 8 Jul 2019 19:23:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> After merging the char-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/misc/vmw_balloon.c: In function 'vmballoon_mount':
> drivers/misc/vmw_balloon.c:1736:14: error: 'simple_dname' undeclared (fir=
st use in this function); did you mean 'simple_rename'?
>    .d_dname =3D simple_dname,
>               ^~~~~~~~~~~~
>               simple_rename
> drivers/misc/vmw_balloon.c:1736:14: note: each undeclared identifier is r=
eported only once for each function it appears in
> drivers/misc/vmw_balloon.c:1739:9: error: implicit declaration of functio=
n 'mount_pseudo'; did you mean 'mount_bdev'? [-Werror=3Dimplicit-function-d=
eclaration]
>   return mount_pseudo(fs_type, "balloon-vmware:", NULL, &ops,
>          ^~~~~~~~~~~~
>          mount_bdev
> drivers/misc/vmw_balloon.c:1739:9: warning: returning 'int' from a functi=
on with return type 'struct dentry *' makes pointer from integer without a =
cast [-Wint-conversion]
>   return mount_pseudo(fs_type, "balloon-vmware:", NULL, &ops,
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         BALLOON_VMW_MAGIC);
>         ~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   83a8afa72e9c ("vmw_balloon: Compaction support")
>=20
> interacting with commits
>=20
>   7e5f7bb08b8c ("unexport simple_dname()")
>   8d9e46d80777 ("fold mount_pseudo_xattr() into pseudo_fs_get_tree()")
>=20
> from the vfs tree.
>=20
> I applied the following merge fix patch:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 8 Jul 2019 19:17:56 +1000
> Subject: [PATCH] convert vmwballoon to use the new mount API
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/misc/vmw_balloon.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 91fa43051535..e8c0f7525f13 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -29,6 +29,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/mount.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/balloon_compaction.h>
>  #include <linux/vmw_vmci_defs.h>
>  #include <linux/vmw_vmci_api.h>
> @@ -1728,21 +1729,14 @@ static inline void vmballoon_debugfs_exit(struct =
vmballoon *b)
> =20
>  #ifdef CONFIG_BALLOON_COMPACTION
> =20
> -static struct dentry *vmballoon_mount(struct file_system_type *fs_type,
> -				      int flags, const char *dev_name,
> -				      void *data)
> +static int vmballoon_init_fs_context(struct fs_context *fc)
>  {
> -	static const struct dentry_operations ops =3D {
> -		.d_dname =3D simple_dname,
> -	};
> -
> -	return mount_pseudo(fs_type, "balloon-vmware:", NULL, &ops,
> -			    BALLOON_VMW_MAGIC);
> +	return init_pseudo(fc, BALLOON_VMW_MAGIC) ? 0 : -ENOMEM;
>  }
> =20
>  static struct file_system_type vmballoon_fs =3D {
>  	.name           =3D "balloon-vmware",
> -	.mount          =3D vmballoon_mount,
> +	.init_fs_context          =3D vmballoon_init_fs_context,
>  	.kill_sb        =3D kill_anon_super,
>  };
> =20

This is now a conflict between the vfs tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/mQvolzmOpIqHqWuZ0oeUFXj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0n1+4ACgkQAVBC80lX
0GzVJAf/RDoLlHds5kYTXclzo2ds+aY91gXqvGzsZJz/28mZElrTV15W8gvE6L3j
YOJ9hsbY4kgkacLhWm2iYSV/nkSvFBmrt2s5pRs1qk4rXgEQWC7VQv7br8VMsBpJ
PCdoHznmZEU8tMMdwP6fUJ4ob41pOnfUSBHHPnIlGqE/RMn5xIsCoYNr2yr/RIY1
rOI4lATfOr5AG6Vfm4X+pZXCHJ431h4dgeZmMdr1ckG1KqoYCjYhvHgR7nJiR6mQ
a9CutMwD74KiAS39/28hZgtLXG1aOSN7wIgCSoEVVjXluion8/bfhhJfy0+7h3M+
NmuEYupvU9lr2Vcl2lccqKs1em0wug==
=8P35
-----END PGP SIGNATURE-----

--Sig_/mQvolzmOpIqHqWuZ0oeUFXj--
