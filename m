Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D3C24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajdslYcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLSNBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:01:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46748 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSNBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:01:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so5856148wrl.13;
        Thu, 19 Dec 2019 05:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PC2LktCF+4MURDQfoOLicAW0U8n9WnU2jauC7WtaDHQ=;
        b=ajdslYcEb86qluBAStd+cWAR4fujIr7nEd/IxIAVxyoYS9U5a34CpNVabPAbG6FFiB
         Q7oA90K/BKeEiZh9xgXC8sGKCCmWDg8kCW6a/1Lk/HHPcVIko+ZU9ZvTqkgB3OVo5VOX
         Cxq36M2oBULynnkqq/BNO94TAuzKAmJ/jU7QXtoMHWusbf0crTlrhSgA8igV0eOLi/gu
         4xBzENRsIJ/2geY3x8y/SCnsIQIKnTgi798FKlR6w/QnM+2329oruD4mtVftBFTQStnG
         zICHTvk/SCPMv0vqKeUESWfA3evQLJ1DBs5SKnXTLpeaV19/WFlAOmoAbq6p+EKl9rIV
         Nskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PC2LktCF+4MURDQfoOLicAW0U8n9WnU2jauC7WtaDHQ=;
        b=pTM0qelU/9U3KY2ts06Zeu4dlwhnNE9YX1DvbAsLZ+MEfDbKKtfYV7/bz3PwhMho3w
         gAHO8zkYNVuYkP/v87MiAvr3iFx03sUYrhB4w88ZNnOVL8hXtsAczc7lrYn6FuukaaAp
         O/nDU73QMik1aj8fqUKAID/KGR1gvJc668UzkCpIz4c2GpiSr9SqO+isN0XF+bGF32FL
         ni2Jvz0dFd7hJ9e6/F1gIZ0aK2tAkS0N9qpWMBfS80bkGplQKp2y7CT0XR1MOco9l3gt
         KJxSYl8s3XchgncQVJ13NXD/IjVxCctQFwQ7FSEUoAzKVEhXk+4g6fc1D6BQbqYNrfP9
         9qvg==
X-Gm-Message-State: APjAAAUPiFTyr95OWrzmGSh43HrVtc5/34bbOiBGAqVxtIqCXSSdGpBG
        bObxOYp79QfGBTXSmkQK67K4/uNG
X-Google-Smtp-Source: APXvYqw/4IiOCRTgjwUqDh/FjCNlysA2NTs7kv6WctwZmrWWydyMn989ZaAQayaJos+3IVsjDgWEGQ==
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr9224106wrx.102.1576760489336;
        Thu, 19 Dec 2019 05:01:29 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id 25sm5806279wmi.32.2019.12.19.05.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 05:01:27 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:01:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] usb: phy: tegra: Hook up init/shutdown callbacks
Message-ID: <20191219130126.GE1440537@ulmo>
References: <20191218175313.16235-1-digetx@gmail.com>
 <20191218175313.16235-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <20191218175313.16235-3-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 08:53:11PM +0300, Dmitry Osipenko wrote:
