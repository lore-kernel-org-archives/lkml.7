Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C949FC4321B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 03:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C842145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 03:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pno7smDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391009AbfFKDjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 23:39:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43649 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390881AbfFKDjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 23:39:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45NG282gw8z9s6w;
        Tue, 11 Jun 2019 13:38:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560224337;
        bh=vxmnXIFB0L1T7hBsX03OJT6KvR3/tW13AiSjOeH/2Q8=;
        h=Date:From:To:Cc:Subject:From;
        b=Pno7smDegHfe5vrgJk9FNn91oh8s7ly88wwGyBuNQIKhBGWW08KbTh7cuXh1PjPwe
         ZZoLg+5viMXDwo+apK9R4VZ6wbM6q1fhMOXseouDSIR/dzQG0233t2jlLjQT3phtEV
         8cL9oqf9EIsYRYlYL84JTSwOQpU6zt1TSPjjsXZ6jzvP2ydhORDVZtZSwXPba5dRw/
         TwLZrarRjY+ErB33ZSAx4t0lqN8Xl797QNXmUFf6/4Og+IKZk38lUVSwNBcDdnsOjY
         dlD2HQhtxG5h8JPU390wWidWWlcbrGSoiZx7eRuBmzEZO87PP9Av+QMIAVyPLr8TXM
         kPURafaEXsOmw==
Date:   Tue, 11 Jun 2019 13:38:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Philip Yang <Philip.Yang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20190611133853.0a3fe7e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Xivm8xR72PKe2utnnOYHBD+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xivm8xR72PKe2utnnOYHBD+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c

between commit:

  899fbde14646 ("drm/amdgpu: replace get_user_pages with HMM mirror helpers=
")

from the drm tree and commit:

  c366be543c5e ("drm/amd: drop dependencies on drm_os_linux.h")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7138dc1dd1f4,a8a1fcab299b..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@@ -34,16 -44,9 +44,10 @@@
  #include <drm/ttm/ttm_placement.h>
  #include <drm/ttm/ttm_module.h>
  #include <drm/ttm/ttm_page_alloc.h>
- #include <drm/drmP.h>
+=20
+ #include <drm/drm_debugfs.h>
  #include <drm/amdgpu_drm.h>
- #include <linux/seq_file.h>
- #include <linux/slab.h>
- #include <linux/swiotlb.h>
- #include <linux/swap.h>
- #include <linux/pagemap.h>
- #include <linux/debugfs.h>
- #include <linux/iommu.h>
 +#include <linux/hmm.h>
  #include "amdgpu.h"
  #include "amdgpu_object.h"
  #include "amdgpu_trace.h"

--Sig_/Xivm8xR72PKe2utnnOYHBD+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz/Ik0ACgkQAVBC80lX
0GyJrQgAjO7a9sVVwMaHTvhnLxEJ/Y6S8pnthzCUmo3cSWbOf8BbLBktcgSfGmcC
9PygLcCGcndcACoGIpOCB1pPC7aY3Foz+8ugXkgrx7scjz1GidxxafehSqmeh4AR
feMpvQ0g4atwETqDRVEz3n5820g0RgVk9uYQSwKq6gz9gNOE4uvvsZaee4reyOVO
NWueH6PsmGPApR+2D1VrSrCGFeXRE9/g7fGo3l2V6tPbLHZoo6mxluICbYQa305i
f680TcR9BF+qVzcLGl5pOozrnkeyisVAn2k0poVQESjWm1OhuH/VDzuiQ3qWd3Do
H6pQgHz+Q1vAqtQlsrX0ZKPf8rftVg==
=cOdI
-----END PGP SIGNATURE-----

--Sig_/Xivm8xR72PKe2utnnOYHBD+--
