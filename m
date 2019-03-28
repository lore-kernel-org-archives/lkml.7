Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC45C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3036F21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9Oy8jc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfC1GJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:09:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39079 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfC1GJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:09:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so21274677wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 23:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78WLPABl+oTUnutraRtcAgVvxbiucBDKgIRTvdgpocU=;
        b=N9Oy8jc+mM8gSGl38WpeMYg5Th4UF/jY1EpgKwp8o9pC2F9zF7mQclpr3XPNS/HNS/
         0uCRw8FF0GGBtNgjuZDzwG1sgHMup++sKprJFdRxTeAb13NK6F+rUuVULPD9atNV5JVT
         GWHs5GdrN1ji+R3fhDEISRzKfeEB+HCWqaxtc2xIuJBfU8x8uJOefL3NNtzi3h5r66Bj
         XzKsT/vPyda5HSNamyRGdh8lOJ4A0T29whqh0fLKs+B4/Fhh7gEk/yIY4IQf3yVjJE0g
         3Jngi1E/btyHnFekpnljkbWYePuXhvwLX3Q91pFRw7L6C6lwynbyT4z5i8W/D6RI/JfC
         Q30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78WLPABl+oTUnutraRtcAgVvxbiucBDKgIRTvdgpocU=;
        b=FPGSnUp9jma7c1WkqNzRVP1sQxGeCYPbgiY7T+546ylTvLysjxAm3SkRGZHaxxllY5
         WCIsEJQVXRMrufpaUVrdYVDLjiYdCce2S66vP86ynQCnP9z1v+P6ydzpk91fDnWACdv7
         HkJgO0elOlxvcLdopoQWP2IE9iYjeNGY480MLvlyhd0rF7Mi+HW9ajar+oNajFfWd0Bz
         ocLfq4YSM4KKVO10Z08SuZ2pNRsw1IaDWYdTlcUlWaifcNlMk8yie2OjuLWaaYOpHdl8
         JFBHPM6Ch5SWHvtcYKOXbiNEULwFFYkdsUyyVc4cdw8QuIMwCTpRHVRuIM8oxFRXNAox
         Mc+g==
X-Gm-Message-State: APjAAAWfBXDPmJHsDZYjBFA8Ar0t8pWgtHWpRHhEPRPd/hGKZ5OesnJN
        xH+zf7r205AdK/4me6FPTB4lryMHXV8aRRMnh2t9Ug==
X-Google-Smtp-Source: APXvYqy8axzT/mnS2AP8mdvFzkQC9eS4ijEYmxvKLtJq4CwJ5pF6o+L8C5XjBauq3W8hlLTj/Y9TMWaB95KLNYGmp/w=
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr2694295wrm.233.1553753392752;
 Wed, 27 Mar 2019 23:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org> <20190327145354.GA4514@kroah.com>
In-Reply-To: <20190327145354.GA4514@kroah.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 27 Mar 2019 23:09:39 -0700
Message-ID: <CALAqxLWmdJ0KnwEsLjNOwZ0DQ=D0H7Smu7KBBCtF+zwbqY+y5g@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:25 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 05, 2019 at 12:54:29PM -0800, John Stultz wrote:
> > From: "Andrew F. Davis" <afd@ti.com>
> >
> > This framework allows a unified userspace interface for dma-buf
> > exporters, allowing userland to allocate specific types of
> > memory for use in dma-buf sharing.
> >
> > Each heap is given its own device node, which a user can
> > allocate a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
> >
> > This code is an evoluiton of the Android ION implementation,
> > and a big thanks is due to its authors/maintainers over time
> > for their effort:
> >   Rebecca Schultz Zavin, Colin Cross, Benjamin Gaignard,
> >   Laura Abbott, and many other contributors!
>
> Comments just on the user/kernel api and how it interacts with the
> driver model.  Not on the "real" functionality of this code :)

Thanks so much for the feedback! In some cases Andrew and I have
already made the changes you've suggested, and hopefully will have a
new version to share soon.


> > +#define DEVNAME "dma_heap"
> > +
> > +#define NUM_HEAP_MINORS 128
>
> Why a max?

Mostly because other drivers do. I'll see if this can be removed with
the Xarray bits.


> > +static DEFINE_IDR(dma_heap_idr);
> > +static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
>
> Move to use xarray now so that Matthew doesn't have to send patches
> converting this code later :)
>
> It also allows you to drop the mutex.

Yep. Already converted to Xarray, it is nicer!


> > +dev_t dma_heap_devt;
> > +struct class *dma_heap_class;
> > +struct list_head dma_heap_list;
> > +struct dentry *dma_heap_debug_root;
>
> Global variables?

Oops. Will make those static. Thanks!

