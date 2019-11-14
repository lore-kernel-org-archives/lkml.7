Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B931DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C228206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOn9mr1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfKNTcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:32:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36086 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKNTcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:32:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id j7so6384526oib.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 11:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdwcF4F5MrX4GfU3MNu3tZA70X9aRizPH4oXTh2bu/A=;
        b=wOn9mr1F2KRMa1bCeYniU7pBxPgcPmtk61DVvP+16scMBg7a2OHR1nbiUQgrQXGARd
         2YQ7PkrHYXM6aircNagLU+p1W/HU0kIJ553U0JugHoanKLMbJJBEOUwSNXHmA8P+Ksx8
         JkcWpeqGf1CVs7DeQ3jVqrpfxlsZQcuZHTcXVTMWZuruGt0KJ1MD0bCZiPmaSFd+WRK7
         TM/6MGG9AXcZCQ2/pZLntK7m3sl+1/CIsGgHuchyRUCbQsZPwOlWXwdsNZhS64BkrlCU
         EYBdnUb/rdI4i/9AbtW9mxcjY/UPsBP6pZmVVaEWP0YGH9Dmq54R6NPT1Ud9afIHlTEy
         tgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdwcF4F5MrX4GfU3MNu3tZA70X9aRizPH4oXTh2bu/A=;
        b=gunkB7qqgUkELJ3gec17R1mYRAgizuozWrQjI+cnGVfyiEjFTi/uL3emyqpUIqO5En
         XUTjsWixO7DAF4uhwdrUqHCI2wd/fav/aHPUiqryrj2Y0RzSF0WFM/3bP5yCMIX80ann
         PTeer0wkOUZTYnnJ0PPM99ZvVllDHTwAc12TrWU3VOtHlH6dIabnVTr4d+NQoaBCZZf+
         QIjouFnsB2UhYgSQj4DzAH4kgKEqq/fxiCxrd32T1k3D3aVXRaodDUZ28qKudMUZ6wFL
         LMY75Igvk64nnwLY1TFsdby4kGZ0G73N30eIIVs508Q1T0/EIPJxnGywNknF7iUyzcm5
         NUNw==
X-Gm-Message-State: APjAAAVqm+lk4WwOJDb6jw4ALiRfnWQ0U83voxHOdjBZTXRp34ADBNM8
        bClmJz4hPArZxHiyHXEwJNFCkm+qQbR2J+9OLDzPbUNu5zlXeA==
X-Google-Smtp-Source: APXvYqzq8Mg54JRnFAbxlyOyyI0apHbEsvWbBnDLH+a9BfoI+fN/KCRiifBpAmmIeG6uitOOgZdUP1SDhEzz0Y01jrg=
X-Received: by 2002:aca:4dcc:: with SMTP id a195mr4908378oib.172.1573759964345;
 Thu, 14 Nov 2019 11:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20191113023559.62295-1-saravanak@google.com> <CAJZ5v0hZZzq=U+6Tpja+hsZOhPMDVik5E+9kX=q2nSCbE8Lf4Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hZZzq=U+6Tpja+hsZOhPMDVik5E+9kX=q2nSCbE8Lf4Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 14 Nov 2019 11:32:08 -0800
Message-ID: <CAGETcx9UXatfj4nOYLWscZ7ewa1p15RR2sbHzOsrFCe6fTgrHg@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Allow device link operations inside sync_state()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 1:13 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Nov 13, 2019 at 3:36 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Some sync_state() implementations might need to call APIs that in turn
> > make calls to device link APIs. So, do the sync_state() callbacks
> > without holding the device link lock.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 63 +++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 55 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index e6d3e6d485da..d396b0597c10 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -48,6 +48,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
> >  static LIST_HEAD(wait_for_suppliers);
> >  static DEFINE_MUTEX(wfs_lock);
> >  static LIST_HEAD(deferred_sync);
> > +static LIST_HEAD(sync_list);
> > +static DEFINE_MUTEX(sync_lock);
> >  static unsigned int defer_sync_state_count = 1;
> >
> >  #ifdef CONFIG_SRCU
> > @@ -695,7 +697,23 @@ int device_links_check_suppliers(struct device *dev)
> >         return ret;
> >  }
> >
> > -static void __device_links_supplier_sync_state(struct device *dev)
> > +/** __device_links_queue_sync_state - Queue a device for sync_state() callback
> > + * @dev: Device to call sync_state() on
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
> > +static void __device_links_queue_sync_state(struct device *dev)
> >  {
> >         struct device_link *link;
> >
> > @@ -709,12 +727,35 @@ static void __device_links_supplier_sync_state(struct device *dev)
> >                         return;
> >         }
> >
> > -       if (dev->bus->sync_state)
> > -               dev->bus->sync_state(dev);
> > -       else if (dev->driver && dev->driver->sync_state)
> > -               dev->driver->sync_state(dev);
> > -
> >         dev->state_synced = true;

<combining emails>
> BTW, this should go into device_links_flush_sync_list() too, shouldn't it?

Once a device is added to a sync list, it shouldn't be readded to the
list again -- that'll cause list corruption. So, I intentionally put
it here. Once a device is added to the list, it WILL get synced -- so
it's okay to flag it as such here.

For example, after all the consumers of a supplier probe and it's been
added to the sync_list, a new consumer could attach itself to the
supplier and then probe. You don't want that to cause list corruption.
I'll add a comment like:

/* Flag here to avoid trying to add the same device to the sync_list twice */

