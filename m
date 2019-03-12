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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D851EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D25A2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx4Y47Yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCLLhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:37:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37004 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfCLLhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:37:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id x10so2216966wmg.2;
        Tue, 12 Mar 2019 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02NJNpf9xftt9Jxg0i5VP4bGJO4Ftj6yP7T1GxfxOPE=;
        b=bx4Y47YjIpRBe7OWb9QtvJgqhUob/ITaPZ3DfJ3dLEmnKZm78W3K2Z+BbBfq38jo45
         KAXiwiTLGXWYs5zyyEQovUIkx+PWta3mgmVSFTEBq5Vz8etCcTueDXuF9e3M78wo396t
         NSe43a4FHz/Ha3RFbG3WtIcpr+WKArT0/53e7JDYc3sWAE6wXO3V2bV6dp/y6DFTrAVu
         MUyLUBirhGRgHWFh74QJ9VR88Hrk7MoCLOBCVSVn4xHf0YQzpqCpA1H8yxJ/qOY68i21
         42nmgUjlcftaxi54Ss70s6dwZobrdWzEwvwD5bsr2cpi4+oZpP8+4VaqNbSViOY7AmbT
         nWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=02NJNpf9xftt9Jxg0i5VP4bGJO4Ftj6yP7T1GxfxOPE=;
        b=C2V3TUCcv1Z9gBp3dqNUhSq1FCWyNTU0Nbk0tqK8RPej0+DZhHcXM02ogv6fy9299w
         KGF9LqGtU7BnpJNh8kfx9lijcNq4iYxys8Dl/Xkgup94AvDYyYPU4UHTz3SRTq6JK3yP
         +nPSPjfOpGXt3X2XSV2/J2SD3ziw4SEmyTQ43fAlsq20hhhddvGyc0alQ9mY8YqUMsoI
         /vsjZB8k7V4CM+k2ztJI0yHuiTCNlCYFkzTbHiTI9fbZYwpFhle0IER6z2VkWIpAajmO
         JPTuqes0HqXeD8JzeJqy69ygjjYEw2XNFfsZzDTpTua4DVRwwDAQlHXf8Wov/LMPYxhm
         DHWA==
X-Gm-Message-State: APjAAAWR6vqBsw/zqSC4+YIKCBSNzKXxoshokUiTXtl98RqX4pzNK5kG
        eCA0zSRQkT1xD0eirKydzvkQEUeE
X-Google-Smtp-Source: APXvYqzR56N0XUCoqRCTiH1vFQODSsgDZ827Abey7jAuHhEk0wmWhBnL/XIVmbafF3pnviSFlHj1NQ==
X-Received: by 2002:a1c:9694:: with SMTP id y142mr2019570wmd.98.1552390655001;
        Tue, 12 Mar 2019 04:37:35 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id n6sm12475415wrt.23.2019.03.12.04.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:37:33 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:37:32 +0100
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
Subject: Re: [PATCH 38/42] drivers: gpio: vr41xx: use
 devm_platform_ioremap_resource()
Message-ID: <20190312113732.GG31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-38-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <1552330521-4276-38-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:55:17PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>=20
> this driver deserves a bit more cleanup, to get rid of the global
> variable giu_base, which makes it single-instance-only.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-vr41xx.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
> index b13a49c..98cd715 100644
> --- a/drivers/gpio/gpio-vr41xx.c
> +++ b/drivers/gpio/gpio-vr41xx.c
> @@ -467,10 +467,9 @@ static int vr41xx_gpio_to_irq(struct gpio_chip *chip=
, unsigned offset)
> =20
>  static int giu_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
>  	unsigned int trigger, i, pin;
>  	struct irq_chip *chip;
> -	int irq, ret;
> +	int irq;
> =20
>  	switch (pdev->id) {
>  	case GPIO_50PINS_PULLUPDOWN:
> @@ -489,21 +488,14 @@ static int giu_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -EBUSY;
> -
> -	giu_base =3D ioremap(res->start, resource_size(res));
> -	if (!giu_base)
> -		return -ENOMEM;
> +	giu_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(giu_base))
> +		return PTR_ERR(giu_base);

The driver currently doesn't request the memory described in the
resource, so technically you're changing behaviour here and with your
change the driver could now fail if somebody else has already claimed
the memory.

Looking at arch/mips/vr41xx there doesn't seem to be an overlap between
the memory region used by the GIU device and any others, so this should
be safe. Not sure anyone still has hardware for this around to give it
a spin.

Thierry

> =20
>  	vr41xx_gpio_chip.parent =3D &pdev->dev;
> =20
> -	ret =3D gpiochip_add_data(&vr41xx_gpio_chip, NULL);
> -	if (!ret) {
> -		iounmap(giu_base);
> +	if (gpiochip_add_data(&vr41xx_gpio_chip, NULL))
>  		return -ENODEV;
> -	}
> =20
>  	giu_write(GIUINTENL, 0);
>  	giu_write(GIUINTENH, 0);
> @@ -534,7 +526,6 @@ static int giu_probe(struct platform_device *pdev)
>  static int giu_remove(struct platform_device *pdev)
>  {
>  	if (giu_base) {
> -		iounmap(giu_base);
>  		giu_base =3D NULL;
>  	}
> =20
> --=20
> 1.9.1
>=20

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHmfwACgkQ3SOs138+
s6GpPw/+PO40QInzGgfRGJGf5fQ2uQKUwIiH2EQxp0L7tmyvF/ZYodNb2Oy16DM4
ypJlpKtRU8udgnhj6h4Jr+rJ50Ak5Nz26aBltA0XVBpUm7eEfLbA3egfup3BtXDR
eERmniHeC83brj+qd2ttpngN0p4RF06BiUtpqWQwYbPaM6ZRhZfqRr5Y3m673vRn
Wm/uKpNVXJ+LjqDEbbwuawy9icfTjPK9u4x5W80H1Qw4AnQEH66cB6isB7kXCKNT
hVA1AKnc2wor3HEQxNBhGESwg5j1tzBYQK6RJ6fVB9cnpOFQGjPCIjYsyJdNf1wc
T27zc3UEL4Sy20crfEzVMaP23khdcdUFlyqLfnPfY3JmUT4NhhZr0FVUGP9iUHPa
hLDtXwUEt+Ojol9uIAyT8OePfSm797Xpk6t+WVpt3H8hrXvXdo77NGUUZXG/IInq
QAMeV/yN/iNOnUguWe7xjBHQLuVUbm+yuNCgKWFG+DOOKYjN8TLmuju1SeHHj/fx
wge65+PnS+SiHzaNz8icRZHaH9VWSGS2qCvEcMuoGJZjGyz3ajaqdzSVfm0TsnIT
R87r1B46OZC++ztZicofvfGtc1vInwaE8F1ikjKxa5VJoFofssI0HnzU+WHrgfcs
PO9mqyLDHjv569YoyX7NcEWdtXotVJT/GlYdkkI+SN70/7Va+4M=
=BSp7
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
