Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84DDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894B62229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZuWolzEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbfHGQQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:16:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39845 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388257AbfHGQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:16:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so100534313otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ytzJIv3QNGK2vpGK5MfHZjc0QgFgcXjo88HR7/oqMA=;
        b=ZuWolzEzTTi6r9XQJ8T7T/obgl1vrSjpszk+SirQmYSfaiKAOopCaOL3uj2/ZeYDN3
         q1/SrxJ/WT7l8LX8St0gjRaKvz6kTJ/9FOa2sacVOtxH5/Lzdb9osA9oLZ3F8b0/9m/g
         4HGJjtU9zw8oCOcwegO9gIZy0dWA7GpPTHNa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ytzJIv3QNGK2vpGK5MfHZjc0QgFgcXjo88HR7/oqMA=;
        b=sHkDlyS6ZRR7vhEICAIpOR7plR6v0u6LU3197beDXnuZ4At4HZnXUPAaz0jaRdObnt
         axiVBQETxWYRAHvvZOLsVFErLR8/wilRJpjsG6G5eR/qLi3unopHjXWbw9IFEod+SV4Z
         sOOxU37FG22Vw3Dk3p8XYleWD1WNGmyQgCUfQEalSRb8zb3WXC/Pgoq+n9WAHAq/Isi+
         sphCjUdyfo+AGpGPYWzItmHuOah5YvCln5z4KQZzI0jm6ERJ0YndksPGNj1hXs+HTfyx
         Vaj5iPw6eTz5u22aitxHgeYxsBVru/mUurk3d795QtvuV5Ix1Ckf3ykriyiJWCncnR8G
         XTvw==
X-Gm-Message-State: APjAAAXKYYtbtuKHDiwiqeUoP+JVJyn3Yq8ekVy/3L5QZjAxKRZtMtpe
        fhtAWPM9Ft6s0OLg6n4/SnmDoc3bHGrY9la/zdzhpw==
X-Google-Smtp-Source: APXvYqxocs9JKmL6vxc8Hn2JrzxAo0kZaTAWxbkrPZVvQvVn85LVpyyqD/xT20Row4n7opcNt7YmbVv05FfX1D6hKFA=
X-Received: by 2002:a5e:924d:: with SMTP id z13mr9363595iop.247.1565194565095;
 Wed, 07 Aug 2019 09:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806143457.GF475@lakrids.cambridge.arm.com> <CAJs_Fx4h6SWGmDTLBnV4nmWUFAs_Ge1inxd-dW9aDKgKqmc1eQ@mail.gmail.com>
 <20190807123807.GD54191@lakrids.cambridge.arm.com>
In-Reply-To: <20190807123807.GD54191@lakrids.cambridge.arm.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Wed, 7 Aug 2019 09:15:54 -0700
Message-ID: <CAJs_Fx5xU2-dn3iOVqWTzAjpTaQ8BBNP_Gn_iMc-eJpOX+iXoQ@mail.gmail.com>
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

On Wed, Aug 7, 2019 at 5:38 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Aug 06, 2019 at 09:31:55AM -0700, Rob Clark wrote:
> > On Tue, Aug 6, 2019 at 7:35 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Tue, Aug 06, 2019 at 07:11:41AM -0700, Rob Clark wrote:
> > > > On Tue, Aug 6, 2019 at 1:48 AM Christoph Hellwig <hch@lst.de> wrote:
> > > > >
> > > > > This goes in the wrong direction.  drm_cflush_* are a bad API we need to
> > > > > get rid of, not add use of it.  The reason for that is two-fold:
> > > > >
> > > > >  a) it doesn't address how cache maintaince actually works in most
> > > > >     platforms.  When talking about a cache we three fundamental operations:
> > > > >
> > > > >         1) write back - this writes the content of the cache back to the
> > > > >            backing memory
> > > > >         2) invalidate - this remove the content of the cache
> > > > >         3) write back + invalidate - do both of the above
> > > >
> > > > Agreed that drm_cflush_* isn't a great API.  In this particular case
> > > > (IIUC), I need wb+inv so that there aren't dirty cache lines that drop
> > > > out to memory later, and so that I don't get a cache hit on
> > > > uncached/wc mmap'ing.
> > >
> > > Is there a cacheable alias lying around (e.g. the linear map), or are
> > > these addresses only mapped uncached/wc?
> > >
> > > If there's a cacheable alias, performing an invalidate isn't sufficient,
> > > since a CPU can allocate a new (clean) entry at any point in time (e.g.
> > > as a result of prefetching or arbitrary speculation).
> >
> > I *believe* that there are not alias mappings (that I don't control
> > myself) for pages coming from
> > shmem_file_setup()/shmem_read_mapping_page()..
>
> AFAICT, that's regular anonymous memory, so there will be a cacheable
> alias in the linear/direct map.

tbh, I'm not 100% sure whether there is a cacheable alias, or whether
any potential linear map is torn down.  My understanding is that a
cacheable alias is "ok", with some caveats.. ie. that the cacheable
alias is not accessed.  I'm not entirely sure about pre-fetch from
access to adjacent pages.  We have been using shmem as a source for
pages since the beginning, and I haven't seen it cause any problems in
the last 6 years.  (This is limited to armv7 and armv8, I'm not really
sure what would happen on armv6, but that is a combo I don't have to
care about.)

BR,
-R

> > digging around at what dma_sync_sg_* does under the hood, it looks
> > like it is just arch_sync_dma_for_cpu/device(), so I guess that should
> > be sufficient for what I need.
>
> I don't think that's the case, per the example I gave above.
>
> Thanks,
> Mark.
