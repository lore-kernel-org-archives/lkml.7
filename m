Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D28EC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F1A21670
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfIBOev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:34:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726916AbfIBOev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:34:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7F9CACC1;
        Mon,  2 Sep 2019 14:34:49 +0000 (UTC)
Subject: Re: [PATCH 4/5] drm/qxl: use drm_gem_object_funcs callbacks
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-5-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNKFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmNvbT7CwJQEEwEIAD4W
 IQRyF/usjOnPY0ShaOVoDcEdUwt6IwUCWznTtgIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgID
 AQIeAQIXgAAKCRBoDcEdUwt6I7D7CACBK42XW+7mCiK8ioXMEy1NzGbXC51RzGea8N83oEJS
 1KVUtQxrkDxgrW/WLSl/TfqHFsJpdEFOv1XubWbleun3uKPy0e5vZCd5UjZPkeNjnqfCYTDy
 hVVsdOuFbtWDppJyJrThLqr9AgSFmoCNNUt1SVpYEEOLNE6C32BhlnSq21VLC+YXTgO/ZHTa
 YXkq54hHj63jwrcjkBSCkXLh37kHeqnl++GHpN+3R+o3w2OpwHAlvVjdKPT27v1tVkiydsFG
 65Vd0n3m/ft+IOrGgxQM1C20uqKvsZGB4r3OGR50ekAybO7sjEJJ1Obl4ge/6RRqcvKz4LMb
 tGs85D6tPIeFzsBNBFs50uABCADGJj+DP1fk+UWOWrf4O61HTbC4Vr9QD2K4fUUHnzg2B6zU
 R1BPXqLGG0+lzK8kfYU/F5RjmEcClsIkAaFkg4kzKP14tvY1J5+AV3yNqcdg018HNtiyrSwI
 E0Yz/qm1Ot2NMZ0DdvVBg22IMsiudQ1tx9CH9mtyTbIXgACvl3PW2o9CxiHPE/bohFhwZwh/
 kXYYAE51lhinQ3oFEeQZA3w4OTvxSEspiQR8dg8qJJb+YOAc5IKk6sJmmM7JfFMWSr22satM
 23oQ3WvJb4RV6HTRTAIEyyZS7g2DhiytgMG60t0qdABG5KXSQW+OKlZRpuWwKWaLh3if/p/u
 69dvpanbABEBAAHCwHwEGAEIACYWIQRyF/usjOnPY0ShaOVoDcEdUwt6IwUCWznS4AIbDAUJ
 A8JnAAAKCRBoDcEdUwt6I6X3CACJ8D+TpXBCqJE5xwog08+Dp8uBpx0T9n1wE0GQisZruACW
 NofYn8PTX9k4wmegDLwt7YQDdKxQ4+eTfZeLNQqWg6OCftH5Kx7sjWnJ09tOgniVdROzWJ7c
 VJ/i0okazncsJ+nq48UYvRGE1Swh3A4QRIyphWX4OADOBmTFl9ZYNPnh23eaC9WrNvFr7yP7
 iGjMlfEW8l6Lda//EC5VpXVNza0xeae0zFNst2R9pn+bLkihwDLWxOIyifGRxTqNxoS4I1aw
 VhxPSVztPMSpIA/sOr/N/p6JrBLn+gui2K6mP7bGb8hF+szfArYqz3T1rv1VzUWAJf5Wre5U
 iNx9uqqx
Message-ID: <0a9d97c7-26a4-bee6-e9a2-120abbd5277c@suse.de>
Date:   Mon, 2 Sep 2019 16:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902124126.7700-5-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5pfoTXHkUA37GgICinr9tBPf2MBxv9lt0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5pfoTXHkUA37GgICinr9tBPf2MBxv9lt0
Content-Type: multipart/mixed; boundary="VYtJRpb5LuEH9QQwQSr1D2uADEAmevApW";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <0a9d97c7-26a4-bee6-e9a2-120abbd5277c@suse.de>
Subject: Re: [PATCH 4/5] drm/qxl: use drm_gem_object_funcs callbacks
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-5-kraxel@redhat.com>
In-Reply-To: <20190902124126.7700-5-kraxel@redhat.com>

