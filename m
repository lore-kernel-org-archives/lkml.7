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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB60C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A991020679
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEUoIHfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfJBK0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:26:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40022 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfJBK0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:26:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so6351031wmj.5;
        Wed, 02 Oct 2019 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+yqoCtW0UPaqaX3/rZx6Ae5AjyB6I8FJkEqrzGonID0=;
        b=PEUoIHfYYaVEqR6aUcRu9wvnGbBnQ2k+mwf7toJDXbxNB4MtrKsu8l0ClJ9/XFW6HF
         Gm8EvEK+MPts0kz8AfJ1/Q4JKfZpCwvLNVNBqDvm7NI4tLSCJSnoamLZKBgxKaBGwpou
         n9YLGyz7dqJP8uC/noWflRi0rV8Ccz8rdBjKtnEEMF5qskmw9a+P7Q+iI39Z9rdwI8hP
         ua4g20mqElUZYM7TD5FLJX6tzNZHSf17RrgQXfckAg150uwg/eFxmmiShH0GQVbOilkS
         9kSBXkbYKgBQH5/r19UO2lU2JFMx7C9uEZu1lw7/jsMs7NeDdmNqj7cnARZUF3l8rMd9
         NKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+yqoCtW0UPaqaX3/rZx6Ae5AjyB6I8FJkEqrzGonID0=;
        b=sNlIYL71gAAjRX1ldLdsNZEgvfIXPBcovUlWC+0RFf5hUMoZcLHkiff8kv9etip7O8
         I2Wq5hiWZ5PBUqBKTmBxcfdMuhBJuKRkDhFmWvteJ01ZhH++dUEywuboRH45CPIrbvIF
         3UhNQm6Hf35y+9UG4SUCaxoweS0YW2V3mRaAr3rKk5d4upiZwoO8mqb+08A1QpjUec4j
         s1HKpOklQB596dUBfXychuCn+nyFbH/ieLHbwWFkV8gu5viyVQEieHMzVydgD9c1gnu0
         2it0UxNDQFl+HbzyacjhEy4vvX8MpRJLEa1r2/cSq/QJ0JCQX4Ac6zN+wT0bB/vJ38c9
         wC0A==
X-Gm-Message-State: APjAAAUWWf5s30uvY9RXltPDKeNQJJPDnmnksunlVaIHvFORmG2cudo8
        TMJjncQ/q+5REOgKMIG4Los=
X-Google-Smtp-Source: APXvYqwhIBnV2XBvixxSGufzFfS0B8R2OPg8cH10qFHGUC+ZEISsgBaSGgKl1pw/1o+L8uSbIl4EiA==
X-Received: by 2002:a05:600c:2115:: with SMTP id u21mr2215937wml.168.1570011973714;
        Wed, 02 Oct 2019 03:26:13 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id r65sm4911532wmr.9.2019.10.02.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 03:26:12 -0700 (PDT)
