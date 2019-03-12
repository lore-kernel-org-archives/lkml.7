Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCE7214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9gpRqoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfCLKAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:00:08 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45498 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfCLKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:00:08 -0400
Received: by mail-vs1-f66.google.com with SMTP id n14so1177979vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22R+IWR6zNRbwiOp0YIcQYmzAQQJBulKj5yJPbJlby0=;
        b=q9gpRqoQqWyC5U8BOVpQ7KjY9Iu5c609tzRuH7mkfwGa0QlQn6KRPq49IdR/SlNk5p
         hKdym3Y+w1GgFlWaTuqitUxUwvAL0L8MWnLEDPjRt/kMyvEFU0uQNmldGxPD3DyfStlw
         cmCfZD1Gj3e2/2QZva8qEudMJkgCW8vnAicZkcVZ+yhPVFVoldYMXmARiGWuOpNT50IR
         9pOnIFFiAb71ByIYh2jyBsrpCdogf1ZVrqIkPiz4oSgFui84CbUYbarIqxmgsyAUi0WE
         fqTI+Mz5OPQQuPcrnqS4DngGyuLjxlgxJKrhon7cXkXQ+9iUXeOtzaQMdV49u9RKZU08
         rd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22R+IWR6zNRbwiOp0YIcQYmzAQQJBulKj5yJPbJlby0=;
        b=G2ZMEEDEftKnElVumL+l7rVcZO1zRrFCSIYSM/DNpdCm2TeNPqhB3oJ7iFmDJDt9jd
         j8PqnhS7/Qvd+OdTRkIT3yQmku5N9erXpBRb1wWLkq8WuaE86e2s8pKB+Dg9g5qNRdsp
         wosZkn1FNFyeS+IkoIqXvdHw+iMXpFws13MTMm5/bm1NV1RGXiMSe2OB7AQFqQrxcsqJ
         AoWS3BpOYFEnc7WOHACbJrX/UzjIdaQgvPd/pjPHgmxw2KsHWN4RnFF3PZT+w9jRQWMU
         FabPxmIknDjylqsWY6O+D806az8g5I3GzbNgE7F2wJV3eA849u71xh0qREKC7K77HOMn
         k0tg==
X-Gm-Message-State: APjAAAUveYrqV03/mCDCK5lc8pG+6PkWR1Q2qMcQ0vShOsX+6Y7qww36
        VDr1fGJ3Pq4jsE2wVnvhESRkpt6euyAZGKDxNFkA3Q==
X-Google-Smtp-Source: APXvYqzSRwMaU7cgx3dE3XVykznS+F5g8D1Rd8nWhviA/RLs0F8hMB5vNxsLjyLJENAL/+0z6syjJDOnjxhG3spEm8o=
X-Received: by 2002:a67:fe51:: with SMTP id m17mr1625817vsr.35.1552384806968;
 Tue, 12 Mar 2019 03:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190305125526.21360-1-ulf.hansson@linaro.org> <1896578.0Ev3Nro9jJ@aspire.rjw.lan>
In-Reply-To: <1896578.0Ev3Nro9jJ@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Mar 2019 10:59:30 +0100
Message-ID: <CAPDyKFpOgbuK_0GcgpM52HR0bCtMAkaXgmo3bNjhubY2FNZPPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / Runtime: Consolidate code to get
 active/suspended time
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 at 13:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, March 5, 2019 1:55:26 PM CET Ulf Hansson wrote:
> > In a step to consolidate code around fetching the runtime PM active/suspend
> > time for a device, let's re-factor the existing pm_runtime_suspended_time()
> > and add a new corresponding pm_runtime_active_time(). Make the latter
> > shared internally to the PM core, as in following changes it starts making
> > use of it.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/power.h   |  1 +
> >  drivers/base/power/runtime.c | 14 ++++++++++++--
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> > index c511def48b48..ec33fbdb919b 100644
> > --- a/drivers/base/power/power.h
> > +++ b/drivers/base/power/power.h
> > @@ -21,6 +21,7 @@ static inline void pm_runtime_early_init(struct device *dev)
> >  extern void pm_runtime_init(struct device *dev);
> >  extern void pm_runtime_reinit(struct device *dev);
> >  extern void pm_runtime_remove(struct device *dev);
> > +extern u64 pm_runtime_active_time(struct device *dev);
> >
> >  #define WAKE_IRQ_DEDICATED_ALLOCATED BIT(0)
> >  #define WAKE_IRQ_DEDICATED_MANAGED   BIT(1)
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 78937c45278c..d1908fc422cc 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -98,7 +98,7 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
> >       dev->power.runtime_status = status;
> >  }
> >
> > -u64 pm_runtime_suspended_time(struct device *dev)
> > +static u64 rpm_account_time(struct device *dev, bool suspend)
> >  {
> >       u64 time;
> >       unsigned long flags;
> > @@ -106,12 +106,22 @@ u64 pm_runtime_suspended_time(struct device *dev)
> >       spin_lock_irqsave(&dev->power.lock, flags);
> >
> >       update_pm_runtime_accounting(dev);
> > -     time = dev->power.suspended_time;
> > +     time = suspend ? dev->power.suspended_time : dev->power.active_time;
> >
> >       spin_unlock_irqrestore(&dev->power.lock, flags);
> >
> >       return time;
> >  }
> > +
> > +u64 pm_runtime_active_time(struct device *dev)
> > +{
> > +     return rpm_account_time(dev, false);
> > +}
> > +
> > +u64 pm_runtime_suspended_time(struct device *dev)
> > +{
> > +     return rpm_account_time(dev, true);
> > +}
> >  EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
> >
> >  /**
> >
>
> Both [1-2/2] applied with some manual changes (please see linux-next
> tomorrow).
>

Looks good, thanks!

Kind regards
Uffe
