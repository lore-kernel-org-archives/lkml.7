Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6402CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA63B2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQwKNKSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfKDTed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:34:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35360 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbfKDTed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:34:33 -0500
Received: by mail-ot1-f66.google.com with SMTP id z6so15475330otb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJyiWygwO7PaAAF+lCbsOZbNEjf6c5RFpg3e51aDY1s=;
        b=UQwKNKSETHUfngej3ca5qu8vH/tpViAxu1vSuRQ4v7yKRXVLeRKNmUp6a40oLzMEDJ
         QwOF4aDftrFrZok2yMaCbey3j8gBRBNqhwmK0HpI0nf359KY672zbyQoIaEq6RH71WbF
         4j+wHs2mBB5TibJ8MMPiP1UB4x9Wwfh3W73sqxRH9RdSMe47rTW4AHLdXoptHFqGeM9+
         0dK9PrEw+RB0oCgrfZ6QXlZCF70J+UFWAxUXOg7qVO6OjL5Wkc52P4HWHLBPoWOIV+yf
         V46+kY6zDBZ3+iYGHS+/t1Fo5JQDCbBUh5LHuaNchwWvIJQwkFcD9mRIn97og8H1Qqzc
         0Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJyiWygwO7PaAAF+lCbsOZbNEjf6c5RFpg3e51aDY1s=;
        b=la7I8U4FNfUVZq0EFY7xAUdjJ0QM7EOJWbH6kk3IqdNhNHACAA3L11Lo42hbNgMnkn
         5OFUgMDrBW7Xr5APdu/nxhBlBucaJZfdZygIftGe9uM8XNfGMvtKmpX1GpZ9iT7JR4uD
         U6DpuxX7/NP1VIykVd7ZN8E1yxfXQSwvfBF1sbfTLWtJ/XMJpO2Xy2D5cfxU7P+sTGzj
         1EHgJtn5WOgqRzBVokY5JL6f8dhIOj53iVHqJrLr/B5DUUPBwjG0tYUGgmTpmZxbDBxo
         +rQvYHhviSFaZ0ff8MbfoYLlcs0e5QYOH7mh8OdmCb+/pQsXcqqF83DFz7cOrib1ZmRd
         Eb/w==
X-Gm-Message-State: APjAAAWU6Z2t8iPaAMf00hvf0c7jAY9BAD2XzRYR7TeTjdJugk47/bed
        3hw2KLyvGUEfwCVuaKbZoNUS2cSus9KNNvYiXWLyDA==
X-Google-Smtp-Source: APXvYqzfnECunuKfDdkHs+0QNkb1qYFbp5i53fy0YUvT+zOgW8n8eC1JtM8AMZPH6xlICGllfqpfi/D1V5dznq0tzEk=
X-Received: by 2002:a05:6830:ca:: with SMTP id x10mr18721750oto.221.1572896071138;
 Mon, 04 Nov 2019 11:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-3-john.stultz@linaro.org> <20191103161348.GB13344@google.com>
In-Reply-To: <20191103161348.GB13344@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Nov 2019 11:34:19 -0800
Message-ID: <CALAqxLUhot_nceaw5zpJ7QXcsfHNL8bOV-3MOeKu9c76Tfzx=g@mail.gmail.com>
Subject: Re: [PATCH v14 2/5] dma-buf: heaps: Add heap helpers
To:     Sandeep Patil <sspatil@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        sspatil+mutt@google.com, "Andrew F . Davis" <afd@ti.com>,
        Alistair Strachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 3, 2019 at 8:13 AM <sspatil@google.com> wrote:
> On Fri, Nov 01, 2019 at 09:42:35PM +0000, John Stultz wrote:
> > Add generic helper dmabuf ops for dma heaps, so we can reduce
> > the amount of duplicative code for the exported dmabufs.
> >
> > This code is an evolution of the Android ION implementation, so
> > thanks to its original authors and maintainters:
> >   Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!
> >
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Liam Mark <lmark@codeaurora.org>
> > Cc: Pratik Patel <pratikp@codeaurora.org>
> > Cc: Brian Starkey <Brian.Starkey@arm.com>
> > Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> > Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> > Cc: Andrew F. Davis <afd@ti.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Chenbo Feng <fengc@google.com>
> > Cc: Alistair Strachan <astrachan@google.com>
> > Cc: Hridya Valsaraju <hridya@google.com>
> > Cc: Sandeep Patil <sspatil@google.com>
> > Cc: Hillf Danton <hdanton@sina.com>
> > Cc: Dave Airlie <airlied@gmail.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> > Acked-by: Laura Abbott <labbott@redhat.com>
> > Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
>
> I have one question and a naming suggestin below (sorry).
>
> Acked-by: Sandeep Patil <sspatil@android.com>

> > +
> > +static void dma_heap_buffer_vmap_put(struct heap_helper_buffer *buffer)
> > +{
> > +     if (!--buffer->vmap_cnt) {
>
> nit: just checking here cause I don't know the order in which vmap_get() and
> vmap_put() is expected to be called from dmabuf, the manual refcounting
> based map/unmap is ok?
>
> I know ion had this for a while and it worked fine over the years, but I
> don't know if anybody saw any issues with it.
> > +             vunmap(buffer->vaddr);
> > +             buffer->vaddr = NULL;
> > +     }
> > +}
> > +




> > +#ifndef _HEAP_HELPERS_H
> > +#define _HEAP_HELPERS_H
> > +
> > +#include <linux/dma-heap.h>
> > +#include <linux/list.h>
> > +
> > +/**
> > + * struct heap_helper_buffer - helper buffer metadata
> > + * @heap:            back pointer to the heap the buffer came from
> > + * @dmabuf:          backing dma-buf for this buffer
> > + * @size:            size of the buffer
> > + * @flags:           buffer specific flags
> nit: Are thee dmabuf flags, or dmabuf_heap specific / allocation related flags?

Good point. They were going to be for the generic flags but as there's
no supported flags yet, there's no reason to track that in the helper
code.

I'll drop it

> > + * @priv_virt                pointer to heap specific private value
> nit: text looks misaligned (or is it my editor?)

Looks ok to me in vim.


> > + * @lock             mutext to protect the data in this structure
> > + * @vmap_cnt         count of vmap references on the buffer
> > + * @vaddr            vmap'ed virtual address
> > + * @pagecount                number of pages in the buffer
> > + * @pages            list of page pointers
> > + * @attachments              list of device attachments
> ditto
> > + *
> > + * @free             heap callback to free the buffer
> > + */
> > +struct heap_helper_buffer {
> /bikeshed/
> s/heap_helper_buffer/dma_heap_buffer ?
>
> The "heap helper buffer" doesn't really convey what it is.

So its the helper structure that is used with all the helper
functions. Since other dmabuf heaps don't have to use the helper
infrastructure, they wouldn't need this structure, so I don't want to
name it too generically to confuse folks.

thanks
-john
