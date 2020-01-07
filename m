Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F42C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB1B2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qVa3ZCDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgAGWgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:36:00 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgAGWf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:35:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47snK63d1Nz9sPJ;
        Wed,  8 Jan 2020 09:35:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578436555;
        bh=5K7yUQoezMG22YaczQTjWBI2s9CqzR+7Y1yt9iqiwo8=;
        h=Date:From:To:Cc:Subject:From;
        b=qVa3ZCDUkwzpku+Jm6SBeOvJGF7OaTNVthlSkDdBritbwx0R/NLDJ6hCef0obL85y
         GeliNjoJmvumvNk97Lmit1L1wMqHcgPbkwoj9xfJsr76k8Cx8OxDWLg/Y+HMI9uAas
         ulqow6Z8YUYSVr3AhVbDHZwfNK/zrjqQSj8DKL97VyGnDTtFcgtFrP2S5jJNq0P+v/
         iPfv3gChAcJrFsmEBwFw3R3+m/lAdxKfdINskzir5WXOeOpKYN0Q9dEMwLQeeQuXk2
         iQjaCBw/rDXkkmhkTWgJHlqE4VGFDdM5edxaPu4kCoPrFEoTJt+Zjm7iEmC3ufrE2W
         xp9FTVUOymdHQ==
Date:   Wed, 8 Jan 2020 09:35:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>,
        Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Nick Hu <nickhu@andestech.com>
Subject: linux-next: manual merge of the risc-v tree with the pidfd-fixes
 tree
Message-ID: <20200108093548.71a9db91@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1gGwnvrxr3zydp08JWaOGPj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1gGwnvrxr3zydp08JWaOGPj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/Kconfig

between commit:

  b57cd1cdb197 ("riscv: Implement copy_thread_tls")

from the pidfd-fixes tree and commit:

  d0f057940663 ("riscv: Add KASAN support")

from the risc-v tree.

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
index fa7dc03459e7,82e7168a81fa..000000000000
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@@ -65,7 -65,7 +65,8 @@@ config RISC
  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
  	select HAVE_ARCH_MMAP_RND_BITS if MMU
  	select ARCH_HAS_GCOV_PROFILE_ALL
 +	select HAVE_COPY_THREAD_TLS
+ 	select HAVE_ARCH_KASAN if MMU && 64BIT
 =20
  config ARCH_MMAP_RND_BITS_MIN
  	default 18 if 64BIT

--Sig_/1gGwnvrxr3zydp08JWaOGPj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4VB8QACgkQAVBC80lX
0Gx3BQf/e16rkxO4kgUKwsSRNY+3ga3hdOPEaUaHKKrTnNbMoaDye28IfhLhG3zu
qU4O/6VyBj5hCD4xdlkKPRf5m2QxHE7c5IF/EEGt7g+8iosh8Qi4c2zgHeykGut/
QmRvMDmVbgo++h5y8rpnKNezOTizaDuDkvMQr8owVqI4f+P7ei4us0IZsk2ZL+GK
7HuCcAq0ERQLUv3rK19mTZl16ixlMsjdfAORSyCF0onRY72OsCWhvWGf7ej5PJ9p
JkGpxsH+5TS00VR4Rx2gKj58P7Ws45FORGH56/JkWLFUYrRv3ckH1ACNL2FArEYC
SFA7urs6VrCMPk2ngB1eCvuEpE7jfQ==
=4gJF
-----END PGP SIGNATURE-----

--Sig_/1gGwnvrxr3zydp08JWaOGPj--
