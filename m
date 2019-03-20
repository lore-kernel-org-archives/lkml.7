Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8497C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9659B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553065053;
	bh=kuMXzrrbvUYuqwGt3EUnztZ7tkk+WGTN0Vy0J6TTjXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Lwdnn1I+nU9VCQeT9tXHn4I9Et66j8thhQeR3sKU6xyPreIn9plG63wFHny4ckbU1
	 mxEN7ogwM8rNK3yK2HhNiJxv67bYF9G7IyYulMEe+OqmzHexNOJzHJV95/qM5Gk11d
	 uOWnlWrb5fxZRHZKmGKkkps0fKWD8qw2JurF8pG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCTG5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:57:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:6403 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfCTG5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:57:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 23:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="asc'?scan'208";a="126953592"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2019 23:57:28 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-usb@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/38] vfs: Convert gadgetfs to fs_context
In-Reply-To: <155257998686.13720.8551460564620091523.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk> <155257998686.13720.8551460564620091523.stgit@warthog.procyon.org.uk>
Date:   Wed, 20 Mar 2019 08:57:24 +0200
Message-ID: <87o966uj6z.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

David Howells <dhowells@redhat.com> writes:

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Felipe Balbi <balbi@kernel.org>
> cc: linux-usb@vger.kernel.org
> ---
>
>  drivers/usb/gadget/legacy/inode.c |   21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legac=
y/inode.c
> index 249277d0e53f..441da16ffc39 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/fs.h>
> +#include <linux/fs_context.h>
>  #include <linux/pagemap.h>
>  #include <linux/uts.h>
>  #include <linux/wait.h>
> @@ -1990,7 +1991,7 @@ static const struct super_operations gadget_fs_oper=
ations =3D {
>  };
>=20=20
>  static int
> -gadgetfs_fill_super (struct super_block *sb, void *opts, int silent)
> +gadgetfs_fill_super (struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode	*inode;
>  	struct dev_data	*dev;
> @@ -2044,11 +2045,19 @@ gadgetfs_fill_super (struct super_block *sb, void=
 *opts, int silent)
>  }
>=20=20
>  /* "mount -t gadgetfs path /dev/gadget" ends up here */
> -static struct dentry *
> -gadgetfs_mount (struct file_system_type *t, int flags,
> -		const char *path, void *opts)
> +static int gadgetfs_get_tree(struct fs_context *fc)
>  {
> -	return mount_single (t, flags, opts, gadgetfs_fill_super);
> +	return vfs_get_super(fc, vfs_get_single_super, gadgetfs_fill_super);
> +}
> +
> +static const struct fs_context_operations gadgetfs_context_ops =3D {
> +	.get_tree	=3D gadgetfs_get_tree,
> +};
> +
> +static int gadgetfs_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops =3D &gadgetfs_context_ops;
> +	return 0;
>  }
>=20=20
>  static void
> @@ -2068,7 +2077,7 @@ gadgetfs_kill_sb (struct super_block *sb)
>  static struct file_system_type gadgetfs_type =3D {
>  	.owner		=3D THIS_MODULE,
>  	.name		=3D shortname,
> -	.mount		=3D gadgetfs_mount,
> +	.init_fs_context =3D gadgetfs_init_fs_context,
>  	.kill_sb	=3D gadgetfs_kill_sb,
>  };
>  MODULE_ALIAS_FS("gadgetfs");

looks like a mostly mechanical change. Do you want this to go through
the USB tree or FS tree?

Also, do you mind doing the same for drivers/usb/gadget/function/f_fs.c?

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlyR5FQACgkQzL64meEa
mQYrGhAA1ulRf1b4iR8G2sHwVqhgjCPLhGmTWQHLXM64KW/50OjG+qV53WRRtQRS
4HbynROBj7ix1NIw2aiGCPzib/lQSWbMDD00AoTnIDql4CCxt74WcA6jj4swclcV
LMU/qiJKH+tl4HPDO7tHcl+tXpCmpXMsxXmTPxBYd/SzItM0H42W1OzH9DRQKBnk
Eev79pQVAu/SEdbbYLniZixHgCkQAe2UNFWtNdHn2x12DkSlOcihhrCVeskmvQV2
QiOYEamBTWsBBH2cFKZh+Us+YBJ28DUr+Cu1Ves699qF3F0UHbOy46kVRfFwueEr
3dfLoYIjtEgKUkw4/ArRZXPkc8+jvos/5mXijm/EV+omtYwAOxh+K/+j+F98Hzzm
chhKWOkiUVL7EJMFg9Vm9+bnEOyxiKB86OF5AuedAcj8HFJomzqL+2Zg6PqUCv48
8eec1LJn290BYtl60oJkCh2MzZZfQ6N03h1WhJwBFVFzDDpqEIRW0ZdcP56CnnX8
nQTOoo17fJXrRLkTOwCIJPwSUTmwHWv0vuzTO5oEthb7exRHfCzxXX+PgcJYiFoD
aNlOiT5IfEww6y0XdI93O5ncoIy7yi3+DfpaToNyU+BuN3DTamFylSU8x2le9Py8
1s+4WotbYL/H2Q6cxpnbHJHYSlz7U1tyoEw2MkupENeSZTDaGmw=
=Bg00
-----END PGP SIGNATURE-----
--=-=-=--
