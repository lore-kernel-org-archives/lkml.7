Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F268C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E04A20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="d1eCP1wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfGaVXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:23:38 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38442 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfGaVXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 17:23:37 -0400
Received: by mail-oi1-f194.google.com with SMTP id v186so51897019oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAw0aj3zYvR732ClhJNo3dihpW65fT0od1LsxS/SmUU=;
        b=d1eCP1wf92yvxG0S3ECQy4F+w9zltGiv2cTd1+G2J/uGIjVe6famiZSAgWqUfohSyi
         SJZegBYqJcnE4Wa9lD35HN9eTFIlE7NbW+ULno28lMD8Jtd2YvyoQjll3QEcKnpa3EMQ
         doINo8YPFBway69F/sCwe91YKDOqBdq86pzeywsb8jaiQEiF5UnTeruIuL+ehE0Pjw5A
         NiCDyCVYt/shrqbDU3I9gj72t4baOFC12zd6zSRX/YSj6YLoENQimft0H1zd9mdobHQY
         3dyAxq7DwIYyUv/Ks4tJpMW7DoESHBO6TxvmLhRnoMFqLaPdKi6hHpMOcrYaJraOS83/
         kSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAw0aj3zYvR732ClhJNo3dihpW65fT0od1LsxS/SmUU=;
        b=OUsxpX6yaPh+B99eHtS5Hc7Q66/UUgQVU0hn+T+hkZT3Nb9rlbXAs4UDWZPlxrj8T9
         yX+Wmkp/nu6cVDVsm28xUdS6YNyaPsWwdwwEq6iW6QX/u9kvAdAxY0JV/lTMpmE9Btfu
         ALrZn+7eznWMAwa1xdzcxaI9F6wkk32wkV0w5l7SJrL3zNQQ1Zl3z0nJ/pqYmIRCfHxQ
         ZMKf4OE1M9OXyyjMRthQk+E44NTuJZUyXqCYe+1Vl6HOUGTe61GYbvlZb2iuo2ecYCnU
         tXsmv90WFz6zANKtxltX+SlG4z/fqI7+jhNv70avfpw21oQClX6MswZwrlOTSDh8yH65
         Qinw==
X-Gm-Message-State: APjAAAUKjiKnfOU0NHy27QaHneS7faLkgV1yNNGP2oDPSsCo6Vrmnh5i
        MHcmeH8IQxua8hXOt4F2Xy1LdBiLzWnqkcO2BkM=
X-Google-Smtp-Source: APXvYqyy4WKqW6MgDk+8JtkFfM9MPTSVjMw7BUfIkE+w/N80C19WwjkpktJkHyN/qIVIcJXnpjcfkiBhAZqU5ubbR0g=
X-Received: by 2002:aca:f552:: with SMTP id t79mr54537837oih.145.1564608215732;
 Wed, 31 Jul 2019 14:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190730024309.233728-1-trong@android.com> <5d40d5b3.1c69fb81.6047f.1cc3@mx.google.com>
 <CAJZ5v0hj-GpiYN7nwPJvKJag71MG6zEFbJ6BNwzDidD+7fNFWw@mail.gmail.com>
 <3963324.N1Qi0Ay72S@kreacher> <5d41cc55.1c69fb81.9480d.8a49@mx.google.com> <CAJZ5v0gdmmgBuSQU7FWaBmdTq7diToKO=5F5e5vRt=Yqvn9C2Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gdmmgBuSQU7FWaBmdTq7diToKO=5F5e5vRt=Yqvn9C2Q@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 31 Jul 2019 14:23:24 -0700
