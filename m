Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63CAC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 12:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8CC2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 12:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnDnLGjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfG1MSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 08:18:54 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33479 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfG1MSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 08:18:54 -0400
Received: by mail-ua1-f67.google.com with SMTP id g11so406422uak.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3D+Mw917YGBxgG0f/A+xEZY8nxwW2qn3vEkoPWx4bls=;
        b=EnDnLGjVebCcL1JGEMf0i+SL2OkQluWLX5O1sfm61QmAJu+0SqZ4FQzy9vQ8yEbm1u
         eqxQq0WuKzbwVT5K6N8P1mwJGmSKYLI/qMt1AMQy082Dw883N+OgIngV6SWO92Rpsa4B
         m1X+lq9KZ2UCsujfaZCyWK22oUM5D2D+N5l8Dox0sq1eB6734/VmPSfYq/XsSBgQjcxy
         ZUMopxLWuBeWw7r+KEuzO0b+ZkdC070pTK4FkeqBY1+85+HiOVjfzVij2sSZyv2lr6zz
         p7xsQuRYcJ1QW7qXFwV5LItcbs2ZEg251Edck6lvGOKqg8rIOscAjQbhjMmItZ0/UAxC
         PnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3D+Mw917YGBxgG0f/A+xEZY8nxwW2qn3vEkoPWx4bls=;
        b=Wr27ylTbpe84Y7SNa6M7lHBJi4FiieP6GxbE0I96cV2wE5wt38XMFXmlow2K3fUp5k
         On871AtVLdsNvK8ED9KoxgegRZL6gKpX2ffN8rjeinhGG7UA0E616wlrZkODlqG1fqMC
         7l/3xkx7zfENObjqtqR2fYgjTjDPWnT7pFVq3HaytaTVYXKp+lsDtkZecEOJdJ99M+yE
         9I/5nfB+m4kH6k4Klw7sn90tLR5Hs8Rz+RudSwrxBvsM3RdiWfSU+gR/Vr0pxC0K3jCw
         GtE0nCK9ndPuKf5/U4t5vjg7DEqvobsaUtXOIjCr2xYXQ6GP1z+FiM5AAWsSzK8JcEKS
         wwtw==
X-Gm-Message-State: APjAAAW009YSryjVtZNGn/3yhKUZ3Fk+R7iCokzRn2mnN5jlhcAnfgwC
        qFXGrb6+4gLmF0nFqFXiPMWs3X3dkS5OKC6WWAM=
X-Google-Smtp-Source: APXvYqxQbZESPUrOZxIojN4k6YI6X1bQkBAr13hCqkL2be7V/fH1s/KqAZd+tU1uQrYQ5XbLGZXmPBwhBf4kEBYgKfU=
X-Received: by 2002:a9f:230c:: with SMTP id 12mr21072909uae.85.1564316332805;
 Sun, 28 Jul 2019 05:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190728112818.30397-1-oded.gabbay@gmail.com> <20190728112818.30397-10-oded.gabbay@gmail.com>
 <20190728114435.GB12033@kroah.com> <CAFCwf11bL_2S__bc+wYpK=1_Ug2sJ6ZWnFiYA1dMDJxpsRZ5dA@mail.gmail.com>
 <20190728120409.GA16299@kroah.com> <CAFCwf11Jx29=Q-K60F+67AvJZhLWD=2di4pv--DR0=F2-M-TTw@mail.gmail.com>
 <20190728121223.GA17311@kroah.com>
