Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B925C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340B92071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myPCmuwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKNMPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:15:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54514 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfKNMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:15:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so5427186wmi.4;
        Thu, 14 Nov 2019 04:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rUOgOHjYlbkXxgsZaG6sgBUHB8CyQBYcNzaB6zVgJTk=;
        b=myPCmuwRAW8HOsFNY5SLDtFoWpC3BrPDSxLkH4pK1Rbp7V/1Oy6X8RCxanRWakeblZ
         pw3c7kqzsoseTVFabkoUvPXJGUaf5tJ9y4flwotzbIgCB8oZwba3Ou/sQzBG1Kn782hY
         f3LJ82Og3VCE1ddBmyB2mah1+RGmzl5dVs2HbxyamEZKMCOVLfBfiCLR8gNhETMwRPg+
         KqUZ7PjWoqNhKXMD3XXsZ61wmvx26jHeDFQD+vFQG0drWPVZGIiZC7P5a9d0G2CjhGlF
         Gj1DguI2z7dhzg4yTedE9JTYAF7JbGsesN/iXpb34gTGUyYLCh3WxPP5IFJwo6DHANCj
         MfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rUOgOHjYlbkXxgsZaG6sgBUHB8CyQBYcNzaB6zVgJTk=;
        b=Mof2GWpJDz1dCpZmVdui9OwLbWHQ3jDOIwdD/s8qoU5XF0Z5oQOm8LDvdNeAoCLTxp
         tzDUxNPaepdVmJKT/3b5Bc27sN0Jf+ohErpg80NSWsOWOlalYB2j/kQ9BGm09ouC0MJT
         8nJs0mzzNA6+089sogLeER/T2tOlZxXY8FLVDf2WavNT4fsR/M2lPThV+CLh9V2HO4J6
         cc2Gt4L3AB/LkWMVf2i8++81mAEa2NLM4D1ci5Lhok3CanOKcd6IwJ+hUfi4VfJyV0YO
         TxCEB4+6k74gxH/A+sk1TI5CbJGPyBi14Xc7kON6Kd+yZF+tuysB9TolLS/vwlDmmUpP
         LAsw==
X-Gm-Message-State: APjAAAWao2SyyvK7GW+r9a0UumQ9ei7xkBTZXZiJFQt97hOpxjbwh72c
        oZ3NwYKaHxpIBwfDnUk/bLQ=
X-Google-Smtp-Source: APXvYqwL00IP18ibhECaY+MHN0v+hBvnw1L4HPDXL+pCnfA7boi2M7CZhCjrhZmtq43Gj+nK9FpqLQ==
X-Received: by 2002:a1c:200f:: with SMTP id g15mr7887602wmg.96.1573733744545;
        Thu, 14 Nov 2019 04:15:44 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id q25sm7693095wra.3.2019.11.14.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 04:15:42 -0800 (PST)
Date:   Thu, 14 Nov 2019 13:15:29 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        Stephen Boyd <sboyd@kernel.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Thierry Reding <treding@nvidia.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: clk/clk-next boot bisection: v5.4-rc1-201-ga228ae437aa5 on
 tegra124-nyan-big
Message-ID: <20191114121529.GD5690@aiwendil>
References: <5dccdf20.1c69fb81.418aa.a71c@mx.google.com>
 <2696747d-3a82-4244-84dc-bb351364e53e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline
