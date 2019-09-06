Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABFBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A61A2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZainT9Yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404129AbfIFJUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:20:32 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36917 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfIFJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:20:32 -0400
Received: by mail-vk1-f196.google.com with SMTP id v78so1133639vke.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Et7PHDrqyxAsDDe/lA78jPHwRxPA1rwYR+XjZVclCvQ=;
        b=ZainT9YricB7thYzru3Q462ubqbMr6Gq+6drN+wbR81ADdNfAf/VsDo8uRhVZyZSux
         6Bd8YIYWmBxfPK5x+DgTStjCQ7+KBvWFcVdBw2Zl+acbA3AlshjdyQ++mAwMt39o9Gma
         YFUfWRjyaW+JWUx2KyMaHtqUMuglucAbtZD8/X953Bgvs8YaNhX9IDDFkibfhozf05py
         0BUU+a5wV7qb/p+Tf0+Hctq6vta6tNS07Lv9+CbuYGYuYT5rrA3K2CRp3Y5C9tny9hTA
         27x90IBSjvlWQL8U5+DP8wXyZ+2bQPe1jzDM00cIpXfebydXvVnoP3EVVHyjzxWLtHQy
         qFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Et7PHDrqyxAsDDe/lA78jPHwRxPA1rwYR+XjZVclCvQ=;
        b=VpgkuhMhAQioaxbrBHw0hug5J82MYMXuDeng9XM+hTEcwrD4Rw6VOIIkdyukDzcmtT
         aeNHFOl1a3UfvlEU0N8/FZFhWf+/Nkjnkfh9ApHkaEk7Un+RraSVSnfy2136jlPkxUuj
         85dX9IDxrMtp6gLCjLZMyQNAInAZQiCxMzumEdHH001rixEgte8uFOuiuq/mqwx1uW1Q
         GeAIsVCRFlldrRGqw0TUdKGBAOOBtv0Bdu2ZTt2kFNYC1E9y/vtjXJh2nXdyGZXguf8b
         iDlZ4gnqdn3yAjJEIQGszUAuCfaxK62RjNppDlIDdjYe7FZAJVp0Do1sI2CVf5H9HriQ
         PKeg==
X-Gm-Message-State: APjAAAXLmhrc26gamHY+NiZavUMWoEKbd/bHxaIbksaSokoBF9Sv/XYR
        92n/PVfP+yHpWdnhxtEQkWdPG6fsqrWadGTV238ytw==
X-Google-Smtp-Source: APXvYqweXpPFiaYJZp3vUYimxv5p2OUTQgGsh9OAs5qU+UkhWxXLaqpYQiFrraMr+rkgJj5XS385iHyXrUnBe7zyy7I=
X-Received: by 2002:a1f:5e4f:: with SMTP id s76mr3852640vkb.4.1567761630813;
 Fri, 06 Sep 2019 02:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-6-ulf.hansson@linaro.org>
 <CAD=FV=UhA4pxui29k+SHygCYq+a3O8ELJCq7=6iVSUrnwvk8DQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UhA4pxui29k+SHygCYq+a3O8ELJCq7=6iVSUrnwvk8DQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Sep 2019 11:19:54 +0200
