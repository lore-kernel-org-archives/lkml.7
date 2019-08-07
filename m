Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7095AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48252217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iVKjA1Ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfHGDJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 23:09:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50897 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfHGDJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:09:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463Ggz26B2z9sDB;
        Wed,  7 Aug 2019 13:09:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565147376;
        bh=hciMHCev9cGV0CU2CP0dmB9i++aefUkurPOQYyCCfQE=;
        h=Date:From:To:Cc:Subject:From;
        b=iVKjA1ZefpsAbshM9XdGUWDwHfmyOJk3pHRAdO+CCNvk4kDDIsjO/t+0VbOSPWjbL
         e2hNF9/G3QtaK2l7T6LgseALRBgGPGB/VFzOzEPThg9RRyauhGDRpCEkfD2lx6VZ87
         GJVN8hiwvSN4JIsUA6oGGBw2YkgJcKwafEqFGMcKngbQXV6cF5lhj560n1J0q5hN5Z
         Itz0PyihNa9/rl0tTua/zLZomWCjYqIETv1KE+wePT/HVTYPBpOmjGwcQVLHz18EV4
         F191H9RHBC5xRpShbLdPi7qGTC11Oq6d9YXtGa6dBnL09rpRyCKV0zh5kiwr7WezbV
         nVKvqWEG4s37A==
Date:   Wed, 7 Aug 2019 13:09:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: linux-next: manual merge of the drm-misc tree with the amdgpu tree
Message-ID: <20190807130933.5491b647@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A4XmEMqHWeGFkMo3c4SEgbH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A4XmEMqHWeGFkMo3c4SEgbH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/ttm/ttm_bo.c

between commit:

  274840e54422 ("drm/ttm: Add release_notify callback to ttm_bo_driver")

from the amdgpu tree and commit:

  b96f3e7c8069 ("drm/ttm: use gem vma_node")

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

diff --cc drivers/gpu/drm/ttm/ttm_bo.c
index 2070e8a57ed8,10a861a1690c..000000000000
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@@ -671,10 -672,7 +672,10 @@@ static void ttm_bo_release(struct kref=20
  	struct ttm_bo_device *bdev =3D bo->bdev;
  	struct ttm_mem_type_manager *man =3D &bdev->man[bo->mem.mem_type];
 =20
 +	if (bo->bdev->driver->release_notify)
 +		bo->bdev->driver->release_notify(bo);
 +
- 	drm_vma_offset_remove(&bdev->vma_manager, &bo->vma_node);
+ 	drm_vma_offset_remove(&bdev->vma_manager, &bo->base.vma_node);
  	ttm_mem_io_lock(man, false);
  	ttm_mem_io_free_vm(bo);
  	ttm_mem_io_unlock(man);

--Sig_/A4XmEMqHWeGFkMo3c4SEgbH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1KQO0ACgkQAVBC80lX
0GxX5gf9EiyGQuQKTqmoVHb32ms1y2mQHnrywmSJ2QEM4WDiAU/v5FZIMDujaYT1
x4LN7JF1x9SmAXyilwUoiGS3hvdd1uxPbjG82fmPtzAwzmfTF7yyRqYssulWU7hS
A+zXjCie/UMNC1RuqGbt5MCBVWklNZiKixuT5is9Mi7Onevxg2Iu0FeMW6VAGtfr
vxLX3+uo1ckbtR7LI3CUn/znCxwPDbh18FSatMnhnDsdISY8LD++wB4eIOt/av1g
uzNNHhD9nl1s/Dmosmv4YGkY2KlE6wrYIxS6tojLUfp9wVj8a01uyggmxl8FvnP1
GEOK8g+4j0kebH1NGPOC74304eKmWg==
=WAmQ
-----END PGP SIGNATURE-----

--Sig_/A4XmEMqHWeGFkMo3c4SEgbH--
