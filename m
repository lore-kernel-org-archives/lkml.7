Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC08FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39BF206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573722943;
	bh=zFwXImjcFRfGHmSnvZE9pSw9T7T9INupTUsHGTNq4Xo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1Mf2a3RuwkssltOfO5yJpDSo5aKdbKxv7zyjCJ+UedrU6ECV4n8S4IBOuFJMdPmKW
	 3pKF61u/kC4WVv9hVTU3Ngd+70PxJhH7PzoGMpDbZ0CmcXkh+PeLSxif5NOwI5PKkG
	 Wza3W3+OGkrKaKBTsIvNCcPaIthptug4yXtMLKGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKNJPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:15:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34034 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKNJPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:15:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id l202so4663212oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 01:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTF6C0MneBCzQ2l+W5YCH3xv4kzAkH/1kcgnxi3HaUw=;
        b=sEiX8P3WHTXpl11oyOnl6+gffICj59wq70TqlErOqhu2M5E6F8qqL/TRdYIQ+wu/3E
         sOs4gvj/gW69nKCSZGkx5m1qpoaEEiwcWaDpH6xFOg+HQ5eWnV87wyjuF0fD5NLz/1Ey
         5heWi9CmnQB1rkbvqpTrM3Pv4iMWn6xUqALM1+bSU4eMiewheiweBOyxknu+uzhvNZKA
         efG33+U6BrpFVDrxHOl6GwkFc2mTQzVwhFKKENNrCgGhTCratZFOtELS8ZDLie0KE4EZ
         cop8s87dH+T7hhR46/6A1hnpFTtWscCjb9b8gR+kVmxuDmXlw7I1lkIPHeylqqTjGDHL
         GAxQ==
X-Gm-Message-State: APjAAAXmR115hsIs01/YgXo3K1Uu7aGR1tCtoD28qydKu9Y4sa5nfuh3
        6OJoR+pN4ncAOP5TC/HLTYf1x1F160fYhtxehSs=
X-Google-Smtp-Source: APXvYqwaPmPNiopmza19ilOiY6XJsUuMHsjEvH+Vvl7ihA5WrIlM7Jpc38y1XLn6RswluefJOG+wBuQMgLdMeHL/VUI=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr2729017oih.57.1573722941190;
 Thu, 14 Nov 2019 01:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20191113023559.62295-1-saravanak@google.com>
In-Reply-To: <20191113023559.62295-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 10:15:30 +0100
Message-ID: <CAJZ5v0iURLDQFEvVwvt3hRokLRkJ5C8iEXOcR9mS7cgC9dQrQQ@mail.gmail.com>
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

BTW, this should go into device_links_flush_sync_list() too, shouldn't it?
