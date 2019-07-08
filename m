Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92431C5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9A520844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mQGXN5xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfGHHBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:01:41 -0400
Received: from ozlabs.org ([203.11.71.1]:50681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfGHHBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:01:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hxFW0X2dz9s3Z;
        Mon,  8 Jul 2019 17:01:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562569298;
        bh=bMGbYY+lSE5Cbp9Av6xqmzjx/6qiPYjokp+Ycp0jkLw=;
        h=Date:From:To:Cc:Subject:From;
        b=mQGXN5xunPpyWgWK7B4WvaRWwOWb5pe3ZmS8ziNGwwhlGjvUfClALjD9HAjS4CXn3
         4530pRcSjDhTSuTVc6Xi3Gfc2y5MHzxa3B5/N+sAZrroXkO05oGaFdpGWHnDnMmRtj
         a1ox+YujmLS97s7zozea0pAC73HXfyNcmqp5v09dISS5EOYBFnCPkAUY06WTLpuwr6
         zdi8x4l7j9eIaMXHjrzFLU4xYD+kc+JXOdpW/UdJh/OLPMXSo8n6t9h6n0SC5tQVM2
         78F+yseIgXfzhneRSor2kWO+zcJ2Rw/kslqRe9uWP0isoZjlerAQGbgEbqyyVC9vP5
         yqZHpKmgm3/rA==
Date:   Mon, 8 Jul 2019 17:01:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Borislav Petkov <bp@alien8.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yash Shah <yash.shah@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: linux-next: manual merge of the edac-amd tree with the risc-v tree
Message-ID: <20190708170134.15f225ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Dx6LgHkcvDoM2xS/FEnOu3I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Dx6LgHkcvDoM2xS/FEnOu3I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the edac-amd tree got a conflict in:

  arch/riscv/Kconfig

between commit:

  9e953cda5cdf ("riscv: Introduce huge page support for 32/64bit kernel")

from the risc-v tree and commit:

  a1ee570c831d ("EDAC/sifive: Add EDAC platform driver for SiFive SoCs")

from the edac-amd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/Kconfig
index 8bf447b36955,4961deaa3b1d..000000000000
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@@ -51,8 -50,7 +51,9 @@@ config RISC
  	select ARCH_HAS_PTE_SPECIAL
  	select ARCH_HAS_MMIOWB
  	select HAVE_EBPF_JIT if 64BIT
 +	select ARCH_HAS_GIGANTIC_PAGE
 +	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
+ 	select EDAC_SUPPORT
 =20
  config MMU
  	def_bool y

--Sig_/Dx6LgHkcvDoM2xS/FEnOu3I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0i6k4ACgkQAVBC80lX
0GwH2wgAi9+yPQKaDLy9YB+z/0Lmkfle7vlxlItVu10iYdMQ8Oc8H/2wMFQzjpff
evIJ52L5ANoZYAUsMtoM5wKR6uEA6zbZFYvLr3xmv2qHSxR8/Vi6+bCaGd5ENyT/
Hc0WWTRq70o1vMzPdvciGNr2XRJWcMnOhI2tNXPYUhA3NIUhqUoh2ZFsKOjQInR+
FnqtkAFYTwlNTQIaHHEMZ+rjG8Ryilpiis6Zjpn4vNfJRSXLwr0xwf0eG1ztlyFc
iXVXLUUQQWpnuiZBpSPPi+aXzaNEvjGK9OmbH4WBTJhAys+TKxaZqRaLTP+tLxHP
Elu1h5NZZz6n4mxX8bDgEBFhToWErg==
=njlY
-----END PGP SIGNATURE-----

--Sig_/Dx6LgHkcvDoM2xS/FEnOu3I--
