Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC7C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A47D21670
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfIBOYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:24:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730947AbfIBOYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:24:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B869AFCD;
        Mon,  2 Sep 2019 14:24:14 +0000 (UTC)
Subject: Re: [PATCH 2/5] drm/vram: use drm_gem_ttm_print_info
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-3-kraxel@redhat.com>
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
Message-ID: <c3cd7018-b7a1-a0e0-c08b-26fbddca1f92@suse.de>
Date:   Mon, 2 Sep 2019 16:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902124126.7700-3-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yxFLkI6bTqjUZIm2tGnU3xHaNJkSgKNOQ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yxFLkI6bTqjUZIm2tGnU3xHaNJkSgKNOQ
Content-Type: multipart/mixed; boundary="sJPlCeXRdRr0ZhbzxovYhw2Ji5nuQiyFV";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 open list <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Sean Paul <sean@poorly.run>
Message-ID: <c3cd7018-b7a1-a0e0-c08b-26fbddca1f92@suse.de>
Subject: Re: [PATCH 2/5] drm/vram: use drm_gem_ttm_print_info
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-3-kraxel@redhat.com>
In-Reply-To: <20190902124126.7700-3-kraxel@redhat.com>

--sJPlCeXRdRr0ZhbzxovYhw2Ji5nuQiyFV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 02.09.19 um 14:41 schrieb Gerd Hoffmann:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem_vram_helper.h     | 1 +
>  drivers/gpu/drm/drm_gem_vram_helper.c | 3 ++-
>  drivers/gpu/drm/Kconfig               | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vr=
am_helper.h
> index ac217d768456..17f160dd6e7d 100644
> --- a/include/drm/drm_gem_vram_helper.h
> +++ b/include/drm/drm_gem_vram_helper.h
> @@ -4,6 +4,7 @@
>  #define DRM_GEM_VRAM_HELPER_H
> =20
>  #include <drm/drm_gem.h>
> +#include <drm/drm_gem_ttm_helper.h>

Why is this include statement in the header file instead of the source fi=
le?

>  #include <drm/ttm/ttm_bo_api.h>
>  #include <drm/ttm/ttm_placement.h>
>  #include <linux/kernel.h> /* for container_of() */
> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/dr=
m_gem_vram_helper.c
> index fd751078bae1..b4929e1fb190 100644
> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> @@ -633,5 +633,6 @@ static const struct drm_gem_object_funcs drm_gem_vr=
am_object_funcs =3D {
>  	.pin	=3D drm_gem_vram_object_pin,
>  	.unpin	=3D drm_gem_vram_object_unpin,
>  	.vmap	=3D drm_gem_vram_object_vmap,
> -	.vunmap	=3D drm_gem_vram_object_vunmap
> +	.vunmap	=3D drm_gem_vram_object_vunmap,
> +	.print_info =3D drm_gem_ttm_print_info,
>  };
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index f7b25519f95c..1be8ad30d8fe 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -169,6 +169,7 @@ config DRM_VRAM_HELPER
>  	tristate
>  	depends on DRM
>  	select DRM_TTM
> +	select DRM_TTM_HELPER

I thought that VRAM helpers already depend on TTM helpers. If so, this
line should rather be a separate patch with a Fixes tag to the patch
that introduced the dependency.

With these points addressed:

  Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

>  	help
>  	  Helpers for VRAM memory management
> =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--sJPlCeXRdRr0ZhbzxovYhw2Ji5nuQiyFV--

--yxFLkI6bTqjUZIm2tGnU3xHaNJkSgKNOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl1tJg0ACgkQaA3BHVML
eiOWfQf/TJqVXilnjtP1zv0wRaQ8jbDP6t+fEGYpjE1mS2RfVcJmmy64hYsRsCaQ
uUNkTx0LpSv2Y3X0Mj0uPd9zNmzhfYM4gzUFWFHJp/QzbRiPG793q03/LvtCZXdt
DdTRv2+XEMPl8YPth8tZiYpSOhqOdfR7gzVX0/6AmsMf479wFtp6KbDtFW9FkD1p
3XRidkrEo8OGPyxtiQ+CtQUileJJTviA5TOQIyR1w1iVJvQjQS+z05VyXc4vXojt
kaNH/VEO8KlxL0/i0vdH4LmwswHRfK/Ba+kbitDrGlDZCS17i0ZfO8dj4btkavKR
Bo6lF8oC/69N/Z6im1yACH9aDxINCA==
=7qpH
-----END PGP SIGNATURE-----

--yxFLkI6bTqjUZIm2tGnU3xHaNJkSgKNOQ--
