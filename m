Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E9C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2185C204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZiBBdb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395161AbfHBPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:16:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41773 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729945AbfHBPQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:16:48 -0400
Received: by mail-ua1-f66.google.com with SMTP id 34so29808059uar.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibE55GDU+SxEkKvtlHBsrRqPQaV4WJm8A3ik/UgIVGc=;
        b=rZiBBdb/2E6Ta8tCVL9hDihq2rRZlTv1MM9xG+XBsJIjay2b5Oa+Z+pzilE0JcExPs
         uO9yNEFq0b+CXd1MEaMVB9sojW9W9fltrhV2de9/cTYEm+rNDn6B/VbP4wq/te7nzGJ8
         oTDHSjna8klMSGgonj8bU0Pbv6Qnp82M55I8+GGREvsBhOyJN6/iY11z2SPczevj6Zmx
         4J4DYHOFterztoDSw09wfhO3ATh9znPmOTVBficZWViC3ZdWcH2zpU7xXweRSDgrLxjs
         l8vSwVOVOmvUopLCFOZ/3bNiuhDRfV6XgCJ4iu3kFuWnR1aGGFYR+nNIgIBtdrYBBh9/
         FbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibE55GDU+SxEkKvtlHBsrRqPQaV4WJm8A3ik/UgIVGc=;
        b=AxHrJfiCs1GWaTVfMcKiSK7VCkwnmaucK3f/VEwkBbdXZ5fHRLvBbaOk/YI2h36KTJ
         nxjFIc0K5+OGA1nWpHEHC52yqFJQ50I1ru01hN7CgCGo6VuJAXcCJ0i1R9KLwSCoZYpG
         k5gDjQCnfulyIR5kbtaz/XXzjipVgoYptJu+05ibGWSCqKX7HHib5eZaZSJ8itKyFnCm
         pEcz6tlyi9NmaettG1jHNp0SoqMyXewymRfNNw+k7xN1qHikRDuR1xnAsVHKMFV7E72u
         g/nvfnLhMnAi3jnP4pIvPkye3zI9cuGgegjAywuPmIYg35LsCcz4RAjPg6S7dUSqnOWI
         a/Aw==
X-Gm-Message-State: APjAAAUdtatPgFxuK2+DMJ1rPucS3ZQ8EulBynwVpWPKEilBAvbOGn27
        /Att1AlNxuMMLoiVxI/QxQqgUDFDLeozA4R7ascczg==
X-Google-Smtp-Source: APXvYqxpsVToQ4BqlxQUMtlFn0CtpTI58hDhBgXctUiO7lD3N7RTazeWbU1axOrRVo/ImsBu2Y3ji5H4cR/ZOSwyoig=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr4058265uad.15.1564759007060;
 Fri, 02 Aug 2019 08:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-30-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-30-swboyd@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Aug 2019 17:16:10 +0200
Message-ID: <CAPDyKFpgMioHCLbwJ7+koZw13UqXTEXE+cnO8+AeT2s-nj-OTQ@mail.gmail.com>
Subject: Re: [PATCH v6 29/57] mmc: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 at 20:16, Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Please apply directly to subsystem trees
>
>  drivers/mmc/host/bcm2835.c       | 1 -
>  drivers/mmc/host/jz4740_mmc.c    | 1 -
>  drivers/mmc/host/meson-gx-mmc.c  | 1 -
>  drivers/mmc/host/mxcmmc.c        | 4 +---
>  drivers/mmc/host/s3cmci.c        | 1 -
>  drivers/mmc/host/sdhci-msm.c     | 2 --
>  drivers/mmc/host/sdhci-pltfm.c   | 1 -
>  drivers/mmc/host/sdhci-s3c.c     | 4 +---
>  drivers/mmc/host/sdhci_f_sdh30.c | 4 +---
>  drivers/mmc/host/uniphier-sd.c   | 4 +---
>  10 files changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 7e0d3a49c06d..e1b7757c48fe 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1409,7 +1409,6 @@ static int bcm2835_probe(struct platform_device *pdev)
>
>         host->irq = platform_get_irq(pdev, 0);
>         if (host->irq <= 0) {
> -               dev_err(dev, "get IRQ failed\n");
>                 ret = -EINVAL;
>                 goto err;
>         }
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index ffdbfaadd3f2..672708543a11 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -969,7 +969,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>         host->irq = platform_get_irq(pdev, 0);
>         if (host->irq < 0) {
>                 ret = host->irq;
> -               dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
>                 goto err_free_host;
>         }
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 037311db3551..e712315c7e8d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1091,7 +1091,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
>
>         host->irq = platform_get_irq(pdev, 0);
>         if (host->irq <= 0) {
> -               dev_err(&pdev->dev, "failed to get interrupt resource.\n");
>                 ret = -EINVAL;
>                 goto free_host;
>         }
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 750604f7fac9..011b59a3602e 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1010,10 +1010,8 @@ static int mxcmci_probe(struct platform_device *pdev)
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
> +       if (irq < 0)
>                 return irq;
> -       }
>
>         mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
>         if (!mmc)
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index ccc5f095775f..bce9c33bc4b5 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1614,7 +1614,6 @@ static int s3cmci_probe(struct platform_device *pdev)
>
>         host->irq = platform_get_irq(pdev, 0);
>         if (host->irq <= 0) {
> -               dev_err(&pdev->dev, "failed to get interrupt resource.\n");
>                 ret = -EINVAL;
>                 goto probe_iounmap;
>         }
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 9cf14b359c14..b75c82d8d6c1 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1917,8 +1917,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         /* Setup IRQ for handling power/voltage tasks with PMIC */
>         msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
>         if (msm_host->pwr_irq < 0) {
> -               dev_err(&pdev->dev, "Get pwr_irq failed (%d)\n",
> -                       msm_host->pwr_irq);
>                 ret = msm_host->pwr_irq;
>                 goto clk_disable;
>         }
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index d268b3b8850a..caf0ad5de604 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -131,7 +131,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0) {
> -               dev_err(&pdev->dev, "failed to get IRQ number\n");
>                 ret = irq;
>                 goto err;
>         }
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 8e4a8ba33f05..3d7fa948b4c3 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -490,10 +490,8 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>         }
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(dev, "no irq specified\n");
> +       if (irq < 0)
>                 return irq;
> -       }
>
>         host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c));
>         if (IS_ERR(host)) {
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index e369cbf1ff02..f8b939e63e02 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -119,10 +119,8 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>         u32 reg = 0;
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(dev, "%s: no irq specified\n", __func__);
> +       if (irq < 0)
>                 return irq;
> -       }
>
>         host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
>         if (IS_ERR(host))
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 49aad9a79c18..e09336f9166d 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -557,10 +557,8 @@ static int uniphier_sd_probe(struct platform_device *pdev)
>         int irq, ret;
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(dev, "failed to get IRQ number");
> +       if (irq < 0)
>                 return irq;
> -       }
>
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> --
> Sent by a computer through tubes
>
