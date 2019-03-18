Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8393C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E822214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nA+f4fl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbfCRJk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:40:56 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40611 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbfCRJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:34:30 -0400
Received: by mail-ua1-f68.google.com with SMTP id b8so3418224uaq.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2ATsNhSt5TrNVesCNg1T9hqD0EtXNi7xhAlDxDKVH4=;
        b=nA+f4fl/6muzsU9wfei4x1eeLqLuO7l3w1m4iiEDmtlI5DUczKnuslLDsE3NEo9cDT
         5acqO/bgyFYd8PBojNPcQEBlmtad+krRAX7eWviwgYS4mOjr1d+IIJC/msTFSP0WcqGO
         fMcpWW+t2WZNOU/XkX8tGa/CR0KpKxlM0jM6ST+/4rlXteK17ZcTo/0JSuE1Oe80O2B1
         M2weKvxdyktIRO+t4WBuHaSpIh2ejNvUkSiWaLO/X/pgQB5kZ26hYkttmjNKD2PE0t4H
         otXggHqhEZur72plWiLSTRBJPSoaFwEfIN2cv5T0NeZqDxx1hLqbeusV9Lhz6URjD8y9
         Kxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2ATsNhSt5TrNVesCNg1T9hqD0EtXNi7xhAlDxDKVH4=;
        b=Z7B83YN8HkxsNVfT7ifCpPSEXB50xX1Yv8EPQJWWZ4MScRjFbdaqC4vfXHmmYZ9PQF
         5g/t/FqewPGO8LeMRcNorF2ARvn7sR7Wv1OWvTJhaYIFgguOHzoxps/DPvhdbrS67GaY
         h9TT++Inaz8Iwm4IfLmcTw3kReuqpDDo9+qzIVO6dmLiaxFllGkXxfZBxbIjFVdNoRtC
         YV01wWn4Q0QUtsLMDwTRFilR9IPSrSxdYpQIFswoQqK0OvYmIv70KRhyzQOsPnfAeKXG
         DaMoEK4SBvUA4xOrETNpqY2e+o7KwjXIkLrQYqnmM+wNUcOjpIy88iPnUBeZn5KQe5Vr
         nfgQ==
X-Gm-Message-State: APjAAAWeMRLyRrepPiMOh/WnPR+q+vkbWs5BwZMhDAyPkG8dgf06PfiO
        V5F5qj2X+ZfVXbAYaLwRPYmqUjNtF6Gr0t8oKeOIOw==
X-Google-Smtp-Source: APXvYqyP/ftteQHYX/fD+nQQ6YNJWgJQMRujb5JD7w31Kjie02h+5EuCGvYvJBvMbGLzvafy3m0ajVp2EAKUZ/AYsig=
X-Received: by 2002:ab0:4812:: with SMTP id b18mr5853944uad.24.1552901668679;
 Mon, 18 Mar 2019 02:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190215192033.24203-1-faiz_abbas@ti.com> <20190215192033.24203-2-faiz_abbas@ti.com>
In-Reply-To: <20190215192033.24203-2-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Mar 2019 10:33:52 +0100
Message-ID: <CAPDyKFqN4s1CZa9z5C3YzCUO01V-=Xhtao5352Pmytd-Tusv9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
To:     Faiz Abbas <faiz_abbas@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kishon <kishon@ti.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Arnd, Grygorii

On Fri, 15 Feb 2019 at 20:17, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> sdhci.c has two bottom halves implemented. A threaded_irq for handling
> card insert/remove operations and a tasklet for finishing mmc requests.
> With the addition of external dma support, dmaengine APIs need to
> terminate in non-atomic context before unmapping the dma buffers.
>
> To facilitate this, remove the finish_tasklet and move the call of
> sdhci_request_done() to the threaded_irq() callback. Also move the
> interrupt result variable to sdhci_host so it can be populated from
> anywhere inside the sdhci_irq handler.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Adrian, I think it makes sense to apply this patch, even if there is
very minor negative impact throughput wise.

To me, it doesn't seems like MMC/SD/SDIO has good justification for
using tasklets, besides from the legacy point of view, of course.
Instead, I think we should try to move all mmc hosts into using
threaded IRQs.

