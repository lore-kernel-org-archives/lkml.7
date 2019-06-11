Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47895C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 03:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AE02089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 03:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="q5TYlxbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391024AbfFKDwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 23:52:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42089 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390941AbfFKDwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 23:52:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45NGKJ07Knz9sND;
        Tue, 11 Jun 2019 13:52:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560225124;
        bh=6kjthrPOTPWNQKlDGL3hQSGhKE1EZEUyQV+BEUTX/uQ=;
        h=Date:From:To:Cc:Subject:From;
        b=q5TYlxbV/yk36cmEt8Cq5Uq29SkAYK5S+IeBicjJcTS9JPs3B6J7GrO53k0MGARjm
         MkN2i7goAvrnWiWBT7mCe+FaPZ/9Tb9mNm3jn1zLAy54fkhhIWLiornH1P/kkbEc6A
         NoH+AUGVuCiOWVlzjnyvQ65eE9n+Uw93TPImcFyDx3Sp0y6gOt6H6VQpNARgTjk/ew
         flvgbQeanJK//42/c1W67lHVrsZh66L3we6PVvSV+nxzPNWoQd1GKSad2PHFS0Ux+k
         3N9qLEay6vVVEmck1v9jQ3f2rlUzVaYBXNi96ipt2pJPVWuoyt+1ed0cmKA3NJ/2Ls
         cLf3r3tJAGx0g==
Date:   Tue, 11 Jun 2019 13:52:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20190611135202.145424e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jfim9.VH5cOFoRzquBp6qyc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jfim9.VH5cOFoRzquBp6qyc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c

between commit:

  9b93eb475aa9 ("drm/amd/display: move clk_mgr files to right place")

from the drm tree and commit:

  4fc4dca8320e ("drm/amd: drop use of drmp.h in os_types.h")

from the drm-misc tree.

I fixed it up (I deleted the file and added the following patch) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

I am not sure if this is actually needed but it seemed prudent with the
addition of the kzalloc/kfree calls in this file.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 11 Jun 2019 13:48:08 +1000
Subject: [PATCH] drm/amd/display: merge fix for "drm/amd: drop use of drmp.=
h in os_types.h"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu=
/drm/amd/display/dc/clk_mgr/clk_mgr.c
index eb2204d42337..cb3f6a74d9e3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -23,6 +23,8 @@
  *
  */
=20
+#include <linux/slab.h>
+
 #include "dal_asic_id.h"
 #include "dc_types.h"
 #include "dccg.h"
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/jfim9.VH5cOFoRzquBp6qyc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz/JWIACgkQAVBC80lX
0GxNRwgApUmTX5kjEA+cNRAn68/Axad9xBwda1Zu4g/kvsT/rNgtT6X1OaArVK/i
KX72++Kyo1bggwxeINKmH1Y6PsbnlIHKLD7FcdV0us4Ab43jeB00xU9ENp27OuXb
5cuxkliKZFh7RaFwIyrmNLZaaq0aI6Ciwt+X+EsD1hl5tgyV5wniHERIKO+Qjh9C
OsuiafBoxg7hdXKKcSGNq2tw0PHuYJ10iBduylvmXPOHm81S9JJ8Of13vrfFzJye
W9U6OzTxuu5qsyKPiGulVOPBGMO8SrCs0XedHbiUtvnTK69CfE0bytnyTmLDVamL
IxNmUS+bhE8U4qkJjeGMN5a8PyvMXA==
=QHva
-----END PGP SIGNATURE-----

--Sig_/jfim9.VH5cOFoRzquBp6qyc--
