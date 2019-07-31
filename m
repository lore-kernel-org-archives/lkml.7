Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944BAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEED20665
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pnjUDc8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfGaAr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 20:47:57 -0400
Received: from ozlabs.org ([203.11.71.1]:48375 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfGaAr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:47:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yvsh4KYJz9s3l;
        Wed, 31 Jul 2019 10:47:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564534073;
        bh=9rQt8cz0JbtUi9ggE2ZHa/0gAM9GLGZUYDcK8Oqv6yU=;
        h=Date:From:To:Cc:Subject:From;
        b=pnjUDc8gjPlEC+OGBhNQslBkbWHeGkWBYC5A2bTI5nQS6k7R1+e5dWldTsP0RKc7W
         ctbgk9UxWS4wpf5qIqusyAiQ80KmlwCmImQt94Ro4CQlpcsuDk3L7KcP1M1+N6Uc0M
         +2OFSMbxDrpplwwoXVUaO+GjQu/egSmVLiMWIsx/TmyHQLzxZlRnYBq+gCza1xSDeA
         Rowp+YV4RMIID7Rdgv8gNotlfB+jJ9Skd2JVRJY6NiNCg+Eb3KMx5wbtPk6sKoH+DA
         lYDHH1a3YjPIFVETprTN+HNtdQf3c0tYdExwX8Q8gSsGWjlo1ox3BYZHIGh3/DfJBP
         H82CH2fgR1ugQ==
Date:   Wed, 31 Jul 2019 10:47:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: linux-next: manual merge of the fsverity tree with the f2fs tree
Message-ID: <20190731104748.203bf67b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rDBMkj_5_i.t2tiHL3ZM_tE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rDBMkj_5_i.t2tiHL3ZM_tE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fsverity tree got conflicts in:

  fs/f2fs/file.c
  fs/f2fs/inode.c

between commits:

  cf3dbe1481d1 ("f2fs: support FS_IOC_{GET,SET}FSLABEL")
  01ff2b3740a6 ("f2fs: Support case-insensitive file name lookups")

from the f2fs tree and commit:

  60d7bf0f790f ("f2fs: add fs-verity support")

from the fsverity tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/f2fs/file.c
index eb1aa9b75eda,838bfeecbd86..000000000000
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@@ -1721,7 -1721,7 +1729,8 @@@ static const struct=20
  		FS_ENCRYPT_FL |		\
  		FS_INLINE_DATA_FL |	\
  		FS_NOCOW_FL |		\
- 		FS_CASEFOLD_FL)
++		FS_CASEFOLD_FL |	\
+ 		FS_VERITY_FL)
 =20
  #define F2FS_SETTABLE_FS_FL (		\
  		FS_SYNC_FL |		\
@@@ -3080,86 -3088,34 +3091,110 @@@ static int f2fs_ioc_resize_fs(struct fi
  	return ret;
  }
 =20
 +static int f2fs_get_volume_name(struct file *filp, unsigned long arg)
 +{
 +	struct inode *inode =3D file_inode(filp);
 +	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
 +	char *vbuf;
 +	int count;
 +	int err =3D 0;
 +
 +	vbuf =3D f2fs_kzalloc(sbi, MAX_VOLUME_NAME, GFP_KERNEL);
 +	if (!vbuf)
 +		return -ENOMEM;
 +
 +	down_read(&sbi->sb_lock);
 +	count =3D utf16s_to_utf8s(sbi->raw_super->volume_name,
 +			sizeof(sbi->raw_super->volume_name),
 +			UTF16_LITTLE_ENDIAN, vbuf, MAX_VOLUME_NAME);
 +	up_read(&sbi->sb_lock);
 +
 +	if (copy_to_user((char __user *)arg, vbuf,
 +				min(FSLABEL_MAX, count)))
 +		err =3D -EFAULT;
 +
 +	kvfree(vbuf);
 +	return err;
 +}
 +
 +static int f2fs_set_volume_name(struct file *filp, unsigned long arg)
 +{
 +	struct inode *inode =3D file_inode(filp);
 +	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
 +	char *vbuf;
 +	int len;
 +	int err =3D 0;
 +
 +	vbuf =3D f2fs_kzalloc(sbi, MAX_VOLUME_NAME, GFP_KERNEL);
 +	if (!vbuf)
 +		return -ENOMEM;
 +
 +	if (copy_from_user(vbuf, (char __user *)arg, FSLABEL_MAX)) {
 +		err =3D -EFAULT;
 +		goto out;
 +	}
 +
 +	len =3D strnlen(vbuf, FSLABEL_MAX);
 +	if (len > FSLABEL_MAX - 1) {
 +		err =3D -EINVAL;
 +		goto out;
 +	}
 +
 +	err =3D mnt_want_write_file(filp);
 +	if (err)
 +		goto out;
 +
 +	down_write(&sbi->sb_lock);
 +
 +	memset(sbi->raw_super->volume_name, 0,
 +			sizeof(sbi->raw_super->volume_name));
 +	utf8s_to_utf16s(vbuf, MAX_VOLUME_NAME, UTF16_LITTLE_ENDIAN,
 +			sbi->raw_super->volume_name,
 +			sizeof(sbi->raw_super->volume_name));
 +
 +	err =3D f2fs_commit_super(sbi, false);
 +
 +	up_write(&sbi->sb_lock);
 +
 +	mnt_drop_write_file(filp);
 +out:
 +	kvfree(vbuf);
 +	return err;
 +}
 +