> > +
> > +       mutex_lock(&sync_lock);
>
> Total nit: I add empty lines around lock/unlock as a rule to make them
> more visible.

Ack

> > +       WARN_ON(!list_empty(&dev->links.defer_sync));
> > +       if (list_empty(&dev->links.defer_sync)) {
>
> Do you really need to duplicate that check?
>
> > +               get_device(dev);
> > +               list_add_tail(&dev->links.defer_sync, &sync_list);
> > +       }
> > +       mutex_unlock(&sync_lock);
> > +}
>
> What about adding
>
> } else {
>         WARN_ON(1);
> }
>
> here instead?

Sounds good.

>
> > +
>
> Kerneldoc?

Looked too obvious of a function and a static one to add a kernel doc
for. I can add it since you seem to want one.

> > +static void device_links_flush_sync_list(void)
> > +{
> > +       struct device *dev, *tmp;
> > +
> > +       mutex_lock(&sync_lock);
> > +
> > +       list_for_each_entry_safe(dev, tmp, &sync_list, links.defer_sync) {
> > +               list_del_init(&dev->links.defer_sync);
> > +               device_lock(dev);
> > +               if (dev->bus->sync_state)
> > +                       dev->bus->sync_state(dev);
> > +               else if (dev->driver && dev->driver->sync_state)
> > +                       dev->driver->sync_state(dev);
> > +               device_unlock(dev);
> > +               put_device(dev);
> > +       }
> > +
> > +       mutex_unlock(&sync_lock);
> >  }
> >
> >  void device_links_supplier_sync_state_pause(void)
> > @@ -738,11 +779,16 @@ void device_links_supplier_sync_state_resume(void)
> >                 goto out;
> >
> >         list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
> > -               __device_links_supplier_sync_state(dev);
> > +               /*
> > +                * Delete from deferred_sync list before queuing it to
> > +                * sync_list because defer_sync is used for both lists.
> > +                */
> >                 list_del_init(&dev->links.defer_sync);
> > +               __device_links_queue_sync_state(dev);
> >         }
> >  out:
> >         device_links_write_unlock();
> > +       device_links_flush_sync_list();
>
> Wouldn't it be better to use a local list in this function instead of
> the global sync_list?

Yeah, not a bad idea. But this is more flexible if we find in the
future that we need to queue to sync list in a function A which is
called by function B with device link write lock held. In that case,
function A will have to do the flushing.

> I guess the idea is that you wouldn't be able to do the flush in
> device_links_driver_bound() below,

Why do you say that? Local list would work in that case too, no?

> but do you really need that flush?

Yeah, device_links_driver_bound() is where I actually found this issue
when trying to implement sync_state() for a downstream driver.

> It looks like this is the only place calling
> __device_links_queue_sync_state() and you do a flush right away after
> the loop, so why is the extra flush in device_links_driver_bound()
> needed?

No, I call it in device_links_driver_bound() too :)

>
> >  }
> >
> >  static int sync_state_resume_initcall(void)
> > @@ -815,12 +861,13 @@ void device_links_driver_bound(struct device *dev)
> >                 if (defer_sync_state_count)
> >                         __device_links_supplier_defer_sync(link->supplier);
> >                 else
> > -                       __device_links_supplier_sync_state(link->supplier);
> > +                       __device_links_queue_sync_state(link->supplier);

See, right here.

> >         }
> >
> >         dev->links.status = DL_DEV_DRIVER_BOUND;
> >
> >         device_links_write_unlock();
> > +       device_links_flush_sync_list();
>
> It looks like devices can be added to sync_list in parallel  with each
> other

Not sure what you mean by "in parallel with each other". But, two
different threads running device_links_supplier_sync_state_resume()
and device_links_driver_bound() could end up updating the sync_list
before either one of them gets to flush it.

> and so is it always OK to always flush all of them after one of
> them has been bound to a driver?

Not sure what you mean by "after one of them has been bound to a
driver". A device won't ever get added to the sync_list unless all
it's consumers have probed. So once it's added to sync_list, it's okay
to flush it any time.

>
> >  }
> >
> >  static void device_link_drop_managed(struct device_link *link)
> > --

So as far as I can tell, the stuff that might need fixing are:
1. The spacing nit.
2. Whether we should move to a local list -- I like to keep it as is
for the flexibility.
3. Add a comment for why I set sync_state = 1 in the queuing function.

I'll skip (2) and send a patch now. And if you want to change (2), I
can update the patch again.

Thanks,
Saravana
