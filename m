Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139AC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D205321530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WZ41FXMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEHBDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:03:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEHBC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:02:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zJ9q5zgfz9s3Z;
        Wed,  8 May 2019 11:02:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557277376;
        bh=zk4W5N2kxFyMMUs+4Ce5fgSCH+gdQdqMduRIdJemt4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WZ41FXMFoNJWRIRBBm7h8NjjhdShdOXT06haxnHi7BxhyxS0yNkcfOycF6XxiIRP9
         WSWqbOpDXwlUaYNdin2QTUfFX1F3J+/S3Dh4AtUDcGWg58R+Tj7zMqbjIg3F/COtHT
         G8bfu2EwN/DBps1bvAU6PglR/lpxhlcQgFTxQEzlWdgg38G9ZhiuxTZIvo3DkhUZjx
         8cbf3rVLybcI9uQoYlpd0RC3Slc+fHL1cZ4TB8NPdMOVZJ3N2cp7zekgAVKXWQAYB2
         MK7dveZEZO4MQZ95VBxSw4wNeFog0WIV4jFuJFiTq9N64LtmfPV2bJrRK4zh33yjZx
         aZUYgOzGVxuFw==
Date:   Wed, 8 May 2019 11:02:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Brandenburg <martin@omnibond.com>
Subject: Re: linux-next: manual merge of the vfs tree with the orangefs tree
Message-ID: <20190508110255.52ce2558@canb.auug.org.au>
In-Reply-To: <20190503111510.6e866e3b@canb.auug.org.au>
References: <20190503111510.6e866e3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mFKah/s06g_pbu_IdFbkSiv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mFKah/s06g_pbu_IdFbkSiv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 3 May 2019 11:15:10 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the vfs tree got a conflict in:
>=20
>   fs/orangefs/super.c
>=20
> between commit:
>=20
>   77becb76042a ("orangefs: implement xattr cache")
>=20
> from the orangefs tree and commit:
>=20
>   f276ae0dd6d0 ("orangefs: make use of ->free_inode()")
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
> diff --cc fs/orangefs/super.c
> index 8fa30c13b7ed,3784f7e8b603..000000000000
> --- a/fs/orangefs/super.c
> +++ b/fs/orangefs/super.c
> @@@ -125,20 -124,9 +125,19 @@@ static struct inode *orangefs_alloc_ino
>   	return &orangefs_inode->vfs_inode;
>   }
>  =20
> - static void orangefs_i_callback(struct rcu_head *head)
> + static void orangefs_free_inode(struct inode *inode)
>   {
> - 	struct inode *inode =3D container_of(head, struct inode, i_rcu);
>  -	kmem_cache_free(orangefs_inode_cache, ORANGEFS_I(inode));
>  +	struct orangefs_inode_s *orangefs_inode =3D ORANGEFS_I(inode);
>  +	struct orangefs_cached_xattr *cx;
>  +	struct hlist_node *tmp;
>  +	int i;
>  +
>  +	hash_for_each_safe(orangefs_inode->xattr_cache, i, tmp, cx, node) {
>  +		hlist_del(&cx->node);
>  +		kfree(cx);
>  +	}
>  +
>  +	kmem_cache_free(orangefs_inode_cache, orangefs_inode);
>   }
>  =20
>   static void orangefs_destroy_inode(struct inode *inode)
> @@@ -148,17 -136,8 +147,15 @@@
>   	gossip_debug(GOSSIP_SUPER_DEBUG,
>   			"%s: deallocated %p destroying inode %pU\n",
>   			__func__, orangefs_inode, get_khandle_from_ino(inode));
> -=20
> - 	call_rcu(&inode->i_rcu, orangefs_i_callback);
>   }
>  =20
>  +static int orangefs_write_inode(struct inode *inode,
>  +				struct writeback_control *wbc)
>  +{
>  +	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_write_inode\n");
>  +	return orangefs_inode_setattr(inode);
>  +}
>  +
>   /*
>    * NOTE: information filled in here is typically reflected in the
>    * output of the system command 'df'
> @@@ -316,8 -295,8 +313,9 @@@ void fsid_key_table_finalize(void
>  =20
>   static const struct super_operations orangefs_s_ops =3D {
>   	.alloc_inode =3D orangefs_alloc_inode,
> + 	.free_inode =3D orangefs_free_inode,
>   	.destroy_inode =3D orangefs_destroy_inode,
>  +	.write_inode =3D orangefs_write_inode,
>   	.drop_inode =3D generic_delete_inode,
>   	.statfs =3D orangefs_statfs,
>   	.remount_fs =3D orangefs_remount_fs,

This is now a conflict between the orangefs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/mFKah/s06g_pbu_IdFbkSiv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzSKr8ACgkQAVBC80lX
0GwrAAf9FtwBBdi03JFGG9l2IjjjJf9pOinYs92SKyDIPizWAqc01T2kafzGDhgY
wYZNk9ZAvlODZk10z4Zk1r1KEFVBqcRsB3Enp8oQx14RRjI3d9vB1XLGHE7R3ahS
lgpQIYmAljQpNy5tYPwO7pk8gMPAHVL1YukCWUUcY67rj9LB3xUD5C0ctzRjhDxb
1N486Cd/7tzLoIPsYDo5VyCq2BMdlLX79URxcvX9y5WsF5Do1MtOt7Cez6SlA9T7
AAgJ3AMM0XS8dK3XeyctNqZZCTrcUDNpsqF3OUK2oyvEag3jNJtEaTGrPT+b+XFW
KjNjB8AYxTd8HpAkuIhjuh8V31ZZOw==
=UUIB
-----END PGP SIGNATURE-----

--Sig_/mFKah/s06g_pbu_IdFbkSiv--
