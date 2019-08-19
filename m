Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE8CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D8022CEA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="f9R5T8xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfHSRFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:05:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41002 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfHSRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:05:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so2330643ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPA1M25c5b7cckb1bBi3HiU2btszwyczg6HKJE45ROE=;
        b=f9R5T8xZxam3tabO8ENYx9nk7+1k7fNMFlNeLTs8J/N63r6t+BN0lzXZaRqPQeVowr
         2a6dF4tbmrODfn0G/wB9r1PEfHDmpNushaC7GY0UuzNy0VI7sblolaxapNQGWSz6+s0e
         m2h2LMEU4YqdNy0ciq38vtEDt0MGPfMq+3EByLtHJV7gJPRSWCKjCriqvRgfr2+nAWa9
         3S/fmLIp4dXZEg3gXEjfJ/vXAbfPBeXoh4w3zzn3aKTkVz3Uxf68NI2yqVvQBmhsfs0a
         s4zEZd5jn3YOe+dQtOT6SdzA1xtleuLBduW5S72HRuqbmY2Jw8q8ctLNt9dgzHIRPQQc
         FHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPA1M25c5b7cckb1bBi3HiU2btszwyczg6HKJE45ROE=;
        b=I1XcGy7e5chi8evIQknZlREQ6w+4Sq6Iq2qqIiRh1UcXQisgfBVKZ8uFK2ur0T3o/c
         +6b9S1r2QgGQFiKyp+8h6yJKiEhitA1g4ZptsGtkelcMZJ3qlQfeRZIKZg8MNrbBx9XZ
         6yEv0XnhoQ/AzoLb/uzMO2ZOMx9ygOfXuXtqS7kvwjnV+RTgN6W38xl2jUZI6N3ivXph
         5dniWC7RoVeZSi6AF0KlPovwN65f/aFkA7gGVWyTCXKKZFkcgQL6nsorpesRDPJ+1zZN
         ipk07BV2jlNPDQVECE8aeOY3V94ydvOMMeIzwuyPDIlPcUl5SqCTfjOD64RY8NwxjXWd
         7oHw==
X-Gm-Message-State: APjAAAUlSLwNpBaqGHyWGpC2MkZajcLQk3EpUVTNCCtHFcWUNipSNbgy
        dYvCM0N2eLTWjbZzJDUFCAlr0eCZbVhQGxPm9Kzq/w==
X-Google-Smtp-Source: APXvYqynAiOKQGACGTIIPu8p0ohfNGjiHMoA/gxhhgA27LasYiYJqx5rbQBRn8JbaR8sVX09bZo2PwIFOboA6wcTrBk=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr18030015oth.159.1566234307799;
 Mon, 19 Aug 2019 10:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190819150645.178871-1-swboyd@chromium.org>
