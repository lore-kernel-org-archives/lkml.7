Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0DAC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3730A2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgWMe3rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbfGXSqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:46:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36008 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfGXSqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:46:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so48146107wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09rFu7af1PGRR7AeHEC/mVE2Rd2hQP0HuD37W7SEc4g=;
        b=HgWMe3rcv2qkGTsJ5HKLMVR7js0MiXzyCkVixWpym+prbnGsyCJYDL1GKs9m+5OR34
         uZkNHDo90oUz9hGmTCJ2A7rtdhvkCY0wmCOP5iapHpn+uFzW7lNzxlwewICis4P/MDcE
         d9UsHIsRja44yirPmbcTRDb0PioPrPYORsIu8BgUmWhiwVm9LuC5BKOKmAGgljXALRz+
         yyEU2hYtJ6J0tRqLLcdjsOELT9/500GZkM8tDO9kvF5oe3z2Jari74Ln7KMaJLjcsAaT
         5m4v79B8izQARxXx0MCYPdGp8DsWPthiT9PybykfXkOmJqeJU72HSsSf6pm1wYsTuLtN
         2LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09rFu7af1PGRR7AeHEC/mVE2Rd2hQP0HuD37W7SEc4g=;
        b=ZtqNld3I7tb0Vby4pNzGZyuQlJyRKDVUwtNbw4NbGh4NM2zCfYeXOqy3YAd5s3d2UK
         MD2RRHCBQC+sJLf6QUCInDr02ZVfAdCg/MYuqiUeNFGgfnXbFQ+vpEj4DBDPq0MpaqC/
         +3IIaXi5/bL6ADggYXTGnJkuKBOaI7ujCmCyAeob7mXc32Y6T1MeqqwnBQBgeuwI0qPx
         zxVDAjpyC45UsOdtTL31AaUYpQHNGzluMBRTEl01wSovDAAh5dWbHSzEPYWjq3UQLGXU
         14j6tG3VH9rA8Pcep1OTcCyrAcbuiQ7mCFbgaCTheQculiiCL+sKd5Y5tHsQfk6dlUoc
         cxaw==
X-Gm-Message-State: APjAAAVoJ/FzqFNpKB0h5mToXGovSK6S8Vi84TbJre5+BEFAVA4QYZKb
        fUr4J+Sev7AkG8AquiP8REdmwhXm58vfCB+zuPqTIQ==
X-Google-Smtp-Source: APXvYqx3pjPIwWc/lOXIzyf8yBCvPRk6JwemOLLIL57IuNozaOmrvi2+JWZwsEC1VqG+o7cdQ6vaEzwR/Zq/lP7z6KM=
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr1043985wro.284.1563993995712;
 Wed, 24 Jul 2019 11:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org> <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com> <20190724065958.GC16225@infradead.org>
In-Reply-To: <20190724065958.GC16225@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Jul 2019 11:46:24 -0700
Message-ID: <CALAqxLUbsz+paJ=P2hwKecuN8DQjJt9Vj4MENCnFuEh6waxsXg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
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
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 12:00 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jul 22, 2019 at 10:04:06PM -0700, John Stultz wrote:
> > Apologies, I'm not sure I'm understanding your suggestion here.
> > dma_alloc_contiguous() does have some interesting optimizations
> > (avoiding allocating single page from cma), though its focus on
> > default area vs specific device area doesn't quite match up the usage
> > model for dma heaps.  Instead of allocating memory for a single
> > device, we want to be able to allow userland, for a given usage mode,
> > to be able to allocate a dmabuf from a specific heap of memory which
> > will satisfy the usage mode for that buffer pipeline (across multiple
> > devices).
> >
> > Now, indeed, the system and cma heaps in this patchset are a bit
> > simple/trivial (though useful with my devices that require contiguous
> > buffers for the display driver), but more complex ION heaps have
> > traditionally stayed out of tree in vendor code, in many cases making
> > incompatible tweaks to the ION core dmabuf exporter logic.
>
> So what would the more complicated heaps be?

Mostly secure heaps, but there have been work in the past with
specially aligned chunk heaps in the past. Unfortunately since every
vendor tree also include many of their own hacks to the core ION code
(usually without changelogs or comments) its hard to decipher much of
it.

Some examples:
msm:
https://github.com/Panchajanya1999/msm-4.14/blob/Pie/drivers/staging/android/ion/ion_cma_secure_heap.c

exynos:
https://github.com/exynos-linux-stable/starlte/tree/tw90-android-p/drivers/staging/android/ion/exynos

hisi:
https://github.com/hexdebug/android_kernel_huawei_hi3660/blob/master/drivers/staging/android/ion/ion_seccm_heap.c
https://github.com/hexdebug/android_kernel_huawei_hi3660/blob/master/drivers/staging/android/ion/ion_secsg_heap.c
https://github.com/hexdebug/android_kernel_huawei_hi3660/blob/master/drivers/staging/android/ion/ion_fama_misc_heap.c

mediatek:
https://android.googlesource.com/kernel/mediatek/+/android-mtk-3.18/drivers/staging/android/ion/mtk/ion_mm_heap.c

But Andrew's example is probably a better example against the dmabuf
heaps frameworks


> > That's why
> > dmabuf heaps is trying to destage ION in a way that allows heaps to
> > implement their exporter logic themselves, so we can start pulling
> > those more complicated heaps out of their vendor hidey-holes and get
> > some proper upstream review.
> >
> > But I suspect I just am confused as to what your suggesting. Maybe
> > could you expand a bit? Apologies for being a bit dense.
>
> My suggestion is to merge the system and CMA heaps.  CMA (at least
> the system-wide CMA area) is really just an optimization to get
> large contigous regions more easily.  We should make use of it as
> transparent as possible, just like we do in the DMA code.

I'm still not understanding how this would work. Benjamin and Laura
already commented on this point, but for a simple example, with the
HiKey boards, the DRM driver requires contiguous memory for the
framebuffer, but the GPU can handle non-contiguous. Thus the target
framebuffers that we pass to the display has to be CMA allocated, but
all the other graphics buffers that the GPU will render to and
composite can be system.

Having the separate heaps allows the gralloc code to allocate the
proper buffer depending on the planned usage (GRALLOC_USAGE_HW_FB or
not), and that way we don't waste CMA on buffers that don't have to be
contiguous.

Laura already touched on this, but similar logic can be used for
camera buffers, which can make sure we allocate from a specifically
reserved CMA region that is only used for the camera so we can always
be sure to have N free buffers immediately to capture with, etc.

But let me know if I'm still misunderstanding your suggestion.

thanks
-john
