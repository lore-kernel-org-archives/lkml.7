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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B659C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6267224672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoN7GjgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLSNhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:37:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34436 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:37:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so6032813wrr.1;
        Thu, 19 Dec 2019 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wRKK6aQkbHwNeV0I7+gSsT5iT4e+yP8blqqWWTkBp2g=;
        b=MoN7GjgFCdL+dP8M0bsD3fajXxpfFXDK33xLbeuEGVm08o8kfJFbP0fGl+TPDdoKtr
         LGSiFwurRI9QlkWBxeH0VlnVsaVJJVUCUCs02cg4MgEX8V8zP3loe70LfD/zizOT/AT9
         ybvBBB+cKA1V6nIRDbvtFL4WutAbX/YVHXPEGojFnD8rbEPFM9SgTi6LJ8/Ht6cbQ+qM
         YPouv8cVRQS9KTQhT5YGeODpmy0LF2X7k/kRbNg+F/0bCXHoDQ6IwFckFumFXLpNBgr7
         fRVm+ILgLCrmJ7mFsdyVKQy6Ed4I4fUFZa7Q295fkPXxGWpRVWCSYCPvfsnn1bIFM4ez
         THYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wRKK6aQkbHwNeV0I7+gSsT5iT4e+yP8blqqWWTkBp2g=;
        b=JzZCJck6aKcP4eHbwgPKLw/n0Cqndk3CnZw0CK5DvozlDooBpcgRyufmppwVmFMO+k
         Q3hec638YjJh4u+j6wNJ0rdLDPKql5vkWHQE0JEfIcqZ/WIHlbWqT6NLExDAto85vw2g
         7JY5rEtDnrqeOzx+hVPmblYbzlJpW7O4lqi+DBVQNNeyjxHSEu3j/YMC5go4oWsEiBCR
         rRqYyWKyY0KumCOi7yzUWS57NIiEqlZzjR5T3eu9cCTA4SrbuAr1d9WDRTxErqnSCV9A
         SeUFLU+XPGtowNOBERyKkx8cLV8D+SuU3TAFSXPrtsBKRnhiygRJbV7Oyui/ba7FdvyR
         Drvw==
X-Gm-Message-State: APjAAAX8OVIrGVlCr5vU/ds1MSZ2AFGVxzby3S4OEmc+woAyFHnjaCQc
        pPMsixPy5ZA186g8e+q2uik=
X-Google-Smtp-Source: APXvYqyN0n3ZFoEkN2kG+/+A+dVPTGD/dpwktPLP+Xk4xdo3TzWSGsT9SGlZazuYNwvmtVIgxU+goA==
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr10047467wrx.141.1576762629821;
        Thu, 19 Dec 2019 05:37:09 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id y139sm6649642wmd.24.2019.12.19.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 05:37:08 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:37:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 04/18] phy: tegra: xusb: Add usb-phy support