In-Reply-To: <20190728121223.GA17311@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 28 Jul 2019 15:18:26 +0300
Message-ID: <CAFCwf11rm1fQ3Uaz9Rq8=r-EeAcmTGpk9U4kGz28sSqTxETRUA@mail.gmail.com>
Subject: Re: [PATCH 9/9] habanalabs: allow multiple processes to open FD
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 3:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 28, 2019 at 03:06:16PM +0300, Oded Gabbay wrote:
> > On Sun, Jul 28, 2019 at 3:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Jul 28, 2019 at 02:56:40PM +0300, Oded Gabbay wrote:
> > > > On Sun, Jul 28, 2019 at 2:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sun, Jul 28, 2019 at 02:28:18PM +0300, Oded Gabbay wrote:
> > > > > > This patch removes the limitation of a single process that can open the
> > > > > > device.
> > > > > >
> > > > > > Now, there is no limitation on the number of processes that can open the
> > > > > > device and have a valid FD.
> > > > > >
> > > > > > However, only a single process can perform compute operations. This is
> > > > > > enforced by allowing only a single process to have a compute context.
> > > > > >
> > > > > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > > > > ---
> > > > > >  drivers/misc/habanalabs/context.c          | 100 +++++++++++++++------
> > > > > >  drivers/misc/habanalabs/device.c           |  18 ++--
> > > > > >  drivers/misc/habanalabs/habanalabs.h       |   1 -
> > > > > >  drivers/misc/habanalabs/habanalabs_drv.c   |   8 --
> > > > > >  drivers/misc/habanalabs/habanalabs_ioctl.c |   7 +-
> > > > > >  5 files changed, 85 insertions(+), 49 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
> > > > > > index 57bbe59da9b6..f64220fc3a55 100644
> > > > > > --- a/drivers/misc/habanalabs/context.c
> > > > > > +++ b/drivers/misc/habanalabs/context.c
> > > > > > @@ -56,7 +56,7 @@ void hl_ctx_do_release(struct kref *ref)
> > > > > >       kfree(ctx);
> > > > > >  }
> > > > > >
> > > > > > -int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
> > > > > > +static int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
> > > > > >  {
> > > > > >       struct hl_ctx_mgr *mgr = &hpriv->ctx_mgr;
> > > > > >       struct hl_ctx *ctx;
> > > > > > @@ -89,9 +89,6 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
> > > > > >       /* TODO: remove for multiple contexts per process */
> > > > > >       hpriv->ctx = ctx;
> > > > > >
> > > > > > -     /* TODO: remove the following line for multiple process support */
> > > > > > -     hdev->compute_ctx = ctx;
> > > > > > -
> > > > > >       return 0;
> > > > > >
> > > > > >  remove_from_idr:
> > > > > > @@ -206,13 +203,22 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
> > > > > >       int rc;
> > > > > >
> > > > > >       /* First thing, to minimize latency impact, check if context exists.
> > > > > > -      * Also check if it matches the requirements. If so, exit immediately
> > > > > > +      * This is relevant for the "steady state", where a process context
> > > > > > +      * already exists, and we want to minimize the latency in command
> > > > > > +      * submissions. In that case, we want to see if we can quickly exit
> > > > > > +      * with a valid answer.
> > > > > > +      *
> > > > > > +      * If a context doesn't exists, we must grab the mutex. Otherwise,
> > > > > > +      * there can be nasty races in case of multi-threaded application.
> > > > > > +      *
> > > > > > +      * So, if the context exists and we don't need a compute context,
> > > > > > +      * that's fine. If it exists and the context we have is the compute
> > > > > > +      * context, that's also fine. Other then that, we can't check anything
> > > > > > +      * without the mutex.
> > > > > >        */
> > > > > > -     if (hpriv->ctx) {
> > > > > > -             if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
> > > > > > -                     return false;
> > > > > > +     if ((hpriv->ctx) && ((!requires_compute_ctx) ||
> > > > > > +                                     (hdev->compute_ctx == hpriv->ctx)))
> > > > > >               return true;
> > > > > > -     }
> > > > > >
> > > > > >       mutex_lock(&hdev->lazy_ctx_creation_lock);
> > > > > >
> > > > > > @@ -222,35 +228,73 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
> > > > > >        * creation of a context
> > > > > >        */
> > > > > >       if (hpriv->ctx) {
> > > > > > -             if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
> > > > > > +             if ((!requires_compute_ctx) ||
> > > > > > +                                     (hdev->compute_ctx == hpriv->ctx))
> > > > > > +                     goto unlock_mutex;
> > > > > > +
> > > > > > +             if (hdev->compute_ctx) {
> > > > > >                       valid = false;
> > > > > > -             goto unlock_mutex;
> > > > > > -     }
> > > > > > +                     goto unlock_mutex;
> > > > > > +             }
> > > > > >
> > > > > > -     /* If we already have a compute context, there is no point
> > > > > > -      * of creating one in case we are called from ioctl that needs
> > > > > > -      * a compute context
> > > > > > -      */
> > > > > > -     if ((hdev->compute_ctx) && (requires_compute_ctx)) {
> > > > > > +             /* If we reached here, it means we have a non-compute context,
> > > > > > +              * but there is no compute context on the device. Therefore,
> > > > > > +              * we can try to "upgrade" the existing context to a compute
> > > > > > +              * context
> > > > > > +              */
> > > > > > +             dev_dbg_ratelimited(hdev->dev,
> > > > > > +                             "Non-compute context %d exists\n",
> > > > > > +                             hpriv->ctx->asid);
> > > > > > +
> > > > > > +     } else if ((hdev->compute_ctx) && (requires_compute_ctx)) {
> > > > > > +
> > > > > > +             /* If we already have a compute context in the device, there is
> > > > > > +              * no point of creating one in case we are called from ioctl
> > > > > > +              * that needs a compute context
> > > > > > +              */
> > > > > >               dev_err(hdev->dev,
> > > > > >                       "Can't create new compute context as one already exists\n");
> > > > > >               valid = false;
> > > > > >               goto unlock_mutex;
> > > > > > -     }
> > > > > > +     } else {
> > > > > > +             /* If we reached here it is because there isn't a context for
> > > > > > +              * the process AND there is no compute context or compute
> > > > > > +              * context wasn't required. In any case, must create a context
> > > > > > +              * for the process
> > > > > > +              */
> > > > > >
> > > > > > -     rc = hl_ctx_create(hdev, hpriv);
> > > > > > -     if (rc) {
> > > > > > -             dev_err(hdev->dev, "Failed to create context %d\n", rc);
> > > > > > -             valid = false;
> > > > > > -             goto unlock_mutex;
> > > > > > +             rc = hl_ctx_create(hdev, hpriv);
> > > > > > +             if (rc) {
> > > > > > +                     dev_err(hdev->dev, "Failed to create context %d\n", rc);
> > > > > > +                     valid = false;
> > > > > > +                     goto unlock_mutex;
> > > > > > +             }
> > > > > > +
> > > > > > +             dev_dbg_ratelimited(hdev->dev, "Created context %d\n",
> > > > > > +                                     hpriv->ctx->asid);
> > > > > >       }
> > > > > >
> > > > > > -     /* Device is IDLE at this point so it is legal to change PLLs.
> > > > > > -      * There is no need to check anything because if the PLL is
> > > > > > -      * already HIGH, the set function will return without doing
> > > > > > -      * anything
> > > > > > +     /* If we reached here then either we have a new context, or we can
> > > > > > +      * upgrade a non-compute context to a compute context. Do the upgrade
> > > > > > +      * only if the caller required a compute context
> > > > > >        */
> > > > > > -     hl_device_set_frequency(hdev, PLL_HIGH);
> > > > > > +     if (requires_compute_ctx) {
> > > > > > +             WARN(hdev->compute_ctx,
> > > > > > +                     "Compute context exists but driver is setting a new one");
> > > > >
> > > > > This will trigger syzbot and will reboot machines that have
> > > > > 'panic-on-warn' set (i.e. all cloud systems).  So be _VERY_ careful
> > > > > about this.
> > > > >
> > > > > If a user can trigger this, do not use WARN(), that's not what it is
> > > > > for.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > I see...
> > > > I'll replace it with dev_crit, but I wanted to ask if you recommend to
> > > > never use WARN in drivers ? Just use it in kernel core code ?
> > >
> > > It should never be used anywhere, unless you are about to crash.  You
> > > should just properly fix things up, log the error, and move on.  Same
> > > goes for a driver as well as "core" kernel code.
> > >
> > > If a user can trigger a WARN message, then that's a real big problem.
> > > Again, think of 'panic-on-warn' systems.
> > >
> > > If the hardware has hosed the system so bad that you can not do anything
> > > else, just stop allowing access to the hardware.  You shouldn't cause
> > > the system to crash/reboot whenever possible.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > I understand. I always thought the above applies mostly to BUG() and
> > that's why it is frowned upon, and instead we should use WARN().
> > But I get your point about the "panic-on-warn" systems.
>
> If you just want to warn the user about something that they can do
> something about (and not just spam the kernel log), use dev_warn(),
> that's what it is there for :)
>
> thanks,
>
> greg k-h

This specific message is about something the user can do. This
indicates a bug in the driver's code. Think of it as a sanity check.
It can't be affected by the user request/action.

Oded
