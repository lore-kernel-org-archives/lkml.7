Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 23:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1780C20725
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 23:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573775611;
	bh=XfErDZIV88RKyEKHVPFKDzmOFo+2JtIfTWJY6EOmNHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dUChbhRvFdtAwdPp+LORQYrgiX8otepBLOekSm8BvZbNUL+rfXaOlKjnz2z/VR39a
	 vDSyvWZPZFkm4WTdftB1R9gbfcs9hCY6JwaRgCtIIbiedXRhg2In6XQ9saMvCB05/m
	 THyVU4zxQ+I2eOvaaoP7ORhghbqZS6rT/H56qh1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKNXxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 18:53:30 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44467 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKNXx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:53:29 -0500
Received: by mail-oi1-f195.google.com with SMTP id s71so6984827oih.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 15:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iT8mbSkLN0X/zzIX/eSTHO9gOy235N/wyyt96ibogJk=;
        b=tdhB1NzH2ZKthsYmQKWJAs172KRjSNZP3Sq31TK+PHdPusoWQoPagYm8V2Dn6Z+zAY
         c/TrH9DPCF1x7g8GnCfHijbkQ26bCcbuIGLh+v7Ajw9PMCOfsvGy2KF/T+ON+9Rw6b/B
         hUBYsXglLiDk6x0mdQo5gOHmilGyAnGTI0nVlcHmzxcxYbMxrgPfbNAoKuBZSnfgo0W6
         PTVxjo3bgZdUTgG9c/3lYiiWXbB6TFGxGqiDpwxZpCDD9/6rSeM671HOO3+kytlcaJD1
         UTHhKlLUDJL7B0EaySS7640ocmv5aV4gmDgg1u1XC1uPmbAnDKsm1q26YxZ85vW/G1h2
         sa4w==
X-Gm-Message-State: APjAAAUT40DIS4e/7Z/9zBH+HLN+GqEcQmC74lvCsdZdpKRqTcPMsw2n
        5AvROFmkviQkjRaS45P1Xp2OiM634g93+nnT2rc=
X-Google-Smtp-Source: APXvYqztbETX3OxlyP+NgFIjqqQg818W2qyXbYlKDxo1EjB2rmSXNbvmz+wN4iiyKDHXxUf6aKdHfd8N07Is8kxDTJY=
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr5514377oig.68.1573775608000;
 Thu, 14 Nov 2019 15:53:28 -0800 (PST)
MIME-Version: 1.0
References: <20191114225646.251277-1-saravanak@google.com>
In-Reply-To: <20191114225646.251277-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Nov 2019 00:53:16 +0100
Message-ID: <CAJZ5v0izLzumE4xGZyxrVJ4OJ6SNytpA5fVZ4q7pC4ve0S7pYw@mail.gmail.com>
Subject: Re: [PATCH v4] driver core: Allow device link operations inside sync_state()
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

On Thu, Nov 14, 2019 at 11:56 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Some sync_state() implementations might need to call APIs that in turn
> make calls to device link APIs. So, do the sync_state() callbacks
> without holding the device link lock.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

All of my comments have been addressed, so:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/core.c | 79 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 71 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e6d3e6d485da..42a672456432 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -695,7 +695,26 @@ int device_links_check_suppliers(struct device *dev)
>         return ret;
>  }
>
> -static void __device_links_supplier_sync_state(struct device *dev)
> +/**
> + * __device_links_queue_sync_state - Queue a device for sync_state() callback
> + * @dev: Device to call sync_state() on
> + * @list: List head to queue the @dev on
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
> +static void __device_links_queue_sync_state(struct device *dev,
> +                                           struct list_head *list)
>  {
>         struct device_link *link;
>
> @@ -709,12 +728,45 @@ static void __device_links_supplier_sync_state(struct device *dev)
>                         return;
>         }
>
> -       if (dev->bus->sync_state)
> -               dev->bus->sync_state(dev);
> -       else if (dev->driver && dev->driver->sync_state)
> -               dev->driver->sync_state(dev);
> -
> +       /*
> +        * Set the flag here to avoid adding the same device to a list more
> +        * than once. This can happen if new consumers get added to the device
> +        * and probed before the list is flushed.
> +        */
>         dev->state_synced = true;
> +
> +       if (WARN_ON(!list_empty(&dev->links.defer_sync)))
> +               return;
> +
> +       get_device(dev);
> +       list_add_tail(&dev->links.defer_sync, list);
> +}
> +
> +/**
> + * device_links_flush_sync_list - Call sync_state() on a list of devices
> + * @list: List of devices to call sync_state() on
> + *
> + * Calls sync_state() on all the devices that have been queued for it. This
> + * function is used in conjunction with __device_links_queue_sync_state().
> + */
> +static void device_links_flush_sync_list(struct list_head *list)
> +{
> +       struct device *dev, *tmp;
> +
> +       list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
> +               list_del_init(&dev->links.defer_sync);
> +
> +               device_lock(dev);
> +
> +               if (dev->bus->sync_state)
> +                       dev->bus->sync_state(dev);
> +               else if (dev->driver && dev->driver->sync_state)
> +                       dev->driver->sync_state(dev);
> +
> +               device_unlock(dev);
> +
> +               put_device(dev);
> +       }
>  }
>
>  void device_links_supplier_sync_state_pause(void)
> @@ -727,6 +779,7 @@ void device_links_supplier_sync_state_pause(void)
>  void device_links_supplier_sync_state_resume(void)
>  {
>         struct device *dev, *tmp;
> +       LIST_HEAD(sync_list);
>
>         device_links_write_lock();
>         if (!defer_sync_state_count) {
> @@ -738,11 +791,17 @@ void device_links_supplier_sync_state_resume(void)
>                 goto out;
>
>         list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
> -               __device_links_supplier_sync_state(dev);
> +               /*
> +                * Delete from deferred_sync list before queuing it to
> +                * sync_list because defer_sync is used for both lists.
> +                */
>                 list_del_init(&dev->links.defer_sync);
> +               __device_links_queue_sync_state(dev, &sync_list);
>         }
>  out:
>         device_links_write_unlock();
> +
> +       device_links_flush_sync_list(&sync_list);
>  }
>
>  static int sync_state_resume_initcall(void)
> @@ -772,6 +831,7 @@ static void __device_links_supplier_defer_sync(struct device *sup)
>  void device_links_driver_bound(struct device *dev)
>  {
>         struct device_link *link;
> +       LIST_HEAD(sync_list);
>
>         /*
>          * If a device probes successfully, it's expected to have created all
> @@ -815,12 +875,15 @@ void device_links_driver_bound(struct device *dev)
>                 if (defer_sync_state_count)
>                         __device_links_supplier_defer_sync(link->supplier);
>                 else
> -                       __device_links_supplier_sync_state(link->supplier);
> +                       __device_links_queue_sync_state(link->supplier,
> +                                                       &sync_list);
>         }
>
>         dev->links.status = DL_DEV_DRIVER_BOUND;
>
>         device_links_write_unlock();
> +
> +       device_links_flush_sync_list(&sync_list);
>  }
>
>  static void device_link_drop_managed(struct device_link *link)
> --
> 2.24.0.432.g9d3f5f5b63-goog
>
