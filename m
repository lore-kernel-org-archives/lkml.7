Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9932CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6069E2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UM88wXVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfECBPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 21:15:16 -0400
Received: from ozlabs.org ([203.11.71.1]:47231 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfECBPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 21:15:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wDhH2sY7z9s5c;
        Fri,  3 May 2019 11:15:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556846111;
        bh=+/Re8tVf2zkTyiwmRV36XRsOPBsv+H8UKjBeTOloOFw=;
        h=Date:From:To:Cc:Subject:From;
        b=UM88wXVwYv6ViNm1YJMCKD525I4OXm8TS0tfbe5Kw9uadZyb576xYhDaOLtjuyNck
         cUrzQQncMROya2mSmzcRSAN64daAOp828i3O6dV2+FYacIF3zBFy5izA2dAFC4O7Nr
         5vEiOxhnothFpRmbRr6zoUR0P8N3rdOlpBze2hwcAJdQBYQHg1y/NiN4MIoMZbtqYw
         2fdz/8ypwARlXFKDdQ3l5g7H4DbN/kwxiyLMl/0Rf9B/keZhWd7Qyw7ZuxlKlDioAY
         mkxzNUV2pS7GHSB93fmSCNuwkQzMQTAp6vuxNHlKjFNag/Y6LcEjQyaBlmWLY/ero3
         eltUGnx3CLm3g==
Date:   Fri, 3 May 2019 11:15:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Brandenburg <martin@omnibond.com>
Subject: linux-next: manual merge of the vfs tree with the orangefs tree
Message-ID: <20190503111510.6e866e3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Pi+73itdhPqitBme2i5CtD/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pi+73itdhPqitBme2i5CtD/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/orangefs/super.c

between commit:

  77becb76042a ("orangefs: implement xattr cache")

from the orangefs tree and commit:

  f276ae0dd6d0 ("orangefs: make use of ->free_inode()")

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

diff --cc fs/orangefs/super.c
index 8fa30c13b7ed,3784f7e8b603..000000000000
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@@ -125,20 -124,9 +125,19 @@@ static struct inode *orangefs_alloc_ino
  	return &orangefs_inode->vfs_inode;
  }
 =20
- static void orangefs_i_callback(struct rcu_head *head)
+ static void orangefs_free_inode(struct inode *inode)
  {
- 	struct inode *inode =3D container_of(head, struct inode, i_rcu);
 -	kmem_cache_free(orangefs_inode_cache, ORANGEFS_I(inode));
 +	struct orangefs_inode_s *orangefs_inode =3D ORANGEFS_I(inode);
 +	struct orangefs_cached_xattr *cx;
 +	struct hlist_node *tmp;
 +	int i;
 +
 +	hash_for_each_safe(orangefs_inode->xattr_cache, i, tmp, cx, node) {
 +		hlist_del(&cx->node);
 +		kfree(cx);
 +	}
 +
 +	kmem_cache_free(orangefs_inode_cache, orangefs_inode);
  }
 =20
  static void orangefs_destroy_inode(struct inode *inode)
@@@ -148,17 -136,8 +147,15 @@@
  	gossip_debug(GOSSIP_SUPER_DEBUG,
  			"%s: deallocated %p destroying inode %pU\n",
  			__func__, orangefs_inode, get_khandle_from_ino(inode));
-=20
- 	call_rcu(&inode->i_rcu, orangefs_i_callback);
  }
 =20
 +static int orangefs_write_inode(struct inode *inode,
 +				struct writeback_control *wbc)
 +{
 +	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_write_inode\n");
 +	return orangefs_inode_setattr(inode);
 +}
 +
  /*
   * NOTE: information filled in here is typically reflected in the
   * output of the system command 'df'
@@@ -316,8 -295,8 +313,9 @@@ void fsid_key_table_finalize(void
 =20
  static const struct super_operations orangefs_s_ops =3D {
  	.alloc_inode =3D orangefs_alloc_inode,
+ 	.free_inode =3D orangefs_free_inode,
  	.destroy_inode =3D orangefs_destroy_inode,
 +	.write_inode =3D orangefs_write_inode,
  	.drop_inode =3D generic_delete_inode,
  	.statfs =3D orangefs_statfs,
  	.remount_fs =3D orangefs_remount_fs,

--Sig_/Pi+73itdhPqitBme2i5CtD/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzLlh4ACgkQAVBC80lX
0GzA1AgAhy3RIu6w7cHrdlvDjWpV5l+Xf9jr5PE4/zYFAXectc6fw2M2gKJx0UTQ
QXQlMkuotzW5I2AbfhMTjMIIsUHb9AjFrbTXqldHxre3h/VsSRZFOOjAuLga+D4W
BGmIQ1Rf2Rq2CRoZn760acF3eORAWVboxwfvAdBGJabvqxbHQl392VR6qp1IuCWH
WdpqoS7awJRq5I2MYnX6cY9lk2HrUB0wQkvtpFgGqzBWPxsmB8Va1/dJY/ph/zy1
9SnZqWJGHh9iLHYQzL+wF3RZf4RnqSFIJWtX3JIEY19WWkG5uquZYnWnNbz0sVF+
hJvrVYBzQyW4YOAWsTDmFeBsdCiRWg==
=6kG4
-----END PGP SIGNATURE-----

--Sig_/Pi+73itdhPqitBme2i5CtD/--
