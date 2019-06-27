Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE336C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40952080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfF0MM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:12:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:56424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfF0MM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:12:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58F9BAC24;
        Thu, 27 Jun 2019 12:12:24 +0000 (UTC)
Subject: Re: [PATCH v2] drm/bochs: fix framebuffer setup.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20190627081206.23135-1-kraxel@redhat.com>
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
Message-ID: <f4cd0030-bc20-58e8-629a-4ab8cc6f6178@suse.de>
Date:   Thu, 27 Jun 2019 14:12:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627081206.23135-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="So3uojqyLOnLZacd1FQK5GGpDU33NWTel"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--So3uojqyLOnLZacd1FQK5GGpDU33NWTel
Content-Type: multipart/mixed; boundary="ukWlB5UqnUmelENCmH8H0mTJbHiVCxXNg";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>
Message-ID: <f4cd0030-bc20-58e8-629a-4ab8cc6f6178@suse.de>
Subject: Re: [PATCH v2] drm/bochs: fix framebuffer setup.
References: <20190627081206.23135-1-kraxel@redhat.com>
In-Reply-To: <20190627081206.23135-1-kraxel@redhat.com>

--ukWlB5UqnUmelENCmH8H0mTJbHiVCxXNg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 27.06.19 um 10:12 schrieb Gerd Hoffmann:
> The driver doesn't consider framebuffer pitch and offset, leading to a
> wrong display in case offset !=3D 0 or pitch !=3D width * bpp.  Fix it.=


Thanks

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs.h     |  2 +-
>  drivers/gpu/drm/bochs/bochs_hw.c  | 14 ++++++++++----
>  drivers/gpu/drm/bochs/bochs_kms.c |  3 ++-
>  3 files changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/boch=
s.h
> index cc35d492142c..2a65434500ee 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -86,7 +86,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>  void bochs_hw_setformat(struct bochs_device *bochs,
>  			const struct drm_format_info *format);
>  void bochs_hw_setbase(struct bochs_device *bochs,
> -		      int x, int y, u64 addr);
> +		      int x, int y, int stride, u64 addr);
>  int bochs_hw_load_edid(struct bochs_device *bochs);
> =20
>  /* bochs_mm.c */
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/b=
ochs_hw.c
> index 791ab2f79947..ebfea8744fe6 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -255,16 +255,22 @@ void bochs_hw_setformat(struct bochs_device *boch=
s,
>  }
> =20
>  void bochs_hw_setbase(struct bochs_device *bochs,
> -		      int x, int y, u64 addr)
> +		      int x, int y, int stride, u64 addr)
>  {
> -	unsigned long offset =3D (unsigned long)addr +
> +	unsigned long offset;
> +	unsigned int vx, vy, vwidth;
> +
> +	bochs->stride =3D stride;
> +	offset =3D (unsigned long)addr +
>  		y * bochs->stride +
>  		x * (bochs->bpp / 8);
> -	int vy =3D offset / bochs->stride;
> -	int vx =3D (offset % bochs->stride) * 8 / bochs->bpp;
> +	vy =3D offset / bochs->stride;
> +	vx =3D (offset % bochs->stride) * 8 / bochs->bpp;
> +	vwidth =3D stride * 8 / bochs->bpp;
> =20
>  	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n=
",
>  			 x, y, addr, offset, vx, vy);
> +	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vwidth);
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
>  }
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/=
bochs_kms.c
> index 5904eddc83a5..bc19dbd531ef 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -36,7 +36,8 @@ static void bochs_plane_update(struct bochs_device *b=
ochs,
>  	bochs_hw_setbase(bochs,
>  			 state->crtc_x,
>  			 state->crtc_y,
> -			 gbo->bo.offset);
> +			 state->fb->pitches[0],
> +			 state->fb->offsets[0] + gbo->bo.offset);
>  	bochs_hw_setformat(bochs, state->fb->format);
>  }
> =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--ukWlB5UqnUmelENCmH8H0mTJbHiVCxXNg--

--So3uojqyLOnLZacd1FQK5GGpDU33NWTel
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl0UsqcACgkQaA3BHVML
eiPuOgf/dIeDhAhZVWHM4iWh7MvIVKAl2Y25KkHSRy8Dmvale9MbgzUuzMMnXSOz
92X0Wt8bA4Y/uRQftcdfWOHck6B77HWtxrsNES4K/YkRG9IdrumgEjjUoH4P4dhf
HGzKIRKOiNfi6V/xNX06N38+ai4yyUJ2ByQSkyiSekBh22sSmahYWTvc485TPKFt
kwftBvuFqIQ5ktp/XVgopbgun1EsIyI8TSbxqPw8y0FWM+uWrgl8b6DPEFZ1xCCh
pU8yiWanz//swDtvZYUCALDtmaDXlU0tw/INIRVO6zOChnG+CtLPt1hqASxuX1yl
JjAgMJlLNuttoXOgPbB35iCcshugUg==
=RTfy
-----END PGP SIGNATURE-----

--So3uojqyLOnLZacd1FQK5GGpDU33NWTel--
