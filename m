Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A2FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D85206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573722804;
	bh=Hk86kKaoCoS8zdFOMF04BeVBX66otvLaHK8cVofGazs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e35kIeRR6os+CwWWgfxPVHnS/WV5crzM3PePHmbsUBSo49zjny8mgGf4ylq1OdFv6
	 5Bpo1EO8dY2rQVK2hXMxNmOaW++5w36X5zJ9LMAHJArJuuJas/9jnI69yBYH7GJCDY
	 frZQGYHCYiKLupgnvk72E6RnCQwPtzR+JCzJpGGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfKNJNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:13:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38898 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:13:22 -0500
Received: by mail-ot1-f67.google.com with SMTP id z25so4260025oti.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 01:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgD/BMuR46VjQez3zISCSv4fnHdI/4XP1QKHZKo2puA=;
        b=C+K5gDfCBdiae4KcfzHZwCDYzXhoWKxGUDIGW4dWVTWz7thqu5rCu4TCdwzZH2ayFo
         Gte3Exg31nRpz+2xX6vYgkrmOYe6DuOnJfotZ6xAgVWxdhWMRDLSz+UVpXx62Wnb6vTE
         voBBs+rAFyW9u1GdGj4u7rLn4uy6XdDSNbtzsYNbtpOYH06Imu/AkvWYnrE0nQwxxu9p
         mIKyvO4dFNtQ1WoTLfpzX6c1UPR8S+DTaCVsntNTS50TTS+iDL/KtkbwoAIIkopU2sMG
         K/voMJKyQ6TJwns4nm9o6aFCbdHA2leew2FJEVcYNitVLmoht0V58SNSP7ZaxjLW3mqt
         4img==
X-Gm-Message-State: APjAAAWY97ZYea0h2oK/G4WOj1i0NG0V4aUKWDSlNUDl1HxCOAP8yV7h
        g/L9Za2M5md3xVVwZvHFra1jy1XyEzDdClE9GvA=
X-Google-Smtp-Source: APXvYqw7pZA8I1p2Z3xXf6iFKv5gGUxbFhl/J9psNXrNfox8A2LIxC5i5b1RZIV27Se5v75pQgL4xl8cksnNt2wnOAU=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr6937615oth.266.1573722801134;
 Thu, 14 Nov 2019 01:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20191113023559.62295-1-saravanak@google.com>
In-Reply-To: <20191113023559.62295-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 10:13:10 +0100
Message-ID: <CAJZ5v0hZZzq=U+6Tpja+hsZOhPMDVik5E+9kX=q2nSCbE8Lf4Q@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Allow device link operations inside sync_state()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 3:36 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Some sync_state() implementations might need to call APIs that in turn
> make calls to device link APIs. So, do the sync_state() callbacks
> without holding the device link lock.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 63 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 55 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e6d3e6d485da..d396b0597c10 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -48,6 +48,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
>  static LIST_HEAD(wait_for_suppliers);
>  static DEFINE_MUTEX(wfs_lock);
>  static LIST_HEAD(deferred_sync);
> +static LIST_HEAD(sync_list);
> +static DEFINE_MUTEX(sync_lock);
>  static unsigned int defer_sync_state_count = 1;
>
>  #ifdef CONFIG_SRCU
> @@ -695,7 +697,23 @@ int device_links_check_suppliers(struct device *dev)
>         return ret;
>  }
>
> -static void __device_links_supplier_sync_state(struct device *dev)
> +/** __device_links_queue_sync_state - Queue a device for sync_state() callback
> + * @dev: Device to call sync_state() on
> + *
> + * Queues a device for a sync_state() callback when the device links write lock
> + * isn't held. This allows the sync_state() execution flow to use device links
> + * APIs.  The caller must ensure this function is called with
> + * device_links_write_lock() held.
> + *
> + * This function does a get_device() to make sure the device is not freed while
> + * on this list.
> + *
> + * So the caller must also ensure that device_links_flush_sync_list() is called
> + * as soon as the caller releases device_links_write_lock().  This is necessary
> + * to make sure the sync_state() is called in a timely fashion and the
> + * put_device() is called on this device.
> + */
> +static void __device_links_queue_sync_state(struct device *dev)
>  {
>         struct device_link *link;
>
> @@ -709,12 +727,35 @@ static void __device_links_supplier_sync_state(struct device *dev)
>                         return;
>         }
>
> -       if (dev->bus->sync_state)
> -               dev->bus->sync_state(dev);
> -       else if (dev->driver && dev->driver->sync_state)
> -               dev->driver->sync_state(dev);
> -
>         dev->state_synced = true;
> +
> +       mutex_lock(&sync_lock);

Total nit: I add empty lines around lock/unlock as a rule to make them
more visible.

> +       WARN_ON(!list_empty(&dev->links.defer_sync));
> +       if (list_empty(&dev->links.defer_sync)) {

Do you really need to duplicate that check?

> +               get_device(dev);
> +               list_add_tail(&dev->links.defer_sync, &sync_list);
> +       }
> +       mutex_unlock(&sync_lock);
> +}

What about adding

} else {
        WARN_ON(1);
}

here instead?

> +

Kerneldoc?

> +static void device_links_flush_sync_list(void)
> +{
> +       struct device *dev, *tmp;
> +
> +       mutex_lock(&sync_lock);
> +
> +       list_for_each_entry_safe(dev, tmp, &sync_list, links.defer_sync) {
> +               list_del_init(&dev->links.defer_sync);
> +               device_lock(dev);
> +               if (dev->bus->sync_state)
> +                       dev->bus->sync_state(dev);
> +               else if (dev->driver && dev->driver->sync_state)
> +                       dev->driver->sync_state(dev);
> +               device_unlock(dev);
> +               put_device(dev);
> +       }
> +
> +       mutex_unlock(&sync_lock);
>  }
>
>  void device_links_supplier_sync_state_pause(void)
> @@ -738,11 +779,16 @@ void device_links_supplier_sync_state_resume(void)
>                 goto out;
>
>         list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
> -               __device_links_supplier_sync_state(dev);
> +               /*
> +                * Delete from deferred_sync list before queuing it to
> +                * sync_list because defer_sync is used for both lists.
> +                */
>                 list_del_init(&dev->links.defer_sync);
> +               __device_links_queue_sync_state(dev);
>         }
>  out:
>         device_links_write_unlock();
> +       device_links_flush_sync_list();

Wouldn't it be better to use a local list in this function instead of
the global sync_list?

I guess the idea is that you wouldn't be able to do the flush in
device_links_driver_bound() below, but do you really need that flush?

It looks like this is the only place calling
__device_links_queue_sync_state() and you do a flush right away after
the loop, so why is the extra flush in device_links_driver_bound()
needed?

>  }
>
>  static int sync_state_resume_initcall(void)
> @@ -815,12 +861,13 @@ void device_links_driver_bound(struct device *dev)
>                 if (defer_sync_state_count)
>                         __device_links_supplier_defer_sync(link->supplier);
>                 else
> -                       __device_links_supplier_sync_state(link->supplier);
> +                       __device_links_queue_sync_state(link->supplier);
>         }
>
>         dev->links.status = DL_DEV_DRIVER_BOUND;
>
>         device_links_write_unlock();
> +       device_links_flush_sync_list();

It looks like devices can be added to sync_list in parallel with each
other and so is it always OK to always flush all of them after one of
them has been bound to a driver?

>  }
>
>  static void device_link_drop_managed(struct device_link *link)
> --
