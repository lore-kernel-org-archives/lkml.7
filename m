Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7ABC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A502184E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="A3J5SEaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfHPV1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:27:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46816 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfHPV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:27:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id t24so5780537oij.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqmSQA31vLUNhr87Xa+IWQLTTVCCaklCI55tBVwyFNQ=;
        b=A3J5SEaIUVTi9GzBvEYudEnLY+MD/Tms4QCct9Le1jCJ+1WYIAbD+48NaEyqtvfbRh
         Qe7pfKphAnMr5eryDM3Opv7Gus2oEdfIptH+ke3T8lWJzlA9JPTYcb3oi++PxTcT1mjd
         YWUTfqhnD+bZLIBnkc36REFChte0qoz/DfKubxH+EQl2xkoOU1ca6IV1pe0LvGO37LKD
         uU4V13hlIEa8yUjpa0txpKASYcF78pANyvXfalCfMwwLfVEVbDeiuTEo/sNRZe+Q5ph3
         ZvER8Ejg/XEyMNC981lqM9ivVQe6iUZsSvO2p+l3jZnDzYEBGoc+uTWqSHr74axyQHej
         8+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqmSQA31vLUNhr87Xa+IWQLTTVCCaklCI55tBVwyFNQ=;
        b=Xim3/MCVSRg8qXxTswIHXjgKAe57ujvUQkoZ49TGDoz7HxV8zmyD9PJuy60HbpZj9r
         MjU1WCCKz/p7j0mX69tkbF6sKfZY7Jpu7AUyHtZ6c3cMAIU1grKpNAAruBid4F4fD5bb
         dOMJCh2tt3Iskp794G1seoPMXWwk2zIIf1pDawTwKimR+Oeh90XVoDZtUOWZqE6CdrYV
         0OK5BTfcFLPoF+v7FJCO067j7dEjUF7JQIxr3TilVv7qAppdPptW9Yc7AREFf67A4uji
         O+yTqIgDFUt+401U6qeFXCpq9lt37qSA+84Bd8viaySELtxEzmAvT0MkyQbBxkEFq83I
         Q9PQ==
X-Gm-Message-State: APjAAAXScsiSNoB4V4ZMXgzSPHqdAXj/WUz0B5wRZNbaeYaLcq0ONWlO
        0vRAyltXreBnQAKeios/RWPVave8bY7ZBxBU5by2ew==
X-Google-Smtp-Source: APXvYqyUY2tOiKVAj3q1ha+TiJ4c/MJUuqSosee46aTi/hV6edQ9nSXhS/v5n62lG0AS/lTxt6wg3iJ4TDkL+2lmAuw=
X-Received: by 2002:a54:4e95:: with SMTP id c21mr5854082oiy.145.1565990866341;
 Fri, 16 Aug 2019 14:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190816145602.231163-1-swboyd@chromium.org>
In-Reply-To: <20190816145602.231163-1-swboyd@chromium.org>
From:   Tri Vo <trong@android.com>
Date:   Fri, 16 Aug 2019 14:27:35 -0700
Message-ID: <CANA+-vB2_pYhYq5cmpyhiwJR3TuO+-2iBPehSXSjun-HN2wb5A@mail.gmail.com>
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

On Fri, Aug 16, 2019 at 7:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
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
>  drivers/base/power/sysfs.c  | 10 +++++++++-
>  drivers/base/power/wakeup.c | 10 ++++++----
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 1b9c281cbe41..27ee00f50bd7 100644
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
> +       if (dev->power.wakeup) {

This conditional checks for the situation when wakeup source
registration have been previously attempted, but failed at
wakeup_source_sysfs_add(). My concern is that it's not easy to
understand what this check does without knowing exactly what
device_wakeup_enable() does to dev->power.wakeup before we reach this
point.

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

Is there a possible race condition here? If dev->power.wakeup check in
dpm_sysfs_add() is done at the same time as device_is_registered(dev)
check here, then wakeup_source_sysfs_add() won't ever be called?

> +                       ret = wakeup_source_sysfs_add(dev, ws);
> +                       if (ret) {
> +                               wakeup_source_free(ws);
> +                               return NULL;
> +                       }
>                 }
>                 wakeup_source_add(ws);
>         }
> --
> Sent by a computer through tubes
>
