Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3B3C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948132067D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aha272U4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfDZNFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:05:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33302 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZNFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:05:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so4423470wrp.0;
        Fri, 26 Apr 2019 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9evg3lCrRRXU90/0lCwm8VkJTX2FRwSG+z9nzU2efq4=;
        b=Aha272U4mTPkHLoKZsJX3uvl/g2dS4x7FrWRxXx72ZqJFTpuU6GhS4sY+Ki8A1q4R5
         92vKwaRnomGoGD2ovX1Y4uzJaQuhTKK6+ToM6NXLP+YzBTihu7vuL+97Jmpn+ju3QrgV
         c3A8SxfLYV/7mXR6ER3UgDquA/m0fYODSsUuhzpyr1vmlbicCDamsZ+n+j20Hp6lj8ZL
         igiYD4oTHyR5Sv0N94+AbKpqCYSVFa6jtRabHDeKMPSiAfYKM4foTuzeaVCWCZDKABpq
         oqVBbbFWJddJMUXDuUVfiCd8oEi+xfkpguOWrsAlxKeOJdhX+9Gr7Ktzn3C71PEBv0Bc
         x8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9evg3lCrRRXU90/0lCwm8VkJTX2FRwSG+z9nzU2efq4=;
        b=t1yyA3XG0oGQQqhOZ2wWnDgYj8ZyjbO2HKcK6wSksMAGRFPR7gkDtxiCyk864QtCcm
         4qFSBzhUfGEEl8TvfqhzZ3qqPHIPz7O0SAGsj76WVmf5k+DMyvzIt5cBlwCyPXdJrPlP
         AACIQmpRj9eEG1OWCxoBwNHALdb1Amf9XOgm/Y33Rq6+xMPikrauk4ll+UUdJ6h37NDO
         b6JtxREIKg/AKjP/RDEvrNfryWnATMxZZcc6brU/Bxrc6+eQt5FGYJDhrsL/63GSsvUd
         f+s3l54p9ZAa1BXRIatjj09jj7Ccwt6Jks0n1ciVcih5+u0GWctnpKshtq9SRs8BT2mG
         OhLQ==
X-Gm-Message-State: APjAAAXPO3veEF8U+AY1BypkqOw93LoXfs3Q5b1MQE0YMoEFtu0CeIVa
        LncwfTZ4oWuHhSF7uR45clM=
X-Google-Smtp-Source: APXvYqwbm4GruffxC6fwSlsNqcFeXu5vaUSgjtFtftHeSH4CCdb0wjwZQbJbjuBxXv0TiDiZlx8Rmw==
X-Received: by 2002:adf:c653:: with SMTP id u19mr6330793wrg.267.1556283945585;
        Fri, 26 Apr 2019 06:05:45 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id p2sm15316588wru.73.2019.04.26.06.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 06:05:44 -0700 (PDT)
Date:   Fri, 26 Apr 2019 15:05:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     linus.walleij@linaro.org, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        pdeschrijver@nvidia.com, josephl@nvidia.com, smangipudi@nvidia.com,
        ldewangan@nvidia.com, vidyas@nvidia.com
Subject: Re: [PATCH 1/2] dt-binding: Tegra194 pinctrl support
Message-ID: <20190426130537.GB16228@ulmo>
References: <1556247378-3335-1-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <1556247378-3335-1-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 08:26:17AM +0530, Krishna Yarlagadda wrote:
> Add new compatible string and other fields used in pinctrl
> driver for Tegra194 in nvidia,tegra210-pinmux.txt
>=20
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  .../bindings/pinctrl/nvidia,tegra210-pinmux.txt    | 43 ++++++++++++++++=
+++---
>  1 file changed, 38 insertions(+), 5 deletions(-)

I think it'd make sense to create an nvidia,tegra194-pinmux.txt and just
duplicate the generic parts in this file. The bulk of the document is
about the specifics anyway and having a separate file makes it a little
cleaner and easier to read.

> diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pi=
nmux.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux=
=2Etxt
> index 85f2114..c4e802d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
> @@ -1,7 +1,7 @@
> -NVIDIA Tegra210 pinmux controller
> +NVIDIA Tegra210/194 pinmux controller
> =20
>  Required properties:
> -- compatible: "nvidia,tegra210-pinmux"
> +- compatible: "nvidia,tegra210-pinmux" or "nvidia,tegra194-pinmux"
>  - reg: Should contain a list of base address and size pairs for:
>    - first entry: The APB_MISC_GP_*_PADCTRL registers (pad control)
>    - second entry: The PINMUX_AUX_* registers (pinmux)
> @@ -83,6 +83,10 @@ Valid values for pin and group names (nvidia,pin) are:
>      These correspond to Tegra PINMUX_AUX_* (pinmux) registers. Any prope=
rty
>      that exists in those registers may be set for the following pin name=
s.
> =20
> +  Tegra194:
> +    pex_l5_clkreq_n_pgg0, pex_l5_rst_n_pgg1
> +
> +  Tegra210:
>      In Tegra210, many pins also have a dedicated APB_MISC_GP_*_PADCTRL
>      register. Where that is true, and property that exists in that regis=
ter
>      may also be set on the following pin names.
> @@ -127,12 +131,15 @@ Valid values for pin and group names (nvidia,pin) a=
re:
>      registers. Note that where one of these registers controls a single =
pin
>      for which a PINMUX_AUX_* exists, see the list above for the pin name=
 to
