Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F1FC06516
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCF52189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kmibXhUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGDIoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:44:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57001 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfGDIoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:44:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fWjl6KFwz9s4Y;
        Thu,  4 Jul 2019 18:44:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562229853;
        bh=BfI+aKrKS5+qiB+uztSNAtnY+XmwQbxDCaV5eXuYOE0=;
        h=Date:From:To:Cc:Subject:From;
        b=kmibXhUAPyicgxFqayHCtnmLyRCrA0GwLTiC8OBvUFiN3P4Q25Bqj74bnpz37WOlM
         CmHwsRUETndMJCaa7/da4TceBbizVpLc1vEjLUG1BRgAgZxPUnMyavIiArkzucfxNG
         +qeQkPJMCgPvws0F39T7bp09CyBkp3SMjo+Qt+LLfy7S5kKHDXXyQccPpPrpgikEA5
         AFmlY6YsSqJgub+HeYpe0sDxr4+czwC1OFRLD+hTLadbXGgQVEYi8gre3ZMcPtn7a9
         rC766rzrexgWxJQbQG5kPwsIQXg2zb/uzNgcCKAGdajLesRq0eM5Mr5dRQ3c48VI+l
         B/bcPAFjX4pLQ==
Date:   Thu, 4 Jul 2019 18:44:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20190704184408.30beea65@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XBT68L92cQ4NHqqdFPdeCxJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XBT68L92cQ4NHqqdFPdeCxJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pidfd tree got a conflict in:

  kernel/fork.c

between commits:

  6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")
  28dd29c06d0d ("fork: return proper negative error code")

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
index 847dd147b068,4114a044822c..000000000000
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
@@@ -2030,17 -2070,7 +2050,17 @@@
  			goto bad_fork_free_pid;
 =20
  		pidfd =3D retval;
 +
 +		pidfile =3D anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
 +					      O_RDWR | O_CLOEXEC);
 +		if (IS_ERR(pidfile)) {
 +			put_unused_fd(pidfd);
 +			retval =3D PTR_ERR(pidfile);
 +			goto bad_fork_free_pid;
 +		}
 +		get_pid(pid);	/* held by pidfile now */
 +
- 		retval =3D put_user(pidfd, parent_tidptr);
+ 		retval =3D put_user(pidfd, args->pidfd);
  		if (retval)
  			goto bad_fork_put_pidfd;
  	}

--Sig_/XBT68L92cQ4NHqqdFPdeCxJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dvFgACgkQAVBC80lX
0GwHyQf+JnUv0jiKgw164UD9y36qZy6xVpNaLCQxY0afh1mMrmWZE0MUSff+4O6K
1TxoO5+3OPlWUQondZgbAK2zUTUe9++HOZF+7t6sTHpwerCQpiTSllCEfpPO8moo
2u2o0Awalsqm67sJ8qk3pG9jlfkzpD4Jm+HH96lafuZmu9Jpo8LjEcn6oVAHjBsM
11Z0TOI2LFBLYh0r0U1LV0rwH4UeCjavpF08JYCHTuHeC2piivg3s1p2T2Qouknx
2Mqd5QzTvqELwntIXObG+Ax9DM0ve4AhgP4cFIhFLSCTGkW1g+FWO4YnwYhVyIzg
6FghEm7Bm0T4keVshUcJnbXmeIGLbA==
=W1Vf
-----END PGP SIGNATURE-----

--Sig_/XBT68L92cQ4NHqqdFPdeCxJ--
