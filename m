Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7670C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BE320830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qeg7CmE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfEFXxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:53:54 -0400
Received: from ozlabs.org ([203.11.71.1]:48235 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfEFXxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:53:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yfhX2KZ5z9s4Y;
        Tue,  7 May 2019 09:53:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557186829;
        bh=1ZkSqqhaWdar3DSYNSZygWd6BNjV3T2Rq82XDyUlWZY=;
        h=Date:From:To:Cc:Subject:From;
        b=qeg7CmE+B93GelVTK/EEjmDhlaPi60C+o10fljli7AWrvGk1kAuqC5Acere/uwcwc
         37Sr23T7kXgaWWpTmISokB1TSDJEl71mapSMoJbqie0/wMYX6sFemkrCZnEFaIjNBv
         SzVrJsSk0NraO8GlRhGiskb4+upQGUhj+4WwwhdnMutL0/tAvHQQuj8O4Eg4Lh9VSn
         bupPpwARzv71FOzyy/uvJJUGNCbyoJjKEHebT7iqljbW6hlC8Sb1/t2Sk8eHlwkNjL
         1Ny/UDXJPT+dhx3UeKzpwP7QcXdFH6ZPFbsyLifTppg87nWcbB+Kf98DMOt89u+7II
         Xm0O/1rnMi6xQ==
Date:   Tue, 7 May 2019 09:53:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhangliguang <zhangliguang@linux.alibaba.com>
Subject: linux-next: manual merge of the vfs tree with the fuse tree
Message-ID: <20190507095323.4ec2d3f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/I4aUjkWfSAsJYqYUG=XoBhP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I4aUjkWfSAsJYqYUG=XoBhP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/fuse/inode.c

between commit:

  829f949b6e06 ("fuse: clean up fuse_alloc_inode")

from the fuse tree and commit:

  9baf28bbfea1 ("fuse: switch to ->free_inode()")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/fuse/inode.c
index bc02bad1be7c,f485d09d14df..000000000000
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@@ -102,25 -104,16 +102,16 @@@ static struct inode *fuse_alloc_inode(s
  		return NULL;
  	}
 =20
 -	return inode;
 +	return &fi->inode;
  }
 =20
- static void fuse_i_callback(struct rcu_head *head)
- {
- 	struct inode *inode =3D container_of(head, struct inode, i_rcu);
- 	kmem_cache_free(fuse_inode_cachep, get_fuse_inode(inode));
- }
-=20
- static void fuse_destroy_inode(struct inode *inode)
+ static void fuse_free_inode(struct inode *inode)
  {
  	struct fuse_inode *fi =3D get_fuse_inode(inode);
- 	if (S_ISREG(inode->i_mode) && !is_bad_inode(inode)) {
- 		WARN_ON(!list_empty(&fi->write_files));
- 		WARN_ON(!list_empty(&fi->queued_writes));
- 	}
+=20
  	mutex_destroy(&fi->mutex);
  	kfree(fi->forget);
- 	call_rcu(&inode->i_rcu, fuse_i_callback);
+ 	kmem_cache_free(fuse_inode_cachep, fi);
  }
 =20
  static void fuse_evict_inode(struct inode *inode)

--Sig_/I4aUjkWfSAsJYqYUG=XoBhP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzQyPMACgkQAVBC80lX
0Gz67wf/T/vGJqlHvEO8LO6cCYEIVD/kUhvd4CgokwwnlFfi1xl49mT1TJmFF8yp
qYVlD4u2+voT2x+6QxRpl6FmKj9UFpP6961xfgkYavGlwLvE/FhLfpkiVdXJdTAD
ICcFlz94g8+g2g0rfJxwcBMPSN16T2IqOGaxEZjmjgKyPNL6FOUmLQdUekAUPP6p
MqOz+lagWGvceW78ywEXGdABwo6Yi8FaCk+uYMBx8JRn4vTKmH0K42kLVGXHugz6
ObE/UWoUvojKlrwT4ycuOgfqzvQmqTRf8FiJizUCPw3OU8Y/HTFIQEUKyE6rLxfO
ho3C5GOHDPDlm/k8EAmIofkV/GwnkQ==
=R/hD
-----END PGP SIGNATURE-----

--Sig_/I4aUjkWfSAsJYqYUG=XoBhP--
