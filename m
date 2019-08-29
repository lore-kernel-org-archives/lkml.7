Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC8BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257A121874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q8rlmGgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfH2RZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:25:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43138 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfH2RZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:25:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so1925867pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MYOtIJN0A+QqzFgfHKDsi1G/mOouSQFNY4BysbbUBh4=;
        b=Q8rlmGgbYhEYPmwKd64lK41pXCL6qVedNM7V2k0OvrIQ/vG95bXXGoVjiCwADkxGXl
         ZZUjy8ZgCGPG/uA82Dsl5g9ls3Vj2gv1PyKU0vQzIbFIusYJiNYClB8g2XWsuoSmLPdI
         S1nRWe6SAAsUTwcOlBb4nMRgTPrpbQRQQDhWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MYOtIJN0A+QqzFgfHKDsi1G/mOouSQFNY4BysbbUBh4=;
        b=j2BzI+aj+JCkD+agftiBsCvQDpsl0S9yJBq4aWUT2de7esKer5KMyLUAMfep4DlyBn
         HYCddhyi1CrbJth7ufP41sloRAyGUMNWaRwbYIrPHkagEEpH50W43MtCdwLMIX+UQ0+U
         G4xyvBY/rP6y+yWwH8rWe/2ovkorfrxMGfgPWZWexlA4rewFizZnD6ybsG+JJJRPM+xx
         Yzcvz5Fkz86jFIaKiqI1eBR0Tfi2JhYLgm/5zA7JKqxoiRLnXay53HLqu4v1R3GLNLmR
         5eg9EG3HCouDsYGenwdfsaaNbjOtSMwCsMWrjs7w76aPqwfG2ndVPsc6wKFCf54lV5WS
         M3jg==
X-Gm-Message-State: APjAAAXnXkenIZvjBMeOb+WoprE7XhPqX4JOv6izhge8qmkkn/+ZcBrA
        SeMYxn7eOsFBF5dvimDWjYFPdsDGW3k=
X-Google-Smtp-Source: APXvYqw14ctMt63lZs4ODAYlDAcOtkGBGADvvzRNY+tQLVAzvYveoWwo4dKHac6gNDuCNrkzsaDb0Q==
X-Received: by 2002:a62:6c1:: with SMTP id 184mr12568083pfg.230.1567099506950;
        Thu, 29 Aug 2019 10:25:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id z189sm5851680pfb.137.2019.08.29.10.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 10:25:06 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:25:04 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] mmc: sdio: Move code to get pending SDIO IRQs to a
 function
Message-ID: <20190829172504.GE70797@google.com>
References: <20190828214620.66003-1-mka@chromium.org>
 <CAPDyKFrJOXC5DaYzPrEr-ttv5Mz6NLAvVW+L4xUUaiZpqyj+Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFrJOXC5DaYzPrEr-ttv5Mz6NLAvVW+L4xUUaiZpqyj+Dw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:29:26AM +0200, Ulf Hansson wrote:
> On Wed, 28 Aug 2019 at 23:46, Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Move the code to get pending SDIO interrupts from
> > process_sdio_pending_irqs() to a dedicated function.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/mmc/core/sdio_irq.c | 47 ++++++++++++++++++++++++-------------
> >  include/linux/mmc/host.h    |  1 +
> >  2 files changed, 32 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> > index 0bcc5e83bd1a..fedc49901efd 100644
> > --- a/drivers/mmc/core/sdio_irq.c
> > +++ b/drivers/mmc/core/sdio_irq.c
> > @@ -27,6 +27,35 @@
> >  #include "core.h"
> >  #include "card.h"
> >
> > +int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
> > +{
> > +       struct mmc_card *card = host->card;
> > +       int ret;
> > +
> > +       WARN_ON(!host->claimed);
> > +
> > +       ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, pending);
> > +       if (ret) {
> > +               pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
> > +                      mmc_card_id(card), ret);
> > +               return ret;
> > +       }
> > +
> > +       if (*pending && mmc_card_broken_irq_polling(card) &&
> > +           !(host->caps & MMC_CAP_SDIO_IRQ)) {
> > +               unsigned char dummy;
> > +
> > +               /* A fake interrupt could be created when we poll SDIO_CCCR_INTx
> > +                * register with a Marvell SD8797 card. A dummy CMD52 read to
> > +                * function 0 register 0xff can avoid this.
> > +                */
> > +               mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(sdio_get_pending_irqs);
> 
> I don't think you need export the sympol as this should be an internal
> function for the core module.

ok, thanks

> > +
> >  static int process_sdio_pending_irqs(struct mmc_host *host)
> >  {
> >         struct mmc_card *card = host->card;
> > @@ -49,23 +78,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> >                 return 1;
> >         }
> >
> > -       ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
> > -       if (ret) {
> > -               pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
> > -                      mmc_card_id(card), ret);
> > +       ret = sdio_get_pending_irqs(host, &pending);
> > +       if (ret)
> >                 return ret;
> > -       }
> > -
> > -       if (pending && mmc_card_broken_irq_polling(card) &&
> > -           !(host->caps & MMC_CAP_SDIO_IRQ)) {
> > -               unsigned char dummy;
> > -
> > -               /* A fake interrupt could be created when we poll SDIO_CCCR_INTx
> > -                * register with a Marvell SD8797 card. A dummy CMD52 read to
> > -                * function 0 register 0xff can avoid this.
> > -                */
> > -               mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
> > -       }
> >
> >         count = 0;
> >         for (i = 1; i <= 7; i++) {
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 4a351cb7f20f..7ce0e98e3dbd 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -502,6 +502,7 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
> >  }
> >
> >  void sdio_signal_irq(struct mmc_host *host);
> > +int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending);
> 
> I want to avoid to sprinkle the public mmc headers, avoiding
> interfaces to be abused outside mmc core.
> 
> That said, I think this should be internal to the mmc core, thus
> please move this to drivers/mmc/core/sdio_ops.h.

Sounds good
