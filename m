Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC6C04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302862173B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VT1Ul3uK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfEJA7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 20:59:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfEJA7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 20:59:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 450X0l5XWyz9sBp;
        Fri, 10 May 2019 10:59:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557449960;
        bh=mAeTHXhVXhp+NZw9SFWSJAY3SKMuDvlZe6GzT36aw1k=;
        h=Date:From:To:Cc:Subject:From;
        b=VT1Ul3uKsKQkqsm2DudQhop69gQwBteC6wQhrfpZF6P/S2BuCf8ZqMoxVcakbZTJy
         oDsl2wtjEuwA1CW5GgPE3usKaEdprW9+TUjJgOTgqK11/GFMrCOL4JwSeVmLWJorkz
         ZgudgLMi4hRsbhSXElVvKiitm509RwG8p6pZkGRoP8RdQS+ejq+qEThbAX+RMDin0g
         LeBk4iVJ4FXT9XWTEI/775K+BvfL7NJXRDe/IhKPxg09OnJjFIgOlNXuAUmeJ2xq3r
         lhGrwKR5P+F1l1E/NLAqp3l+GtwD+OrqDbP+8JkZyAD8wR9oApaKCNSM3idMYzajXV
         WHA9zA47+WRvA==
Date:   Fri, 10 May 2019 10:59:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Kim <jonathan.kim@amd.com>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20190510105913.357c15e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wjdZqcrecLj/0QnYLKM3.fn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wjdZqcrecLj/0QnYLKM3.fn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from drivers/gpu/drm/amd/amdgpu/df_v3_6.c:23:
drivers/gpu/drm/amd/amdgpu/df_v3_6.c: In function 'df_v3_6_pmc_start':
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1010:29: warning: 'lo_val' may be used =
uninitialized in this function [-Wmaybe-uninitialized]
 #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
                             ^~~~
drivers/gpu/drm/amd/amdgpu/df_v3_6.c:334:39: note: 'lo_val' was declared he=
re
  uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
                                       ^~~~~~

Introduced by commit

  a6ac0b44bab9 ("drm/amdgpu: add df perfmon regs and funcs for xgmi")

--=20
Cheers,
Stephen Rothwell

--Sig_/wjdZqcrecLj/0QnYLKM3.fn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzUzOEACgkQAVBC80lX
0Gw1TAf/ai35uQnY98yR9OeNyjhZGsvBCLPPvchvu4uUkyfQC8hcfPNMK6KGUB9f
wc3ncmFVMHkawM0qXR34LZk3yvIXABUoUjT3BNuEgVbGbufSzT5f99P8eWD+MYxv
Bjit6j/peEdr1C0AUysOnqfkdse3Zj4mrnbGIXEzmKYr1fwCwsQaEHxjTt7zFTdf
TQg8A5zoGUOQ0ySa4BiukWEGKfIzdjER1LC18mn5ZhwOYtjCfOg3ZI75XeM4d75Q
TO2iH+YVL9ldjkKM44aDLjuWiwawzeGqs85yuMMCgUDFWNfLsGFfw45gKV2j+ztD
OQqEIZzDk2BghSrbRMXcp4SftkiICg==
=UIhV
-----END PGP SIGNATURE-----

--Sig_/wjdZqcrecLj/0QnYLKM3.fn--
