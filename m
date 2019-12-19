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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67789C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292EF24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjNM03Ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLSN05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:26:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33248 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:26:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so6013205wrq.0;
        Thu, 19 Dec 2019 05:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pgA2WnQuOOK5keoT2+uwrCJ8Ew20ApXTSGtm6g1GwaY=;
        b=IjNM03QlmHOruxygv44q848uKGGUHIksJLHtNl0a7NfqYYLWsDlKXBvHArD1aVlT7Y
         K9Y5KEHBEPdm+66HtSCz6vyoV9BGtCXU9svvc4w3/2OX8rpXF2/siJdmFHwgs7/LL8Og
         SHxLR01hl7tIwAl5fWJNGTTb3f525E6sAvt5VlYbc8GFvXhkcfW4FGl4iDKM6vEBwszp
         g6L4TS/wY2g5Z8K+SN5p4zbB3vm9mbcdzTEuaCm3lXnj5PXvVeIXC8pHJ1rTE9i8Fpr2
         VZB3P8CAnM+57Utv8D6tusymsBwBQYPC06DjyERa3M6xjxqX3CpQRR/dHfSWcgYHNHEE
         v0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pgA2WnQuOOK5keoT2+uwrCJ8Ew20ApXTSGtm6g1GwaY=;
        b=qKUZhLjav+mVZIUGlzacorVe+inQRpCnFLgfVBdZA94i789pnJR0jqzxAhFqnxqHc3
         dNsNXMq+l9ntiQG0MChFP33ZpqL7Y7w2+/obXnW1BbJ/xiSdy2een3PCxg+gBUg1s3f9
         Am7Tf8QYbL9luJT6ggwBwzSbqEDqFHF2h3Gvb9X0ulZ8QCxZIVLLGzpb6uQaj16yoc8L
         3rKhDExOJtJe4EiS5wz+XXAYhMQBzOj1OtprLZhJmEWs+Zx5HfK4A1mLuSL9Z7RF+yix
         aM6ZCG+ywmcDf9ikDGbEab0l8DvIgW4aA87eopCg8pbb8PQuRhjzTq+PhsG9DrZY1dHT
         9gmg==
X-Gm-Message-State: APjAAAV5MF4bcaZ/TNUQ9PypkJFYibsWJk4s6i8dBpgbRNr6x0Ysxo4J
        X1kuTHNbfwLaqriZoKpp83k=
X-Google-Smtp-Source: APXvYqyre8RZu1DEGNLYP7pKwoNqZLaZaKqayoh1JPAxp0cRQoIB+ygEMD2j7iLjvlFmca0MhKYoGQ==
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr9300231wrs.200.1576762013089;
        Thu, 19 Dec 2019 05:26:53 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id u16sm5973478wmj.41.2019.12.19.05.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 05:26:51 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:26:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 03/18] phy: tegra: xusb: Add usb-role-switch support
