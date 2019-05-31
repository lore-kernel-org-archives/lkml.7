Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F96C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455EC261E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SScAYJe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfEaB16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:27:58 -0400
Received: from ozlabs.org ([203.11.71.1]:34097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfEaB16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:27:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FRf20K00z9s3l;
        Fri, 31 May 2019 11:27:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559266075;
        bh=iEZ7SHokno/wMqqDJQwkZOucRZwXo1VW5RkjTVbMOgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SScAYJe51PdK38A1e7jBxa3sNVkP6mmxV7P5+Bg4qRglwTgwgKtVgI92DNHY7JElm
         c6KVSungH2geqFg56S87qMkCnP2ksmjKZUYJ4wbn18vS1W3hmP7FMxnn56tTGAoE5P
         /arZmAytOc/QFNGDAaMZRv5/7P8JOLccTVDu8TGhgQmWni6Pyd5IUL42u28SKjd4DN
         h1ZW9vPf26vSNWfX/la1XtI+qiVd8gNkLyuMwKI8qjp3yIA8AwldF5U+F/Ma3fzcPe
         Dk1uwbA2vS+NnpAb7PebLWKe/HtUpr00aQl8ZI5MJdpEmLmsdtq0B/Np9SlKmFb6ZX
         PHxuDWzizEdow==
Date:   Fri, 31 May 2019 11:27:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Kim <jonathan.kim@amd.com>
Subject: Re: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20190531112752.7f3ca857@canb.auug.org.au>
In-Reply-To: <20190510105913.357c15e3@canb.auug.org.au>
References: <20190510105913.357c15e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SgjzKMuKXe4areELDBT3g40"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SgjzKMuKXe4areELDBT3g40
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 10 May 2019 10:59:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>=20
> In file included from drivers/gpu/drm/amd/amdgpu/df_v3_6.c:23:
> drivers/gpu/drm/amd/amdgpu/df_v3_6.c: In function 'df_v3_6_pmc_start':
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:1010:29: warning: 'lo_val' may be use=
d uninitialized in this function [-Wmaybe-uninitialized]
>  #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
>                              ^~~~
> drivers/gpu/drm/amd/amdgpu/df_v3_6.c:334:39: note: 'lo_val' was declared =
here
>   uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
>                                        ^~~~~~
>=20
> Introduced by commit
>=20
>   a6ac0b44bab9 ("drm/amdgpu: add df perfmon regs and funcs for xgmi")

I now get this warning after merging the drm tree ...

--=20
Cheers,
Stephen Rothwell

--Sig_/SgjzKMuKXe4areELDBT3g40
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwgxgACgkQAVBC80lX
0Gx1DAf+Pbrqe4MgGO3fK7UnBMZtCpEGsyMA27mNVq3S6DRwluPK0S8cnySYNENL
2xiTU6Jwtzh89REYEtpgDpHXYMZDuB4iZWMr9gm3gUXFrtjKJg4DNRy8J6NOIthJ
IQSaW6zDPtdglhTi/w83FCDIiYljb3nqVpTjCn2Rh38SyQXmJOlGS/QeW/NgaH6y
exnRzZDA/UmVffKoEWf9B3wyLpfagRaRoTecSiprDp+Ka7NwIFrUiqdHOlj5FItf
mKLq8Lzz/wPlZDLGA5CEK9Rvc1t28H+NSFuLddLhnAs6TVjHWQzGW5z7uyGcuX+1
2dGlLN50+N0zzj4YD1DA0/sG4hVzAw==
=70m1
-----END PGP SIGNATURE-----

--Sig_/SgjzKMuKXe4areELDBT3g40--
