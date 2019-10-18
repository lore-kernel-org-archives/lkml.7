Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D3BCA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE3A21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oncUhKrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392198AbfJRGAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:00:50 -0400
Received: from ozlabs.org ([203.11.71.1]:39977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731843AbfJRGAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:00:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46vb4F5mbcz9sP6;
        Fri, 18 Oct 2019 17:00:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571378446;
        bh=60ewmAB7QXvwdlwLfmq4cIwU3Hc9aFogqwrAB0oeu0A=;
        h=Date:From:To:Cc:Subject:From;
        b=oncUhKrCB9ZHOX2bHPNHKNF44fZV2hVYuQlKlrXfxa2QpfhcmhPeBFRIkQGiH8tDz
         fTkLEIXbfh3DmeJvyV+GvhN6mOVYWciqqaODZ4DxsC77kpeuUXWYWK0AruO9MrkSyZ
         My0dYmrOo+up0uEbDKTMG+cBi7rmcEokYfX06OA9kiAxY6JjxvwE99cA2KyUt7YQ4o
         NxZSM101+pixRiUJUIZhHekiiosmkteJmWsto8WqHdW1la4Sd3fBahg5ixRyrT0lti
         4W33f6088I5OGkpXes82f9wDwZYKVucsVMiyBS8cNtD3wxfrfvzt0K3nFM6FWsFZXl
         hORJfFnqTRH4A==
Date:   Fri, 18 Oct 2019 17:00:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Changbin Du <changbin.du@gmail.com>
Subject: linux-next: manual merge of the akpm-current tree with the printk
 tree
Message-ID: <20191018170045.1c2b624e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XFRzzwHgo9hLnYc=8qy9BXX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XFRzzwHgo9hLnYc=8qy9BXX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  lib/Kconfig.debug

between commit:

  57f5677e535b ("printf: add support for printing symbolic error names")

from the printk tree and patch:

  "kernel-hacking: move DEBUG_BUGVERBOSE to 'printk and dmesg options'"

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

diff --cc lib/Kconfig.debug
index 045ef7caeb49,83bb867fcb6f..000000000000
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@@ -164,15 -164,15 +164,24 @@@ config DYNAMIC_DEBU
  	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
  	  information.
 =20
 +config SYMBOLIC_ERRNAME
 +	bool "Support symbolic error names in printf"
 +	default y if PRINTK
 +	help
 +	  If you say Y here, the kernel's printf implementation will
 +	  be able to print symbolic error names such as ENOSPC instead
 +	  of the number 28. It makes the kernel image slightly larger
 +	  (about 3KB), but can make the kernel logs easier to read.
 +
+ config DEBUG_BUGVERBOSE
+ 	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EXPERT
+ 	depends on BUG && (GENERIC_BUG || HAVE_DEBUG_BUGVERBOSE)
+ 	default y
+ 	help
+ 	  Say Y here to make BUG() panics output the file name and line number
+ 	  of the BUG call as well as the EIP and oops trace.  This aids
+ 	  debugging but costs about 70-100K of memory.
+=20
  endmenu # "printk and dmesg options"
 =20
  menu "Compile-time checks and compiler options"

--Sig_/XFRzzwHgo9hLnYc=8qy9BXX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2pVQ0ACgkQAVBC80lX
0GxuXwf7BRclE8NsqVQsrAt9NxPkN85pOOcsqvrE6N4MfH0drgiZJOpSMLvuRSru
PBwST03aMk5wXhsjILNOHr+9NkuUJnHlrTXaLyqMAuEwm2FhHH6Vk/hzPDPIkKL0
6XUkx4P0mirfiyQSGZjL9zXrgtej+Ov7NNWtEDatbdMt1YoRBLMTbLGnhM+Q7r2P
+aZtQvS2tPx8SqOdzpPCbonfNtrIivTl427/4rVnSEEuvaTDEksG69YStUbW9CyN
A4MUik3lOfWJVVEfDLswa2WbHbmGtekskKFEOLQoKKGtRUGfuTPfgS1CLEux36+P
9c6ImOpPL8CBprzp1HXBfc6AJzZxHQ==
=x/VE
-----END PGP SIGNATURE-----

--Sig_/XFRzzwHgo9hLnYc=8qy9BXX--
