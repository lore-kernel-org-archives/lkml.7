Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33702CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB3021872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3GY4JRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392132AbfJWOQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:16:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37434 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392122AbfJWOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:16:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so13596952wrv.4;
        Wed, 23 Oct 2019 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UAmBCpYVREnT9sFsheyKh8dqijvBgfTzNlMnZDlGZ1s=;
        b=l3GY4JRDwmepq3JEx195FaY4MISpM12L2SwTCrDmUsI+DmxrqdeHu6Yq2SV+zXiMd+
         zALd/UI++9YBxBmWDng8KiSyxyh31WJO3sCkR0w2TcJY9FI7HevZ1mBPUO6fbOA33eOW
         pdt0c365RNm9rccaEgiiDqn16A7ODiFax2ywr1xaJGR4SqPWSO6eCzITYBc0cGwmVCRV
         ddpA0LJcp7a06iZ1RlEV9gPrKB2AZdBnxNlpkCIK4a01IrU8h9FhNvk0egojBGmhj51I
         2DQshaZj+FLsg6QALWtHF3i/AsLWZ8TTew4kiIMEJ0EhqEl70VXKmJ+bnXlVGrJqmD27
         pImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UAmBCpYVREnT9sFsheyKh8dqijvBgfTzNlMnZDlGZ1s=;
        b=pBnB+2waLT5rM6sbyBFq7VCa8ZcQVkLybytgrBZVwqHCJn63jVeUXXQbObQHk+8X+T
         +g0qH+mEX3cRJxDHjrl7l0JjA72d7vfOZljHNtTLuFdwuetaOYnJJlLZhiyvDVXDUOuE
         FH1ccznILnTyWr+SQg1chMqGeYP7+Wsim8QRwFFUk6gFHtu7Jv/sB1HfBUWpWrOGoHUB
         eKXWZIwzHl88Oxtnd4eN2R2MB/f48hBgwnjn+yeImaUPwmkjZfnPJjG1ysxG+NxE03YU
         mOLl+5h6BGbcZbyiO5wgtkLWCKMrI30EZ4pwwHxXSjSb/2XXJ0IaYjb9IBPcoQU/fLNG
         mm2Q==
X-Gm-Message-State: APjAAAU6FOoT+dczxGjQfOkmEx4PtYAX8kx0n7w/nnJrLYOISbEhivwO
        mcGZys15mldrT+C4pIEUhCQ=
X-Google-Smtp-Source: APXvYqwzpFUkA2x7B4BUKk0AY/CpNtGQNLhOYNdD30hhYEmMWqVVjOYUONq0veuhkqZJwqzXXfTp+g==
X-Received: by 2002:a5d:614e:: with SMTP id y14mr9133892wrt.329.1571840199240;
        Wed, 23 Oct 2019 07:16:39 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id u1sm32589818wru.90.2019.10.23.07.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 07:16:37 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:16:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/tegra: plane: Remove format-modifier checking
Message-ID: <20191023141636.GB2711737@ulmo>
References: <20190224153405.8447-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20190224153405.8447-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 24, 2019 at 06:34:05PM +0300, Dmitry Osipenko wrote:
> Tiling modifier can't be applied to YV12 video overlay because all tiling
> modifiers are filtered out for multi-plane formats. AFAIK, all modifiers
> should work with all of formats, hence the checking is incorrect and
> simply not needed.
>=20
> Fixes: e90124cb46bdb ("drm/tegra: plane: Support format modifiers")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/plane.c | 16 ----------------
>  1 file changed, 16 deletions(-)

I'm hesitant to apply this because we don't really have a good way to
test that this is actually the case. I vaguely recall that at least for
some of the block-linear formats supported on Tegra124 and later there
are additional restrictions on when they can be used.

There's also the problem that using these block-linear formats, and I
think this even applies to the TILED format on older Tegra SoCs, results
in higher bandwidth requirements.

