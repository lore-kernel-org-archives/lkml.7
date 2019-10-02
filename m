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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D583BC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0D121783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsIyLHWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfJBKKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:10:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33413 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfJBKKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:10:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so4562872wme.0;
        Wed, 02 Oct 2019 03:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7f4FFC207JROsiL0BefsQuifFD7iKPSKyUdbTlcKVhk=;
        b=EsIyLHWIlUvo5OPxpqtGqWZTIcmJXB7TzEFLgP5EiYtuwbmx9VtRE8qlbl4kF/pedb
         JAxiAHgEtG5QBuLK1xbbmZF5x/VOM488n3VSxQSKxUwNXIPeAt1TiruvjYAsfMk61kSF
         xqVKYnOVANiDHgYL46l1wpsaCfuWi89UkrVNybh961KLNoCLsxHjc+LtoSW8ZEKCfvin
         jriwcLLRc3BGcnIu7XhNfAelrnCUr7DwCJYQ8SuiwCLHxI4uXrQTIh2rYcm8PnYztyMq
         w5Bs9/Fh6OPlPflhX/o7iLXuRlgk8khBKAauYSRyjFtX82Zklj6l6YYBxOXgNFSHf0z3
         A3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7f4FFC207JROsiL0BefsQuifFD7iKPSKyUdbTlcKVhk=;
        b=d/kDOKhZIFYcFpyjztZiluJznFQ3S1iT1vuryF/R4eJfx1aWl2hDf/ZdHHvNoiX+mF
         J/vQwElo3DTUUPSYU2k383qQCEGT3gUs9PSpzonloxf28teqBvgKBMOMPLaLsYFAt1/P
         Rg16u4oi6YGww5apJKUXcelaSh9UvswE5CLq0FUK/5ihEoUhce0GoG8O+CIvkzwzKVfT
         J88TeWS4gZVx5/SzOLnXqcELY9on/lONtbhbx2c8aZmAhQa05fCyUkUE4nnP5s1FnMdC
         HiEJUQsPULLYT7JrHcutOSdU+2iEYhYB7syDkYXUWI/iSYNXvRu7L7vF5F25aJmq7dIz
         G8Ng==
X-Gm-Message-State: APjAAAXPuF2JsXZ5aLAT+4Sw5ux44BtnDQS24fW1JlBa3ir+d+ju94lR
        qZ8UB0tSoqhSrf/FMi+X4eo=
X-Google-Smtp-Source: APXvYqz4klkUD/cZvX4DLNIb/KY21ThRQndFnyoJX7sjX3A4XS5j+3NVIVzGcrUS6Yz3bBWBZ0uzwQ==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr2143472wmc.83.1570011004123;
        Wed, 02 Oct 2019 03:10:04 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id f8sm3954015wmb.37.2019.10.02.03.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 03:10:02 -0700 (PDT)
