Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBADAC06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB65D213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C85ESt3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfGAKfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:35:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfGAKfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:35:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ckKH4kRwz9s3Z;
        Mon,  1 Jul 2019 20:35:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561977318;
        bh=twv9ZwZIcLJxhwfM23HN07nH1DlurVQxgtYqVvpMQvY=;
        h=Date:From:To:Cc:Subject:From;
        b=C85ESt3DSmvv/SR8ibcZTUYp+nLU0SZZ2BmwdvkJcigltjtdVQVw9m5+a2GbVyemF
         Zz1kt/OmM8TOlafkIkIS9FlTgIJwqVWTZolr+jK+7J/MHCuh5wTCj09X3nAQWZMRDV
         efdYHa3IX3ID9NEaGF4kUj1PiVJOY+Ob3k3pnOxAqKrKSZ5rAnOUR3blMh3detG9So
         GjKBJOiP5ZKVgdpNmWIv0tCdxxgovrSQNmFcyB5mlPs9pQK+sOoPT7T0YBgq6qiFT2
         0NYYEKtkR+W71v+c0OaipUTKnuT38h02QWsmbtfD+LkHy2hdOSmZ+vA7eOIaBJzaK9
         3h9NSDAyrBHFg==
Date:   Mon, 1 Jul 2019 20:35:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20190701203513.2ee7785b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/juO=KC=RF+2vh0RvUOYM=br"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/juO=KC=RF+2vh0RvUOYM=br
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pidfd tree got a conflict in:

  kernel/fork.c

between commits:

  9014143bab2f ("fork: don't check parent_tidptr with CLONE_PIDFD")
  6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")

from Linus' tree and commit:

  7f192e3cd316 ("fork: add clone3")

from the pidfd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/fork.c
index 947bc0161f9c,4114a044822c..000000000000
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@@ -1755,7 -1794,7 +1776,8 @@@ static __latent_entropy struct task_str
  	int pidfd =3D -1, retval;
  	struct task_struct *p;
  	struct multiprocess_signals delayed;
 +	struct file *pidfile =3D NULL;
+ 	u64 clone_flags =3D args->flags;
 =20
  	/*
  	 * Don't allow sharing the root directory with processes in a different
@@@ -2030,16 -2070,7 +2050,16 @@@
  			goto bad_fork_free_pid;
 =20
  		pidfd =3D retval;
 +
 +		pidfile =3D anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
 +					      O_RDWR | O_CLOEXEC);
 +		if (IS_ERR(pidfile)) {
 +			put_unused_fd(pidfd);
 +			goto bad_fork_free_pid;
 +		}
 +		get_pid(pid);	/* held by pidfile now */
 +
- 		retval =3D put_user(pidfd, parent_tidptr);
+ 		retval =3D put_user(pidfd, args->pidfd);
  		if (retval)
  			goto bad_fork_put_pidfd;
  	}

--Sig_/juO=KC=RF+2vh0RvUOYM=br
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0Z4eEACgkQAVBC80lX
0GxAKwf+JQLGkfRto9OdZsLPVfIgw4TM+9nOMTQ9BrgvFsONFX5J1VkO5KDZZQEj
ejqsJkI26FT0Y0ZEAsXJ/FnMXIMnv+iIxi3SD3pvS7lvUM2V6h+/gTxd3ErUDQuy
bmSI77jlK07kdwh84umC0pKfTmOLCZGQfUoJaLmPFNyAaitg6FIjQYQFRqxxhn/v
bqF+Q/f0SByCtY6AsPWea2LBhkSseByjGCfTTPGicAcssEJKypG/wMUdiO/bUF2W
X8KZlpVXgjoxIHPXFxatFv7yKZCl8bbCMWaSiiU8+Y8i/lpWUx5cW8R/eR4OvIzM
GpOp/5qoVtFL7NjLlZhsb7VtK7z+ag==
=M+WN
-----END PGP SIGNATURE-----

--Sig_/juO=KC=RF+2vh0RvUOYM=br--
