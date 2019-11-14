Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E46C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3B0206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573769279;
	bh=nPvE5iRI9oeFBuVCR7FRwxyrrVDdSptxmqqrURrPtgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eQ20M4/amVEcZvM7amjju0njxE6ZtDhLbWCKXbsTr9jYkVeE4KeQyxggdbN06yVFB
	 9Y9rrwmC0l7ss+L/eMnzN58ml2WOg7Jz3HfOwWsQvxBpc1E1KWssMjbFONzG55X4jr
	 dLoSPM5BHYApDNXwE8J3OA+Yld0CyMGKoZ4cfoyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKNWH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:07:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36499 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKNWH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:07:58 -0500
Received: by mail-ot1-f67.google.com with SMTP id f10so6301676oto.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 14:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbHcmmT+K7/6Dz8UTlhzAfwajNR/U9qce79LxD5PYpM=;
        b=Cx3wEd+/5SwNOwRvqKqZTRsZEO5R/R2GRyH596pAbV+qSy3SWTUxpifEXsJLfn5c75
         NJ/BQxIMJoJBjpjsUQwa76DVSSiTddXPVTVJtj/tteIZ2la7/wgoH21ivFJF+sMTAJZ6
         B7g2gH/sX7bz5YBWIKyDsQCv9AyPLvWUWr4q4iRr283gtV0ZTumyJdpf4CKfeDHqs6NU
         3VoXc/cMomqQKL3Y6jtrsNT4xV57Hfdarjqx9ThMzCxV90fpV4bpqHAmcLLEWAGf8QCp
         nBsry/wQ8+Rq+UQsVvJtfXIjA1VgalDNDoVH0enrDoEHD1gxYEnfb2jeUxHE7ZoUxikM
         J7/A==
X-Gm-Message-State: APjAAAVdBqclNnTfxlYbRLqWWf1URg1KUXhsYQ2cR2u7wZbKApGG3877
        YkBrOIikGBphShQqUGIob4xDvIjlcMU4f+J+bRI=
X-Google-Smtp-Source: APXvYqyAf/wr3mQU3LIWfRQEhPg/EMgYf/J0J6/O/He8x2Mj1w5u+z6edEnrnhi8QMpFNL9+ub6ffLZYUVeyx2E81F4=
X-Received: by 2002:a05:6830:232a:: with SMTP id q10mr9360487otg.262.1573769276711;
 Thu, 14 Nov 2019 14:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20191114194205.21730-1-saravanak@google.com> <CAJZ5v0gfW9z87Q9K45Jih7mUqJDVPsdTatg7a13JxJvEP0GCAg@mail.gmail.com>
 <CAGETcx_GHhCwzKP+0GTQ-p6WahKBBWwsMGJORj9rzQSoVx0CEA@mail.gmail.com>
