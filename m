Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9635C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6ECE2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1dx55p5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfDOKHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:07:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42925 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfDOKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:07:12 -0400
Received: by mail-vs1-f66.google.com with SMTP id f15so9104441vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+b8MPPNm00IZ9FaojShqmzrNV/w6KAgWlTEURGTqJg=;
        b=S1dx55p5Te1TsHnTsTn2qLaXahkNmbgyjFtnQun6Yt+iv5rsmy99k1waNvXngeysub
         Y+L5rysST9pI+4Zi+PGIE2ogNqwXi2Cw+51AinpWWvCJCdlSdSkt+QRfr6NG1XdVE9nC
         2rdsyuXzfz5+LEBEIQwEkuT/AolNV1KZQVrbXC9pgCM4KDhMo7oguJ4B8iT6WC3nd+xo
         UFAvWO00sEO8WP+bp+ersDvbimBaYmYZvuZeK9qGMZDmlFdIn074NqhvcPI+Kz/1eR2Q
         v5+DmOzqrsEdaXEfL46b+RWRSuGbVs7A3eU1sNxSlh3Bq2XBInecUdUBLtZJeimZW9MC
         lFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+b8MPPNm00IZ9FaojShqmzrNV/w6KAgWlTEURGTqJg=;
        b=HTS9zxzytT43lCxEqrtFIEmrIkYQIkuWk1tPp6Rb8TayxbmFa3k5DA/5mZer0aZK5J
         5gcYEsPKyJnJx+VA6Xt+irO+dk1OZp8kzXz5G4tASL5epncSkiYylUgV4xOHr5SBHv8N
         Mp8bQ0jMg55cepwJZxRNAIIvosbAnTwcOMnFVseG471t+ktJ75zwAwixJI03aHgrABtN
         RhwmcBG2jHYMV1j2NLMwc+omXjIxG7WqmcQPlGMUTAXkegFCw8towvgHn6YEWRTnHldp
         8vl9xleceAGts2a0DvTbbHrsSPg2q8NyQVhQZdEY4pK1Tcwh3JMmZQx+1Upzq37GqyR0
         OLdw==
X-Gm-Message-State: APjAAAXO5qNK8McZW//q1GSSVO0Lh097vhoJyk5khKfvq5jTzAxx0d/h
        OM5tTkUX4nGSNFBi8US9dBohQJZE/r3xf28lRw7niQ==
X-Google-Smtp-Source: APXvYqykItCS9N7dP8mJi13zV9/v0yBM5NvTt4OKgJs9e67gYXxke6ppM8hKMO1HQo/upTJH1+CL7rLvOP+RWCI3Tas=
X-Received: by 2002:a67:fa04:: with SMTP id i4mr40045545vsq.18.1555322831388;
 Mon, 15 Apr 2019 03:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <1555010299-19141-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1555010299-19141-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Apr 2019 12:06:33 +0200
Message-ID: <CAPDyKFo+jwFJQUtTRnejX7CzJEOmfpYwX5ZwnMNHPK=wfW-Ycg@mail.gmail.com>
Subject: Re: [PATCH V4] mmc: tegra: add sdhci tegra suspend and resume
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>, bbiswas@nvidia.com,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 at 21:18, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> This patch adds suspend and resume PM ops for tegra SDHCI.
>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 58 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index eafaaefab4a6..f608417ae967 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1611,11 +1611,67 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
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
> +#endif
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
