Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39375C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 00:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1714218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 00:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBa+wUxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfCPAQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 20:16:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34976 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfCPAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 20:16:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so5331469wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 17:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AoD+knAlz3bws5yL5P/ADP0iS5uhqJVppDIkBdID5rw=;
        b=EBa+wUxhUnTUdUcl3ZVnnTRnbjXoeefaWc66vS05b1V7JyKeL687V8ffCFM9/RbIkH
         v66wjYx8PMnoL/2mpIQ04jOobfatxnC+a+xiCauS5U9eg1DQnIqPJmgeS+vsYwNWGBVR
         JP3OuNikMXRXSq76ZdkUBDbJYyem1/ouqswtGM04sv9alC3ZkNf46w5iFMnUA9Bvy1A/
         KTXrfCt6pDtHOrch1ys4qBTdacKN4/lKqmvF/1LzlguOjlTy1Ybyl3K4Kckh5XLyeZQ8
         ko/hpg01WUyIPeaRbsbezfFPFFB8xTfaz3F0cWh4mLgHMzZz48N+ug+/doFupov8OTm4
         WAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoD+knAlz3bws5yL5P/ADP0iS5uhqJVppDIkBdID5rw=;
        b=eWA1ONOl6nE4Sk2rVWfCcpZiAkb/HG49KMtWNpAJS3jbttibCf58tWCn9kX0QQw/g7
         wX3qo2z28tKniHRY2T2W84P4axD8+6Q+/PPn841DZ49P12yO1ErMTsrnZujY2lRctaCT
         ogx/P0X7xmuycAo2BtfvijQ/4pUoT8EPOrakqkI4bvk9dkPQhslwszUtvMPAepMWL1T6
         ld4t0dQUHtow+FJLG6cALziLyYcrW7lTavGN2XSgDcNetdrHlmvZN80yxOvoUM45bsH+
         gwOfWS601H7Ervqt+r0/M/ZEpFO9ZaBJTK1CleX20XD8u6e4GGSu8A/umQs5OwqQHJe3
         Vz0w==
X-Gm-Message-State: APjAAAUY6kWe8QigBdwLNjDXqwXQJEVNGMNz/N0QQ+ZiSF8/WAs6x3b+
        JnIsPPHxdqBMj9VI2FgMl0HjTG+UnIMT9QRx1kh8foy1
X-Google-Smtp-Source: APXvYqxVmJMUiaryFXwZo/FDGUu5a3Cq3dtja+UTANs6iT3Lo1JpsdeFqspq6z5TABkNWvZrDJ+fEjpffDYZk3XM8qA=
X-Received: by 2002:adf:fa51:: with SMTP id y17mr4342564wrr.233.1552695407561;
 Fri, 15 Mar 2019 17:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org> <20190315231547.GB3242@redhat.com>
In-Reply-To: <20190315231547.GB3242@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 15 Mar 2019 17:16:36 -0700
Message-ID: <CALAqxLW3A+n7U3Kjt1qyR593_JO-MB-2abDD2fYbCX2MZ2KvEA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 4:15 PM Jerome Glisse <jglisse@redhat.com> wrote:
> On Tue, Mar 05, 2019 at 12:54:28PM -0800, John Stultz wrote:
> > Here is a initial RFC of the dma-buf heaps patchset Andrew and I
> > have been working on which tries to destage a fair chunk of ION
> > functionality.
> >
> > The patchset implements per-heap devices which can be opened
> > directly and then an ioctl is used to allocate a dmabuf from the
> > heap.
> >
> > The interface is similar, but much simpler then IONs, only
> > providing an ALLOC ioctl.
> >
> > Also, I've provided simple system and cma heaps. The system
> > heap in particular is missing the page-pool optimizations ION
> > had, but works well enough to validate the interface.
> >
> > I've booted and tested these patches with AOSP on the HiKey960
> > using the kernel tree here:
> >   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> >
> > And the userspace changes here:
> >   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
>
> What upstream driver will use this eventualy ? And why is it
> needed ?

So, its sort of a complicated answer, as we don't have a fully open
pipeline just yet.  The HiKey board's upstream kirin drm driver uses
this, as it needs contiguous buffers for its framebuffers. So in
Android the HiKey gralloc (opensource userspace) allocates the HW_FB
buffers from the CMA heap.  Other graphics buffers are then allocated
by gralloc out of the system heap and SurfaceFlinger and  drm_hwc
(both also opensource userspace) coordinate squashing those other
buffers down through the mali utgard gpu (proprietary GL blob) onto
the target HW_FB buffer.  (All of the above is the same for the
HiKey960, but we're still working the drm driver into shape for
upstreaming).

That said, I know the Lima driver is starting to shape up, and I'm
hoping to give it a whirl to replace the proprietary utgard driver.
Everything else would stay the same, which would give us a fully open
pipeline.

I know for other dev boards like the db410c w/ freedreno, the Android
pipeline gets away with using the gbmgralloc implementation, but my
understanding in that case is the rendering/display pipeline doesn't
require contiguous buffers, so the allocation logic can be simpler,
and doesn't use ION heaps. But its possible a gralloc could be
implemented to use the system heap for allocations on that device.

thanks
-john
