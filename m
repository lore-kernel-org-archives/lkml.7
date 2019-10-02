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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D332C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136D321920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZitNU5uT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfJBKLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:11:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37684 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfJBKLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:11:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so6332734wmc.2;
        Wed, 02 Oct 2019 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M4UUQ+aEuggjcZX2H/YTgUQiAaMcYcQjkAJllVSG030=;
        b=ZitNU5uTOmbFx7v1UniRtun/Yc0QcBGI4ZlhH3ocFzm2Om4WZMqgez9edaLqGUy/wZ
         rXiJ1jD3b7gHCDTCXk3TXmkrKJhU4j3sa2jPEedqRsn1o5bY/zHIWUqGZHr9nSc0/sQI
         c1W47Ymmq81Ry9D+Ea2cYb39cuOAloJhWV6xHC5X004coWH6LBa5st2w0s89USKtV4IB
         +YgQqVuehCMt0t/GUIZvYZdBDCHFG/Ld/Z/9BGfdQ/U+PwdclygOEBe1+8J7x+flBgfv
         BDDjyolCPBP4sAbj21AMZkcRYLOR0UTkSfplMiljla9I4Tu9+eSfGjpBJVCm6AJjIUEx
         iMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M4UUQ+aEuggjcZX2H/YTgUQiAaMcYcQjkAJllVSG030=;
        b=Yl1NuhtJlPxIk5PpqSD2xuxHz1f1VDUa1GnMVEQteWsBZFDqHIN0KOtoT3DyGsxjiE
         HU/yS7+Hhn5B46rzRFvFvgxUMlCpQTu61WioRofCA82Nhb1/4blcvEU2ZbMTwc5Mc42T
         qkkVy0B5VaLKgdlQ/InNBYOWKgNpKFAVXhI176PC1f20BuYXJZ1l4QFTidsSdvz+cy9t
         FqsO9aiGWN3o8lJZCO9bybRetIZ0CWKWAx28wHFesHrGtsu8Dl2HwT92YKtQLnGjwH/m
         /f7uTAMLs+oD95TVuHL5zhxa/L0cfAkJk7T2vg8bKw5RdiUDGGK2XOsIZnNFWRPTxEG1
         4XIQ==
X-Gm-Message-State: APjAAAUPMEi0ZnosgP7KUctOLsq5b8xfIjlr52zORjFxOn078mDqjz6p
        U+cIopKlo8QJqmMRDeVcWW4=
X-Google-Smtp-Source: APXvYqzqtvIJ5BH8JA2ViQyMstGCjhKX2rgAAsWWNSo4aGPTtquUMKlxj2BQl2aPvnloImVstqW7lw==
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr2181454wmj.12.1570011064811;
        Wed, 02 Oct 2019 03:11:04 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id b22sm4964600wmj.36.2019.10.02.03.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 03:11:03 -0700 (PDT)
Date:   Wed, 2 Oct 2019 12:11:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com, skomatineni@nvidia.com
Subject: Re: [PATCH 5/6] arm64: tegra: Add XUSB and pad controller on Tegra194
Message-ID: <20191002101102.GG3716706@ulmo>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-6-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kadn00tgSopKmJ1H"
Content-Disposition: inline
In-Reply-To: <20191002080051.11142-6-jckuo@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kadn00tgSopKmJ1H
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

I also noticed that this is outside of the /cbb bus node. It really
belongs inside /cbb. Same for the XHCI controller node.

Thierry

> +		compatible =3D "nvidia,tegra194-xusb-padctl";
> +		reg =3D <0x0 0x03520000 0x0 0x1000>,
> +			<0x0 0x03540000 0x0 0x1000>;
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

--kadn00tgSopKmJ1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2Ud7YACgkQ3SOs138+
s6Fc4g//doxqb6jUWGiWBzZ1ER+mEG+TxHEsnsZJ/r1205w9wyN+WLLEKkrDVwKN
yaB/7/4TlwCg8HEs6pDMwn4puU8kiRoMLQM6jekI4NtExurKLV9JhkAnA0l7J+nJ
bKDeewgv04CqzYIeGg+NeveI8nheTlbg2qFXrQxbjZHqUYouRBUJhaUB9yH+8+qo
Mg6phXNr6e63bqy8lE0cNDi3QFNKn1tRdYJ/1/Cmd+UiZzFy2JJr6Df0ca9xIU/8
zHpvUO5Gft4lof1wbTgRuJT93O/Tpul431noSIA2FJbUWfWdMeHoq9iO0RsQ2jrW
9BKWV966H2mFyt4RZtRehlcE9T4R8z7VkV63hrCK39ggLywmARIgUdYXtl9bjn1K
/OCbCPsthITfuXBCOhrfeNCysrCHwOA5VeAtISI0xnCPAogAdTplmpWPJY9XZDz1
XkzE0UZG59YF5x1+JRwbamJ0WP28NUXemhD3MX5fbWwBRcK3B5roTnQHxyYcyCOS
/DVknEU893JRCqi70kB67zZu2nGICC6peiTdJZMHovaXQHOi/2YK7F/qRli3DCkd
aakqavcDQt1AGgEry9wg0NEyBG9ltPIZThnUCTveu+9oBtMGutRBsNNu8kT6bIww
4+7VyitnJWyw0lFGu7C4n8+Y0pWqeTxI++yOnuosM+q0wz2g7LM=
=l7N3
-----END PGP SIGNATURE-----

--kadn00tgSopKmJ1H--
