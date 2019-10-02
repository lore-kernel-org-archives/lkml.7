Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C691C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B7420659
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfJBWG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:06:58 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41021 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:06:57 -0400
X-Originating-IP: 132.205.230.6
Received: from aptenodytes (unknown [132.205.230.6])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F414BC0004;
        Wed,  2 Oct 2019 22:06:52 +0000 (UTC)
Date:   Wed, 2 Oct 2019 18:06:50 -0400
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     mripard@kernel.org, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: cedrus: Fix H264 default reference index
 count
Message-ID: <20191002220650.GB24151@aptenodytes>
References: <20191002193553.1633467-1-jernej.skrabec@siol.net>
 <20191002193553.1633467-3-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <20191002193553.1633467-3-jernej.skrabec@siol.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed 02 Oct 19, 21:35, Jernej Skrabec wrote:
> Reference index count in VE_H264_PPS should come from PPS control.
> However, this is not really important, because reference index count is
> in our case always overridden by that from slice header.

Thanks for the fixup!

Our libva userspace and v4l2-request testing tool currently don't provide t=
his,
but I have a pending merge request adding it for the hantro so it's good to=
 go.

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h264.c
> index bd848146eada..4a0e69855c7f 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> @@ -364,12 +364,8 @@ static void cedrus_set_params(struct cedrus_ctx *ctx,
> =20
>  	// picture parameters
>  	reg =3D 0;
> -	/*
> -	 * FIXME: the kernel headers are allowing the default value to
> -	 * be passed, but the libva doesn't give us that.
> -	 */
> -	reg |=3D (slice->num_ref_idx_l0_active_minus1 & 0x1f) << 10;
> -	reg |=3D (slice->num_ref_idx_l1_active_minus1 & 0x1f) << 5;
> +	reg |=3D (pps->num_ref_idx_l0_default_active_minus1 & 0x1f) << 10;
> +	reg |=3D (pps->num_ref_idx_l1_default_active_minus1 & 0x1f) << 5;
>  	reg |=3D (pps->weighted_bipred_idc & 0x3) << 2;
>  	if (pps->flags & V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE)
>  		reg |=3D VE_H264_PPS_ENTROPY_CODING_MODE;
> --=20
> 2.23.0
>=20

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl2VH3oACgkQ3cLmz3+f
v9HfnQf+Piqc+/r5jjib8Rh52MjgYahIkSTSbp4ZIe3lc/Uwyc/W/O5u2tCNC+KV
+VJ+3ws7rbRkWfU1nfV6WKp8jxp+/a73DEsx1AePm4vOrzh9qitnXtwPpjXkXzJB
qtuDNoaRlvzRI6KN98hICCfiYT6LKKDcIURUx5sGZi5vbSpQvsdIEofwZmxPuZDl
C0+RXEwUPLIhM6E2FKj+6Tt6DdX+Tc4UtzP4wBLvFfYO2Magxdtp0w/SerqphDhX
3KtP9S3N+M5vDMD3FzM56DLRqqDpd4e3+5YV0/dmJrKmpBsm885B8bgNUwSsto+D
e0opfIfHkZ4GSg2vZ1Mp58+lbZ0rag==
=DONI
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
