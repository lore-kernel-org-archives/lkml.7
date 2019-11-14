Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD12C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F295206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573768577;
	bh=R0rpupKe/KP8TjMK5DD+8jmyeCI/nvwRxVIUB4TippE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XkGAIdmarvS8LNNjg2gB1225NbiRxm46sbmVb3LRvjFrKDm9mZUzdhbp/GlviWNkJ
	 P4+urFRHE/R5pM/F/ElmmLa6WD6Tp1PqBORu6ZlS8cI1XTwTXejxUlNxLOSGvHB/Aj
	 K8Hg/O3vE1sZyDoF50y7mfb+l8/soy1bfMgxIS7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKNV4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:56:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38654 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKNV4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:56:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id z25so6279466oti.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 13:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YK6IQ+WzJL19YfA0CWiS2Ye2YhP1AEHuOCWUHx3hgqI=;
        b=CHZA+7s0PqvevTDOwoygVquu8CS5vYjsuWS/6nlMQ58qyOPwRwHGGmK4Q+L059i1uf
         yuD8UdDMMqNVcmlCHxuhMSlD/+o+fNiQZpgODhJanH9uYSn3Goi6Udu/w0ti8kIbZUKU
         1Ip+msDK6HgHejuOBzJFohWgfGEPDULbEuht2IdI5iqSUnQtiv4uDMP5slrCIxLkSEN3
         SL6c3bkCcgPF/VCrBD0YUv/r56m0nLkB9/ga6sVuJS9LIMnvKfpGnmh0/wDeYiJNLG2y
         OEthdIAS6748BJQJqCpd6Q0Tz2F+rGj35Z+O4oEAc/uudGcu3PmAM6w0VMHBjFhjBKqs
         6yQA==
X-Gm-Message-State: APjAAAX0eSzoJvwYb91coiE+MxDhIikQYNVR1jJhE5/b6+2V3mbPkQbW
        VOt4k2fvlY8tD42XEwV630TSimsCB2U97tn0ALg=
X-Google-Smtp-Source: APXvYqyqiFl/p0y6prP6hffgfvV+lXABIvpyguaI1ekxCEUaEHc501dvD5jpufESbjczzO+aIwlfHnywdcrSdg78fN4=
X-Received: by 2002:a9d:590f:: with SMTP id t15mr8484659oth.118.1573768574899;
 Thu, 14 Nov 2019 13:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20191114194205.21730-1-saravanak@google.com>
In-Reply-To: <20191114194205.21730-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 22:56:03 +0100
Message-ID: <CAJZ5v0gfW9z87Q9K45Jih7mUqJDVPsdTatg7a13JxJvEP0GCAg@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Allow device link operations inside sync_state()
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

On Thu, Nov 14, 2019 at 8:42 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Some sync_state() implementations might need to call APIs that in turn
> make calls to device link APIs. So, do the sync_state() callbacks
> without holding the device link lock.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

It would have been kind of nice to let me respond to your last reply
before sending this.  Oh well.

> ---
>  drivers/base/core.c | 76 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 68 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e6d3e6d485da..2f14d4bf1472 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -48,6 +48,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
>  static LIST_HEAD(wait_for_suppliers);
>  static DEFINE_MUTEX(wfs_lock);
>  static LIST_HEAD(deferred_sync);
> +static LIST_HEAD(sync_list);
> +static DEFINE_MUTEX(sync_lock);

The two items above are not needed AFAICS.

>  static unsigned int defer_sync_state_count = 1;
>
>  #ifdef CONFIG_SRCU
> @@ -695,7 +697,23 @@ int device_links_check_suppliers(struct device *dev)
>         return ret;
>  }
>
> -static void __device_links_supplier_sync_state(struct device *dev)
> +/** __device_links_queue_sync_state - Queue a device for sync_state() callback

This should be

/**
 * __device_links_queue_sync_state - Queue a device for sync_state() callback

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

Pass a list head as a second arg.

>  {
>         struct device_link *link;
>
> @@ -709,12 +727,48 @@ static void __device_links_supplier_sync_state(struct device *dev)
>                         return;
>         }
>
> -       if (dev->bus->sync_state)
> -               dev->bus->sync_state(dev);
> -       else if (dev->driver && dev->driver->sync_state)
> -               dev->driver->sync_state(dev);
> -
> +       /*
> +        * Set the flag here to avoid adding the same device to the sync_list
> +        * more than once. This can happen if new consumers get added to the
> +        * device before the sync_list is flushed.
> +        */
>         dev->state_synced = true;
> +
> +       mutex_lock(&sync_lock);
> +
> +       if (list_empty(&dev->links.defer_sync)) {
> +               get_device(dev);
> +               list_add_tail(&dev->links.defer_sync, &sync_list);

Add it to the list that you have passed as the second arg.  No locking.

> +       } else {
> +               WARN_ON(1);
> +       }
> +
> +       mutex_unlock(&sync_lock);
> +}
> +
> +/** device_links_flush_sync_list - Call sync_state() on devices queued for it
> + *
> + * Calls sync_state() on all the devices that have been queued for it. This
> + * function is used in conjunction with __device_links_queue_sync_state().
> + */
> +static void device_links_flush_sync_list(void)

Make it take a list to flush as an arg.

> +{
> +       struct device *dev, *tmp;
> +
> +       mutex_lock(&sync_lock);

This isn't necessary.

> +
> +       list_for_each_entry_safe(dev, tmp, &sync_list, links.defer_sync) {
> +               list_del_init(&dev->links.defer_sync);
> +               device_lock(dev);

Empty lines around this?

> +               if (dev->bus->sync_state)
> +                       dev->bus->sync_state(dev);
> +               else if (dev->driver && dev->driver->sync_state)
> +                       dev->driver->sync_state(dev);
> +               device_unlock(dev);

And this?

> +               put_device(dev);
> +       }
> +
> +       mutex_unlock(&sync_lock);

This isn't necessary.

>  }
>
>  void device_links_supplier_sync_state_pause(void)
> @@ -738,11 +792,16 @@ void device_links_supplier_sync_state_resume(void)
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

Use a local list (initially empty) in this function and pass it to the above.

>         }
>  out:
>         device_links_write_unlock();
> +       device_links_flush_sync_list();

Pass the local list here too.

>  }
>
>  static int sync_state_resume_initcall(void)
> @@ -815,12 +874,13 @@ void device_links_driver_bound(struct device *dev)
>                 if (defer_sync_state_count)
>                         __device_links_supplier_defer_sync(link->supplier);
>                 else
> -                       __device_links_supplier_sync_state(link->supplier);
> +                       __device_links_queue_sync_state(link->supplier);

Like in the previous case, use a local list (initially empty) in this
function and pass it to the above.

>         }
>
>         dev->links.status = DL_DEV_DRIVER_BOUND;
>
>         device_links_write_unlock();
> +       device_links_flush_sync_list();

And pass that list here too.

>  }
>
>  static void device_link_drop_managed(struct device_link *link)
> --
