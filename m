Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FE4C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E2E2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5WizO0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFOyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:54:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39752 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:54:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so8065261wrt.6;
        Fri, 06 Dec 2019 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7azf65fJZQpsNwRde6shfCCLXfP6jWsDNlQBGqL907Y=;
        b=C5WizO0UPxLG+5aIhH5boK7sw94FEXr7esKEzhc8vaNBdneY6Ecb6EnGinjwo88Hzk
         GMOoOg8Tp68oAP068+yGA3JDph8D65voG+w1NxZeEmyhQWVm3McveslUoDEhMUNDqrOK
         7RKuMWAWZbWT2Oyx8Hc2ZexkyHSnxaLJOrDNQ4sFI8FP91rUmY7u1gEj6kU7PzWP19ve
         qNO7JmLP5iJKT7e6HcgaqiDWVVN0Kes8d91+UlXgmgKd/6xVwI18BdPFxfeGghsM2u2s
         uIpqhuBJTwtQpXJf96eo14NdyvN808Gf1g4tJvWY1dA0AlcmnyjAXrkOxHPWXpNkcL4l
         Oz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7azf65fJZQpsNwRde6shfCCLXfP6jWsDNlQBGqL907Y=;
        b=sMxAsw4xJzYLuEHXspQ55w1TCK8scXCxNHIV8RCrFecZC/SBVLAdF4OFbfCvU+5IDl
         gV4JhZgoKTTgkEHtvrBajCGGJZQpNe0s2K1ucF8KHr4xgUanYxt0YTs8doJFVwCtqz+w
         4O+EtJUWdM9yhYNFV68L2B+oftjmUo6PUmmLs1X7fDwPTpCz00OV6CFVQuySD+KGN28V
         B28reY5qQM57f3TnnhIQaGel+5RWTwYgHzHB16X71qH3qPBmaPwEyv5IZGLi79M+G5eo
         SuIz+EXOBynVXqQ+PD0tA6an4nAufUsHxYF4g2wJ5qIYddIY5ex454OVmO/vJ4A3Qu5L
         V81w==
X-Gm-Message-State: APjAAAVvue/LL+2tF3BaKY5z/L4Np5LA0MDl8JLJfNS9Ipd84sV18DxZ
        d32eBj7Bshqf3+nuA6N9Hew=
X-Google-Smtp-Source: APXvYqyJ8LEv74plxu/XSCxkGYT/lNOEagCnZ4hqONO61i3UJduQaOOhm34PyRDlXzpeFD63Ze4JJg==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr16441463wrs.184.1575644088215;
        Fri, 06 Dec 2019 06:54:48 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id g74sm3482606wme.5.2019.12.06.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:54:46 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:54:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] phy: tegra: xusb: Add usb-role-switch support
Message-ID: <20191206145445.GD2085684@ulmo>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
 <1575629421-7039-4-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <1575629421-7039-4-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 04:20:06PM +0530, Nagarjuna Kristam wrote:
> If usb-role-switch property is present in USB 2 port, register
> usb-role-switch to receive usb role changes.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
>  drivers/phy/tegra/Kconfig |  1 +
>  drivers/phy/tegra/xusb.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/phy/tegra/xusb.h  |  3 +++
>  3 files changed, 44 insertions(+)
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
> index f98ec39..da60a63 100644
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
> @@ -532,6 +533,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
t *port,
>  	if (err < 0)
>  		goto unregister;
> =20
> +	dev_set_drvdata(&port->dev, port);

You never seem to use dev_get_drvdata() to get at this. Also, you can
get at it via container_of(), so this is only marginally useful to begin
with.

>  	return 0;
> =20
>  unregister:
> @@ -541,6 +543,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
t *port,
> =20
>  static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
>  {
> +	usb_role_switch_unregister(port->usb_role_sw);
>  	device_unregister(&port->dev);
>  }
> =20
> @@ -551,11 +554,39 @@ static const char *const modes[] =3D {
>  	[USB_DR_MODE_OTG] =3D "otg",
>  };
> =20
> +static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
> +{
> +	dev_dbg(dev, "%s calling notifier for role is %d\n", __func__, role);
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
> +
> +	port->usb_role_sw =3D usb_role_switch_register(&port->dev,
> +						&role_sx_desc);
> +	if (IS_ERR(port->usb_role_sw)) {
> +		err =3D PTR_ERR(port->usb_role_sw);
> +		if (err !=3D EPROBE_DEFER)
> +			dev_err(&port->dev, "Failed to register USB role SW: %d",
> +				err);
> +	}
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
> @@ -572,6 +603,15 @@ static int tegra_xusb_usb2_port_parse_dt(struct tegr=
a_xusb_usb2_port *usb2)
>  		usb2->mode =3D USB_DR_MODE_HOST;
>  	}
> =20
> +	if (of_property_read_bool(np, "usb-role-switch")) {
> +		/* populate connector entry */
> +		of_platform_populate(np, NULL, NULL, &port->dev);

I think we want to clean this up on failure, don't we? Otherwise we
might end up trying to register the same platform device multiple times.
Also, do we want to depopulate when the port is removed again?

Have you tried unloading and loading the driver to see if that works?

Thierry

> +
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

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3qa7UACgkQ3SOs138+
s6HVBg//RiQ8UZnpuBFOWZBD8QQTTsLsYbNlE0WN3pEp92yW4O6YCyXX81eDPhMc
xboH8ABiiPX0rNfQJLnzYa7icZnVcLUhJr3Z6+oH27/BQt0kVaBLB9W0/jvfIy63
r93Z2ygshzLA6fAOJKaUiOA8QcCciBVGUIHXw9JPgid78xKwXY+dWMy+8SJlXt2G
jtkDKBo5+paZy8zhvH5k/nu+g/MkSnVWYs2sgIqIam1SQyk8espbj54Fj6yCXmQy
rZ5xUUdOraCgTWr2tk8V9C9KQIpJ4OlbzW7ubHkG7LNJSaBxTaCCKl6US/Gcx8nk
tAJbENGR+ataYGDQctncKsZDFRX6CE2jFVA7PscSNtoX+Bv7u6E4H9yLlI6wNDVu
IGMiNQcbCegl7YsPeK8F8GAwcoFyKYOCez4VdMGtVxeILnbDD6/j1qPXjpwidFvr
Hg2nv86ru6K07a3PdWjvDHeepphmHIgL1Vj1zjWmZ865rjPZae1kVGuhpVd73/hj
v5UMYexAv+4JcRv7eogy+V464bMUZ9dFiWnxIB+FC6Cgict424S1FbIHys/zt6Ge
KZozQCQ/oG6GmJp+n6vCu6WLGynF58GIJWDukvJCMg4iVX+ZVDrjfDojO+6aD9iK
I8fPO9vbKL5dXNW9YLmcJQNr8W4ANI8Zr0dZ2YTnOACe/pU4LoY=
=SkSc
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