Message-ID: <20191219133707.GK1440537@ulmo>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-5-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Content-Disposition: inline
In-Reply-To: <1576660591-10383-5-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 02:46:17PM +0530, Nagarjuna Kristam wrote:
> For USB 2 ports that has usb-role-switch enabled, add usb-phy for
> corresponding USB 2 phy. USB role changes from role switch are then
> updated to corresponding host and device mode drivers via usb-phy notifier
> block.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Added dev_set_drvdata for port->dev.
> ---
>  drivers/phy/tegra/xusb.c | 71 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/phy/tegra/xusb.h |  2 ++
>  2 files changed, 73 insertions(+)
>=20
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index dc00b42..5bde8f1 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -533,6 +533,8 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
t *port,
>  	if (err < 0)
>  		goto unregister;
> =20
> +	dev_set_drvdata(&port->dev, port);
> +
>  	return 0;
> =20
>  unregister:
> @@ -545,6 +547,8 @@ static void tegra_xusb_port_unregister(struct tegra_x=
usb_port *port)
>  	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
>  		of_platform_depopulate(&port->dev);
>  		usb_role_switch_unregister(port->usb_role_sw);
> +		cancel_work_sync(&port->usb_phy_work);
> +		usb_remove_phy(&port->usb_phy);
>  	}
>  	device_unregister(&port->dev);
>  }
> @@ -556,16 +560,59 @@ static const char *const modes[] =3D {
>  	[USB_DR_MODE_OTG] =3D "otg",
>  };
> =20
> +static void tegra_xusb_usb_phy_work(struct work_struct *work)
> +{
> +	struct tegra_xusb_port *port =3D container_of(work,
> +				struct tegra_xusb_port, usb_phy_work);

Perhaps add a static inline function to cast this? Might not be worth it
since we only need to cast once. In that case, perhaps make this look a
little prettier by aligning arguments on subsequent lines with "work" on
the first line?

> +	enum usb_role role =3D usb_role_switch_get_role(port->usb_role_sw);
> +
> +	dev_dbg(&port->dev, "%s calling notifier for role %d\n", __func__,
> +		role);
> +
> +	atomic_notifier_call_chain(&port->usb_phy.notifier, role,
> +				   &port->usb_phy);

I'm curious: you use an atomic notifier call chain here but then you
schedule work to call it. Typically you only need to schedule work if
you get notified in atomic context and you need to process the event
outside of the atomic context.

Since these are atomic notifiers, do we really need the work? Or the
other way around: why not use regular notifiers if we're processing them
=66rom non-atomic contexts only anyway?

> +}
> +
>  static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
>  {
> +	struct tegra_xusb_port *port =3D dev_get_drvdata(dev);
> +
>  	dev_dbg(dev, "%s calling notifier for role is %d\n", __func__, role);
> =20
> +	schedule_work(&port->usb_phy_work);
> +
> +	return 0;
> +}
> +
> +static int tegra_xusb_set_peripheral(struct usb_otg *otg,
> +					struct usb_gadget *gadget)
> +{
> +	struct tegra_xusb_port *port =3D container_of(otg->usb_phy,
> +					struct tegra_xusb_port, usb_phy);
> +
> +	if (gadget !=3D NULL)
> +		schedule_work(&port->usb_phy_work);
> +
> +	return 0;
> +}
> +
> +static int tegra_xusb_set_host(struct usb_otg *otg, struct usb_bus *host)
> +{
> +	struct tegra_xusb_port *port =3D container_of(otg->usb_phy,
> +					struct tegra_xusb_port, usb_phy);
> +
> +	if (host !=3D NULL)
> +		schedule_work(&port->usb_phy_work);
> +
>  	return 0;
>  }
> =20
> +
>  static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>  {
>  	int err =3D 0;
> +	struct tegra_xusb_lane *lane =3D tegra_xusb_find_lane(port->padctl,
> +							"usb2", port->index);

You're not properly aligning the arguments here.

Thierry

>  	struct usb_role_switch_desc role_sx_desc =3D {
>  					.set =3D tegra_xusb_role_sw_set,
>  					.fwnode =3D dev_fwnode(&port->dev),
> @@ -578,6 +625,30 @@ static int tegra_xusb_setup_usb_role_switch(struct t=
egra_xusb_port *port)
>  		if (err !=3D EPROBE_DEFER)
>  			dev_err(&port->dev, "Failed to register USB role SW: %d",
>  				err);
> +		return err;
> +	}
> +
> +	INIT_WORK(&port->usb_phy_work, tegra_xusb_usb_phy_work);
> +
> +	port->usb_phy.otg =3D devm_kzalloc(&port->dev,
> +					 sizeof(struct usb_otg), GFP_KERNEL);
> +	if (!port->usb_phy.otg)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Assign phy dev to usb-phy dev. Host/device drivers can use phy
> +	 * reference to retrieve usb-phy details.
> +	 */
> +	port->usb_phy.dev =3D &lane->pad->lanes[port->index]->dev;
> +	port->usb_phy.dev->driver =3D port->padctl->dev->driver;
> +	port->usb_phy.otg->usb_phy =3D &port->usb_phy;
> +	port->usb_phy.otg->set_peripheral =3D tegra_xusb_set_peripheral;
> +	port->usb_phy.otg->set_host =3D tegra_xusb_set_host;
> +
> +	err =3D usb_add_phy_dev(&port->usb_phy);
> +	if (err < 0) {
> +		dev_err(&port->dev, "Failed to add usbphy: %d\n", err);
> +		return err;
>  	}
> =20
>  	/* populate connector entry */
> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
> index 9f27899..2345657 100644
> --- a/drivers/phy/tegra/xusb.h
> +++ b/drivers/phy/tegra/xusb.h
> @@ -268,6 +268,8 @@ struct tegra_xusb_port {
>  	struct device dev;
> =20
>  	struct usb_role_switch *usb_role_sw;
> +	struct work_struct usb_phy_work;
> +	struct usb_phy usb_phy;
> =20
>  	const struct tegra_xusb_port_ops *ops;
>  };
> --=20
> 2.7.4
>=20

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37fQEACgkQ3SOs138+
s6Fv7hAAvExHkWdrmkYkFGItZhn0RkHOADu6gyYBaXUdmmoZpdiDhyHdYqA1NXKg
8w5wnvxpOB7t5Mam78jpQmKG8CbT2BtrxGY2K21b2B4RSD7ocAMtlGopRXZlEfcF
8f5N4/uwQdUOEqy93guL7N32cfErmidGhs6ZizTZxPCNhr+xZ/3Xpby+yZobYwLG
NcmtSEgYSvMxaTHC9q9BfY7Zp00psaUe9L1cHzbaBDwv/MZ2EGfhcky8jtqldvcv
pxNtuw5wXMGa1PW5RapONA3YavQxvyW5/xDip2kpCQjhLaeZEjNui6poSxtjacAe
LLutnzm5/ptcKpvzg19Suoco6Akysvf1JybJUrT//mBmiR/bHhmq/1jgXQiG5mkh
j/RvkrXquTYR+SRbzfdV1smG5NQukv7Bzd5ZclIXjAbbuEDuUQ2wPjsuq2OwaP+p
KgufXZjj4juLh4AGi+4LpVGkkq7tNJBcOjXYnQq84mu2j0QtZUo1A0AK+Lo/OgKf
KOFwbA2mFta/OB4G6gmOIeL9lDaRLw/pJYFociyubgGNyON+qm0xFIOUrJ7EyTcJ
VvhdzRmW8r4Ec1qSl3HnUQaI83TRTUg3mZmcP2rzQ+mgJVirQAMLsuYwYcWOOlMr
0ZdpG+39vuH5TttVG9XycrS9/RHGR1V36DaInWOkULE3yZhkLjE=
=U3pb
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--