> Generic PHY provides init/shutdown callbacks which allow USB-host drivers
> to abstract PHY's hardware management in a common way. This change allows
> to remove Tegra-specific PHY handling from the ChipIdea driver.
>=20
> Note that ChipIdea's driver shall be changed at the same time because it
> turns PHY ON without the PHY's initialization and this doesn't work now,
> resulting in a NULL dereference of phy->freq because it's set during of
> the PHY's initialization.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_tegra.c |   9 --
>  drivers/usb/phy/phy-tegra-usb.c      | 165 +++++++++++++++++----------
>  2 files changed, 102 insertions(+), 72 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/=
ci_hdrc_tegra.c
> index 0c9911d44ee5..7455df0ede49 100644
> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> @@ -83,13 +83,6 @@ static int tegra_udc_probe(struct platform_device *pde=
v)
>  		return err;
>  	}
> =20
> -	/*
> -	 * Tegra's USB PHY driver doesn't implement optional phy_init()
> -	 * hook, so we have to power on UDC controller before ChipIdea
> -	 * driver initialization kicks in.
> -	 */
> -	usb_phy_set_suspend(udc->phy, 0);
> -
>  	/* setup and register ChipIdea HDRC device */
>  	udc->data.name =3D "tegra-udc";
>  	udc->data.flags =3D soc->flags;
> @@ -109,7 +102,6 @@ static int tegra_udc_probe(struct platform_device *pd=
ev)
>  	return 0;
> =20
>  fail_power_off:
> -	usb_phy_set_suspend(udc->phy, 1);
>  	clk_disable_unprepare(udc->clk);
>  	return err;
>  }
> @@ -119,7 +111,6 @@ static int tegra_udc_remove(struct platform_device *p=
dev)
>  	struct tegra_udc *udc =3D platform_get_drvdata(pdev);
> =20
>  	ci_hdrc_remove_device(udc->dev);
> -	usb_phy_set_suspend(udc->phy, 1);
>  	clk_disable_unprepare(udc->clk);
> =20
>  	return 0;
> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-=
usb.c
> index ea7ef1dc0b42..15bd253d53c9 100644
> --- a/drivers/usb/phy/phy-tegra-usb.c
> +++ b/drivers/usb/phy/phy-tegra-usb.c
> @@ -238,23 +238,6 @@ static int utmip_pad_open(struct tegra_usb_phy *phy)
>  {
>  	int ret;
> =20
> -	phy->pad_clk =3D devm_clk_get(phy->u_phy.dev, "utmi-pads");
> -	if (IS_ERR(phy->pad_clk)) {
> -		ret =3D PTR_ERR(phy->pad_clk);
> -		dev_err(phy->u_phy.dev,
> -			"Failed to get UTMIP pad clock: %d\n", ret);
> -		return ret;
> -	}
> -
> -	phy->pad_rst =3D devm_reset_control_get_optional_shared(
> -						phy->u_phy.dev, "utmi-pads");
> -	if (IS_ERR(phy->pad_rst)) {
> -		ret =3D PTR_ERR(phy->pad_rst);
> -		dev_err(phy->u_phy.dev,
> -			"Failed to get UTMI-pads reset: %d\n", ret);
> -		return ret;
> -	}
> -
>  	ret =3D clk_prepare_enable(phy->pad_clk);
>  	if (ret) {
>  		dev_err(phy->u_phy.dev,
> @@ -315,6 +298,18 @@ static int utmip_pad_close(struct tegra_usb_phy *phy)
>  	return ret;
>  }
> =20
> +static void ulpi_close(struct tegra_usb_phy *phy)
> +{
> +	int err;
> +
> +	err =3D gpio_direction_output(phy->reset_gpio, 1);
> +	if (err < 0) {
> +		dev_err(phy->u_phy.dev,
> +			"ULPI reset GPIO %d direction not asserted: %d\n",
> +			phy->reset_gpio, err);
> +	}
> +}
> +
>  static void utmip_pad_power_on(struct tegra_usb_phy *phy)
>  {
>  	unsigned long val, flags;
> @@ -761,14 +756,19 @@ static int ulpi_phy_power_off(struct tegra_usb_phy =
*phy)
>  	return gpio_direction_output(phy->reset_gpio, 0);
>  }
> =20
> -static void tegra_usb_phy_close(struct tegra_usb_phy *phy)
> +static void tegra_usb_phy_close(struct usb_phy *u_phy)
>  {
> -	if (!IS_ERR(phy->vbus))
> -		regulator_disable(phy->vbus);
> +	struct tegra_usb_phy *phy =3D container_of(u_phy, struct tegra_usb_phy,
> +						 u_phy);
> =20
> -	if (!phy->is_ulpi_phy)
> +	if (phy->is_ulpi_phy)
> +		ulpi_close(phy);
> +	else
>  		utmip_pad_close(phy);
> =20
> +	if (!IS_ERR(phy->vbus))
> +		regulator_disable(phy->vbus);
> +
>  	clk_disable_unprepare(phy->pll_u);
>  }
> =20
> @@ -788,7 +788,7 @@ static int tegra_usb_phy_power_off(struct tegra_usb_p=
hy *phy)
>  		return utmi_phy_power_off(phy);
>  }
> =20
> -static int	tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
> +static int tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
>  {
>  	struct tegra_usb_phy *phy =3D container_of(x, struct tegra_usb_phy, u_p=
hy);
>  	if (suspend)
> @@ -801,54 +801,25 @@ static int ulpi_open(struct tegra_usb_phy *phy)
>  {
>  	int err;
> =20
> -	phy->clk =3D devm_clk_get(phy->u_phy.dev, "ulpi-link");
> -	if (IS_ERR(phy->clk)) {
> -		err =3D PTR_ERR(phy->clk);
> -		dev_err(phy->u_phy.dev, "Failed to get ULPI clock: %d\n", err);
> -		return err;
> -	}
> -
> -	err =3D devm_gpio_request(phy->u_phy.dev, phy->reset_gpio,
> -		"ulpi_phy_reset_b");
> -	if (err < 0) {
> -		dev_err(phy->u_phy.dev, "Request failed for GPIO %d: %d\n",
> -			phy->reset_gpio, err);
> -		return err;
> -	}
> -
>  	err =3D gpio_direction_output(phy->reset_gpio, 0);
>  	if (err < 0) {
>  		dev_err(phy->u_phy.dev,
> -			"GPIO %d direction not set to output: %d\n",
> +			"ULPI reset GPIO %d direction not deasserted: %d\n",
>  			phy->reset_gpio, err);
>  		return err;
>  	}
> =20
> -	phy->ulpi =3D otg_ulpi_create(&ulpi_viewport_access_ops, 0);
> -	if (!phy->ulpi) {
> -		dev_err(phy->u_phy.dev, "Failed to create ULPI OTG\n");
> -		err =3D -ENOMEM;
> -		return err;
> -	}
> -
> -	phy->ulpi->io_priv =3D phy->regs + ULPI_VIEWPORT;
>  	return 0;
>  }
> =20
> -static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
> +static int tegra_usb_phy_init(struct usb_phy *u_phy)
>  {
> +	struct tegra_usb_phy *phy =3D container_of(u_phy, struct tegra_usb_phy,
> +						 u_phy);
>  	unsigned long parent_rate;
>  	int i;
>  	int err;
> =20
> -	phy->pll_u =3D devm_clk_get(phy->u_phy.dev, "pll_u");
> -	if (IS_ERR(phy->pll_u)) {
> -		err =3D PTR_ERR(phy->pll_u);
> -		dev_err(phy->u_phy.dev,
> -			"Failed to get pll_u clock: %d\n", err);
> -		return err;
> -	}
> -
>  	err =3D clk_prepare_enable(phy->pll_u);
>  	if (err)
>  		return err;
> @@ -884,8 +855,17 @@ static int tegra_usb_phy_init(struct tegra_usb_phy *=
phy)
>  	if (err < 0)
>  		goto fail;
> =20
> +	err =3D tegra_usb_phy_power_on(phy);
> +	if (err)
> +		goto close_phy;
> +
>  	return 0;
> =20
> +close_phy:
> +	if (phy->is_ulpi_phy)
> +		ulpi_close(phy);
> +	else
> +		utmip_pad_close(phy);
>  fail:
>  	clk_disable_unprepare(phy->pll_u);
>  	return err;
> @@ -1134,22 +1114,77 @@ static int tegra_usb_phy_probe(struct platform_de=
vice *pdev)
>  		tegra_phy->vbus =3D ERR_PTR(-ENODEV);
>  	}
> =20
> -	tegra_phy->u_phy.dev =3D &pdev->dev;
> -	err =3D tegra_usb_phy_init(tegra_phy);
> -	if (err < 0)
> +	tegra_phy->pll_u =3D devm_clk_get(&pdev->dev, "pll_u");
> +	err =3D PTR_ERR_OR_ZERO(tegra_phy);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to get pll_u clock: %d\n", err);
>  		return err;
> +	}
> =20
> +	if (tegra_phy->is_ulpi_phy) {
> +		tegra_phy->clk =3D devm_clk_get(&pdev->dev, "ulpi-link");
> +		err =3D PTR_ERR_OR_ZERO(tegra_phy->clk);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to get ULPI clock: %d\n", err);
> +			return err;
> +		}
> +
> +		err =3D devm_gpio_request(&pdev->dev, tegra_phy->reset_gpio,
> +			"ulpi_phy_reset_b");
> +		if (err < 0) {
> +			dev_err(&pdev->dev, "Request failed for GPIO %d: %d\n",
> +				tegra_phy->reset_gpio, err);
> +			return err;
> +		}
> +
> +		tegra_phy->ulpi =3D otg_ulpi_create(&ulpi_viewport_access_ops, 0);
> +		if (!tegra_phy->ulpi) {
> +			dev_err(&pdev->dev, "Failed to create ULPI OTG\n");
> +			err =3D -ENOMEM;
> +			return err;
> +		}
> +
> +		tegra_phy->ulpi->io_priv =3D tegra_phy->regs + ULPI_VIEWPORT;
> +	} else {
> +		tegra_phy->pad_clk =3D devm_clk_get(&pdev->dev, "utmi-pads");
> +		err =3D PTR_ERR_OR_ZERO(tegra_phy->pad_clk);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to get UTMIP pad clock: %d\n", err);
> +			return err;
> +		}
> +
> +		tegra_phy->pad_rst =3D devm_reset_control_get_optional_shared(
> +						&pdev->dev, "utmi-pads");
> +		err =3D PTR_ERR_OR_ZERO(tegra_phy->pad_rst);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to get UTMI-pads reset: %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	tegra_phy->u_phy.dev =3D &pdev->dev;
> +	tegra_phy->u_phy.init =3D tegra_usb_phy_init;
> +	tegra_phy->u_phy.shutdown =3D tegra_usb_phy_close;
>  	tegra_phy->u_phy.set_suspend =3D tegra_usb_phy_suspend;
> =20
>  	platform_set_drvdata(pdev, tegra_phy);
> =20
>  	err =3D usb_add_phy_dev(&tegra_phy->u_phy);
> -	if (err < 0) {
> -		tegra_usb_phy_close(tegra_phy);
> -		return err;
> -	}
> +	if (err < 0)
> +		goto free_ulpi;
> =20
>  	return 0;
> +
> +free_ulpi:
> +	if (tegra_phy->ulpi) {
> +		kfree(tegra_phy->ulpi->otg);
> +		kfree(tegra_phy->ulpi);
> +	}
> +
> +	return err;
>  }
> =20
>  static int tegra_usb_phy_remove(struct platform_device *pdev)
> @@ -1157,7 +1192,11 @@ static int tegra_usb_phy_remove(struct platform_de=
vice *pdev)
>  	struct tegra_usb_phy *tegra_phy =3D platform_get_drvdata(pdev);
> =20
>  	usb_remove_phy(&tegra_phy->u_phy);
> -	tegra_usb_phy_close(tegra_phy);
> +
> +	if (tegra_phy->ulpi) {
> +		kfree(tegra_phy->ulpi->otg);
> +		kfree(tegra_phy->ulpi);
> +	}

