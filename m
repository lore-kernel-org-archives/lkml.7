Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135FCC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFD1217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gm2KZUeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDKKJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:09:12 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41538 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:09:11 -0400
Received: by mail-vs1-f67.google.com with SMTP id g187so3131320vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gs7gBcEMLxEryOdWjW4Avj2H/SSxPS3pqT1UcEW92yE=;
        b=gm2KZUeJtADpieYoif+/2J1KgmK2pz+gIdDIa9fP6A5IyRoEL2Yqea9k/YfOGlMxHE
         iMzliyzg2R+WT+wED5yH7qzchLZgajiPa9jGCXdBrk1OeMn//SG+XS4Z/DW7WvMoyrox
         acKOIE8ucBgxiJPibWTzBqcETlRi4NwrUiwwC3uB+cj/Sbyn0uLF5KT4T7k4hR6vVh+H
         poRr0wSQOeRvr2ytLTNVEDILmSYrkdCJnSw2VAle2/pl2qybjG5TBT0KCNAK8pE7vYc5
         Z6f4XqWBeJ/dpJ1Fc4SWMFXAX/NnJvk2ODFrEczZaziy0kT7isFRv4KdQafSXLINvwiC
         EPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gs7gBcEMLxEryOdWjW4Avj2H/SSxPS3pqT1UcEW92yE=;
        b=o1mEuN3saiM9zbJvHyGctiXFZOfYDV1uGw/tV/Oxi25khD91jbUrrKo7CdMbPl0Z3r
         GH0ucVQwIDHpH0Nq72Ij5lWlrXh9EYnhL3PEw+9uW/9XyiEauvyBjju9AuKrwB5MUhBB
         8ZBAAWGKq8aVOb9sxUMgAijPZDiv1lI6GrKCi5U4fvFbQuTqDVIZgINmll0oTpnVlRwb
         gKtTZRF9EZsHkgWL1ycE52+1qGJls6rKyM2KEQZn3mUMCsUxp4mSQx/SPL6qgQZoj3XD
         Fv/2P/KyjjiALMshOAe4YQRGagPcF5ljnsUDxAdpz0kQCstfYPvqdzM+X+1Du9tgI/5T
         Gt1A==
X-Gm-Message-State: APjAAAVJfBmkplGV/kp1D0HmGXfRjm4mh+c7EyukAyNL6dwxpzOwLHTi
        S3jBOFRVeSNqngs77QWAkvlEe4rPyfzN0c4rp90HrA==
X-Google-Smtp-Source: APXvYqwQuN/AHAqh0OR30343dE20u2exR4h++hFhQLklyS+VS1V6eM7F/0yyOXtOoFfNvqf+Kl4yB0Kbpo6Lr4gH1oI=
X-Received: by 2002:a67:7c8a:: with SMTP id x132mr26870239vsc.172.1554977350687;
 Thu, 11 Apr 2019 03:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <1554305964-19347-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1554305964-19347-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 12:08:34 +0200
Message-ID: <CAPDyKFpJ6S2oS3Zz+RAwhJG+gdXwwbDUSWTOJdji2wm2AV1Bng@mail.gmail.com>
Subject: Re: [PATCH V3] mmc: tegra: add sdhci tegra suspend and resume
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, anrao@nvidia.com,
        bbiswas@nvidia.com, linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 at 17:39, Sowjanya Komatineni <skomatineni@nvidia.com> wrote:
>
> This patch adds suspend and resume PM ops for tegra SDHCI.
>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 56 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index eafaaefab4a6..5ec304166566 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1611,11 +1611,65 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
>         return 0;
>  }
>

sdhci_suspend_host() exists only if CONFIG_PM is set. Therefore, I
think it's better to add explicit check for that. So add the ifdef
like below, and a corresponding #endif, after the implementation of
sdhci_tegra_resume().

#ifdef CONFIG_PM_SLEEP

> +static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       int ret;
> +
> +       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +               ret = cqhci_suspend(host->mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = sdhci_suspend_host(host);
> +       if (ret) {
> +               cqhci_resume(host->mmc);
> +               return ret;
> +       }
> +
> +       clk_disable_unprepare(pltfm_host->clk);
> +       return 0;
> +}
> +
> +static int __maybe_unused sdhci_tegra_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       int ret;
> +
> +       ret = clk_prepare_enable(pltfm_host->clk);
> +       if (ret)
> +               return ret;
> +
> +       ret = sdhci_resume_host(host);
> +       if (ret)
> +               goto disable_clk;
> +
> +       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +               ret = cqhci_resume(host->mmc);
> +               if (ret)
> +                       goto suspend_host;
> +       }
> +
> +       return 0;
> +
> +suspend_host:
> +       sdhci_suspend_host(host);
> +disable_clk:
> +       clk_disable_unprepare(pltfm_host->clk);
> +       return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(sdhci_tegra_dev_pm_ops, sdhci_tegra_suspend,
> +                        sdhci_tegra_resume);
> +
>  static struct platform_driver sdhci_tegra_driver = {
>         .driver         = {
>                 .name   = "sdhci-tegra",
>                 .of_match_table = sdhci_tegra_dt_match,
> -               .pm     = &sdhci_pltfm_pmops,
> +               .pm     = &sdhci_tegra_dev_pm_ops,
>         },
>         .probe          = sdhci_tegra_probe,
>         .remove         = sdhci_tegra_remove,
> --
> 2.7.4
>

Otherwise this looks good to me.

Kind regards
Uffe
