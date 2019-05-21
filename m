Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0367FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69DD2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIrsm3PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfEUPAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:00:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45115 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfEUPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:00:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so18947030wrq.12;
        Tue, 21 May 2019 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vyK/mPyRJOdcHJJCImc+aiGr+T+jcqi6u6xDwEP/lVw=;
        b=qIrsm3PA+ie9ByYZGnDHhdENmckxt9Wn3Zpm4I9oeebpgQYv3j29+6DT+BIQKOnrjx
         9cgi6T39TSV04E4Lhu7Adq4u/Lo4LYGJj7+yuFpd+cF6ioNsrJi48uY0I/TM7jTidbfa
         L3hlrWXDR4FqeTYnK7uDOoZ5MO8xMLecI+Fs2QahMVsfX+DE7uqvl+DLe1w3PR+yoWOy
         iaCVsFp3VpXqsQk4a++yW0wPZg7bVR9XxeP+5XLbs4fmdpE89Q4dZFObo/Lf3m87iEa/
         +q7kzTtPMnVhpMpROlp4DsWcdsH4s5NsTNwt+4QgUwJ3hz6/H/DVhZ05jWJST+PptrTd
         yvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vyK/mPyRJOdcHJJCImc+aiGr+T+jcqi6u6xDwEP/lVw=;
        b=fBbhvteaUrAGtDr6s9resNbkjejaoO3RaeUqGPzyFSuWucvZ+Qd7TzMKveFMHDCApd
         lXJvu9Nn5QNiU4WxJO+Br+Be65s8RBrTgkrC7brUlosez8o3U7mHwueM2PRRFiFF98qR
         zA8Lra2uFzXlXh/Nwtm+JvEKvZyJSb/gXyRx1ALjhFspddCTt0UWs9UrJIm+rO/KWx8j
         HgfSOe5ViTHXN3/80GABv78a7gKc6w9NQIE/zEhMAl39ZEcpxug0DSmm5EL4H8Oku0zn
         7ZCnc8V8DCEI+q6YosTcKcJcrt7GCFf23TREmHq7YoccHRmZsPITENTybKrU064QbHG5
         mWCg==
X-Gm-Message-State: APjAAAV1AbK3Tlnq5hW0DA6IQq1HhbTsWAMdOwYyDhXgcPvZuxthDqA+
        8vJJHFaXbH2e9wiSILuHTP4=
X-Google-Smtp-Source: APXvYqwiC5nPtcRDsTzuXv+IiYZ2EjEjqlmSAdKy4NhHJ3M5HUK029K3c5V+FHD/e2eb0BRkOjxWeQ==
X-Received: by 2002:adf:83c5:: with SMTP id 63mr20838465wre.33.1558450846486;
        Tue, 21 May 2019 08:00:46 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u2sm32242993wra.82.2019.05.21.08.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 08:00:45 -0700 (PDT)
Date:   Tue, 21 May 2019 17:00:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: phy: tegra-xusb: List PLL power supplies
Message-ID: <20190521150044.GA7098@ulmo>
References: <20190425153444.6281-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20190425153444.6281-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 05:34:42PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> These power supplies provide power for various PLLs that are set up and
> driven by the XUSB pad controller. These power supplies were previously
> improperly added to the PCIe and XUSB controllers, but depending on the
> driver probe order, power to the PLLs will not be supplied soon enough
> and cause initialization to fail.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> This was previously reviewed here:
>=20
>     https://patchwork.ozlabs.org/patch/1077153/
>=20
>  .../bindings/phy/nvidia,tegra124-xusb-padctl.txt     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Hi Kishon,

do you have any comments on this series. It's fairly straightforward but
is required in order to make XUSB work properly on Jetson Nano for which
support was merged in v5.2-rc1.

Thanks,
Thierry

>=20
> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-p=
adctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padc=
tl.txt
> index daedb15f322e..9fb682e47c29 100644
> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.t=
xt
> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.t=
xt
> @@ -42,6 +42,18 @@ Required properties:
>  - reset-names: Must include the following entries:
>    - "padctl"
> =20
> +For Tegra124:
> +- avdd-pll-utmip-supply: UTMI PLL power supply. Must supply 1.8 V.
> +- avdd-pll-erefe-supply: PLLE reference PLL power supply. Must supply 1.=
05 V.
> +- avdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
> +- hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 3.3=
 V.
> +
> +For Tegra210:
> +- avdd-pll-utmip-supply: UTMI PLL power supply. Must supply 1.8 V.
> +- avdd-pll-uerefe-supply: PLLE reference PLL power supply. Must supply 1=
=2E05 V.
> +- dvdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
> +- hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 1.8=
 V.
> +
>  For Tegra186:
>  - avdd-pll-erefeut-supply: UPHY brick and reference clock as well as UTM=
I PHY
>    power supply. Must supply 1.8 V.
> --=20
> 2.21.0
>=20

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzkEpwACgkQ3SOs138+
s6GifhAAoCiCcvnoALjMNw+bcAVupWuDb+KWFF59YbxHzUKtctPi36CiVZrsdKqO
l3p+Mp23SKd/F/NlNDuU6n0HHSCYCOT/o1Fyy8bF1B056wPomE39k4RxZ/bmdp2D
VHsLW66+WajZf/cYYAY7m8koEL8Nk2h2kJS7rDZ6dKQWxnx0NUNJyxH1HLLsk2d+
egRa8aeaPFvMEFsHDgX+Ux6/kRglG/pXfe+eulrR9DJzKeISBKc3SC43iYisll9t
Z+r28EO1jOWemRr9s0ezjorVw/JApiijSe5B1czBFnGd/1PN7IwPeNjsgFaZ2IS5
QTdP1r5Mot9v3Rkv3nlxApI0YmpeewqNXgUf86MJuu/TTEqGuiZjf4Afse0MNiJx
z7vBiWhESttcvbB4qVVUyC/lEadJuUAADxAdgUQFGb1UoMCHkF7CdPQuhgNFvMi3
tvDv6W/I3s24fZkQ3U9smc5lLYAAR/zqlz3lG3c4mkpBuF1BneiINa4mfusJ6LzB
T0TdAe8AtP6Vk3A4jNG0zEdiXKp66uTHwaBj2AxIJMm623a5WJPesNf5HAvTV4q7
zT3nJxH/KG5iZNPjEK/I7+XWFzpOaD956tojDFQ5qv+MuSKakkp/rUqPoz+BHsJO
99cCv4ObZHJmzVRj7+FjetkLR6euXlUDm2dxu2geowjPKXfAbJU=
=u4HU
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
