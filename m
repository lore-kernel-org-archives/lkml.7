Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BA9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7997021841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjhhrBfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfEVMh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:37:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35603 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfEVMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:37:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so2055301wmj.0;
        Wed, 22 May 2019 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHyvbn1T+JkFTAAJRmt0GeRYU1rR5IWCWPPRTRGI4Sk=;
        b=KjhhrBfZ5gVHVrn7AmQiNgALfU6F4KUtgFdGoeTCcQzaxFC2vWQvRUG8nMFTfrn9WR
         KrpPXGD4hDpIiyf+oZd8PRimV1NyaFg6f9xXTsZk2KHRm/EC+PrfebFpocrqnMH1s9nN
         BJOhqXCJ2WoUv1oXhTHFEsgeRhduP0JJ5uZzbd2tYI13+qOeqGfiI6PLrJ9QSibl5H2e
         OIgGWq/wp8VE4HwNmm3ZwzLeFv6e0FM0AtJHSNYqyoDw50yuM6jxjIn4I71BW+plXhji
         87ibMQQvM17MRCH8R9XAnSyMwkQD/OjR7bWcgXFtOBQLEJZq+N6JrcYG3/0CxwXn4/18
         sHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHyvbn1T+JkFTAAJRmt0GeRYU1rR5IWCWPPRTRGI4Sk=;
        b=lqZt8cl7hi+0mOS3nrItOPtmlZ3Ti693ySnWHQYQ2W/PrgYgRJN2yzPHBzjXNMba5j
         f0UAR6/DsKnRHd9C8+u11SVV4Wl+Uc7u4ZG6dP5BBG1unC8da0GpkGaUrBGdGi0rwDKf
         se1R9Z2rsU2gW9q5FzjfjIC+ruio/kg7ClbFo75z8uLCAOMvN53rRjtI0QYmeEhA8JvF
         DHFoAYeiHzim3RGfu8Uk+AuJ+3DBZguZNK9Ks5XeTwaD0czl6pL4dym/2NypPiSrwtQs
         5dBdpTSSNDkZmL2ojn8vj/swFGWlEwNctTckE6jcCnRp+I3v3wEiQqnMvxJKdVavMflk
         tpEA==
X-Gm-Message-State: APjAAAWKX1B3h78AITdBCFo98mq2un59ixh1ebXmDTW5TQdTnsX58sjB
        5/YrB7527tTjHUoZwRInTGs=
X-Google-Smtp-Source: APXvYqyDujf21fh/Kr9QJ9pgdH+Rp11h/1DveZu8x6yRR5VQ3xjZLfK+i+V7VT1PZ3ecnndFii2l9A==
X-Received: by 2002:a1c:e718:: with SMTP id e24mr7446881wmh.27.1558528641629;
        Wed, 22 May 2019 05:37:21 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id 20sm7552934wmj.36.2019.05.22.05.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 05:37:20 -0700 (PDT)
Date:   Wed, 22 May 2019 14:37:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, jckuo@nvidia.com, talho@nvidia.com,
        josephl@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 02/12] pinctrl: tegra: add suspend and resume support
Message-ID: <20190522123719.GH30938@ulmo>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
 <1558481483-22254-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Content-Disposition: inline
In-Reply-To: <1558481483-22254-3-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 04:31:13PM -0700, Sowjanya Komatineni wrote:
> This patch adds suspend and resume support for Tegra pinctrl driver
> and registers them to syscore so the pinmux settings are restored
> before the devices resume.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c    | 68 ++++++++++++++++++++++++++=
+++++-
>  drivers/pinctrl/tegra/pinctrl-tegra.h    |  3 ++
>  drivers/pinctrl/tegra/pinctrl-tegra114.c |  1 +
>  drivers/pinctrl/tegra/pinctrl-tegra124.c |  1 +
>  drivers/pinctrl/tegra/pinctrl-tegra20.c  |  1 +
>  drivers/pinctrl/tegra/pinctrl-tegra210.c |  1 +
>  drivers/pinctrl/tegra/pinctrl-tegra30.c  |  1 +
>  7 files changed, 75 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegr=
a/pinctrl-tegra.c
> index a5008c066bac..585debbc4291 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -28,11 +28,18 @@
>  #include <linux/pinctrl/pinmux.h>
>  #include <linux/pinctrl/pinconf.h>
>  #include <linux/slab.h>
> +#include <linux/syscore_ops.h>

