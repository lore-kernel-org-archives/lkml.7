Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F332C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E32C21479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbfIIHLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 03:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731421AbfIIHLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0E7AB655;
        Mon,  9 Sep 2019 07:11:12 +0000 (UTC)
Subject: Re: [PATCH 3/8] drm/vram: switch to gem vma offset manager
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
References: <20190905070509.22407-1-kraxel@redhat.com>
 <20190905070509.22407-4-kraxel@redhat.com>
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
Message-ID: <d040188e-5986-8114-1118-10081b2bbda2@suse.de>
Date:   Mon, 9 Sep 2019 09:11:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905070509.22407-4-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="evHEEYnCrnkrpKn1EexwPmjcNWrFjwEZ3"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--evHEEYnCrnkrpKn1EexwPmjcNWrFjwEZ3
Content-Type: multipart/mixed; boundary="fy5y8dzbOnWfhmhb7UDF0AN0AXYPbOmiN";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 open list <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Sean Paul <sean@poorly.run>
Message-ID: <d040188e-5986-8114-1118-10081b2bbda2@suse.de>
Subject: Re: [PATCH 3/8] drm/vram: switch to gem vma offset manager
References: <20190905070509.22407-1-kraxel@redhat.com>
 <20190905070509.22407-4-kraxel@redhat.com>
In-Reply-To: <20190905070509.22407-4-kraxel@redhat.com>

--fy5y8dzbOnWfhmhb7UDF0AN0AXYPbOmiN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 05.09.19 um 09:05 schrieb Gerd Hoffmann:
> Pass gem vma_offset_manager to ttm_bo_device_init(), so ttm uses it
> instead of its own embedded struct.  This makes some gem functions
> (specifically drm_gem_object_lookup) work on ttm objects.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/drm_vram_mm_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_vram_mm_helper.c b/drivers/gpu/drm/drm=
_vram_mm_helper.c
> index 56fd1519eb35..3b2552bec4e6 100644
> --- a/drivers/gpu/drm/drm_vram_mm_helper.c
> +++ b/drivers/gpu/drm/drm_vram_mm_helper.c
> @@ -172,7 +172,7 @@ int drm_vram_mm_init(struct drm_vram_mm *vmm, struc=
t drm_device *dev,
> =20
>  	ret =3D ttm_bo_device_init(&vmm->bdev, &bo_driver,
>  				 dev->anon_inode->i_mapping,
> -				 NULL,
> +				 dev->vma_offset_manager,
>  				 true);
>  	if (ret)
>  		return ret;
>=20

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--fy5y8dzbOnWfhmhb7UDF0AN0AXYPbOmiN--

--evHEEYnCrnkrpKn1EexwPmjcNWrFjwEZ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl11+w8ACgkQaA3BHVML
eiMMMwf9HCG98d5k5+woxDZUZSpVtQZxqilFr6vp11wxHNQdXMaHJ/WCCwAFZV+5
K+HA3IAs5vU9Z/K6bg3orBVgZW6Ja9+w/Aetfm3mbJ09txdC4NJAB6ikHNpxEAhL
qrNHBjRf4MnNdc7iw13KNx0ukL232/yyPyuLQv9CNrbfoFBV/kdweEpUipDHLuVm
bzEX9dVKkha+Tl9MWlgCAZof8ZRyxNaQdTyjyTYlcEJrrxSIv9rj504evbBEfWCo
6uwx3hmPxJ/WahsYrCUQtEJNhO3elKMBzKqIDL492oHbEAPT/tJuCTqgCGxF3niJ
pJtLgO2slITULHYa6k16pznbBa94sQ==
=klGI
-----END PGP SIGNATURE-----

--evHEEYnCrnkrpKn1EexwPmjcNWrFjwEZ3--
