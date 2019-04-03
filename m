Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C899FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F0D2133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDCSxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:53:31 -0400
Received: from anholt.net ([50.246.234.109]:33862 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCSxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:53:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 28D9110A2F03;
        Wed,  3 Apr 2019 11:53:30 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id B_nmpVZw2-0a; Wed,  3 Apr 2019 11:53:28 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9A95810A275D;
        Wed,  3 Apr 2019 11:53:28 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 36B0D2FE33BA; Wed,  3 Apr 2019 11:53:28 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Stone <daniel@fooishbar.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v4 4/4] drm/vc4: Allocate binner bo when starting to use the V3D
In-Reply-To: <20190403154856.9470-5-paul.kocialkowski@bootlin.com>
References: <20190403154856.9470-1-paul.kocialkowski@bootlin.com> <20190403154856.9470-5-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Apr 2019 11:53:27 -0700
Message-ID: <87ftqyor88.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> The binner bo is not required until the V3D is in use, so avoid
> allocating it at probe and do it on the first non-dumb BO allocation.
> Keep track of which clients are using the V3D and liberate the buffer
> when there is none left.
>
> We also want to keep it alive during runtime suspend/resume to avoid
> failing to allocate it at resume. This happens when the CMA pool is
> full at that point and results in a hard crash.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/vc4/vc4_bo.c  | 32 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_drv.c |  9 +++++++++
>  drivers/gpu/drm/vc4/vc4_drv.h |  4 ++++
>  drivers/gpu/drm/vc4/vc4_v3d.c | 13 -------------
>  4 files changed, 45 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index 88ebd681d7eb..b941f09b9378 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> @@ -799,6 +799,30 @@ vc4_prime_import_sg_table(struct drm_device *dev,
>  	return obj;
>  }
>=20=20
> +static int vc4_prepare_bin_bo(struct drm_device *dev,
> +			      struct drm_file *file_priv)
> +{
> +	struct vc4_file *vc4file =3D file_priv->driver_priv;
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +	int ret;
> +
> +	if (!vc4->v3d)
> +		return -ENODEV;
> +
> +	if (!vc4file->needs_bin_bo) {
> +		atomic_inc(&vc4->bin_bo_usecnt);
> +		vc4file->needs_bin_bo =3D true;
> +	}
> +
> +	if (!vc4->bin_bo) {
> +		ret =3D vc4_v3d_allocate_bin_bo(vc4);
> +		if (ret)
> +			return ret;
> +	}
> +

This atomic usage looks really racy.  For example, multiple clients
could call allocate at the same time and leak one.  Or this timeline:

us           them
             dec count to 0
inc count
check bin_bo
             free bin_bo

vc4_v3d_allocate_bin_bo should probably be a vc4_v3d_bin_bo_get()
returning a kref on the BO, called under a lock protecting both one
file_priv being dereferenced by multiple threads in the kernel at the
same time (so file_priv doesn't try to double-get its ref) and multiple
file_privs trying to get the bin_bo at once.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlylASgACgkQtdYpNtH8
nui6yxAAhNRgTwjZnkulsLdH3fl2EY+wFqNeL7MN6wTSIEB2Tfn5IAjizq+TgARd
dqlXdArGiQrXwib4UljTbocOAOAM1MWUiY9RESeqIuQoy1h7OBpxw9c8PEX2PJUw
oNuCKCGqxIQqFA8OW3EcTModbs+QaxPrc+m7se3T+1ppGlVL9N+EapT9CEdMlq3J
lgFirN/OQJ/dmyVowGgDnwoADKNIWclWHoieTdiBxVOqbDxPdy6sFOfr36regVXp
Am0qPllon1KcpcECJKWAk7rrr0BkAENkPj1pOfrGhEaSQrKGBENF0IRQXqyzlbvo
7uQlVPNcL1k+6euvDO1zatbxOfSA6Gu+aDw9sfwL723FoeZT292Sl8QALGgDsrv0
dQmfqTpEbvvdfUvLAbOr0v9iLYQPT1DBup50jOHg4D4bgAkDmec1GUnu+qMDAeLp
qhQMf5Wvovb6f6Px5nBlfbbqboETFnsH7RtNzx1v4z7C9ey4p1Jfl8eb+sf++F3i
PT6hAa5EhU9XUunYDNcpyKm9nlNxxXPKD2Fiol1PB/aVnZ07pGTcnES2IFnR/JAA
7GI3xy8JTUihxh1v0N7uC4wjbwHvKZuxCrWjfvH4zAelPy6FlFIFZus1bYq0+4Fu
yiTAWR2ObpW3BzypUV6kInd1LuFYksRuCm4f4z+YO/HHW05GhbU=
=2Y6S
-----END PGP SIGNATURE-----
--=-=-=--
