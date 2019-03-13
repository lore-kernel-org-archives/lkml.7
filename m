Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDACC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352602177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xln0ln3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfCMHfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:35:41 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46842 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMHfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:35:40 -0400
Received: by mail-vk1-f196.google.com with SMTP id j68so231510vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqplvvOAwiIzlpi/WtKVEIywC43QXot6ApbcJv2I4cg=;
        b=xln0ln3XPt0IT6834qygXYwzqBMpQyWeXlAUcdSZgER7tJU8mRcNSUJiYAff4RahwR
         cyOxPHDDnapzoA7IkuQw+oX33QaRwFj6kPYYZAhwH+phXFfDzv1KmvlB1c1J9UInaGuD
         IcZeIeXB8WFDxDt54ytSQho016nnPLep+dsa/IvzAEUcVXohfm3d2QvsQ7su5S2uGy17
         cbpIpC+Fe4e54ms+S6BMVcwNCO1fyOzXZWd5MZH4Mo7RGoXYnOgHJh9IZgehxgdDD90M
         c6NRGCL8pLJsX1F7r6Xu8Dz3gL3bcBgEQ12xEBEPDdohiT2khMHXsqX6b5/7TPL/gRfQ
         zSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqplvvOAwiIzlpi/WtKVEIywC43QXot6ApbcJv2I4cg=;
        b=LvoHoOO/xoZE2Wx8fhZQgDqA9zTXE1e4eO+SgTlXO3Z+U2B+yD3yoODXaT0mofyKKR
         EKG0nN94S5j5ZRvS+zNUvRIC/Ui2deK9SxDouxrbbYIVbBG0ped1x9Fjw/82eiJAuXcR
         hVV8GK2VKkt5eahJXnpdorzeHmf0YZA527393pMY4R6RQ02ft94cJ1gxO2tqSV5EvFKL
         9+6MrTvjBzTzTYqoY8lea9T0RTVLJVweunHs/SipZ7T5Ybao/BhabGcVe5NHf0aTF31t
         woDby7OXD4vzyv0dHeY99PZhdqqu/BbwRwdvQgCCMVb5fZXBFN8Is25C7aBYiMzC8QuE
         0WHg==
X-Gm-Message-State: APjAAAWLXu39YXOG8dTPNTWk+Du4ENf2NYApzmPGEferfPCGvhJanw4x
        wKSP/ndUhvD7tFBN6oqvQJ5W/YgyVO7sD1XqC3zg/Q==
X-Google-Smtp-Source: APXvYqz2GH4qQs9Ct4UA6SeGHQ0eg4hVlPa0Z3GzWE5fyKKU/Mz83yG7plTDmxJKtFCzu9qPd78aa5zyYFpKm8zqV8M=
X-Received: by 2002:a1f:3253:: with SMTP id y80mr21227185vky.17.1552462539450;
 Wed, 13 Mar 2019 00:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190312065128.24994-1-jiada_wang@mentor.com>
In-Reply-To: <20190312065128.24994-1-jiada_wang@mentor.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Mar 2019 08:35:02 +0100
Message-ID: <CAPDyKFodmgkpLkJDiMqh3vm+Ynuo852biZkY7uB5sm9UeAJ63A@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM / Domains: Avoid a potential deadlock
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 at 07:51, Jiada Wang <jiada_wang@mentor.com> wrote:
>
> Lockdep warns that prepare_lock and genpd->mlock can cause a deadlock
> the deadlock scenario is like following:
> First thread is probing cs2000
> cs2000_probe()
>   clk_register()
>     __clk_core_init()
>       clk_prepare_lock()                            ----> acquires prepare_lock
>         cs2000_recalc_rate()
>           i2c_smbus_read_byte_data()
>             rcar_i2c_master_xfer()
>               dma_request_chan()
>                 rcar_dmac_of_xlate()
>                   rcar_dmac_alloc_chan_resources()
>                     pm_runtime_get_sync()
>                       __pm_runtime_resume()
>                         rpm_resume()
>                           rpm_callback()
>                             genpd_runtime_resume()   ----> acquires genpd->mlock
>
> Second thread is attaching any device to the same PM domain
> genpd_add_device()
>   genpd_lock()                                       ----> acquires genpd->mlock
>     cpg_mssr_attach_dev()
>       of_clk_get_from_provider()
>         __of_clk_get_from_provider()
>           __clk_create_clk()
>             clk_prepare_lock()                       ----> acquires prepare_lock
>
> Since currently no PM provider access genpd's critical section
> in .attach_dev, and .detach_dev callbacks, so there is no need to protect
> these two callbacks with genpd->mlock.
> This patch avoids a potential deadlock by moving out .attach_dev and .detach_dev
> from genpd->mlock, so that genpd->mlock won't be held when prepare_lock is acquired
> in .attach_dev and .detach_dev

Thanks for the detailed description, this seems like a reasonable change to me!

>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/domain.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 500de1dee967..a00ca6b8117b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1467,12 +1467,12 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>         if (IS_ERR(gpd_data))
>                 return PTR_ERR(gpd_data);
>
> -       genpd_lock(genpd);
> -
>         ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
>         if (ret)
>                 goto out;
>
> +       genpd_lock(genpd);
> +
>         dev_pm_domain_set(dev, &genpd->domain);
>
>         genpd->device_count++;
> @@ -1480,9 +1480,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>
>         list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
>
> - out:
>         genpd_unlock(genpd);
> -
> + out:
>         if (ret)
>                 genpd_free_dev_data(dev, gpd_data);
>         else
> @@ -1531,15 +1530,15 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>         genpd->device_count--;
>         genpd->max_off_time_changed = true;
>
> -       if (genpd->detach_dev)
> -               genpd->detach_dev(genpd, dev);
> -
>         dev_pm_domain_set(dev, NULL);
>
>         list_del_init(&pdd->list_node);
>
>         genpd_unlock(genpd);
>
> +       if (genpd->detach_dev)
> +               genpd->detach_dev(genpd, dev);
> +
>         genpd_free_dev_data(dev, gpd_data);
>
>         return 0;
> --
> 2.19.2
>