I'd like to avoid moving this to syscore_ops if possible. The reason is
that there are other mechanisms that allow proper sequencing of suspend
and resume. syscore_ops might give you the correct sequence with respect
to device drivers, but there's no way to control the sequence with
respect to other syscore_ops. It also sets a bad precedent because this
requires a global variable and is therefore no longer properly
encapsulated (i.e. you can't have more than one instance, otherwise you
would end up overwriting the global variable).

> =20
>  #include "../core.h"
>  #include "../pinctrl-utils.h"
>  #include "pinctrl-tegra.h"
> =20
> +#define EMMC2_PAD_CFGPADCTRL_0			0x1c8
> +#define EMMC4_PAD_CFGPADCTRL_0			0x1e0
> +#define EMMC_DPD_PARKING			(0x1FFF << 14)

Use lower-case hexadecimal digits consistently.

> +
> +static struct tegra_pmx *pmx;
> +
>  static inline u32 pmx_readl(struct tegra_pmx *pmx, u32 bank, u32 reg)
>  {
>  	return readl(pmx->regs[bank] + reg);
> @@ -629,6 +636,50 @@ static void tegra_pinctrl_clear_parked_bits(struct t=
egra_pmx *pmx)
>  	}
>  }
> =20
> +static int __maybe_unused tegra_pinctrl_suspend(void)
> +{
> +	u32 *pg_data =3D pmx->pg_data;

This is a very generic name. Perhaps use something more contextual like
pmx->suspend_backup, pmx->saved_regs or something along those lines.

> +	u32 *regs;
> +	int i, j;
> +
> +	for (i =3D 0; i < pmx->nbanks; i++) {
> +		regs =3D pmx->regs[i];
> +		for (j =3D 0; j < pmx->reg_bank_size[i] / 4; j++)
> +			*pg_data++ =3D readl(regs++);

Perhaps avoid the regs temporary variable and just do regs[i][j]?

> +	}
> +
> +	return pinctrl_force_sleep(pmx->pctl);
> +}
> +
> +static void __maybe_unused tegra_pinctrl_resume(void)
> +{
> +	u32 *pg_data =3D pmx->pg_data;
> +	u32 *regs;
> +	u32 val;
> +	int i, j;
> +
> +	for (i =3D 0; i < pmx->nbanks; i++) {
> +		regs =3D pmx->regs[i];
> +		for (j =3D 0; j < pmx->reg_bank_size[i] / 4; j++)
> +			writel(*pg_data++, regs++);
> +	}
> +
> +	if (pmx->soc->has_park_padcfg) {
> +		val =3D pmx_readl(pmx, 0, EMMC2_PAD_CFGPADCTRL_0);
> +		val &=3D ~EMMC_DPD_PARKING;
> +		pmx_writel(pmx, val, 0, EMMC2_PAD_CFGPADCTRL_0);
> +
> +		val =3D pmx_readl(pmx, 0, EMMC4_PAD_CFGPADCTRL_0);
> +		val &=3D ~EMMC_DPD_PARKING;
> +		pmx_writel(pmx, val, 0, EMMC4_PAD_CFGPADCTRL_0);
> +	}
> +}
> +
> +static struct syscore_ops pinctrl_syscore_ops =3D {
> +	.suspend =3D tegra_pinctrl_suspend,
> +	.resume =3D tegra_pinctrl_resume,
> +};
> +
>  static bool gpio_node_has_range(const char *compatible)
>  {
>  	struct device_node *np;
> @@ -648,11 +699,11 @@ static bool gpio_node_has_range(const char *compati=
ble)
>  int tegra_pinctrl_probe(struct platform_device *pdev,
>  			const struct tegra_pinctrl_soc_data *soc_data)
>  {
> -	struct tegra_pmx *pmx;
>  	struct resource *res;
>  	int i;
>  	const char **group_pins;
>  	int fn, gn, gfn;
> +	int pg_data_size =3D 0;
> =20
>  	pmx =3D devm_kzalloc(&pdev->dev, sizeof(*pmx), GFP_KERNEL);
>  	if (!pmx)
> @@ -705,6 +756,7 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
>  		res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
>  		if (!res)
>  			break;
> +		pg_data_size +=3D resource_size(res);
>  	}
>  	pmx->nbanks =3D i;
> =20
> @@ -712,12 +764,25 @@ int tegra_pinctrl_probe(struct platform_device *pde=
v,
>  				 GFP_KERNEL);
>  	if (!pmx->regs)
>  		return -ENOMEM;
> +#ifdef CONFIG_PM_SLEEP

Do we really need the #ifdef here? I don't think it buys us much and
PM_SLEEP is likely always going to be enabled.

> +	pmx->reg_bank_size =3D devm_kcalloc(&pdev->dev, pmx->nbanks,
> +					  sizeof(*pmx->reg_bank_size),
> +					  GFP_KERNEL);
> +	if (!pmx->reg_bank_size)
> +		return -ENOMEM;
> =20
> +	pmx->pg_data =3D devm_kzalloc(&pdev->dev, pg_data_size, GFP_KERNEL);
> +	if (!pmx->pg_data)
> +		return -ENOMEM;
> +#endif
>  	for (i =3D 0; i < pmx->nbanks; i++) {
>  		res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
>  		pmx->regs[i] =3D devm_ioremap_resource(&pdev->dev, res);
>  		if (IS_ERR(pmx->regs[i]))
>  			return PTR_ERR(pmx->regs[i]);
> +#ifdef CONFIG_PM_SLEEP
> +		pmx->reg_bank_size[i] =3D resource_size(res);
> +#endif
>  	}
> =20
>  	pmx->pctl =3D devm_pinctrl_register(&pdev->dev, &tegra_pinctrl_desc, pm=
x);
> @@ -732,6 +797,7 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
>  		pinctrl_add_gpio_range(pmx->pctl, &tegra_pinctrl_gpio_range);
> =20
>  	platform_set_drvdata(pdev, pmx);
> +	register_syscore_ops(&pinctrl_syscore_ops);
> =20
>  	dev_dbg(&pdev->dev, "Probed Tegra pinctrl driver\n");
> =20
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.h b/drivers/pinctrl/tegr=
a/pinctrl-tegra.h
> index 44c71941b5f8..8c7cd94124ea 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.h
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.h
> @@ -25,6 +25,8 @@ struct tegra_pmx {
> =20
>  	int nbanks;
>  	void __iomem **regs;
> +	int *reg_bank_size;

size_t

However, I wonder if there's not a better way to do this. You already do
pinctrl_force_sleep(). I wonder if it'd make sense to add functionality
to the pinctrl framework to restore the current state.

Adding Linus Walleij. Linus, do you know if there's some way of tracking
the current state for all of the pins? I can't seem to find anything
like that anywhere, but it seems to me like a bit of a waste for every
driver to have to allocate extra system memory to store register values
that could equally well just be reconstructed from state kept in the
pinctrl framework.

Any ideas if this is possible, or whether that'd be worth doing?

Thierry

> +	u32 *pg_data;
>  };
> =20
>  enum tegra_pinconf_param {
> @@ -199,6 +201,7 @@ struct tegra_pinctrl_soc_data {
>  	bool hsm_in_mux;
>  	bool schmitt_in_mux;
>  	bool drvtype_in_mux;
> +	bool has_park_padcfg;
>  };
> =20
>  int tegra_pinctrl_probe(struct platform_device *pdev,
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra114.c b/drivers/pinctrl/t=
egra/pinctrl-tegra114.c
> index d43c209e9c30..4ac44f34dccf 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra114.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra114.c
> @@ -1849,6 +1849,7 @@ static const struct tegra_pinctrl_soc_data tegra114=
_pinctrl =3D {
>  	.hsm_in_mux =3D false,
>  	.schmitt_in_mux =3D false,
>  	.drvtype_in_mux =3D false,
> +	.has_park_padcfg =3D false,
>  };
> =20
>  static int tegra114_pinctrl_probe(struct platform_device *pdev)
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra124.c b/drivers/pinctrl/t=
egra/pinctrl-tegra124.c
> index 5b07a5834d15..1dac7648b41f 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra124.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra124.c
> @@ -2061,6 +2061,7 @@ static const struct tegra_pinctrl_soc_data tegra124=
_pinctrl =3D {
>  	.hsm_in_mux =3D false,
>  	.schmitt_in_mux =3D false,
>  	.drvtype_in_mux =3D false,
> +	.has_park_padcfg =3D false,
>  };
> =20
>  static int tegra124_pinctrl_probe(struct platform_device *pdev)
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/te=
gra/pinctrl-tegra20.c
> index 1fc82a9576e0..9d2b25200f32 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
> @@ -2231,6 +2231,7 @@ static const struct tegra_pinctrl_soc_data tegra20_=
pinctrl =3D {
>  	.hsm_in_mux =3D false,
>  	.schmitt_in_mux =3D false,
>  	.drvtype_in_mux =3D false,
> +	.has_park_padcfg =3D false,
>  };
> =20
>  static const char *cdev1_parents[] =3D {
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra210.c b/drivers/pinctrl/t=
egra/pinctrl-tegra210.c
> index 3e77f5474dd8..dc06c36e698a 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra210.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra210.c
> @@ -1563,6 +1563,7 @@ static const struct tegra_pinctrl_soc_data tegra210=
_pinctrl =3D {
>  	.hsm_in_mux =3D true,
>  	.schmitt_in_mux =3D true,
>  	.drvtype_in_mux =3D true,
> +	.has_park_padcfg =3D true,
>  };
> =20
>  static int tegra210_pinctrl_probe(struct platform_device *pdev)
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra30.c b/drivers/pinctrl/te=
gra/pinctrl-tegra30.c
> index 10e617003e9c..42182d714950 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra30.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra30.c
> @@ -2484,6 +2484,7 @@ static const struct tegra_pinctrl_soc_data tegra30_=
pinctrl =3D {
>  	.hsm_in_mux =3D false,
>  	.schmitt_in_mux =3D false,
>  	.drvtype_in_mux =3D false,
> +	.has_park_padcfg =3D false,
>  };
> =20
>  static int tegra30_pinctrl_probe(struct platform_device *pdev)
> --=20
> 2.7.4
>=20

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlQn0ACgkQ3SOs138+
s6EhNA/8C+LkVpKOWBjote9hTTbyzCY0IU6wIe21lgfVnkLyGHhda28REkrZM+ku
AHlWnR7iAf7bZLudOMH87x7qZDmRIorQJTKgxT1qVfWK81vLG9ggV8lC7MZd3jJv
0cLkjP1/r2ALQwzIZhmHrIJrO98ZjTnlP5aNUude5j9WK0Ptw4D8+aqp7vhUxUiD
n9x8vVmpeq2Te4A06sTU9lHZmAjkNMbJE3brqRFP4cy3wzA5ehEczbLBcDCVbmtj
7frKuEExDAeV+lBbkmT0ksLJHUl3XuDTJkKQ12jADcJKR1zMnoJFSFfRbpY2b9vh
4+fiObChfYKA2rawijY7uyB7N2fKqCKwytrJb2XODV0g/9OXMTrne6atR0+0XeBZ
6u9fEpfzUSMGcw8s8VA0PlGMI4615KPmyXHppqEYFDSpiFa9GbZsJ2CpskWCJfLh
j1ezD5D+XPmtZJ4RnoP3o/48TU9WgkW2T6vysyXDXLUv5waXI1P0UjB00v+sc5+l
ZQ/WeiiWon5EfCsewHDrt7htaKBIsPGbhhzO4DN1l4zD0gMqrFLfoJradF8K0hsK
PL9X4Ukx07a2U8kez9Zckvzi3gu9FFYXqtN1wjwvtZ1uhiV6g+6/9L8fsf4EuFN/
yy6DRyNvV0A8xG00tSQYn5vbEeZv4QLfhuqUuWjPkI0JlRKsB5A=
=XFJG
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--
