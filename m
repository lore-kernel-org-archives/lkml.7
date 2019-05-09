Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F42DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740F4217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfEISjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:39:21 -0400
Received: from anholt.net ([50.246.234.109]:37370 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfEISjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:39:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 747F910A34BA;
        Thu,  9 May 2019 11:39:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Y9nQtU846ddV; Thu,  9 May 2019 11:39:19 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1F94810A33E6;
        Thu,  9 May 2019 11:39:19 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id A737D2FE3AA9; Thu,  9 May 2019 11:39:18 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v8 4/4] drm/vc4: Allocate binner bo when starting to use the V3D
In-Reply-To: <20190503081242.29039-5-paul.kocialkowski@bootlin.com>
References: <20190503081242.29039-1-paul.kocialkowski@bootlin.com> <20190503081242.29039-5-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Thu, 09 May 2019 11:39:17 -0700
Message-ID: <87r2973222.fsf@anholt.net>
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

> @@ -313,6 +321,49 @@ static int bin_bo_alloc(struct vc4_dev *vc4)
>  	return ret;
>  }
>=20=20
> +int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used)
> +{
> +	int ret =3D 0;
> +
> +	mutex_lock(&vc4->bin_bo_lock);
> +
> +	if (used && *used)
> +		goto complete;



> +
> +	if (used)
> +		*used =3D true;
> +
> +	if (vc4->bin_bo) {
> +		kref_get(&vc4->bin_bo_kref);
> +		goto complete;
> +	}
> +
> +	ret =3D bin_bo_alloc(vc4);

I think this block wants to be:

if (vc4->bin_bo)
	kref_get(&vc4->bin_bo_kref);
else
	ret =3D bin_bo_alloc(vc4);

if (ret =3D=3D 0 && used)
	*used =3D true;

(so we don't flag used if bin_bo_alloc fails)

If you agree, then the series is:

Reviewed-by: Eric Anholt <eric@anholt.net>

> +
> +complete:
> +	mutex_unlock(&vc4->bin_bo_lock);
> +
> +	return ret;
> +}


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlzUc9UACgkQtdYpNtH8
nui+7A//dYFvEu23z/u7C7jPsCdV5Pe5lH1XBUv3QPsIOcO5V868i7nOqWB7XdW7
CVfm9p3RkMGk5KkarXSxPqnkP6HEsOUEalDLHkqeljij6Il7PZhjlE/8bq59F1PY
xlTelmR0KqffrvaTErXR8rbkOe0HCRyyhoGP1FDu8R5PMc79MEYOyayhiIniuAjh
Ec6I/8msFgls3ojw93sFxf0H+TmcE8sHUJoT0/JAfeDFi+QDnB9uxcEZt9xZQGP5
0XK8SQn9Cz2KfL9DLGSFLIM/5QVhpoxCbRohPXVPuO953oyn+eSxnUwX8Ymusz3S
xr6VZRnPjeVf5Reb9GTkUMESdOR3WCnmuSA1jpuQqA/EBPU9XO7d/q/pascozGvJ
AszjT5pMO9uPmcbGerq0CBkAHe5XbS5CkLTYpgeXD+PbFwsplKpGL42q1XyL8NMy
5dANWecHDr3bRekX8Qy4ytE6e7X4hmfrNEj7klluotw39alOk/+WHBMbOYnsPPkq
y6jaanE14J3GBlz7W6+YIYuGG5m2ITCc4+gkkcHcdnjKG2iBAMZ/0qg44KfORYxS
+PzryEx67Fm94Ihjb9wr4u4wYI2aQuhGAsl7F52v5Atfx0pQHp3Y9s7auk3c36eo
9icaWzFBdqKBk5wz5wMTgpcRnJsX/witly1fxBuKb4/avZ60E5E=
=qaUS
-----END PGP SIGNATURE-----
--=-=-=--
