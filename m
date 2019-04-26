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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9701CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE5D2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUjp491g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDZNHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:07:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35733 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfDZNHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:07:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so4361746wmd.0;
        Fri, 26 Apr 2019 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rsrLtw4Gmr2viLgGXMzcj3XLcNbytJSIHL3NMu3D0Rw=;
        b=bUjp491gDi63+BuCK0cKDD7V+fPodhm/rDn22t2ZUvaV+mnMzVZ/9FfhsuTKMRmnRo
         4UPYmA2l38uP63i9OHurURplpglqhJvYE2zpgzkfNrseBmkie9GY6AK1gj13ws7uiNEh
         K9o/9RyZL+CxU2JKdu9r9VmXoq8ac2NhA0OnUPRdIKcxnTCL69h50NGZOfv9gCsHPPxo
         3ZWTsOJDZB8lQlS8Y1YKE/xbTz6znTRYis8YzuY3eSuQdahZ+afeFCyFWZ6thv3pByMF
         tbg60vwdXVrvpsWa/KvTjp8u0d3T5MMvx+v690jQRxRlgF3nVpqGjHu+ZTv/eQhENZad
         dVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rsrLtw4Gmr2viLgGXMzcj3XLcNbytJSIHL3NMu3D0Rw=;
        b=JBd6dsPyNn1YdVQb3QEgwOw/NU8IO442jPuMUnrAhZRUk9f4JRK2ItFVx3Lc0aYsSw
         P/frk1BIIoFfTV+9O2wlFQ82NE4kxCYqkpbAY/qZ6lWJF1nP1z115loSHKr8CcTZ/2TX
         Ggy/xYCpXyOCuqGZT7Lebf1CUYOZkmkluhvvm69BXD5On9octg8NWCROE4ubJqOG5lC6
         K+oYuEwTG3tqM8dxEXAAqp6iP1113lL28Az44F0ElscFabWldiT27jeNwiGIkqPjtoLG
         KYdlm8rbmzXRV9cQGHrP6EVShUMHAOyy33yexsufh+1wNCI0IIpkYFoZn80QSbF10JYL
         MP8w==
X-Gm-Message-State: APjAAAW7YZjoOrxCEzfgiJW7rhCeVbEwRA/FJYXm3c/GjlcWo9Dm92Xc
        +bdLSTOEQT+YJo9qbPwXOlA=
X-Google-Smtp-Source: APXvYqxtiyLS5gnAASRfRwtPjtYN/w8rWbUPH+q9XGKD/0O0hMYs62fGHG2d85oS+TunHB5aM6RDGg==
X-Received: by 2002:a1c:7005:: with SMTP id l5mr4150032wmc.149.1556284070941;
        Fri, 26 Apr 2019 06:07:50 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id s21sm20244314wmh.22.2019.04.26.06.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 06:07:50 -0700 (PDT)
Date:   Fri, 26 Apr 2019 15:07:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     linus.walleij@linaro.org, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        pdeschrijver@nvidia.com, josephl@nvidia.com, smangipudi@nvidia.com,
        ldewangan@nvidia.com, vidyas@nvidia.com
Subject: Re: [PATCH 1/2] dt-binding: Tegra194 pinctrl support
Message-ID: <20190426130748.GC16228@ulmo>
References: <1556247378-3335-1-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <1556247378-3335-1-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B4IIlcmfBL/1gGOG
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
>=20
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

This doesn't appear to be documented and we don't use this on any other
chip.

> +			pex_rst_c5_out_state: pex_rst_c5_out {
> +				pex_rst {
> +					nvidia,pins =3D "pex_l5_rst_n_pgg1";
> +					nvidia,schmitt =3D <TEGRA_PIN_DISABLE>;
> +					nvidia,lpdr =3D <TEGRA_PIN_ENABLE>;
> +					nvidia,enable-input =3D <TEGRA_PIN_DISABLE>;
> +					nvidia,io-high-voltage =3D <TEGRA_PIN_ENABLE>;
> +					nvidia,tristate =3D <TEGRA_PIN_DISABLE>;
> +					nvidia,pull =3D <TEGRA_PIN_PULL_NONE>;

Should the above not set a nvidia,function property for the pex_rst pin?

Thierry

> +				};
> +			};
> +		};
> +		pinmuxtest@0 {
> +			compatible =3D "nvidia,tegra194-pinmux-test";
> +			pinctrl-names =3D "pex_rst";
> +			pinctrl-0 =3D <&pex_rst_c5_out_state>;
> +		};
> --=20
> 2.7.4
>=20

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzDAqQACgkQ3SOs138+
s6H1qg//RWcDJBPuUXv7TZF/CL+BdbTsUBWjBbYxyO2uIWwCpgOB6IPSIbWWHP+D
TMux4TUd0Jdra2AuWfOPQSJXhHlGxSSQWPyPvCX5ZMuMAb0khraFsCcmjcQzEtgi
aUDm3kupODoKbuwV7bwJuuRjhlINM3o7ItB/Z3QQ6kelY8SCMqlkY2yAU2YXZi9Q
t1wFSyP0SkovHHYkz1SMsqejraX91i6VT+3MN4sCrztSquD6QeLWZNfNfLET0Y6G
zTin1D1JHpVaFPOn4WoNDTZUGFgSe6VzZePAuO22yj9uaFZo6bm1q5UJRPk+YWM0
CgsfibQoGLhRxQJhZIREXisQDwJkcuM5Q//PkZlA7OFd3+0gqnzGvHZ4wGnUlcAS
kAlL951+YrRkyhVyalm2X9q7zZ5Az+PdT5OcYQx6fDquk9kHCCYOZbyghU2U7EL6
Fr+Y2wk1praI7Xu29JhHbS4/i5t15MlNeZ2b2csqtG+5Z0QOfRWjOswqnfqNVgqG
yM5ZBsrQk+43rWwXmgiDv89HHn9QXi4lyJF1cbbLToqLlt0FXR4MYGMwGycw0F5z
3d4/0aVXAtn5wsqWIanSmtqyGncRz5bKkx0EeYHLTHEIlY38+LdXWVqgXjAUNiGn
EDrLWVWJn/eG0ITIw9aO3Cm6CquLxktdwV/4mTIHYkCc+kunUcE=
=ibra
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
