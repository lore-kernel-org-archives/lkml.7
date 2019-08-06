Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3B5C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F46E208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PaNovIOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbfHFQcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:32:07 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39015 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbfHFQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:32:06 -0400
Received: by mail-ua1-f66.google.com with SMTP id j8so33860109uan.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJV0VVyb7OBSwrj4NQkfWBYcw+e0SGu2TpYvncrxquQ=;
        b=PaNovIOOce5SiqO4ZfKl84Pa4yv0mSqVy5C30RPobTjNSM7clsyNQbQ/vhelfWggU9
         NgsFUrCfnnyuoAdH13iul7qyQW+rfYTpPfBbokbf4T3tjfWMbJTP7PDBLdM2atX1U17L
         kqJ0ZreL5023LO6c/T/0E/lD7i0AsyjbuCbI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJV0VVyb7OBSwrj4NQkfWBYcw+e0SGu2TpYvncrxquQ=;
        b=Br25eRa4EmpfraGiMKIsZQS0ojq7PvqUaUqZ432HCApB3f/nQ2vSp7ZFWBZr35l2DD
         CuyRLlLOl6zzS1fAFu/hwWciWA0pwQvZ8H12rrHl0PFGxxeA8pRY7mzMcR33kbrHIIhj
         flj8yVMVwZThzFXgbwl8BJEBzmmegcqyTh+mIf3DI6daHdQR999E3aEmgScoO/ITItXx
         47Zw92AoAhaW5oyDjWlf9b/7RP020QAwWqxTbMJsJIP9DmhlgO12fkrV4sYASK5AWl1T
         XY9Sq974xmfzMWQAQbwzPnrB8ftzE5bQLB6np5BPy4kj0DV0ejGTv42hGIYnCKEfVYG7
         9Pqw==
X-Gm-Message-State: APjAAAVQoGY/sAdIYOGd0MXKJQuBWzviuiLGpJOJ3Pw8AFyL++uxnnnN
        6okzv8Wycb98PBL2tP5NcY67f2z9EygchGZtXxgZKA==
X-Google-Smtp-Source: APXvYqxN7Za8djlBzCs0iQ70yJGGaDd0xjSmac554wXuA65p9UMe7pqTUjduNocumSHig7Qa6Mhlgd8Iif02bjhVezI=
X-Received: by 2002:ab0:66d2:: with SMTP id d18mr1393892uaq.101.1565109125884;
 Tue, 06 Aug 2019 09:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com> <20190806143457.GF475@lakrids.cambridge.arm.com>
In-Reply-To: <20190806143457.GF475@lakrids.cambridge.arm.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 6 Aug 2019 09:31:55 -0700
Message-ID: <CAJs_Fx4h6SWGmDTLBnV4nmWUFAs_Ge1inxd-dW9aDKgKqmc1eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@gmail.com>,
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

On Tue, Aug 6, 2019 at 7:35 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Aug 06, 2019 at 07:11:41AM -0700, Rob Clark wrote:
> > On Tue, Aug 6, 2019 at 1:48 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > This goes in the wrong direction.  drm_cflush_* are a bad API we need to
> > > get rid of, not add use of it.  The reason for that is two-fold:
> > >
> > >  a) it doesn't address how cache maintaince actually works in most
> > >     platforms.  When talking about a cache we three fundamental operations:
> > >
> > >         1) write back - this writes the content of the cache back to the
> > >            backing memory
> > >         2) invalidate - this remove the content of the cache
> > >         3) write back + invalidate - do both of the above
> >
> > Agreed that drm_cflush_* isn't a great API.  In this particular case
> > (IIUC), I need wb+inv so that there aren't dirty cache lines that drop
> > out to memory later, and so that I don't get a cache hit on
> > uncached/wc mmap'ing.
>
> Is there a cacheable alias lying around (e.g. the linear map), or are
> these addresses only mapped uncached/wc?
>
> If there's a cacheable alias, performing an invalidate isn't sufficient,
> since a CPU can allocate a new (clean) entry at any point in time (e.g.
> as a result of prefetching or arbitrary speculation).

I *believe* that there are not alias mappings (that I don't control
myself) for pages coming from
shmem_file_setup()/shmem_read_mapping_page()..  digging around at what
dma_sync_sg_* does under the hood, it looks like it is just
arch_sync_dma_for_cpu/device(), so I guess that should be sufficient
for what I need.

There are a few buffers that I vmap for use on kernel side, but like
the userspace mmap's, the vmaps are also writecombine.

BR,
-R
