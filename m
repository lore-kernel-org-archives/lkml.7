Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1686C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7912081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJaIsxiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391708AbfIFVaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 17:30:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42041 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732110AbfIFVaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:30:22 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so16031969iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6XmAQuLEI6LRXi7I+W7PqdETWZbpre6aa0r24jUMtc=;
        b=cJaIsxiBzzg6x+h0oqnrF19NvReVCCqvleCX1I2rRkSvgb8RNY2iSVxx3RM+x5sb5U
         P1H4GTBRJggED7MxJXYsM6VVQGFUwmqCCIY6tLU/r+wumfqFHMb8drmWaZRVpdfu4lsJ
         8z6blICBQ52bQfdkymMKen63Mmb+3Ll+GbHaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6XmAQuLEI6LRXi7I+W7PqdETWZbpre6aa0r24jUMtc=;
        b=bIyFCWkn16nbfkf+inmbFqNk2kNrpbk6FBuNZg+tHizkLsdz3yplqbIlMPwM0Kdo0B
         0YNFCagGHjHHJxx6p4x1RFEhVtGl7JwBSeOaNHYnNLe9a70mAduN2wWJe8Bdy26CZc5Q
         z7hof2HkmWbW4GPv0adVcuWY+GxofrkrFF983t8VyTorTtm1LHed06xF+J5l6SLodnkY
         Xs6kFptZOG32iqAA/91FsB3kIwv1hO9aqyqEdmcFeCgzRPTlMze/0bgOeHn1dZsORpS/
         H4jgAWKGqtHt8yJmG6jNhadmf/NlTxhynYDDKmqAp0hO8VPB5eLdLuvNa8DEwWQdgGoM
         XmwA==
X-Gm-Message-State: APjAAAVAiI2T08AKmsFEcIvUSd6heaHaXYTICEwm1f0PaYUYjo6S2jjY
        eIKSCP91h1Y+tyATZs8626bVDuMu1qo=
X-Google-Smtp-Source: APXvYqxlAdfi9PRLmiLfDgsH7PZiSv/L6v3oUia5l/JRDpda+RQDGrzMq9GUBX59NHcPWbiOBer/ng==
X-Received: by 2002:a5e:8f41:: with SMTP id x1mr1821979iop.191.1567805421165;
        Fri, 06 Sep 2019 14:30:21 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id x9sm3921258iol.23.2019.09.06.14.30.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 14:30:20 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id u185so15984965iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 14:30:20 -0700 (PDT)
X-Received: by 2002:a6b:b704:: with SMTP id h4mr9483813iof.218.1567805419931;
 Fri, 06 Sep 2019 14:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-6-ulf.hansson@linaro.org>
 <CAD=FV=UhA4pxui29k+SHygCYq+a3O8ELJCq7=6iVSUrnwvk8DQ@mail.gmail.com> <CAPDyKFo3BNjFcqfURP2TWrMWB3SGC6p4hMcxz++QRRBwCsLH4w@mail.gmail.com>
