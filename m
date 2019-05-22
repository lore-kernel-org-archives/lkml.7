Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C06DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A1521479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIyUFerl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfEVMtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:49:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40808 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfEVMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:49:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id 15so2076477wmg.5;
        Wed, 22 May 2019 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=swdAIXsZGhrGk/f703Z2+Wo04Cd4e6g6npZCW2aWqbM=;
        b=TIyUFerlOVtJXC0nnRPro5qHoF5aMDqEOKEagqDCr0jsFDWr3J7DzqPVB/Ab8ZUlMx
         Mx6BvpIllHjPXDkdDC/vahdrzzDVq9lclFgqXzWc4LBUnBcspWDNEQhkfPOo6x9367y/
         VSP3/ljRtbbHI/Hyvt+8uCTyEXP+s/yf49Vq9EoEKZRfaRTA6yOGpTAP8b4jNdNeof/a
         ohw8DgJgOpidJMfXGtvO/Vy6rW1L4vShe9iieTbShgu/LHhJ2lDPKs5eogR5oQfs+V+c
         vOYpIRTwAQpc+J3BSDHvm0SWHBL858XkZgV/DSoFgjTzn+SnzLHaSzuLeLUqt/FADTXp
         tbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=swdAIXsZGhrGk/f703Z2+Wo04Cd4e6g6npZCW2aWqbM=;
        b=rIUvhtjwSljA8i08jYRbw8WZxmWiWyn72AC28L/hscxWDWCi6riK4JzEoOTn+AjEft
         SOsqGusK/QVuYMlYaaTtDXsafu5D2JfNgauZO3uE5cgCwAZ+7dfbF6JaCylqUJtA2NKW
         365keedgF5N2UZ0dbdW829CGyU1bp9d9OS0k+f5uUET6sW+KUWv9nXD2+liHqK2x6gi/
         MS7+eE72Rbg3Fvu/YiJOBQwBcbhleV3P4sSt2wnEEW5UY/ewPbwa7uDp3s81zpZ/Xpw0
         7lGeQQJolsKT5ShorzdJtnNUF+i+5IA5DTkZYq9Zfpc+LDjW9zIWZZxg9k0bGAU3wXok
         Yg6A==
X-Gm-Message-State: APjAAAWNcWOwwkcxoZfZ3zsnf7KL/aq55dIHoFPW/hX61jvAOjEqVEPl
        YI+FPL4oLHHAXhFoexf3WEAhsw/F9f8=
X-Google-Smtp-Source: APXvYqxMM9ncVti286jibunTu9O0WGdNbbb/OnkSgx40uXlVkh17Hh/xbHfEtsjtCZIWRGlHJX3EOQ==
X-Received: by 2002:a1c:7d04:: with SMTP id y4mr7568477wmc.123.1558529386748;
        Wed, 22 May 2019 05:49:46 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id j28sm46714775wrd.64.2019.05.22.05.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 05:49:45 -0700 (PDT)
Date:   Wed, 22 May 2019 14:49:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, jckuo@nvidia.com, talho@nvidia.com,
        josephl@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 08/12] soc/tegra: pmc: allow support for more tegra
 wake models
Message-ID: <20190522124944.GI30938@ulmo>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
 <1558481483-22254-9-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline
In-Reply-To: <1558481483-22254-9-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 04:31:19PM -0700, Sowjanya Komatineni wrote:
> This patch allows to create separate irq_set_wake and irq_set_type
> implementations for different tegra designs PMC that has different
> wake models which require difference wake registers and different
> programming sequence.
>=20
> AOWAKE model support is available for Tegra186 and Tegra194 only
> and it resides within PMC and supports tiered wake architecture.
>=20
> Tegra210 and prior tegra designs uses PMC directly to receive wake
> events and coordinate the wake sequence.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 5648e5c09ef5..f77ce4b827e3 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -235,6 +235,8 @@ struct tegra_pmc_soc {
>  	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
>  				   struct device_node *np,
>  				   bool invert);
> +	int (*pmc_irq_set_wake)(struct irq_data *data, unsigned int on);
> +	int (*pmc_irq_set_type)(struct irq_data *data, unsigned int type);
> =20
>  	const char * const *reset_sources;
>  	unsigned int num_reset_sources;
> @@ -1915,12 +1917,15 @@ static const struct irq_domain_ops tegra_pmc_irq_=
domain_ops =3D {
>  	.alloc =3D tegra_pmc_irq_alloc,
>  };
> =20
> -static int tegra_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
> +static int tegra186_pmc_irq_set_wake(struct irq_data *data, unsigned int=
 on)