+ static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
+ {
+ 	struct inode *inode =3D file_inode(filp);
+=20
+ 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+=20
+ 	if (!f2fs_sb_has_verity(F2FS_I_SB(inode))) {
+ 		f2fs_warn(F2FS_I_SB(inode),
+ 			  "Can't enable fs-verity on inode %lu: the verity feature is not enab=
led on this filesystem.\n",
+ 			  inode->i_ino);
+ 		return -EOPNOTSUPP;
+ 	}
+=20
+ 	return fsverity_ioctl_enable(filp, (const void __user *)arg);
+ }
+=20
+ static int f2fs_ioc_measure_verity(struct file *filp, unsigned long arg)
+ {
+ 	if (!f2fs_sb_has_verity(F2FS_I_SB(file_inode(filp))))
+ 		return -EOPNOTSUPP;
+=20
+ 	return fsverity_ioctl_measure(filp, (void __user *)arg);
+ }
+=20
  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
  {
 +	int ret;
 +
  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
  		return -EIO;
 +	ret =3D f2fs_is_checkpoint_ready(F2FS_I_SB(file_inode(filp)));
 +	if (ret)
 +		return ret;
 =20
  	switch (cmd) {
  	case F2FS_IOC_GETFLAGS:
@@@ -3214,10 -3170,10 +3249,14 @@@
  		return f2fs_ioc_precache_extents(filp, arg);
  	case F2FS_IOC_RESIZE_FS:
  		return f2fs_ioc_resize_fs(filp, arg);
 +	case F2FS_IOC_GET_VOLUME_NAME:
 +		return f2fs_get_volume_name(filp, arg);
 +	case F2FS_IOC_SET_VOLUME_NAME:
 +		return f2fs_set_volume_name(filp, arg);
+ 	case FS_IOC_ENABLE_VERITY:
+ 		return f2fs_ioc_enable_verity(filp, arg);
+ 	case FS_IOC_MEASURE_VERITY:
+ 		return f2fs_ioc_measure_verity(filp, arg);
  	default:
  		return -ENOTTY;
  	}
@@@ -3332,8 -3288,8 +3371,10 @@@ long f2fs_compat_ioctl(struct file *fil
  	case F2FS_IOC_SET_PIN_FILE:
  	case F2FS_IOC_PRECACHE_EXTENTS:
  	case F2FS_IOC_RESIZE_FS:
 +	case F2FS_IOC_GET_VOLUME_NAME:
 +	case F2FS_IOC_SET_VOLUME_NAME:
+ 	case FS_IOC_ENABLE_VERITY:
+ 	case FS_IOC_MEASURE_VERITY:
  		break;
  	default:
  		return -ENOIOCTLCMD;
diff --cc fs/f2fs/inode.c
index 5d78f2db7a67,06da75d418e0..000000000000
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@@ -46,11 -46,11 +46,13 @@@ void f2fs_set_inode_flags(struct inode=20
  		new_fl |=3D S_DIRSYNC;
  	if (file_is_encrypt(inode))
  		new_fl |=3D S_ENCRYPTED;
 +	if (flags & F2FS_CASEFOLD_FL)
 +		new_fl |=3D S_CASEFOLD;
+ 	if (file_is_verity(inode))
+ 		new_fl |=3D S_VERITY;
  	inode_set_flags(inode, new_fl,
  			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|
- 			S_ENCRYPTED|S_CASEFOLD);
 -			S_ENCRYPTED|S_VERITY);
++			S_ENCRYPTED|S_CASEFOLD|S_VERITY);
  }
 =20
  static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)

--Sig_/rDBMkj_5_i.t2tiHL3ZM_tE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1A5TQACgkQAVBC80lX
0Gx0agf/dYP1aN+/vMYlRsrpk9WK72mIw0IZlIVZvf6+DgXoJgD7qWL1HVl/Qae3
5OW9Fm3kCM2wboMECOPyHawbSNjqhD6PwbOHRK9CdXUKRPiC6GZ8H2hWj6bMdjnA
XgLFp0iGTwOH1p3NluGDRoJJhBc8yB8z2qa3UhNuUgV9GvvtIOjXdAOFiNBgHyjl
dd3/yC6qPMYc7/Wc5Fbxsjh0o8CrawI28ANTKY5lzDXI+mSVFiKc2QMa8tmBT061
J21QlRka9a4sSapnRpbsaY5YNzYBMKb3dnNQlTAsqmhZ2/Y8Zy1kdWzylv1XV5lk
D0Laq9KE4IFToMh1VAOJrMrA8VZwgQ==
=4TtB
-----END PGP SIGNATURE-----

--Sig_/rDBMkj_5_i.t2tiHL3ZM_tE--
