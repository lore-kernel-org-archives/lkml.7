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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E278C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A05206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbvRzCkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfDZPUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:20:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34413 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfDZPUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:20:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16so2560783wrp.1;
        Fri, 26 Apr 2019 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZUJIfk6tIO/ooOJ38g2hyXFqbYbzxSiXTLjARv0MeYo=;
        b=fbvRzCkruAQK1F7RTyBAo8fybIK74c/ou5QOQjn8Pv/BHezuFgVOTlckLpGHaA8oYs
         GjD6pRzSzYoO3tz6zk6c6Mw8yFrCcPkse2ZumUhVFWsOw3IXrogLgavptq0Rei1Hx490
         sKSe+yCn+k/oKtlATWbuVuFwkNPGVoG8g0oyJy5Cz2VoKup1PTfkaTwpcrQxo9H0aSWt
         zbLutsn9EAvaxLvB9SB9qNdEmmiGRHm5halL7Ujz7SdxRJhfsz3f7zttPpKTDVhhiRvi
         S72jaCgDz+WLX/wY34KyDzstTpPXzYGILSQFi++BIFK5m5Jm1M28e0DV3CKmUC13OOR8
         xfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZUJIfk6tIO/ooOJ38g2hyXFqbYbzxSiXTLjARv0MeYo=;
        b=VO8yicXBr6J/N7pm8NIS6ldljb3Eax16yBrUxc/rUYmWAhXW4VUvufH6Rl4gMKjAtr
         hxus+VzSNE2M41Gswws7JSQOvFV1/kAkiWjWzg9cm1IHmqumFPn5qcUFdXz8wLFqG1bK
         1t1CT1Gs9A6dQudW6KceOjR04M7B4BiQj/PC9cSmRFaUd+7jDOSihO/l4uaMQcaoEcLD
         a66GFkbLnRgK2vm7pNrzQk6pwsXkVneMqh9fYU9tSnVGWZuENhv0Zvp17eAVwxQlTdTS
         +jDBvn37UfI7R2ZeDA8QLi2DDD5bfEgWVDt3oyfzyCIl++T3GVI7KIDB1BKyG6DLU0rF
         BBog==
X-Gm-Message-State: APjAAAVMMIsWeIdjfQkXzzJCIQnJ1MgydccFDg0GfMgo5K27BJDmpT6y
        /fW83oO9aZqVR02Dx0DJyFQ=
X-Google-Smtp-Source: APXvYqwJoXk24TG6HWWk1fWXSqjQKSHV6tThrIu2paS6K2gyZv6qR5snko5gdDAplMaOSsMr5gwi2w==
X-Received: by 2002:adf:eb52:: with SMTP id u18mr6795251wrn.10.1556292035460;
        Fri, 26 Apr 2019 08:20:35 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id g185sm12954921wmf.30.2019.04.26.08.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:20:34 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:20:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] amba: tegra-ahb: mark PM functions as __maybe_unused
Message-ID: <20190426152033.GB19559@ulmo>
References: <20190426145617.2342824-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20190426145617.2342824-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 04:56:03PM +0200, Arnd Bergmann wrote:
> clang warns about an unused variable when CONFIG_PM is disabled,
> since it is only referenced from an #ifdef:
>=20
> drivers/amba/tegra-ahb.c:97:18: error: variable 'tegra_ahb_gizmo' is not =
needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
>=20
> Rather than trying to get the #ifdef right, remove it and
> use __maybe_unused here, which is less error prone.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/amba/tegra-ahb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Shouldn't tegra_ahb_gizmo have the same annotation, then? I do see that
it's "used" in tegra_ahb_probe() as part of an ARRAY_SIZE() expression,
but that technically doesn't mean that it would need to be emitted, but
it might be enough to shut up clang?

Or does the __maybe_unused not get propagated?

Looking at the code, I guess we could save a bit of memory if we didn't
allocate memory for the zero-length "ctx" array for !PM since that's no
longer needed. But then again, we've recently changed 32-bit Tegra to
forcefully enable PM, just like we did for 64-bit Tegra, so that's moot
anyway.

Do you want me to pick this up, or would you rather stash it into ARM
SoC directly? If the latter:

Acked-by: Thierry Reding <treding@nvidia.com>

> diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
> index b0b688c481e8..3751d811be39 100644
> --- a/drivers/amba/tegra-ahb.c
> +++ b/drivers/amba/tegra-ahb.c
> @@ -170,8 +170,7 @@ int tegra_ahb_enable_smmu(struct device_node *dn)
>  EXPORT_SYMBOL(tegra_ahb_enable_smmu);
>  #endif
> =20
> -#ifdef CONFIG_PM
> -static int tegra_ahb_suspend(struct device *dev)
> +static int __maybe_unused tegra_ahb_suspend(struct device *dev)
>  {
>  	int i;
>  	struct tegra_ahb *ahb =3D dev_get_drvdata(dev);
> @@ -181,7 +180,7 @@ static int tegra_ahb_suspend(struct device *dev)
>  	return 0;
>  }
> =20
> -static int tegra_ahb_resume(struct device *dev)
> +static int __maybe_unused tegra_ahb_resume(struct device *dev)
>  {
>  	int i;
>  	struct tegra_ahb *ahb =3D dev_get_drvdata(dev);
> @@ -190,7 +189,6 @@ static int tegra_ahb_resume(struct device *dev)
>  		gizmo_writel(ahb, ahb->ctx[i], tegra_ahb_gizmo[i]);
>  	return 0;
>  }
> -#endif
> =20
>  static UNIVERSAL_DEV_PM_OPS(tegra_ahb_pm,
>  			    tegra_ahb_suspend,
> --=20
> 2.20.0
>=20

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzDIcEACgkQ3SOs138+
s6Ft6A//b0cxvRY6nJ9Yet6Wg/uddl2eSzPlON4FpiwM+h+j1a0NKr3DkrMhzAe7
wUMCnuIej+9XHDhTnZKere+C8MBWOkAJVVtaUKG57PXLIz8kn6bdpExhyon2M868
xl2iWRVObyFf8mdJiqx0LQ0gLNgWTEoLojXi6p+9wF3MwmGwoJhSsNjgOkPmfDCb
fccwgyBcMGKOei9gkiZKBQcgb4NTQNEJeR38FXFskoU2Rv6LvyE4e1riSh9BQ3hR
wjMhJLqVYwGBnGLJAc6rhoxhJa9eiUbn8cwgsVNwc5B+agUuM/RGPx5+dHPjjbso
Cl/BTerUwpW0uG4Fp01kyBIr7DvJHqZxND93c8lNktuaq3u/ADhaeKjUz5qi88jG
TJhnJ5gYPd92wpqGOUsqE1IiZGcq/rLx+mxGAxhVYsE0cCGJYj+WLGadi+GiVpca
/z7I5+NwTDcRszm/KuyOsCRMo1l7jp+tdueJHl12UtmyAt87CR9QaXyzqor38Sdc
dcvXnA0M/5fzDwaN4O1HzMLl9rlP8bXnvCtBnZll/x8VjRB01GxQPdoBPuC4ogxb
fljEbTg9FjW7Ib1530KlCAqQ+U+Oas87hk0R7m3MjcYCWi7tAAj+oWWzGoSPI78o
3bdELnmBOj8J3f8x77llHPAb/GNZoQK4Rwt702PmGIr1Tstf8/U=
=xwIS
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
