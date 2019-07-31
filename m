Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19621C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE1D206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cS2I/+70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfGaRN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:13:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35942 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfGaRN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:13:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so32355534pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 10:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=ruDF2QJk0RcaoD/jGCIEntz9VsOPy5ywGe3+1XGTF3E=;
        b=cS2I/+703Lp0/GDvqx/aR15ZroVpe9Dj/fQg56wPORtKfsfCfjFnolIPqgXQlzHD81
         2oXF0KRjVJm0Ahc8nVNekjVPIxSUhAL05++7dLyn2dPcoEUBC+qaD7TzXpuJ3GZFVSM+
         yAgzSd0Me7+ShJIKHb0ARjUTBdR6Mz3ZVlPuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=ruDF2QJk0RcaoD/jGCIEntz9VsOPy5ywGe3+1XGTF3E=;
        b=XVex+ZAmzt4JdE4259ZirzKHE5o9NoLO084Vd1y9D9j90VWtFtqCB/mRDpnoytmZfV
         6c8mKkJJ1v1RmPAqAne46OFcII00QeZOpulGcDWcyOe8roGLUKSs8uW0y6Y9vncM9dC2
         lWkQLzXFDeXpiOVPwfUz33MULG4egWhrMOanCwENjFC8MoR5yWA4VBiAzk94CUiKojMX
         VfgWpDCsIkrwhjZ/9Torj2kNvQ8ATqRDuVp/go4ekurxmCWKYUXUXMwWPBij2G6ZLa/d
         VXYUnNd3A9TNyoBigqutnwqAaN4DQE/UOWX5Ni+sRYrBtP7ouWm/iZaR6wNekIoo1v+9
         VpaQ==
X-Gm-Message-State: APjAAAUBIXdePF7vTrACNWBuIZxzDyqLYzPZgi6uaepjdA53TobrSrCF
        2bgU1eLKUzwcQKtZYPHK9dqCew==
X-Google-Smtp-Source: APXvYqwYn/0sv59L0nj+oVd0I2wmn455cZmzNOFQRyDqkMc/XkteC+z5CP9Qn0cmPUlatWoJtazi8g==
X-Received: by 2002:a62:770e:: with SMTP id s14mr46921167pfc.150.1564593238470;
        Wed, 31 Jul 2019 10:13:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x9sm45533236pgp.75.2019.07.31.10.13.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:13:57 -0700 (PDT)
Message-ID: <5d41cc55.1c69fb81.9480d.8a49@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3963324.N1Qi0Ay72S@kreacher>
References: <20190730024309.233728-1-trong@android.com> <5d40d5b3.1c69fb81.6047f.1cc3@mx.google.com> <CAJZ5v0hj-GpiYN7nwPJvKJag71MG6zEFbJ6BNwzDidD+7fNFWw@mail.gmail.com> <3963324.N1Qi0Ay72S@kreacher>
Cc:     Tri Vo <trong@android.com>,
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
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Wed, 31 Jul 2019 10:13:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rafael J. Wysocki (2019-07-31 04:58:36)
> On Wednesday, July 31, 2019 10:34:11 AM CEST Rafael J. Wysocki wrote:
> > On Wed, Jul 31, 2019 at 1:41 AM Stephen Boyd <swboyd@chromium.org> wrot=
e:
> > >
> >=20
> > > We can run into the same problem when two buses name their devices the
> > > same name and then we attempt to attach a wakeup source to those two
> > > devices. Or we can have a problem where a virtual wakeup is made with
> > > the same name, and again we'll try to make a duplicate named device.
> > > Using something like 'event' or 'wakeup' or 'ws' as the prefix avoids=
 this
> > > problem and keeps things clean.
> >=20
> > Or suffix, like "<devname-wakeup>.
> >=20
> > But if prefixes are used by an existing convention, I would prefer
> > "ws-" as it is concise enough and should not be confusing.

Another possibility is 'eventN', so it reads as /sys/class/wakeup/event0

> >=20
> > > We should probably avoid letting the same virtual wakeup source be ma=
de
> > > with the same name anyway, because userspace will be confused about w=
hat
> > > virtual wakeup it is otherwise. I concede that using the name of the
> > > wakeup source catches this problem without adding extra code.
> > >
> > > Either way, I'd like to see what you outline implemented so that we
> > > don't need to do more work than is necessary when userspace writes to
> > > the file.
> >=20
> > Since we agree here, let's make this change first.  I can cut a patch
> > for that in a reasonable time frame I think if no one else beats me to
> > that.
>=20
> So maybe something like the patch below (untested).
>=20
> Index: linux-pm/drivers/base/power/wakeup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/base/power/wakeup.c
> +++ linux-pm/drivers/base/power/wakeup.c
> @@ -265,15 +244,29 @@ int device_wakeup_enable(struct device *
>         if (pm_suspend_target_state !=3D PM_SUSPEND_ON)
>                 dev_dbg(dev, "Suspicious %s() during system transition!\n=
", __func__);
> =20
> +       spin_lock_irq(&dev->power.lock);
> +
> +       if (dev->power.wakeup) {
> +               spin_unlock_irq(&dev->power.lock);
> +               return -EEXIST;
> +       }
> +       dev->power.wakeup =3D ERR_PTR(-EBUSY);
> +
> +       spin_unlock_irq(&dev->power.lock);
> +
>         ws =3D wakeup_source_register(dev_name(dev));
>         if (!ws)
>                 return -ENOMEM;
> =20

Let's say that device_wakeup_enable() is called twice at around the same
time. First thread gets to wakeup_source_register() and it fails, we
return -ENOMEM. dev->power.wakeup is assigned to ERR_PTR(-EBUSY). Second
thread is at the spin_lock_irq() above, it grabs the lock and sees
dev->power.wakeup is ERR_PTR(-EBUSY) so it bails out with return
-EEXIST. I'd think we would want to try to create the wakeup source
instead.

    CPU0                                   CPU1
    ----                                   ----
    spin_lock_irq(&dev->power.lock)
    ...
    dev->power.wakeup =3D ERR_PTR(-EBUSY)
    spin_unlock_irq(&dev->power.lock)
    ws =3D wakeup_source_register(...)
    if (!ws)
        return -ENOMEM;                 spin_lock_irq(&dev->power.lock)
                                        if (dev->power.wakeup)
                                            return -EEXIST; // Bad


Similar problems probably exist with wakeup destruction racing with
creation. I think it might have to be a create and then publish pointer
style of code to keep the spinlock section small?

> -       ret =3D device_wakeup_attach(dev, ws);
> -       if (ret)
> -               wakeup_source_unregister(ws);
> +       spin_lock_irq(&dev->power.lock);
> =20
> -       return ret;
> +       dev->power.wakeup =3D ws;
> +       if (dev->power.wakeirq)
> +               device_wakeup_attach_irq(dev, dev->power.wakeirq);
> +
> +       spin_unlock_irq(&dev->power.lock);
> +
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(device_wakeup_enable);
> =20
