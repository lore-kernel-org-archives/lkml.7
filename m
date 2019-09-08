Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5110EC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 09:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2A72082C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 09:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhzYOfqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfIHJLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 05:11:47 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46559 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfIHJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 05:11:46 -0400
Received: by mail-vs1-f68.google.com with SMTP id z14so6817982vsz.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX40TQtXTP9fql9KfAiQf8sIGWXKAP38eDtMFtnBbLE=;
        b=OhzYOfqMw91y7E/2fABIX+o/WXzJTyGZufnnn+r+fCGboxjKb+c/D2LPTWiSSfRFqV
         gocOjY2scrNUWeE93GCkQBEXgDhG0cshaWe52h+7ZiID8xAoQdxcExeqcaCgRsxR0NFj
         x7/n6yJy0HeRW3bDzG7zEfCJItVmv0ww7QOUT9BW8EbWRtBWdO0e0TfT0yTngmxpA8bW
         kMJqTWrgJijSrc80aVxWPnzeI2HpdF6UQwM7Q+vWzg22qh1X3VWi6oS6WnFrsj5m4fxx
         t35KGnWGJ4DKASfm7qtCLIbxOc52VJlnYER4LLvpIVAFx4oi+vE3i/W15wDvgl12xfLI
         n5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX40TQtXTP9fql9KfAiQf8sIGWXKAP38eDtMFtnBbLE=;
        b=Krhtf3mEHjfIcKhqAKcbzpL3+4jJBHgt3Txo4BahmbYw1Ezefm3tlYCkaT+9S97v9O
         x2dkmC5ACCD6HbWu6c2jpZkLnqv50fetcW/Sgtu4vazOROgaiN0yX+K7FhHibpMZUP0A
         HL1kEu561OorJVITk5EEtZw7BuOdZEFfchSqVn5VWd9fEyGA63KEmJeevkAxzEx5w+vq
         epUcApdb+oDG/ODOIw668ahLDqv9SOZTzmuq3f2u71bML/VKkm9xXppGfE74oQstuYrM
         JSGNmu/4VFgKGm3nqcO9ZkUU7Bvi11oK5CKWsV55PDLWP+tdUjcH/yr3jqTSgFnc0FmS
         Aelw==
X-Gm-Message-State: APjAAAXYUiSj9QdNVwJbhcBBsLfHPCg44B6Z/VJSfFPifCGNhd2zzeju
        grce0cFOxb6RlxNMioaM+k9YmDE05T7N9ja7kCnzuw==
X-Google-Smtp-Source: APXvYqy6CcohSpSjrsWE9E/ac0xK9rUHCW8yzjVpKNxe1sWN7Q/y17hBp1AbKHXJa8H1I2n8pIyvTBeJ3jHI2atsUCc=
X-Received: by 2002:a67:e2cf:: with SMTP id i15mr9611378vsm.165.1567933905514;
 Sun, 08 Sep 2019 02:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-6-ulf.hansson@linaro.org>
 <CAD=FV=UhA4pxui29k+SHygCYq+a3O8ELJCq7=6iVSUrnwvk8DQ@mail.gmail.com>
 <CAPDyKFo3BNjFcqfURP2TWrMWB3SGC6p4hMcxz++QRRBwCsLH4w@mail.gmail.com> <CAD=FV=UStS7xbChnmZwgcrqQJqC2xCjrNn9wKe-8Yod9xjWTKw@mail.gmail.com>
In-Reply-To: <CAD=FV=UStS7xbChnmZwgcrqQJqC2xCjrNn9wKe-8Yod9xjWTKw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sun, 8 Sep 2019 11:11:07 +0200
Message-ID: <CAPDyKFoMgWJH8S9+ukiwwB3HatwKcPPnWf42QP7kvnP4G_7Yfg@mail.gmail.com>
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

