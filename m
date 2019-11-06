Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310A8C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0564E2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fg82y5+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfKFRDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:03:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45129 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732411AbfKFRDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:03:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id r24so5150410otk.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13XiEQK8Wfi1t0rOXtClrpgGr0M1MsxM4DjcUQln3M4=;
        b=Fg82y5+/m4XYC7+TXTEObVZp0oO/gdUR8ls6Gztw9ARyKO/M421qhy1RRD2jEGLEUw
         VKgI0VbcQ/Ao4avg6W+OSkcj5EtmXbztGbk75Dij721u4or6l8vc09DGum7kiIiKOfpC
         UAQxiKf8lrx49pgXN7OlNB4Bnew3F4rvfOvjOzLetyXYj4ZmBnVREiBqnbD+cid5C8TO
         1LvJzNXsM9/e2Ugvl4kkhlrp47+KgX1opNdqHpBu77Q9tnYbq443XxLelWgsTiNb+4dx
         vJVtmPmBBFVJJzKQO7Nq9OUTswoiu0YrIVYj1iivcboY6E5qag9Z+ZlyqEsUg9db/vpt
         4UWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13XiEQK8Wfi1t0rOXtClrpgGr0M1MsxM4DjcUQln3M4=;
        b=Du2J2ak9p97+IhFod/xV1w6ronyIPNthUoMn8fWqxuGl67+Wml099Zyl8+MrTw68vM
         MmpB4kR9wzys1nBsljfxJc17EQF7o/Iep/3IeTt/wicWSn5C+y7Xas3nhmlKK1K0Va4/
         4QE8tDBOYPUcLtfjv7ZT2Dm/S0TIUK/iP3JcPQIv4iiId5IH2hVUeX6nqtDH2pavI8NQ
         r4BRSrpG1RbVK3JrhoDEn39267Gt7n8Z8InmwZCUXlDhmHVxhhADk0n/CjnPHONmEeRx
         ck4EWYNZd/IUqloLSAfkh9KQLH8jLKuu/jPkyTXTaGZb7i2GFMM8Adonge0vIRg13n3e
         hp3g==
X-Gm-Message-State: APjAAAW8ZUXVg/2aPx2kSwJ2sFt6LYXPeqIIvjOgkBo7nrYH+3im+Kw9
        C5+AAcG/CnkToBdxL+ohoQrM/OxvlqYcerdsDy/guQ==
X-Google-Smtp-Source: APXvYqxA21M83YXgjSCtZkjN7heKaT/7/0PT0b0l2nJ5K0JzCI1YBIavSwGU0cxJ2gksIniKC8dgfk8zYAAoPRimlnQ=
X-Received: by 2002:a9d:5a0b:: with SMTP id v11mr2687592oth.102.1573059801948;
 Wed, 06 Nov 2019 09:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20191106042252.72452-1-john.stultz@linaro.org>
 <20191106042252.72452-2-john.stultz@linaro.org> <7154851c-fc55-e157-5a01-21abdd4a23e6@ti.com>
In-Reply-To: <7154851c-fc55-e157-5a01-21abdd4a23e6@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 6 Nov 2019 09:03:10 -0800
Message-ID: <CALAqxLW1vgLCik5WfDN7qkRsO=K9U4otNBp72aOH5UNN1jUgMQ@mail.gmail.com>
Subject: Re: [PATCH v15 1/5] dma-buf: Add dma-buf heaps framework
To:     "Andrew F. Davis" <afd@ti.com>
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
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 5:52 AM Andrew F. Davis <afd@ti.com> wrote:
>
> On 11/5/19 11:22 PM, John Stultz wrote:
> > +unsigned int dma_heap_ioctl_cmds[] = {
> > +     DMA_HEAP_IOC_ALLOC,
> > +};
> > +
> > +static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
> > +                        unsigned long arg)
> > +{
> > +     char stack_kdata[128];
> > +     char *kdata = stack_kdata;
> > +     unsigned int kcmd;
> > +     unsigned int in_size, out_size, drv_size, ksize;
> > +     int nr = _IOC_NR(ucmd);
> > +     int ret = 0;
> > +
> > +     if (nr >= ARRAY_SIZE(dma_heap_ioctl_cmds))
> > +             return -EINVAL;
> > +
> > +     /* Get the kernel ioctl cmd that matches */
> > +     kcmd = dma_heap_ioctl_cmds[nr];
>
>
> Why do we need this indirection here and all the complexity below? I
> know DRM ioctl does something like this but it has a massive table,
> legacy ioctls, driver defined ioctls, etc..
>
> I don't expect we will ever need complex handling like this, could we
> switch back to the more simple handler from v13?

I agree it does add complexity, but I'm not sure I see how to avoid
some of this. The logic trying to handle that the user may pass a cmd
that has the same _IOC_NR() as DMA_HEAP_IOC_ALLOC but not the same
size. So the simple "switch(cmd) { case DMA_HEAP_IOC_ALLOC:" we had
before won't work (as the cmd will be a different value).

Thus why I thought the cleanest approach would be to use the
dma_heap_ioctl_cmds array to convert from whatever the user cmd is to
the matching kernel cmd value.

Do you have an alternative suggestion that I'm overlooking?

thanks
-john
