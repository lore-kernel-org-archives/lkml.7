Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612FFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B72A2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILvH+n+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfEVN24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:28:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44524 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:28:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so2291898wru.11;
        Wed, 22 May 2019 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eAAuLA5om6VrYrWHB9GFmGEVserHpuSE9+0R0hizySY=;
        b=ILvH+n+XRHqMb/uN9Hzjj3WSX5iuHxn5eVTmWiV/SSCRBoaUQK7/28mFpKUBK1ebqd
         hwFWezE7FHLpin6ZkGQoSuQUtUUOq9z+/YNtjDRBzv9QQnZK8jTNj4Ct+1/tzR9VWcBh
         jvjN0iQxw5jFJ0Kkm20e3/OdIsbsWNzcgo0xerrROkDSO4YHqJ8nc4ZOcQBsNkE/gHUD
         dA2a90kQMeT7U9FVeJ1v3EehQv9oCpkPNdXK54bG5LaeuQC0kkwwuRSI3gKW2We1fVln
         Q5EXGdX6totPPgpVu2BXU3KkFcfJ2Vt9bqxXMAgJG6UvbHcOyADvojj7xratFMqtnQEP
         Dnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eAAuLA5om6VrYrWHB9GFmGEVserHpuSE9+0R0hizySY=;
        b=FC7T0/Xo0e7h+6613+0/Don0L/NkNGmDIAHhdecZfCLTo7UVNMQt/X4phnJcqGr7wp
         vkOPaB/reMZH0C3Oho6k8PKyZiroy75UqMV7D5VSOVfWWX3afQVeqTgipZQozVU80FEg
         Q5zrb8QmNgvCoCZ9Gh4BF1mjahdSK6bcWjGYctSnoDBCGTH+GD/8xEjeL0yBzJh1a0q9
         0dEz8PnCh+pc4dEJgx+AAPsQbMn8MdcFFkRDyzMq3evb5ER2nVYU2TQlp/vIxD56RRrL
         i6j24isHZFkj3vxptil+ih/SsXnVV7Hz11XJo4IsBxTkfVPjOFj/CmMznHCo+f5Nw34j
         0DMQ==
X-Gm-Message-State: APjAAAWMMGY0mOnsoo4ov+lhWa3cYDHt0vcFcgGAP+BLmoS/O8YtZJWH
        pyCVs+QQGZEuOsmo9qaYRGs=
X-Google-Smtp-Source: APXvYqxZtrMiJQU38jZUcjGsvAJFMuXF0t9BcMGrWaz6+oeSS6GT/87elRamgKNNbKfR/TxA/YBGCg==
X-Received: by 2002:adf:c188:: with SMTP id x8mr2612144wre.256.1558531733373;
        Wed, 22 May 2019 06:28:53 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id b206sm7249288wmd.28.2019.05.22.06.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 06:28:52 -0700 (PDT)
Date:   Wed, 22 May 2019 15:28:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, jckuo@nvidia.com, talho@nvidia.com,
        josephl@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 11/12] soc/tegra: pmc: configure tegra deep sleep
 control settings
Message-ID: <20190522132851.GM30938@ulmo>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
 <1558481483-22254-12-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hnsKUeImFCk/igEn"
Content-Disposition: inline
In-Reply-To: <1558481483-22254-12-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hnsKUeImFCk/igEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 04:31:22PM -0700, Sowjanya Komatineni wrote:
> Tegra210 and prior Tegra chips have power request signal polarity,
> deep sleep entry and wake related timings which are platform specific
> that should be configured before entering into deep sleep.
>=20
> Below are the timings specific configurations for deep sleep and wake.
> - Core rail power-on stabilization timer
> - OSC clock stabilization timer after SOC rail power is stabilized.
> - Core power off time is the minimum wake delay to keep the system
> in deep sleep state irrespective of any quick wake event.
>=20
> These values depends on the discharge time of regulators and turn OFF
> time of the PMIC to allow the complete system to finish entering into
> deep sleep state.
>=20
> These values vary based on the platform design and are specified
> through the device tree.
>=20
> This patch has implementation to configure these configurations which
> are must to have for deep sleep state.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi |  7 +++++++
>  drivers/soc/tegra/pmc.c                        | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/=
boot/dts/nvidia/tegra210-p2180.dtsi
> index 4dcd0d36189a..7ac5e55a30aa 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
> @@ -266,6 +266,13 @@
> =20
>  	pmc@7000e400 {
>  		nvidia,invert-interrupt;
> +		nvidia,suspend-mode =3D <0>;
> +		nvidia,cpu-pwr-good-time =3D <0>;
> +		nvidia,cpu-pwr-off-time =3D <0>;
> +		nvidia,core-pwr-good-time =3D <4587 3876>;
> +		nvidia,core-pwr-off-time =3D <39065>;
> +		nvidia,core-power-req-active-high;
> +		nvidia,sys-clock-req-active-high;
>  	};
> =20
>  	/* eMMC */

