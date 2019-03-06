Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE46F20645
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKwsL5HN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfCFTDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:03:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33636 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfCFTDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:03:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so14655451wrw.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 11:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Neppaa8RdSqht8UnmU1WA+2pKzzdo2Ze2M49fJVuFqk=;
        b=CKwsL5HNTI4ZDBtRxedSPbYsaWgWSxA2wBKgvKt59/9jpYW40RFrP0s7bzjFHVBCKG
         HFaKBtSaCnmjWmg75tMhOlSEQu29gp5MFpFsc5Em2JfLv/opkpFkt0F85Z9qm/fC+wZK
         +iuHHVVEZgzHzu0ExHqMXqw+ORzTKOfKVbjH5Rya2eitnN1zbr3w+gR0VxzNdJ97OKdI
         mSqyPri83QuUBVTM/W8+DT+tJN0jpEYn6ZLqKb74iolpX3nyY8IlgTd6rajZBvf+zDuc
         UkaHBEYn+SST5ynDzcKXoCVwE4psiv9GZwljfgmoT0vIPjL7xFUcmiLupxR2JDC3jnmb
         hQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Neppaa8RdSqht8UnmU1WA+2pKzzdo2Ze2M49fJVuFqk=;
        b=hlKDKI82sXulKSmQfzN/eB2Et+SMsnXGVUcvlJyDZT2t37IzyoiZyIlfgtLcYEfaU4
         v0K0wvlAvdMOJwYT/eB5wXUWAoHr1R3tV6BvTeHEi4x2sssV40gVCQ5qnfVD93RizFUA
         +l3bFk2w6xA8paysTUSfl+gA6KcaN321k49gxCbXWtwLdvrtQr2xt4AMcoxwHexV+RDz
         GFwbNkpu4m5x/gRO7u8qozQNc+ystVuQ1HUExdHVdfzjOsxSRax0MO3D1UCegxRSQxjZ
         sskNR6rIO9Z4yZgP/LnWXgq4OBa7jpoc4WkSG/9XZUj6B6PYXfVtTG2dpGtePFJPKCiq
         kDLg==
X-Gm-Message-State: APjAAAUpYUic2PK6SpXh9Ni9MMpv51/VDiPyhkZDs7oTO6zMzvhJiQvc
        qJF9qpMvly7ZJER+9y5CQuow5SmYxEwhQw1EV+JUXg==
X-Google-Smtp-Source: APXvYqwoc9YzLdO+Wsx1UunUmMqeboKF6kbuqTB4YWnJ2ONYlnob2BRo6mTRmqqKyTReFFtfHdM8k54D4abdv83+Dy4=
X-Received: by 2002:a5d:6703:: with SMTP id o3mr3960828wru.75.1551899010374;
 Wed, 06 Mar 2019 11:03:30 -0800 (PST)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org> <a4fd1783-c0d8-8ed5-5cd0-522b0789998c@ti.com>
In-Reply-To: <a4fd1783-c0d8-8ed5-5cd0-522b0789998c@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 6 Mar 2019 11:03:19 -0800
Message-ID: <CALAqxLVh9zU-96ZpOVFztS=WtpMWPEOqAo=zj+fhVVK78W50BQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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

On Wed, Mar 6, 2019 at 10:18 AM Andrew F. Davis <afd@ti.com> wrote:
>
> On 3/5/19 2:54 PM, John Stultz wrote:
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
> >
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Liam Mark <lmark@codeaurora.org>
> > Cc: Brian Starkey <Brian.Starkey@arm.com>
> > Cc: Andrew F. Davis <afd@ti.com>
> > Cc: Chenbo Feng <fengc@google.com>
> > Cc: Alistair Strachan <astrachan@google.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Andrew F. Davis <afd@ti.com>
> > [jstultz: reworded commit message, and lots of cleanups]
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2:
> > * Folded down fixes I had previously shared in implementing
> >   heaps
> > * Make flags a u64 (Suggested by Laura)
> > * Add PAGE_ALIGN() fix to the core alloc funciton
> > * IOCTL fixups suggested by Brian
> > * Added fixes suggested by Benjamin
> > * Removed core stats mgmt, as that should be implemented by
> >   per-heap code
> > * Changed alloc to return a dma-buf fd, rather then a buffer
> >   (as it simplifies error handling)
> > ---
> >  MAINTAINERS                   |  16 ++++
> >  drivers/dma-buf/Kconfig       |   8 ++
> >  drivers/dma-buf/Makefile      |   1 +
> >  drivers/dma-buf/dma-heap.c    | 191 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-heap.h      |  65 ++++++++++++++
> >  include/uapi/linux/dma-heap.h |  52 ++++++++++++
> >  6 files changed, 333 insertions(+)
> >  create mode 100644 drivers/dma-buf/dma-heap.c
> >  create mode 100644 include/linux/dma-heap.h
> >  create mode 100644 include/uapi/linux/dma-heap.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ac2e518..a661e19 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4621,6 +4621,22 @@ F:     include/linux/*fence.h
> >  F:   Documentation/driver-api/dma-buf.rst
> >  T:   git git://anongit.freedesktop.org/drm/drm-misc
> >
> > +DMA-BUF HEAPS FRAMEWORK
> > +M:   Laura Abbott <labbott@redhat.com>
> > +R:   Liam Mark <lmark@codeaurora.org>
> > +R:   Brian Starkey <Brian.Starkey@arm.com>
> > +R:   "Andrew F. Davis" <afd@ti.com>
>
> Quotes not needed in maintainers file.

Whatever you say, "Andrew F. Davis", or whomever you really are! ;)


> > +
> > +             if (heap_allocation.fd ||
> > +                 heap_allocation.reserved0 ||
> > +                 heap_allocation.reserved1 ||
> > +                 heap_allocation.reserved2) {
>
> Seems too many reserved, I can understand one, but if we ever needed all
> of these we would be better off just adding another alloc ioctl.

Well, we have to have one u32 for padding. And I figured if we needed
anything more then a u32, then we're in for 2 more.

And I think the potential of the alignment and heap-private flags, I
worry we might want to  have something, but I guess we could just add
a new ioctl and keep the support for the old one if folks prefer.

> > +int dma_heap_add(struct dma_heap *heap)
> > +{
> > +     struct device *dev_ret;
> > +     int ret;
> > +
> > +     if (!heap->name || !strcmp(heap->name, "")) {
> > +             pr_err("dma_heap: Cannot add heap without a name\n");
>
> As these names end up as the dev name in the file system we may want to
> check for invalid names, there is probably a helper for that somewhere.

Hrm. I'll have to look.

> > +struct dma_heap {
> > +     const char *name;
> > +     struct dma_heap_ops *ops;
> > +     unsigned int minor;
> > +     dev_t heap_devt;
> > +     struct cdev heap_cdev;
> > +};
>
> Still not sure about this, all of the members in this struct are
> strictly internally used by the framework. The users of this framework
> should not have access to them and only need to deal with an opaque
> pointer for tracking themselves (can store it in a private struct of
> their own then container_of to get back out their struct).
>
> Anyway, not a big deal, and if it really bugs me enough I can always go
> fix it later, it's all kernel internal so not a blocker here. :)

I guess I'd just move the include/linux/dma-heap.h to
drivers/dma-buf/heaps/ and keep it localized there.
But whichever. Feel free to also send a patch and I can fold it down.

thanks
-john
