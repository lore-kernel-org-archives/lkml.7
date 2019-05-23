Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1E5C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BE321883
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QYLDyYhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfEWLat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:30:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39201 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfEWLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:30:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id v2so4075998oie.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8h3Tf0RlBpsQ1a0YQeR0qKJGmBmNjStk3GauhOvxfc=;
        b=QYLDyYhvqLdf9UyAYUZmimoGJGuAzW+uJ3NTQ8es79E4sN4u/24qi0cS+Q61aJ09as
         ook5Pdqnsw873SmnSGAvaRpKjJPbvAErIJjMeYLOV9ddY/bLuH1RB4J3VxUDiAmYgA6D
         /6UcDwXWSFvVXvEJ6HDdy7BltsAZkgxHPy2jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8h3Tf0RlBpsQ1a0YQeR0qKJGmBmNjStk3GauhOvxfc=;
        b=GJYRNWUsE2OLLo3t39MoKo2xQNQkBHl0HQXsVotmFQ9uEI5HAiBylEE/VXTLDntU7T
         Ozc3unnKvS+8UeRBl02BXdTLRrmOXoik3VVtWafh0rnI76O9y0kUOAsHyTnP0dq4q3eN
         xpD0s9hz7aK+0fxWzpIx3gkxmiVk0sqnADH/JjT69Y+76/qn9Qr3SACX/edNWpBSQr5k
         Jr/4TYi1k9L+ilMRHEyVpJG7EEWclbSTdNei3yK2rJtAx7tTtFGEhKSqa75kNPMVQkk7
         Zkn9IObOMy+2mbz3A4dyr5jwT4nmYPBrODQGBN0KzFXW/pvC0wk8vpL7uznv4iO+DgYF
         yzLQ==
X-Gm-Message-State: APjAAAVtA6xtJskn5HApdhtRdAdv8YggJKhTu9fqgQqPrYVj/lQsqypp
        uaivxELsK6J+ZZ/ZpchuyC7URa0YuONHEB0xVEA5tg==
X-Google-Smtp-Source: APXvYqzgWW4QE3al1A+KXCjvwN22k9yT81tHRLi7VGKggF93LUWQZHYr4QLQpl2sBgX03nTP61D98NBJqaWFaIklIDU=
X-Received: by 2002:aca:31cf:: with SMTP id x198mr2294398oix.132.1558611048084;
 Thu, 23 May 2019 04:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <1556323269-19670-1-git-send-email-lmark@codeaurora.org> <CAO_48GGanguXbmYDD+p1kK_VkiWdZSTYAD1y-0JQK7hqL_OPPg@mail.gmail.com>
 <d7fb2a6b-f516-b506-247d-0f3d4d59ec8e@gmail.com> <CAKMK7uEaeVW0EMtCUeH+WeUmFnovEySz3kebRUcybLeySb4GSA@mail.gmail.com>
 <cbb1f3a1-6cd1-c231-f1b2-8f20a6bad067@amd.com>
In-Reply-To: <cbb1f3a1-6cd1-c231-f1b2-8f20a6bad067@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 23 May 2019 13:30:35 +0200
Message-ID: <CAKMK7uFghnEHjyOaJyui+8g9gJahhnhNWPruPMqPr6VAN1UvsA@mail.gmail.com>
Subject: Re: [PATCH 01/12] dma-buf: add dynamic caching of sg_table
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 1:21 PM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 22.05.19 um 20:30 schrieb Daniel Vetter:
> > [SNIP]
> >> Well, it seems you are making incorrect assumptions about the cache
> >> maintenance of DMA-buf here.
> >>
> >> At least for all DRM devices I'm aware of mapping/unmapping an
> >> attachment does *NOT* have any cache maintenance implications.
> >>
> >> E.g. the use case you describe above would certainly fail with amdgpu,
> >> radeon, nouveau and i915 because mapping a DMA-buf doesn't stop the
> >> exporter from reading/writing to that buffer (just the opposite actually).
> >>
> >> All of them assume perfectly coherent access to the underlying memory.
> >> As far as I know there is no documented cache maintenance requirements
> >> for DMA-buf.
> > I think it is documented. It's just that on x86, we ignore that
> > because the dma-api pretends there's never a need for cache flushing
> > on x86, and that everything snoops the cpu caches. Which isn't true
> > since over 20 ago when AGP happened. The actual rules for x86 dma-buf
> > are very much ad-hoc (and we occasionally reapply some duct-tape when
> > cacheline noise shows up somewhere).
>
> Well I strongly disagree on this. Even on x86 at least AMD GPUs are also
> not fully coherent.
>
> For example you have the texture cache and the HDP read/write cache. So
> when both amdgpu as well as i915 would write to the same buffer at the
> same time we would get a corrupted data as well.
>
> The key point is that it is NOT DMA-buf in it's map/unmap call who is
> defining the coherency, but rather the reservation object and its
> attached dma_fence instances.
>
> So for example as long as a exclusive reservation object fence is still
> not signaled I can't assume that all caches are flushed and so can't
> start with my own operation/access to the data in question.

The dma-api doesn't flush device caches, ever. It might flush some
iommu caches or some other bus cache somewhere in-between. So it also
won't ever make sure that multiple devices don't trample on each
another. For that you need something else (like reservation object,
but I think that's not really followed outside of drm much).

The other bit is the coherent vs. non-coherent thing, which in the
dma-api land just talks about whether cpu/device access need extra
flushing or not. Now in practice that extra flushing is always only
cpu side, i.e. will cpu writes/reads go through the cpu cache, and
will device reads/writes snoop the cpu caches. That's (afaik at least,
an in practice, not the abstract spec) the _only_ thing dma-api's
cache maintenance does. For 0 copy that's all completely irrelevant,
because as soon as you pick a mode where you need to do manual cache
management you've screwed up, it's not 0-copy anymore really.

The other hilarious stuff is that on x86 we let userspace (at least
with i915) do that cache management, so the kernel doesn't even have a
clue. I think what we need in dma-buf (and dma-api people will scream
about the "abstraction leak") is some notition about whether an
importer should snoop or not (or if that device always uses non-snoop
or snooped transactions). But that would shred the illusion the
dma-api tries to keep up that all that matters is whether a mapping is
coherent from the cpu's pov or not, and you can achieve coherence both
with a cache cpu mapping + snooped transactions, or with wc cpu side
and non-snooped transactions. Trying to add cache managment (which
some dma-buf exporter do indeed attempt to) will be even worse.

Again, none of this is about preventing concurrent writes, or making
sure device caches are flushed correctly around batches.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
