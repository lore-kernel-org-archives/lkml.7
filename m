Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7D7C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD52620856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ea9V0F0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGYTCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:02:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55504 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYTCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:02:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so45912223wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3AsLQhnTHv4m5xXViWHAbzsivrqwa3myoFef6PvdXM=;
        b=ea9V0F0OEhqUArIBeWLCnvfcrUIQC370T7JFfVzHiH7WaDR72Pc79vJ3YAHgMdAdeM
         LnqlyM/gWSnYRnHArIBN7L/XLdoUxcI0DyW6F2VGzFBc2PwdL4KtMLbbkBrTi8ieSNmd
         PVzdVtd97Rvn2O1JXKF4Vm+igS8L3HuOZ1Zw5hBdGYB8Xj9gVppLO9QWHKWNyXfGRuFn
         2ZQAPUEtagigSOFpgVesdN7ii7hUjf0cz0F+u9AyOEjM9okSTRpnjg8+atvNFUi2iiOV
         Bn0etSCenMtCUQejzDNdqD0IC7qX0U8zz/eoqTM8YmZxXW0+AI3qXLtHXiLDAJ4fj6ZZ
         Pn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3AsLQhnTHv4m5xXViWHAbzsivrqwa3myoFef6PvdXM=;
        b=WwqysVrFtm175JbmuzwA3ZF1Y0KaVYyetKAE3OBxKn1yEI1JLUeF3O6fqN6qH/2F4w
         rrzdPw+HqvKOsoZS5693/2ZhhkAUoHGNrS2VpXTGWNdw1PJofPnY9ZNb4Jc4qpCltEBL
         wCcrkuKbClEEduyl5/WqgEe5a6Tjx2eLlLhAMUvQFyH0WT4fhqtyBOMD9jcy9vL6DQz6
         V7Y+9E3v+tJ4B7lLEDnW+poNbyM8Qe1w4sqLS9LFWM/2MoZ1ljO3R6p6x8NuWMGUquNa
         C4BZf3T24qGfot3IJeoXE+O5OgR3MaXyPKWILUhy5zEMnigVAwoEiEgBoS2o3EP/L1Vz
         V71g==
X-Gm-Message-State: APjAAAXRQEcWWy2JedwKuphfZfeeJXkCs9j1SswkocZ2qgZwaJcWoN8i
        3xD2AQ+thaZaIAv9KLr5HanuUfuK7cbIELqzE0Zd5w==
X-Google-Smtp-Source: APXvYqxBn/gbH+PT6SDkNaOjbZZU5/bxVkSeXpu2kzM/b7ovVktC8AkRNNHB0Ifr7dWGjGxOqTYxwRvs3k38c5DiRG8=
X-Received: by 2002:a05:600c:c6:: with SMTP id u6mr83259750wmm.153.1564081342013;
 Thu, 25 Jul 2019 12:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190724003656.59780-1-john.stultz@linaro.org>
 <20190724003656.59780-4-john.stultz@linaro.org> <20190725130204.GG20286@infradead.org>
In-Reply-To: <20190725130204.GG20286@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 25 Jul 2019 12:02:10 -0700
Message-ID: <CALAqxLW3AFRVgrZwpuBTm8g7R5WmRDVsmmKEH+d7-aaNZGeuCw@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
To:     Christoph Hellwig <hch@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 6:02 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +struct system_heap {
> > +     struct dma_heap *heap;
> > +} sys_heap;
>
> It seems like this structure could be removed and if would improve
> the code flow.

Good point. We actually keep a few things in the cma version of this,
and I think I copied that over when I started here, but never cleaned
it up.

> > +static struct dma_heap_ops system_heap_ops = {
> > +     .allocate = system_heap_allocate,
> > +};
> > +
> > +static int system_heap_create(void)
> > +{
> > +     struct dma_heap_export_info exp_info;
> > +     int ret = 0;
> > +
> > +     exp_info.name = "system_heap";
> > +     exp_info.ops = &system_heap_ops;
> > +     exp_info.priv = &sys_heap;
> > +
> > +     sys_heap.heap = dma_heap_add(&exp_info);
> > +     if (IS_ERR(sys_heap.heap))
> > +             ret = PTR_ERR(sys_heap.heap);
> > +
> > +     return ret;
>
> The data structures here seem a little odd.  I think you want to:

Yea. There is some awkwardness, and some is due to using the helper
infrastructure, but some is just clutter and I'll revise that.

>  - mark all dma_heap_ops instanes consts, as we generally do that for
>    all structures containing function pointers

Done.

>  - move the name into dma_heap_ops.

I'm not sure this is useful, as there are cases where there are
multiple heaps that use the same ops. Specifically the multiple CMA
heaps.

>  - remove the dma_heap_export_info structure, which is a bit pointless

Andrew and I went back and forth on this a bit. It looks like he just
responded so I'll defer to his answer.

>  - don't bother setting a private data, as you don't need it.
>    If other heaps need private data I'd suggest to switch to embedding
>    the dma_heap structure into containing structure insted so that you
>    can use container_of to get at it.

Fair. There is some cases where we use the priv data, but I'll try to
see if I can minimize it.  And again, I think having the dma_heap
structure be internal/private to the heap implementations made it
difficult to be a contained structure. So it goes back to the
export_info structure point above.

>  - also why is the free callback passed as a callback rather than
>    kept in dma_heap_ops, next to the paired alloc one?

This one is due to the optional heap helpers infrastructure. If a heap
implements its own dma_buf_ops, it can have release directly call the
buffer free function. However, since we tried to minimize the code we
have the heap helpers infrastructure which implements a shared
dma_buf_op, we need some way for the helper release function to call
back to the heap specific free.  We could put it in the dma_heaps_ops
like you suggest, but that brings some confusion as well, as nothing
in the dma-heaps core would call it, it would only be a tool for the
helper infrastructure to trace back to the heap specific free call.
This is why its passed to the heap_helper initializer.  I agree it
feels a little odd, so I'd welcome alternate approaches.

Very much appreciate the review and feedback!  I'll try to address as
much of this as I can in the next revision.

thanks
-john
