Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379D3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C74321848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L6ft1CCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfHVGA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:00:29 -0400
Received: from ozlabs.org ([203.11.71.1]:35283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbfHVGA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:00:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46DYm94dvXz9s00;
        Thu, 22 Aug 2019 16:00:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1566453625;
        bh=VFotkBeoQnghfR8tH06nrgVXHITRs+NJzJpLHEvDidI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L6ft1CCHZbEPcpYc1MaIaZGnmK/0OHRuaD3UwTqiYMsYPDtLykbR75qGc4Sefsbyp
         h1nnEl9JMD6P04QQDEV5gBUQxGQk4XAa95AFy/znQOzrYYkTEdwR2qhOWQlDoTAgVj
         l7DN1dJ8TQ3lwIaHQnngGcXtL7oRvw15Mhvn98g0tokHJsHv9oMx4x4xofVK4PGgOB
         igGL+u4rxmZ4au+mF+pt7kJty3l7CPW3tm1sTTBeOtF6iqQM/HlsGorhbH80IRypnU
         +0ePvYjC63h8GXt26rf3ZBmh47wPwBSLpZ0VB7wfeGH0OQP4MGROrtT3EeQXsXmBi0
         RTSPxnpfn+qcQ==
Date:   Thu, 22 Aug 2019 16:00:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>, jgg@mellanox.com,
        rcampbell@nvidia.com
Subject: Re: [linux-next][PPC][bisected c7d8b7][gcc 6.4.1] build error at
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1471
Message-ID: <20190822155953.79f01e54@canb.auug.org.au>
In-Reply-To: <1566452811.526.7.camel@abdul.in.ibm.com>
References: <1566452811.526.7.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XrmJ+4XahkVTA+0CD=Bp1ls";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XrmJ+4XahkVTA+0CD=Bp1ls
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Abdul,

On Thu, 22 Aug 2019 11:16:51 +0530 Abdul Haleem <abdhalee@linux.vnet.ibm.co=
m> wrote:
>
> Today's linux-next kernel 5.3.0-rc5-next-20190820 failed to build on my
> powerpc machine
>=20
> Build errors:
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c: In function amdgpu_exit:
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1471:2: error: implicit
> declaration of function mmu_notifier_synchronize
> [-Werror=3Dimplicit-function-declaration]
>   mmu_notifier_synchronize();
>   ^~~~~~~~~~~~~~~~~~~~~~~~=20
> cc1: some warnings being treated as errors
> make[4]: *** [drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o] Error 1
> make[3]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
>=20
> It was introduced with commit c7d8b7 (hmm: use mmu_notifier_get/put for
> 'struct hmm')

This should have been fixed in next-20190821.

--=20
Cheers,
Stephen Rothwell

--Sig_/XrmJ+4XahkVTA+0CD=Bp1ls
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1eL3kACgkQAVBC80lX
0GzB2gf+KEISnntYC1xlRdG6xsqu3zj1kkSNXSw5wvXZfw5GsjNgADkRGD9WO4rw
6QBAuxPbdgnp0EtpspqQ8ZFhPfT41MH/NBKRYFTzDs4r6BilnWVUfa6sLK4RA1u/
RkKoy14dluF2c5QE5bqrUTeHPl9CtAELyD1n82c8gX9sCsLqQbEcc+hFJG+V5FPa
0ceqZhcvCOxtSFMDzZsAbLzZFx+7EYaZRoXrmwtv/ufucmuYxOS/BPRakw1EuFY2
4Pkz1bKht8aaFPkl6G8PMV2NT8L1Q9WVuf6xUrB5pZ7XNMVXKqDj/gBFp/QMGPvj
4ZXWp5MjokdY4SV5OxLliFeBsVOv0g==
=lUpR
-----END PGP SIGNATURE-----

--Sig_/XrmJ+4XahkVTA+0CD=Bp1ls--
