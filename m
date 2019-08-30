Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5A2C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA802073F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j04hvyN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfH3KjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:39:03 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40359 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfH3KjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:39:03 -0400
Received: by mail-vs1-f65.google.com with SMTP id i128so4455177vsc.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/UGLkrJRvm+li0YZyHFEsmW2SjqLYvPQTm0FTUlv6Ag=;
        b=j04hvyN72L+zDRpxCWzBS9vYgYaPDy1tVt4SfRR8Bg++NMXQKt+4ImKHJeWP/+L4+f
         FsxNd8HSMpPK/H9A2pJjH88qCwKM39QTQ49uSVQbaxvvRHcHV0Yi2ueGmHw8hhb5lNZJ
         9mb+mys0fDmWSR2WSvBvnmBENeXqQAk69lbbmA7s/5UDWRVm0fAqQ/sloezQoFx8XxwV
         ZqWGjgaxPbEj0NRW3jQoQO2b99l5bTSvSk2pimXTSNcJD3tfqvA0TuoPnK6r2c9bfrzf
         spLwuJryZa6UIdcvwpdkMTb80NQgntry5FDEO2x33aidLwWiqkQ5zWHs0Eg4pwlbgts5
         4hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UGLkrJRvm+li0YZyHFEsmW2SjqLYvPQTm0FTUlv6Ag=;
        b=I8C0ngnDaDPRoZrYf7rkUGx3q8MPaLtJovyyZf7cfY+PaxGp4DIpo7lWUNpcu4tsAr
         J7VV5ITQU+DnDfN7b4/lOO+SWFlR65V7SiqXbT7XaNwbjCynUC3XCLMfQAh6p8v2dr87
         nqPQ6fnkc6GdT1MRPypCs7w62OerzUBdn8yQN1GEISjhD9wflZI1nHnwE/3Am53KQBtW
         5ndc6U8PytmjcLFI+35s3/TnKleNE3/8xLuen0othbGM5NTqDUrUISbmbT0KpnAWQjXh
         jwGkLHKEKZCguQO56YwbTiSq0z9A7NMF/vojxWM0FmkTcr+WoX/+Pm5pb+HCJM5bBfMi
         5QDQ==
X-Gm-Message-State: APjAAAWkxj1D+FVWBoHZqo7UzfRdkEhd+OyKx2bsPWPj3RdDJ7hMQCEK
        L20+6WuO2ukkL285AuW9QonMTAsJF3SW9Q1HgozuLA==
X-Google-Smtp-Source: APXvYqyexb/mfNJJQsyEuU1xMvNLp6YAZf+F2QKjVy8WDgPjJur+u8KWulIE/o4fnV72MYujkJgPj7YRlPDTX5ADcM4=
X-Received: by 2002:a67:347:: with SMTP id 68mr8224648vsd.35.1567161542239;
 Fri, 30 Aug 2019 03:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190828214620.66003-1-mka@chromium.org> <20190828214620.66003-2-mka@chromium.org>
 <CAPDyKFr2R-ta5Xob12-6k=+mXXt0NowJ=dpLGJu10qhn7cB1HQ@mail.gmail.com>
 <20190829171555.GD70797@google.com> <CAD=FV=VhAFGZusYac8hqYNZ9t+ipTZ5EAo5qY5+A8jA4xjw2vg@mail.gmail.com>
 <CAPDyKFo-NkkYyNNxtU9PpP7aG5zRd-pXsxOujdN53J=uAezieA@mail.gmail.com>
In-Reply-To: <CAPDyKFo-NkkYyNNxtU9PpP7aG5zRd-pXsxOujdN53J=uAezieA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Aug 2019 12:38:26 +0200
Message-ID: <CAPDyKFp-p_iunzFd8vSuuP0ubd7WzPY4XOzCoo=EEFQ8rscWCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Run handlers for pending SDIO interrupts
 on resume
To:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 at 08:08, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 29 Aug 2019 at 19:40, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Aug 29, 2019 at 10:16 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > > In one way, this change makes sense as it adopts the legacy behavior,
> > > > signaling "cached" SDIO IRQs also for the new SDIO irq work interface.
> > > >
> > > > However, there is at least one major concern I see with this approach.
> > > > That is, in the execution path for sdio_signal_irq() (or calling
> > > > wake_up_process() for the legacy path), we may end up invoking the
> > > > SDIO func's ->irq_handler() callback, as to let the SDIO func driver
> > > > to consume the SDIO IRQ.
> > > >
> > > > The problem with this is, that the corresponding SDIO func driver may
> > > > not have been system resumed, when the ->irq_handler() callback is
> > > > invoked.
> > >
> > > While debugging the the problem with btmrvl I found that this is
> > > already the case without the patch, just not during resume, but when
> > > suspending. The func driver suspends before the SDIO bus and
> > > interrupts can keep coming in. These are processed while the func
> > > driver is suspended, until the SDIO core starts dropping the
> > > interrupts.
> > >
> > > And I think it is also already true at resume time: mmc_sdio_resume()
> > > re-enables SDIO IRQs and disables dropping them.
> >
> > I would also note that this matches the design of the normal system
> > suspend/resume functions.  Interrupts continue to be enabled even
> > after the "suspend" call is made for a device.  Presumably this is so
> > that the suspend function can make use of interrupts even if there is
> > no other reason.
>
> I understand and you have a good point!
>
> However, in my experience, the most common generic case, is that it's
> a bad idea to let a device process interrupts once they have been
> suspended. This also applies to runtime suspend (via runtime PM).
>
> > If it's important for a device to stop getting
> > interrupts after the "suspend" function is called then it's up to that
> > device to re-configure the device to stop giving interrupts.
>
> Again, you have a very good point. The corresponding driver for the
> device in question is responsible for dealing with this.
>
> Then, for this particular case, the SDIO func driver scenario, how
> would that work?
>
> For example, assume that the SDIO func driver can't process IRQs after
> its been system suspended, however it still wants the IRQs to be
> re-kicked to consume them once it has been resumed?
>
> Or are you saying that the SDIO func driver for cases when IRQs can't
> be consumed during system suspend, that is should call
> sdio_release_irq() (then reclaim the IRQ once resumed)?

I have been thinking more about this. The above seems like a
reasonable assumption to make. So, I started to hack and improve the
SDIO IRQ management, again.

Just to be clear, I like the approach Matthias has taken here, which
means reading SDIO_CCCR_INTx register at system resume, to understand
whether there are some SDIO IRQs that needs to be processed, however
there are some more corner cases that needs to be covered as well.

Let me post something on Monday, then we can continue our discussions
and run some tests as well.

Have nice weekend!
Uffe
