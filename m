Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A56C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B4A217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edAk+miC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCLLYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:24:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43139 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfCLLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:24:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so2237661wre.10;
        Tue, 12 Mar 2019 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4F+rMkJTHGYdfzngaJwz/m15u2foSWZH1y0nn2S7j7k=;
        b=edAk+miCItdgM97aIIecEVMxCXNc4bgDmr0jikU1aEns/Lea3uTQ6KKPjPrayPHeNd
         iOFmO6oosJXj3PQvzGC0oV6BBSHytnM3K6tTJl0YoNWcs2UD7kt3UQlI7N0JJUW9QaZA
         BPI6MdQ7HJlilAYxDr45QyDDJn3HmcYpc4lc5T3KWs5VwIFXV3Wvd9kYIAtJ3b6cuRPq
         8Qp+4PWBW77J7Z8HUlz9FNr30aG4ENdDByl8Dqtgivel2r8y3l+JwjsU8MW1glTUjaoQ
         +kVvmXKki2nVRqEAhoJjlsa/Kb6u1A30xKLqL9+LWsVHB/fM31EUH/2DDGBa2fCrb7OX
         XzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4F+rMkJTHGYdfzngaJwz/m15u2foSWZH1y0nn2S7j7k=;
        b=q+yZTXBhTrKevhJLxrHPQXq5xqq9MfTS5cLkMNqIiOlSyihBEM8SXi9zmU8cQ4/XNn
         ZW8xj4aWYOGMw8a2nqkVSALDlz9ucy0n9viv3hPLgCqnASLmCIksIF3Ha8k2mF0M06ws
         EfgUdv6KbnVgxKcBMs60drldmHYH04jaXk/pVukxqcA42Vop5YStsNGe1E241y8xWlrr
         v/ELEVtFrAZRxfFv82BUejPsc5QT71BAboENmGPi4X7P6FqK7eiR2ARStCUrHFPG6kJ1
         cowPQZE+7QZG/WgpVZxfcpx0be6rL+m//AQMBl/ul10CmW6T3P8kkAzAjNjGmpQ4MJFd
         lZGQ==
X-Gm-Message-State: APjAAAWptoS3fDnc/LOFDw2RDVoBZfDuK+fU5r8I1AIEl6MS+FSFkdHj
        fmsamoGK6yG4+od945kq4QM=
X-Google-Smtp-Source: APXvYqy+xxD1xbZ3YtYQGeik9kWA3izcG1fj0vHSPODl/xODr4656t2xxPm91/nPX1o+uotDK2A6Lw==
X-Received: by 2002:a5d:5504:: with SMTP id b4mr14041271wrv.137.1552389840531;
        Tue, 12 Mar 2019 04:24:00 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id q135sm3561408wme.43.2019.03.12.04.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:23:59 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:23:58 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        hoan@os.amperecomputing.com, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        robert.jarzmik@free.fr, yamada.masahiro@socionext.com,
        jun.nie@linaro.org, shawnguo@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 12/42] drivers: gpio: grgpio: use
 devm_platform_ioremap_resource()
Message-ID: <20190312112358.GC31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-12-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <1552330521-4276-12-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:54:51PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-grgpio.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
> index 45b8d6a..09d3dac 100644
> --- a/drivers/gpio/gpio-grgpio.c
> +++ b/drivers/gpio/gpio-grgpio.c
> @@ -333,7 +333,6 @@ static int grgpio_probe(struct platform_device *ofdev)
>  	void  __iomem *regs;
>  	struct gpio_chip *gc;
>  	struct grgpio_priv *priv;
> -	struct resource *res;
>  	int err;
>  	u32 prop;
>  	s32 *irqmap;
> @@ -344,8 +343,7 @@ static int grgpio_probe(struct platform_device *ofdev)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> -	res =3D platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> -	regs =3D devm_ioremap_resource(&ofdev->dev, res);
> +	regs =3D devm_platform_ioremap_resource(&ofdev, 0);

Drop the &?

Thierry

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHls4ACgkQ3SOs138+
s6EWCQ/9EHCXbXLCc1FpDnsDfyTyDxLnFG5COjAUiU/kfkLGrNOlsMnZfoGEcyJs
i8EJl62h3GZ+VIfRhnhg+91tNb7zXVi0zt7uZ9aMn0CBomrgL38k3AaKhr7FLmzo
zW3eXxDPIoJSXK1SAyPxfKpw+WO4XY5Ztsx1UOQvdaVGkqNVRKbjtDuKbJz7Utwk
x5L9z6mAsfW0MQ7CWI40tTVjZsNcCLv+QKrE8/iLY1+nrE6u0BL/D3ppt4grD4Bv
UqECNlPWPMSj6mUoluJBq2FMvZcWiYAxqRDCza/CnT/j5RlGYWBPfhvKlfnrUumJ
1NCqXTPMSq125OcxNZwkakUtwVCl05wX6tXBkOuJrSLd93WN0b1Xw5ifPithkTCz
6XAd6/xfOnVUnFT8KftCLTnCF2mSoFLxY4jHDrdHgXNn9Xj2aNwIu8oiTqHkK/Y3
kuTjC+wOCiaCqEf817CMHmg6tXzxLaCM9sr+nzLrJkUL9I7ywyhYa/BYKOHpqWA1
Malob9RzkEG8jr72To6QZXqqLZGaK8iACWj2RIl+QRAs8P5NuSNO6zKJVoO5pe5P
Mp7owrzdbp1zlLcyhmrZDCdLaVXfYtfza8VpxBTfvlGAhV5uJb7ihLfXMD4CWEHj
frCV48106sgIZJI5I93fwYoWeaY76tJaPDtRQiiV5YOEvoPcM3Q=
=CAJm
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