On Fri, 6 Sep 2019 at 23:30, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Sep 6, 2019 at 2:20 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 6 Sep 2019 at 01:47, Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Sep 3, 2019 at 7:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > In the single SDIO IRQ handler case, the sdio_irq_pending flag is used to
> > > > avoid reading the SDIO_CCCR_INTx register and instead immediately call the
> > > > SDIO func's >irq_handler() callback.
> > > >
> > > > To clarify the use behind the flag for the MMC_CAP2_SDIO_IRQ_NOTHREAD case,
> > > > let's set the flag from inside sdio_signal_irq(), rather from
> > > > sdio_run_irqs().
> > >
> > > I'm having a hard time parsing the above statement...  Can you reword
> > > and maybe I'll understand?
> >
> > Sure, I admit, it's not very good. :-) How about the below.
> >
> > The sdio_irq_pending flag is used to let host drivers indicate that it
> > has signaled an IRQ. If that is the case and we only have a single
> > SDIO func that have claimed an SDIO IRQ, our assumption is that we can
> > avoid reading the SDIO_CCCR_INTx register and just call the SDIO func
> > irq handler immediately. This makes sense, but the flag is set/cleared
> > in a somewhat messy order, let's fix that up according to below.
> >
> > First, the flag is currently set in sdio_run_irqs(), which is executed
> > as a work that was scheduled from sdio_signal_irq(). To make it more
> > implicit that the host have signaled an IRQ, let's instead immediately
> > set the flag in sdio_signal_irq(). This also makes the behavior
> > consistent with host drivers that uses the legacy,
> > mmc_signal_sdio_irq() API. This have no functional impact, because we
> > don't expect host drivers to call sdio_signal_irq() until after the
> > work (sdio_run_irqs()) have been executed anyways.
> >
> > Second, currently we never clears the flag when using the
> > sdio_run_irqs() work, but only when using the sdio_irq_thread(). Let
> > make the behavior consistent, by moving the flag to be cleared inside
> > the common process_sdio_pending_irqs() function. Additionally, tweak
> > the behavior of the flag slightly, by avoiding to clear it unless we
> > processed the SDIO IRQ. The purpose with this at this point, is to
> > keep the information about whether there have been an SDIO IRQ
> > signaled by the host, so at system resume we can decide to process it
> > without reading the SDIO_CCCR_INTx register.
> >
> > >
> > >
> > > > Moreover, let's also reset the flag when the SDIO IRQ have
> > > > been properly processed.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/mmc/core/sdio_irq.c | 9 ++++++---
> > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > Nice!  This looks like it addresses some of the things that came up in
> > > the previous discussion [1] and should be a nice improvement.  From
> > > re-reading that discussion that will probably change the behvaior
> > > slightly (hopefully for the better) in the single-function case where
> > > we might actually poll CCCR_INTx sometimes now.
> >
> > Correct!
> >
> > >
> > >
> > > > diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> > > > index f75043266984..0962a4357d54 100644
> > > > --- a/drivers/mmc/core/sdio_irq.c
> > > > +++ b/drivers/mmc/core/sdio_irq.c
> > > > @@ -59,6 +59,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> > > >  {
> > > >         struct mmc_card *card = host->card;
> > > >         int i, ret, count;
> > > > +       bool sdio_irq_pending = host->sdio_irq_pending;
> > > >         unsigned char pending;
> > > >         struct sdio_func *func;
> > > >
> > > > @@ -66,13 +67,16 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> > > >         if (mmc_card_suspended(card))
> > > >                 return 0;
> > > >
> > > > +       /* Clear the flag to indicate that we have processed the IRQ. */
> > > > +       host->sdio_irq_pending = false;
> > > > +
> > > >         /*
> > > >          * Optimization, if there is only 1 function interrupt registered
> > > >          * and we know an IRQ was signaled then call irq handler directly.
> > > >          * Otherwise do the full probe.
> > > >          */
> > > >         func = card->sdio_single_irq;
> > > > -       if (func && host->sdio_irq_pending) {
> > > > +       if (func && sdio_irq_pending) {
> > > >                 func->irq_handler(func);
> > > >                 return 1;
> > > >         }
> > > > @@ -110,7 +114,6 @@ static void sdio_run_irqs(struct mmc_host *host)
> > > >  {
> > > >         mmc_claim_host(host);
> > > >         if (host->sdio_irqs) {
> > > > -               host->sdio_irq_pending = true;
> > > >                 process_sdio_pending_irqs(host);
> > > >                 if (host->ops->ack_sdio_irq)
> > > >                         host->ops->ack_sdio_irq(host);
> > > > @@ -128,6 +131,7 @@ void sdio_irq_work(struct work_struct *work)
> > > >
> > > >  void sdio_signal_irq(struct mmc_host *host)
> > > >  {
> > > > +       host->sdio_irq_pending = true;
> > >
> > > Is this safe to do without claiming the host or any other type of
> > > locking?  sdio_signal_irq() is called directly from the interrupt
> > > handler on dw_mmc with no locks held at all.  Could we have races /
> > > problems with weakly ordered memory?
> >
> > At this point, for $subject patch and @subject series, I don't see any
> > issues. But perhaps when we go forward and start using the flag
> > slightly differently.
>
> Lockless concurrency always makes my head hurt (especially when I try
> to consider weakly ordered memory) and I've learned that the only way
> I can reason about it and have any belief that I got it right is to
> always make sure I access values in a context where things are locked.
> :-P
>
> Let's see if I can figure out any actual problem, though...
>
> Certainly the queue_delayed_work() would act as a barrier so you don't
> have to worry about the worker not seeing the "= true".
>
> I suppose it's definitely possible that (if the worker is already
> running) that our "= true" will get clobbered by an "= false" from a
> previous instance of the worker running.  I guess that's unlikely
> because we can't get a second IRQ signaled until the "->ack_sdio_irq"
> ran and presumably there's enough stuff after the "= false" that one
> of them would have a barrier that made sure that the "= false" didn't
> affect us in a delayed way.
>
> So I guess we're fine...

Yeah, the trick is simply that we don't expect another IRQ being
signaled via sdio_signal_irq(), until the ->ack_sdio_irq() has been
invoked.

And even if that happens, the works case scenario would be that we
would skip the 1-func optimized pat and end up reading the poll
CCCR_INTx. This should be fine.

Kind regards
Uffe