>  {
>  	struct tegra_pmc *pmc =3D irq_data_get_irq_chip_data(data);
>  	unsigned int offset, bit;
>  	u32 value;
> =20
> +	if (data->hwirq < 0)
> +		return 0;
> +

This isn't going to work: data->hwirq is unsigned long so it will never
be < 0. Also, why is this necessary? I see that it's there in
tegra_pmc_irq_set_wake(), but I fail to remember why that's there. When
is this ever invalid?

Thierry

>  	offset =3D data->hwirq / 32;
>  	bit =3D data->hwirq % 32;
> =20
> @@ -1943,12 +1948,12 @@ static int tegra_pmc_irq_set_wake(struct irq_data=
 *data, unsigned int on)
>  	return 0;
>  }
> =20
> -static int tegra_pmc_irq_set_type(struct irq_data *data, unsigned int ty=
pe)
> +static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int=
 type)
>  {
>  	struct tegra_pmc *pmc =3D irq_data_get_irq_chip_data(data);
>  	u32 value;
> =20
> -	if (data->hwirq =3D=3D ULONG_MAX)
> +	if (data->hwirq < 0)
>  		return 0;
> =20
>  	value =3D readl(pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
> @@ -1996,8 +2001,10 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pm=
c)
>  	pmc->irq.irq_unmask =3D irq_chip_unmask_parent;
>  	pmc->irq.irq_eoi =3D irq_chip_eoi_parent;
>  	pmc->irq.irq_set_affinity =3D irq_chip_set_affinity_parent;
> -	pmc->irq.irq_set_type =3D tegra_pmc_irq_set_type;
> -	pmc->irq.irq_set_wake =3D tegra_pmc_irq_set_wake;
> +	if (pmc->soc->pmc_irq_set_type)
> +		pmc->irq.irq_set_type =3D pmc->soc->pmc_irq_set_type;
> +	if (pmc->soc->pmc_irq_set_wake)
> +		pmc->irq.irq_set_wake =3D pmc->soc->pmc_irq_set_wake;
> =20
>  	pmc->domain =3D irq_domain_add_hierarchy(parent, 0, 96, pmc->dev->of_no=
de,
>  					       &tegra_pmc_irq_domain_ops, pmc);
> @@ -2670,6 +2677,8 @@ static const struct tegra_pmc_soc tegra186_pmc_soc =
=3D {
>  	.regs =3D &tegra186_pmc_regs,
>  	.init =3D NULL,
>  	.setup_irq_polarity =3D tegra186_pmc_setup_irq_polarity,
> +	.pmc_irq_set_wake =3D tegra186_pmc_irq_set_wake,
> +	.pmc_irq_set_type =3D tegra186_pmc_irq_set_type,
>  	.reset_sources =3D tegra186_reset_sources,
>  	.num_reset_sources =3D ARRAY_SIZE(tegra186_reset_sources),
>  	.reset_levels =3D tegra186_reset_levels,
> @@ -2748,6 +2757,8 @@ static const struct tegra_pmc_soc tegra194_pmc_soc =
=3D {
>  	.regs =3D &tegra186_pmc_regs,
>  	.init =3D NULL,
>  	.setup_irq_polarity =3D tegra186_pmc_setup_irq_polarity,
> +	.pmc_irq_set_wake =3D tegra186_pmc_irq_set_wake,
> +	.pmc_irq_set_type =3D tegra186_pmc_irq_set_type,
>  	.num_wake_events =3D ARRAY_SIZE(tegra194_wake_events),
>  	.wake_events =3D tegra194_wake_events,
>  };
> --=20
> 2.7.4
>=20

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlRWYACgkQ3SOs138+
s6HkiBAAhdT95aojoGVVofzPjlKWofpbrp+5rqG5LnDZ7iadgclc101WMwJcSzrm
2A/5z0nN1QJFY4G0rN7+nOxYw1Cc/B5nGOzZjYDi5Z6bUj0l7dnjU8nizuEY0RuW
HLzQsncWD2HzQAbwXD3DNNcT7tn324PHZB5KMXPsy7F484X3Hq44IU5gDMJYEIXD
Ejn7CgXEd7bMmHS0Hkh5dxFk5jfeIKqjJtyS8fX39/m9it8mva/ctkQNgYi5RJSX
EcSc05JG78ft0d87IhPblahDRV5tjq/2x99LORMpHrmhwtm6X458mAi89ZpyRz+q
0KuK2LtvnRwNYtfFkX2SQ3FXIl6CgoY8LTkT8FUlL52lt/aRCGJqImulyjGmRY46
5Hkso6UtEihTchD/27JaIEFid5nSoycE/ib0HK1V26cloGn/eICNnCnqHrhEszaq
VNIeZ+SkRgCie7emmmhd/YXMj+gwOnNIuSshBkrw2P/84fSy3FCQjg+Fc5VjZT2j
XR1w5SOxnXxmE72EItt7oJsaaluxe1R77edh1LWUuLj24XjYG3lT27FWh2X7E+Hg
zqFIQ89btCRHtozs4ngEsSyXU4+FlZNRIT17bww1sAbFECWst9nagh7nTsz/rFuF
nV0lGoapFYY8Frtt/7pP3vy9wnQ/f4xYzpMFIC6LbSJvk4oQWIU=
=ZN1C
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--
