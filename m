Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC30AC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A0D2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3Y+QESV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfG1L5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:57:09 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40748 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfG1L5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:57:09 -0400
Received: by mail-vk1-f193.google.com with SMTP id s16so11490963vke.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3lH9hgKaTbuYdNfOB/tOltKQl4H3gn2fptv0wIlIXg=;
        b=N3Y+QESVmzOJ8PMy0zrtHZZ3HByD4Sui7c24OezXnzAJVg4euE5MO3YBjWLntUi8VO
         r117YtS+Ic+cxhFvo2WiAWWHhzuvi/bK0YVvWon+MaNnsUjXA4C1wwt/KV3X1GjHqgz/
         SWVx0yYNHqnzcNoE2xzyJ6K+B+Amb3tCtdGX7DmSq5A+dVuF+wKyCAoHW8GcXAq/SUoy
         3xVI41T5iD4YB3RqcDLHmBqyAr0b8hafLu7DdMfC2xgkFAJ/YOHhq6rLeqlFWQR2o0F+
         4z3FVuU55AJHOH7sADnUuGeRT1wF7ePa2+cOGYTqtlbBlYO1FrGTrtbztilQ345SV4nk
         mUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3lH9hgKaTbuYdNfOB/tOltKQl4H3gn2fptv0wIlIXg=;
        b=tO7HLwoE/BmMzQnxfMqi0dHitrbvtwtvpqGrrEYny5AMLAqp0Lc4strcZpRlMFuv8u
         TteLhcSkJZVhrDIdGdWIT42aQ31Qn8Fc9Qxb021BhAX6steGoOg8L0MWs3Yh1PQLbSj9
         fozFfVAQ6PhZ17fyBI3JN4O6t/j0ppqsElk+K2nYT+hdXtdfI7SUDBWERdCnaLZb2vwh
         wapq1gHyvWhuUEL25sOMEh+mIg5GMJKhAHZdir9RabC3jWAOh7cIAK/oUCbXbOxZCrVa
         wKZ/I0IrW5VIGcaBusDIo0KerGwM0Qe3xD6Vi/hlvZkvCAuaoEhMEHFlDqc2Dy9nNvFI
         BVcA==
X-Gm-Message-State: APjAAAUWPnAwCAo2+1dNyrLPLO789TNMYAqlGKnqkWcyNrBqLbGng3bB
        tobsb1Y5UD4gW1H+2DCRp/a4UvvTpmHlF4J1hws=
X-Google-Smtp-Source: APXvYqx9AEc1ePPVANndY4Clc4knMPtmO6m18HDCdR5YClvXwRIq6XkynodA/HwWtS2q43/t4nmcnGWVarKtessrc8Y=
X-Received: by 2002:ac5:c907:: with SMTP id t7mr17500318vkl.30.1564315027217;
 Sun, 28 Jul 2019 04:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190728112818.30397-1-oded.gabbay@gmail.com> <20190728112818.30397-10-oded.gabbay@gmail.com>
 <20190728114435.GB12033@kroah.com>
In-Reply-To: <20190728114435.GB12033@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 28 Jul 2019 14:56:40 +0300
Message-ID: <CAFCwf11bL_2S__bc+wYpK=1_Ug2sJ6ZWnFiYA1dMDJxpsRZ5dA@mail.gmail.com>
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

