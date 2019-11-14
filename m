Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD397C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823A2206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573771538;
	bh=xN7BqHG8v5qTljz1rtNacBFEUWeXv4gNUxLNQix72fc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=urgbZ5UtegSw3rhONN6+OKJW1wMo2cM5MTT0ccSiFhTf6UtGIw0Oqyf7uQ3FXhHOG
	 /vq4kjMxhTmmqmS78uv2ymu0stVF/whRqohUKUJqhILAO9tczntkYmqEY9e1XoCbPX
	 Fg9yKDAaG9lg7L/hA75WxZjit3lsfXe1S6Y6VBvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKNWph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:45:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43012 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKNWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:45:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id l20so6850535oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 14:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhMAaOuLWO6MHWm0rzegVnx1g/8bytY9Jgc505hZftA=;
        b=c6MNRRz3abkWdy4hRt7V7q18dBgCZekG8uF79K45svJMTmE7w1C/gaW0Uqv+h7IJXk
         TkH7eDzX76ol1PLqLkmjnsk+gW7r+Ih/5Hj9DeYVvrSck0MzhA1upaBXqlhCAK/wYisf
         C8SMNGJLp7BQjSZqXvSUibhu/9HBuhWHvqc0jmmILXIG1R7O5UfSStruefcSslRRg6P4
         XIjIZkfnmaU53eZMGeyeslivE8U1BOw5Kh4timGwS9Cr+GbGoK+ZGbjI7bCau8FvLyhk
         6uEe2qZdGBFD1kcA9pJljUc5VAZnLdRBTSUTJ02z/bTg/YoNNpQPNCGdunAPtZ5sQEU7
         9ZhA==
X-Gm-Message-State: APjAAAVaTVYZnilI1HWpeC7kebZMW33BXfNp0ErG52+NEpDO/JSOyRuf
        yY+gZLAWesA2cxrUK28QncL5Mz6Ml1d9d8OvtWI=
X-Google-Smtp-Source: APXvYqxge4NVhPaIpqZwlGWo/G7Jr3nHf6l+Z+kaIKF14Hia8GsmFTC18onwYR8YvPvVCbEOgYIuy6Q3j+0MwI5e2uo=
X-Received: by 2002:aca:1101:: with SMTP id 1mr5685729oir.103.1573771535925;
 Thu, 14 Nov 2019 14:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20191114222348.226355-1-saravanak@google.com>
In-Reply-To: <20191114222348.226355-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 23:45:24 +0100
Message-ID: <CAJZ5v0gFUmNd1JNNV+KdQLZ6Zw0VTjtEumbBpy20=0Py0q=OKQ@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Allow device link operations inside sync_state()
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

On Thu, Nov 14, 2019 at 11:23 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Some sync_state() implementations might need to call APIs that in turn
> make calls to device link APIs. So, do the sync_state() callbacks
> without holding the device link lock.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 80 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 72 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e6d3e6d485da..9a88bcfd5d33 100644
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
> @@ -709,12 +728,46 @@ static void __device_links_supplier_sync_state(struct device *dev)
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
> +       if (list_empty(&dev->links.defer_sync)) {
> +               get_device(dev);
> +               list_add_tail(&dev->links.defer_sync, list);
> +       } else {
> +               WARN_ON(1);
> +       }

Now you can do:

        if (WARN_ON(!list_empty(&dev->links.defer_sync)))
                return;

        get_device(dev);
        list_add_tail(&dev->links.defer_sync, list);

The rest of the patch LGTM.
