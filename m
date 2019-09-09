Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18093C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A20218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfIIMrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:47:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:58956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727474AbfIIMrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:47:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 467D0AFA5;
        Mon,  9 Sep 2019 12:46:58 +0000 (UTC)
Subject: Re: [PATCH v3 1/7] drm: add drm_print_bits
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
References: <20190904054740.20817-1-kraxel@redhat.com>
 <20190904054740.20817-2-kraxel@redhat.com>
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
Message-ID: <66258358-b27e-4eb1-44a4-c90aa342293c@suse.de>
Date:   Mon, 9 Sep 2019 14:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904054740.20817-2-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2skgr6sFYrh1Z5EQHu05feTjEDtqucFhH"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2skgr6sFYrh1Z5EQHu05feTjEDtqucFhH
Content-Type: multipart/mixed; boundary="cvmaHfE2YJqR393NckYCCAwLsnpy2D3uw";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 open list <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Sean Paul <sean@poorly.run>
Message-ID: <66258358-b27e-4eb1-44a4-c90aa342293c@suse.de>
Subject: Re: [PATCH v3 1/7] drm: add drm_print_bits
References: <20190904054740.20817-1-kraxel@redhat.com>
 <20190904054740.20817-2-kraxel@redhat.com>
In-Reply-To: <20190904054740.20817-2-kraxel@redhat.com>

--cvmaHfE2YJqR393NckYCCAwLsnpy2D3uw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 04.09.19 um 07:47 schrieb Gerd Hoffmann:
> New helper to print named bits of some value (think flags fields).
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_print.h     |  3 +++
>  drivers/gpu/drm/drm_print.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 112165d3195d..12d4916254b4 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -89,6 +89,9 @@ __printf(2, 3)
>  void drm_printf(struct drm_printer *p, const char *f, ...);
>  void drm_puts(struct drm_printer *p, const char *str);
>  void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32=
 *regset);
> +void drm_print_bits(struct drm_printer *p,
> +		    unsigned long value, const char *bits[],
> +		    unsigned int from, unsigned int to);
> =20
>  __printf(2, 0)
>  /**
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index ad302d71eeee..dfa27367ebb8 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -185,6 +185,39 @@ void drm_printf(struct drm_printer *p, const char =
*f, ...)
>  }
>  EXPORT_SYMBOL(drm_printf);
> =20
> +/**
> + * drm_print_bits - print bits to a &drm_printer stream
> + *
> + * Print bits (in flag fields for example) in human readable form.
> + * The first name in the @bits array is for the bit indexed by @from.
> + *
> + * @p: the &drm_printer
> + * @value: field value.
> + * @bits: Array with bit names.
> + * @from: start of bit range to print (inclusive).
> + * @to: end of bit range to print (exclusive).
> + */
> +void drm_print_bits(struct drm_printer *p,
> +		    unsigned long value, const char *bits[],
> +		    unsigned int from, unsigned int to)
> +{
> +	bool first =3D true;
> +	unsigned int i;
> +
> +	for (i =3D from; i < to; i++) {
> +		if (!(value & (1 << i)))
> +			continue;
> +		if (WARN_ON_ONCE(!bits[i-from]))
> +			continue;
> +		drm_printf(p, "%s%s", first ? "" : ",",
> +			   bits[i-from]);
> +		first =3D false;
> +	}
> +	if (first)
> +		drm_printf(p, "(none)");
> +}
> +EXPORT_SYMBOL(drm_print_bits);
> +
>  void drm_dev_printk(const struct device *dev, const char *level,
>  		    const char *format, ...)
>  {
>=20

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--cvmaHfE2YJqR393NckYCCAwLsnpy2D3uw--

--2skgr6sFYrh1Z5EQHu05feTjEDtqucFhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl12SbcACgkQaA3BHVML
eiOgMQf+OLBhvRiFKKfSph9H1t6UnHvMrW1HxM+GGcoPTfz8kjSr+9E1QE1vdLGs
XaU+2xBkVL38+Jo8CzwtFqAqiqhzc1nV1JECpzLcmnFSEjRKvBTZWz0Fv4OWhfCl
FFXwTqgkVAU2aZXzJWdIgQRsdMc3R352tvt+m+tkNQElmGUoTMQYcOKG6sR8sEru
w4veeSUGSowctfDrX2CsyFL635utCLwBcSg/PMXt2q4dbF00hP5h6M3f10SWUViM
OtsUksUXdjOGKLwyCoP2Wtgojl6VPTPlQTV273WOjlBy8htLPpeFa6tW9Srbj7Bm
qFeTeVXG6UptWfQBbVFzVIV4EPq7Bw==
=tGTV
-----END PGP SIGNATURE-----

--2skgr6sFYrh1Z5EQHu05feTjEDtqucFhH--
