Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DD6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501F320675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fw3vOv13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfCFFx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 00:53:29 -0500
Received: from ozlabs.org ([203.11.71.1]:59931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfCFFx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 00:53:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Djc42nkxz9s9T;
        Wed,  6 Mar 2019 16:53:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551851606;
        bh=laNqj5WYWxPNNssbLanzQubyLGHBQac/J9CedDtRrgQ=;
        h=Date:From:To:Cc:Subject:From;
        b=fw3vOv13DDmFzZf5hVC4t81Vp2XKtwcdCFeYm+jRuFpxHZaIGRuX+q54qEfTB2rCI
         QtJy8pbVQyH51uVcJDJCTfArTmnQcJtgFk4cftMT86mUDKOs1XdgJd7Iihr++F6Ip9
         2QyEyIvnx+U7m+gzvhhE3dysXhnKYktDDB7LBQPPGce98d0HT5NJKX27rEtbTVgtLw
         mXkFKRJuJFot17FuoU4U5Vk5wo2Bb2SyyyM4A/4DTJqixIsI/ey0m+Tp0HCRg5b+zo
         O/+QlBpuY3w0wMh846Mr0LoJnhsbxdweRHniXdba3GyPUAy6Z48fljiW8zYXGairyf
         hQDNcjjrbvhlw==
Date:   Wed, 6 Mar 2019 16:53:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Borislav Petkov <bp@suse.de>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20190306165321.681712d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xxf0+bjchqGOdpU3OtBvoX+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xxf0+bjchqGOdpU3OtBvoX+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/um/Kconfig

between commit:

  eac616557050 ("x86: Deprecate a.out support")

from Linus' tree and commit:

  942fa985e9f1 ("32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config op=
tion")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/um/Kconfig
index 494eeb51e4e1,ab14e6f73ca4..a9e80e44178c
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@@ -16,6 -16,8 +16,7 @@@ config 64BI
 =20
  config X86_32
  	def_bool !64BIT
 -	select HAVE_AOUT
+ 	select ARCH_32BIT_OFF_T
  	select ARCH_WANT_IPC_PARSE_VERSION
  	select MODULES_USE_ELF_REL
  	select CLONE_BACKWARDS

--Sig_/xxf0+bjchqGOdpU3OtBvoX+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx/YFIACgkQAVBC80lX
0Gz22Af/enj2lc2djVHy4zZOzB0Dso/qgMFo7WeIsD+eIGiJeCjGt6/25cOZ4wqc
tvXMDIbzrHQIU+dgtyPWK7SqgfXm64uaATI9jp/xdj8JudLFYKBCxOdkeiY0MSWR
MVI3lU0n8f20CZUNhSbl6ghorZAX4yavAnwb9l/CBsoA8YzJjpA6/Stgw3G7AilC
p1eb7C21X6wGdzVF076ohdqNCW6oZJaV6g1P6XA2EFTBmEeF2sFFMaBuzYmQtbFK
FUpetWHfYjUBaIpmhNi5i4lVDLjLTA5Gkb8NrSqWqhEr96IJDb0hOioqHQ6xiStQ
8PAvUYAer8r+BJAqbUVrbcWFmZplhw==
=bgc7
-----END PGP SIGNATURE-----

--Sig_/xxf0+bjchqGOdpU3OtBvoX+--