Date:   Wed, 2 Oct 2019 12:10:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com, skomatineni@nvidia.com
Subject: Re: [PATCH 5/6] arm64: tegra: Add XUSB and pad controller on Tegra194
Message-ID: <20191002101001.GF3716706@ulmo>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-6-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
Content-Disposition: inline
In-Reply-To: <20191002080051.11142-6-jckuo@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 04:00:50PM +0800, JC Kuo wrote:
> Adds the XUSB pad and XUSB controllers on Tegra194.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 130 +++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index 3c0cf54f0aab..4d3371d3a407 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1599,4 +1599,134 @@
>  		interrupt-parent =3D <&gic>;
>  		always-on;
>  	};
> +
> +	xusb_padctl: padctl@3520000 {
> +		compatible =3D "nvidia,tegra194-xusb-padctl";
> +		reg =3D <0x0 0x03520000 0x0 0x1000>,
> +			<0x0 0x03540000 0x0 0x1000>;

These should generally be aligned. Use tabs first and then spaces to
make the opening < on subsequent lines align with the opening < on the
first line. There are a couple more like this below.

> +		reg-names =3D "padctl", "ao";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_XUSB_PADCTL>;
> +		reset-names =3D "padctl";
> +
> +		status =3D "disabled";
> +
> +		pads {
> +			usb2 {
> +				clocks =3D <&bpmp TEGRA194_CLK_USB2_TRK>;
> +				clock-names =3D "trk";
> +
> +				lanes {
> +					usb2-0 {
> +						nvidia,function =3D "xusb";
> +						status =3D "disabled";
> +						#phy-cells =3D <0>;
> +					};
> +					usb2-1 {

I prefer blank lines to visually separate blocks here and below.

> +						nvidia,function =3D "xusb";
> +						status =3D "disabled";
> +						#phy-cells =3D <0>;
> +					};
> +					usb2-2 {
> +						nvidia,function =3D "xusb";
> +						status =3D "disabled";
> +						#phy-cells =3D <0>;
> +					};
> +					usb2-3 {
> +						nvidia,function =3D "xusb";
> +						status =3D "disabled";
> +						#phy-cells =3D <0>;
> +					};
> +				};
> +			};
> +			usb3 {
> +				lanes {
> +					usb3-0 {
> +						nvidia,function =3D "xusb";
> +						status =3D "disabled";
> +						#phy-cells =3D <0>;
> +					};
> +					usb3-1 {
> +						nvidia,function =3D "xusb";
> +						status =3D "disabled";
> +						#phy-cells =3D <0>;
> +					};
> +					usb3-2 {
> +						nvidia,function =3D "xusb";
> +						status =3D "disabled";
> +						#phy-cells =3D <0>;
> +					};
> +					usb3-3 {
> +						nvidia,function =3D "xusb";
> +						status =3D "disabled";
> +						#phy-cells =3D <0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		ports {
> +			usb2-0 {
> +				status =3D "disabled";
> +			};
> +			usb2-1 {
> +				status =3D "disabled";
> +			};
> +			usb2-2 {
> +				status =3D "disabled";
> +			};
> +			usb2-3 {
> +				status =3D "disabled";
> +			};
> +			usb3-0 {
> +				status =3D "disabled";
> +			};
> +			usb3-1 {
> +				status =3D "disabled";
> +			};
> +			usb3-2 {
> +				status =3D "disabled";
> +			};
> +			usb3-3 {
> +				status =3D "disabled";
> +			};
> +		};
> +	};
> +
> +	tegra_xhci: xhci@3610000 {

The tegra_xhci is unused, so I don't think we need to add it. Also, the
name of this node should be usb@3610000 since it's the compatible string
that defines (together with the bindings) that this is XHCI capable. But
it is fundamentally a USB controller, so the name should reflect that.

> +		compatible =3D "nvidia,tegra194-xusb";
> +		reg =3D <0x0 0x03610000 0x0 0x40000>,
> +			<0x0 0x03600000 0x0 0x10000>;
> +		reg-names =3D "hcd", "fpci";
> +
> +		interrupts =3D <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_XUSB_CORE_MUX>,
> +			<&bpmp TEGRA194_CLK_XUSB_CORE_HOST>,
> +			<&bpmp TEGRA194_CLK_XUSB_CORE_SS>,
> +			<&bpmp TEGRA194_CLK_XUSB_FALCON>,
> +			<&bpmp TEGRA194_CLK_XUSB_FALCON_HOST>,
> +			<&bpmp TEGRA194_CLK_XUSB_FALCON_SS>,
> +			<&bpmp TEGRA194_CLK_XUSB_FS>,
> +			<&bpmp TEGRA194_CLK_XUSB_FS_HOST>,
> +			<&bpmp TEGRA194_CLK_XUSB_SS>,
> +			<&bpmp TEGRA194_CLK_XUSB_SS_SUPERSPEED>,
> +			<&bpmp TEGRA194_CLK_UTMIPLL>,
> +			<&bpmp TEGRA194_CLK_CLK_M>,
> +			<&bpmp TEGRA194_CLK_PLLE>;
> +		clock-names =3D "xusb_hs_src", "xusb_host",
> +			"xusb_core_superspeed_clk", "xusb_falcon_src",
> +			"xusb_falcon_host_clk", "xusb_falcon_superspeed_clk",
> +			"xusb_fs_src", "xusb_fs_host_clk", "xusb_ss_src",
> +			"xusb_ss", "pll_u_480m", "clk_m", "pll_e";

Some of these clocks are not defined in the bindings. Many of them are
also not used by the driver. Are all of these really needed? If they
are, please add the required ones to the bindings.

Also, for new ones, drop the _clk suffix. The fact that these are clocks
is already conveyed by the property name.

Thierry

> +
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_XUSBC>,
> +				<&bpmp TEGRA194_POWER_DOMAIN_XUSBA>;
> +		power-domain-names =3D "xusb_host", "xusb_ss";
> +
> +		nvidia,xusb-padctl =3D <&xusb_padctl>;
> +		status =3D "disabled";
> +	};
>  };
> --=20
> 2.17.1
>=20

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2Ud3kACgkQ3SOs138+
s6HHxA//f2bNm7UQ7wJ81PQ6k1PUe7yCIbYVt0DW5uP1acBlo6n4rVB4qTER2wxc
BMWH4a029oQoMabQj6zUsYnTfEKTJUs1D06BakN7x1uP3+daQOg2SqyM1VshqsyF
lryvzMF3d0uHUTF2TTbsAWj2xV/0KGgRd1WfSgfcLW6beKL8WHa95R3fgRnscmZZ
gTnS4Bl6Uo3yrTc9u02RCiSKH8cDzaqtFYqlgrRRTj3mK301NipEvGKumz2OM4cg
zlWk9tAO2hqsAkz1rxAjGdpZ9IyWWwx95k5PnO2aCSdP4TyZ3fzAWlxH/smzd6/f
K/c0hT/+Slo4JW4klly41fKu/Fi6N0Gk2OKpnsCmc65bD3US2pHD/6ytjMY2LN0i
5upasZ6IyG3/9jBuH62i3sT+9anw9rGkIRGI0FZSWZynYEt+BLimW8pisf6iUAMm
1i7sUit/6nvouFR03k4Vvya8URbv2uyp8+rtHNJseeYBsuRvxdwNrK20TPHeeX+Y
xAE5pXavpFOqhlx+NuqU+wwjH3HoYuOuKZYDnMUtY2PjhBaOUs0tOBkDLsBzp8Nw
8QQy6oQ0RGKDCvjRYdJDEk7qgDa4oDE3/qtmjsamf1m37LmQnYS0YDzQbNtWZp0B
UNtr5wJ5Vo5cSNnOCgDNlh3kI+gdTxhI9ooWqPlgnXWdZw9/4lQ=
=a/8b
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--
