Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748D6FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4103A21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsrhK51O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbfJPReS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:34:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39882 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388899AbfJPReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:34:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so3665045wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0tIou4PVkZRKLfa9URmZPGTaGi8mrzfHy4IFvVFBmo=;
        b=IsrhK51OKWd8bP04UTXaPueBjA67hvoFZsdh7mia4eNj9xsV7+fv3sHRuN9eKLHN+V
         HDjLtWhbuI1I7S4WCLQLbfHetyQkZUCeRcNFjFP9wy1ADEOzsLrA2g+MYlHTfw7kjB84
         TIjeewvFBSokWChLz9b/K8dJz0aqdKI8genVCmpx09KFHWjj3+xPVvsGTGwpJ+IoH3YX
         tidSriY4ER0KjLMS+dUXbniyYq6agUF5ud6Vk61dRZ4a0zNelvyV75BBCzaRYQXY+ATZ
         guqCjijTxyJ7rFwVEC3ID9G0VyuqhmQVj2zHzr9p4j/1nLr4Qxg41roPSdfI8+zsg3ym
         JKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0tIou4PVkZRKLfa9URmZPGTaGi8mrzfHy4IFvVFBmo=;
        b=O4pXFBgwoYVcae2it127rTx59kUZB2AIEd7U0H1TI3J4UyEpYFiwpXj9WMRx8dQR0H
         MlGXT/dt6EQdBYJIcrhH1dC3mEseP2vA/n1/nCLJvi1224MzavwsQ2OHoAb0snqb18jC
         iiGwG8ve2aEL9EoL/U4/KN9Rp86gpoIAXZqD61JpqA+iD0RV49WEQ63gkTgOD+g0lqAK
         djKtRZJU3qqQDi+b4QzXfWG5jI+JKbx1wjF0QveIKxf9cwVHhwCPn8nu1OH/uJTLmqnM
         2wgIQRlozwLoWD3mx+NuId11k6ykHVE9Pt6RYFS/SqeBW8M8anqEHs3WTpOrEivxa6wd
         Zq1Q==
X-Gm-Message-State: APjAAAW+5sF/xu96nfCTHdV5wiju1bc4WboKoKYERyFbki1eiDYj7yC0
        5K65BdClG+EZMYLuQ+kiuSW6ZfvQdaeUBs40VlxLXg==
X-Google-Smtp-Source: APXvYqy+FGQn6QYk/0687usNtlfuIFnlu9T3YLV2q9L2MjpCBtgZNe+VkqswnI0REXKB1BTmCOjv5LFAhvBniduVCTU=
X-Received: by 2002:a1c:f201:: with SMTP id s1mr4209041wmc.59.1571247253858;
 Wed, 16 Oct 2019 10:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
In-Reply-To: <20191009173742.GA2682@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 16 Oct 2019 10:34:01 -0700
Message-ID: <CALAqxLVHjijuDUvVp4bTn5-bh=CTAZ3wvY0-PAG0TdKq-J6cHw@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>, nd <nd@arm.com>,
        Pratik Patel <pratikp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 10:38 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
>
> On Tue, Sep 24, 2019 at 04:22:18PM +0000, Ayan Halder wrote:
> > On Thu, Sep 19, 2019 at 10:21:52PM +0530, Sumit Semwal wrote:
> > > Hello Christoph, everyone,
> > >
> > > On Sat, 7 Sep 2019 at 00:17, John Stultz <john.stultz@linaro.org> wrote:
> > > >
> > > > Here is yet another pass at the dma-buf heaps patchset Andrew
> > > > and I have been working on which tries to destage a fair chunk
> > > > of ION functionality.
> > > >
> > > > The patchset implements per-heap devices which can be opened
> > > > directly and then an ioctl is used to allocate a dmabuf from the
> > > > heap.
> > > >
> > > > The interface is similar, but much simpler then IONs, only
> > > > providing an ALLOC ioctl.
> > > >
> > > > Also, I've provided relatively simple system and cma heaps.
> > > >
> > > > I've booted and tested these patches with AOSP on the HiKey960
> > > > using the kernel tree here:
> > > >   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> > > >
> > > > And the userspace changes here:
> > > >   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
> > > >
> > > > Compared to ION, this patchset is missing the system-contig,
> > > > carveout and chunk heaps, as I don't have a device that uses
> > > > those, so I'm unable to do much useful validation there.
> > > > Additionally we have no upstream users of chunk or carveout,
> > > > and the system-contig has been deprecated in the common/andoid-*
> > > > kernels, so this should be ok.
> > > >
> > > > I've also removed the stats accounting, since any such accounting
> > > > should be implemented by dma-buf core or the heaps themselves.
> > > >
> > > > Most of the changes in this revision are adddressing the more
> > > > concrete feedback from Christoph (many thanks!). Though I'm not
> > > > sure if some of the less specific feedback was completely resolved
> > > > in discussion last time around. Please let me know!
> > >
> > > It looks like most of the feedback has been taken care of. If there's
> > > no more objection to this series, I'd like to merge it in soon.
> > >
> > > If there are any more review comments, may I request you to please provide them?
> >
> > I tested these patches using our internal test suite with Arm,komeda
> > driver and the following node in dts
> >
> >         reserved-memory {
> >                 #address-cells = <0x2>;
> >                 #size-cells = <0x2>;
> >                 ranges;
> >
> >                 framebuffer@60000000 {
> >                         compatible = "shared-dma-pool";
> >                         linux,cma-default;
> >                         reg = <0x0 0x60000000 0x0 0x8000000>;
> >                 };
> >         }
> Apologies for the confusion, this dts node is irrelevant as our tests were using
> the cma heap (via /dev/dma_heap/reserved).
>
> That raises a question. How do we represent the reserved-memory nodes
> (as shown above) via the dma-buf heaps framework ?

(Apologies I didn't initially see this as you somehow left me off the
reply list)

So yea, as Brian mentioned, we'll generate a heap for each cma area.
So the above should generate a heap named "framebuffer".

For example, on HiKey960 the following patch adds (originally for ION,
but the same dt node will work for dmabuf heaps) the cma heap
"linux,cma"
  https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/dma-buf-heap&id=00538fe70e17acf07fdcbc441816d91cdd227207

thanks
-john
