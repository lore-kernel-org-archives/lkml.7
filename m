Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC92221917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTM/kKts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfCUVQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:16:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42102 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfCUVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:16:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so115272wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDjNNvEtNwoG96Uw3Yu3Mr9+yxvOsy2qoYHck7Zu0eI=;
        b=mTM/kKtsOhWzNDM0d2pk/dYeT7AUZaJ5b5rh1jFxr9feBxhGSd/RQJ4ixG7sTCq0eP
         NtQFWKb2njQFMhT1NOWqsWH2mvkyE9lbbOtMEjrJT6CXToDZ+faXUiYgLGo0e+RNl6Kf
         gY7k09OJJT8T1vAOGTr0lNvsfPdEklaByMzkhVcVQUYZJNH7KSbZV3CE83zPniiVjiOR
         4Qo/B1swoAGh2o/+D846msio4F4GmX9k0m3Nmkj8+dJ5ynSOKmj8l+4VpPayeVagCbEq
         /kQ4f0HRqQN0drUNwJV6GMvsSwpFklvxTJcNH3ZnrbXQy6itTVd4njQ+qMVJOqJYEEgt
         Y3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDjNNvEtNwoG96Uw3Yu3Mr9+yxvOsy2qoYHck7Zu0eI=;
        b=Wpf0UVxo/+LLwheKiRQWUkux1kA3R52bU4aWCm+tad79wxK2ojHmAJmk2aSdsAZFvj
         uLYQOnXd4JTFWg2oh1nf8ZL2XaAt8AjMqZGKVhs9CZgiEoB0ze8EEonQ0zlFxdGAgBgK
         hmWldMMpDGJedjO36/kTmTVZFW4UMyQFwZdylW9UGzw1tPxEDxi8ybA6Zd447iacSRMH
         9Q/3Vlo7zP8aR0AmVnAAom4H7/wuJ444NpxaRkKFfm2zR032+3AER9RebkR6t2gR2ZtC
         vgFbrXdSbUp7TfbaWljFCYzCVvon8Y/vffUd2MIIIWWpTSQDch2hi+ArkZPVpKNo2eW0
         COdw==
X-Gm-Message-State: APjAAAWQf1+Ojey6u/D2MvjaXb6OYmQ9k1IVugGK8m3IwgErDpdfy0qc
        KzKHv1Ojpm6LZCcj7/lFzsvyVFA6BQH0USM97b+ThA==
X-Google-Smtp-Source: APXvYqxLRbyn9hUEw3Z1yR9YUUmbfSO4LniUucITkc86bV57YZfxXSXyDG8wmZRL6wjczznPA2HrV+2H3qqVsiWe1iU=
X-Received: by 2002:a5d:6682:: with SMTP id l2mr3835835wru.33.1553203005841;
 Thu, 21 Mar 2019 14:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org> <20190319120825.3mvdxp5saluboy7o@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190319120825.3mvdxp5saluboy7o@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 21 Mar 2019 14:16:34 -0700
Message-ID: <CALAqxLUoXF-M1bGtDPLPg5qJ++e9gpjpnXrJ1_vHg1uLhWQDmA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 5:08 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
>
> Hi John,
>
> On Tue, Mar 05, 2019 at 12:54:29PM -0800, John Stultz wrote:
> > From: "Andrew F. Davis" <afd@ti.com>
>
> [snip]
>
> > +
> > +#define NUM_HEAP_MINORS 128
> > +static DEFINE_IDR(dma_heap_idr);
> > +static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
>
> I saw that Matthew Wilcox is trying to nuke idr:
> https://patchwork.freedesktop.org/series/57073/
>
> Perhaps a different data structure could be considered? (I don't have
> an informed opinion on which).

Thanks for pointing this out! I've just switched to using the Xarray
implementation in my tree.

> > +static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> > +                              unsigned int flags)
> > +{
> > +     len = PAGE_ALIGN(len);
> > +     if (!len)
> > +             return -EINVAL;
>
> I think aligning len to pages only makes sense if heaps are going to
> allocate aligned to pages too. Perhaps that's an implicit assumption?
> If so, lets document it.

I've added a comment as such (or do you have more thoughts on where it
should be documented?), and for consistency removed the PAGE_ALIGN
usage in the heap allocator hooks.

> Why not let the heaps take care of aligning len however they want
> though?

As Andrew already said, It seems page granularity would have to be the
finest allocation granularity for dmabufs.  If heaps want to implement
their own larger granularity alignment, I don't see any reason they
would be limited there.

And for me, its mostly because I stubbed my toe implementing the heap
code w/ the first patch that didn't have the page alignment in the
generic code. :)

> > +     /* Create device */
> > +     heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), heap->minor);
> > +     dev_ret = device_create(dma_heap_class,
> > +                             NULL,
> > +                             heap->heap_devt,
> > +                             NULL,
> > +                             heap->name);
> > +     if (IS_ERR(dev_ret)) {
> > +             pr_err("dma_heap: Unable to create char device\n");
> > +             return PTR_ERR(dev_ret);
> > +     }
> > +
> > +     /* Add device */
> > +     cdev_init(&heap->heap_cdev, &dma_heap_fops);
> > +     ret = cdev_add(&heap->heap_cdev, dma_heap_devt, NUM_HEAP_MINORS);
>
> Shouldn't this be s/dma_heap_devt/heap->heap_devt/ and a count of 1?
>
> Also would it be better to have cdev_add/device_create the other way
> around? First create the char device, then once it's all set up
> register it with sysfs.

Thanks for catching that! Much appreciated! Reworked as suggested.

Though I realized last week I have not figured out a consistent way to
have the heaps show up in /dev/dma_heaps/<device> on both Android and
classic Linux environments.  I need to go stare at the /dev/input/
setup code some more.

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
> Until we've figured out how modules are going to work, I still think
> it would be a good idea to not export this.

Done!

thanks
-john