Message-ID: <CAPDyKFo3BNjFcqfURP2TWrMWB3SGC6p4hMcxz++QRRBwCsLH4w@mail.gmail.com>
Subject: Re: [PATCH 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 at 01:47, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Sep 3, 2019 at 7:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > In the single SDIO IRQ handler case, the sdio_irq_pending flag is used to
> > avoid reading the SDIO_CCCR_INTx register and instead immediately call the
> > SDIO func's >irq_handler() callback.
> >
> > To clarify the use behind the flag for the MMC_CAP2_SDIO_IRQ_NOTHREAD case,
> > let's set the flag from inside sdio_signal_irq(), rather from
> > sdio_run_irqs().
>
> I'm having a hard time parsing the above statement...  Can you reword
> and maybe I'll understand?

Sure, I admit, it's not very good. :-) How about the below.

The sdio_irq_pending flag is used to let host drivers indicate that it
has signaled an IRQ. If that is the case and we only have a single
SDIO func that have claimed an SDIO IRQ, our assumption is that we can
avoid reading the SDIO_CCCR_INTx register and just call the SDIO func
irq handler immediately. This makes sense, but the flag is set/cleared
in a somewhat messy order, let's fix that up according to below.

First, the flag is currently set in sdio_run_irqs(), which is executed
as a work that was scheduled from sdio_signal_irq(). To make it more
implicit that the host have signaled an IRQ, let's instead immediately
set the flag in sdio_signal_irq(). This also makes the behavior
consistent with host drivers that uses the legacy,
mmc_signal_sdio_irq() API. This have no functional impact, because we
don't expect host drivers to call sdio_signal_irq() until after the
work (sdio_run_irqs()) have been executed anyways.

Second, currently we never clears the flag when using the
sdio_run_irqs() work, but only when using the sdio_irq_thread(). Let
make the behavior consistent, by moving the flag to be cleared inside
the common process_sdio_pending_irqs() function. Additionally, tweak
the behavior of the flag slightly, by avoiding to clear it unless we
processed the SDIO IRQ. The purpose with this at this point, is to
keep the information about whether there have been an SDIO IRQ
signaled by the host, so at system resume we can decide to process it
without reading the SDIO_CCCR_INTx register.

>
>
> > Moreover, let's also reset the flag when the SDIO IRQ have
> > been properly processed.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/sdio_irq.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
>
> Nice!  This looks like it addresses some of the things that came up in
> the previous discussion [1] and should be a nice improvement.  From
> re-reading that discussion that will probably change the behvaior
> slightly (hopefully for the better) in the single-function case where
> we might actually poll CCCR_INTx sometimes now.

Correct!

>
>
> > diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> > index f75043266984..0962a4357d54 100644
> > --- a/drivers/mmc/core/sdio_irq.c
> > +++ b/drivers/mmc/core/sdio_irq.c
> > @@ -59,6 +59,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> >  {
> >         struct mmc_card *card = host->card;
> >         int i, ret, count;
> > +       bool sdio_irq_pending = host->sdio_irq_pending;
> >         unsigned char pending;
> >         struct sdio_func *func;
> >
> > @@ -66,13 +67,16 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> >         if (mmc_card_suspended(card))
> >                 return 0;
> >
> > +       /* Clear the flag to indicate that we have processed the IRQ. */
> > +       host->sdio_irq_pending = false;
> > +
> >         /*
> >          * Optimization, if there is only 1 function interrupt registered
> >          * and we know an IRQ was signaled then call irq handler directly.
> >          * Otherwise do the full probe.
> >          */
> >         func = card->sdio_single_irq;
> > -       if (func && host->sdio_irq_pending) {
> > +       if (func && sdio_irq_pending) {
> >                 func->irq_handler(func);
> >                 return 1;
> >         }
> > @@ -110,7 +114,6 @@ static void sdio_run_irqs(struct mmc_host *host)
> >  {
> >         mmc_claim_host(host);
> >         if (host->sdio_irqs) {
> > -               host->sdio_irq_pending = true;
> >                 process_sdio_pending_irqs(host);
> >                 if (host->ops->ack_sdio_irq)
> >                         host->ops->ack_sdio_irq(host);
> > @@ -128,6 +131,7 @@ void sdio_irq_work(struct work_struct *work)
> >
> >  void sdio_signal_irq(struct mmc_host *host)
> >  {
> > +       host->sdio_irq_pending = true;
>
> Is this safe to do without claiming the host or any other type of
> locking?  sdio_signal_irq() is called directly from the interrupt
> handler on dw_mmc with no locks held at all.  Could we have races /
> problems with weakly ordered memory?

At this point, for $subject patch and @subject series, I don't see any
issues. But perhaps when we go forward and start using the flag
slightly differently.

>
> Maybe I'm not understanding why this has to move.  It seems like it
> would have been fine to leave this part in sdio_run_irqs() where it
> was...

The changes later in the series relies on this change, as we start
making use of the flag to understand if we should ack an SDIO IRQ.

>
>
> [1] https://lore.kernel.org/r/CAD=FV=XBVRsdiOD0vhgTvMXmqm=fzy9Bzd_x=E1TNPBsT_D-tQ@mail.gmail.com
>
> -Doug
>
> >         queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(sdio_signal_irq);
> > @@ -173,7 +177,6 @@ static int sdio_irq_thread(void *_host)
> >                 if (ret)
> >                         break;
> >                 ret = process_sdio_pending_irqs(host);
> > -               host->sdio_irq_pending = false;
> >                 mmc_release_host(host);
> >
> >                 /*
> > --
> > 2.17.1
> >

Kind regards
Uffe
