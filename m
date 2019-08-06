Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE4BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4F3208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K34U5Yzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbfHFQYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:24:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43156 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbfHFQYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:24:02 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so67496641oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fbj+u+KrqZW21/tW+cx/lMPBDdiJJVlER4tKrQPMhTU=;
        b=K34U5YzvYaD1O3TWt3DKuJv0E7xfxFYasGVJmvfC3bMJWdUxjUg+tT/VSSTZurCvVa
         iovFc4oxIYrAcjIw6g7JmWJGjsqZqOvT+JpgTMJo4I6dVtpKFZSjyxhtp719Ua7sfhOP
         MDgeCWp2jWMGu9BPGfva1iVe+gQRtEb8DMqWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fbj+u+KrqZW21/tW+cx/lMPBDdiJJVlER4tKrQPMhTU=;
        b=m+gA1RWqkcVhPXC68WlGCxkK7hw6vYWeSU3PwBr8ZZm2vubYSsQv9AyOppP7YU14G+
         woBqUWubiSkkElwgyuUAndM4cQ8Zski027gaz55O7tgoBHNzrJDsMUdnPv55kY2WIf29
         BSa9127V4J+7QM5/PfTmjPI9hoo1dMEcQYEfy1GmK65wjnPjxHdE4ZSopFwZrinrZmXV
         +CqIA+FpezakJquEHQCaMSS1tC0I4IamobORJ/k00oPwaHNYy3oplvnwOSj8XxMd6FDx
         8JLCTs/uVSYGPthFWJqJiZ91v0+a6jZYnB+beY8OrMp3SyaDusKV5F//nVcKC92N+SZR
         qupg==
X-Gm-Message-State: APjAAAVuOcjnQIOy9x1xZA/jXu9YtU2ztXZ8PSlELw4wnqSceuKrjm/b
        7NoBgjsAo+ZAPy5PzXISfobIhY1lqcAYSeTq3pOJ9g==
X-Google-Smtp-Source: APXvYqyfP29xHh3wHXQf3kayoVgPfPlXWuIwnV/InXQ1VuBpOGOPWgtJVmYL0bZSvY7/FfjsJEoRXu6p5LXQCNopOtE=
X-Received: by 2002:a02:c549:: with SMTP id g9mr5009331jaj.14.1565108641886;
 Tue, 06 Aug 2019 09:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com> <20190806155044.GC25050@lst.de>
In-Reply-To: <20190806155044.GC25050@lst.de>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 6 Aug 2019 09:23:51 -0700
Message-ID: <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 8:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 06, 2019 at 07:11:41AM -0700, Rob Clark wrote:
> > Agreed that drm_cflush_* isn't a great API.  In this particular case
> > (IIUC), I need wb+inv so that there aren't dirty cache lines that drop
> > out to memory later, and so that I don't get a cache hit on
> > uncached/wc mmap'ing.
>
> So what is the use case here?  Allocate pages using the page allocator
> (or CMA for that matter), and then mmaping them to userspace and never
> touching them again from the kernel?

Currently, it is pages coming from tmpfs.  Ideally we want pages that
are swappable when unpinned.

CPU mappings are *mostly* just mapping to userspace.  There are a few
exceptions that are vmap'd (fbcon, and ringbuffer).

(Eventually I'd like to support pages passed in from userspace.. but
that is down the road.)

> > Tying it in w/ iommu seems a bit weird to me.. but maybe that is just
> > me, I'm certainly willing to consider proposals or to try things and
> > see how they work out.
>
> This was just my through as the fit seems easy.  But maybe you'll
> need to explain your use case(s) a bit more so that we can figure out
> what a good high level API is.

Tying it to iommu_map/unmap would be awkward, as we could need to
setup cpu mmap before it ends up mapped to iommu.  And the plan to
support per-process pagetables involved creating an iommu_domain per
userspace gl context.. some buffers would end up mapped into multiple
contexts/iommu_domains.

If the cache operation was detached from iommu_map/unmap, then it
would seem weird to be part of the iommu API.

I guess I'm not entirely sure what you had in mind, but this is why
iommu seemed to me like a bad fit.

> > Exposing the arch_sync_* API and using that directly (bypassing
> > drm_cflush_*) actually seems pretty reasonable and pragmatic.  I did
> > have one doubt, as phys_to_virt() is only valid for kernel direct
> > mapped memory (AFAIU), what happens for pages that are not in kernel
> > linear map?  Maybe it is ok to ignore those pages, since they won't
> > have an aliased mapping?
>
> They could have an aliased mapping in vmalloc/vmap space for example,
> if you created one.  We have the flush_kernel_vmap_range /
> invalidate_kernel_vmap_range APIs for those, that are implement
> on architectures with VIVT caches.

If I only have to worry about aliased mappings that I create myself,
that doesn't seem too bad..  I could track that myself easily enough.

BR,
-R