In-Reply-To: <CAGETcx_GHhCwzKP+0GTQ-p6WahKBBWwsMGJORj9rzQSoVx0CEA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 23:07:45 +0100
Message-ID: <CAJZ5v0jTbqgEhU6XJAv88i+6dW6Zwu9hELvpriN88OpR2cCv+w@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Allow device link operations inside sync_state()
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:59 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Nov 14, 2019 at 1:56 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Nov 14, 2019 at 8:42 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Some sync_state() implementations might need to call APIs that in turn
> > > make calls to device link APIs. So, do the sync_state() callbacks
> > > without holding the device link lock.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > It would have been kind of nice to let me respond to your last reply
> > before sending this.  Oh well.
> >
> > > ---
> > >  drivers/base/core.c | 76 ++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 68 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index e6d3e6d485da..2f14d4bf1472 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -48,6 +48,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
> > >  static LIST_HEAD(wait_for_suppliers);
> > >  static DEFINE_MUTEX(wfs_lock);
> > >  static LIST_HEAD(deferred_sync);
> > > +static LIST_HEAD(sync_list);
> > > +static DEFINE_MUTEX(sync_lock);
> >
> > The two items above are not needed AFAICS.
> >
> > >  static unsigned int defer_sync_state_count = 1;
> > >
> > >  #ifdef CONFIG_SRCU
> > > @@ -695,7 +697,23 @@ int device_links_check_suppliers(struct device *dev)
> > >         return ret;
> > >  }
> > >
> > > -static void __device_links_supplier_sync_state(struct device *dev)
> > > +/** __device_links_queue_sync_state - Queue a device for sync_state() callback
> >
> > This should be
> >
> > /**
> >  * __device_links_queue_sync_state - Queue a device for sync_state() callback
> >
> > > + * @dev: Device to call sync_state() on
> > > + *
> > > + * Queues a device for a sync_state() callback when the device links write lock
> > > + * isn't held. This allows the sync_state() execution flow to use device links
> > > + * APIs.  The caller must ensure this function is called with
> > > + * device_links_write_lock() held.
> > > + *
> > > + * This function does a get_device() to make sure the device is not freed while
> > > + * on this list.
> > > + *
> > > + * So the caller must also ensure that device_links_flush_sync_list() is called
> > > + * as soon as the caller releases device_links_write_lock().  This is necessary
> > > + * to make sure the sync_state() is called in a timely fashion and the
> > > + * put_device() is called on this device.
> > > + */
> > > +static void __device_links_queue_sync_state(struct device *dev)
> >
> > Pass a list head as a second arg.
> >
> > >  {
> > >         struct device_link *link;
> > >
> > > @@ -709,12 +727,48 @@ static void __device_links_supplier_sync_state(struct device *dev)
> > >                         return;
> > >         }
> > >
> > > -       if (dev->bus->sync_state)
> > > -               dev->bus->sync_state(dev);
> > > -       else if (dev->driver && dev->driver->sync_state)
> > > -               dev->driver->sync_state(dev);
> > > -
> > > +       /*
> > > +        * Set the flag here to avoid adding the same device to the sync_list
> > > +        * more than once. This can happen if new consumers get added to the
> > > +        * device before the sync_list is flushed.
> > > +        */
> > >         dev->state_synced = true;
> > > +
> > > +       mutex_lock(&sync_lock);
> > > +
> > > +       if (list_empty(&dev->links.defer_sync)) {
> > > +               get_device(dev);
> > > +               list_add_tail(&dev->links.defer_sync, &sync_list);
> >
> > Add it to the list that you have passed as the second arg.  No locking.
> >
> > > +       } else {
> > > +               WARN_ON(1);
> > > +       }
> > > +
> > > +       mutex_unlock(&sync_lock);
> > > +}
> > > +
> > > +/** device_links_flush_sync_list - Call sync_state() on devices queued for it
> > > + *
> > > + * Calls sync_state() on all the devices that have been queued for it. This
> > > + * function is used in conjunction with __device_links_queue_sync_state().
> > > + */
> > > +static void device_links_flush_sync_list(void)
> >
> > Make it take a list to flush as an arg.
> >
> > > +{
> > > +       struct device *dev, *tmp;
> > > +
> > > +       mutex_lock(&sync_lock);
> >
> > This isn't necessary.
> >
> > > +
> > > +       list_for_each_entry_safe(dev, tmp, &sync_list, links.defer_sync) {
> > > +               list_del_init(&dev->links.defer_sync);
> > > +               device_lock(dev);
> >
> > Empty lines around this?
> >
> > > +               if (dev->bus->sync_state)
> > > +                       dev->bus->sync_state(dev);
> > > +               else if (dev->driver && dev->driver->sync_state)
> > > +                       dev->driver->sync_state(dev);
> > > +               device_unlock(dev);
> >
> > And this?
> >
> > > +               put_device(dev);
> > > +       }
> > > +
> > > +       mutex_unlock(&sync_lock);
> >
> > This isn't necessary.
> >
> > >  }
> > >
> > >  void device_links_supplier_sync_state_pause(void)
> > > @@ -738,11 +792,16 @@ void device_links_supplier_sync_state_resume(void)
> > >                 goto out;
> > >
> > >         list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
> > > -               __device_links_supplier_sync_state(dev);
> > > +               /*
> > > +                * Delete from deferred_sync list before queuing it to
> > > +                * sync_list because defer_sync is used for both lists.
> > > +                */
> > >                 list_del_init(&dev->links.defer_sync);
> > > +               __device_links_queue_sync_state(dev);
> >
> > Use a local list (initially empty) in this function and pass it to the above.
> >
> > >         }
> > >  out:
> > >         device_links_write_unlock();
> > > +       device_links_flush_sync_list();
> >
> > Pass the local list here too.
> >
> > >  }
> > >
> > >  static int sync_state_resume_initcall(void)
> > > @@ -815,12 +874,13 @@ void device_links_driver_bound(struct device *dev)
> > >                 if (defer_sync_state_count)
> > >                         __device_links_supplier_defer_sync(link->supplier);
> > >                 else
> > > -                       __device_links_supplier_sync_state(link->supplier);
> > > +                       __device_links_queue_sync_state(link->supplier);
> >
> > Like in the previous case, use a local list (initially empty) in this
> > function and pass it to the above.
> >
> > >         }
> > >
> > >         dev->links.status = DL_DEV_DRIVER_BOUND;
> > >
> > >         device_links_write_unlock();
> > > +       device_links_flush_sync_list();
> >
> > And pass that list here too.
> >
> > >  }
> > >
> > >  static void device_link_drop_managed(struct device_link *link)
> > > --
>
> Ok, I'll move it to a local list, add the blank lines and send out a patch?

Works for me. :-)
