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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0005C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0BD206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6jtZn72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfDBQsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:48:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35070 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfDBQsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:48:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so17582026wrp.2;
        Tue, 02 Apr 2019 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PUIoCQVKdjTUFP7ZWMir+oP7cNqt/IuMtgoa7jzPuhk=;
        b=S6jtZn72te1UKp/M5qkavabjKeW4iZOlPnYBi0iR+p0XrTHcSXeLTZLTtvR7JnvGnl
         2vrK2REUz4d4Y5CDG6vCjen/yVkhM8TSiQm+ItO5R9ZPZq9sH20vo9TOMWlSPeZvQt2P
         Q6mYsLtBuHIeb3JS3Xl+/7O7R/lvPc18sWUs+++ns8hZVinjwMx3y4zGTTOf4gvVOUZ4
         2KSwCAsFDJWaNcMskcKAKcTny/ThqhfftabAqQpMbE/zECQ6SOlPo7ir9AFI672U6adG
         o6uABhnn2mQgQXj8cVTGXCrHJzh3hWMpw8EKQPBQSRt3luS61lvXxceaCIiRjM+a4bA6
         uMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUIoCQVKdjTUFP7ZWMir+oP7cNqt/IuMtgoa7jzPuhk=;
        b=nebTMDY0O3eQWST7QEz+lmzzpEjO+x7vBxnZstNpPE4e7jh2pa2FYZn5qisdfSPmUZ
         4/uCcEnA3KJH2FxdWVsKCA/nWHiZgS1sfAN1mbh1W3IilsJqNarN7FWVMXQMJSDt1Tr1
         TtOUB56o6B7K/1YSFiqz63a7lLr+YS/Kda9PXdmucBcDmjQoTpzG4eGzOXmLdVoWmSaC
         TsPBkSQxcEJU2Vc10YWpow9Sn2giGHZlS4uYmuUKfGwvO5SVGdgJuBgdz3/gIK/drv71
         dBjNJr1BeH/wtx2ESwnZTclini5e3TV6+yI3EZeAPVVRWkRWpSeIAQNukyLTG8yRbChT
         uW7w==
X-Gm-Message-State: APjAAAXbYJPV7EA0rpdhPYsBJkB6LuoFdHIy8iuhdOePcO5XXR/2STPb
        LyEnDwgxhPgBKtNP8AL/8s8=
X-Google-Smtp-Source: APXvYqyEyYgtSRx+3OQCVxba0ln5QlpfRYV8LQzJAs2NuPqkveMfl9oPCxBewGCzHhber641Iex78Q==
X-Received: by 2002:adf:c002:: with SMTP id z2mr47889247wre.177.1554223684167;
        Tue, 02 Apr 2019 09:48:04 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id c16sm12584850wme.31.2019.04.02.09.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 09:48:03 -0700 (PDT)
Date:   Tue, 2 Apr 2019 18:48:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH V1] mmc: tegra: add sdhci tegra suspend and resume
Message-ID: <20190402164802.GA7797@ulmo>
References: <1554182853-31612-1-git-send-email-skomatineni@nvidia.com>
 <20190402145901.GF8017@ulmo>
 <BYAPR12MB3398861980C3F967CD209393C2560@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398861980C3F967CD209393C2560@BYAPR12MB3398.namprd12.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 04:41:18PM +0000, Sowjanya Komatineni wrote:
> > On Mon, Apr 01, 2019 at 10:27:33PM -0700, Sowjanya Komatineni wrote:
> > > This patch adds suspend and resume PM ops for tegra SDHCI.
> > >=20
> > > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > > ---
> > >  drivers/mmc/host/sdhci-tegra.c | 45=20
> > > +++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 44 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c=20
> > > b/drivers/mmc/host/sdhci-tegra.c index eafaaefab4a6..68263ea4a93e=20
> > > 100644
> > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > @@ -1611,11 +1611,54 @@ static int sdhci_tegra_remove(struct platform=
_device *pdev)
> > >  	return 0;
> > >  }
> > > =20
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int sdhci_tegra_suspend(struct device *dev) {
> > > +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> > > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > > +	int ret;
> > > +
> > > +	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> > > +		ret =3D cqhci_suspend(host->mmc);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	ret =3D sdhci_suspend_host(host);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	clk_disable_unprepare(pltfm_host->clk);
> > > +	return 0;
> > > +}
> > > +
> > > +static int sdhci_tegra_resume(struct device *dev) {
> > > +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> > > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > > +	int ret;
> > > +
> > > +	clk_prepare_enable(pltfm_host->clk);
> >
> > You need to check this for errors here.
> >
> > > +
> > > +	ret =3D sdhci_resume_host(host);
> > > +	if (ret)
> > > +		return ret;
> >
> > And clk_disable_unprepare() in case of failure.
> >
> > > +
> > > +	if (host->mmc->caps2 & MMC_CAP2_CQE)
> > > +		return cqhci_resume(host->mmc);
> >
> > Same here. Also make sure to sdhci_suspend_host() if cqhci_resume() fai=
ls. It's probably best to have a standard error cleanup path for this.
> >
> > Thierry
>=20
> Thanks Thierry. Will add error check and cleanup for clock and sdhci_resu=
me_host.
> Regarding, cqhci_resume always returns 0. Infact, it does nothing as resu=
me happens on first cqhci_request.
> Since helper functions exists in cqhci driver, was using it for explicit =
resume call.

Yeah, I think it's good to use it. And I think it's also the safest
option to handle errors from it properly because somebody may eventually
add code to it that can fail. If we properly handle errors we'll be
prepared for when that happens.

Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyjkj0ACgkQ3SOs138+
s6EwEBAAhV3DcxKntQenphq/Inls3vasqeZSK1NBBoE+Ym+CZhO2v6+TGJOuEaxu
RfoeodVB/6jasOplTv7EiBbxEuEdj4xzcSi2jVQnv6m4nQaflMpguvHbPd9M1TGO
x/QMYxI2sBctVLjq8eiTBTbuclJki9M16Y4tlVXcgjFtgBb6Dyb7QJ86+PKOFazA
56v/S7yY4++hcqHI0F1+fovDxNdgzQF5fUNi7CMWQA5q82qOw98mnZf3dm4H84ba
ftjKD0gDJst+f0N7AipcXTEACGgD4Y+aOFs5jnmj0rAw14CfTi31GzPFNlCKq1Hp
VlTSVQQOisdEI3nlalaf0b9IAn1kyarPqCgPQLPHm0/TiaZ7qp5o7bf1Eh7v29zC
KSUNCjtKVh7bOzQJxPkPLFDjOVf8ocvYWXkGr33I1bF3aBlHYBUzS+9RRegwNed7
ZH7t2LuKMHCprQ9hH30xDVKOrZCxT4GgIYYc+1lSrVFrsSeuHlMgOrwokJ3qwF4p
mACxduNPyOClRJZQKksvqThgtg3aW9NxQaP/x2G5yCNihU9xk0zgrzz3HT542o0K
Vl/cwKHcMaDRFJLQSWDOa7ZOJ6kc/baI3Vs4//3zaF5C24Y8exTGVdjGky0+LDJ8
QmDJSEwKmYcW2tyXbs1yyZ+3W2T8X5my4SMhOEW11j5H9qvKSE0=
=uStW
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