In-Reply-To: <CAPDyKFo3BNjFcqfURP2TWrMWB3SGC6p4hMcxz++QRRBwCsLH4w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 6 Sep 2019 14:30:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UStS7xbChnmZwgcrqQJqC2xCjrNn9wKe-8Yod9xjWTKw@mail.gmail.com>
Message-ID: <CAD=FV=UStS7xbChnmZwgcrqQJqC2xCjrNn9wKe-8Yod9xjWTKw@mail.gmail.com>
Subject: Re: [PATCH 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

Hi,

On Fri, Sep 6, 2019 at 2:20 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 6 Sep 2019 at 01:47, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Sep 3, 2019 at 7:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > In the single SDIO IRQ handler case, the sdio_irq_pending flag is used to
> > > avoid reading the SDIO_CCCR_INTx register and instead immediately call the
> > > SDIO func's >irq_handler() callback.
> > >
> > > To clarify the use behind the flag for the MMC_CAP2_SDIO_IRQ_NOTHREAD case,
> > > let's set the flag from inside sdio_signal_irq(), rather from
> > > sdio_run_irqs().
> >
> > I'm having a hard time parsing the above statement...  Can you reword
> > and maybe I'll understand?
>
> Sure, I admit, it's not very good. :-) How about the below.
>
> The sdio_irq_pending flag is used to let host drivers indicate that it
> has signaled an IRQ. If that is the case and we only have a single
> SDIO func that have claimed an SDIO IRQ, our assumption is that we can
> avoid reading the SDIO_CCCR_INTx register and just call the SDIO func
> irq handler immediately. This makes sense, but the flag is set/cleared
> in a somewhat messy order, let's fix that up according to below.
>
> First, the flag is currently set in sdio_run_irqs(), which is executed
> as a work that was scheduled from sdio_signal_irq(). To make it more
> implicit that the host have signaled an IRQ, let's instead immediately
> set the flag in sdio_signal_irq(). This also makes the behavior
> consistent with host drivers that uses the legacy,
> mmc_signal_sdio_irq() API. This have no functional impact, because we
> don't expect host drivers to call sdio_signal_irq() until after the
> work (sdio_run_irqs()) have been executed anyways.
>
> Second, currently we never clears the flag when using the
> sdio_run_irqs() work, but only when using the sdio_irq_thread(). Let
> make the behavior consistent, by moving the flag to be cleared inside
> the common process_sdio_pending_irqs() function. Additionally, tweak
> the behavior of the flag slightly, by avoiding to clear it unless we
> processed the SDIO IRQ. The purpose with this at this point, is to
> keep the information about whether there have been an SDIO IRQ
> signaled by the host, so at system resume we can decide to process it
> without reading the SDIO_CCCR_INTx register.
>
> >
> >
> > > Moreover, let's also reset the flag when the SDIO IRQ have
> > > been properly processed.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/mmc/core/sdio_irq.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > Nice!  This looks like it addresses some of the things that came up in
> > the previous discussion [1] and should be a nice improvement.  From
> > re-reading that discussion that will probably change the behvaior
> > slightly (hopefully for the better) in the single-function case where
> > we might actually poll CCCR_INTx sometimes now.
>
> Correct!
>
> >
> >
> > > diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> > > index f75043266984..0962a4357d54 100644
> > > --- a/drivers/mmc/core/sdio_irq.c
> > > +++ b/drivers/mmc/core/sdio_irq.c
> > > @@ -59,6 +59,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> > >  {
> > >         struct mmc_card *card = host->card;
> > >         int i, ret, count;
> > > +       bool sdio_irq_pending = host->sdio_irq_pending;
> > >         unsigned char pending;
> > >         struct sdio_func *func;
> > >
> > > @@ -66,13 +67,16 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> > >         if (mmc_card_suspended(card))
> > >                 return 0;
> > >
> > > +       /* Clear the flag to indicate that we have processed the IRQ. */
> > > +       host->sdio_irq_pending = false;
> > > +
> > >         /*
> > >          * Optimization, if there is only 1 function interrupt registered
> > >          * and we know an IRQ was signaled then call irq handler directly.
> > >          * Otherwise do the full probe.
> > >          */
> > >         func = card->sdio_single_irq;
> > > -       if (func && host->sdio_irq_pending) {
> > > +       if (func && sdio_irq_pending) {
> > >                 func->irq_handler(func);
> > >                 return 1;
> > >         }
> > > @@ -110,7 +114,6 @@ static void sdio_run_irqs(struct mmc_host *host)
> > >  {
> > >         mmc_claim_host(host);
> > >         if (host->sdio_irqs) {
> > > -               host->sdio_irq_pending = true;
> > >                 process_sdio_pending_irqs(host);
> > >                 if (host->ops->ack_sdio_irq)
> > >                         host->ops->ack_sdio_irq(host);
> > > @@ -128,6 +131,7 @@ void sdio_irq_work(struct work_struct *work)
> > >
> > >  void sdio_signal_irq(struct mmc_host *host)
> > >  {
> > > +       host->sdio_irq_pending = true;
> >
> > Is this safe to do without claiming the host or any other type of
> > locking?  sdio_signal_irq() is called directly from the interrupt
> > handler on dw_mmc with no locks held at all.  Could we have races /
> > problems with weakly ordered memory?
>
> At this point, for $subject patch and @subject series, I don't see any
> issues. But perhaps when we go forward and start using the flag
> slightly differently.

Lockless concurrency always makes my head hurt (especially when I try
to consider weakly ordered memory) and I've learned that the only way
I can reason about it and have any belief that I got it right is to
always make sure I access values in a context where things are locked.
:-P

Let's see if I can figure out any actual problem, though...

Certainly the queue_delayed_work() would act as a barrier so you don't
have to worry about the worker not seeing the "= true".

I suppose it's definitely possible that (if the worker is already
running) that our "= true" will get clobbered by an "= false" from a
previous instance of the worker running.  I guess that's unlikely
because we can't get a second IRQ signaled until the "->ack_sdio_irq"
ran and presumably there's enough stuff after the "= false" that one
of them would have a barrier that made sure that the "= false" didn't
affect us in a delayed way.

So I guess we're fine...

-Doug
