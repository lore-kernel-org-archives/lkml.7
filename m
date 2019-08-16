Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F7C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B430621721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="a3cDSghN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfHPWiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:38:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43608 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfHPWiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:38:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id e12so10948137otp.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8CirlaHdh28gHLoP6h4JqrJrGvDIaVMTsL4o/hfB+Q=;
        b=a3cDSghN76lmTismZG0JY1fRaRl8s1zZgZTjxVK+xaaaaNNs90B2T83Rml4/QmQ5L7
         yfLiWFwyVeKL+BQnCjYloJqOxGfu6F7R1bUiLxfbh5kZoEDY5d08QKizcXOGAKsiBOri
         Jeu1SafRJxBUH0jR/68px4blC5ni9fY6lFFNoVeOfnqD7DFsqZp9VMiawqCl8VgrSsFM
         RsvCefaLOLf9t973heAsMqOJaeSuBqM17B3cQACIIelOALYiS7paaVYQ9qItOM0m+G4u
         XfB4w/J44LUPWEnFS0Q2d5CruoJ5QqMkVVKH6ALvzzjvKm6+W1gCYeiWMX1HJFVfaxMP
         tr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8CirlaHdh28gHLoP6h4JqrJrGvDIaVMTsL4o/hfB+Q=;
        b=dfClBMMsCTOMvdXuUU8UzCD6M5h2U3yVLVPS5Ap6heaXlQuqEjKZ5d1TIaTLVxEQi3
         pn9P/ZpfFo9sxpp1pF4roUT5Ao84SnqtgiX4/l02hgET4uGcAn5L3f1yXWyfYKyTsqc/
         jBsSqi3uo6YXZnamypC42GeA6PdGEudbQOP+TzsIRt1TM6yZGFBDAkajRyOSpPWFB8SI
         D+mRs3zTx9jQ4r8SKR8XQZt1O9GquwXj6emTid9F2Xf0j4MiJ72pLl0+gFGbOP5Z7c2Z
         Oqvbk3DAUt1WTNj6lQF4RqFTULV2BcxeXg3hBtq6bqgoo47c6rZpYeQp1jWAIZh2hAyb
         8dXQ==
X-Gm-Message-State: APjAAAUuA+LDUQEgQOCWfXPRvFBwGvPP8OGx2WO4qOQsYlvRqOqVatPr
        fa8+GGmo05altm1uPsrpn6h9J98fM4u5/SuA1R/dS6uCCw4=
X-Google-Smtp-Source: APXvYqyLof2LMIjakexWruidxXTOuja6QYEBN71Wz09dSSdidzjc076P0/NGpcQ8yXPJKdtCNEZZ3ZWNW8ha6hRJgHA=
X-Received: by 2002:a9d:3466:: with SMTP id v93mr9635813otb.312.1565995098349;
 Fri, 16 Aug 2019 15:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190816145602.231163-1-swboyd@chromium.org> <CANA+-vB2_pYhYq5cmpyhiwJR3TuO+-2iBPehSXSjun-HN2wb5A@mail.gmail.com>
 <5d57242c.1c69fb81.bba86.14f6@mx.google.com>
In-Reply-To: <5d57242c.1c69fb81.bba86.14f6@mx.google.com>
From:   Tri Vo <trong@android.com>
Date:   Fri, 16 Aug 2019 15:38:07 -0700
Message-ID: <CANA+-vDZqXS-yac9Q_K54oVrqZLtJojBSKa=ToJ9ZkfYHRcqbQ@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: Register wakeup class kobj after device is added
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 2:46 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Tri Vo (2019-08-16 14:27:35)
> > On Fri, Aug 16, 2019 at 7:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > > index 1b9c281cbe41..27ee00f50bd7 100644
> > > --- a/drivers/base/power/sysfs.c
> > > +++ b/drivers/base/power/sysfs.c
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/export.h>
> > >  #include <linux/pm_qos.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/pm_wakeup.h>
> > >  #include <linux/atomic.h>
> > >  #include <linux/jiffies.h>
> > >  #include "power.h"
> > > @@ -661,14 +662,21 @@ int dpm_sysfs_add(struct device *dev)
> > >                 if (rc)
> > >                         goto err_runtime;
> > >         }
> > > +       if (dev->power.wakeup) {
> >
> > This conditional checks for the situation when wakeup source
> > registration have been previously attempted, but failed at
> > wakeup_source_sysfs_add(). My concern is that it's not easy to
> > understand what this check does without knowing exactly what
> > device_wakeup_enable() does to dev->power.wakeup before we reach this
> > point.
>
> Oh, actually this is wrong. It should be a check for
> dev->power.wakeup->dev being non-NULL. That's the variable that's set by
> wakeup_source_sysfs_add() upon success. So I should make it:
>
>         if (dev->power.wakeup && !dev->power.wakeup->dev)

Oh ok, this makes more sense now :)
>
> And there's the problem that CONFIG_PM_SLEEP could be unset. Let me fix
> it up with a new inline function like device_has_wakeup_dev().
>
> >
> > > +               rc = wakeup_source_sysfs_add(dev, dev->power.wakeup);
> > > +               if (rc)
> > > +                       goto err_wakeup;
> > > +       }
> > >         if (dev->power.set_latency_tolerance) {
> > >                 rc = sysfs_merge_group(&dev->kobj,
> > >                                        &pm_qos_latency_tolerance_attr_group);
> > >                 if (rc)
> > > -                       goto err_wakeup;
> > > +                       goto err_wakeup_source;
> > >         }
> > >         return 0;
> > >
> > > + err_wakeup_source:
> > > +       wakeup_source_sysfs_remove(dev->power.wakeup);
> > >   err_wakeup:
> > >         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> > >   err_runtime:
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > > index f7925820b5ca..5817b51d2b15 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -220,10 +220,12 @@ struct wakeup_source *wakeup_source_register(struct device *dev,
> > >
> > >         ws = wakeup_source_create(name);
> > >         if (ws) {
> > > -               ret = wakeup_source_sysfs_add(dev, ws);
> > > -               if (ret) {
> > > -                       wakeup_source_free(ws);
> > > -                       return NULL;
> > > +               if (!dev || device_is_registered(dev)) {
> >
> > Is there a possible race condition here? If dev->power.wakeup check in
> > dpm_sysfs_add() is done at the same time as device_is_registered(dev)
> > check here, then wakeup_source_sysfs_add() won't ever be called?
>
> The same race exists for device_set_wakeup_capable() so I didn't bother
> to try to avoid it. I suppose wakeup_source_sysfs_add() could run
> completely, allocate the device and set the name, etc., but not call
> device_add() and then we can set ws->dev and call device_add() under a
> mutex so that we keep a very small window where the wakeup class is
> published to sysfs. Or just throw a big mutex around the whole wakeup
> class creation path so that there isn't a chance of a race. But really,
> is anyone going to call device_set_wakeup_*() on a device that is also
> being added to the system? Seems unlikely.

True. I don't have a strong opinion.
>
> >
> > > +                       ret = wakeup_source_sysfs_add(dev, ws);
> > > +                       if (ret) {
> > > +                               wakeup_source_free(ws);