Message-ID: <20191219132650.GJ1440537@ulmo>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-4-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Content-Disposition: inline
In-Reply-To: <1576660591-10383-4-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 02:46:16PM +0530, Nagarjuna Kristam wrote:
> If usb-role-switch property is present in USB 2 port, register
> usb-role-switch to receive usb role changes.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Removed dev_set_drvdata for port->dev.
>  - Added of_platform_depopulate during error handling and driver removal.
> ---
>  drivers/phy/tegra/Kconfig |  1 +
>  drivers/phy/tegra/xusb.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/phy/tegra/xusb.h  |  3 +++
>  3 files changed, 46 insertions(+)
>=20
> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> index f9817c3..df07c4d 100644
> --- a/drivers/phy/tegra/Kconfig
> +++ b/drivers/phy/tegra/Kconfig
> @@ -2,6 +2,7 @@
>  config PHY_TEGRA_XUSB
>  	tristate "NVIDIA Tegra XUSB pad controller driver"
>  	depends on ARCH_TEGRA
> +	select USB_CONN_GPIO
>  	help
>  	  Choose this option if you have an NVIDIA Tegra SoC.
> =20
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index f98ec39..dc00b42 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -523,6 +523,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
t *port,
>  	port->dev.type =3D &tegra_xusb_port_type;
>  	port->dev.of_node =3D of_node_get(np);
>  	port->dev.parent =3D padctl->dev;
> +	port->dev.driver =3D padctl->dev->driver;
> =20
>  	err =3D dev_set_name(&port->dev, "%s-%u", name, index);
>  	if (err < 0)
> @@ -541,6 +542,10 @@ static int tegra_xusb_port_init(struct tegra_xusb_po=
rt *port,
> =20
>  static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
>  {
> +	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
> +		of_platform_depopulate(&port->dev);
> +		usb_role_switch_unregister(port->usb_role_sw);
> +	}
>  	device_unregister(&port->dev);

Nit: I prefer blank lines after blocks for readability.

>  }
> =20
> @@ -551,11 +556,42 @@ static const char *const modes[] =3D {
>  	[USB_DR_MODE_OTG] =3D "otg",
>  };
> =20
> +static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
> +{
> +	dev_dbg(dev, "%s calling notifier for role is %d\n", __func__, role);

I don't understand what "for role is %d" means here. I think perhaps you
meant to simply say "for role %d"? Also, perhaps add parentheses after
the "%s" to clarify that you're referring to a function.

> +
> +	return 0;
> +}
> +
> +static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
> +{
> +	int err =3D 0;
> +	struct usb_role_switch_desc role_sx_desc =3D {
> +					.set =3D tegra_xusb_role_sw_set,
> +					.fwnode =3D dev_fwnode(&port->dev),
> +						   };

The indentation here is odd. Use a single tab to indent lines after the
opening { and put the closing } on the same column as "struct". Also,
the above may become more readable if you follow the "inverse Christmas
tree" style of declaring functions, where you order lines by their
length, with the longest line first, like so:

	struct usb_role_switch_desc role_sx_desc =3D {
		.fwnode =3D dev_fwnode(&port->dev),
		.set =3D tegra_xusb_role_sw_set,
	};
	int err =3D 0;

> +
> +	port->usb_role_sw =3D usb_role_switch_register(&port->dev,
> +						&role_sx_desc);

&role_sx_desc should be aligned with &port->dev.

> +	if (IS_ERR(port->usb_role_sw)) {
> +		err =3D PTR_ERR(port->usb_role_sw);
> +		if (err !=3D EPROBE_DEFER)
> +			dev_err(&port->dev, "Failed to register USB role SW: %d",

Error messages typically start with a lowercase letter (at least in this
driver). Also perhaps spell out "switch" above because SW could easily
be confused with "software".

> +				err);

Shouldn't we abort here? Consider the case where this indeed defers
probe. If we don't abort here, the of_platform_populate() below will be
called multiple times. Shouldn't it only be called when we actually
succeed in registering the switch?

Also, looking at usb_role_switch_register(), I don't think it ever can
return -EPROBE_DEFER, so I think you can drop that check and print the
error unconditionally.

Thierry

> +	}
> +
> +	/* populate connector entry */
> +	of_platform_populate(port->dev.of_node, NULL, NULL, &port->dev);
> +
> +	return err;
> +}
> +
>  static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *us=
b2)
>  {
>  	struct tegra_xusb_port *port =3D &usb2->base;
>  	struct device_node *np =3D port->dev.of_node;
>  	const char *mode;
> +	int err;
> =20
>  	usb2->internal =3D of_property_read_bool(np, "nvidia,internal");
> =20
> @@ -572,6 +608,12 @@ static int tegra_xusb_usb2_port_parse_dt(struct tegr=
a_xusb_usb2_port *usb2)
>  		usb2->mode =3D USB_DR_MODE_HOST;
>  	}
> =20
> +	if (of_property_read_bool(np, "usb-role-switch")) {
> +		err =3D tegra_xusb_setup_usb_role_switch(port);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	usb2->supply =3D devm_regulator_get(&port->dev, "vbus");
>  	return PTR_ERR_OR_ZERO(usb2->supply);
>  }
> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
> index da94fcc..9f27899 100644
> --- a/drivers/phy/tegra/xusb.h
> +++ b/drivers/phy/tegra/xusb.h
> @@ -12,6 +12,7 @@
>  #include <linux/workqueue.h>
> =20
>  #include <linux/usb/otg.h>
> +#include <linux/usb/role.h>
> =20
>  /* legacy entry points for backwards-compatibility */
>  int tegra_xusb_padctl_legacy_probe(struct platform_device *pdev);
> @@ -266,6 +267,8 @@ struct tegra_xusb_port {
>  	struct list_head list;
>  	struct device dev;
> =20
> +	struct usb_role_switch *usb_role_sw;
> +
>  	const struct tegra_xusb_port_ops *ops;
>  };
> =20
> --=20
> 2.7.4
>=20

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37epgACgkQ3SOs138+
s6Hh5RAAh0cel4clHZg+GIdIG6ZyBOYP5icjLpq2J4MtTqiQYoh6mSG4V+bLrqvb
Vaal7meApdBQ0b31/Rv3bJRrFz0RQAy0cjiwkZWFKRASrM4s+aAgRBQoOXYPq0AM
bqsVMloKvS5zBEI/JAy6e7/I+d41cjF+RGWIt4i2A7ubTYMlSs8d4Xl+SC81K3pb
ufTs/0cI8e5rB75l6sgaEaareIX9tpXhbCzGpG1Etwp2ciXlUPE51+EQHxF//OXk
WK/i3rrf07n438IAat5Ktu9PUxJxpoKKQVqoHRehYK7ujqZDZ8SaR6pXL9W6xLSe
4TtrjD+snsZQ7KtgNbUxQ7s6iucg3woUpAglT6LIVyadcTLeLnXqInyaIbz6b+oS
rrT6vhfJ2xXL4N4UP46epowWgEpJZ42L27h6dSB/VzsNMqcZYtzJ2687rVMMy6Lu
VjsIpL0JTVRIOkUCYr01kB76jA1WKN+LwlpTX5zloIqTwCSw2TTj5bQw1odZuXxM
ByhBAD8xshUZ/KFQPKiJIsYs6FmYWN/UQeNKPmIKiyLYKauFu4Yi3NRxUkCR9ACj
lF6uv10ed/e2VDuHFhvOferCu+e1+tJVT5IJbQqy8Fg0YvoAfnoSzMOAKbrObq/5
sgJnTS/mip96YoA8mu91XXHW/H4cW8Dei0aQ6113q9ppPqDcoS8=
=od3S
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