On Sun, Jul 28, 2019 at 2:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 28, 2019 at 02:28:18PM +0300, Oded Gabbay wrote:
> > This patch removes the limitation of a single process that can open the
> > device.
> >
> > Now, there is no limitation on the number of processes that can open the
> > device and have a valid FD.
> >
> > However, only a single process can perform compute operations. This is
> > enforced by allowing only a single process to have a compute context.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/context.c          | 100 +++++++++++++++------
> >  drivers/misc/habanalabs/device.c           |  18 ++--
> >  drivers/misc/habanalabs/habanalabs.h       |   1 -
> >  drivers/misc/habanalabs/habanalabs_drv.c   |   8 --
> >  drivers/misc/habanalabs/habanalabs_ioctl.c |   7 +-
> >  5 files changed, 85 insertions(+), 49 deletions(-)
> >
> > diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
> > index 57bbe59da9b6..f64220fc3a55 100644
> > --- a/drivers/misc/habanalabs/context.c
> > +++ b/drivers/misc/habanalabs/context.c
> > @@ -56,7 +56,7 @@ void hl_ctx_do_release(struct kref *ref)
> >       kfree(ctx);
> >  }
> >
> > -int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
> > +static int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
> >  {
> >       struct hl_ctx_mgr *mgr = &hpriv->ctx_mgr;
> >       struct hl_ctx *ctx;
> > @@ -89,9 +89,6 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
> >       /* TODO: remove for multiple contexts per process */
> >       hpriv->ctx = ctx;
> >
> > -     /* TODO: remove the following line for multiple process support */
> > -     hdev->compute_ctx = ctx;
> > -
> >       return 0;
> >
> >  remove_from_idr:
> > @@ -206,13 +203,22 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
> >       int rc;
> >
> >       /* First thing, to minimize latency impact, check if context exists.
> > -      * Also check if it matches the requirements. If so, exit immediately
> > +      * This is relevant for the "steady state", where a process context
> > +      * already exists, and we want to minimize the latency in command
> > +      * submissions. In that case, we want to see if we can quickly exit
> > +      * with a valid answer.
> > +      *
> > +      * If a context doesn't exists, we must grab the mutex. Otherwise,
> > +      * there can be nasty races in case of multi-threaded application.
> > +      *
> > +      * So, if the context exists and we don't need a compute context,
> > +      * that's fine. If it exists and the context we have is the compute
> > +      * context, that's also fine. Other then that, we can't check anything
> > +      * without the mutex.
> >        */
> > -     if (hpriv->ctx) {
> > -             if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
> > -                     return false;
> > +     if ((hpriv->ctx) && ((!requires_compute_ctx) ||
> > +                                     (hdev->compute_ctx == hpriv->ctx)))
> >               return true;
> > -     }
> >
> >       mutex_lock(&hdev->lazy_ctx_creation_lock);
> >
> > @@ -222,35 +228,73 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
> >        * creation of a context
> >        */
> >       if (hpriv->ctx) {
> > -             if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
> > +             if ((!requires_compute_ctx) ||
> > +                                     (hdev->compute_ctx == hpriv->ctx))
> > +                     goto unlock_mutex;
> > +
> > +             if (hdev->compute_ctx) {
> >                       valid = false;
> > -             goto unlock_mutex;
> > -     }
> > +                     goto unlock_mutex;
> > +             }
> >
> > -     /* If we already have a compute context, there is no point
> > -      * of creating one in case we are called from ioctl that needs
> > -      * a compute context
> > -      */
> > -     if ((hdev->compute_ctx) && (requires_compute_ctx)) {
> > +             /* If we reached here, it means we have a non-compute context,
> > +              * but there is no compute context on the device. Therefore,
> > +              * we can try to "upgrade" the existing context to a compute
> > +              * context
> > +              */
> > +             dev_dbg_ratelimited(hdev->dev,
> > +                             "Non-compute context %d exists\n",
> > +                             hpriv->ctx->asid);
> > +
> > +     } else if ((hdev->compute_ctx) && (requires_compute_ctx)) {
> > +
> > +             /* If we already have a compute context in the device, there is
> > +              * no point of creating one in case we are called from ioctl
> > +              * that needs a compute context
> > +              */
> >               dev_err(hdev->dev,
> >                       "Can't create new compute context as one already exists\n");
> >               valid = false;
> >               goto unlock_mutex;
> > -     }
> > +     } else {
> > +             /* If we reached here it is because there isn't a context for
> > +              * the process AND there is no compute context or compute
> > +              * context wasn't required. In any case, must create a context
> > +              * for the process
> > +              */
> >
> > -     rc = hl_ctx_create(hdev, hpriv);
> > -     if (rc) {
> > -             dev_err(hdev->dev, "Failed to create context %d\n", rc);
> > -             valid = false;
> > -             goto unlock_mutex;
> > +             rc = hl_ctx_create(hdev, hpriv);
> > +             if (rc) {
> > +                     dev_err(hdev->dev, "Failed to create context %d\n", rc);
> > +                     valid = false;
> > +                     goto unlock_mutex;
> > +             }
> > +
> > +             dev_dbg_ratelimited(hdev->dev, "Created context %d\n",
> > +                                     hpriv->ctx->asid);
> >       }
> >
> > -     /* Device is IDLE at this point so it is legal to change PLLs.
> > -      * There is no need to check anything because if the PLL is
> > -      * already HIGH, the set function will return without doing
> > -      * anything
> > +     /* If we reached here then either we have a new context, or we can
> > +      * upgrade a non-compute context to a compute context. Do the upgrade
> > +      * only if the caller required a compute context
> >        */
> > -     hl_device_set_frequency(hdev, PLL_HIGH);
> > +     if (requires_compute_ctx) {
> > +             WARN(hdev->compute_ctx,
> > +                     "Compute context exists but driver is setting a new one");
>
> This will trigger syzbot and will reboot machines that have
> 'panic-on-warn' set (i.e. all cloud systems).  So be _VERY_ careful
> about this.
>
> If a user can trigger this, do not use WARN(), that's not what it is
> for.
>
> thanks,
>
> greg k-h

I see...
I'll replace it with dev_crit, but I wanted to ask if you recommend to
never use WARN in drivers ? Just use it in kernel core code ?

Thanks,
Oded