In-Reply-To: <20190819150645.178871-1-swboyd@chromium.org>
From:   Tri Vo <trong@android.com>
Date:   Mon, 19 Aug 2019 10:04:56 -0700
Message-ID: <CANA+-vAaOLA0LQot6V8aHjx=_Q9BuXU_Ois+qiTFEsySD9QuZg@mail.gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: Register wakeup class kobj after device
 is added
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 8:06 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The device_set_wakeup_enable() function can be called on a device that
> hasn't been registered with device_add() yet. This allows the device to
> be in a state where wakeup is enabled for it but the device isn't
> published to userspace in sysfs yet.
>
> After commit 986845e747af ("PM / wakeup: Show wakeup sources stats in
> sysfs"), calling device_set_wakeup_enable() will fail for a device that
> hasn't been registered with the driver core via device_add(). This is
> because we try to create sysfs entries for the device and associate a
> wakeup class kobject with it before the device has been registered.
> Let's follow a similar approach that device_set_wakeup_capable() takes
> here and register the wakeup class either from
> device_set_wakeup_enable() when the device is already registered, or
> from dpm_sysfs_add() when the device is being registered with the driver
> core via device_add().
>
> Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Tri Vo <trong@android.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  * Export wakeup_source_sysfs_add/remove stubs
>  * New function to check if we should add the device from
>    dpm_sysfs_add()
>
>  drivers/base/power/power.h  |  9 +++++++++
>  drivers/base/power/sysfs.c  | 10 +++++++++-
>  drivers/base/power/wakeup.c | 10 ++++++----
>  include/linux/pm_wakeup.h   | 10 ++++++++++
>  4 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 57b1d1d88c8e..22a1533ec56b 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -156,5 +156,14 @@ static inline void device_pm_init(struct device *dev)
>  extern int wakeup_source_sysfs_add(struct device *parent,
>                                    struct wakeup_source *ws);
>  extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
> +#else /* !CONFIG_PM_SLEEP */
> +
> +static inline int wakeup_source_sysfs_add(struct device *parent,
> +                                         struct wakeup_source *ws)
> +{
> +       return 0;
> +}
> +
> +static inline void wakeup_source_sysfs_remove(struct wakeup_source *ws) {}
>
>  #endif /* CONFIG_PM_SLEEP */
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 1b9c281cbe41..1468d03ae9fb 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -5,6 +5,7 @@
>  #include <linux/export.h>
>  #include <linux/pm_qos.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeup.h>
>  #include <linux/atomic.h>
>  #include <linux/jiffies.h>
>  #include "power.h"
> @@ -661,14 +662,21 @@ int dpm_sysfs_add(struct device *dev)
>                 if (rc)
>                         goto err_runtime;
>         }
> +       if (!device_has_wakeup_dev(dev)) {

This evaluates to true if dev->power.wakeup is NULL, which will result
in a null pointer dereference later in wakeup_source_sysfs_add().

I think the condition you want to check for is the one you pointed out
in previous patch.

        if (dev->power.wakeup && !dev->power.wakeup->dev)

> +               rc = wakeup_source_sysfs_add(dev, dev->power.wakeup);
> +               if (rc)
> +                       goto err_wakeup;
> +       }
>         if (dev->power.set_latency_tolerance) {
>                 rc = sysfs_merge_group(&dev->kobj,
>                                        &pm_qos_latency_tolerance_attr_group);
>                 if (rc)
> -                       goto err_wakeup;
> +                       goto err_wakeup_source;
>         }
>         return 0;
>
> + err_wakeup_source:
> +       wakeup_source_sysfs_remove(dev->power.wakeup);
>   err_wakeup:
>         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
>   err_runtime:
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index f7925820b5ca..5817b51d2b15 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -220,10 +220,12 @@ struct wakeup_source *wakeup_source_register(struct device *dev,
>
>         ws = wakeup_source_create(name);
>         if (ws) {
> -               ret = wakeup_source_sysfs_add(dev, ws);
> -               if (ret) {
> -                       wakeup_source_free(ws);
> -                       return NULL;
> +               if (!dev || device_is_registered(dev)) {
> +                       ret = wakeup_source_sysfs_add(dev, ws);
> +                       if (ret) {
> +                               wakeup_source_free(ws);
> +                               return NULL;
> +                       }
>                 }
>                 wakeup_source_add(ws);
>         }
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 661efa029c96..986f797a8b26 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -79,6 +79,11 @@ static inline bool device_may_wakeup(struct device *dev)
>         return dev->power.can_wakeup && !!dev->power.wakeup;
>  }
>
> +static inline bool device_has_wakeup_dev(struct device *dev)
> +{
> +       return dev->power.wakeup && !!dev->power.wakeup->dev;

nit: use "!!" on both (or neither) inputs for consistency.

> +}
> +
>  static inline void device_set_wakeup_path(struct device *dev)
>  {
>         dev->power.wakeup_path = true;
> @@ -165,6 +170,11 @@ static inline bool device_may_wakeup(struct device *dev)
>         return dev->power.can_wakeup && dev->power.should_wakeup;
>  }
>
> +static inline bool device_has_wakeup_dev(struct device *dev)
> +{
> +       return false;
> +}
> +
>  static inline void device_set_wakeup_path(struct device *dev) {}
>
>  static inline void __pm_stay_awake(struct wakeup_source *ws) {}
>
> base-commit: 0c3d3d648b3ed72b920a89bc4fd125e9b7aa5f23
> --
> Sent by a computer through tubes
>