So, what do you think? Can you overlook the throughput drop and
instead we can try to recover this on top with other optimizations?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 43 +++++++++++++++-------------------------
>  drivers/mmc/host/sdhci.h |  2 +-
>  2 files changed, 17 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index eba9bcc92ad3..20ed09b896d7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1232,7 +1232,7 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>
>         WARN_ON(i >= SDHCI_MAX_MRQS);
>
> -       tasklet_schedule(&host->finish_tasklet);
> +       host->result = IRQ_WAKE_THREAD;
>  }
>
>  static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> @@ -2705,14 +2705,6 @@ static bool sdhci_request_done(struct sdhci_host *host)
>         return false;
>  }
>
> -static void sdhci_tasklet_finish(unsigned long param)
> -{
> -       struct sdhci_host *host = (struct sdhci_host *)param;
> -
> -       while (!sdhci_request_done(host))
> -               ;
> -}
> -
>  static void sdhci_timeout_timer(struct timer_list *t)
>  {
>         struct sdhci_host *host;
> @@ -2995,11 +2987,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>
>  static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  {
> -       irqreturn_t result = IRQ_NONE;
>         struct sdhci_host *host = dev_id;
>         u32 intmask, mask, unexpected = 0;
>         int max_loops = 16;
>
> +       host->result = IRQ_NONE;
> +
>         spin_lock(&host->lock);
>
>         if (host->runtime_suspended && !sdhci_sdio_irq_enabled(host)) {
> @@ -3009,7 +3002,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>
>         intmask = sdhci_readl(host, SDHCI_INT_STATUS);
>         if (!intmask || intmask == 0xffffffff) {
> -               result = IRQ_NONE;
> +               host->result = IRQ_NONE;
>                 goto out;
>         }
>
> @@ -3054,7 +3047,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>
>                         host->thread_isr |= intmask & (SDHCI_INT_CARD_INSERT |
>                                                        SDHCI_INT_CARD_REMOVE);
> -                       result = IRQ_WAKE_THREAD;
> +                       host->result = IRQ_WAKE_THREAD;
>                 }
>
>                 if (intmask & SDHCI_INT_CMD_MASK)
> @@ -3074,7 +3067,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>                     (host->ier & SDHCI_INT_CARD_INT)) {
>                         sdhci_enable_sdio_irq_nolock(host, false);
>                         host->thread_isr |= SDHCI_INT_CARD_INT;
> -                       result = IRQ_WAKE_THREAD;
> +                       host->result = IRQ_WAKE_THREAD;
>                 }
>
>                 intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
> @@ -3087,8 +3080,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>                         sdhci_writel(host, intmask, SDHCI_INT_STATUS);
>                 }
>  cont:
> -               if (result == IRQ_NONE)
> -                       result = IRQ_HANDLED;
> +               if (host->result == IRQ_NONE)
> +                       host->result = IRQ_HANDLED;
>
>                 intmask = sdhci_readl(host, SDHCI_INT_STATUS);
>         } while (intmask && --max_loops);
> @@ -3101,7 +3094,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>                 sdhci_dumpregs(host);
>         }
>
> -       return result;
> +       return host->result;
>  }
>
>  static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> @@ -3131,6 +3124,12 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>                 spin_unlock_irqrestore(&host->lock, flags);
>         }
>
> +       if (!isr) {
> +               do {
> +                       isr = !sdhci_request_done(host);
> +               } while (isr);
> +       }
> +
>         return isr ? IRQ_HANDLED : IRQ_NONE;
>  }
>
> @@ -4212,12 +4211,6 @@ int __sdhci_add_host(struct sdhci_host *host)
>         struct mmc_host *mmc = host->mmc;
>         int ret;
>
> -       /*
> -        * Init tasklets.
> -        */
> -       tasklet_init(&host->finish_tasklet,
> -               sdhci_tasklet_finish, (unsigned long)host);
> -
>         timer_setup(&host->timer, sdhci_timeout_timer, 0);
>         timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
>
> @@ -4230,7 +4223,7 @@ int __sdhci_add_host(struct sdhci_host *host)
>         if (ret) {
>                 pr_err("%s: Failed to request IRQ %d: %d\n",
>                        mmc_hostname(mmc), host->irq, ret);
> -               goto untasklet;
> +               return ret;
>         }
>
>         ret = sdhci_led_register(host);
> @@ -4263,8 +4256,6 @@ int __sdhci_add_host(struct sdhci_host *host)
>         sdhci_writel(host, 0, SDHCI_INT_ENABLE);
>         sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
>         free_irq(host->irq, host);
> -untasklet:
> -       tasklet_kill(&host->finish_tasklet);
>
>         return ret;
>  }
> @@ -4326,8 +4317,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>         del_timer_sync(&host->timer);
>         del_timer_sync(&host->data_timer);
>
> -       tasklet_kill(&host->finish_tasklet);
> -
>         if (!IS_ERR(mmc->supply.vqmmc))
>                 regulator_disable(mmc->supply.vqmmc);
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6cc9a3c2ac66..624d5aa01995 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -554,7 +554,7 @@ struct sdhci_host {
>
>         unsigned int desc_sz;   /* ADMA descriptor size */
>
> -       struct tasklet_struct finish_tasklet;   /* Tasklet structures */
> +       irqreturn_t result;     /* Result of IRQ handler */
>
>         struct timer_list timer;        /* Timer for timeouts */
>         struct timer_list data_timer;   /* Timer for data timeouts */
> --
> 2.19.2
>
