Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F93AC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E73A21019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ql6C1WZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEHBBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:01:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEHBBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:01:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zJ8K6pm2z9s3Z;
        Wed,  8 May 2019 11:01:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557277299;
        bh=ZTR9+UXbz/hs7CTBlloJ/Voht+YTKRxMGFWW3mjOyy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ql6C1WZCX9dO8OFLR99QNVXdqWTxgiwkxPRyWF5YyMwD/uehVYowH0A9JAzJNtoCb
         xowkweUfaOUFAyVjZG71yAk+Jna1aXH2SxvX/fFt+xcJxSwSi0XGtBficr7KnZOksl
         264gQu5vav1ZTA01qgpbztO9zKEmIg++QYmd38qUl3g2/wNeKS+dzRLXROkadwHM5/
         ISK/eRPHdl/AgCPAsPgpmMEnyYzUmmpdEn2Xhj2d6lu0wF6EQHz/004H0S8U9I7AMw
         h6zJCnQG0/sEbEwkh0juOg+RPaUjgqRPauto8xyab4+MGh9BL05UaPWe6Xun4myUUf
         LdeZSNSutW1ug==
Date:   Wed, 8 May 2019 11:01:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhangliguang <zhangliguang@linux.alibaba.com>
Subject: Re: linux-next: manual merge of the vfs tree with the fuse tree
Message-ID: <20190508110137.28f23b3a@canb.auug.org.au>
In-Reply-To: <20190507095323.4ec2d3f7@canb.auug.org.au>
References: <20190507095323.4ec2d3f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sD7QpNiwQHF4aCFs.UCn0qx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sD7QpNiwQHF4aCFs.UCn0qx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 7 May 2019 09:53:23 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> Today's linux-next merge of the vfs tree got a conflict in:
>=20
>   fs/fuse/inode.c
>=20
> between commit:
>=20
>   829f949b6e06 ("fuse: clean up fuse_alloc_inode")
>=20
> from the fuse tree and commit:
>=20
>   9baf28bbfea1 ("fuse: switch to ->free_inode()")
>=20
> from the vfs tree.
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
> diff --cc fs/fuse/inode.c
> index bc02bad1be7c,f485d09d14df..000000000000
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@@ -102,25 -104,16 +102,16 @@@ static struct inode *fuse_alloc_inode(s
>   		return NULL;
>   	}
>  =20
>  -	return inode;
>  +	return &fi->inode;
>   }
>  =20
> - static void fuse_i_callback(struct rcu_head *head)
> - {
> - 	struct inode *inode =3D container_of(head, struct inode, i_rcu);
> - 	kmem_cache_free(fuse_inode_cachep, get_fuse_inode(inode));
> - }
> -=20
> - static void fuse_destroy_inode(struct inode *inode)
> + static void fuse_free_inode(struct inode *inode)
>   {
>   	struct fuse_inode *fi =3D get_fuse_inode(inode);
> - 	if (S_ISREG(inode->i_mode) && !is_bad_inode(inode)) {
> - 		WARN_ON(!list_empty(&fi->write_files));
> - 		WARN_ON(!list_empty(&fi->queued_writes));
> - 	}
> +=20
>   	mutex_destroy(&fi->mutex);
>   	kfree(fi->forget);
> - 	call_rcu(&inode->i_rcu, fuse_i_callback);
> + 	kmem_cache_free(fuse_inode_cachep, fi);
>   }
>  =20
>   static void fuse_evict_inode(struct inode *inode)

This is now a conflict between the fuse tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/sD7QpNiwQHF4aCFs.UCn0qx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzSKnEACgkQAVBC80lX
0GwcoQgAnegk0Y1z9VKvek8GxxiQW+0PnWxE0f9YqU1QGbhs5EApVqu85jBK9ft5
lLY+bmRfoNDhH4yj+hZ6IUJ0l84hvyHUj92CiABw7yE4hOVrxTKZl83nGLRu9jax
7aU4FhQD1Gx1BO2aRQIytlBElKAx8gTwG1s5n0PAMtXrHQDDC8WsVjiBKqpg9tTr
xJc0Pf8i7umKNcDhDUOpUKJoqpjErShuqo4tAb8YhnNoNzefKIkrn3z+NKdyDkB3
cqHIuw8pT/EtqzGhZaIKaxUIMsD8+u8Oa2oakoVCzYEZFXxK7W+iMXAuE9H69ZSP
W6wUmWfj/7hmxzfFhp/liWOJiwyryA==
=kQjJ
-----END PGP SIGNATURE-----

--Sig_/sD7QpNiwQHF4aCFs.UCn0qx--
