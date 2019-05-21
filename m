Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D091BC04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDFD21479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X8iM6w02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfEUAiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 20:38:22 -0400
Received: from ozlabs.org ([203.11.71.1]:47515 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfEUAiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 20:38:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457H1N1YFtz9s9T;
        Tue, 21 May 2019 10:38:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558399098;
        bh=IcmSxkyhyheY63x0Sqljy/UD2XTdhq+M+ULqA85IMVQ=;
        h=Date:From:To:Cc:Subject:From;
        b=X8iM6w02bCD//+TQlz+bmuk+7UeIDmbe3w2UuDhZ5Y8JSt7TeyY0//XXUslTIRL3L
         9drDsVuuGiTGR77pwrePkP7SoxX+Q8oVEjtZ0V6GxyZW34uULqMZ89fI50MsgBPPs8
         Dvop7iVlNMrIm776un8j9DCOovmC/FRwBfNVN6l64lDqBaBngM/+PSB75Oxw0oIQ6B
         bkgp48zpUOttwDnLRoo/fbl64bQZBz+IxQz22c9oL06wBW1AzbN27edFt+jsuRur6h
         NRVH+0lTtwTRTn0/f8d+G5iRzQ+GJLTXbx8C1ynJ+wgx55ueqdgHQVuRiC7jx55wLc
         T+8AJBQJzaXpQ==
Date:   Tue, 21 May 2019 10:38:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xinhui pan <xinhui.pan@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: linux-next: manual merge of the drm-misc tree with the amdgpu tree
Message-ID: <20190521103815.21dcb0ba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/F+2zI99WB3E_l/eAI8=GZdg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F+2zI99WB3E_l/eAI8=GZdg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

between commit:

  56965ce261af ("drm/amdgpu: cancel late_init_work before gpu reset")

from the amdgpu tree and commit:

  1d721ed679db ("drm/amdgpu: Avoid HW reset if guilty job already signaled.=
")

from the drm-misc tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c9024f92e203,b9371ec5e04f..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@@ -3614,28 -3538,27 +3595,28 @@@ int amdgpu_device_gpu_recover(struct am
 =20
  	dev_info(adev->dev, "GPU reset begin!\n");
 =20
 +	cancel_delayed_work_sync(&adev->late_init_work);
+ 	hive =3D amdgpu_get_xgmi_hive(adev, false);
 =20
  	/*
- 	 * In case of XGMI hive disallow concurrent resets to be triggered
- 	 * by different nodes. No point also since the one node already executing
- 	 * reset will also reset all the other nodes in the hive.
+ 	 * Here we trylock to avoid chain of resets executing from
+ 	 * either trigger by jobs on different adevs in XGMI hive or jobs on
+ 	 * different schedulers for same device while this TO handler is running.
+ 	 * We always reset all schedulers for device and all devices for XGMI
+ 	 * hive so that should take care of them too.
  	 */
- 	hive =3D amdgpu_get_xgmi_hive(adev, 0);
- 	if (hive && adev->gmc.xgmi.num_physical_nodes > 1 &&
- 	    !mutex_trylock(&hive->reset_lock))
+=20
+ 	if (hive && !mutex_trylock(&hive->reset_lock)) {
+ 		DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already =
in progress",
+ 			 job->base.id, hive->hive_id);
  		return 0;
+ 	}
 =20
  	/* Start with adev pre asic reset first for soft reset check.*/
- 	amdgpu_device_lock_adev(adev);
- 	r =3D amdgpu_device_pre_asic_reset(adev,
- 					 job,
- 					 &need_full_reset);
- 	if (r) {
- 		/*TODO Should we stop ?*/
- 		DRM_ERROR("GPU pre asic reset failed with err, %d for drm dev, %s ",
- 			  r, adev->ddev->unique);
- 		adev->asic_reset_res =3D r;
+ 	if (!amdgpu_device_lock_adev(adev, !hive)) {
+ 		DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress=
",
+ 					 job->base.id);
+ 		return 0;
  	}
 =20
  	/* Build list of devices to reset */

--Sig_/F+2zI99WB3E_l/eAI8=GZdg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzjSHcACgkQAVBC80lX
0Gwk+Af/bWXFQKn3v8vCeqqNO+4DfcXDlz579wmq2ctkdCwkYkmOnnfIKTrthi3Q
sKr2F+qc+132SCjhAQHPIuAE8zDFW9XasdKkdd36VJtrqaRitmWA8qvWkz8Riy5R
DHIAsy3W4evd19zi0X4Zbc8vPQewGdunLH1cvi9FOC1zr4/+nX+Zq5NV4LGfvZTf
ehr0AIxCxfAM3Dw9FYHtv0EdcFAF/m+LnKKLiZ5VJgS+XAM3/4q6swy/YMsHr0S5
yg+NgdmdjFvEqd+MZk68Fsb0LmIAMMS78ZRbMvVlRcG8ZaaGdDubaL4mHCp8hQV3
oWaF6GPjbv0+C0kDh6KDFYyzAPRHhQ==
=KYAk
-----END PGP SIGNATURE-----

--Sig_/F+2zI99WB3E_l/eAI8=GZdg--
