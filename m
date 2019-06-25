Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F04C4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 02:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FD820644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 02:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="t8pGBM6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfFYC2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 22:28:24 -0400
Received: from ozlabs.org ([203.11.71.1]:36197 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfFYC2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 22:28:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XqpB6qXWz9sCJ;
        Tue, 25 Jun 2019 12:28:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561429700;
        bh=MSMkoQR214F5Kca8JxEJY32zLgsawr1UmWDfz49laZU=;
        h=Date:From:To:Cc:Subject:From;
        b=t8pGBM6N4uNqXsemgg4zyIuouia1h9QSXTAHuAvR7vQBSRkJ0oYmmxSXU2YJzwQEb
         7yOuO7478BYs4UHd9eFU/e3Ral0ipfznrfV5Q6alUmgasu0OMNPbtkMZWDd+iRTe2G
         dT2UtkohRcRpA9CsI8lkAwDuuTIdtZRhABJvIgAZ91tmpNC/OzB4UrX9QVV8OFqnXm
         2VA/Yx1MbgStBrUY/oCG+c0GNDy8JTld1OX51Eim3JEW+d84Pwby+83ETCvxJgdzNo
         qrZQjo7biD7nLscOpes4Mcpp8/uy8FxJPEBEB6BSn5hv6nlP0YzLqqBDQEX8pZI8l5
         m/WHzkavm510Q==
Date:   Tue, 25 Jun 2019 12:28:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: linux-next: manual merge of the fbdev tree with the v4l-dvb tree
Message-ID: <20190625122817.1f6657c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ujqgfZAwnPLv8RKeU_TJR54"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ujqgfZAwnPLv8RKeU_TJR54
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fbdev tree got a conflict in:

  drivers/media/pci/ivtv/ivtvfb.c

between commit:

  2161536516ed ("media: media/pci: set device_caps in struct video_device")

from the v4l-dvb tree and commit:

  deb00d2785be ("fbdev: make unregister/unlink functions not fail")

from the fbdev tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/media/pci/ivtv/ivtvfb.c
index 800b3654cac5,299ff032f528..000000000000
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@@ -1251,16 -1246,7 +1251,12 @@@ static int ivtvfb_callback_cleanup(stru
  	struct osd_info *oi =3D itv->osd_info;
 =20
  	if (itv->v4l2_cap & V4L2_CAP_VIDEO_OUTPUT) {
 +		itv->streams[IVTV_DEC_STREAM_TYPE_YUV].vdev.device_caps &=3D
 +			~V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
 +		itv->streams[IVTV_DEC_STREAM_TYPE_MPG].vdev.device_caps &=3D
 +			~V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
 +		itv->v4l2_cap &=3D ~V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
- 		if (unregister_framebuffer(&itv->osd_info->ivtvfb_info)) {
- 			IVTVFB_WARN("Framebuffer %d is in use, cannot unload\n",
- 				       itv->instance);
- 			return 0;
- 		}
+ 		unregister_framebuffer(&itv->osd_info->ivtvfb_info);
  		IVTVFB_INFO("Unregister framebuffer %d\n", itv->instance);
  		itv->ivtvfb_restore =3D NULL;
  		ivtvfb_blank(FB_BLANK_VSYNC_SUSPEND, &oi->ivtvfb_info);

--Sig_/ujqgfZAwnPLv8RKeU_TJR54
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0RhsEACgkQAVBC80lX
0Gy8Ngf/U+gW1i/a3cwGmh294qAvV4VjmZLIoRCehie6fvs5vU/EWYsFocqf6o3f
rs+Mq1NRPovdNiRyKo2oT8pPoGm76hhtwxXotyV8xFR4ePbA0C2LTlh6spoGaE8u
qZqLelU6tvbu7MpqeS2sGBcEZlkr4ivIFklJXNtgUNYrVm4i4IufgUYsxxLpuEXT
Ve8YHofQC9iykfHQ+CQER6o+Yiuqa8zq2+lNLX34fvIdhlr97Y7n6n8GEMuW5m5x
SBMgTecgO/+ric+If+XEkbq8SYcJAy6rjNx1F2IALihf3ZKzwHfyCJwHmOkKJmiy
+xGXdF+VZXn5sw/9rKUNtoO//gLgjw==
=xZfT
-----END PGP SIGNATURE-----

--Sig_/ujqgfZAwnPLv8RKeU_TJR54--
