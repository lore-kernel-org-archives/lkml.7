Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB2AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8400F20706
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbYoUKwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKNWzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:55:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36450 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKNWzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:55:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id f10so6404005oto.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 14:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KxZ1Ibqc+KUsdUu40X3MgsOVQYNN79f6M4asQUu3LOU=;
        b=NbYoUKwoIt40q3gfcxeer7WRQUMWbljMK0KnWPm5GUlT0n0+O9uc5PejgfIe5T59/v
         bocswU66sav+NK8orfQMo61JlIR8pJEX7UMy+avligm+By1P3vcdRs5jVmDRDQ8/zbwz
         IJUcLzvkUvM2K4s83uH+m1JVjZfZ7d9HuioWDtH+nqxPcyv0Hwb6hfVhB18qRjLITIkM
         wQtCQI/6FKE20hWr5HpkwXyNpMBLEiaPOWZhpj//KGI0ByeDDwLeIv3GzqcsTu9Nwh8A
         /e4CZrgdm3X0CaOM3rfkx8pfOClHUsvfcBlNxUQcAFR65GA3myAcMMXUZeE4ytr5QLFN
         nfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxZ1Ibqc+KUsdUu40X3MgsOVQYNN79f6M4asQUu3LOU=;
        b=M2oJmSKyX3d9oNjE7QR7A4Am1J0V9IHdugdC8bGm+nwGUNA/I96tKPOKCOJOcqFjpU
         pQ20qZHhj9tADqTBtAILJJ0QIpGU8jMd2K4IqtinLEI4TxRzZ6w67PoEeefJpDqFeF4R
         aEmcY4PccNDD0oWJjwTEbD5Ef1XJwvSGQeAas1aDGJmaKHM1FUkBc+Hv95JGfXb191KJ
         vzcxttUZmL8yjAo2lmPACtf2SKfmy0Dy8SZ+yIgw/KObiALmd13DSn320FIoaKmfvtDu
         QgL7FpOp5ywkA1BZ8unXkpmRPGzuihm56mKKCWqOCrkv6BGBL5NnkfBxX720cQoFGAbB
         faYw==
X-Gm-Message-State: APjAAAWo0N4IMbt0TjUvyjhF7/0olnc/KxPqgwdi55UJjy7Da15OMEoV
        u3p0BLoqcyb66wGhI1UTKfO2F9nt+uIvuVD9PI/oOhFzcAQ=
X-Google-Smtp-Source: APXvYqyKW+MrDuxMaUQjJlQAMLr1M8M9YrO+dcOtXg7N+PijYw1bovZT8Tk4L98sptfZt8akRCT4cAAvzuPH7vYKeSU=
X-Received: by 2002:a9d:6f15:: with SMTP id n21mr9701011otq.231.1573772115532;
 Thu, 14 Nov 2019 14:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20191114222348.226355-1-saravanak@google.com> <CAJZ5v0gFUmNd1JNNV+KdQLZ6Zw0VTjtEumbBpy20=0Py0q=OKQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gFUmNd1JNNV+KdQLZ6Zw0VTjtEumbBpy20=0Py0q=OKQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 14 Nov 2019 14:54:39 -0800
Message-ID: <CAGETcx8EFMzjoMjeernyGPGSKg_nTE1os_SYGmwLnRBw7nVVkA@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Allow device link operations inside sync_state()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 2:45 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 14, 2019 at 11:23 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Some sync_state() implementations might need to call APIs that in turn
> > make calls to device link APIs. So, do the sync_state() callbacks
> > without holding the device link lock.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 80 ++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 72 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index e6d3e6d485da..9a88bcfd5d33 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -695,7 +695,26 @@ int device_links_check_suppliers(struct device *dev)
> >         return ret;
> >  }
> >
> > -static void __device_links_supplier_sync_state(struct device *dev)
> > +/**
> > + * __device_links_queue_sync_state - Queue a device for sync_state() callback
> > + * @dev: Device to call sync_state() on
> > + * @list: List head to queue the @dev on
> > + *
> > + * Queues a device for a sync_state() callback when the device links write lock
> > + * isn't held. This allows the sync_state() execution flow to use device links
> > + * APIs.  The caller must ensure this function is called with
> > + * device_links_write_lock() held.
> > + *
> > + * This function does a get_device() to make sure the device is not freed while
> > + * on this list.
> > + *
> > + * So the caller must also ensure that device_links_flush_sync_list() is called
> > + * as soon as the caller releases device_links_write_lock().  This is necessary
> > + * to make sure the sync_state() is called in a timely fashion and the
> > + * put_device() is called on this device.
> > + */
> > +static void __device_links_queue_sync_state(struct device *dev,
> > +                                           struct list_head *list)
> >  {
> >         struct device_link *link;
> >
> > @@ -709,12 +728,46 @@ static void __device_links_supplier_sync_state(struct device *dev)
> >                         return;
> >         }
> >
> > -       if (dev->bus->sync_state)
> > -               dev->bus->sync_state(dev);
> > -       else if (dev->driver && dev->driver->sync_state)
> > -               dev->driver->sync_state(dev);
> > -
> > +       /*
> > +        * Set the flag here to avoid adding the same device to a list more
> > +        * than once. This can happen if new consumers get added to the device
> > +        * and probed before the list is flushed.
> > +        */
> >         dev->state_synced = true;
> > +
> > +       if (list_empty(&dev->links.defer_sync)) {
> > +               get_device(dev);
> > +               list_add_tail(&dev->links.defer_sync, list);
> > +       } else {
> > +               WARN_ON(1);
> > +       }
>
> Now you can do:
>
>         if (WARN_ON(!list_empty(&dev->links.defer_sync)))
>                 return;
>
>         get_device(dev);
>         list_add_tail(&dev->links.defer_sync, list);
>
> The rest of the patch LGTM.

Sending the patch right away in hopes of getting a reviewed-by or ack :)

-Saravana
