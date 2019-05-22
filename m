Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E465AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894EA20665
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W45yq2L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfEVXyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 19:54:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49535 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfEVXyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 19:54:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 458TxP6JLxz9s55;
        Thu, 23 May 2019 09:54:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558569243;
        bh=4Ie1TzLXQj8FI5hKG+wwp2NDJHkk7TzCx/TL7beKews=;
        h=Date:From:To:Cc:Subject:From;
        b=W45yq2L2Kflk4ySOTn67aogaWM+73l8VU19rLtVoJexA84dXjXZhLtzn3OnZL0Pu3
         BcUQOTd9k4xgaMtcOSj3wpDzEW1QnaH4zqw3/y0sWRkR8GYz8+iTfQgGHjL+czT2zR
         bfTdjRMMwhDOscBSX/mTir2fFQpGylg/xE0MrVGw4D1WSonE0cAtcIoTivsOoTbvmV
         qttFnoDDh0ql8AQAm6CfR057fVCX+Lq7psr45pF530RhndZ+apC2SwvkJAJdwR5qYg
         r/5vRg+HThw++3LGpYilhnHuL0VuPRpy0b246vLqdKmxVQvH5FcEBdW9PEeM4ZSIqD
         zt3+HPT1U5s3A==
Date:   Thu, 23 May 2019 09:53:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: linux-next: manual merge of the drm-misc tree with the drm-intel
 tree
Message-ID: <20190523095341.728a79b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XP=lWq5qsA1xog0vpv4kTbS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XP=lWq5qsA1xog0vpv4kTbS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/drm_atomic_uapi.c

between commit:

  585b000de23b ("drm: move content protection property to mode_config")

from the drm-intel tree and commit:

  fbb5d0353c62 ("drm: Add HDR source metadata property")

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

diff --cc drivers/gpu/drm/drm_atomic_uapi.c
index 4131e669785a,125605ff45af..000000000000
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@@ -814,7 -823,10 +823,10 @@@ drm_atomic_connector_get_property(struc
  		*val =3D state->colorspace;
  	} else if (property =3D=3D connector->scaling_mode_property) {
  		*val =3D state->scaling_mode;
+ 	} else if (property =3D=3D config->hdr_output_metadata_property) {
+ 		*val =3D state->hdr_output_metadata ?
+ 			state->hdr_output_metadata->base.id : 0;
 -	} else if (property =3D=3D connector->content_protection_property) {
 +	} else if (property =3D=3D config->content_protection_property) {
  		*val =3D state->content_protection;
  	} else if (property =3D=3D config->writeback_fb_id_property) {
  		/* Writeback framebuffer is one-shot, write and forget */

--Sig_/XP=lWq5qsA1xog0vpv4kTbS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzl4QUACgkQAVBC80lX
0GxSWwf+MTWafkXTbuoTHRn6ceiKD4K1BQsTENaQOxEaubqh5y9mLJZFPSonoirH
a/7tG2u3KTKKMI4fqHLWvnyHVUn7piAf7IU+rTFYHc1Mrfj8wYJzc8CbrS0AbQ14
840CxOiUewJJtziqeL4KGIrkQXD7KmQYtc/CgYN1OImZc9L344VS919941yEz8ad
MEEBPraKYvn4eYAVBhNmRGJR2H8/DSoprmJ26bCC/usFBLOI+Ux8yjIie1AF+Ev9
AKxufmlfLF22L7tIXnPLbAm6xe2SpjerAYK8hCHAp1Uv5swqsXj1TxFuIa0Bo87w
PmCWifWI4YNoD2JqY57vP2pS9eEWFQ==
=bwN4
-----END PGP SIGNATURE-----

--Sig_/XP=lWq5qsA1xog0vpv4kTbS--
