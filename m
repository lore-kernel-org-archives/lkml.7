Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCFEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79862087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8KFzI6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfH3GI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:08:57 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45753 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfH3GI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:08:57 -0400
Received: by mail-vk1-f195.google.com with SMTP id r13so1307765vke.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 23:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ztWsfOXVEpHFtnIq8w7cRDu21xVxyn3+pw5q+nRPwI=;
        b=m8KFzI6uZubMkxC41B6Jdts4IJdQQyK44/dYRqwiOtb0uTuPsPARtq8945B1w8n7dV
         S39E8NSSivYfOifle2Ytq3v4i9p6Kkb16t+RjCKG6GbOkuy2lqItqeoZc4MKEQSzEQJ+
         DkKMVXFVu9fAP2iGVJjULVSOOsUCBL/7Byq9URBJDgnc16NWMBR2244iZozpESWzbaMW
         Z7p3WldZk2tSHCXRKQhddG0VJyfXxkV0JXc1QPGiCjxhmWIA+gFE+Y8rk5onh3v8cgbL
         SRXqMaY2aGl/K8u//7HamHd4BdOesuuh3kQ/VJVUGO+yiN4HJ44CpAI0uYDxCchb61B2
         5HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ztWsfOXVEpHFtnIq8w7cRDu21xVxyn3+pw5q+nRPwI=;
        b=lcUVoHlWtFaMQX4VgaELfjSbI+FK/cl1WMgJ8BUiGmZbN4BO9ZHs4jpNSJMtnvDKgg
         6sZCdQJS+SdGl6RmloOdB9JSe9NiIKlTflMVNR7SZL2/ISYczxjTn+SLv5uYVqSrigP3
         mRO9uzbcoEqeZnKR5UyzN2Yo9Bog+bA2gNjhyS//UOJxwt/euBHqBTmo07MLI8L4nOtK
         hKaFpz0JOXCI5RX58LIhwL8yTehuybhUc3fZ5xzSvlwxZNiaQZwUM3CUIECxq8BLrXPs
         /13flTe1ddbLymEytUkxok1v5APjvV5yiHO0g5yntJyvvFNNdvnxaATp4DK4hWIv5SzZ
         85wA==
X-Gm-Message-State: APjAAAXXhSieWqC+f9axmNz62R+a2qjWUhuMdcDnwBiVxgt4PaTIzx7z
        trIqxWRyi2z6FBpaOWb5Ja5bwQkX0548nVqOTehEiw==
X-Google-Smtp-Source: APXvYqw1nBaGGkN8cAVj+dX/S14oVak25EH2jB36+YgUNs6gJOzGxNaYHuatBoYnPGL9B0AKB22xmLaAAvEcn9Y4yt4=
X-Received: by 2002:a1f:1486:: with SMTP id 128mr7296483vku.40.1567145336013;
 Thu, 29 Aug 2019 23:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190828214620.66003-1-mka@chromium.org> <20190828214620.66003-2-mka@chromium.org>
 <CAPDyKFr2R-ta5Xob12-6k=+mXXt0NowJ=dpLGJu10qhn7cB1HQ@mail.gmail.com>
 <20190829171555.GD70797@google.com> <CAD=FV=VhAFGZusYac8hqYNZ9t+ipTZ5EAo5qY5+A8jA4xjw2vg@mail.gmail.com>
In-Reply-To: <CAD=FV=VhAFGZusYac8hqYNZ9t+ipTZ5EAo5qY5+A8jA4xjw2vg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Aug 2019 08:08:18 +0200
Message-ID: <CAPDyKFo-NkkYyNNxtU9PpP7aG5zRd-pXsxOujdN53J=uAezieA@mail.gmail.com>
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

On Thu, 29 Aug 2019 at 19:40, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Aug 29, 2019 at 10:16 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > > In one way, this change makes sense as it adopts the legacy behavior,
> > > signaling "cached" SDIO IRQs also for the new SDIO irq work interface.
> > >
> > > However, there is at least one major concern I see with this approach.
> > > That is, in the execution path for sdio_signal_irq() (or calling
> > > wake_up_process() for the legacy path), we may end up invoking the
> > > SDIO func's ->irq_handler() callback, as to let the SDIO func driver
> > > to consume the SDIO IRQ.
> > >
> > > The problem with this is, that the corresponding SDIO func driver may
> > > not have been system resumed, when the ->irq_handler() callback is
> > > invoked.
> >
> > While debugging the the problem with btmrvl I found that this is
> > already the case without the patch, just not during resume, but when
> > suspending. The func driver suspends before the SDIO bus and
> > interrupts can keep coming in. These are processed while the func
> > driver is suspended, until the SDIO core starts dropping the
> > interrupts.
> >
> > And I think it is also already true at resume time: mmc_sdio_resume()
> > re-enables SDIO IRQs and disables dropping them.
>
> I would also note that this matches the design of the normal system
> suspend/resume functions.  Interrupts continue to be enabled even
> after the "suspend" call is made for a device.  Presumably this is so
> that the suspend function can make use of interrupts even if there is
> no other reason.

I understand and you have a good point!

However, in my experience, the most common generic case, is that it's
a bad idea to let a device process interrupts once they have been
suspended. This also applies to runtime suspend (via runtime PM).

> If it's important for a device to stop getting
> interrupts after the "suspend" function is called then it's up to that
> device to re-configure the device to stop giving interrupts.

Again, you have a very good point. The corresponding driver for the
device in question is responsible for dealing with this.

Then, for this particular case, the SDIO func driver scenario, how
would that work?

For example, assume that the SDIO func driver can't process IRQs after
its been system suspended, however it still wants the IRQs to be
re-kicked to consume them once it has been resumed?

Or are you saying that the SDIO func driver for cases when IRQs can't
be consumed during system suspend, that is should call
sdio_release_irq() (then reclaim the IRQ once resumed)?

Kind regards
Uffe
