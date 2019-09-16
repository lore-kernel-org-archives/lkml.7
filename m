Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E5C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58711214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KovzaBM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbfIPN7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:59:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37971 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfIPN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:59:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id o184so10534185wme.3;
        Mon, 16 Sep 2019 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=brJuMc+rs4JR/n8EvqMjQOPBaR33yKuj/pzrCTI3Phg=;
        b=KovzaBM2E9VwackUkkqQWE5qLgCF5tU7k+skHR0jUbAVyKJumE9H9vhn5rc+p1KBKT
         SR93WUXmI/jHhn5Hy04NHVwXE84oAhfPiGA18xCoVgTCTmth5eHUIzYVBfe/WIo9+XXy
         g7oLzZXGRBW9gxhvx3fvVNa5UyG9JoT37rBV/I+wZWL6V7/A4UYiiX+vdpfMmWkM3IOp
         yXDvHKqcUVUwOHke+4OUmLOpaJ+ly1vNvfUcsCGapxhN6gv165FyM3H0Z1fesaQblcIk
         hlueZSZ4ORiWzRf/KMrSd1GQzDhzEr0G9FH/0n8oQY71AOK2m5S5PZhs9l6HM/GPZSMX
         Llrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brJuMc+rs4JR/n8EvqMjQOPBaR33yKuj/pzrCTI3Phg=;
        b=pCO8ya7KFBdXJMcnCmsBFEpQ/4rVO1/MH0iW/u3ULjWHihEstS8cty/AXKsmkC6mKc
         wt5x7TGeSu0ZlVIxWNrS3j8Uv0PAMjxTbF9TmskeBjpO0blgh2IkIb/LppA+uUJuw641
         HOKYTuLa4UHtW5afS0LXmC48Z8Un9R73iTjZ7MpjmnVljrpmYJZF9XCDZ8ch94EWnH/P
         zEO+Yewmb08+FPdvihtVitKRjKPsXsTPwNRL3vSxy4BB4FeRSgp5ZeUbdD0PNYSRhy/u
         YsxntFwmk4xi4HnrACB48cG7lsb253dL6ovAupPxp8xLfo32o02mBmw2o0kfB2Zv0ek7
         jp9g==
X-Gm-Message-State: APjAAAWgRlhBvb4JnmoU6LYoFTH4yAeGsQzaZEkbX0Jkas+tfzdsi4VT
        xHSnC50bvkGqRAl9IfY8y3c=
X-Google-Smtp-Source: APXvYqxVIYp+hvzl7WxC/wxt/UcHjrMyBHPfulpQ4YAEWW+bPJY5Oeh2WlonpVR6IhQ21M26ELAOCQ==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr587995wmi.151.1568642346427;
        Mon, 16 Sep 2019 06:59:06 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id e30sm72168031wra.48.2019.09.16.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:59:05 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:59:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: switch to using devm_gpiod_get_optional
Message-ID: <20190916135904.GA7488@ulmo>
References: <20190915071323.GA36596@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20190915071323.GA36596@dtor-ws>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2019 at 12:13:23AM -0700, Dmitry Torokhov wrote:
> We do not really need to use API that fetches GPIO data from an
> arbitrary device tree node, as we are dealing with device tree node
> assigned to the device structure. We can easily switch to
> devm_gpiod_get_optional() plus gpiod_set_consumer_name() and clean up
> the code.
>=20
> Note this is part of efforts to get rid of [devm_]gpiod_get_from_of_node
> in drivers so that gpiolib can be cleaned up.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpu/drm/tegra/output.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

We can't do that. There's a special case in rgb.c that sets
output->of_node to something different than output->dev, so we actually
need to pass the struct device_node * separately.

Thierry

>=20
> diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/outpu=
t.c
> index bdcaa4c7168c..b4248125b844 100644
> --- a/drivers/gpu/drm/tegra/output.c
> +++ b/drivers/gpu/drm/tegra/output.c
> @@ -121,19 +121,15 @@ int tegra_output_probe(struct tegra_output *output)
>  		of_node_put(ddc);
>  	}
> =20
> -	output->hpd_gpio =3D devm_gpiod_get_from_of_node(output->dev,
> -						       output->of_node,
> -						       "nvidia,hpd-gpio", 0,
> -						       GPIOD_IN,
> -						       "HDMI hotplug detect");
> -	if (IS_ERR(output->hpd_gpio)) {
> -		if (PTR_ERR(output->hpd_gpio) !=3D -ENOENT)
> -			return PTR_ERR(output->hpd_gpio);
> -
> -		output->hpd_gpio =3D NULL;
> -	}
> +	output->hpd_gpio =3D devm_gpiod_get_optional(output->dev,
> +						   "nvidia,hpd", GPIOD_IN);
> +	if (IS_ERR(output->hpd_gpio))
> +		return PTR_ERR(output->hpd_gpio);
> =20
>  	if (output->hpd_gpio) {
> +		gpiod_set_consumer_name(output->hpd_gpio,
> +					"HDMI hotplug detect");
> +
>  		err =3D gpiod_to_irq(output->hpd_gpio);
>  		if (err < 0) {
>  			dev_err(output->dev, "gpiod_to_irq(): %d\n", err);
> --=20
> 2.23.0.237.gc6a4ce50a0-goog
>=20
>=20
> --=20
> Dmitry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1/lScACgkQ3SOs138+
s6GZHg/7BvOAV6GlmzRIMTWPhSZVXASdXGoC7OG5Tj/OolqXcAtfPTXIY2EuWnU8
4WWut1Tu2kEUxYOF220ygFHAYcq534dtEQ7tGb6aT2qo+SCs590ohhj5d0aaNP+p
W4gaGaoWabU6e8H0fGrFRayns+k+EMp4LzwkeAyhgVAXnrWSAU/TgLTuV1BVqJx5
/Cl4qvxRtrC4bXqqVpLTKAeu0uJ1/B/Qx8bqXmtWQO7dFVQvUyTubdhuV+qi3ah4
FkVvjAC1y7ipfeJxAOmh6U+zZE07WU2ig9VTk9rT5C5RQk0y7+VyXmn4jleR7QtC
3/sz688DG286/i0rdcgTTwgDPW4B6GC0jHnK7yX9QXus4GYKMW3Jb44MzpdT8njH
HlQzxuliHLsIHpH0bOhO2KIn/PB9WoTswi0A+5BKMzRlbRRbj+i0JSY0YkshiqIx
V6O6fzEYKGjAWmVBZjQLLotTnxPB+hPNA80w09yw6b4A+kTqyre5nUiMPlrQodB3
4+D33AyTq0J6jVM9vra6PxVL+qoQBDbqPdoZcTC19Hu7vHVQYkM9co3lDu6X8Uzo
NchZUvaY/3s2SK1HvkItxyeOsr0GQDqEo5wRDiayCzqiCcDcBqaYGgMuzag88CRZ
s47dRGofk4wxJOkC0NrwWYcLdZdLWKdECBUOo9FWVJM5Pl842KE=
=2VOz
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
