Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD71C48BD8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96583205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JEtwILZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFZLWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:22:25 -0400
Received: from ozlabs.org ([203.11.71.1]:35679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZLWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:22:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Ygbw4g4rz9s4V;
        Wed, 26 Jun 2019 21:22:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561548141;
        bh=O1fng1ydEQKNvr7BKHmOIggvW6lgAw2nYp3TVsn7JsE=;
        h=Date:From:To:Cc:Subject:From;
        b=JEtwILZAMBCv+GikHNX4V0QP701EdiuyWYnoMAnlbSlU5XE+Q4p5auonDzFcTvZaE
         3VZgBg3QARIJDG4u5gZtU2jMgIH5DASc6/mC8E64CR9KceKi4zCPSJbhynqwCDqb6x
         TuIbk8TJSrtmmlaLw6uzNykR0huTtBSf4t4J2kKQKI8W9RDC/ZP1FwTbl7VF7TQocD
         q3BAnYD3D3aDC/f0EM1Ht6GLH18JbFnnt07gUqAQE74tl3ljCyM2cKkkmbD5acgtUt
         qXQLwCS99G0kDtueYfsewaIVxi+CX6Y976tJ6yC0HTWBBK5jtM00Qg3UheHG5SoDb3
         wrcp5vTePtlUQ==
Date:   Wed, 26 Jun 2019 21:22:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20190626212212.25b41df4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/o4FyHtmZuu_71.mcJ3c_DS8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o4FyHtmZuu_71.mcJ3c_DS8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

After merging the amdgpu tree, today's linux-next build (powerpc
allyesconfig) failed like this:

In file included from drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:25:
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c: In function 'gfx_v10_0_cp_gfx_resum=
e':
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:27: error: 'CP_RB1_CNTL__BUF_SW=
AP_MASK' undeclared (first use in this function); did you mean 'CP_RB_CNTL_=
_BUF_SWAP_MASK'?
  tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
                           ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1067:36: note: in definition of macro '=
REG_FIELD_MASK'
 #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
                                    ^~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:8: note: in expansion of macro =
'REG_SET_FIELD'
  tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
        ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:27: note: each undeclared ident=
ifier is reported only once for each function it appears in
  tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
                           ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1067:36: note: in definition of macro '=
REG_FIELD_MASK'
 #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
                                    ^~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:8: note: in expansion of macro =
'REG_SET_FIELD'
  tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
        ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:27: error: 'CP_RB1_CNTL__BUF_SW=
AP__SHIFT' undeclared (first use in this function); did you mean 'CP_RB0_CN=
TL__BUF_SWAP__SHIFT'?
  tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
                           ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1066:37: note: in definition of macro '=
REG_FIELD_SHIFT'
 #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
                                     ^~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2628:8: note: in expansion of macro =
'REG_SET_FIELD'
  tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, BUF_SWAP, 1);
        ^~~~~~~~~~~~~

Caused by commit

  a644d85a5cd4 ("drm/amdgpu: add gfx v10 implementation (v10)")

I have disabled that driver for today.  Please let me know when it is
fixed so that I can enable it again.
--=20
Cheers,
Stephen Rothwell

--Sig_/o4FyHtmZuu_71.mcJ3c_DS8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0TVWQACgkQAVBC80lX
0GwLGAf/UfZkehdVWkAXVR10FVfxYTG1qBP5PP//SVPA5WmLupBt3Q3fS2RneViN
+oU/Enn6ooGk5uiT74wkWoz7YjiNPlucyv9DRTF/I8rY6e/GkQZrrjvWn0DhE4q9
2kpMyfV7CLW7SnfJiXFjPnAbvqiXFp7mIULSvjKcWMNxC+nQ6cFpZBkfXkzSfyD8
kiq+p8T4+MOyo1HBhFXgybRkZ3fFVz2qIR8RmGMgo0UMz6WX+a90D51XezNHm+44
ng9vrnwj35RXmuf0fw+HzhCgahCDT3pbXt29ZLGJh97PzKdJ88pTWfdVLeo+r/Mq
yISDZnFuUtzVJtYwoGKmY1hG+AwVyg==
=koc3
-----END PGP SIGNATURE-----

--Sig_/o4FyHtmZuu_71.mcJ3c_DS8--