This hunk looks like maybe it belongs in the last patch?

Thierry

> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 5e68e1de1780..8d225962d136 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -66,6 +66,7 @@
>  #define  PMC_CNTRL_SIDE_EFFECT_LP0	BIT(14) /* LP0 when CPU pwr gated */
>  #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
>  #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
> +#define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
>  #define  PMC_CNTRL_MAIN_RST		BIT(4)
>  #define  PMC_CNTRL_LATCH_WAKEUPS	BIT(5)
> =20
> @@ -98,6 +99,8 @@
> =20
>  #define PMC_CPUPWRGOOD_TIMER		0xc8
>  #define PMC_CPUPWROFF_TIMER		0xcc
> +#define PMC_COREPWRGOOD_TIMER		0x3c
> +#define PMC_COREPWROFF_TIMER		0xe0
> =20
>  #define PMC_PWR_DET_VALUE		0xe4
> =20
> @@ -2293,6 +2296,7 @@ static const struct tegra_pmc_regs tegra20_pmc_regs=
 =3D {
>  static void tegra20_pmc_init(struct tegra_pmc *pmc)
>  {
>  	u32 value;
> +	unsigned long osc, pmu, off;
> =20
>  	/* Always enable CPU power request */
>  	value =3D tegra_pmc_readl(pmc, PMC_CNTRL);
> @@ -2306,6 +2310,11 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
>  	else
>  		value |=3D PMC_CNTRL_SYSCLK_POLARITY;
> =20
> +	if (pmc->corereq_high)
> +		value &=3D ~PMC_CNTRL_PWRREQ_POLARITY;
> +	else
> +		value |=3D PMC_CNTRL_PWRREQ_POLARITY;
> +
>  	/* configure the output polarity while the request is tristated */
>  	tegra_pmc_writel(pmc, value, PMC_CNTRL);
> =20
> @@ -2313,6 +2322,15 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
>  	value =3D tegra_pmc_readl(pmc, PMC_CNTRL);
>  	value |=3D PMC_CNTRL_SYSCLK_OE;
>  	tegra_pmc_writel(pmc, value, PMC_CNTRL);
> +
> +	osc =3D DIV_ROUND_UP_ULL(pmc->core_osc_time * 8192, 1000000);
> +	pmu =3D DIV_ROUND_UP_ULL(pmc->core_pmu_time * 32768, 1000000);
> +	off =3D DIV_ROUND_UP_ULL(pmc->core_off_time * 32768, 1000000);
> +	if (osc && pmu)
> +		tegra_pmc_writel(pmc, ((osc << 8) & 0xff00) | (pmu & 0xff),
> +				 PMC_COREPWRGOOD_TIMER);
> +	if (off)
> +		tegra_pmc_writel(pmc, off, PMC_COREPWROFF_TIMER);
>  }
> =20
>  static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
> --=20
> 2.7.4
>=20

--hnsKUeImFCk/igEn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlTpMACgkQ3SOs138+
s6Hceg//eJ9RnI4FqaavIppTxvP+6ycPplyXRYYRThqnNCkniyHlND9eTi13aWTZ
7KPyxOq1soDt75QXoah478RxkuCUkQ48w3/t6J622eN8r5n/VC+XHvprajKCPJeO
3O3i+Ma5gIqdpBCx2wgv+/OZExgE2oFfhRWUPFxpeM+PCKu6C8ild7288lXAxu6K
tL+GBFbbd1YbvO98X0vSrC8hP8f2/byKSwBmnwQUcFJsumylyQ9QS/ILgp8Gb20s
MJSqOCQmxKp8yuQfq41YHKuBYwdWSN5VVE/s/N+3CvM3mQCV1gWKMCfIryZc819J
k4aAAeqRp+hua9E2G/DJvMjJTNm299DNjHbqF9pmE49ggTam9yBxiwZXwHiI1snY
yH66DmApDxu5g5AxsjcWdees7km+Ug8ZaNCR2TewjBkOq/end8mZhVvRjN27jlq/
oIKUpxqT8hFm8voF55Y5bYWZ3H2eyP+GAH6f1b4HDytS8epsDx9Uj/yc/URmpvXA
lflvfcrHRFEsSYIyX6fNbw0s+oJCb04f6oLz0tB5T53AyClU6xW+cDHLF9Dvdt4p
G6Q8ZEEtrcyIzvxkBNS2hbiqjKnTAX9iKU+r3/1RJ49okvsEgAUIMrfqyIJ+xxeK
rjkPkgQSaCbE4TGzSwmk6gKDCFKk1/FCJmMvasMS9cUbQg0eIQU=
=vVPi
-----END PGP SIGNATURE-----

--hnsKUeImFCk/igEn--
