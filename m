Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B9DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CD320651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfDOUuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:50:39 -0400
Received: from anholt.net ([50.246.234.109]:44874 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfDOUuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:50:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3CE0210A3362;
        Mon, 15 Apr 2019 13:50:38 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id DDA9wwVGMy-7; Mon, 15 Apr 2019 13:50:36 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4A87C10A28B9;
        Mon, 15 Apr 2019 13:50:36 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id CDECD2FE36FA; Mon, 15 Apr 2019 13:50:35 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v5 4/4] drm/vc4: Allocate binner bo when starting to use the V3D
In-Reply-To: <20190415123908.28986-5-paul.kocialkowski@bootlin.com>
References: <20190415123908.28986-1-paul.kocialkowski@bootlin.com> <20190415123908.28986-5-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Mon, 15 Apr 2019 13:50:35 -0700
Message-ID: <87tvez802s.fsf@anholt.net>
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
> when there is none left (through a kref) and protect it with a mutex to
> avoid race conditions.
>
> The Out-Of-Memory (OOM) interrupt also gets some tweaking, to avoid
> enabling it before having allocated a binner bo.

I love your solution to this!

> We also want to keep the BO alive during runtime suspend/resume to avoid
> failing to allocate it at resume. This happens when the CMA pool is
> full at that point and results in a hard crash.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/vc4/vc4_bo.c  | 30 ++++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_drv.c | 17 +++++++++++++
>  drivers/gpu/drm/vc4/vc4_drv.h |  9 +++++++
>  drivers/gpu/drm/vc4/vc4_irq.c |  6 +++--
>  drivers/gpu/drm/vc4/vc4_v3d.c | 47 +++++++++++++++++++++++++----------
>  5 files changed, 94 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index 88ebd681d7eb..5a5276cce9a2 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> @@ -799,6 +799,28 @@ vc4_prime_import_sg_table(struct drm_device *dev,
>  	return obj;
>  }
>=20=20
> +static int vc4_grab_bin_bo(struct drm_device *dev,
> +			   struct drm_file *file_priv)
> +{
> +	struct vc4_file *vc4file =3D file_priv->driver_priv;
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> +
> +	if (!vc4->v3d)
> +		return -ENODEV;
> +
> +	if (vc4file->bin_bo_kref)
> +		return 0;
> +
> +	mutex_lock(&vc4->bin_bo_lock);
> +	vc4file->bin_bo_kref =3D vc4_v3d_bin_bo_get(vc4);
> +	mutex_unlock(&vc4->bin_bo_lock);

Interesting.  I think I would have stored a bool for whether he had the
kref, instead of a pointer to vc4->bin_bo_kref.  Either way is fine with
me, though.

> +
> +	if (!vc4file->bin_bo_kref)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index d840b52b9805..b09f771384be 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -126,10 +126,25 @@ static int vc4_open(struct drm_device *dev, struct =
drm_file *file)
>  	return 0;
>  }
>=20=20
> +static void vc4_close_bin_bo_release(struct kref *ref)
> +{
> +	struct vc4_dev *vc4 =3D container_of(ref, struct vc4_dev, bin_bo_kref);
> +
> +	return vc4_v3d_bin_bo_free(vc4);
> +}

Could we have this be the function that vc4_v3d.c publishes instead of
_free, and then we don't need two separate functions for the free path?

>  static void vc4_close(struct drm_device *dev, struct drm_file *file)
>  {
> +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
>  	struct vc4_file *vc4file =3D file->driver_priv;
>=20=20
> +	mutex_lock(&vc4->bin_bo_lock);
> +
> +	if (vc4file->bin_bo_kref)
> +		kref_put(vc4file->bin_bo_kref, vc4_close_bin_bo_release);
> +
> +	mutex_unlock(&vc4->bin_bo_lock);
> +
>  	vc4_perfmon_close_file(vc4file);
>  	kfree(vc4file);
>  }


> @@ -313,6 +338,15 @@ int vc4_v3d_bin_bo_alloc(struct vc4_dev *vc4)
>  	return ret;
>  }
>=20=20
> +void vc4_v3d_bin_bo_free(struct vc4_dev *vc4)
> +{
> +	if (!vc4->bin_bo)
> +		return;
> +
> +	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
> +	vc4->bin_bo =3D NULL;

Hmm.  I'm thinking:

We free the bin BO from the DRM fd close operation, but we could have
jobs still being executed after the close if userspace didn't happen to
wait on them before finishing (closing doesn't wait for execution to
complete, and we couldn't reliably wait during close even if we wanted
to).  I think to resolve that we need the vc4_exec_info to keep a ref on
the bin BO as well (at least, if they had a binning component to their
job).

>  #ifdef CONFIG_PM
>  static int vc4_v3d_runtime_suspend(struct device *dev)
>  {
> @@ -321,9 +355,6 @@ static int vc4_v3d_runtime_suspend(struct device *dev)
>=20=20
>  	vc4_irq_uninstall(vc4->dev);
>=20=20
> -	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
> -	vc4->bin_bo =3D NULL;
> -
>  	clk_disable_unprepare(v3d->clk);
>=20=20
>  	return 0;
> @@ -335,10 +366,6 @@ static int vc4_v3d_runtime_resume(struct device *dev)
>  	struct vc4_dev *vc4 =3D v3d->vc4;
>  	int ret;
>=20=20
> -	ret =3D vc4_v3d_bin_bo_alloc(vc4);
> -	if (ret)
> -		return ret;
> -
>  	ret =3D clk_prepare_enable(v3d->clk);
>  	if (ret !=3D 0)
>  		return ret;

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAly07psACgkQtdYpNtH8
nuhVhQ//agHD8mONnj+qN/vwqr+cHbHTLY07yG2Qo4htShTARpKJEEzIbLEJdBxG
Md21UhwJfjX/MdV2M9KkPvcvTFQLqoWofZRsvc9q3vTyLnIht/ZzWJ5V/xN6rFl5
I7LQD/t8QoULRnJC8huV/iUwYR+kvXRMVUTu8D51Sku1NoTs4fU9yeNTTlD8ptxb
ojjabySNxkIEnhUrwzchfahjBxyKmIve4Vs/0SoblMKzapD9qVkKr5weGtcxUbFA
W081sgBxdmKOgvvdRLljqvCc0Xe7gyJfi+UqjHkcjtpGDZThC6gLJdU7W3JF2MfL
qE5MIsuDu+SRu6njSclf8jHu+1G7vzub9UKpJt/lrWbLghJ+WiORpZL4goCSiZMk
ZAjQIGUC4iucD1y+chK8yUr27Vx8+eT9kk757rKVp3uit00KmOFzPLGH4cnkkcl+
Y3UgII4JoICQ4G4WuwqUrQB8k5qGH/u0BGVZBtspbb8LRT1kdOP9hKy3qPgsgupK
GlPxq8BHuOoVMjS7JsS9ORTbSksBSe16lSTcmIML55Dzk9B7mjMfbPVVzUsQQLLC
jXCRQL7MTSBsX0b2xgPbNlcwuuYjsy7V5hi5Iv5jEbA0kBw+TATvgiB2zr5jTlmh
kZvqe/I9hycUnieZ3Qb0Ik3OubO6Bp1/nbkdBtTUlgVu2c/w2Bo=
=V2WX
-----END PGP SIGNATURE-----
--=-=-=--
