Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C73FC04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 03:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E180F2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 03:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U3SAhg0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEODQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 23:16:38 -0400
Received: from ozlabs.org ([203.11.71.1]:48307 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfEODQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 23:16:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 453fpq58frz9sB8;
        Wed, 15 May 2019 13:16:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557890196;
        bh=IougcBQo/3IwBr3UVGFgXOGRwtCmGc6GD1W2IioGNS0=;
        h=Date:From:To:Cc:Subject:From;
        b=U3SAhg0jGR0tW7Qeik9Ug4S19FW1b+pQ5PvP9jNNOv7an9QzcBRwU+8gSYTote3jB
         M27s2eJCReGLwC1tL71ijwyBb3miuJ49oPiU/vpUah1XVEyI4/z8WX9Zau5zms7W9Z
         I7V4kbqsUAd5yu6bz7GxeX0gsXRrGJJa4NYb5T6d7pA/9Cgv7vGluTi7HyVus9Z+xb
         IRKmsKBSnd8H/YrvTHH3HFMrlXexMjDnRp3xhnji1903ZNodT44WZTcjnzRcx+F8Hq
         jqE2YSJnNWWdpQrRo9Ql8d3aO6uyvsv3DcZAnzMI49gg497QhkCzGIWCyzXW3YAsIa
         ZZMeLOJ6BUPZw==
Date:   Wed, 15 May 2019 13:16:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: linux-next: manual merge of the akpm-current tree with the pidfd
 tree
Message-ID: <20190515131629.405837b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pJ_20YllzkTvP8BoZaX1AE/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pJ_20YllzkTvP8BoZaX1AE/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  include/linux/pid.h

between commit:

  51f1b521a515 ("pidfd: add polling support")

from the pidfd tree and commit:

  c02e28a1bb18 ("kernel/pid.c: convert struct pid:count to refcount_t")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/pid.h
index 1484db6ca8d1,0be5829ddd80..000000000000
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@@ -3,7 -3,7 +3,8 @@@
  #define _LINUX_PID_H
 =20
  #include <linux/rculist.h>
 +#include <linux/wait.h>
+ #include <linux/refcount.h>
 =20
  enum pid_type
  {

--Sig_/pJ_20YllzkTvP8BoZaX1AE/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzbhI0ACgkQAVBC80lX
0GzTiggAlOOvTzElTR5o4UckTt3ds7Iko11bpza1zqLRhR5XN2Wgo0CTP9FDHvaN
MtXdFlHIRF2NKE8bbQc6ndHOorS2afTq8T4k2TU9vF32ZvviRa10jsjb7F+RzFpi
S3VDA+er2ZvzOw4237yMiIB4MxptyDLjGn5IBaCkWW2KybCn7pqkTpAXLASg7Lhb
bZ0ajPxX3Xtk/TSSSPtJ6XMZMuPvIHYYybluZ0GQi98WwXu8bVRP5baeu0kDbEda
oOoXcEn2MELXeb9P05OdZJf54Z/sQDmOvOcOQ/E0lK9t6vFFXMhBneKcit+AJFTq
27HgHGUiuUse+9BOoBd2ntHNh8XPoQ==
=DZqo
-----END PGP SIGNATURE-----

--Sig_/pJ_20YllzkTvP8BoZaX1AE/--
