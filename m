Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773EDC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7C321D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dct+OpJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfJBKCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:02:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36481 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:02:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so6299542wmc.1;
        Wed, 02 Oct 2019 03:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k4jsz6ycvkRTp7a+e7CggaOBw//JfrDaC9jUAN8p7yM=;
        b=Dct+OpJPrE06SUP7ka/XjUTL2qQkB3xfJNKPbU3gmymnj15Yu/Xva/MvJpSkqQ28wH
         TxL1FpulWJjnE/vkjZ8io2VrRhMXOnuUNJybxxuKsOKQOVmsaL5ogAH3HqTIK05Yf09h
         CBFL3CAwGLY0yvMiG5PEqWH/5dM65PDZ5VgiP+k8bXLyLI6GpEY0/D6SVJNwMTaZfiXh
         KiQNxWmm5MUSS8HiAaVuLgN20tmQPm98QWUr1T80VvHQ7ljLoMl1LAIJ4CurF1otA1LB
         TnpemdAhemOrlpresUgKjq18XUpSmHtzLGgjvwyD1VrI8l/Y0Yp6ByxnAY9BymurohnZ
         rcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k4jsz6ycvkRTp7a+e7CggaOBw//JfrDaC9jUAN8p7yM=;
        b=YVXIUgHPPJiFBCyyGXRXoFaaV2HK02KX9SSvlsdQiTxSUE1YMm0xgTkXw/PdUyYG+5
         5VONoXe+9b4HAPXL9jb3/xrHowX+8YmUEwKeWdsm9GWRlUb3PWbWE49yNdF/LGT5rNWp
         Rr0E+4HCa+ETHcoJbZAXvKWgkMa73jhCwhboumQGSHLzuQTVuo2vnLZ5F7uBf1p1Te+v
         kG2REpWKj4GpZMQmTC+TI3lPOeiVKbW6+3gybcmkBvRUtF0FMBJ6L7tyky8//vVEezqo
         f4XE1M4EWI0ALn9p06Bz/YpV20OUDKKodCUuz8TleMNt8ErwluE2SJBgJkt8wXVq6s8s
         vSFg==
X-Gm-Message-State: APjAAAVmnrLLE5BSAEdbGDuidvvbjKzm7z2F1SzUtgJv3y7g33EDYSsx
        vQY5oE4Kq9JSzhE7NPTOzzBhVvIV
X-Google-Smtp-Source: APXvYqzLBjtfSnlTIrmUz+L6NJXFbA6bQaE52haqzjvU1JBoh39IXh/HLoiyUf2tZfVTfMuNnH3eZw==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr2079618wmc.132.1570010526594;
        Wed, 02 Oct 2019 03:02:06 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id m18sm22346063wrg.97.2019.10.02.03.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 03:02:05 -0700 (PDT)
