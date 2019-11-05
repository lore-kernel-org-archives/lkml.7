Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFE1C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E9E21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E0m/5SMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbfKEN6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:58:31 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41218 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389113AbfKEN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:58:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id e9so13681905oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 05:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDIxaK5XX1he2V+PqxXF4SxUgffAFMYXkaPiJpN+d6I=;
        b=E0m/5SMGe2TSs7mwIepFgaoMTW6j0pYIdgrE1mK4HxLg49ptKy3Z4dZyjyKTHAqNzm
         UM6fbse3CY7TZDGzrJSsLgThswDSyPyRTzFNTvX7+rMU2RncGQTKMlSOHswSWP9z4gDY
         5k7FYJeJn/XMzFh7hh2ZKN2RGGXVyacV995Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDIxaK5XX1he2V+PqxXF4SxUgffAFMYXkaPiJpN+d6I=;
        b=JF7DQ/x2Ti2TN5RxH+PlHwvZ1L6Up5JCqstM/D84w1CHyAWRnn87tfdSbDXd51B9hb
         rGI4COtvHAVPRsOSHVDFamDihK/vq9OC7rGnpIifs7ZIxhE47UGfbKzF3B90bYgEkzSN
         dwDYBUlvr6WMRBhucei0LZxdpVKYvVDkFJ9UqXTcHB6kyyDFSJuSW/QtpuMLq96jF7of
         UnNyNQjYymMaapFNHUEEHHyh2Obfu6yuOyZASZ0lO0E92vSmagVox2YF5nqUyFqUxXML
         Wb8Sx6kZPSuW7IzFiTHAfeOxE4ZXlR5okCZ2q22FDr29u9I2FJY3DLpiKbEecHacdscJ
         F49w==
X-Gm-Message-State: APjAAAVQshvNiIC5+yhCsJoVXei/cXiCJrxsGvyyfnay4rEqnUumKSOB
        iG//eCCjjm/3GRXRWUI9vUqt/HU1qc+e5hKHwQUvMg==
X-Google-Smtp-Source: APXvYqzCdtg8X/Dp3y8EBtEI3NYGoynsZiPpTNRwn1I8keVGknLSzC12T1ir0isKsE46LVkdT7beX3XVeNZ7+R86lls=
X-Received: by 2002:aca:b805:: with SMTP id i5mr4232004oif.110.1572962309401;
 Tue, 05 Nov 2019 05:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191104095823.GD10326@phenom.ffwll.local> <CALAqxLW_CoAn-KXki0dGKK+vo-R4CTnjt1Azrw=mRdL8BUFGWw@mail.gmail.com>
 <20191105094259.GX10326@phenom.ffwll.local> <5b591240-43c8-495a-e9c9-881a2997c492@ti.com>
In-Reply-To: <5b591240-43c8-495a-e9c9-881a2997c492@ti.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 5 Nov 2019 14:58:18 +0100
Message-ID: <CAKMK7uHWajeGRRw44nd+EHQvFeXimpLf2YPczXogEOa47iQw+A@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/2] Allow DMA BUF heaps to be loaded as modules
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 2:30 PM Andrew F. Davis <afd@ti.com> wrote:
>
> On 11/5/19 4:42 AM, Daniel Vetter wrote:
> > On Mon, Nov 04, 2019 at 10:57:44AM -0800, John Stultz wrote:
> >> On Mon, Nov 4, 2019 at 1:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>> On Fri, Oct 25, 2019 at 11:48:32PM +0000, John Stultz wrote:
> >>>> Now that the DMA BUF heaps core code has been queued, I wanted
> >>>> to send out some of the pending changes that I've been working
> >>>> on.
> >>>>
> >>>> For use with Android and their GKI effort, it is desired that
> >>>> DMA BUF heaps are able to be loaded as modules. This is required
> >>>> for migrating vendors off of ION which was also recently changed
> >>>> to support modules.
> >>>>
> >>>> So this patch series simply provides the necessary exported
> >>>> symbols and allows the system and CMA drivers to be built
> >>>> as modules.
> >>>>
> >>>> Due to the fact that dmabuf's allocated from a heap may
> >>>> be in use for quite some time, there isn't a way to safely
> >>>> unload the driver once it has been loaded. Thus these
> >>>> drivers do no implement module_exit() functions and will
> >>>> show up in lsmod as "[permanent]"
> >>>>
> >>>> Feedback and thoughts on this would be greatly appreciated!
> >>>
> >>> Do we actually want this?
> >>
> >> I guess that always depends on the definition of "we" :)
> >>
> >>> I figured if we just state that vendors should set up all the right
> >>> dma-buf heaps in dt, is that not enough?
> >>
> >> So even if the heaps are configured via DT (which at the moment there
> >> is no such binding, so that's not really a valid method yet), there's
> >> still the question of if the heap is necessary/makes sense on the
> >> device. And the DT would only control the availability of the heap
> >> interface, not if the heap driver is loaded or not.
> >
> > Hm I thought the cma regions are configured in DT? How does that work if
> > it's not using DT?
> >
> >> On the HiKey/HiKey960 boards, we have to allocate contiguous buffers
> >> for the display framebuffer. So gralloc uses ION to allocate from the
> >> CMA heap. However on the db845c, it has no such restrictions, so the
> >> CMA heap isn't necessary.
> >
> > Why do you have a CMA region for the 2nd board if you don't need it?
> > _That_ sounds like some serious memory waster, not a few lines of code
> > loaded for nothing :-)
> >
> >> With Android's GKI effort, there needs to be one kernel that works on
> >> all the devices, and they are using modules to try to minimize the
> >> amount of memory spent on functionality that isn't universally needed.
> >> So on devices that don't need the CMA heap, they'd probably prefer not
> >> to load the CMA dmabuf heap driver, so it would be best if it could be
> >> built as a module.  If we want to build the CMA heap as a module, the
> >> symbols it uses need to be exported.
> >
> > Yeah, I guess I'm disagreeing on whether dma-buf heaps are core or not.
> >
> >>> Exporting symbols for no real in-tree users feels fishy.
> >>
> >> I'm submitting an in-tree user here. So I'm not sure what you mean?  I
> >> suspect you're thinking there is some hidden/nefarious plan here, but
> >> really there isn't.
> >
> > I was working under the assumption that you're only exporting the symbols
> > for other heaps, and keep the current ones in-tree. Are there even any
> > out-of-tree dma-buf heaps still? out-of-tree and legit different use-case
> > I mean ofc, not just out-of-tree because inertia :-)
>
> Not sure what you mean here, hopefully all the heaps can be "in-tree"
> some day.
>
> https://patchwork.kernel.org/patch/10863957/

No idea this is good or bad, where's the userspace for it?

> Plus some non-caching heaps and one that forces early allocation of our
> PAT (gart like) IP.

Hm, so essentially we'd need to move _all_ drm allocators into dma-buf
heaps, for all drivers? Can't just do this for TI only ...

> All this stuff is going into our evil vendor tree next cycle (if not
> upstream by then :)), if we want some of these "specialty" heaps to go
> into generic kernel builds at some point they will need to be modules if
> the core is.
>
> Although I am still thinking Heaps should be always built in + system +
> CMA heaps, then the rando heaps could be modules if needed.

Yeah that's what I'd expected to happen. Speciality heaps for when you
have the relevant something unusual (and I'm not sure whether upstream
does want something unusual really, the above examples from you sound
a bit strange).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
