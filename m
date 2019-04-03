Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E66C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C24206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFH1d6N/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfDCIt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:49:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43112 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDCIt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:49:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so20154341wrx.10;
        Wed, 03 Apr 2019 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lI8CZHlJwwNjKjJV8h8Paz9JeF+xKmqhh6HvJtEFESI=;
        b=lFH1d6N/ffRTt1ZzUTh43q/D+ivWxHenZX9otUgk7hl1cK+R+r49+kLtmirDxypim8
         bdDAhwv0Y7cIH6I9+mjiLz9mBDuOra82K5qF670dOrtxiIDnn6mlNQ2pc8IRF1gXU9pI
         ooIvBMHIHZthpfTZqpjcLP/RTt9KslUIW7KxJJKwBcuXxt3gS23Ph/llsIe7oIhEk0l/
         jnR8q8GkB7W6wvYzCv4Ex59nB6eYEGDhzBqIBPDigqJSJhc+gnLoIox6/inBhpOieUku
         7pEF/NKchHWQihOB4Kt/mdqsiZSBdLTJIuYeXrW0T7pE1ak/z5y+SeqciS7CWHw1IrD0
         kt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lI8CZHlJwwNjKjJV8h8Paz9JeF+xKmqhh6HvJtEFESI=;
        b=t1xH4/Yv9e46S6A2fpid1kecVB16AT5Db7OapGOrjBGtJw1rsbval6ZHku5uEme7xS
         Kpty+XUb5FTntpyBNgK9e6qiNPqbBo1dZ8v0+Rf33xcJAE5xCa+arupGuJFRXs6UqAeM
         Zw7/SVp52AJwvHm/FsOzEvj/0RSd8L3A7cBPFu6gJ+MnnfSLEb3+nF7nCyObdQpWfuZs
         MUV5B6HOw1n9AcXORYhEWOHcY8UYHCOdsgqI+61rHJt4kQZDclzpT8WVx0av9BLtGE9l
         4m7dzxJXE2VdxfGsOqC4kHk+WHYB2y4awBZKqtqOZhIUlrmSbWj29rWwfHhJKfbZxCc2
         vusQ==
X-Gm-Message-State: APjAAAVpQtfTok41v9zWsc5FME4P3SawW68ghhFw35JWhk42Oya0BXUC
        0Oum4+y18sHYXHQgYhs98ZA=
X-Google-Smtp-Source: APXvYqwx0IWHK9AXmd7Q+fUuuri06cG4izA6TD/esaHdfdtXIEMzMbG2IV91pe0utnVfUkvSfzSeLg==
X-Received: by 2002:adf:eb0b:: with SMTP id s11mr25430736wrn.140.1554281364263;
        Wed, 03 Apr 2019 01:49:24 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id x5sm24248672wmi.37.2019.04.03.01.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:49:23 -0700 (PDT)
Date:   Wed, 3 Apr 2019 10:49:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, anrao@nvidia.com, talho@nvidia.com,
        bbiswas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V2] mmc: tegra: add sdhci tegra suspend and resume
Message-ID: <20190403084922.GE5238@ulmo>
References: <1554226641-22612-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <1554226641-22612-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 10:37:21AM -0700, Sowjanya Komatineni wrote:
> This patch adds suspend and resume PM ops for tegra SDHCI.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 56 ++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index eafaaefab4a6..6c91926a012c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1611,11 +1611,65 @@ static int sdhci_tegra_remove(struct platform_dev=
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

I didn't spot this earlier, but I think we'd need cqhci_resume() here in
case of failure.

With that fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykc5IACgkQ3SOs138+
s6EszQ//TkWf17Qu1wTq8l/vUCpn4kks/qsOMfrv83+b38TJwqGCem6T1Q8fEqj5
WiDAd29Vqv8UFvmHLqsGG+wgik9wgJn5kWXvwgachk0eN5nvx7F3NqyB9f+pCng9
ODq3JE5k01716y3t7iIBpXiYrENk9qdwZYlKYtCFY7cQxGvJJeHyXXwRj4tuM39f
qyOU2EU+zkf+rjhSLKdJNwKz4MIJ63NAdwz6q4TKgf/aip8RWa2FNtxcpXNVyAcq
Y8UubY2PWt/wqm9RF+B7G800W6wrsXUH6anDm2bs9hX2KHfgTyblQVarwV5s+1X8
X9eAIV8rk5BuznqLd2QD+5grOPa8lhmZd76vJDUIvrU2gIJl0eVB40CY/j1olgdU
fIpAC4Py1TNF4qMXbvKJoJXY9fxOUuFeMHwDOjeRqTA6ZzTAao8wXPPWf+I1v+LH
Z/cgkGR2Cuu55TP5cWMzwaOMaAlOitke2pCqBbbRVmwIEvh/gmhtWSsPHSqZHnH2
9ac6O+VZ4Spz6BqXBCc7Mn94jBB1As/GvgZG7t5Qxxf4HdzXDmkI+so8dlW7JUZn
lKgOJi/iGwVO2k+P/IFfDSo/kVTRY1kYDxX2kfB0tTe0Z1bDqj4kbgaNN8KsbyyQ
YGS9VWA0TGVArpM9o5J21P6NjCXFJ5SHfsJaoC8u/vbR4SGpecQ=
=J/FS
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
