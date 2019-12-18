Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A125AC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7693C206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2eoiCRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLRLxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:53:05 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33503 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfLRLxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:53:05 -0500
Received: by mail-ua1-f65.google.com with SMTP id a12so529908uan.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 03:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3mn+kJ178kZtOWDg2zTvnwyxAVrOywGSMty+AaHNEI=;
        b=F2eoiCRjNchgbhQCkT7vV1Kmxm5nNZ6xSGL4Lj+OBYfiDioWYJMcunissFoUsV/Sir
         +akukblcwPNcWSf4YMGr/L2j6FMFC2sA6h29CMco9Kj5h/BvpLz3G/OwxSJePOA+1CBs
         8r+v6UuxeRfOotEIAtIpd1c0ZYEKoNDELVD2phJhJuOhX1f+xwGqveozrMSUBLKluM8t
         8BhNKS0fQRN8ZCG4R6ku2mMnkyKEz0ijbWv01KH4t4va2Qd48f7QnB0F6p5fpn8/4BAa
         vd/vc78cJgw0tdyX86fCsa/cy/smbPpbU48/CZg95Pc6GbLV4x26rGSADE3sR5Df8MEY
         jR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3mn+kJ178kZtOWDg2zTvnwyxAVrOywGSMty+AaHNEI=;
        b=LcfaWAYJNspB5kgluOtPJ77WJK6T3y6lXOv00gbaHCvzlIGE9Dno2gdPy4XRd+u/5W
         nmPdkwYdLrJ59dj69aLoQouhufM9slE+uqgumyLvdPHm8g9IIL2Ve9Vxe0YgtXkZEYkM
         K9a648zZ+o9wYL+eJt/OqWwGt+e0AJOSM4VuQaUw11rtma8B9qYSOJFrJLc0vBaBhqvg
         f3TU9pllYn2P2k8b8I7UjE3jRA3UXb0CVbn33QoJQLTQSBfU39lkePXG3uww10rTMh0p
         8kZOlSbr2g+EYqacCvIrAcAJu0TmGTedZnZcalCjOvoXVarjAawCBBA3r4rVtFIp5K7d
         DfVg==
X-Gm-Message-State: APjAAAWEkk/5oyQDcq+eRRWLl4N+jIBfHhi3Dt9+katDUadCpBxennIL
        EjDIFcjpw6kIlT357ZlpaXaJveNMyiIucoNjTjW7di/W
X-Google-Smtp-Source: APXvYqxAeqMZl5h12AA0LAKmFZXJfhgKleA32w3EKgAOwZARMefeWZnWf2d9TV9+5OLGFwMu86iu856ofVAW5N7gtk8=
X-Received: by 2002:ab0:e16:: with SMTP id g22mr961195uak.129.1576669984262;
 Wed, 18 Dec 2019 03:53:04 -0800 (PST)
MIME-Version: 1.0
References: <1576552672-22737-1-git-send-email-zhangpan26@huawei.com>
In-Reply-To: <1576552672-22737-1-git-send-email-zhangpan26@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 12:52:28 +0100
Message-ID: <CAPDyKFr8aVWVydT5U6mpuZr5_waH=bn6F8rjryfDJ15FDaAXUw@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: fix a possible null pointer access.
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     hushiyuan@huawei.com, Jaehoon Chung <jh80.chung@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 at 04:18, Pan Zhang <zhangpan26@huawei.com> wrote:
>
> 3419     if (host->slot &&
> 3420         (mmc_can_gpio_cd(host->slot->mmc) ||
> 3421          !mmc_card_is_removable(host->slot->mmc))) {
> 3422         ret = clk_prepare_enable(host->biu_clk);
> 3423         if (ret)
> 3424             return ret;
> 3425     }
>
> We previously assumed 'host->slot' could be null (see line 3419).
>
> The following situation is similar, so add a judgement.
>
> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index fc9d4d0..8e27c52 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3454,7 +3454,7 @@ int dw_mci_runtime_resume(struct device *dev)
>         mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
>
>
> -       if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> +       if (host->slot && (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER))
>                 dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);

This shouldn't be a problem as the ->runtime_resume() callback can't
be invoked, unless there is a slot.

>
>         /* Force setup bus to guarantee available clock output */
> --
> 2.7.4
>

Kind regards
Uffe
