Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE8CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA922229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FffiqU5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbfHGRaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:30:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40658 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389025AbfHGRaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:30:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so50220558oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GvSVwyjYkUWZmzb2UwP5yi6JZ1ykYGY6rFaP7/aYTLo=;
        b=FffiqU5+eIuv8kGlzf37a45hctKBFrPl36bD6mU5CnzC9YL5qpM893c3kSRhakuQZQ
         X4takvwHuxy5NPQWSrC6jaQkzchWaUx1B2uc3JsY5zG+8FLgsHbhVsLvlRlGDAQ4kKoH
         5jmnc8EUa0XC26IRhxOfNVAFjlUJkw0FvWnMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvSVwyjYkUWZmzb2UwP5yi6JZ1ykYGY6rFaP7/aYTLo=;
        b=ufmMEPdkhkwlTQqXnOHhB3LpsnNDp42MsZo2UTZwiirB9pWCbmbrdxODhdzTtuFEss
         NmhXISdIBaD0SkCkacY6OK8UiJZB8mkCVwx/q7XOG9NA6XsulfoRSNu3T0rs4DGqh3l4
         CAF8F3lbgvtmuDYd+tuCnrCH2nzeaw3mAn8nEChG+tYBYYEHVzo+H7YTxTFCuQnz2x+h
         U4gu3pOOpaeYIqpNEsKJiFThLoUWSABYI3D/nuHxZPSfSHjU+nm88GOhS40IP6tc4qoZ
         xe4D6mZIrfd4PsAjq1T2PfMLGbsn0kWyKDTUn20GUoyeG88T67fsiQ4aUj/4rPNUVIl/
         YX1A==
X-Gm-Message-State: APjAAAWs9s3TPhWGLENvPVZMIepHyTMBuv5jP3qBNTwflPoZbWzwUoU+
        CbkE1QG1oSNr1X5ePWdztHSp45qIFpJyckpDfhnzJw==
X-Google-Smtp-Source: APXvYqw7RRBjKPo7ZfZEtmV59ny/ac5jMKhz6wAq19P1RhtP8uwSeSEl2cXGsfsujsBrMkrSAoT5zOfXD+sPwaeHIv8=
X-Received: by 2002:a6b:90c1:: with SMTP id s184mr10120928iod.244.1565199015080;
 Wed, 07 Aug 2019 10:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806143457.GF475@lakrids.cambridge.arm.com> <CAJs_Fx4h6SWGmDTLBnV4nmWUFAs_Ge1inxd-dW9aDKgKqmc1eQ@mail.gmail.com>
 <20190807123807.GD54191@lakrids.cambridge.arm.com> <CAJs_Fx5xU2-dn3iOVqWTzAjpTaQ8BBNP_Gn_iMc-eJpOX+iXoQ@mail.gmail.com>
 <20190807164958.GA44765@lakrids.cambridge.arm.com>
In-Reply-To: <20190807164958.GA44765@lakrids.cambridge.arm.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Wed, 7 Aug 2019 10:30:04 -0700
Message-ID: <CAJs_Fx71T=kJEgt28TWqzw+jOahSbLQynCg83+szQW7op4xBkQ@mail.gmail.com>
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

On Wed, Aug 7, 2019 at 9:50 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Aug 07, 2019 at 09:15:54AM -0700, Rob Clark wrote:
> > On Wed, Aug 7, 2019 at 5:38 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Tue, Aug 06, 2019 at 09:31:55AM -0700, Rob Clark wrote:
> > > > On Tue, Aug 6, 2019 at 7:35 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > >
> > > > > On Tue, Aug 06, 2019 at 07:11:41AM -0700, Rob Clark wrote:
> > > > > > On Tue, Aug 6, 2019 at 1:48 AM Christoph Hellwig <hch@lst.de> wrote:
> > > > > > >
> > > > > > > This goes in the wrong direction.  drm_cflush_* are a bad API we need to
> > > > > > > get rid of, not add use of it.  The reason for that is two-fold:
> > > > > > >
> > > > > > >  a) it doesn't address how cache maintaince actually works in most
> > > > > > >     platforms.  When talking about a cache we three fundamental operations:
> > > > > > >
> > > > > > >         1) write back - this writes the content of the cache back to the
> > > > > > >            backing memory
> > > > > > >         2) invalidate - this remove the content of the cache
> > > > > > >         3) write back + invalidate - do both of the above
> > > > > >
> > > > > > Agreed that drm_cflush_* isn't a great API.  In this particular case
> > > > > > (IIUC), I need wb+inv so that there aren't dirty cache lines that drop
> > > > > > out to memory later, and so that I don't get a cache hit on
> > > > > > uncached/wc mmap'ing.
> > > > >
> > > > > Is there a cacheable alias lying around (e.g. the linear map), or are
> > > > > these addresses only mapped uncached/wc?
> > > > >
> > > > > If there's a cacheable alias, performing an invalidate isn't sufficient,
> > > > > since a CPU can allocate a new (clean) entry at any point in time (e.g.
> > > > > as a result of prefetching or arbitrary speculation).
> > > >
> > > > I *believe* that there are not alias mappings (that I don't control
> > > > myself) for pages coming from
> > > > shmem_file_setup()/shmem_read_mapping_page()..
> > >
> > > AFAICT, that's regular anonymous memory, so there will be a cacheable
> > > alias in the linear/direct map.
> >
> > tbh, I'm not 100% sure whether there is a cacheable alias, or whether
> > any potential linear map is torn down.
>
> I'm fairly confident that the linear/direct map cacheable alias is not
> torn down when pages are allocated. The gneeric page allocation code
> doesn't do so, and I see nothing the shmem code to do so.
>
> For arm64, we can tear down portions of the linear map, but that has to
> be done explicitly, and this is only possible when using rodata_full. If
> not using rodata_full, it is not possible to dynamically tear down the
> cacheable alias.

So, we do end up using GFP_HIGHUSER, which appears to get passed thru
when shmem gets to the point of actually allocating pages.. not sure
if that just ends up being a hint, or if it guarantees that we don't
get something in the linear map.

(Bear with me while I "page" this all back in.. last time I dug thru
the shmem code was probably pre-armv8, or at least before I had any
armv8 hw)

BR,
-R
