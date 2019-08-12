Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC59C32756
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6582085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p1x0BiuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfHLEoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 00:44:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59049 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfHLEoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 00:44:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 466NXz1SWqz9s7T;
        Mon, 12 Aug 2019 14:44:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565585060;
        bh=GgqLSApIi76VNsoqNdz4ou45OIScOvutBd6oeC57fa0=;
        h=Date:From:To:Cc:Subject:From;
        b=p1x0BiuGM3CupeZ+qmQnv3zXAhJeD4lNAKaeDU0V2/FnzepD0inj1ATsCoDt696cT
         5HjfePvh1vzozlNnV5YCidRcGEkzzVUXdBC41pA/bYh9kfZPlFMiRppfAxNfMkQvfR
         1ObrrRoclkKs6HK6M/HGhO6I2jYqQeNvSbLZGLMrbLwkvw/XW7YzhXoLNapmloIfI5
         Q0iZXWM6MtMDhbc5Sf9X/AvC6Rf8qXGym4K2gmh8j3Yh0G6jBFao4AIHOG44yfJR9I
         FcqnvI7d4UyNGeI5ez2yAkVvfcbb8RSTgVY6yk+t5QvH2ty+CF+FXspmBWtJZgifj4
         ds0Ma1N6mKZXw==
Date:   Mon, 12 Aug 2019 14:44:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Morris <jmorris@namei.org>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the security tree with the vfs tree
Message-ID: <20190812144417.74219a8e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XLb5Qq0jGOEvb+G3Gn5_JTC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XLb5Qq0jGOEvb+G3Gn5_JTC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  fs/tracefs/inode.c

between commit:

  67782f8ae148 ("vfs: Convert tracefs to use the new mount API")

from the vfs tree and commit:

  757ff7244358 ("tracefs: Restrict tracefs when the kernel is locked down")

from the security tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/tracefs/inode.c
index 1387bcd96a79,34da48036e08..000000000000
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@@ -19,8 -17,10 +19,9 @@@
  #include <linux/tracefs.h>
  #include <linux/fsnotify.h>
  #include <linux/seq_file.h>
 -#include <linux/parser.h>
  #include <linux/magic.h>
  #include <linux/slab.h>
+ #include <linux/security.h>
 =20
  #define TRACEFS_DEFAULT_MODE	0700
 =20
@@@ -210,12 -239,26 +228,18 @@@ static int tracefs_apply_options(struc
  	return 0;
  }
 =20
+ static void tracefs_destroy_inode(struct inode *inode)
+ {
+ 	if (S_ISREG(inode->i_mode))
+ 		kfree(inode->i_fop);
+ }
+=20
 -static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 +static int tracefs_reconfigure(struct fs_context *fc)
  {
 -	int err;
 -	struct tracefs_fs_info *fsi =3D sb->s_fs_info;
 +	struct super_block *sb =3D fc->root->d_sb;
 =20
  	sync_filesystem(sb);
 -	err =3D tracefs_parse_options(data, &fsi->mount_opts);
 -	if (err)
 -		goto fail;
 -
 -	tracefs_apply_options(sb);
 -
 -fail:
 -	return err;
 +	return tracefs_apply_options(sb);
  }
 =20
  static int tracefs_show_options(struct seq_file *m, struct dentry *root)
@@@ -236,6 -280,8 +260,7 @@@
 =20
  static const struct super_operations tracefs_super_operations =3D {
  	.statfs		=3D simple_statfs,
 -	.remount_fs	=3D tracefs_remount,
+ 	.destroy_inode  =3D tracefs_destroy_inode,
  	.show_options	=3D tracefs_show_options,
  };
 =20

--Sig_/XLb5Qq0jGOEvb+G3Gn5_JTC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1Q7qEACgkQAVBC80lX
0Gx/0Qf+IxwDqnHdV9MZKQ3L92rn7JCi9XTw/jsCJJu0xQVC5rap3Mzl2UyU9PW5
fBl1Jbyyi0sFbcASQfxIChLzmlDS6+rNwSMLnn8uZ6x7O26jtTndbOTtU+o/jSAj
mh0ieB9D1dtQ7/rOfg3kD3jJzuxwR0hhQiLwIulAjwj1QffWTRrVN377qb3h4a1l
H4wWIz48WAkpetonzxHUrwiGl4wAepIrC8n518OED7u+hLqStroQEJH8AiH1ONsD
1JOKLswh2B4XWP2biIdwPPxUkPA3LxRMt9mGp2ofnvWeuihg/tedFI4OmGzachW+
pvCILUtfo74iaFvsZKDFzYO/OhkaXg==
=59xK
-----END PGP SIGNATURE-----

--Sig_/XLb5Qq0jGOEvb+G3Gn5_JTC--