Message-ID: <CANA+-vDMee+2e+siOQS_6iR=8BNYtvMG3C8qpfDf5CQ6Nti9Kg@mail.gmail.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 2:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jul 31, 2019 at 7:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Rafael J. Wysocki (2019-07-31 04:58:36)
> > > On Wednesday, July 31, 2019 10:34:11 AM CEST Rafael J. Wysocki wrote:
> > > > On Wed, Jul 31, 2019 at 1:41 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > >
> > > >
> > > > > We can run into the same problem when two buses name their devices the
> > > > > same name and then we attempt to attach a wakeup source to those two
> > > > > devices. Or we can have a problem where a virtual wakeup is made with
> > > > > the same name, and again we'll try to make a duplicate named device.
> > > > > Using something like 'event' or 'wakeup' or 'ws' as the prefix avoids this
> > > > > problem and keeps things clean.
> > > >
> > > > Or suffix, like "<devname-wakeup>.
> > > >
> > > > But if prefixes are used by an existing convention, I would prefer
> > > > "ws-" as it is concise enough and should not be confusing.
> >
> > Another possibility is 'eventN', so it reads as /sys/class/wakeup/event0
> >
> > > >
> > > > > We should probably avoid letting the same virtual wakeup source be made
> > > > > with the same name anyway, because userspace will be confused about what
> > > > > virtual wakeup it is otherwise. I concede that using the name of the
> > > > > wakeup source catches this problem without adding extra code.
> > > > >
> > > > > Either way, I'd like to see what you outline implemented so that we
> > > > > don't need to do more work than is necessary when userspace writes to
> > > > > the file.
> > > >
> > > > Since we agree here, let's make this change first.  I can cut a patch
> > > > for that in a reasonable time frame I think if no one else beats me to
> > > > that.
> > >
> > > So maybe something like the patch below (untested).
> > >
> > > Index: linux-pm/drivers/base/power/wakeup.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/power/wakeup.c
> > > +++ linux-pm/drivers/base/power/wakeup.c
> > > @@ -265,15 +244,29 @@ int device_wakeup_enable(struct device *
> > >         if (pm_suspend_target_state != PM_SUSPEND_ON)
> > >                 dev_dbg(dev, "Suspicious %s() during system transition!\n", __func__);
> > >
> > > +       spin_lock_irq(&dev->power.lock);
> > > +
> > > +       if (dev->power.wakeup) {
> > > +               spin_unlock_irq(&dev->power.lock);
> > > +               return -EEXIST;
> > > +       }
> > > +       dev->power.wakeup = ERR_PTR(-EBUSY);
> > > +
> > > +       spin_unlock_irq(&dev->power.lock);
> > > +
> > >         ws = wakeup_source_register(dev_name(dev));
> > >         if (!ws)
> > >                 return -ENOMEM;
> > >
> >
> > Let's say that device_wakeup_enable() is called twice at around the same
> > time. First thread gets to wakeup_source_register() and it fails, we
> > return -ENOMEM.
>
> The return is premature.  dev->power.wakeup should be reset back to
> NULL if the wakeup source creation fails.
>
> > dev->power.wakeup is assigned to ERR_PTR(-EBUSY). Second
> > thread is at the spin_lock_irq() above, it grabs the lock and sees
> > dev->power.wakeup is ERR_PTR(-EBUSY) so it bails out with return
> > -EEXIST. I'd think we would want to try to create the wakeup source
> > instead.
> >
> >     CPU0                                   CPU1
> >     ----                                   ----
> >     spin_lock_irq(&dev->power.lock)
> >     ...
> >     dev->power.wakeup = ERR_PTR(-EBUSY)
> >     spin_unlock_irq(&dev->power.lock)
> >     ws = wakeup_source_register(...)
> >     if (!ws)
> >         return -ENOMEM;                 spin_lock_irq(&dev->power.lock)
> >                                         if (dev->power.wakeup)
> >                                             return -EEXIST; // Bad
> >
> >
> > Similar problems probably exist with wakeup destruction racing with
> > creation. I think it might have to be a create and then publish pointer
> > style of code to keep the spinlock section small?
>
> There is a problem when there are two concurrent callers of
> device_wakeup_enable() running in parallel with a caller of
> device_wakeup_disable(), but that can be prevented by an extra check
> in the latter.
>
> Apart from that I missed a few if (dev->power.wakeup) checks to convert.
>
> I'll update the patch and resend it.

Ok thanks, I'll ignore the device_wakeup_enable() issue in this patch,
since you're addressing it in a separate patch.

IIUC checking and assigning to dev->power.wakeup must be in the same
critical section for correctness, implying that allocation of the
wakeup source must also be in that critical section (since we check
dev->power.wakeup to see whether we need a wakeup source).

Wakeup source virtual device registration can fail (it allocates
memory), in which case dev->power.wakeup need to be cleaned up.
Meaning that wakeup source virtual device registration need to be in
that same critical section.

So I'm not sure it is at all possible to satisfy these conditions at
the same time (1) avoid creating an extra wakeup source (2) not hold
the spinlock while creating/registering the wakeup source.
