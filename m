Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53FCC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FBD20659
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANBhQPrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbfGYPYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:24:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35855 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387941AbfGYPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:24:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so50616643edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gryz4oIs4ZZI3Q3VIYP2tloVo1WnPxPFcILb2RQ/dVY=;
        b=ANBhQPrdPAoKQK9ZXEyziioz5qPzys4ZEmCTpfUDM+q3SbNO22FbkK9vjIs+oQ0Dev
         9Zyre+uqD8+HU/EWmJdiAUvufYIPbuTBbC8fFXK4fr7UnXSqXY9bhftHjTozL4OtMDMx
         sclACmp1vP04jHyYKBP57S+LQeIXTwoiQrqiOJP+FfdhqqUknT/I2QwKD1awQMDzYxZn
         gr7RD2mRWHgnqzGuvA8ls4cLw7uYU3nltdXA3zE/V3W7zjI45VLrTM+9JL5wwhanzaC9
         0HooyMM/mL9u8dYl3RMmgayqNrqbjvMsd9WsF+Pv6K/fc2BcRIt4BmcTBuMwnZ1OI/be
         V3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gryz4oIs4ZZI3Q3VIYP2tloVo1WnPxPFcILb2RQ/dVY=;
        b=n41YU2UEueUwJgF/+/FVECtNUNdvX+TjSU6s/MIlZZGPj+4L7H9y2n0PGmgUjHnzlg
         Fal2BIsnw7Waait5r8R3+9JnXJFciKccGe8xJhVxL0j+ndIh8q+DvedEj54sw9imv/TB
         G4H1miYoNIBxewpiW9dUJSkjyd035ptGx3HJvHjdvXRkasApV0jCZFwH2r9K6sKHXNC4
         UcLhqEoLv8bQklXN+UDE9ILO1ESi3Xj1Ak7HR8pMYQGwe+EvRM5TGTSdcG7ibs2n0Ftv
         s7s3Y+wSC/WpNATRoAS+6LIldY0qR8cm6wGjYAI1pdOodR510gNXTo7aO9xVRxoSu85s
         8NeA==
X-Gm-Message-State: APjAAAUVQjfAWslhq7Jon6JSR2ArTxbvSur3UUJOnmAaXBswKgn7Z1kM
        XINhw2oNweCBcB9vitmSazySghQOlamCebUNmvU=
X-Google-Smtp-Source: APXvYqxfWQXe/revetG8OcHxoLSO+C4rvtM+iZ2yDoeH5xVKQGVFekFfcpOY44B1y/zaBEGyqdSPVOGpL5oVH7m5U7Y=
X-Received: by 2002:a17:906:3f87:: with SMTP id b7mr66827074ejj.164.1564068243156;
 Thu, 25 Jul 2019 08:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-3-john.stultz@linaro.org> <20190718100654.GA19666@infradead.org>
 <CALAqxLX1s4mbitE-_1s1vFPJrbrCKqpyhYoFW0V6hMEqE=eKVw@mail.gmail.com>
 <CAF6AEGuM1+pimGNhyKHbYR0BdH=hH+Sai0es8RjGHE9jKHjngw@mail.gmail.com>
 <20190724065530.GA16225@infradead.org> <3966dff1-864d-cad4-565f-7c7120301265@ti.com>
 <20190725124142.GA20286@infradead.org>
In-Reply-To: <20190725124142.GA20286@infradead.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 25 Jul 2019 08:23:51 -0700
Message-ID: <CAF6AEGuKMu+=HYxmOPUL-5gkU1a1aqCxbx+E2ygYQqy4gmZ0Xw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] dma-buf: heaps: Add heap helpers
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Andrew F. Davis" <afd@ti.com>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 5:41 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jul 24, 2019 at 11:20:31AM -0400, Andrew F. Davis wrote:
> > Well then lets think on this. A given buffer can have 3 owners states
> > (CPU-owned, Device-owned, and Un-owned). These are based on the caching
> > state from the CPU perspective.
> >
> > If a buffer is CPU-owned then we (Linux) can write to the buffer safely
> > without worry that the data is stale or that it will be accessed by the
> > device without having been flushed. Device-owned buffers should not be
> > accessed by the CPU, and inter-device synchronization should be handled
> > by fencing as Rob points out. Un-owned is how a buffer starts for
> > consistency and to prevent unneeded cache operations on unwritten buffers.
>
> CPU owned also needs to be split into which mapping owns it - in the
> normal DMA this is the kernel direct mapping, but in dma-buf it seems
> the primary way of using it in kernel space is the vmap, in addition
> to that the mappings can also be exported to userspace, which is another
> mapping that is possibly not cache coherent with the kernel one.

Just for some history, dmabuf->vmap() is optional, and mostly added
for the benefit of drm/udl (usb display, where CPU needs to read out
and encode (?) the video stream.. most of the drm drivers are using
tmpfs to get backing pages, and if there is any kernel direct mapping
it is unused.

It is probably ok for any allocator that does care about a kernel
direct mapping to simply not implement vmap.

BR,
-R