In-Reply-To: <2696747d-3a82-4244-84dc-bb351364e53e@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2019 at 02:56:20PM +0300, Dmitry Osipenko wrote:
> 14.11.2019 07:59, kernelci.org bot =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > *                                                               *
> > * If you do send a fix, please include this trailer:            *
> > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > *                                                               *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >=20
> > clk/clk-next boot bisection: v5.4-rc1-201-ga228ae437aa5 on tegra124-nya=
n-big
> >=20
> > Summary:
> >   Start:      a228ae437aa5 Merge branch 'clk-unused' into clk-next
> >   Details:    https://kernelci.org/boot/id/5dcc99e959b514100f138e14
> >   Plain log:  https://storage.kernelci.org//clk/clk-next/v5.4-rc1-201-g=
a228ae437aa5/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-nyan-big=
=2Etxt
> >   HTML log:   https://storage.kernelci.org//clk/clk-next/v5.4-rc1-201-g=
a228ae437aa5/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-nyan-big=
=2Ehtml
> >   Result:     25175c806a68 clk: tegra: Reimplement SOR clock on Tegra124
> >=20
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> >=20
> > Parameters:
> >   Tree:       clk
> >   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux=
=2Egit
> >   Branch:     clk-next
> >   Target:     tegra124-nyan-big
> >   CPU arch:   arm
> >   Lab:        lab-collabora
> >   Compiler:   gcc-8
> >   Config:     tegra_defconfig
> >   Test suite: boot
> >=20
> > Breaking commit found:
> >=20
> > -----------------------------------------------------------------------=
--------
> > commit 25175c806a6841149abe46168e0af12593141612
> > Author: Thierry Reding <treding@nvidia.com>
> > Date:   Thu Jul 25 18:19:00 2019 +0200
> >=20
> >     clk: tegra: Reimplement SOR clock on Tegra124
> >    =20
> >     In order to allow the display driver to deal uniformly with all SOR
> >     generations, implement the SOR clocks in a way that is compatible w=
ith
> >     Tegra186 and later.
> >    =20
> >     Acked-by: Stephen Boyd <sboyd@kernel.org>
> >     Signed-off-by: Thierry Reding <treding@nvidia.com>
> >=20
> > diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-t=
egra124.c
> > index 7d231529c3a5..b3110d5b5a6c 100644
> > --- a/drivers/clk/tegra/clk-tegra124.c
> > +++ b/drivers/clk/tegra/clk-tegra124.c
> > @@ -1005,20 +1005,24 @@ static struct tegra_devclk devclks[] __initdata=
 =3D {
> >  	{ .con_id =3D "hda2hdmi", .dt_id =3D TEGRA124_CLK_HDA2HDMI },
> >  };
> > =20
> > -static const char *mux_pllp_pllm_plld_plla_pllc_plld2_clkm[] =3D {
> > -	"pll_p", "pll_m", "pll_d_out0", "pll_a_out0", "pll_c",
> > -	"pll_d2_out0", "clk_m"
> > +static const char * const sor0_parents[] =3D {
> > +	"pll_p_out0", "pll_m_out0", "pll_d_out0", "pll_a_out0", "pll_c_out0",
> > +	"pll_d2_out0", "clk_m",
> >  };
>=20
> I'm not sure how it supposed to work because looks like some of these
> "_out0" parent clocks just do not exists in the upstream clk driver.
>=20
> Either some other patch that adds "_out0" aliases is missed or this
> patch was based on top of a different codebase (downstream kernel?).

The pll_d{,2}_out0 clocks are registered as fixed-factor clocks. The
others I'm not exactly sure, but I think I ended up taking these
directly from the register tables in the TRM (the clock mux fields).
Looks like we ended up naming these differently in the kernel driver
when it was merged initially.

The reason why this works is because the common clock framework will not
flag these clocks as missing since they may appear at some later point
(perhaps by some different provider).

In this case it doesn't really matter because the only parents that are
ever used or the clk_m, pll_d_out0 and pll_d2_out0.

It might be a good idea to clean some of this up at some point, though.

> What's also a bit odd is that commit says Tegra186.. but AFAIK there is
> no driver for Tegra186 clocks in upstream.

Clocks on Tegra186 are provided by the clk-bpmp driver. Basically those
are mostly the same clocks but the implementation is provided by the
BPMP and the clk-bpmp driver talks to it via an IPC mechanism.

So basically the bottom line here is that the SOR clocks were not
correctly implemented on chips prior to Tegra186 which leads to obscure
bugs with HDMI and DP outputs.

Thierry

> BTW, seems T114 clk driver also uses a non-existent pll_m/p/c_out0 for
> the emc_mux.
>=20
> Thierry / Peter, could you please explain what's going on with this
> patch and why clocks are missed on T114? Maybe I'm missing something?
>=20
> > -#define mux_pllp_pllm_plld_plla_pllc_plld2_clkm_idx NULL
> > =20
> > -static const char *mux_clkm_plldp_sor0out[] =3D {
> > -	"clk_m", "pll_dp", "sor0_out",
> > +static const char * const sor0_out_parents[] =3D {
> > +	"clk_m", "sor0_pad_clkout",
> >  };
> > -#define mux_clkm_plldp_sor0out_idx NULL
> > =20
> >  static struct tegra_periph_init_data tegra124_periph[] =3D {
> > -	MUX8_NOGATE_LOCK("sor0_out", mux_pllp_pllm_plld_plla_pllc_plld2_clkm,=
 CLK_SOURCE_SOR0, tegra_clk_sor0_out, &sor0_lock),
> > -	NODIV("sor0", mux_clkm_plldp_sor0out, CLK_SOURCE_SOR0, 14, 3, 182, 0,=
 tegra_clk_sor0, &sor0_lock),
> > +	TEGRA_INIT_DATA_TABLE("sor0", NULL, NULL, sor0_parents,
> > +			      CLK_SOURCE_SOR0, 29, 0x7, 0, 0, 0, 0,
> > +			      0, 182, 0, tegra_clk_sor0, NULL, 0,
> > +			      &sor0_lock),
> > +	TEGRA_INIT_DATA_TABLE("sor0_out", NULL, NULL, sor0_out_parents,
> > +			      CLK_SOURCE_SOR0, 14, 0x1, 0, 0, 0, 0,
> > +			      0, 0, TEGRA_PERIPH_NO_GATE, tegra_clk_sor0_out,
> > +			      NULL, 0, &sor0_lock),
> >  };
> > =20
> >  static struct clk **clks;
> > -----------------------------------------------------------------------=
--------
> >=20
> >=20
> > Git bisection log:
> >=20
> > -----------------------------------------------------------------------=
--------
> > git bisect start
> > # good: [dafbb1e6473788cb3068eaeddc58f9d88e9c7a62] Merge branch 'clk-ti=
' into clk-next
> > git bisect good dafbb1e6473788cb3068eaeddc58f9d88e9c7a62
> > # bad: [a228ae437aa553736058cbbd58d2d0e191635cdc] Merge branch 'clk-unu=
sed' into clk-next
> > git bisect bad a228ae437aa553736058cbbd58d2d0e191635cdc
> > # bad: [3214be6cb1e487b0f8c3bb2eac9b06df07a07e06] clk: tegra: Share clk=
 and rst register defines with Tegra clock driver
> > git bisect bad 3214be6cb1e487b0f8c3bb2eac9b06df07a07e06
> > # bad: [05308d7e7bbc932025f1dafc401c73ce83c6f414] clk: tegra: Reimpleme=
nt SOR clocks on Tegra210
> > git bisect bad 05308d7e7bbc932025f1dafc401c73ce83c6f414
> > # good: [d1ee3173a139ed2eb8d87e06216f0426b16084d8] Merge branch 'for-5.=
5/dt-bindings' into for-5.5/clk
> > git bisect good d1ee3173a139ed2eb8d87e06216f0426b16084d8
> > # good: [e5f8a107d92db30a7ad7d8d95aee59f5ad76206a] clk: tegra: Move SOR=
0 implementation to Tegra124
> > git bisect good e5f8a107d92db30a7ad7d8d95aee59f5ad76206a
> > # bad: [25175c806a6841149abe46168e0af12593141612] clk: tegra: Reimpleme=
nt SOR clock on Tegra124
> > git bisect bad 25175c806a6841149abe46168e0af12593141612
> > # good: [da8d1a3555406275650b366460c6235f1696bf8b] clk: tegra: Rename s=
or0_lvds to sor0_out
> > git bisect good da8d1a3555406275650b366460c6235f1696bf8b
> > # first bad commit: [25175c806a6841149abe46168e0af12593141612] clk: teg=
ra: Reimplement SOR clock on Tegra124
> > -----------------------------------------------------------------------=
--------
> >=20
>=20

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3NRV8ACgkQ3SOs138+
s6HFRA//ezhmZlP8YsTWZ7P728QVSm0JNhS1rsgaw6mldjDe6NcCxJx5XZJDDaAy
XmuTAXIUpMW9HOzeZKk25YNOTJWgPr/PdXJ9jS72LHdwiWMsWykBN5Wp9YBV71BG
qxUmqX03//foZo1zuPtvk94kqhEhlcFcVZOI9IhjQxHiBmnu9smJV+jpsx46yc+O
gIm88ddTgPc0arGwVFuMoZ1hW/nVXaeC59Sg6Kq0czyhx9cEsYiRWugRIuOQuR6B
ThSuQWw5W1AqmldfrB1qAA9OlQWeVRfXWoWTo5ddYxF/tmU7kWTowID5l5uO/5uf
pjzN6sVUY/96HKRj+FEkhlboVlLKmgFyCeGiUrPEYdkPDk5L8noOi5HloZ3GvEyy
Op5yHxLn3ZYX41pvR2Tf2LMft1XtyvWo9ed0wBzXb1z5qXS88xJtsBCcfGSuzs+v
DtMsBp0xJUUm01c8OIRo/+NnUbCNMQlUSCLNIQYyOLmi2LDlN4EXkj82M/44WdFo
ncUx3fBKt7XLF6SCKtzA7fp7hxdLAyldOwveDOsOSoz5m/7cuCv/n9FG1NrvsJNY
T1Vio3gB1OYv6mS1xhlEeWf4M4PuByJu2X20SCvjhtCMz9xQDtz6hceFDCUa40Lx
o0ezUiuRuz6+sVLc9roSDLMy2XCRnq06xXG7Rqgs/O7ka9seqyQ=
=adhW
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
