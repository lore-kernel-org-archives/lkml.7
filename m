Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F247EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9892075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiQJAPtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbfDBO7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:59:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37767 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfDBO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:59:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so4138474wmf.2;
        Tue, 02 Apr 2019 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F71NeLTn4cM5gBZUdRYa0Si7uaR37Qo+GO8j/lKHfXA=;
        b=uiQJAPtzOLJKzzbLHhL1c3ZVayjLgplxvWP4YnriPk+onDAbj1TYQTF/55BNqLO/YQ
         ZXGqBGMp02U78Q5shkUpfEmWwbm4As4L+Kx1Vrv8Uh7zl97E6WSc1CiU/d6VM4Tf8rMQ
         WoiMj9Q9ZSgH254ocEIN+rNWP7QWch06b/h8peM1hBvE6lSy3Slvku6HLNtMUJtJ3h7B
         j4mi4JfMx6tKEDLvmVHaL6u33w9NFLMod0RFceCnvaUZ5PFFuNT0b/4fXfNCH2FVNGP6
         yRPZxSv/AZv6MlNBVtOIdo0qGG60PgVarUlKu5ua6A4gdExskuRWy1joHLKQZbq3JlFJ
         JCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F71NeLTn4cM5gBZUdRYa0Si7uaR37Qo+GO8j/lKHfXA=;
        b=Q1fQHH87PfenPz7wegivRXdmPN7fFi4kcS+G1r3RJdJhV/OFwHCe3kMHF9j856+GFM
         YSHSi6tpdphn85yvlu825z3fAmAwwNIQvBdyC0sR5wt0+2F5ET+lBPbUcPpu/PnUSoL7
         MvcWVPXCfS6/lWW7lK+Nlfw75AOApn55Kog46gnXc38Asd/Zm3o32QuSxykFSNK4z2vL
         jAmFsYgNxUVwo49odYOD41KGPT2K+vpkfeHa+E9Z4qTu1fiYxqiAjykUme+METBcqMcM
         SjZNGa5/iBVNdl3f2cztj3ialRQ25VS6w75EXknnWM1SCpuGOViMmbR9b7Y7DgMCsD7S
         XUrw==
X-Gm-Message-State: APjAAAWUCO/6n5z/3NXcXYpLmIHDMzpq65gnaNBiOUANv9cQ4KlLhhli
        vPl+DORh01HyrH5bnw5URs8=
X-Google-Smtp-Source: APXvYqzbCQqZWcRqAAg4U/d4wh0UedIpOqe9RjA6zfSGbOaZStdujXHG5xvc0WGXJDz7OK5Q0GdHag==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr3127584wmi.1.1554217143158;
        Tue, 02 Apr 2019 07:59:03 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id i28sm40326686wrc.32.2019.04.02.07.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 07:59:02 -0700 (PDT)
Date:   Tue, 2 Apr 2019 16:59:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, anrao@nvidia.com, talho@nvidia.com,
        bbiswas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V1] mmc: tegra: add sdhci tegra suspend and resume
Message-ID: <20190402145901.GF8017@ulmo>
References: <1554182853-31612-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <1554182853-31612-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 10:27:33PM -0700, Sowjanya Komatineni wrote:
> This patch adds suspend and resume PM ops for tegra SDHCI.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 45 ++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index eafaaefab4a6..68263ea4a93e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1611,11 +1611,54 @@ static int sdhci_tegra_remove(struct platform_dev=
ice *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM_SLEEP
> +static int sdhci_tegra_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	int ret;
> +
> +	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +		ret =3D cqhci_suspend(host->mmc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D sdhci_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	return 0;
> +}
> +
> +static int sdhci_tegra_resume(struct device *dev)
> +{
> +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	int ret;
> +
> +	clk_prepare_enable(pltfm_host->clk);

You need to check this for errors here.

> +
> +	ret =3D sdhci_resume_host(host);
> +	if (ret)
> +		return ret;

And clk_disable_unprepare() in case of failure.

> +
> +	if (host->mmc->caps2 & MMC_CAP2_CQE)
> +		return cqhci_resume(host->mmc);

Same here. Also make sure to sdhci_suspend_host() if cqhci_resume()
fails. It's probably best to have a standard error cleanup path for
this.

Thierry

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyjeLMACgkQ3SOs138+
s6ENvA/+LkCvdh3owTukZ+MogvqrxofbtGNH4nHaaXtN/Jew7QYNGL/5Hr3l9hHt
4TboAQ+J9Fyx/uwLa6wVp/rSInwZFnfkzDYfJEyJHE6ev8eTLkzEAPaEQ+lY0Fn8
Vq0Sg7Z4PaJKf8flwNBeT3OCXgEUaUowO/udTPlRGHiA04RZSRXF3s4d/lr8oWpw
FDVu/bCDQWJSrElVY5mkAyScUw2OkJpiNsVC/hClOwXPfvbsCzpdjdiOl9yeGgDp
Q/f+ZQhyGr+CxW9LxzJYy085Yl3S/02gcABoFF1GB+U7qnLY24ND2UbrcdM2j0kG
h8mQ02gMghii88fsqUjGP00D4hXpccRzGVEiVbtvhSjN+BZRPoVvbrebmKH6CETV
GVqA8Yi/2mKDSgsFYYk8wzbK0UBYgCOnx2Y6JU4w0kV+0G2GEdgupUy6hoPBLcMC
U791byj7Uwwknn1QZE2a/psx5n8p4BJlRJMRn1b2gdCmnQCNsQNx6ACKYRfn5nMX
rv9Mo/v+LE95uSHM9mODCDoRyOYC9rEVZsEYyL1Cd6OuSGH4cjxPOObmRAq6Gf7N
B8c3/PYIc160+leRIz/0INofaVORMU/4ppGdCKFOZ88tagzSY+3AcZFMLzmw76kz
TbxGonOnuTsfkpUkAkdw/YsdasOH5dS/YdKTrROp7BVBqZ0LpoE=
=3vRk
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
