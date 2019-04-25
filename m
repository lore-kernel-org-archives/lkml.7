Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412B4C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BD320675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfDYRm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:42:58 -0400
Received: from anholt.net ([50.246.234.109]:47328 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDYRm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:42:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9740D10A33C0;
        Thu, 25 Apr 2019 10:42:57 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id AiRZmce-X5UY; Thu, 25 Apr 2019 10:42:53 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8F0F410A33CB;
        Thu, 25 Apr 2019 10:42:53 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 088562FE3AA9; Thu, 25 Apr 2019 10:42:53 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v7 4/4] drm/vc4: Allocate binner bo when starting to use the V3D
In-Reply-To: <20190425122917.26536-5-paul.kocialkowski@bootlin.com>
References: <20190425122917.26536-1-paul.kocialkowski@bootlin.com> <20190425122917.26536-5-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Thu, 25 Apr 2019 10:42:52 -0700
Message-ID: <87tvemj80z.fsf@anholt.net>
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

> The binner BO is not required until the V3D is in use, so avoid
> allocating it at probe and do it on the first non-dumb BO allocation.
>
> Keep track of which clients are using the V3D and liberate the buffer
> when there is none left, using a kref. Protect the logic with a
> mutex to avoid race conditions.
>
> The binner BO is created at the time of the first render ioctl and is
> destroyed when there is no client and no exec job using it left.
>
> The Out-Of-Memory (OOM) interrupt also gets some tweaking, to avoid
> enabling it before having allocated a binner bo.
>
> We also want to keep the BO alive during runtime suspend/resume to avoid
> failing to allocate it at resume. This happens when the CMA pool is
> full at that point and results in a hard crash.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/vc4/vc4_bo.c  | 33 +++++++++++++++++++-
>  drivers/gpu/drm/vc4/vc4_drv.c |  6 ++++
>  drivers/gpu/drm/vc4/vc4_drv.h | 14 +++++++++
>  drivers/gpu/drm/vc4/vc4_gem.c | 13 ++++++++
>  drivers/gpu/drm/vc4/vc4_irq.c | 21 +++++++++----
>  drivers/gpu/drm/vc4/vc4_v3d.c | 58 +++++++++++++++++++++++++++--------
>  6 files changed, 125 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index 88ebd681d7eb..2b3ec5926fe2 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> @@ -799,13 +799,38 @@ vc4_prime_import_sg_table(struct drm_device *dev,
>  	return obj;
>  }
>=20=20
> +static int vc4_grab_bin_bo(struct vc4_dev *vc4, struct vc4_file *vc4file)
> +{
> +	int ret;
> +
> +	if (!vc4->v3d)
> +		return -ENODEV;
> +
> +	if (vc4file->bin_bo_used)
> +		return 0;
> +
> +	ret =3D vc4_v3d_bin_bo_get(vc4);
> +	if (ret)
> +		return ret;
> +


> +	vc4file->bin_bo_used =3D true;

I think I found one last race.  Multiple threads could be in an ioctl
trying to grab the bin BO at the same time (while this is only during
app startup, since the fd only needs to get the ref once, it's
particularly plausible given that allocating the bin BO is slow).  I
think if you replace this line with:

	mutex_lock(&vc4->bin_bo_lock);
        if (vc4file->bin_bo_used) {
        	mutex_unlock(&vc4->bin_bo_lock);
                vc4_v3d_bin_bo_put(vc4);
        } else {
        	vc4file->bin_bo_used =3D true;
        	mutex_unlock(&vc4->bin_bo_lock);
        }

that will be the last change we need.  If you agree with this, feel free
to squash it in and apply the series with:

Reviewed-by: Eric Anholt <eric@anholt.net>

> +
> +	return 0;
> +}
> +
>  int vc4_create_bo_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *file_priv)
>  {
>  	struct drm_vc4_create_bo *args =3D data;
> +	struct vc4_file *vc4file =3D file_priv->driver_priv;
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
>  	struct vc4_bo *bo =3D NULL;
>  	int ret;
>=20=20
> +	ret =3D vc4_grab_bin_bo(vc4, vc4file);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * We can't allocate from the BO cache, because the BOs don't
>  	 * get zeroed, and that might leak data between users.
> @@ -846,6 +871,8 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, vo=
id *data,
>  			   struct drm_file *file_priv)
>  {
>  	struct drm_vc4_create_shader_bo *args =3D data;
> +	struct vc4_file *vc4file =3D file_priv->driver_priv;
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
>  	struct vc4_bo *bo =3D NULL;
>  	int ret;
>=20=20
> @@ -865,6 +892,10 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, v=
oid *data,
>  		return -EINVAL;
>  	}
>=20=20
> +	ret =3D vc4_grab_bin_bo(vc4, vc4file);
> +	if (ret)
> +		return ret;
> +
>  	bo =3D vc4_bo_create(dev, args->size, true, VC4_BO_TYPE_V3D_SHADER);
>  	if (IS_ERR(bo))
>  		return PTR_ERR(bo);
> @@ -894,7 +925,7 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, vo=
id *data,
>  	 */
>  	ret =3D drm_gem_handle_create(file_priv, &bo->base.base, &args->handle);
>=20=20
> - fail:
> +fail:
>  	drm_gem_object_put_unlocked(&bo->base.base);
>=20=20
>  	return ret;

Extraneous whitespace change?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlzB8ZwACgkQtdYpNtH8
nuj+6Q//ZPL/aQed9FLTnzT5PSahgAA2C1P3DfA7A+WadhV/l8/bWQAUYyoeAoJy
krO4FdZHoPMqyLl+g5pY8fJQhdV4qcg1CRcBYS6ksUHA15x5necOiEWO0i3QnF6t
lQIpROuj0sDV/EGgxh4I/s37UJPZSMcnadt+vAobsUaWT1seD5twYvbpso195TQZ
GQMU9vwz5uvJYXP92aXLD9sHziSoKCh2yfzv8aQSiyOXJkdyGKcSz04eZ81Jgybe
GdUPnOxE2Z1cqIVLMaS/R6ip2cNxTAeHupINdZUw5A+WD8v9r6tkwrw8YYjy/w/i
Bz05yy/kwGDST9PA4R0ebeFihB0QNNQghasumliEn5KevQWT39bsjZJbaKIfdDzL
tGUXMsGI6OPqtulIcELTSjHvqSpS97Da08X80ryEKlMq0Wy76duB38B/l0A42C/A
MrYEeEbos4pbF7YP1JMeSMnEZ3Ub33ghSJ4mnHZgF1jDSVGC/2wUiE3Xx7ICHOEe
3vkZqBH3w4QC/HUixJzViUgT5Yrdtz46VP/8FXgHe0XPnNJH6Fa/Xo+evOOCsq0V
EHb7917N9TOddRBY5+PytmLtGNF98zIN9KyjIZEYLJhSm8wdarw1c+eRoACzYOh9
ZRgSWRwarfzYQfGPh6Nv4+Shd4xa5/CQQg+6KGo9REo8q6HPG6Y=
=nXWA
-----END PGP SIGNATURE-----
--=-=-=--