Date:   Wed, 2 Oct 2019 12:26:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com, skomatineni@nvidia.com
Subject: Re: [PATCH 6/6] arm64: tegra: Enable XUSB host in P2972-0000 board
Message-ID: <20191002102611.GH3716706@ulmo>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-7-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYYhpFXgKVw71fwr"
Content-Disposition: inline
In-Reply-To: <20191002080051.11142-7-jckuo@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYYhpFXgKVw71fwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 04:00:51PM +0800, JC Kuo wrote:
> This commit enables XUSB host and pad controller in Tegra194
> P2972-0000 board.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 31 +++++++++-
>  .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 59 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/=
boot/dts/nvidia/tegra194-p2888.dtsi
> index 4c38426a6969..cb236edc6a0d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> @@ -229,7 +229,7 @@
>  						regulator-max-microvolt =3D <3300000>;
>  					};
> =20
> -					ldo5 {
> +					vdd_usb_3v3: ldo5 {
>  						regulator-name =3D "VDD_USB_3V3";
>  						regulator-min-microvolt =3D <3300000>;
>  						regulator-max-microvolt =3D <3300000>;
> @@ -313,5 +313,34 @@
>  			regulator-boot-on;
>  			enable-active-low;
>  		};
> +
> +		vdd_5v_sata: regulator@4 {
> +			compatible =3D "regulator-fixed";
> +			reg =3D <4>;
> +
> +			regulator-name =3D "vdd-5v-sata";

Please keep capitalization of regulator names consistent. We use
all-caps and underscores for the others (which mirrors the names in the
schematics), so please stick with that for this one as well.

Also, I'm wondering if perhaps you can clarify something here. My
understanding is that SATA functionality is provided via a controller on
the PCI bus. Why is it that we route the 5 V SATA power to the USB port?
Oh wait... this is one of those eSATAp (hybrid) ports that can take
either eSATA or USB, right? Do we need any additional setup to switch
between eSATA and USB modes? Or is this all done in hardware? That is,
if I plug in an eSATA, does it automatically hotplug detect the device
as SATA and if I plug in a USB device, does it automatically detect it
as USB?

> +			regulator-min-microvolt =3D <5000000>;
> +			regulator-max-microvolt =3D <5000000>;
> +			gpio =3D <&gpio TEGRA194_MAIN_GPIO(Z, 1) GPIO_ACTIVE_LOW>;

This will actually cause a warning on boot. For fixed regulators the
polarity of the enable GPIO is not specified in the GPIO specifier.
Instead you're supposed to use the boolean enable-active-high property
to specify if the enable GPIO is active-high. By default the enable GPIO
is considered to be active-low. The GPIO specifier needs to have the
GPIO_ACTIVE_HIGH flag set regardless for backwards-compatibilitiy
reasons.

Note that regulator@3 above your new entry does this wrongly, but
next-20191002 should have a fix for that.

> +		};
> +	};
> +
> +	padctl@3520000 {

Don't forget to move this into /cbb as well to match the changes to
patch 5/6.

> +		avdd-usb-supply =3D <&vdd_usb_3v3>;
> +		vclamp-usb-supply =3D <&vdd_1v8ao>;
> +		ports {

Blank line between the above two for better readability.

> +			usb2-1 {
> +				vbus-supply =3D <&vdd_5v0_sys>;
> +			};
> +			usb2-3 {

Same here and below.

> +				vbus-supply =3D <&vdd_5v_sata>;
> +			};
> +			usb3-0 {
> +				vbus-supply =3D <&vdd_5v0_sys>;
> +			};
> +			usb3-3 {
> +				vbus-supply =3D <&vdd_5v0_sys>;
> +			};
> +		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/ar=
m64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index d47cd8c4dd24..410221927dfa 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -222,4 +222,63 @@
>  			};
>  		};
>  	};
> +
> +	padctl@3520000 {

Same comment as above. Move this into /cbb.

> +		status =3D "okay";
> +
> +		pads {
> +			usb2 {
> +				lanes {
> +					usb2-1 {
> +						status =3D "okay";
> +					};
> +					usb2-2 {

And blank lines for readability here and below.

> +						status =3D "okay";
> +					};
> +					usb2-3 {
> +						status =3D "okay";
> +					};
> +				};
> +			};
> +			usb3 {
> +				lanes {
> +					usb3-0 {
> +						status =3D "okay";
> +					};
> +					usb3-3 {
> +						status =3D "okay";
> +					};
> +				};
> +			};
> +		};
> +
> +		ports {
> +			usb2-1 {
> +				mode =3D "host";
> +				status =3D "okay";
> +			};
> +			usb2-3 {
> +				mode =3D "host";
> +				status =3D "okay";
> +			};
> +			usb3-0 {
> +				nvidia,usb2-companion =3D <1>;
> +				status =3D "okay";
> +			};
> +			usb3-3 {
> +				nvidia,usb2-companion =3D <3>;
> +				nvidia,disable-gen2;
> +				status =3D "okay";
> +			};
> +		};
> +	};
> +
> +	tegra_xhci: xhci@3610000 {

Also needs to move into /cbb. Also, you can drop the tegra_xhci label
here since we never reference the controller from elsewhere.

Also make sure to update the name here to match the changes in 5/6.

Thierry

> +		status =3D "okay";
> +		phys =3D	<&{/padctl@3520000/pads/usb2/lanes/usb2-1}>,
> +			<&{/padctl@3520000/pads/usb2/lanes/usb2-3}>,
> +			<&{/padctl@3520000/pads/usb3/lanes/usb3-0}>,
> +			<&{/padctl@3520000/pads/usb3/lanes/usb3-3}>;
> +		phy-names =3D "usb2-1", "usb2-3", "usb3-0", "usb3-3";
> +	};
>  };
> --=20
> 2.17.1
>=20

--mYYhpFXgKVw71fwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2Ue0AACgkQ3SOs138+
s6GAgw//bgErm+FyPqbnCyw/CJbKUYXSkpwC/rGhxRnk037h2UYIJSIXtCRFllmx
SDCCTvU0l9ii/dSkaVfo/eOpp/B1RTI0E9mdtJkzaFdmedkogE9m+JrlDGBMeXMe
WwEksdW08PDcYOjecHBlcpB7+WA4a097WN1zWezOAGrdvNaaKGTSg3A/QSnFDOc9
Wge4KazOfhy6csT+Sjf++A/0uqWrOVhoIZjbdsDjD/zdua6CT96W06YmkK/qZLRU
bWn42dGoJLtRCtRFEzHerUq1P5d9k/C29iWduJ/DyM2SeQP6VvwgYO+DY7pOp+Ng
sWHN3yyIzR9G0rUpdH+R6KwpFbwqbfNpD4h5U/Z1P/bt8T9TVBdVxrYQnzCRm4ry
Mg1FUW13zbmvH5rUgewEdvhGAvRO90SvIQx1Z/RHO3wTbWhkT1jQawiqlYl57fBc
bixdkc7Uft4GvSZPc/0mT0IfWWpssVQMZ9J7DHFJpM/wxs8pV84sPJZbg3CSo6C9
PqW917GsFFOCfNjHq1GukmS0C3OKOM4lgwhHCdZ4QaRTK/zzkZohS/iSigSUaxQM
7TC7isxVGkApoeQ8TjugbhW+xeLTVv0PA/ebtnAoBfOQA3vfsB+GIxKEJp69HrbF
+Q3D36qqMfE8I1YW0+mCAvH6uEqqYBWDyrEiTvoG0GpZEeQVNrQ=
=0eUt
-----END PGP SIGNATURE-----

--mYYhpFXgKVw71fwr--