Bandwidth requirements is something that we don't really concern
ourselves with, and that's bad enough as it is. I suspect that once we
blindly allow all format modifiers we could easily run into situations
where the display controllers underflow.

Now, regardless of which way you look at this, it boils down to testing.
We don't have a good way of testing various combinations of format
modifiers to verify that they work. You say yourself that "AFAIK, all
modifiers should work with all formats", but can you really know for
certain? Until we're able to properly test this, we really can't.

Given all of the above, I think it's better to be prudent and only allow
format/modifier combinations that we've actually tested. I'm not aware
of a good way to test planar formats, so we don't have a good way to get
the results that we need.

I'm all ears if you know of a good way to test this. It doesn't have to
be anything fully automated. Automated testing is especially difficult
to do for display because it usually needs visual inspection. But that's
okay, I'm willing to settle for something that we can roll into a script
and run manually after boot until we can find a way to automatically do
this type of test.

Thierry

> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
> index d068e8aa3553..5a8a3387f5ee 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -72,21 +72,6 @@ static void tegra_plane_atomic_destroy_state(struct dr=
m_plane *plane,
>  	kfree(state);
>  }
> =20
> -static bool tegra_plane_format_mod_supported(struct drm_plane *plane,
> -					     uint32_t format,
> -					     uint64_t modifier)
> -{
> -	const struct drm_format_info *info =3D drm_format_info(format);
> -
> -	if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR)
> -		return true;
> -
> -	if (info->num_planes =3D=3D 1)
> -		return true;
> -
> -	return false;
> -}
> -
>  const struct drm_plane_funcs tegra_plane_funcs =3D {
>  	.update_plane =3D drm_atomic_helper_update_plane,
>  	.disable_plane =3D drm_atomic_helper_disable_plane,
> @@ -94,7 +79,6 @@ const struct drm_plane_funcs tegra_plane_funcs =3D {
>  	.reset =3D tegra_plane_reset,
>  	.atomic_duplicate_state =3D tegra_plane_atomic_duplicate_state,
>  	.atomic_destroy_state =3D tegra_plane_atomic_destroy_state,
> -	.format_mod_supported =3D tegra_plane_format_mod_supported,
>  };
> =20
>  int tegra_plane_state_add(struct tegra_plane *plane,
> --=20
> 2.20.1
>=20

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2wYMIACgkQ3SOs138+
s6HMUBAAkMcnsil5fbLkuO3EK8JFeZkIcJpkCrVe3OK7UjFRAi8RGLKxLc4n5N3Q
3WSZG6CHX4YmtHa8jkjUnX9dzgqTmmm2WBh5IjR2+XuySf9c7rSD0EF2Gzsy6Y4w
YJDAas34D73oWmP5HfF4bg+WV7kXFvorx+zb+QUzbu7GpJw/mEuPGqaE4KQQwt+A
eF0XjJPEitEhmGMSEgXR4DEA9NxeckZMYYuPl8jENunE8LlMIpqZy0Y3WQPT4y2W
G9AFYI4VTK3kk8sdAAFkjwbWXCk++VDiGKDDcKg+8K0fCiVpRnzTo1bI9AAQWyoU
Adf4i//PLZ3ieZgNzm9KafoRGVttPIo6JcrvQfi/0e8SO/8ynktPmCEwGPnJnDVZ
xMRPz8jlUlj7kovq0DodXL2OKFmNCdO9jS1FMALtyojS+iSZejqXUJ3mlScckxIT
6JSi/n7GhoPGaQWKnRsSDIjCSal5dGwVzOD2phZUwYPjaVwkJ6tjhQpY0KFE0kb6
i9layrE5Pb/49/RuqlXfkrprKKpO7skRLz4kmliDa86nKMW9c2aFI1N15YA7D39O
uFkQPm3HE86SPv0ZqYZYzne3BEKw0E1oWn54m0jCIu/Ixh1POjRfcsALsrvzOcIY
VuBZmgntOG32AEnVVMHKFrAXHxa4yQTLEUJ5g4zDCKDl63Enqf0=
=LGMI
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
