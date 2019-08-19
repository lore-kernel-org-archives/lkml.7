Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1470FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED0D22CEA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTZmtNpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfHSRPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:15:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33490 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfHSRPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:15:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so1542178pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=uYperS6YY4bg7dPpvAvDebJfjDzQ51LlK9CFMNGa0+Q=;
        b=VTZmtNpqHgTlZQeUGhcq7ayM708jpk8EKFY8eY89WZAMDUsSO8HFVIIvJpuFWCU/Ur
         LCrrOY/fxWr/la9M55qJFE7YzS2FewrF51xrgVguaXtefttlMEre6DNwO8Tozf0BGZd3
         6FjT2WQkyOOi9Akj4MPCYetS2OzBC8ikSQzX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=uYperS6YY4bg7dPpvAvDebJfjDzQ51LlK9CFMNGa0+Q=;
        b=innA1e3CsGQ1E6brQi2u3h2hdsXN7hRMoXCjRGNDKEwsz1umKJK6+rFLMOWHlJruze
         TPRpXyVXRNVx/sqbHXJCbfscmILVQLZb+HuH1BXqUY0KIKO0KHULtWd/4//US/y+p6fI
         xYkaRitjMTZwfPqlROQQHLS9NJZfx6FlrLbOXaan5K9j9lfTCI4E2e+ZPDO2IwEDcwT3
         8GCQ74imtov7rr49gSU3LCbMdz0P2aASfG9/t6Ol7jlX8GJ16xi+E99n0mNBpavBSM0V
         IxfCXiBk4HopLydCjkPZ2dxuj30IudRp0YPFrgF8qxm779v4bltdO1DK0gWzyQH4yPga
         A4nw==
X-Gm-Message-State: APjAAAWcv4fWAx396xx6TWnV7MQaxU+Tl73mcS1uWhLh5Uj+ZvXW7Ejd
        KPn6gY6KRZCCKsb3Bw/o9hK9fg==
X-Google-Smtp-Source: APXvYqyn69vHgO31trGYTuY8vwoB/p84HXpcF9N5fip1WG7rfBejATNDQHrtkM/pyim42XlQ7Bmyfw==
X-Received: by 2002:a63:9d43:: with SMTP id i64mr21020529pgd.306.1566234948026;
        Mon, 19 Aug 2019 10:15:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b14sm16898206pfo.15.2019.08.19.10.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:15:47 -0700 (PDT)
Message-ID: <5d5ad943.1c69fb81.25dd0.c326@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANA+-vAaOLA0LQot6V8aHjx=_Q9BuXU_Ois+qiTFEsySD9QuZg@mail.gmail.com>
References: <20190819150645.178871-1-swboyd@chromium.org> <CANA+-vAaOLA0LQot6V8aHjx=_Q9BuXU_Ois+qiTFEsySD9QuZg@mail.gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: Register wakeup class kobj after device is added
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Qian Cai <cai@lca.pw>
To:     Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 10:15:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tri Vo (2019-08-19 10:04:56)
> On Mon, Aug 19, 2019 at 8:06 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > The device_set_wakeup_enable() function can be called on a device that
> > hasn't been registered with device_add() yet. This allows the device to
> > be in a state where wakeup is enabled for it but the device isn't
> > published to userspace in sysfs yet.
> >
> > After commit 986845e747af ("PM / wakeup: Show wakeup sources stats in
> > sysfs"), calling device_set_wakeup_enable() will fail for a device that
> > hasn't been registered with the driver core via device_add(). This is
> > because we try to create sysfs entries for the device and associate a
> > wakeup class kobject with it before the device has been registered.
> > Let's follow a similar approach that device_set_wakeup_capable() takes
> > here and register the wakeup class either from
> > device_set_wakeup_enable() when the device is already registered, or
> > from dpm_sysfs_add() when the device is being registered with the driver
> > core via device_add().
> >
> > Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
> > Reported-by: Qian Cai <cai@lca.pw>
> > Cc: Qian Cai <cai@lca.pw>
> > Cc: Tri Vo <trong@android.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > Changes from v1:
> >  * Export wakeup_source_sysfs_add/remove stubs
> >  * New function to check if we should add the device from
> >    dpm_sysfs_add()
> >
> >  drivers/base/power/power.h  |  9 +++++++++
> >  drivers/base/power/sysfs.c  | 10 +++++++++-
> >  drivers/base/power/wakeup.c | 10 ++++++----
> >  include/linux/pm_wakeup.h   | 10 ++++++++++
> >  4 files changed, 34 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> > index 57b1d1d88c8e..22a1533ec56b 100644
> > --- a/drivers/base/power/power.h
> > +++ b/drivers/base/power/power.h
> > @@ -156,5 +156,14 @@ static inline void device_pm_init(struct device *d=
ev)
> >  extern int wakeup_source_sysfs_add(struct device *parent,
> >                                    struct wakeup_source *ws);
> >  extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
> > +#else /* !CONFIG_PM_SLEEP */
> > +
> > +static inline int wakeup_source_sysfs_add(struct device *parent,
> > +                                         struct wakeup_source *ws)
> > +{
> > +       return 0;
> > +}
> > +
> > +static inline void wakeup_source_sysfs_remove(struct wakeup_source *ws=
) {}
> >
> >  #endif /* CONFIG_PM_SLEEP */
> > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > index 1b9c281cbe41..1468d03ae9fb 100644
> > --- a/drivers/base/power/sysfs.c
> > +++ b/drivers/base/power/sysfs.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/export.h>
> >  #include <linux/pm_qos.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/pm_wakeup.h>
> >  #include <linux/atomic.h>
> >  #include <linux/jiffies.h>
> >  #include "power.h"
> > @@ -661,14 +662,21 @@ int dpm_sysfs_add(struct device *dev)
> >                 if (rc)
> >                         goto err_runtime;
> >         }
> > +       if (!device_has_wakeup_dev(dev)) {
>=20
> This evaluates to true if dev->power.wakeup is NULL, which will result
> in a null pointer dereference later in wakeup_source_sysfs_add().
>=20
> I think the condition you want to check for is the one you pointed out
> in previous patch.
>=20
>         if (dev->power.wakeup && !dev->power.wakeup->dev)

Aha thanks. I need to wrapper it because CONFIG_PM_SLEEP is the one that
defines the power path.

>=20
> > +               rc =3D wakeup_source_sysfs_add(dev, dev->power.wakeup);

But also, dev->power.wakeup doesn't exist with !CONFIG_PM_SLEEP.

