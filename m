Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9744DC606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7782087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vydbS4JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfGHL4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:56:34 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:32856 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbfGHL4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:56:32 -0400
Received: by mail-vs1-f65.google.com with SMTP id m8so7995494vsj.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQ8W16JFocd/InfO/cTB4TM+C2DG5Zh65kAxr22aAgw=;
        b=vydbS4JFbSJNqkIOFQ0D5/ZnJvmP882sgm8pA2xzk4cuTgDSOkGzTVrCU7NlK1CHgj
         SeVTb2hAwwAVEHoWdfMjszU5gR1i2vAC2ytmDeRkD2DQKevdCkwkhTxdJ9DAuA4OOLXc
         L+DiEDMXIDsVRF69tivAPriiX+mLRJJP/F8BJW7Zrm3c7XAoM2S5mMdB3x103YBx6qjU
         ET0hAMjxwDXYy06Z1sfWreTdzOc+cLHtOD6sBYmBa32KhbFzUOvw5S8HtpwULzfxhAlz
         VBLQItAy3bYqRK1eGWBrim8oTn+dzLA2lyHEbtogg8vL9deO78/vilh9C+dvly2mEJGF
         H4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQ8W16JFocd/InfO/cTB4TM+C2DG5Zh65kAxr22aAgw=;
        b=tLDFXJgUVUOZtWhdhK2Qiv7vjZ2yNgecXAALsYlvggddyrJVln4JxNCe5DFjBbRx+d
         Hiox2fUQjWDdKUMCDJ33ToAcMjkQ4ww03WLlKQjoBHQt7hccIYp32cv2SSU6QjrHvd5H
         cuSqZbRRz3xQea+F7kJ1rRxjvY9UsHHUeJAIYTOztW95Wc6fIZFuNyFNXVt5MAPJ48Jg
         MwCkvpvVJhvjmg4X7BluiSnJTUUujWfpSEsh6WEAiUhF+tt+qCfjC4KAolZSYZT6apk2
         UbtDJBcOlPanj8jodln2/Xt/tysZC3Y0wP8Vm0NHUK5P5k/F5iINX2koD1dcJ5eEq2Rx
         3d8A==
X-Gm-Message-State: APjAAAV252KY5WJWNQrJ+gqb9i9Zx7ji+1k9jNxuDr43dsBwmH92RMcg
        DiPNZyh1SXEPCKj1o5I298lv/6iFHHAcDpR5XP+WGg==
X-Google-Smtp-Source: APXvYqzidSJWbMyu5YA4UU0sFo+5kRhKxrroJqRjJoabzcjT+jV61fswOw7eZKxNfepxVIMJc+BMC7osp4ifP26Gdx4=
X-Received: by 2002:a67:8709:: with SMTP id j9mr10023670vsd.35.1562586991328;
 Mon, 08 Jul 2019 04:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190701150125.2602-1-jorge.ramirez-ortiz@linaro.org>
In-Reply-To: <20190701150125.2602-1-jorge.ramirez-ortiz@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:55:55 +0200
Message-ID: <CAPDyKFrcB3Pqe+yiz4T5mL5wQ-2bATyO3aE+hy4T2Ueeu22g1Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-msm: fix mutex while in spinlock
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     agross@kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        vinod.koul@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019 at 17:01, Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
>
> mutexes can sleep and therefore should not be taken while holding a
> spinlock. move clk_get_rate (can sleep) outside the spinlock protected
> region.
>
> Fixes: 83736352e0ca ("mmc: sdhci-msm: Update DLL reset sequence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5fc76a1993d0..9cf14b359c14 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -575,11 +575,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>         int wait_cnt = 50;
> -       unsigned long flags;
> +       unsigned long flags, xo_clk = 0;
>         u32 config;
>         const struct sdhci_msm_offset *msm_offset =
>                                         msm_host->offset;
>
> +       if (msm_host->use_14lpp_dll_reset && !IS_ERR_OR_NULL(msm_host->xo_clk))
> +               xo_clk = clk_get_rate(msm_host->xo_clk);
> +
>         spin_lock_irqsave(&host->lock, flags);
>
>         /*
> @@ -627,10 +630,10 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>                 config &= CORE_FLL_CYCLE_CNT;
>                 if (config)
>                         mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 8),
> -                                       clk_get_rate(msm_host->xo_clk));
> +                                       xo_clk);
>                 else
>                         mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 4),
> -                                       clk_get_rate(msm_host->xo_clk));
> +                                       xo_clk);
>
>                 config = readl_relaxed(host->ioaddr +
>                                 msm_offset->core_dll_config_2);
> --
> 2.21.0
>
