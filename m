Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70364C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4947520828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfF0H5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:57:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:41330 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfF0H5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:57:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A467AAF42;
        Thu, 27 Jun 2019 07:57:34 +0000 (UTC)
Subject: Re: [PATCH 1/2] drm/vram: store dumb bo dimensions.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
References: <20190626065551.12956-1-kraxel@redhat.com>
 <20190626065551.12956-2-kraxel@redhat.com>
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
Message-ID: <a5663141-ebee-db14-30cc-f0b3f90fe6bb@suse.de>
Date:   Thu, 27 Jun 2019 09:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626065551.12956-2-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PNZhXJOw24KwAY0OqG7FiAQoGizuOrBiS"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PNZhXJOw24KwAY0OqG7FiAQoGizuOrBiS
Content-Type: multipart/mixed; boundary="i9KRYARTXh1fZn7QNWgDqOZhwcb3zjCkB";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 open list <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Sean Paul <sean@poorly.run>
Message-ID: <a5663141-ebee-db14-30cc-f0b3f90fe6bb@suse.de>
Subject: Re: [PATCH 1/2] drm/vram: store dumb bo dimensions.
References: <20190626065551.12956-1-kraxel@redhat.com>
 <20190626065551.12956-2-kraxel@redhat.com>
In-Reply-To: <20190626065551.12956-2-kraxel@redhat.com>

--i9KRYARTXh1fZn7QNWgDqOZhwcb3zjCkB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 26.06.19 um 08:55 schrieb Gerd Hoffmann:
> Store width and height of the bo.  Needed in case userspace
> sets up a framebuffer with fb->width !=3D bo->width..

This seems like bug. I'd rather return an error to userspace if the BO
is incompatible.

For the Gnome issue, a fix would be to program the display HW's line
pitch to the correct value.

Best regards
Thomas

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem_vram_helper.h     | 1 +
>  drivers/gpu/drm/drm_gem_vram_helper.c | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vr=
am_helper.h
> index 1a0ea18e7a74..3692dba167df 100644
> --- a/include/drm/drm_gem_vram_helper.h
> +++ b/include/drm/drm_gem_vram_helper.h
> @@ -39,6 +39,7 @@ struct drm_gem_vram_object {
>  	struct drm_gem_object gem;
>  	struct ttm_buffer_object bo;
>  	struct ttm_bo_kmap_obj kmap;
> +	unsigned int width, height;
> =20
>  	/* Supported placements are %TTM_PL_VRAM and %TTM_PL_SYSTEM */
>  	struct ttm_placement placement;
> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/dr=
m_gem_vram_helper.c
> index 4de782ca26b2..c02bf7694117 100644
> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> @@ -377,6 +377,8 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *=
file,
>  	gbo =3D drm_gem_vram_create(dev, bdev, size, pg_align, interruptible)=
;
>  	if (IS_ERR(gbo))
>  		return PTR_ERR(gbo);
> +	gbo->width =3D args->width;
> +	gbo->height =3D args->height;
> =20
>  	ret =3D drm_gem_handle_create(file, &gbo->gem, &handle);
>  	if (ret)
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--i9KRYARTXh1fZn7QNWgDqOZhwcb3zjCkB--

--PNZhXJOw24KwAY0OqG7FiAQoGizuOrBiS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl0UdugACgkQaA3BHVML
eiMtjQf8CxTl5L3xNbrgYeDJOsnk5yrqTOJWx3K9bYD9tX2RdJJvpBqOi4Zzn2VP
P4xktt1sa4DBhoZZSc41IEe2n6Vfwlm9OrFuONMcJVaBV7DsUHeBXc5Z3QJ2xjZ2
h98mh4VUHBFFWrn5Zezx6OMGAXigJYIInhk0x9GncUQP+239XaL7MnuffYWhC2ym
OKOethtUOLU6RTe6x8gYs80fHZ4KDfo1rLPJfoIdj/oqmZby+0b+rzmBuGHcf1V7
Zb8GQfZQfMCtR9pKrCxRgTr6vu4x4D1bMdYcuDQ2lflzgxU1PndFrgnF132OXRzN
puGViOo9KBS53l+LSg8UK+9EcPfOjw==
=dxqA
-----END PGP SIGNATURE-----

--PNZhXJOw24KwAY0OqG7FiAQoGizuOrBiS--
