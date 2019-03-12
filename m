Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35FCC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07E1206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgB8DM6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCLLX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:23:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfCLLX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:23:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id w2so2231524wrt.11;
        Tue, 12 Mar 2019 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WkqXir7d0kiPSBGahHcDiyTlMGo+FD0Upe9kA2SQVWk=;
        b=TgB8DM6OdkmZDPESC1j3T4I8DfjMth5smtRXXF8b1yaDc0rwUz7LwsGDXrQX3+vMis
         q1QJgs5+GxiynsTlIvE5kcCSfyNBpCTJVOfKLGWNemsVmLbM56/WJBkxJ2QW9CW4oHow
         7QEy0rTE+zXgVvbR+bODzdSPMPzzfYxX9eCIzkk9VIsK82+sI48GClrg9zRkUj1o8SQg
         n5W9EF3MoEh5IdedFqHYydtRInDmAlGQtJw0exkNjZpdmXp7gtyUN33dF660i54stTAa
         kHVs+dsVJ+96qLo693aPkbh13GcJx2EQm+ByGSv/TmCEJeudoAhoagrJ3AfJl7if4swU
         WRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WkqXir7d0kiPSBGahHcDiyTlMGo+FD0Upe9kA2SQVWk=;
        b=amuxrCxAhlXBPFgp8cdaxnWrkUOuXnVIA2GB1cjHj8Hz2Ju6bkvgfJcx3uoEluaOuV
         gVCcfPawjOSMpHm//VI01C7L0AY7kW6CUwCf7KK8KukKmU0uwG8vmobp/uYZUhjIKHpa
         vuwAukHpBZb01+/ftWCXzokM06TmD5f3whAA/TbVmEkfievP0EoNci/8G3JXYcMZUma1
         bI2fzaAjqlbvwPefTBMGy+8glnbE6ujH2vU5SITIVGVwZqlNLKEbB+UJo1qVDA4llxVb
         5f2ilM0vXU/URJgTFx0VRf/kosW9f0MlNb/O1Toh37GWeJ9qfy8ni3FKTWYMZiQu+BkP
         +Mfg==
X-Gm-Message-State: APjAAAVcGBLlyjCnjnik1qSWkpO+8NwmcGUpOr5j3J8+HteRiy0+f7/V
        5dyRfBdxXalS77uc17YBwP0=
X-Google-Smtp-Source: APXvYqzsVPrc0c0bozK9iQJ3x3PKgJqFrT8ikjklmfb7JMOUatDKYHh4JsaIJ8lVit5ickXYgZL55Q==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr4779526wrt.12.1552389806029;
        Tue, 12 Mar 2019 04:23:26 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id j1sm2027521wme.4.2019.03.12.04.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:23:25 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:23:24 +0100
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
Subject: Re: [PATCH 10/42] drivers: gpio: ep93xx:
 devm_platform_ioremap_resource()
Message-ID: <20190312112324.GB31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-10-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <1552330521-4276-10-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:54:49PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-ep93xx.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
> index 71728d6..52e9a7b2 100644
> --- a/drivers/gpio/gpio-ep93xx.c
> +++ b/drivers/gpio/gpio-ep93xx.c
> @@ -393,16 +393,13 @@ static int ep93xx_gpio_add_bank(struct gpio_chip *g=
c, struct device *dev,
>  static int ep93xx_gpio_probe(struct platform_device *pdev)
>  {
>  	struct ep93xx_gpio *epg;
> -	struct resource *res;
>  	int i;
> -	struct device *dev =3D &pdev->dev;
> =20
> -	epg =3D devm_kzalloc(dev, sizeof(*epg), GFP_KERNEL);
> +	epg =3D devm_kzalloc(&odev->dev, sizeof(*epg), GFP_KERNEL);

odev -> pdev

You should write some scripts to compile-test these changes. Compilers
are good at catching these silly typos. Humans not so much.

Thierry

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHlqwACgkQ3SOs138+
s6EXlQ//UlPhWGa4orxXlExHArR+1/Kgj0PTzlH1CExKaqMqH7TZEDb9TOLPAp38
Yea3rxI53Y+OgGrqhKku98gdSclm414zA6DLyukxKZK42DFEyvQBmGDVetQXRMyF
+thSWF271Hh1ZHWFR1YB0WV7h3qmZv3KLzbVd7uWeWbfA1acXTo1kn/XKMkRNfrr
OU7upm0agz3CzWBnd4AhFPr+LhIaNMq92fg2VTmuMNQFR8sMFn2Nd1f/Rh73y8ZK
1OXg8amO4kMeGKMp6Q/ApWehhZb07JGUqatjVdxdEzIYedXlTjV/uPt8bTyv1xRG
3UJu6Qez7dMgoNVKDyXDo+6XAWKkYenVrrcEBD+HDAYVsO7CMRf8nP4lH8w+/YTi
7jWzhOaCmM4Rrl8aOhQ8eizZUyAa36vWKnm9k1KOmQwu5A2Pe8rg357MH5lExt2W
WCN7U8AlHLhDKSVQGiS2Ajw8MfYik+GQ4DY6BLRWn3FOGV+l3XWNGoQCrQm9JhpS
Lgq8AY4beeSk5W7/1ccXF3TWGHOcfGveBlQEM1avq64k8RD4q7PfgOrd6JW0ejr+
2BkR1urgcSzvdTgKfqeg+krpPNmyfvxIAhEX4/3Uj/09V8nb6a+jmvsznkG2OQ5f
ma/tRUrK74kFZlkoxR5mtHlSFksQA3qWKC1v8hweexhm7LUJD7Q=
=OJtP
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
