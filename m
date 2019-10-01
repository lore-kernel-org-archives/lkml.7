Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0905DECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F27215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCza1vos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfJAUvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 16:51:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42113 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfJAUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 16:51:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so17095597wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRJlSTe3enCBLAxogNySsJ9S73/uDChBELwRwUUTh7g=;
        b=iCza1vos46GxgzD39SFzwhy6cJ8W/5jzGl1xR5WccqvYz/DGYXMwcUUnjp+GqS+hfO
         qbOW/2DkVIQc/VFZsyZ3VwoEIMLApe67hXyTfOfZOQJDOG/PKPlAeJ/MAAfBZj8cJ/2t
         KBQICOrReINcXTyUV03nMA1WCgHSX3jyz6ulvGo/XF9PLKHVj7KeLuVUKgznL9qrnDAA
         u4Na5JSkQQa1p8JvA5nRG6Egf+k+iYsMDl4ky5ZnBcvrxv8M1VV2nFYD33MZsPVm1/Uv
         1BySCXIX9wPohS/0j9xV4aOeWklskzDRAuP1h5uXc4VsHrOR3i1T9HL6BuzNRZzt0Uhj
         t+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRJlSTe3enCBLAxogNySsJ9S73/uDChBELwRwUUTh7g=;
        b=ifRgfjoW1WxyD/p4FFXY/A68GTLNLEtve/Ks5ChZ5HjPahFoVX7MD75Tx6kfQrdv4D
         5Oz7Yor15xNe0Xd8vFbCwrGWuDFGVZF9ekuty9VrnWBe57FfF/K0PPtVowdRRa+sxUwy
         Ir1jAipkmkGwHEGFXczuhU6wtI3WzLHGlMKOOt6BPAdN4ohuTg9b+3Uut4GZdNa8VnWi
         yT0ZWfWmCp/TleE4Hyyu9+Rsd9cz79l5naNB2KIUcLkl7wGMLp+mp75oYy6vWeKPbojP
         KD61Amr61JMIdN0LasEE16mroTWf3znY0V5LHVOtkiWXJ5RHML6mxpWjgDVw62wFEjZr
         UY8w==
X-Gm-Message-State: APjAAAUJWPrJD3jGhDOzg5UIC+7RXcur8pxY3MRfyXOMepHfhRMDvqIl
        YdxJ5B2186wLjiPiTzEgJ4hr/hzm0aDOjcXuvvrTQA==
X-Google-Smtp-Source: APXvYqzx/FZOWaZvriNbKTbyJs7xkM7pO4zOq51rphBY411oSkn14f7uOL3ewgVeUHjtAn7k84AjghvlBQ0Q9RiwrbE=
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr20881280wrq.141.1569963060455;
 Tue, 01 Oct 2019 13:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org> <20190930074335.6636-1-hdanton@sina.com>
In-Reply-To: <20190930074335.6636-1-hdanton@sina.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 1 Oct 2019 13:50:45 -0700
Message-ID: <CALAqxLWKGEhzqXir8KoeS5EBcbokAY5+=mHrqy0-G9aGraqXXA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
To:     Hillf Danton <hdanton@sina.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 12:43 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Fri,  6 Sep 2019 18:47:09 +0000 John Stultz wrote:
> >
> > +static int system_heap_allocate(struct dma_heap *heap,
> > +                             unsigned long len,
> > +                             unsigned long fd_flags,
> > +                             unsigned long heap_flags)
> > +{
> > +     struct heap_helper_buffer *helper_buffer;
> > +     struct dma_buf *dmabuf;
> > +     int ret = -ENOMEM;
> > +     pgoff_t pg;
> > +
> > +     helper_buffer = kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
> > +     if (!helper_buffer)
> > +             return -ENOMEM;
> > +
> > +     init_heap_helper_buffer(helper_buffer, system_heap_free);
> > +     helper_buffer->flags = heap_flags;
> > +     helper_buffer->heap = heap;
> > +     helper_buffer->size = len;
> > +
> A couple of lines looks needed to handle len if it is not
> PAGE_SIZE aligned.

Hey! Thanks so much for the review!

dma_heap_buffer_alloc() sets "len = PAGE_ALIGN(len);" before calling
into the heap allocation hook.
So hopefully this isn't a concern, or am I missing something?

thanks
-john
