Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A10C46477
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D0E20848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ntPi1qAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfFQDgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:36:35 -0400
Received: from ozlabs.org ([203.11.71.1]:46449 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbfFQDge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:36:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Rxhb0gc9z9sBp;
        Mon, 17 Jun 2019 13:36:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560742592;
        bh=LowPzVDsxLqs/C3kR5JDANavRyAIxtOAT539ZcPPyZQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ntPi1qAnPvfrzZtNQRv/UNA55KCjBeBmVKeh4C5HSJNbl7WWVJtNu0zdII8na+3sS
         rnIL++ATvJo0e+D7N6bQq/jsEX1K/3EMnOynYXZgeMBVutpl9/akwE84/N0yx6tBYv
         91mCy+2YfHn3oqF829XYDp86SrzGD1XW2CqBgliOBbLhvcUf6i0SnvQ1ntTCN60TT0
         UuJNKn60j/3IcCJwUDpbBTK/CsEqLO+huLHT1HBQ0k0JGj/+oBzMmYcSRSukojrRdd
         Ws2KxW4lyhnn0psloZ3xiPt9ZBMsGZ33Fpe3mIh7L1g8H/JnlMDjrlF+GK+7afMPms
         tduBur6RHbDIg==
Date:   Mon, 17 Jun 2019 13:36:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: linux-next: manual merge of the imx-drm tree with the v4l-vdb tree
Message-ID: <20190617133629.7c276a67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gdQjnfksCTf=EUManH2KJQC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gdQjnfksCTf=EUManH2KJQC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the imx-drm tree got a conflict in:

  drivers/staging/media/imx/imx-ic-prpencvf.c

between commits:

  6d01b7ff5233 ("media: staging/imx: Switch to sync registration for IPU su=
bdevs")
  34ff38745b16 ("media: staging/imx: Pass device to alloc/free_dma_buf")

from the v4l-vdb tree and commit:

  f208b26e61df ("gpu: ipu-v3: ipu-ic: Fully describe colorspace conversions=
")

from the imx-drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/staging/media/imx/imx-ic-prpencvf.c
index 82bba68c554e,f2fe3c11c70e..000000000000
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@@ -460,7 -465,18 +461,18 @@@ static int prp_setup_rotation(struct pr
  	incc =3D priv->cc[PRPENCVF_SINK_PAD];
  	outcc =3D vdev->cc;
 =20
+ 	ret =3D ipu_ic_calc_csc(&csc,
+ 			      infmt->ycbcr_enc, infmt->quantization,
+ 			      incc->cs,
+ 			      outfmt->ycbcr_enc, outfmt->quantization,
+ 			      outcc->cs);
+ 	if (ret) {
+ 		v4l2_err(&ic_priv->sd, "ipu_ic_calc_csc failed, %d\n",
+ 			 ret);
+ 		return ret;
+ 	}
+=20
 -	ret =3D imx_media_alloc_dma_buf(priv->md, &priv->rot_buf[0],
 +	ret =3D imx_media_alloc_dma_buf(ic_priv->ipu_dev, &priv->rot_buf[0],
  				      outfmt->sizeimage);
  	if (ret) {
  		v4l2_err(&ic_priv->sd, "failed to alloc rot_buf[0], %d\n", ret);

--Sig_/gdQjnfksCTf=EUManH2KJQC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0HCr0ACgkQAVBC80lX
0GwE1wf/c+7+zpXahMO3i71+2SqwJ0Tqo+/OyPG/cNDOcCsPTP4k7KLp4J3KD//r
6kfJ1StR2g22xkBwILN7Kj5yiirCa+/CQ2hgolTzILd2ai9GgCRYpPiNEOglc0oA
FG71QZC5xMVxbAdbiJE82P5ffC0xrzhUP4YUWMiAgac4uIV0bDQbY3WzRw+g/ffC
I7Usx+vYEwrbZmKV3NU5cCFCP6WgNZbBIZuTY9kU8d0A5AjYNQaIrQlgxn7WQDcE
mAUHxMrBWfvmy4ijYgYjp8lI6AgDy2hpgld9cN6EzgvYYGOh0114ZOUP7s8CUiWF
zsGgKjV39aEhzZ3TC7c4OFif93UVaA==
=QW6x
-----END PGP SIGNATURE-----

--Sig_/gdQjnfksCTf=EUManH2KJQC--
