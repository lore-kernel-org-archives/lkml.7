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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC47C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01FD206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIiuTjAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfCLLVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:21:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38648 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfCLLVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:21:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so2254146wrm.5;
        Tue, 12 Mar 2019 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=48Ux1j0TGqV7k4ceMsTo3hrQBQvNsM5C5lwrjuhnW6Y=;
        b=qIiuTjASVle/ZW2Vnsx62L478XTAzkurVd37q91yzaT7kiHH2BwFBMN6YIbE4CUA42
         HLDZM8Z8e/w0tWr4gO5vuEm7ibuO7/3yvUzdN6n+nTCftI3mp/FucCT46tB/fqUrnDnX
         Nv1g4iOMbMPS00iniA3JKYHw7E/Xdl6ZSZ5Qj5sD+el/9Zucdn2SGk8m5XgBw0sxXVdv
         UrM78Uv1KvrN0PR0E4RE9P3o6Oz7GnrNrcJP9x3/MsofdYCkUa4F09CJ786TzsH5EvY/
         r2VaEnYBR39mhVIrpm1OkGXw1suTr6rxp7pn02S485dzA+yzAdgd2cl2RdPAD8XE1Gcn
         YDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=48Ux1j0TGqV7k4ceMsTo3hrQBQvNsM5C5lwrjuhnW6Y=;
        b=nKWlNT6jFIcc6aeeyipVRlxqvGbpQHhoFTSlXN38zFFit8E7vZZulZsW0LiJJZ8Zjx
         iZo8oMKGl+wUlXI2RUvEkZc2tg83p+DaQ6NMfraHL1h+C2RRUxYC5sq94Dn3x9TVt7t5
         2U7+/ZQl6V/emVpBJ8bDxapoc665x0KeR/GNfgxyLFb+kmaOhQIjsMR4r0LZsfuFOMIz
         1rtN4dKy5ydrF3jkwXwIjW2MvktHez3qB+oi03sOupabNbEzxY+cVnWyZOPQLSihGl1t
         vnN/rFoRf9iOkNdf+y++ubDcURN+CgD1v4jfB5TH5rSNNG3a/B0N5CMLh47qWCUWY6wz
         SfHw==
X-Gm-Message-State: APjAAAWX6sKXTLTNxB2RuXRcY00R+8u3rjMJHQGI0cRkp1dED41z+ub9
        mZipLpRKBv+h8fID3XTBP1E=
X-Google-Smtp-Source: APXvYqxtCZbKBdL3+CyB48GSbZ302ztMC2/dZeZKNtk0Y9I4n1TZzfh7tC93zKpoAmMTZRF8bYI1Jg==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr22854580wru.135.1552389667377;
        Tue, 12 Mar 2019 04:21:07 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id z9sm9919170wrv.59.2019.03.12.04.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:21:06 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:21:04 +0100
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
Subject: Re: [PATCH 03/42] drivers: gpio: amdpt: drop unneeded deref of
 &pdev->dev
Message-ID: <20190312112104.GA31026@ulmo>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-3-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <1552330521-4276-3-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 07:54:42PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> We already have the struct device* pointer in a local variable,
> so we can write this a bit shorter.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-amdpt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
> index 1ffd7c2..3220f3c 100644
> --- a/drivers/gpio/gpio-amdpt.c
> +++ b/drivers/gpio/gpio-amdpt.c
> @@ -91,7 +91,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
> =20
>  	pt_gpio->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pt_gpio->reg_base)) {
> -		dev_err(&pdev->dev, "Failed to map MMIO resource for PT GPIO.\n");
> +		dev_err(dev, "Failed to map MMIO resource for PT GPIO.\n");
>  		return PTR_ERR(pt_gpio->reg_base);
>  	}
> =20
> @@ -101,7 +101,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
>  			 pt_gpio->reg_base + PT_DIRECTION_REG, NULL,
>  			 BGPIOF_READ_OUTPUT_REG_SET);
>  	if (ret) {
> -		dev_err(&pdev->dev, "bgpio_init failed\n");
> +		dev_err(dev, "bgpio_init failed\n");
>  		return ret;
>  	}
> =20
> @@ -110,11 +110,11 @@ static int pt_gpio_probe(struct platform_device *pd=
ev)
>  	pt_gpio->gc.free             =3D pt_gpio_free;
>  	pt_gpio->gc.ngpio            =3D PT_TOTAL_GPIO;
>  #if defined(CONFIG_OF_GPIO)
> -	pt_gpio->gc.of_node          =3D pdev->dev.of_node;
> +	pt_gpio->gc.of_node          =3D dev.of_node;

"dev->of_node"?

Thierry

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHlhwACgkQ3SOs138+
s6GD7g//RLd4WtA1eIT8moMwWLKywkUMl3Nz89m1EIFFGKv2Q76AjTLCMykRiwTR
Pu6OtKodY+L2FpLDweXXz/HYtUbtiZn2/44t5vVAFadlJiMAiL0fFO8VYDW4DNE9
cmcWzeTdbJNg/DJXRbUVE932XhvEdUzWXw1ymBlD97FQYpvRy81FjjHgQ7tCYYQn
q+7u2dS+Q/9g5pFvz0oiG3TZyX6yWoXwIdSRTrU4O1QTpNgSt70xvKGg/NcCxYfe
TByHergN63iBB+0caCXkpbmc7X26QKfvZn1L7OfrCPUQEZg5pOXJ69JGM3ELz6Rx
3xP/C+Lzhe0eS6E7sjbb7FA0XhBs9zlnMBLv8wz6miYJrj9YuEJEUJHoPDjlUTmk
gTnbhp79Ic8fbsNAIfnByHnZ6d1g/0Xis/LOyQ6WppARhrNXZxPt2XZZyiHel2t3
ozG03l1U4omMaj+W08euRQ9oX5UJAfR6Knd5ZD/TYcBQFDgyyIMjjsPzwhIC7cVL
REYCYrcYLQgOG/O0oUqmEQtJZXsF3OtLXDADYxoCGAD+6ri3O9NOxOlO+rwUDjEj
QmLu34BajBjOV6wx/5HSXOTbntd8Ej+stMUp/xVMeV7xRwTb0hKMUFUwNNL8Aw27
/dD0jGMO0vAcc0kUgTGgHkyJy3OetueR5RjzRMzdqegxq/D213M=
=6/o3
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
