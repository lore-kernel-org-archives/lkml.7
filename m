Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8993FC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B7D2084A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CtdS7i61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfGHIoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:44:11 -0400
Received: from ozlabs.org ([203.11.71.1]:50111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729555AbfGHIoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:44:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hzWp2ps6z9sNy;
        Mon,  8 Jul 2019 18:44:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562575446;
        bh=9iHnAV5x+eygmg72q9V9IpKKCZ5gF1idv4hhMUU9d1w=;
        h=Date:From:To:Cc:Subject:From;
        b=CtdS7i61kZ2nJIP99nJ7iZcpJOgnpZR9Bn6GsDLtyE17ipw5smgUD1DBihzJuCdtV
         hy9UI/6xHnn3W1hb9l/z4sCSTsJ3bm60M3HM4E9yAoVJ6UnI/PDJnTs4pKFdlpsHYg
         3tu0DrihODx54qVjbAkwqeHulXYwvZ42ecaTAjKnfGHkCoEWFHhf7YEMp5g9lapOC3
         KE2d/7KqLTl7xuGXP/syCOkvYgdcSzezHu/EEJjkUec9yNuDyVdnKghWlXV4ZktPsf
         UIovBvUW7ZSfFcipgP3d/80eKN9iTq67AV2nawogQHW22l7+sa4yac7LApj8u6Cc0z
         gp4OEaILS6nCA==
Date:   Mon, 8 Jul 2019 18:44:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Trond Myklebust <trondmy@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: linux-next: manual merge of the driver-core tree with the nfs tree
Message-ID: <20190708184402.4cd912ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uXRP4x1pD_=gQ7L6IDWX1GM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uXRP4x1pD_=gQ7L6IDWX1GM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  net/sunrpc/debugfs.c

between commit:

  2f34b8bfae19 ("SUNRPC: add links for all client xprts to debugfs")

from the nfs tree and commit:

  0a0762c6c604 ("sunrpc: no need to check return value of debugfs_create fu=
nctions")

from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/sunrpc/debugfs.c
index 105bea190a45,707d7aab1546..000000000000
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@@ -118,60 -117,40 +117,52 @@@ static const struct file_operations tas
  	.release	=3D tasks_release,
  };
 =20
 +static int do_xprt_debugfs(struct rpc_clnt *clnt, struct rpc_xprt *xprt, =
void *numv)
 +{
 +	int len;
 +	char name[24]; /* enough for "../../rpc_xprt/ + 8 hex digits + NULL */
 +	char link[9]; /* enough for 8 hex digits + NULL */
 +	int *nump =3D numv;
 +
 +	if (IS_ERR_OR_NULL(xprt->debugfs))
 +		return 0;
 +	len =3D snprintf(name, sizeof(name), "../../rpc_xprt/%s",
 +		       xprt->debugfs->d_name.name);
 +	if (len > sizeof(name))
 +		return -1;
 +	if (*nump =3D=3D 0)
 +		strcpy(link, "xprt");
 +	else {
 +		len =3D snprintf(link, sizeof(link), "xprt%d", *nump);
 +		if (len > sizeof(link))
 +			return -1;
 +	}
- 	if (!debugfs_create_symlink(link, clnt->cl_debugfs, name))
- 		return -1;
++	debugfs_create_symlink(link, clnt->cl_debugfs, name);
 +	(*nump)++;
 +	return 0;
 +}
 +
  void
  rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
  {
  	int len;
 -	char name[24]; /* enough for "../../rpc_xprt/ + 8 hex digits + NULL */
 -	struct rpc_xprt *xprt;
 +	char name[9]; /* enough for 8 hex digits + NULL */
 +	int xprtnum =3D 0;
 =20
- 	/* Already registered? */
- 	if (clnt->cl_debugfs || !rpc_clnt_dir)
- 		return;
-=20
  	len =3D snprintf(name, sizeof(name), "%x", clnt->cl_clid);
  	if (len >=3D sizeof(name))
  		return;
 =20
  	/* make the per-client dir */
  	clnt->cl_debugfs =3D debugfs_create_dir(name, rpc_clnt_dir);
- 	if (!clnt->cl_debugfs)
- 		return;
 =20
  	/* make tasks file */
- 	if (!debugfs_create_file("tasks", S_IFREG | 0400, clnt->cl_debugfs,
- 				 clnt, &tasks_fops))
- 		goto out_err;
+ 	debugfs_create_file("tasks", S_IFREG | 0400, clnt->cl_debugfs, clnt,
+ 			    &tasks_fops);
 =20
 -	rcu_read_lock();
 -	xprt =3D rcu_dereference(clnt->cl_xprt);
 -	/* no "debugfs" dentry? Don't bother with the symlink. */
 -	if (IS_ERR_OR_NULL(xprt->debugfs)) {
 -		rcu_read_unlock();
 -		return;
 -	}
 -	len =3D snprintf(name, sizeof(name), "../../rpc_xprt/%s",
 -			xprt->debugfs->d_name.name);
 -	rcu_read_unlock();
 -
 -	if (len >=3D sizeof(name))
 +	if (rpc_clnt_iterate_for_each_xprt(clnt, do_xprt_debugfs, &xprtnum) < 0)
  		goto out_err;
 =20
 -	debugfs_create_symlink("xprt", clnt->cl_debugfs, name);
 -
  	return;
  out_err:
  	debugfs_remove_recursive(clnt->cl_debugfs);

--Sig_/uXRP4x1pD_=gQ7L6IDWX1GM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jAlIACgkQAVBC80lX
0Gx/hwf+OdQB9hhf8/q2PaTAveekef/bng7zIuO+8jukNi1ufafFfmBi2JzywSbI
wSlYbT54SHDfTuUFYbKjMBsWiR/sxUJ++Kn5bWd/shhImYfZ7H6hKq0Zbifxi3w5
bduOIJ+hH8RMUyat2XorJHIQRyzC0CGNKEjSNjnHeo3A8woQWN+jg3q++g5KhOTD
mgPLzgDi1yvfd46/yYM0oVI7Ak08NlxL//lT76h90DI84NU9/NHaB4ea9CfUDtOL
+u+84qPqnlHp8NlE+RRBhtkY3pZU2YRAfml6FZCc83kSPY13AjSpqDIPYC70nVKP
q9S/lOoIXaQXvjTeEKc8K5kZR8KCfQ==
=KalS
-----END PGP SIGNATURE-----

--Sig_/uXRP4x1pD_=gQ7L6IDWX1GM--
