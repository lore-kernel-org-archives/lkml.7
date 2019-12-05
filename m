Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AA2C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617AA20640
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="vtCXI6ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfLEEOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 23:14:50 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44972 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfLEEOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 23:14:50 -0500
Received: by mail-vs1-f68.google.com with SMTP id p6so1406562vsj.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 20:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqFPHdq2JLprnKO5VwIvwEO3N5V/VX0CxYcPwY52gV4=;
        b=vtCXI6eyS+2xdwHXSvFzMOB8Chgw85vfzPkdgVzTNU6F8HGvjWTq32MwsgZhxECGj0
         3LfOWDNTWmx+TVkopEKRGby1mg9dlygeoCzquDCpKnj6fe4PwPuPKiqkuaJFvG/RjWEM
         YU0GKlXnektfcf8dq11uUiPlZo9dwThQCahskH5M3cZq1VZ6i/saNFdkitvoHY9aAP/i
         aZJJyeAMHPwe6vgt/3W+FpNXpj0jrR9Ha+DHDBO+rHil+UQWZ74lq0IMEFOo/YoDctA/
         R8lX2rMbeQeKm75uiinD7K99xONw8jrZLCtgc8uxGd9RXgHrDTpm8zgYIfXr1EZXPYUm
         ++7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqFPHdq2JLprnKO5VwIvwEO3N5V/VX0CxYcPwY52gV4=;
        b=sOuA7oNxZ7JtU6MdqZx+bqsPHGMOd8Ts24ysRQOa9sgxm0VjjSOsfQKMhjYxobIHVi
         G5S7p062gtXUVVj6rBwrrUcJ7jjH6aOVirgh0D8R+HthDihHtPozD7o4ta4aX3Q18cQA
         FFz3lrn5rkIysP9VkIW3qJWbpxoyHIiG/QYtVUIpkWFO8xDX+2T6Q0PnXy9A2PphT/RE
         gb4bb9BqNvMrFT97pnA/+erqgk8VFhULBZ+rirV6MGxEOCONes1+YbP4TW1M+xSjALDI
         lbVrYcZyHOiPisiRhLX+4Pd7DPT3tFGkZOU95QUD7jj6drWi0WtO9CP6bOd8hKiDSdW3
         k4iw==
X-Gm-Message-State: APjAAAVttMUQJyW7UAoHHrKkvS0UvEuDuakzZ8HsMdvCc9vRmYD0tz6R
        ELA4u74sy00pSYLONR6LlYdjirtIePgD5TtOgZURvA==
X-Google-Smtp-Source: APXvYqxBdkwA3F7mInycga4o2n4t9e4RP0Hx+NDWf62MpAtgLQ71+O7tfZuLZUdPCDHljQPLDy99hXq9njxeRo82N2I=
X-Received: by 2002:a05:6102:1261:: with SMTP id q1mr4250512vsg.182.1575519288928;
 Wed, 04 Dec 2019 20:14:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
 <20191204215618.125826-1-wvw@google.com> <20191204215618.125826-3-wvw@google.com>
In-Reply-To: <20191204215618.125826-3-wvw@google.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 5 Dec 2019 09:44:38 +0530
Message-ID: <CAHLCerNGYy55vFVJs5u_YZ=xLu2jWwtugLkvBVjEwgP+_B0Y3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: create softlink by name for thermal_zone
 and cooling_device
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 3:26 AM Wei Wang <wvw@google.com> wrote:
>
> The paths thermal_zone%d and cooling_device%d are not intuitive and the
> numbers are subject to change due to device tree change. This usually
> leads to tree traversal in userspace code.
> The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> cooling_device respectively.
>
> Signed-off-by: Wei Wang <wvw@google.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 64fbb59c2f44..4f55e3f16265 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -22,6 +22,7 @@
>  #include <net/netlink.h>
>  #include <net/genetlink.h>
>  #include <linux/suspend.h>
> +#include <linux/kobject.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/thermal.h>
> @@ -46,6 +47,8 @@ static DEFINE_MUTEX(poweroff_lock);
>
>  static atomic_t in_suspend;
>  static bool power_off_triggered;
> +static struct kobject *cdev_link_kobj;
> +static struct kobject *tz_link_kobj;
>
>  static struct thermal_governor *def_governor;
>
> @@ -997,9 +1000,15 @@ __thermal_cooling_device_register(struct device_node *np,
>                 return ERR_PTR(result);
>         }
>
> -       /* Add 'this' new cdev to the global cdev list */
> +       /* Add 'this' new cdev to the global cdev list and create link*/
>         mutex_lock(&thermal_list_lock);
>         list_add(&cdev->node, &thermal_cdev_list);
> +       if (!cdev_link_kobj)
> +               cdev_link_kobj = kobject_create_and_add("cdev-by-name",
> +                                               cdev->device.kobj.parent);
> +       if (!cdev_link_kobj || sysfs_create_link(cdev_link_kobj,
> +                                               &cdev->device.kobj, cdev->type))
> +               dev_err(&cdev->device, "Failed to create cdev-by-name link\n");
>         mutex_unlock(&thermal_list_lock);
>
>         /* Update binding information for 'this' new cdev */
> @@ -1165,6 +1174,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>                         }
>                 }
>         }
> +       if (cdev_link_kobj)
> +               sysfs_remove_link(cdev_link_kobj, cdev->type);
>
>         mutex_unlock(&thermal_list_lock);
>
> @@ -1348,6 +1359,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>
>         mutex_lock(&thermal_list_lock);
>         list_add_tail(&tz->node, &thermal_tz_list);
> +       if (!tz_link_kobj)
> +               tz_link_kobj = kobject_create_and_add("tz-by-name",
> +                                               tz->device.kobj.parent);
> +       if (!tz_link_kobj || sysfs_create_link(tz_link_kobj,
> +                                               &tz->device.kobj, tz->type))
> +               dev_err(&tz->device, "Failed to create tz-by-name link\n");
>         mutex_unlock(&thermal_list_lock);
>
>         /* Bind cooling devices for this zone */
> @@ -1419,6 +1436,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>                         }
>                 }
>         }
> +       if (tz_link_kobj)
> +               sysfs_remove_link(tz_link_kobj, tz->type);
>
>         mutex_unlock(&thermal_list_lock);
>
> --
> 2.24.0.393.g34dc348eaf-goog
>
