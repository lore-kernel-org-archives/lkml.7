Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77681C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3747420B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PL2aNmgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEFKhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:37:31 -0400
Received: from ozlabs.org ([203.11.71.1]:39643 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfEFKh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:37:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yK1Y2jlYz9s9y;
        Mon,  6 May 2019 20:37:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557139045;
        bh=2fOyYG+asxh+SSMiPSyCjhhoyUosSzyEWLbHioVeyIE=;
        h=Date:From:To:Cc:Subject:From;
        b=PL2aNmgvhdCSmwE0V02D+Kpg5dty8/xOYpXtL0TrvezU4Q9MP8yziyfi7A7Elpt6M
         sCPQPhUskH6Vlp6QzNWF5r8xn294IxdNjNO0tUtCNMNIHegIDC2xhrvNncsHun4jGX
         u1F2Sa2ihn+LbBYcZ9gBT7p7uURbUmpgzorBxjTS+8tYEPnVD6+8xvOZHxWBgEbAy6
         mOoHSSWAJyTG5XiD8/1+nOWBfA+EqFR5aw9AchFRFXKEORSXzCu2gvKUgeqNEtmB5I
         1p5YW+a7+XH+OjsYzn6cgMlhZ7smrCf0FF0T8fRmjHrxikC7Tg49SXe2JY1UrErNfd
         nfX4jfoIexV9g==
Date:   Mon, 6 May 2019 20:37:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: linux-next: manual merge of the akpm-current tree with the rdma
 tree
Message-ID: <20190506203710.10b080dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3gncj=lu4fwPmti+gIskl1D"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3gncj=lu4fwPmti+gIskl1D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  include/linux/dynamic_debug.h

between commit:

  923abb9d797b ("RDMA/core: Introduce RDMA subsystem ibdev_* print function=
s")

from the rdma tree and commit:

  8dc1ed58157d ("lib/dynamic_debug.c: introduce CONFIG_DYNAMIC_DEBUG_RELATI=
VE_POINTERS")

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

diff --cc include/linux/dynamic_debug.h
index 6c809440f319,08175c219d60..000000000000
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@@ -71,13 -77,12 +77,20 @@@ void __dynamic_netdev_dbg(struct _ddebu
  			  const struct net_device *dev,
  			  const char *fmt, ...);
 =20
 +struct ib_device;
 +
 +extern __printf(3, 4)
 +void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 +			 const struct ib_device *ibdev,
 +			 const char *fmt, ...);
 +
++
+ #ifdef CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
+ #include <asm/dynamic_debug.h>
+ #ifndef DEFINE_DYNAMIC_DEBUG_METADATA
+ # error "asm/dynamic_debug.h must provide definition of DEFINE_DYNAMIC_DE=
BUG_METADATA"
+ #endif
+ #else
  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
  	static struct _ddebug  __aligned(8)			\
  	__attribute__((section("__verbose"))) name =3D {		\

--Sig_/3gncj=lu4fwPmti+gIskl1D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzQDlYACgkQAVBC80lX
0GxkFgf+ONRkS4T1A0ayyhOQWMeJN6RiJKna46rX1c8Y++CaIvFWZ32HXKtQnCiD
1dOXB+sOgxVVqC4Mz05K95kPrLbbBEa4IFExeeZ0j+HY840veFN9mWNwI3MCDZMo
kg/8ebo/odFMJEnrVLijlhPrecXQdp33sI8XFR2qs21exL+4wrh3/sH+ZThtmtmr
oUPxXAHjOO147yQTSaMu4mAQvbHqpWClHx18fFy8JinFvi1kfgIEop9xTH2s69+6
kmPUkjYIIIUrs2qMPZqCNxlXfME9O8nH4Zsev9xixrWXwD5rmXFSj+OUkhc914hI
dMvr947yD8aQHM+LhI0k5a4WBGbBUg==
=T39j
-----END PGP SIGNATURE-----

--Sig_/3gncj=lu4fwPmti+gIskl1D--
