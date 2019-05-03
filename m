Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28549C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9682085A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RZO5UNJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfECBJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 21:09:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfECBJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 21:09:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wDZC3ZpMz9s5c;
        Fri,  3 May 2019 11:09:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556845795;
        bh=7bkWu+6rTKTwonGgaS4sxAMv9lTzGjIejg51YopzHN0=;
        h=Date:From:To:Cc:Subject:From;
        b=RZO5UNJIoAh/9+uhW+GTctr6u07vLhc9B9vOzhUi5sIMCOdT9uvdypMIfXsmA0Fal
         0gexw1z+s2y2lavQ8wxNrLz1jfA+kz9TLhbCn964sRdKoLAOa2iUW02AoEUWIHIjkr
         lyu+VGN2ajvrbrHRHsubWqOPrezsVkOc2zkGZXpjIOLnARy5/m2zvOH0i/Var85Eqi
         2KjbZVUtt1jSg+oVR/gfvUtg9z4AJrFYHdps47IVxuYgs9bLKtRBmxB94wMRl/4pRE
         kKQWeUEudn9vjR0inEyTzV9zQlN1BV3SEYeiUtaBOVGbWN8VG3DGorIJ9fsXmULWnx
         BIc+oqUHldigg==
Date:   Fri, 3 May 2019 11:09:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the fscrypt tree
Message-ID: <20190503110951.2df97b8c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5DT88H2gGKsN9j+elZMjYA_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5DT88H2gGKsN9j+elZMjYA_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/ext4/super.c
  fs/f2fs/super.c

between commit:

  2c58d548f570 ("fscrypt: cache decrypted symlink target in ->i_link")

from the fscrypt tree and commits:

  94053139d482 ("ext4: make use of ->free_inode()")
  d01718a050d0 ("f2fs: switch to ->free_inode()")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

Thanks, Al, for the heads up and example merge.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ext4/super.c
index 489cdeeab789,981f702848e7..000000000000
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@@ -1111,12 -1107,8 +1111,9 @@@ static int ext4_drop_inode(struct inod
  	return drop;
  }
 =20
- static void ext4_i_callback(struct rcu_head *head)
+ static void ext4_free_in_core_inode(struct inode *inode)
  {
- 	struct inode *inode =3D container_of(head, struct inode, i_rcu);
-=20
 +	fscrypt_free_inode(inode);
-=20
  	kmem_cache_free(ext4_inode_cachep, EXT4_I(inode));
  }
 =20
diff --cc fs/f2fs/super.c
index f7605b3ff1f9,9924eac76254..000000000000
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@@ -1000,12 -1000,8 +1000,9 @@@ static void f2fs_dirty_inode(struct ino
  	f2fs_inode_dirtied(inode, false);
  }
 =20
- static void f2fs_i_callback(struct rcu_head *head)
+ static void f2fs_free_inode(struct inode *inode)
  {
- 	struct inode *inode =3D container_of(head, struct inode, i_rcu);
-=20
 +	fscrypt_free_inode(inode);
-=20
  	kmem_cache_free(f2fs_inode_cachep, F2FS_I(inode));
  }
 =20

--Sig_/5DT88H2gGKsN9j+elZMjYA_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzLlN8ACgkQAVBC80lX
0Gz7Pwf/V59IXjAUO1LLeQX7qhHxgK0OoZD2mvhrgFz2NbECImXsXvmFR9RhPstg
TjHn1Vi6WT3gRnSRWPqJd0ywS9VN60S4GnB9Ho0OQv55aPjyP1FF8VGxsuy6UDFQ
NBrs/JysXdfr/SCBV3FCUgB4oYTwwosZePsBurPotO/V2RySRFPM/GGOLGa/HKox
sqA3WL4p4x9O+eIBqj1iO642lHI9gTWZ4rGzfn2oEwxfRdhWO/CKLZ4yXksI5LXm
QB6EU8Keb+VlC1pWTBW6mKxlAnanNcmVNm5gxpQZD3GNDe9YY8cS5L9AJRRpYC/I
G5YlnIWhrE6yalf3zZpe6NHRTOliCA==
=oD1k
-----END PGP SIGNATURE-----

--Sig_/5DT88H2gGKsN9j+elZMjYA_--