> > +
> > +static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> > +                              unsigned int flags)
> > +{
> > +     len = PAGE_ALIGN(len);
> > +     if (!len)
> > +             return -EINVAL;
> > +
> > +     return heap->ops->allocate(heap, len, flags);
> > +}
> > +
> > +static int dma_heap_open(struct inode *inode, struct file *filp)
> > +{
> > +     struct dma_heap *heap;
> > +
> > +     mutex_lock(&minor_lock);
> > +     heap = idr_find(&dma_heap_idr, iminor(inode));
> > +     mutex_unlock(&minor_lock);
> > +     if (!heap) {
> > +             pr_err("dma_heap: minor %d unknown.\n", iminor(inode));
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* instance data as context */
> > +     filp->private_data = heap;
> > +     nonseekable_open(inode, filp);
> > +
> > +     return 0;
> > +}
> > +
> > +static int dma_heap_release(struct inode *inode, struct file *filp)
> > +{
> > +     filp->private_data = NULL;
>
> Why does this matter?  release should only be called on the way out of
> here, no need to do anything as nothing else can be called, right?
>
> release shouldn't be needed from what I can tell.

Yep. Christoph suggested the same and its been removed already.


> > +             if (heap_allocation.flags & ~DMA_HEAP_VALID_FLAGS) {
> > +                     pr_warn_once("dma_heap: flags has invalid or unsupported flags set\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             fd = dma_heap_buffer_alloc(heap, heap_allocation.len,
> > +                                        heap_allocation.flags);
>
> No max value checking for .len?  Can you really ask for anything?

So I think any length caps would be heap specific, so we want to pass
them on here.

> > +static const struct file_operations dma_heap_fops = {
> > +     .owner          = THIS_MODULE,
> > +     .open           = dma_heap_open,
> > +     .release        = dma_heap_release,
> > +     .unlocked_ioctl = dma_heap_ioctl,
> > +#ifdef CONFIG_COMPAT
> > +     .compat_ioctl   = dma_heap_ioctl,
> > +#endif
>
> Why is compat_ioctl even needed?

Probably my mistake. I didn't realize if we're running 32bit on 64bit
and there's no compat, the unlocked_ioctl gets called.


> > +     /* Find unused minor number */
> > +     mutex_lock(&minor_lock);
> > +     ret = idr_alloc(&dma_heap_idr, heap, 0, NUM_HEAP_MINORS, GFP_KERNEL);
> > +     mutex_unlock(&minor_lock);
>
> Again, xarray.

Ack.

> But I will ask you to back up, why need a major number at all?  Why not
> just use the misc subsystem?  How many of these are you going to have
> over time in a "normal" system?  How about a "abnormal system"?

So early implementations did use misc, but in order to get the
/dev/heap/cma_heap style directories, in both Android and classic udev
linux systems I had to create a class.

This v2 patch didn't get it quite right (got it working properly in
android but not on classic systems), but the next version does get the
subdir created properly (similar to how the input layer does it).

As for number of heaps, I wouldn't expect there to be a ton on any
given system. Most likely less then 16, but possibly up to 32. 128
seemed like a safe "crazy out there" cap. But perspectives on crazy
shift over time :)

> We have seen people running Android in "containers" such that they
> needed binderfs to handle huge numbers of individual android systems
> running at the same time.  Will this api break those systems if you have
> a tiny maximum number you an allocate?

I'd have to think some more on this. Right now I'd expect that you'd
not be trying to virtualize the heaps in a container so you'd not have
m heaps * n containers on the system. Instead the containers would
mount/link in the devnode (I'm a bit fuzzy on how containers handle
devnode creation/restrictions) as appropriate (the nice part with this
over ION is we have per heap dev nodes, so the set shared can be
limited).  But I'd have to think more about the risks of how multiple
containers might share things like cma heaps.


> > +     if (ret < 0) {
> > +             pr_err("dma_heap: Unable to get minor number for heap\n");
> > +             return ret;
> > +     }
> > +     heap->minor = ret;
> > +
> > +     /* Create device */
> > +     heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), heap->minor);
> > +     dev_ret = device_create(dma_heap_class,
> > +                             NULL,
> > +                             heap->heap_devt,
> > +                             NULL,
> > +                             heap->name);
>
> No parent?  Can't hang this off of anything?  Ok, having it show up in
> /sys/devices/virtual/ is probably good enough.
>
> > +     if (IS_ERR(dev_ret)) {
> > +             pr_err("dma_heap: Unable to create char device\n");
> > +             return PTR_ERR(dev_ret);
> > +     }
> > +
> > +     /* Add device */
> > +     cdev_init(&heap->heap_cdev, &dma_heap_fops);
> > +     ret = cdev_add(&heap->heap_cdev, dma_heap_devt, NUM_HEAP_MINORS);
> > +     if (ret < 0) {
> > +             device_destroy(dma_heap_class, heap->heap_devt);
> > +             pr_err("dma_heap: Unable to add char device\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(dma_heap_add);
>
> EXPORT_SYMBOL_GPL() please?  For core stuff like this it's good.

Actually, removed the export completely for now since its probably not
ready for modules yet. But will be sure to tag it GPL when we do
re-add it.


> > +
> > +static int dma_heap_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret = alloc_chrdev_region(&dma_heap_devt, 0, NUM_HEAP_MINORS, DEVNAME);
> > +     if (ret)
> > +             return ret;
> > +
> > +     dma_heap_class = class_create(THIS_MODULE, DEVNAME);
> > +     if (IS_ERR(dma_heap_class)) {
> > +             unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
> > +             return PTR_ERR(dma_heap_class);
> > +     }
> > +
> > +     return 0;
> > +}
> > +subsys_initcall(dma_heap_init);
>
> Overall, looks sane, the comments above are all really minor.

Very much appreciate the review!


>
> > --- /dev/null
> > +++ b/include/uapi/linux/dma-heap.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>
> Wrong license for a uapi .h file :(

Ack. Fixed.

Thanks so much again!
-john
