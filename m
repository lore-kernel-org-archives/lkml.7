Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C95C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E692523404
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qoLCCti7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfH2IaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:30:04 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36813 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfH2IaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:30:04 -0400
Received: by mail-vs1-f66.google.com with SMTP id y16so1872534vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8KVS3WjjGsX+VLjU/LkBwPrBnJsz/ospkY1CDEGnbc=;
        b=qoLCCti7tDQj75bRIJmpecZtyATOYvx/Ue50cSdRaYMgs4v23EfqkSYjxxd6BBT135
         NM/10JteU5kbTWj3VQ6ElY1xoXdKJg2Q6B0bxj96atbSLEnzBU7v21GNVJpZMFaXIOia
         oMzmWF4nAKv6tPlksPzyHKAfSdbnchYTsDaAjgaAplk7ysl6g14EFkQp0kmZakBimUiL
         H0lhFTX4mYt5owaq+lwQ8p1iclk3jrzVrbG44Uh2dmoENr5q8s3y4rasAnhtKHN17EK4
         YXTMPmK037cQ5B/dlEkxs5JonZerfCp6OPGk+qBvVN+seD0MB2VkMrSjauOiTGUfukx6
         XSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8KVS3WjjGsX+VLjU/LkBwPrBnJsz/ospkY1CDEGnbc=;
        b=I0Fv70E64y0wjYTVbM7a6fRp1S8XmE1Tz1Z1cCccyAdmv+ga6rfuFThnHTYLOx0mRD
         BzxVUXEGFtYoSv714i2zENVivR27jjevYphjZSGXA4J29T78GEzI7l2tc1I09Vf5LqNE
         jyhUQ6QiYU2ZPxX7gsO1NDTp217Go7VOHytWlDBqGjws1VC1aT26vE5VQHwZ+jwaLd9u
         l1jKvlAn+ak6CI1yCE+3V9fy6+Mq7gEB0yeJuPSFwi5+QMeoJYnPoq/OqdDBshPaky8B
         G1tEMDS8YvzbCut2GpTAOv1r53X7NOxdZ5HObSicCO/vblqIf889J0znaLR4TvuN7RIe
         4iaA==
X-Gm-Message-State: APjAAAXcyCKMINq+E7/YoU+chW2nt9nT9VmPsHyiD1MnZXbb5qPFxIjK
        SyQCroigPYxrxzKxrCCnlThjFm6Mqlxy0rvzVHbVcg==
X-Google-Smtp-Source: APXvYqzd/d2jBHerpv45go4Rm2INhV3tAXjXFfOsLO6AiCuwGOpfkHaXG2cWN8z7oscoX8mrSVdQAS2jjjtEDqZ7B0w=
X-Received: by 2002:a67:e287:: with SMTP id g7mr4720453vsf.200.1567067402816;
 Thu, 29 Aug 2019 01:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190828214620.66003-1-mka@chromium.org>
In-Reply-To: <20190828214620.66003-1-mka@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 10:29:26 +0200
Message-ID: <CAPDyKFrJOXC5DaYzPrEr-ttv5Mz6NLAvVW+L4xUUaiZpqyj+Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdio: Move code to get pending SDIO IRQs to a function
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 at 23:46, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Move the code to get pending SDIO interrupts from
> process_sdio_pending_irqs() to a dedicated function.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 47 ++++++++++++++++++++++++-------------
>  include/linux/mmc/host.h    |  1 +
>  2 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 0bcc5e83bd1a..fedc49901efd 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -27,6 +27,35 @@
>  #include "core.h"
>  #include "card.h"
>
> +int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
> +{
> +       struct mmc_card *card = host->card;
> +       int ret;
> +
> +       WARN_ON(!host->claimed);
> +
> +       ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, pending);
> +       if (ret) {
> +               pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
> +                      mmc_card_id(card), ret);
> +               return ret;
> +       }
> +
> +       if (*pending && mmc_card_broken_irq_polling(card) &&
> +           !(host->caps & MMC_CAP_SDIO_IRQ)) {
> +               unsigned char dummy;
> +
> +               /* A fake interrupt could be created when we poll SDIO_CCCR_INTx
> +                * register with a Marvell SD8797 card. A dummy CMD52 read to
> +                * function 0 register 0xff can avoid this.
> +                */
> +               mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(sdio_get_pending_irqs);

I don't think you need export the sympol as this should be an internal
function for the core module.

> +
>  static int process_sdio_pending_irqs(struct mmc_host *host)
>  {
>         struct mmc_card *card = host->card;
> @@ -49,23 +78,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>                 return 1;
>         }
>
> -       ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
> -       if (ret) {
> -               pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
> -                      mmc_card_id(card), ret);
> +       ret = sdio_get_pending_irqs(host, &pending);
> +       if (ret)
>                 return ret;
> -       }
> -
> -       if (pending && mmc_card_broken_irq_polling(card) &&
> -           !(host->caps & MMC_CAP_SDIO_IRQ)) {
> -               unsigned char dummy;
> -
> -               /* A fake interrupt could be created when we poll SDIO_CCCR_INTx
> -                * register with a Marvell SD8797 card. A dummy CMD52 read to
> -                * function 0 register 0xff can avoid this.
> -                */
> -               mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
> -       }
>
>         count = 0;
>         for (i = 1; i <= 7; i++) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4a351cb7f20f..7ce0e98e3dbd 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -502,6 +502,7 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>  }
>
>  void sdio_signal_irq(struct mmc_host *host);
> +int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending);

I want to avoid to sprinkle the public mmc headers, avoiding
interfaces to be abused outside mmc core.

That said, I think this should be internal to the mmc core, thus
please move this to drivers/mmc/core/sdio_ops.h.

>
>  #ifdef CONFIG_REGULATOR
>  int mmc_regulator_set_ocr(struct mmc_host *mmc,
> --
> 2.23.0.187.g17f5b7556c-goog
>

Kind regards
Uffe