Date:   Wed, 2 Oct 2019 12:02:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com, skomatineni@nvidia.com
Subject: Re: [PATCH 3/6] phy: tegra: xusb: Add Tegra194 support
Message-ID: <20191002100204.GE3716706@ulmo>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-4-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
In-Reply-To: <20191002080051.11142-4-jckuo@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 04:00:48PM +0800, JC Kuo wrote:
> Add support for the XUSB pad controller found on Tegra194 SoCs. It is
> mostly similar to the same IP found on Tegra186, but the number of
> pads exposed differs, as do the programming sequences. Because most of
> the Tegra194 XUSB PADCTL registers definition and programming sequence
> are the same as Tegra186, Tegra194 XUSB PADCTL can share the same
> driver, xusb-tegra186.c, with Tegra186 XUSB PADCTL.
>=20
> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it
> is possible for some platforms have long signal trace that could not
> provide sufficient electrical environment for Gen 2 speed. This patch
> introduce a new device node property "nvidia,disable-gen2" that can
> be used to specifically disable Gen 2 speed for a particular USB 3.0
> port so that the port can be limited to Gen 1 speed and avoid the
> instability.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  drivers/phy/tegra/Makefile        |  1 +
>  drivers/phy/tegra/xusb-tegra186.c | 77 +++++++++++++++++++++++++++++++
>  drivers/phy/tegra/xusb.c          | 13 ++++++
>  drivers/phy/tegra/xusb.h          |  4 ++
>  4 files changed, 95 insertions(+)
>=20
> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
> index 320dd389f34d..89b84067cb4c 100644
> --- a/drivers/phy/tegra/Makefile
> +++ b/drivers/phy/tegra/Makefile
> @@ -6,4 +6,5 @@ phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) +=3D xusb-teg=
ra124.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) +=3D xusb-tegra124.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) +=3D xusb-tegra210.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) +=3D xusb-tegra186.o
> +phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_194_SOC) +=3D xusb-tegra186.o
>  obj-$(CONFIG_PHY_TEGRA194_P2U) +=3D phy-tegra194-p2u.o
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-t=
egra186.c
> index 6f3afaf9398f..4e27acf398b2 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -64,6 +64,13 @@
>  #define  SSPX_ELPG_CLAMP_EN_EARLY(x)		BIT(1 + (x) * 3)
>  #define  SSPX_ELPG_VCORE_DOWN(x)		BIT(2 + (x) * 3)
> =20
> +#if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
> +#define XUSB_PADCTL_SS_PORT_CFG			0x2c
> +#define   PORTX_SPEED_SUPPORT_SHIFT(x)		((x) * 4)
> +#define   PORTX_SPEED_SUPPORT_MASK		(0x3)
> +#define     PORT_SPEED_SUPPORT_GEN1		(0x0)
> +#endif

I wouldn't bother protecting these with the #if/#endif.

> +
>  #define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x)	(0x88 + (x) * 0x40)
>  #define  HS_CURR_LEVEL(x)			((x) & 0x3f)
>  #define  TERM_SEL				BIT(25)
> @@ -635,6 +642,17 @@ static int tegra186_usb3_phy_power_on(struct phy *ph=
y)
> =20
>  	padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_CAP);
> =20
> +#if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
> +	if (padctl->soc =3D=3D &tegra194_xusb_padctl_soc && port->disable_gen2)=
 {
> +		value =3D padctl_readl(padctl, XUSB_PADCTL_SS_PORT_CFG);
> +		value &=3D ~(PORTX_SPEED_SUPPORT_MASK <<
> +			PORTX_SPEED_SUPPORT_SHIFT(index));
> +		value |=3D (PORT_SPEED_SUPPORT_GEN1 <<
> +			PORTX_SPEED_SUPPORT_SHIFT(index));
> +		padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_CFG);
> +	}
> +#endif

Same here. Also, I think you can drop the extra check for padctl->soc
and only rely on port->disable_gen2. This is not a lot of code, so might
as well make our life simpler by building it unconditionally.

On another note: checking the padctl->soc pointer against a SoC-specific
structure is a neat way to check for this support. However, it's not
very flexible. Consider what happens when the next chip is released. I
think we can assume that it will also support gen 2 and may also require
some boards to disable gen 2 because of long signal traces. In order to
accomodate that, you'd have to extend this check with another comparison
to that new SoC structure.

A better alternative would be to add this as a "feature" flag to the SoC
structure:

	struct tegra_xusb_pad_soc {
		...
		bool supports_gen2;
	};

Presumably every SoC that supports gen 2 will also need support for
explicitly disabling gen 2 if the board doesn't support it, so you can
use that new feature flag to conditionalize this code.

This way, the next SoC generation can support can simply be added by
setting supports_gen2 =3D true, without requiring any actual code changes
(unless of course if it supports new features).

Multi-SoC support is also a good argument for dropping the #if/#endif
protection, because those would need to be extended for the next SoC
generation as well.

> +
>  	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_1);
>  	value &=3D ~SSPX_ELPG_VCORE_DOWN(index);
>  	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_1);
> @@ -894,6 +912,65 @@ const struct tegra_xusb_padctl_soc tegra186_xusb_pad=
ctl_soc =3D {
>  };
>  EXPORT_SYMBOL_GPL(tegra186_xusb_padctl_soc);
> =20
> +#if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)

