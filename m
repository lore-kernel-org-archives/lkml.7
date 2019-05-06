Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB710C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF6F206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DklFcPGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfEFKsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:48:30 -0400
Received: from ozlabs.org ([203.11.71.1]:39431 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfEFKsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:48:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yKGL5Sttz9s9T;
        Mon,  6 May 2019 20:48:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557139707;
        bh=pNKBKpxVH2LgQ7vCqLdpkO4eWCHJJGCdllmEafubsSI=;
        h=Date:From:To:Cc:Subject:From;
        b=DklFcPGH9g1L6+JsJn+qMtC+XmBAPsL+qbJzLFhC0VnYHzMScSS1+5CvHDwDhR/xC
         R9Jr8+mElIh7sWu5xTMHuAea4bE2i/vg+/ewZ+7w1WmWCZQfG3Lo2pNeOoqdWGKBbG
         tuRA8rDR7dG33AgICTvFbcIrxQZKh2FD/nAXiJaiio1kLKTLIHysa27g5OQmXA7hKC
         6FsVFzZKU+X9A4BLe0rp5siyY05JVnAo30clIOESI0YM1T9clZVAfSV1OJ7Yjq7m5C
         J2AkE3DIP4Zv1saTDaMVT8HB4oyjscmO6bOTFExMH4vIJFMQWzU5JOfFn2IdWYbqSV
         VcV8OmAXQ2DwQ==
Date:   Mon, 6 May 2019 20:48:24 +1000
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
Message-ID: <20190506204824.11a7b368@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8=Bp9QV4r5ApqToKC=N9mfu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8=Bp9QV4r5ApqToKC=N9mfu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  lib/dynamic_debug.c

between commit:

  923abb9d797b ("RDMA/core: Introduce RDMA subsystem ibdev_* print function=
s")

from the rdma tree and commits:

  c20acb85ecb2 ("lib/dynamic_debug.c: introduce accessors for string member=
s of struct _ddebug")
  686a19fd8999 ("lib/dynamic_debug.c: drop use of bitfields in struct _ddeb=
ug")
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

diff --cc lib/dynamic_debug.c
index 8a16c2d498e9,58288560cc35..000000000000
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@@ -37,8 -37,55 +37,57 @@@
  #include <linux/device.h>
  #include <linux/netdevice.h>
 =20
 +#include <rdma/ib_verbs.h>
 +
+ #ifdef CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
+ static inline const char *dd_modname(const struct _ddebug *dd)
+ {
+ 	return (const char *)dd + dd->modname_disp;
+ }
+ static inline const char *dd_function(const struct _ddebug *dd)
+ {
+ 	return (const char *)dd + dd->function_disp;
+ }
+ static inline const char *dd_filename(const struct _ddebug *dd)
+ {
+ 	return (const char *)dd + dd->filename_disp;
+ }
+ static inline const char *dd_format(const struct _ddebug *dd)
+ {
+ 	return (const char *)dd + dd->format_disp;
+ }
+ #else
+ static inline const char *dd_modname(const struct _ddebug *dd)
+ {
+ 	return dd->modname;
+ }
+ static inline const char *dd_function(const struct _ddebug *dd)
+ {
+ 	return dd->function;
+ }
+ static inline const char *dd_filename(const struct _ddebug *dd)
+ {
+ 	return dd->filename;
+ }
+ static inline const char *dd_format(const struct _ddebug *dd)
+ {
+ 	return dd->format;
+ }
+ #endif
+=20
+ static inline unsigned dd_lineno(const struct _ddebug *dd)
+ {
+ 	return dd->flags_lineno >> 8;
+ }
+ static inline unsigned dd_flags(const struct _ddebug *dd)
+ {
+ 	return dd->flags_lineno & 0xff;
+ }
+ static inline void dd_set_flags(struct _ddebug *dd, unsigned newflags)
+ {
+ 	dd->flags_lineno =3D (dd_lineno(dd) << 8) | newflags;
+ }
+=20
  extern struct _ddebug __start___verbose[];
  extern struct _ddebug __stop___verbose[];
 =20

--Sig_/8=Bp9QV4r5ApqToKC=N9mfu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzQEPgACgkQAVBC80lX
0GyZOAgAjAojmVaqCoSYf1j9INvLmKxwGDCPoMg2eZC62MLZvJHlyo975XBDPBE4
Xb4QlaPEraFy5DOUgyCTMEb3yewXUbAzgq0pkxlKJAIXOT5PdOCw2mXECPVo7+IC
XBwZNYwgI1fZub0TNNIIJ+oNfcjozQ6kJRINCxx1El9N8igahpTxkLhPhkC22ac7
phmsrizRbtd7CKNbL8QB/5twuAu9vo+3k9rEjD+5R+o5O7YBU1fi5DN1E1FF3Ynk
JAWqyI697juck1UjISp4Hp23EOYiJ3N7v5vTdnWysIgRbWFaqNfSwk9jrjcuHw1v
1AP2OGIYA40gyUWu8ae+PIrmu0wVAw==
=y0Hr
-----END PGP SIGNATURE-----

--Sig_/8=Bp9QV4r5ApqToKC=N9mfu--
