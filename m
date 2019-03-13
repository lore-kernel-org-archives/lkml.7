Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3177CC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B51B2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfCMOpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:45:17 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35266 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMOpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:45:16 -0400
Received: by mail-ua1-f68.google.com with SMTP id f88so745610uaf.2;
        Wed, 13 Mar 2019 07:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63dkDYz52se4E5080eXzCZ9vNZBXRS9vr4q0KCO8Cy4=;
        b=kL5mCFyxSv2Idhf5IdagVjq6n03T/S2IQP03G1EYV/o7XBfBFPsMSvgMTiuhltYD2i
         4JzGwlasIFJVW+u8jqFh5Gf1kAs7UrJtQSaXuyrGT7WesH8tRJOnhTb6xbE4C+lrDlXq
         RRWYA1zME9HbdQprbbWRahjNPbK8M9/u+K9WeXLxxw/vz9N15CTUEqDWbTlohhyZKfS6
         GxT2FENbOWkErV6MW3kLgByJq5r1Xe1fimv4HkEJpMJwo55SLuTsvuaJTvB/LV5e/FiO
         xr6mKwcniqLZdi0rusU+Y7WA9lRJEYoO0wIDFKSWZuFwOkc0OQCfpan4c8T7qRGY5ub5
         mEtQ==
X-Gm-Message-State: APjAAAWdJwjfkAy9KC8rAFE1Qhq7Q+aGB5k/4S3COReh4aEY6nI6ZXEJ
        4v47gPURftwJVIKqtKl0gtfuy9SRrMwKTgX0Tlk=
X-Google-Smtp-Source: APXvYqyEfu3Iegnjt5eiK9aoYhPNx4ak8DInz6UPgEF0pcBCsIACErDiJ7EkuOwnf1l+FgvaGN7fQDytKUngxHrHcrE=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr22757596uao.20.1552488314929;
 Wed, 13 Mar 2019 07:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190312065128.24994-1-jiada_wang@mentor.com>
In-Reply-To: <20190312065128.24994-1-jiada_wang@mentor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Mar 2019 15:45:03 +0100
Message-ID: <CAMuHMdUEnzgwAqBC=vTYWnrzC5HrqC5f5gDLWJFSJRYAu+DD1g@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM / Domains: Avoid a potential deadlock
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiada,

CC Marek, Jon, Mike, Stephen, linux-clk, linux-renesas-soc

On Tue, Mar 12, 2019 at 7:51 AM Jiada Wang <jiada_wang@mentor.com> wrote:
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
>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Thanks a lot for your perseverance!
I had tried putting each PM Domain in its own lockdep class, but that
didn't help.

Your patch fixes the lockdep warnings on my Salvator-X(S) boards.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Your solution makes sense, as the .{at,de}tach_dev() callbacks are
owned by the individual PM Domain drivers, and not by the genpd core.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One thing I'm still wondering about: genpd_add_device() is always called
with gpd_list_lock held.
However, the same cannot be said about genpd_remove_device():
  - pm_genpd_remove_device() does not take gpd_list_lock, unlike
    pm_genpd_add_device(),
  - genpd_dev_pm_detach() does not take gpd_list_lock, while
    __genpd_dev_pm_attach() does take the lock for adding,
    but not for removing (in the error patch)?

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

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