>      use when configuring the pinmux.
> -
> +  Tegra210:
>      pa6, pcc7, pe6, pe7, ph6, pk0, pk1, pk2, pk3, pk4, pk5, pk6, pk7, pl=
0, pl1,
>      pz0, pz1, pz2, pz3, pz4, pz5, sdmmc1, sdmmc2, sdmmc3, sdmmc4
> +  Tegra194:
> +    pex_l5_clkreq_n_pgg0, pex_l5_rst_n_pgg1
> =20
>  Valid values for nvidia,functions are:
> =20
> +  Tegra210:
>      aud, bcl, blink, ccla, cec, cldvfs, clk, core, cpu, displaya, displa=
yb,
>      dmic1, dmic2, dmic3, dp, dtv, extperiph3, i2c1, i2c2, i2c3, i2cpmu, =
i2cvi,
>      i2s1, i2s2, i2s3, i2s4a, i2s4b, i2s5a, i2s5b, iqc0, iqc1, jtag, pe, =
pe0,
> @@ -140,9 +147,12 @@ Valid values for nvidia,functions are:
>      sdmmc1, sdmmc3, shutdown, soc, sor0, sor1, spdif, spi1, spi2, spi3, =
spi4,
>      sys, touch, uart, uarta, uartb, uartc, uartd, usb, vgp1, vgp2, vgp3,=
 vgp4,
>      vgp5, vgp6, vimclk, vimclk2
> +  Tegra194:
> +    pe5
> =20
> -Example:
> +Examples:
> =20
> +  Tegra210:
>  	pinmux: pinmux@70000800 {
>  		compatible =3D "nvidia,tegra210-pinmux";
>  		reg =3D <0x0 0x700008d4 0x0 0x2a8>, /* Pad control registers */
> @@ -163,4 +173,27 @@ Example:
>  			};
>  		};
>  	};
> -};
> +
> +  Tegra194:
> +		tegra_pinctrl: pinmux: pinmux@2430000 {
> +			compatible =3D "nvidia,tegra194-pinmux";
> +			reg =3D <0x2430000 0x17000
> +			       0xc300000 0x4000>;
> +			#gpio-range-cells =3D <2>;
> +			pex_rst_c5_out_state: pex_rst_c5_out {
> +				pex_rst {
> +					nvidia,pins =3D "pex_l5_rst_n_pgg1";
> +					nvidia,schmitt =3D <TEGRA_PIN_DISABLE>;
> +					nvidia,lpdr =3D <TEGRA_PIN_ENABLE>;
> +					nvidia,enable-input =3D <TEGRA_PIN_DISABLE>;
> +					nvidia,io-high-voltage =3D <TEGRA_PIN_ENABLE>;
> +					nvidia,tristate =3D <TEGRA_PIN_DISABLE>;
> +					nvidia,pull =3D <TEGRA_PIN_PULL_NONE>;
> +				};
> +			};
> +		};
> +		pinmuxtest@0 {
> +			compatible =3D "nvidia,tegra194-pinmux-test";
> +			pinctrl-names =3D "pex_rst";
> +			pinctrl-0 =3D <&pex_rst_c5_out_state>;
> +		};

It's not clean to me what that pinmuxtest@0 node is there for. That
compatible string is not defined anywhere and nothing references the
state.

Wouldn't it make more sense to have an example similar to what we have
for Tegra210?

Thierry

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzDAg8ACgkQ3SOs138+
s6EsDRAAqOpwAotzi5SjF379qvUwX9oWkVDrzDCCq7Tkj+x29JUKRWc+OJiXOCaF
L0WeZTL33MV1a2Y4nt7W9V3/oZ5RgPWlTc/FmHSURe0FzObqT9tzj1Gy49nNBqgw
voJHEUzrqf/sCMJMFWDK81sTc1CXcrF50xu9I/Je3nX60Zxc4f9GKDlXycXW7dPh
E/geagK8UDHMm2LzQmewCm0tPTBxbHUmMAfkMl70rYYHLpLXoFETskxry6IC4udg
f0gZOM0ZLqDQRAhHXP/gD2APJDw9WHhoBbaze3TDbeCGredQXT9R+zQds6uvQnJZ
yxFx0ouaevNmCCTVgXXjlHcPwfGD26rbfjupsxnkAsSUdJKAYLW1sOVjGKVtBhiO
56RaaZhHZYb9SIdNqia4uExz4YkdOO4wDMm4vjIQmIvySiqXoNyPal+AeiAHOnWm
4KHR4jviGF7T/tMtYYa37DF9s/YgxXfJTBqzZb+Wavwdq10Yc6UZvFkMDV4cZKCu
0PNaAuxzYgJwfSWNMRDr5BW05UxQE6SkmdSVD2NZxJ2rqZmcVHdF76DjwXCu0SI0
noX0hV/OJWWPwTaimorwqTa+fswcAz9fO8HpmA2r7j522PzneGupueRoOomurL2P
ICEZ58EeMZ018LOiQ89fcy4Pj3uoCqHcwNRpehiyzuJu1sqx3ks=
=lisa
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
