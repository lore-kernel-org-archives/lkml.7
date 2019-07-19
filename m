Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA73FC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B5A2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NgzALEiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGSJNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:13:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33499 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfGSJNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:13:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so33853679edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dy3eiftsHgEHO+bH2d+Vo7Yj2Uyc+Sk/TwZVrada+Bw=;
        b=NgzALEiEIP/wom8Q6GPOA1eTwCqfuDSwYRT4pTiN0svfxty8C46zOPR5oqWBl6sKYN
         c3tPHABjFwEJBusU078wzdryzWYwNGa6XkEBumqKeEoogixd5tOeF0yhtjpYLQ5f7P1Y
         F4yJCHJAwr+LS3OZyGjE2++8/S+TLAX14C0Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Dy3eiftsHgEHO+bH2d+Vo7Yj2Uyc+Sk/TwZVrada+Bw=;
        b=jxZZjmVyqv2YpCVVFFl0iD8SO9E06+lYrTQebgSSjTirCUALqkmAXt+q/OMghwe0oC
         em9NpRG12jDIJff9wR6aolq12932tZeSuX3rSJXH1/GFvUO2aKj4klaTM0ShAhPLJgwI
         QL2C6ileCVxNQso4924EzsOsLM1+qlA8aR4fV9uc8WHXHwCjG5lcLlxu5zniippMyaPo
         i6zygG+6sWnMlKyG24edPgPl/ENpLHhn0zjnhGKwYNECm0rFepmwoDHRISPe0fBwjtsm
         WVuL0EUbmVEecXg4u7JOu4Xotg83+E7YITeoyxxOZCRNIDchS3p4Fy3Q61UKxcDAzJk0
         kaPQ==
X-Gm-Message-State: APjAAAW4NbXbp68PUKns3BMYjM9A0V5PDwwr428ShF7LWcBLbmD/eRFN
        y2nPM7XlT9b9Y5VKAWqS/BA=
X-Google-Smtp-Source: APXvYqz+3V8Aeo5Sma4Zyvs268t0Iez1pg+tIsq1r4Jm4RSqAPYUfQU3LmKxnxV+qOIMZvQ7pzoruw==
X-Received: by 2002:a50:e69a:: with SMTP id z26mr45147649edm.41.1563527597630;
        Fri, 19 Jul 2019 02:13:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f24sm8699434edf.30.2019.07.19.02.13.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 02:13:16 -0700 (PDT)
Date:   Fri, 19 Jul 2019 11:13:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Biggers <ebiggers@google.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] drm/vgem: use normal cached mmap'ings
Message-ID: <20190719091314.GH15868@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>, David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Biggers <ebiggers@google.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190716213746.4670-1-robdclark@gmail.com>
 <20190716213746.4670-3-robdclark@gmail.com>
 <87lfwxh7mo.fsf@anholt.net>
 <CAF6AEGsrJu8r+t35zWxbq8KXFSoyPSJ_3+MjTii00Pb=YOMxHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGsrJu8r+t35zWxbq8KXFSoyPSJ_3+MjTii00Pb=YOMxHQ@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 05:13:10PM -0700, Rob Clark wrote:
> On Tue, Jul 16, 2019 at 4:39 PM Eric Anholt <eric@anholt.net> wrote:
> >
> > Rob Clark <robdclark@gmail.com> writes:
> >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Since there is no real device associated with VGEM, it is impossible to
> > > end up with appropriate dev->dma_ops, meaning that we have no way to
> > > invalidate the shmem pages allocated by VGEM.  So, at least on platforms
> > > without drm_cflush_pages(), we end up with corruption when cache lines
> > > from previous usage of VGEM bo pages get evicted to memory.
> > >
> > > The only sane option is to use cached mappings.
> >
> > This may be an improvement, but...
> >
> > pin/unpin is only on attaching/closing the dma-buf, right?  So, great,
> > you flushed the cached map once after exporting the vgem dma-buf to the
> > actual GPU device, but from then on you still have no interface for
> > getting coherent access through VGEM's mapping again, which still
> > exists.
> 
> In *theory* one would detach before doing further CPU access to
> buffer, and then re-attach when passing back to GPU.
> 
> Ofc that isn't how actual drivers do things.  But maybe it is enough
> for vgem to serve it's purpose (ie. test code).
> 
> > I feel like this is papering over something that's really just broken,
> > and we should stop providing VGEM just because someone wants to write
> > dma-buf test code without driver-specific BO alloc ioctl code.
> 
> yup, it is vgem that is fundamentally broken (or maybe more
> specifically doesn't fit in w/ dma-mappings view of how to do cache
> maint), and I'm just papering over it because people and CI systems
> want to be able to use it to do some dma-buf tests ;-)
> 
> I'm kinda wondering, at least for arm/dt based systems, if there is a
> way (other than in early boot) that we can inject a vgem device node
> into the dtb.  That isn't a thing drivers should normally do, but (if
> possible) since vgem is really just test infrastructure, it could be a
> way to make dma-mapping happily think vgem is a real device.

Or we just extend drm_cflush_pages with the cflushing we need (at least
for those arms where this is possible, let's ignore the others) and accept
for a few more years that dma-api doesn't fit?

Note this would need to be a full copypasta of what the arch code has
(since just exporting the function was shot down before), but I really
don't care about the resulting wailing if we do this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
