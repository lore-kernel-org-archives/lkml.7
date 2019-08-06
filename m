Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5854CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BBD214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SZo4fdmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbfHFOLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:11:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36130 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:11:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id c15so11369218oic.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSZHR8G3MghKTiH3RE/z9t0oAkPmKdy9XO/QMCZqNZU=;
        b=SZo4fdmXeH8WXLZpaSB/sTV0Fj/AOoy8kq3bwOXiCeK8jvWHo70O+zD6FGjZ4ESlzG
         MJwNG4UTGW0T+1XmwKK1L0YCnIqCOJzMb+NEEP94tgXzPcO60WWioadGoDrAlJhawAxu
         C6B3hppVH+zXeBCt8Dxdu3vMqTF2xSy6yZ4Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSZHR8G3MghKTiH3RE/z9t0oAkPmKdy9XO/QMCZqNZU=;
        b=r33EYGYM+Lgq0Mh9FzI1J5sWNWxGHqf3gy4XVSeh0uTmvIvlYXotOBuVi6cmm7s6y7
         NEdjDgRubrukKbIhA3La3XHGefeq6kMkdSSoMarvlBppcZmnpfwChpKmaGXs4tevWgRD
         Js/pX+/VvN8BEMqcJpYJQinDIdV3ZYSIqDJMj6qc0lAyli6/ltonr5PoR3EcPPbaVvP5
         O1JW5AG8sa1Sd6OGEToApD8xjNSmYAKj7fP0doxp4qGopNVTjTW/thFR0EUbgq7JejqV
         fQdAegEmj24T5x+48MfXKpwLbGWrBa34afQ3uHPlAmevRzL0jj7T7/WhobEAvd0qnFMD
         IkRg==
X-Gm-Message-State: APjAAAXtP7AWx681ag9610VJdebig4jUjtn6KoOZI68T/chbJWyuq4ym
        Uw7xd/MlRUebCmdXrgpcCWp7tNZZx2gxVZWNHlEJGWg5/M4=
X-Google-Smtp-Source: APXvYqytpvT8vaMFRA5kJCHz75f7m4Y8MAbUwJhZNd42scl1WSb2yxqI74afmLk/TEYBgez6jiANQdmqKzHF5x1pzu0=
X-Received: by 2002:a02:c916:: with SMTP id t22mr4302514jao.24.1565100712372;
 Tue, 06 Aug 2019 07:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de>
In-Reply-To: <20190806084821.GA17129@lst.de>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 6 Aug 2019 07:11:41 -0700
Message-ID: <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
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

On Tue, Aug 6, 2019 at 1:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This goes in the wrong direction.  drm_cflush_* are a bad API we need to
> get rid of, not add use of it.  The reason for that is two-fold:
>
>  a) it doesn't address how cache maintaince actually works in most
>     platforms.  When talking about a cache we three fundamental operations:
>
>         1) write back - this writes the content of the cache back to the
>            backing memory
>         2) invalidate - this remove the content of the cache
>         3) write back + invalidate - do both of the above

Agreed that drm_cflush_* isn't a great API.  In this particular case
(IIUC), I need wb+inv so that there aren't dirty cache lines that drop
out to memory later, and so that I don't get a cache hit on
uncached/wc mmap'ing.

>  b) which of the above operation you use when depends on a couple of
>     factors of what you want to do with the range you do the cache
>     maintainance operations
>
> Take a look at the comment in arch/arc/mm/dma.c around line 30 that
> explains how this applies to buffer ownership management.  Note that
> "for device" applies to "for userspace" in the same way, just that
> userspace then also needs to follow this protocol.  So the whole idea
> that random driver code calls random low-level cache maintainance
> operations (and use the non-specific term flush to make it all more
> confusing) is a bad idea.  Fortunately enough we have really good
> arch helpers for all non-coherent architectures (this excludes the
> magic i915 won't be covered by that, but that is a separate issue
> to be addressed later, and the fact that while arm32 did grew them
> very recently and doesn't expose them for all configs, which is easily
> fixable if needed) with arch_sync_dma_for_device and
> arch_sync_dma_for_cpu.  So what we need is to figure out where we
> have valid cases for buffer ownership transfer outside the DMA
> API, and build proper wrappers around the above function for that.
> My guess is it should probably be build to go with the iommu API
> as that is the only other way to map memory for DMA access, but
> if you have a better idea I'd be open to discussion.

Tying it in w/ iommu seems a bit weird to me.. but maybe that is just
me, I'm certainly willing to consider proposals or to try things and
see how they work out.

Exposing the arch_sync_* API and using that directly (bypassing
drm_cflush_*) actually seems pretty reasonable and pragmatic.  I did
have one doubt, as phys_to_virt() is only valid for kernel direct
mapped memory (AFAIU), what happens for pages that are not in kernel
linear map?  Maybe it is ok to ignore those pages, since they won't
have an aliased mapping?

BR,
-R