It might be nicer to add a new otg_ulpi_free() (or whatever) function to
do this. Manually cleaning up the resources allocated by a public API is
a bit asymmetric and easy to get wrong.

But it's correct in this case and the new function can be added in a
separate patch, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37dKYACgkQ3SOs138+
s6FvoRAAtxEObLBPwqQJjQidM6mYcOuGzKKY47wU2MRp2d+XZBff8z0gUJ9jCmMJ
c1dQ45zCTdOw9G1v7VgyKgqwCgGGbWfM9ZIBpdmL+vL70p0kOtsMkmkAQ9ZK1+X5
vJMVSZnUcRLOzhGsNqNgj/BHmDpVqHsIlMg96aRE8FywFLdwDTuzvJXhSVr7IFMx
dKrYdSmK6OPqjXyyKpxNvO1FjrrBnBY9ZNpOpxEueHW0JLTOdTPwDrtM8tSeQK5x
4eKYc4i+e2YYbI+zdmIfuSb4rS7oHZghv7QSNu340XWVtS0YWupraaZrdTtIKe+E
SSGP+huFKM/T2ELxwzOEaM7jtGXj53Vf05phJN7XQL8GQBkvyHiamwOcRicFNMyx
L1iUxmLfHYHRqt1X3mLftplCxEbtmg6p+rwX2g/oTCwKitO7sHxcBtz34h39QJGM
EeU4XvoO57mq2Cr+PmhyTuox1gujhhmP4bZ+63uQrjtUkZ+DUMe6UPinFmaPdC72
l842c4+/kzi3vmLSp1nTtpcyMGxm5IUyquaFPzDeeGbUiHMqwd7XzsbWpwitmwl+
TAht0ZsINAzwo3wuECpvWN9L+JkfzeWPKXTI1+Iu6DBtq3O/Nncm14jAlVT8xyOU
/nGgLkzUyMZSJJbTMpKyEe++XB8It0UHVFtSpLugK6dbde+NEzI=
=f9Zt
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
