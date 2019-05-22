Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E40AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9D0206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AkCaBfd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfEVX6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 19:58:20 -0400
Received: from ozlabs.org ([203.11.71.1]:44403 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfEVX6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 19:58:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 458V2K0zG5z9s55;
        Thu, 23 May 2019 09:58:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558569497;
        bh=awSBY8QhuVpH2dy6Tjr+pBL7Q9+494tGdrCADPbp6JU=;
        h=Date:From:To:Cc:Subject:From;
        b=AkCaBfd81pV96IMrR/ZRSqiziOtr2nedXxnYOHwKBtvL8mxs2Rcfs0RrGH/avyVn7
         2HvfDbg9slu+9LeNCNWNbXn+6uEMNzAECO1RPJQ43X4fBJIzIXhrmM9+bgrpEDLHxf
         ioF1nKeosEkVVxp7wSsD1Zqulnm8yAgQig7gPDn1rHrIZWEtK7sDe/5t4mR9ryytlt
         2viGVPe+KD26LtZa2v2o/7hXf6S9q0cddu9MryVoO9517+SDepzYKaGX1wC4E4YWLF
         MbuBKBGZqUsjyKrKkgvTEg8bopi/bAvqcMPrjvbXELT980QIESSsRm3aKZx0PcS6CE
         6S9vMHyD0jgKA==
Date:   Thu, 23 May 2019 09:58:16 +1000
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
Message-ID: <20190523095816.2fd950f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iqoc+GgWuISAZa6f0roKMrT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iqoc+GgWuISAZa6f0roKMrT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  include/drm/drm_mode_config.h

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

diff --cc include/drm/drm_mode_config.h
index 5764ee3c7453,c031b5a9d8d1..000000000000
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@@ -836,12 -836,13 +836,19 @@@ struct drm_mode_config=20
  	 */
  	struct drm_property *writeback_out_fence_ptr_property;
 =20
 +	/**
 +	 * @content_protection_property: DRM ENUM property for content
 +	 * protection. See drm_connector_attach_content_protection_property().
 +	 */
 +	struct drm_property *content_protection_property;
 +
+ 	/**
+ 	 * hdr_output_metadata_property: Connector property containing hdr
+ 	 * metatda. This will be provided by userspace compositors based
+ 	 * on HDR content
+ 	 */
+ 	struct drm_property *hdr_output_metadata_property;
+=20
  	/* dumb ioctl parameters */
  	uint32_t preferred_depth, prefer_shadow;
 =20

--Sig_/iqoc+GgWuISAZa6f0roKMrT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzl4hgACgkQAVBC80lX
0GwvNAf/e7CBkRU+Cwrf5MF74yDaDjYq1i+q6cdNZgWm1pjYAHtD+2QarsztG3fI
8Ln3ug+xGjuoWWDSWQ4kkDWRg2L//Viqt5EmUrQFKrvxvOBBWE4936f1kfJg9JGp
neOdvZEGjRgQo8xcKW/5KP7WQvNw+yelYPZ1p3IdQ2oigr7y0SewpICvWnIPEeUa
MAqY9sBmCp+S326XWvjlPoAnMZUbzzsnnUZUYMt3yzUui1k8UaYAG9WGPyx2WNgs
Qxi+1CsuV9GVpoAao+4s1QsLJDUZ9nCjT/GgN56mQR+NBFyfTTtfY/yBxyzAkxu/
kfA2Tk1W5TcIrEbrf3/mX/OifV3dgA==
=xKAU
-----END PGP SIGNATURE-----

--Sig_/iqoc+GgWuISAZa6f0roKMrT--
