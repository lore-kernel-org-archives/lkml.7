Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBACC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F77206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWm/ixOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKNLy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:54:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35282 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfKNLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:54:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so5578686wmo.0;
        Thu, 14 Nov 2019 03:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0N4w0ZI5d9d5cBejH4YgMLSblK8CjQsMaOJSPv/SGRQ=;
        b=cWm/ixOUZ68bQ6HtRbhDGgbY9xLbngBYOwgkUvJ7MUOuoaizIz72Ma3rzOphDQ/7h6
         o+kjP2DntKiODXYisTVmHcJ7MNuZkGXXNzs0DwdqNfFmbZE+uXhFmqXy6+Y62pPnEByB
         6/taWUpjpMfyoUif+7FddzNYicfObo5zokrV5RoDHRBDI7QL2BKB7HkxyvYxl+KbYd6j
         lPyDvxMBC+ndlxduzx0kW+tz3Y9GDZ+I2vxLSezRsw9mFFzWSycQxCoy4F609LYcNvuH
         9tckWrlzLUKOcYIVJU68ltX8EwyARxIjUeYGAJXX61ibnn2krxgi/N7I6WGUy65jF2Fm
         XlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0N4w0ZI5d9d5cBejH4YgMLSblK8CjQsMaOJSPv/SGRQ=;
        b=cmyBoGOhaDxTNqazoWaILm0N/VN36Nd4Fl2nxjqJQfFQ9x6GDIJW2hU2w80dLN4UN3
         aoOZFnmEwcWa1PTbRHoj9d7OGjxF1BwyWhnzVEKq/oopA1ChMajRi9NmtmczM94KPTx9
         pWpIoe41a0THI7m+RGzq+b8b6dlwN6PcV2etPgekuKHU+s+IxQkRhW0etlukJMlET/nh
         Cs/zHaWyMnk0EkWpevBRllITZyMhp5Lahp6EQn8wUfBqFMFo2pSL3h8SQSrKuzVQybrp
         dkVAasfbCwei3esoXQyEytWYGVYFIjjJX29vxyy1UHVlR/ArTJQTkOCleGblWr2OISVX
         YaYA==
X-Gm-Message-State: APjAAAUwsQXAN3H0jEesh4hA7iXKVKibaN+F0IX8XQax41aKcqxn6EI6
        qKSyjEsmvqWgLFESTwPenYY=
X-Google-Smtp-Source: APXvYqxVD+PavoTgtgnr/6BOhaMBp5M9rUEekWfpy8YZEg/uBkI+5o9YoBRO4z7lrKkqwx7wJgdsWg==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr7371476wmd.39.1573732466846;
        Thu, 14 Nov 2019 03:54:26 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id v128sm6989934wmb.14.2019.11.14.03.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 03:54:25 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:54:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: tegra: divider: Check UART's divider enable-bit
 state on rate's recalculation
Message-ID: <20191114115424.GB5690@aiwendil>
References: <20191030004813.9187-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20191030004813.9187-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 03:48:13AM +0300, Dmitry Osipenko wrote:
> UART clock is divided using divisor values from DLM/DLL registers when
> enable-bit is unset in clk register and clk's divider configuration isn't
> taken onto account in this case. This doesn't cause any problems, but
> let's add a check for the divider's enable-bit state, for consistency.
>=20
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>=20
> Changelog:
>=20
> v2: In the comment to v1 Peter De Schrijver pointed out that UART's DLM/D=
LL
>     registers configuration is used when enable bit is unset, thus the
>     commit's title and message are changed accordingly.
>=20
>  drivers/clk/tegra/clk-divider.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Stephen, feel free to apply this on top of the Tegra pull requests:

Acked-by: Thierry Reding <treding@nvidia.com>

> diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divi=
der.c
> index e76731fb7d69..f33c19045386 100644
> --- a/drivers/clk/tegra/clk-divider.c
> +++ b/drivers/clk/tegra/clk-divider.c
> @@ -40,8 +40,13 @@ static unsigned long clk_frac_div_recalc_rate(struct c=
lk_hw *hw,
>  	int div, mul;
>  	u64 rate =3D parent_rate;
> =20
> -	reg =3D readl_relaxed(divider->reg) >> divider->shift;
> -	div =3D reg & div_mask(divider);
> +	reg =3D readl_relaxed(divider->reg);
> +
> +	if ((divider->flags & TEGRA_DIVIDER_UART) &&
> +	    !(reg & PERIPH_CLK_UART_DIV_ENB))
> +		return rate;
> +
> +	div =3D (reg >> divider->shift) & div_mask(divider);
> =20
>  	mul =3D get_mul(divider);
>  	div +=3D mul;
> --=20
> 2.23.0
>=20

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3NQHAACgkQ3SOs138+
s6HdixAAl5ejIwhvheyL/qCf0ZUiB15Q+IG8wHI93w7Rw9zWlCXitzl7ST4MQSwS
n3rUZWw3wymfL0Oybfoz1Yv7B1Ei7hoQBRPtIP2r6yMqgLQv+0wCOtjlZr3jWKKI
k3Ik4MHg3VN9WDEukbd1E8VCFEzUaWwFVVuX4XJzDuuPAWIrtHmLq/zg4y7mWyt3
qKnS/JFhJJWWPotHklgj8yYlNrWpgkWRwlyIHmrMtB+mpFyLJKPvN8v8skIBfA5F
Dkp7kTxrff3cOdoHLze/MmlMOqJMKC0aIKhKFdU00cMi/g0BTHOFd446ydj1u46V
3d7H9PdM4MV9tdJNLOjZ7fooZMw8vB2dvEshow5O57Ko88yK0ogl9P7uVCPVb6Dx
sBVMCmiO6owglBtxWfh7SukaiJCc5S9czdaiPKmi3DRo0YOwP1rRqdQXVCOSsFDV
4CIESHrk2/2d6eNf87xvuDsFiiGvKrKjBgPDCKVj73/4clgmDA44r66U8JyFgoOn
HthcN5IJvyAh5+5Q7vn+ovAnR/yT6NWR9h+21sXA+rpaM/yeyoUZJRhFoQWvyj19
QMTiZuKBtfbYUuL0/w4u0At66kud3TzMuGw2bIamY3CdOzDrEUS66XjuM9urpn2B
lBWDc32/JLzi8lhfHIv8D0EesNsHGQLHgRUUDMQBojqPEMECj30=
=2lWh
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