It doesn't look like we have this type of protection for Tegra186. It
might make sense to add a patch to this series (before this patch) to
slightly clean up the Tegra186 SoC data (reshuffle the data so that a
single #if/#endif block can be used, like you do for Tegra194).

But we can equally well do that in a follow-up.

> +static const char * const tegra194_xusb_padctl_supply_names[] =3D {
> +	"avdd-usb",
> +	"vclamp-usb",
> +};
> +
> +static const struct tegra_xusb_lane_soc tegra194_usb2_lanes[] =3D {
> +	TEGRA186_LANE("usb2-0", 0,  0, 0, usb2),
> +	TEGRA186_LANE("usb2-1", 0,  0, 0, usb2),
> +	TEGRA186_LANE("usb2-2", 0,  0, 0, usb2),
> +	TEGRA186_LANE("usb2-3", 0,  0, 0, usb2),
> +};
> +
> +static const struct tegra_xusb_pad_soc tegra194_usb2_pad =3D {
> +	.name =3D "usb2",
> +	.num_lanes =3D ARRAY_SIZE(tegra194_usb2_lanes),
> +	.lanes =3D tegra194_usb2_lanes,
> +	.ops =3D &tegra186_usb2_pad_ops,
> +};
> +
> +static const struct tegra_xusb_lane_soc tegra194_usb3_lanes[] =3D {
> +	TEGRA186_LANE("usb3-0", 0,  0, 0, usb3),
> +	TEGRA186_LANE("usb3-1", 0,  0, 0, usb3),
> +	TEGRA186_LANE("usb3-2", 0,  0, 0, usb3),
> +	TEGRA186_LANE("usb3-3", 0,  0, 0, usb3),
> +};
> +
> +static const struct tegra_xusb_pad_soc tegra194_usb3_pad =3D {
> +	.name =3D "usb3",
> +	.num_lanes =3D ARRAY_SIZE(tegra194_usb3_lanes),
> +	.lanes =3D tegra194_usb3_lanes,
> +	.ops =3D &tegra186_usb3_pad_ops,
> +};
> +
> +static const struct tegra_xusb_pad_soc * const tegra194_pads[] =3D {
> +	&tegra194_usb2_pad,
> +	&tegra194_usb3_pad,
> +};
> +
> +const struct tegra_xusb_padctl_soc tegra194_xusb_padctl_soc =3D {
> +	.num_pads =3D ARRAY_SIZE(tegra194_pads),
> +	.pads =3D tegra194_pads,
> +	.ports =3D {
> +		.usb2 =3D {
> +			.ops =3D &tegra186_usb2_port_ops,
> +			.count =3D 4,
> +		},
> +		.usb3 =3D {
> +			.ops =3D &tegra186_usb3_port_ops,
> +			.count =3D 4,
> +		},
> +	},
> +	.ops =3D &tegra186_xusb_padctl_ops,
> +	.supply_names =3D tegra194_xusb_padctl_supply_names,
> +	.num_supplies =3D ARRAY_SIZE(tegra194_xusb_padctl_supply_names),
> +};
> +EXPORT_SYMBOL_GPL(tegra194_xusb_padctl_soc);
> +#endif
> +
>  MODULE_AUTHOR("JC Kuo <jckuo@nvidia.com>");
>  MODULE_DESCRIPTION("NVIDIA Tegra186 XUSB Pad Controller driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 2ea8497af82a..266c08074b28 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -65,6 +65,12 @@ static const struct of_device_id tegra_xusb_padctl_of_=
match[] =3D {
>  		.compatible =3D "nvidia,tegra186-xusb-padctl",
>  		.data =3D &tegra186_xusb_padctl_soc,
>  	},
> +#endif
> +#if defined(CONFIG_ARCH_TEGRA_194_SOC)
> +	{
> +		.compatible =3D "nvidia,tegra194-xusb-padctl",
> +		.data =3D &tegra194_xusb_padctl_soc,
> +	},
>  #endif
>  	{ }
>  };
> @@ -739,6 +745,13 @@ static int tegra_xusb_usb3_port_parse_dt(struct tegr=
a_xusb_usb3_port *usb3)
> =20
>  	usb3->internal =3D of_property_read_bool(np, "nvidia,internal");
> =20
> +#if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
> +	if (port->padctl->soc =3D=3D &tegra194_xusb_padctl_soc) {
> +		usb3->disable_gen2 =3D of_property_read_bool(np,
> +							"nvidia,disable-gen2");
> +	}
> +#endif

Do we really need the #if/#endif here? Or the conditional for that
matter? nvidia,disable-gen2 is only defined for Tegra194, so any earlier
SoCs are not going to have one, in which case the above code would just
set usb3->disable_gen2 to false (the default).

Removing the conditional allows you to have the above on a single line.

Thierry

> +
>  	usb3->supply =3D devm_regulator_get(&port->dev, "vbus");
>  	return PTR_ERR_OR_ZERO(usb3->supply);
>  }
> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
> index 093076ca27fd..6b71978ba15d 100644
> --- a/drivers/phy/tegra/xusb.h
> +++ b/drivers/phy/tegra/xusb.h
> @@ -332,6 +332,7 @@ struct tegra_xusb_usb3_port {
>  	bool context_saved;
>  	unsigned int port;
>  	bool internal;
> +	bool disable_gen2;
> =20
>  	u32 tap1;
>  	u32 amp;
> @@ -444,5 +445,8 @@ extern const struct tegra_xusb_padctl_soc tegra210_xu=
sb_padctl_soc;
>  #if defined(CONFIG_ARCH_TEGRA_186_SOC)
>  extern const struct tegra_xusb_padctl_soc tegra186_xusb_padctl_soc;
>  #endif
> +#if defined(CONFIG_ARCH_TEGRA_194_SOC)
> +extern const struct tegra_xusb_padctl_soc tegra194_xusb_padctl_soc;
> +#endif
> =20
>  #endif /* __PHY_TEGRA_XUSB_H */
> --=20
> 2.17.1
>=20

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2UdZkACgkQ3SOs138+
s6Ha9Q//cUjWQHDifmKCSCWSdKp06ir/Z+7StjEDABtTLlHp3kJHmUzzIOONlnyD
YfEpjJnUaIjxG2HXrHzgsPgGM1PnRY8GO+4h2RDTJ78YCilGh4Ho+BzyTCyYyBsK
rnW/Jxg7wOet4wV0XE4oMuV6Q8p4ksytr7Ifbb/BZTO4LTEZrzyew6CxjjMJB+bK
Z/A1w6xq2tm8oGfFV0J1V/bbCq0zzEuFiR8DjsCtp6bYDzzgOQIhAAAybWjpu9zB
E0Rck0s01+2zMUtnP0D0mwz/yG4dssOIGifN7gHmVmGnKm8U2qbZKnfEDDDqFelf
mgV48+Qzsju4uiHPnRd2TedpKfqxpTIc6iJAcl03fINVFCbW86wLbKW1qD0essOP
75X0zg+qmxp0Ey29fd5PVULWnWifFSlXgYt+wxNquls4TxYuyKR7HuaF5605dg2p
DCdh/ygi3zFcZmjpNuejpKySuPVlSbeoU+AQl8hZ8C4Tv2brWH14/PHOs5TCJgB6
6Dw1FCkKDE9I1IczGVeCDJSJ9xvldWsI1SNHL893rfuBGGjm/4bNUgErkylstPXx
qHX3g2A+Y1pFxLSAMgW0DOvqu6MiXUuQuE34qJmcGgAZr/VCxseb/25Y2CyPvzs3
xkoZ6T222AzsLlYPcbQ6RtRKABgmaAbZd/tp6V2X0hanPk6DJKc=
=Ib/W
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