--VYtJRpb5LuEH9QQwQSr1D2uADEAmevApW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

This patch seems unrelated.

Am 02.09.19 um 14:41 schrieb Gerd Hoffmann:
> Switch qxl to use drm_gem_object_funcs callbacks
> instead of drm_driver callbacks.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c    |  8 --------
>  drivers/gpu/drm/qxl/qxl_object.c | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_dr=
v.c
> index 2b726a51a302..996d428fa7e6 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -258,16 +258,8 @@ static struct drm_driver qxl_driver =3D {
>  #endif
>  	.prime_handle_to_fd =3D drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
> -	.gem_prime_pin =3D qxl_gem_prime_pin,
> -	.gem_prime_unpin =3D qxl_gem_prime_unpin,
> -	.gem_prime_get_sg_table =3D qxl_gem_prime_get_sg_table,
>  	.gem_prime_import_sg_table =3D qxl_gem_prime_import_sg_table,
> -	.gem_prime_vmap =3D qxl_gem_prime_vmap,
> -	.gem_prime_vunmap =3D qxl_gem_prime_vunmap,
>  	.gem_prime_mmap =3D qxl_gem_prime_mmap,
> -	.gem_free_object_unlocked =3D qxl_gem_object_free,
> -	.gem_open_object =3D qxl_gem_object_open,
> -	.gem_close_object =3D qxl_gem_object_close,
>  	.fops =3D &qxl_fops,
>  	.ioctls =3D qxl_ioctls,
>  	.irq_handler =3D qxl_irq_handler,
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl=
_object.c
> index 548dfe6f3b26..29aab7b14513 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -77,6 +77,17 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *qb=
o, u32 domain, bool pinned)
>  	}
>  }
> =20
> +static const struct drm_gem_object_funcs qxl_object_funcs =3D {
> +	.free =3D qxl_gem_object_free,
> +	.open =3D qxl_gem_object_open,
> +	.close =3D qxl_gem_object_close,
> +	.pin =3D qxl_gem_prime_pin,
> +	.unpin =3D qxl_gem_prime_unpin,
> +	.get_sg_table =3D qxl_gem_prime_get_sg_table,
> +	.vmap =3D qxl_gem_prime_vmap,
> +	.vunmap =3D qxl_gem_prime_vunmap,
> +};
> +
>  int qxl_bo_create(struct qxl_device *qdev,
>  		  unsigned long size, bool kernel, bool pinned, u32 domain,
>  		  struct qxl_surface *surf,
> @@ -100,6 +111,7 @@ int qxl_bo_create(struct qxl_device *qdev,
>  		kfree(bo);
>  		return r;
>  	}
> +	bo->tbo.base.funcs =3D &qxl_object_funcs;
>  	bo->type =3D domain;
>  	bo->pin_count =3D pinned ? 1 : 0;
>  	bo->surface_id =3D 0;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--VYtJRpb5LuEH9QQwQSr1D2uADEAmevApW--

--5pfoTXHkUA37GgICinr9tBPf2MBxv9lt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl1tKIkACgkQaA3BHVML
eiMbjAf6AxrSfiSwm5E9Q+kRgf/F5G7EF7dbpaTiSosYTZd7U+6DSM3ljVOdBoTP
7tGDxBOB2gISyEwV80XSSNlfznuwu/AmcUlV0zxmmhQFbtAg5d+tltxkl8JUbThu
IXnvhuagV3gTKsFLoRDcIaZhfX7WRQRdzT2aE3v8gPlC+2Gq79CRgkcWTUjxRqiC
H8wZduikC5Eh8DIdMx8psHsnaIPB+Ody48ahAuc3IlSzW/Uml8pvktfFOt/E/1pt
CR+A4iUYA8elgRKIBIvbTydzWgno/Yssq2jJmodCD/CchssJ/+L5XK67QuD04hmP
kgiY7AUlzJRS2ECQGZq+jq0gSrkabw==
=zx9m
-----END PGP SIGNATURE-----

--5pfoTXHkUA37GgICinr9tBPf2MBxv9lt0--
