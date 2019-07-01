Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF57DC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 23:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C108A20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 23:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Uons06qY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGAXJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 19:09:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfGAXJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 19:09:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45d33W5HBVz9s00;
        Tue,  2 Jul 2019 09:09:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562022568;
        bh=US0LjfjVcnRZoZU6p2IS6+DprGUL5L327gB/z/lazTw=;
        h=Date:From:To:Cc:Subject:From;
        b=Uons06qYdTZkktHRBeo5dSwIl8dTfs8JZbKKKt7RA3ZLHmN0IAryVW0PeO4OnulOY
         hziZFB1e29FiHHc8x4Ze7zyB2ogrXZdesSrnYFuCBFFBIw+HHWwvp3tB+/fIG6j4Ak
         4UTMQ+nze/nUKsLsvHNEhJw3W9lC4rvW3r+XMNcqPDNX+6VhApMMk5X3oPWgNwoJo4
         fPGdOH3NevGknIIEUH1t2stzOYt4q6ztwtxqU+7/hjPgZOlBF24zo8lnTyiKGGqmnp
         ZSdFKXSaS7tzxUrG6nRSyqkxoO7lH3etod9PyIyOSp3viSafc26gJSH3xFZgHo19LC
         +smU3nJ+gW2Xw==
Date:   Tue, 2 Jul 2019 09:09:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Ungerer <gerg@snapgear.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the m68knommu tree with the m68k tree
Message-ID: <20190702090912.6a9db396@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oI4OoWPyq8Ce_6oUSklHnyv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oI4OoWPyq8Ce_6oUSklHnyv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the m68knommu tree got a conflict in:

  arch/m68k/Kconfig

between commits:

  34dc63a5fb9b ("m68k: Use the generic dma coherent remap allocator")
  69878ef47562 ("m68k: Implement arch_dma_prep_coherent()")

from the m68k tree and commit:

  bdd15a288492 ("binfmt_flat: replace flat_argvp_envp_on_stack with a Kconf=
ig variable")
  aef0f78e7460 ("binfmt_flat: add a ARCH_HAS_BINFMT_FLAT option")

from the m68knommu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/m68k/Kconfig
index 00f5c98a5e05,c0c43c624afa..000000000000
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@@ -3,13 -3,12 +3,15 @@@ config M68
  	bool
  	default y
  	select ARCH_32BIT_OFF_T
+ 	select ARCH_HAS_BINFMT_FLAT
 +	select ARCH_HAS_DMA_MMAP_PGPROT if MMU && !COLDFIRE
 +	select ARCH_HAS_DMA_PREP_COHERENT
  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
  	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
  	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
  	select ARCH_NO_PREEMPT if !COLDFIRE
+ 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 +	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
  	select HAVE_IDE
  	select HAVE_AOUT if MMU
  	select HAVE_DEBUG_BUGVERBOSE

--Sig_/oI4OoWPyq8Ce_6oUSklHnyv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0akpgACgkQAVBC80lX
0GzFfQf+PKe+PEA58frDxjnGZtJwDGHK4NtvxPs/wMwvc2rPtfA4a97eEg6GzCpZ
BpTyx9XEylvAnAEt2U8xLzy6/a79lQ4kXP2L62rA9GzchVeHRK1pcrHnl0xQG4np
6jp4YnXHp7L+5AFdhb4NIKbQuCVBNsIIq3W0O1jEEtrW+jSUbEpB6Ioh9ESpPuP5
DcBfKr0pLMaGK8Sf7Yz1lwbnP60EJi933vh/qxiYtBeTh5M7wfNsI4WpnwDze/6S
MVqvtprWyN2fwQtTDjBsDH5KYzVlsREl+5Zswuh2b3PBYyCiCr5FI2I0o9sVgk7t
6mOdTgR7FkEndCVWvmMg5KxRw+mVtg==
=iuL3
-----END PGP SIGNATURE-----

--Sig_/oI4OoWPyq8Ce_6oUSklHnyv--
