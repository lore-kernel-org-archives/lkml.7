Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B314C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE04C20657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHAkCnQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfCDXYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:24:46 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38151 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDXYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:24:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id s1so7101066qte.5;
        Mon, 04 Mar 2019 15:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f5lnnOQQAlZeFfSi/MXvqHgP0stbrXzz3jkh8Ytum7Q=;
        b=nHAkCnQLhEY5lJigM2ESpTjmZOm3Gxkw+QaGMKzFLdtgRSVE3ysZiv2XBSe/6lABjr
         iPa+nfdAPl+jlayj7aEh6pk0TIgUyYBzI4bzELuvO/+G6grHvbsGmCk2tC/AAv+oGGPh
         HTjw8oY5ypaFe1PUqItLWT4FXvZcKxx1Jnj0fCx9uEYlEiLg4MeEbGzYP+1CXYGZ2YQN
         0lwxYYGFJ1EIMyV60U5PyevkNaWjjM9M/aYp7WopEqCEwh6AkaM5W8XuQd9+GhWHl11H
         h7w/lFAqFoMccxBngrdl4lynh5q+w5dVIBd2exY5HzCvJPlcFNKP0nrBsqYJc8BBTft0
         wDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f5lnnOQQAlZeFfSi/MXvqHgP0stbrXzz3jkh8Ytum7Q=;
        b=JVOPqZ8ECI21TLA9eaZ4IbCzqiYgq0uLqmjREgA/ufv47p40ZTO42SN597K6maEyZq
         55iz52kRcO5UCKbiBa9uevJ7ZgRxDWUhqZe/AkqBdf7YY3LvxzO8yK09FNZDiz/Mo2xH
         TVEU/GFCSDPL5lzuvpf4i/CsQyTvnHWM19hvHk+MIqvbstevkPSG1+3ZS6RwPcmmfCEW
         saMqZb5cw9LIK6DThqpGmiOXhM38zjVMa9sjyXE/yEwi+2iPJAeO1NsRYtAUhpe9l7EL
         JX5eB1jAjcC3/ctqD3QiVZ5OEzk2ZkxhbEo/NCJ1cBsCcMAywJRIxoaY14Ig8+vYtwGk
         BkdQ==
X-Gm-Message-State: APjAAAVvVvdnICW3Q6LmrkItNqdWEk/w7gBufRCRF5w9rhhK7XZWwKJV
        +2uda4GcQaH9LvlSgeoHQds=
X-Google-Smtp-Source: APXvYqwJavwgrBOnalckzmRUI6RWhJou/5cDhMMtnizetCu6fdSKiH3STKOMkabnYLjdXPuje7Ysyw==
X-Received: by 2002:ac8:2d85:: with SMTP id p5mr17000391qta.136.1551741884708;
        Mon, 04 Mar 2019 15:24:44 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x80sm6325496qkx.85.2019.03.04.15.24.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 04 Mar 2019 15:24:43 -0800 (PST)
Date:   Mon, 4 Mar 2019 20:24:40 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] drm/vgem: fix use-after-free when
 drm_gem_handle_create() fails
Message-ID: <20190304232440.epotc72sa5svclc2@smtp.gmail.com>
References: <20190226213053.GC218103@gmail.com>
 <20190226214451.195123-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="il7sctba46rhcpoy"
Content-Disposition: inline
In-Reply-To: <20190226214451.195123-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--il7sctba46rhcpoy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02/26, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>=20
> If drm_gem_handle_create() fails in vgem_gem_create(), then the
> drm_vgem_gem_object is freed twice: once when the reference is dropped
> by drm_gem_object_put_unlocked(), and again by __vgem_gem_destroy().
>=20
> This was hit by syzkaller using fault injection.
>=20
> Fix it by skipping the second free.
>=20
> Reported-by: syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com
> Fixes: af33a9190d02 ("drm/vgem: Enable dmabuf import interfaces")
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/gpu/drm/vgem/vgem_drv.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_=
drv.c
> index 5930facd6d2d8..11a8f99ba18c5 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -191,13 +191,9 @@ static struct drm_gem_object *vgem_gem_create(struct=
 drm_device *dev,
>  	ret =3D drm_gem_handle_create(file, &obj->base, handle);
>  	drm_gem_object_put_unlocked(&obj->base);
>  	if (ret)
> -		goto err;
> +		return ERR_PTR(ret);
> =20
>  	return &obj->base;
> -
> -err:
> -	__vgem_gem_destroy(obj);
> -	return ERR_PTR(ret);
>  }
> =20
>  static int vgem_gem_dumb_create(struct drm_file *file, struct drm_device=
 *dev,
> --=20
> 2.21.0.rc2.261.ga7da99ff1b-goog
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Applied to drm-misc-fixes.

Thanks

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--il7sctba46rhcpoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlx9s7gACgkQWJzP/com
vP9+dA/+KaWJNQbLg0uAECcJbJqJQPDnLHqi6HbKeZee2w2kYKWz3qMZQn+7oZZV
mXgFvWeP3Wh6klIwqJltyDyWezjpK4OKp7YaXSzWPHUyVDOH5tj3bhul2ilknZAj
NhdhcRlBCY4Cxk9kPtJyTHRSUpZ/m5Mw5AYXPiuljY/Jlus7q6bgHlw+EBJtn/l/
Ov/KJbThDKC1H+B/234Ndmmqc00cR1aul+trmmzfZYelYoVz/JzQAYA7cD7jDOzk
+lEhUn2mptYHhvx+uuZZNXW0hAfTvBf62KNx+i1ELfb8GVwB9mgVBi5Q7lO/G9+X
yIUYrsfAl6BH16adRxPSCeCnqfFxZDppVylsMfvqbIGd37SFuS7ArGAELoXzrxRk
M0eCABM/o+6J2gtn7RzUg5E5yLXMb4MStc6J10N1WzPhSELhyPaxcvqTrVzTKWAX
d60jmTUSGQEQYPrRFRb7/EnuNAoghHs5KKq0clJ6hkGAdyc7mWIdqLqNGBuHXMea
NVU0EY6V2L6iYuz/Uf+vorTJfrEli2OstnN2YxahALRxIwTLxqyeJWPLGbPHiFJ+
uaqgSngT06gLeMl287z5iFAG9aEK64fWT/avUzRHoqdDHs8ErhmCAjA6lTfgOkqb
4yT0cyTFCJYk28UL5BIIv2/P3g43/IkGeIuVrEdIQrbZyBVT8tM=
=C2Dr
-----END PGP SIGNATURE-----

--il7sctba46rhcpoy--
