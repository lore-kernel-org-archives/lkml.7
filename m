Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CEC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9CB20693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m0s5ttCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfGIAZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:25:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfGIAZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:25:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jNPp1Q7Kz9sMQ;
        Tue,  9 Jul 2019 10:25:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562631918;
        bh=mCXItJilGUDpNMpT2L3La6FgFakLWATcr5d+gNWvtiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m0s5ttCLXJGQ7TIkJ7AxR/gBzRZaDvFQJUmcIDVIDVMoWuqSBV6qv8Wa54uNefB5y
         kvWUXiHbitBBNjZ6BiBjRJT/Z3c2SbotP+EG6MwB7+Bxr7zY3wCUacuHTeKXfPHQBK
         xN9dJHte/bSo6fIcoiwYOOc1eYsR/qmsmz9/N/OsKZ+83QuMYZvsHdIOV8iCCga4Gj
         +Sn2G3e4lCdfYjL8UdIzQYAz78w7oJ7MwISPRDTRLRrRmkHGrHILs8y8unkkp0NoEp
         DPxcB+2Rn7ipzNnUNmGHKe7Fa7y/7Np1IRweQ05q/Ah4TcwY491soLO94Fxew1aPiL
         bmp3Ki1xxAGRA==
Date:   Tue, 9 Jul 2019 10:25:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Ungerer <gerg@snapgear.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the m68knommu tree with the m68k
 tree
Message-ID: <20190709102517.26cf1f5e@canb.auug.org.au>
In-Reply-To: <20190702090912.6a9db396@canb.auug.org.au>
References: <20190702090912.6a9db396@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MUG1DsNp=MH8i7YElMs5U9C"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MUG1DsNp=MH8i7YElMs5U9C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 2 Jul 2019 09:09:12 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the m68knommu tree got a conflict in:
>=20
>   arch/m68k/Kconfig
>=20
> between commits:
>=20
>   34dc63a5fb9b ("m68k: Use the generic dma coherent remap allocator")
>   69878ef47562 ("m68k: Implement arch_dma_prep_coherent()")
>=20
> from the m68k tree and commit:
>=20
>   bdd15a288492 ("binfmt_flat: replace flat_argvp_envp_on_stack with a Kco=
nfig variable")
>   aef0f78e7460 ("binfmt_flat: add a ARCH_HAS_BINFMT_FLAT option")
>=20
> from the m68knommu tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/m68k/Kconfig
> index 00f5c98a5e05,c0c43c624afa..000000000000
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@@ -3,13 -3,12 +3,15 @@@ config M68
>   	bool
>   	default y
>   	select ARCH_32BIT_OFF_T
> + 	select ARCH_HAS_BINFMT_FLAT
>  +	select ARCH_HAS_DMA_MMAP_PGPROT if MMU && !COLDFIRE
>  +	select ARCH_HAS_DMA_PREP_COHERENT
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
>   	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
>   	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
>   	select ARCH_NO_PREEMPT if !COLDFIRE
> + 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
>  +	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
>   	select HAVE_IDE
>   	select HAVE_AOUT if MMU
>   	select HAVE_DEBUG_BUGVERBOSE

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

This is now a conflict between the m68knommu tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/MUG1DsNp=MH8i7YElMs5U9C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j3u0ACgkQAVBC80lX
0GxqqAf+M2CwTvSXj6PqB1xdiv9qfNrD0frXZgLxFoHchvtzWHhU5KAuwTwMA0sO
EG3iDGa09hoUeLLjQO5przUOvRsKauGV0ZudNzQY5hpwffkDZ8kjuJlXrxwKJKsO
Xq5pFTS83KLsIX+RnAVEWOzG+vJPOXZPp4JI7nE84lXxl5bjzCjwiRNwBLcUB1cA
7kCCqfSFKeoMOy/UNaQ23LfvmeRvH6JBkNeTs3+MgsH4SjH23eC5QgofEMrth2c5
gnyPit9NhTanzQrUn/hjnc/bqp0pN9h80XGfoFxdAtX7nWWrGi956CVPMUDlfDkw
uvlw0D8bRhpX8VcKCXkzolvHtQR2Lw==
=lsoR
-----END PGP SIGNATURE-----

--Sig_/MUG1DsNp=MH8i7YElMs5U9C--
