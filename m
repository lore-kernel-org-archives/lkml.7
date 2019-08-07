Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE71C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2F22229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbfHGQuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:50:07 -0400
Received: from foss.arm.com ([217.140.110.172]:51976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387967AbfHGQuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:50:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7600C344;
        Wed,  7 Aug 2019 09:50:06 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 711623F694;
        Wed,  7 Aug 2019 09:50:04 -0700 (PDT)
Date:   Wed, 7 Aug 2019 17:49:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Clark <robdclark@chromium.org>
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
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
Message-ID: <20190807164958.GA44765@lakrids.cambridge.arm.com>
References: <20190805211451.20176-1-robdclark@gmail.com>
 <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806143457.GF475@lakrids.cambridge.arm.com>
 <CAJs_Fx4h6SWGmDTLBnV4nmWUFAs_Ge1inxd-dW9aDKgKqmc1eQ@mail.gmail.com>
 <20190807123807.GD54191@lakrids.cambridge.arm.com>
 <CAJs_Fx5xU2-dn3iOVqWTzAjpTaQ8BBNP_Gn_iMc-eJpOX+iXoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs_Fx5xU2-dn3iOVqWTzAjpTaQ8BBNP_Gn_iMc-eJpOX+iXoQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 09:15:54AM -0700, Rob Clark wrote:
> On Wed, Aug 7, 2019 at 5:38 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Aug 06, 2019 at 09:31:55AM -0700, Rob Clark wrote:
> > > On Tue, Aug 6, 2019 at 7:35 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Tue, Aug 06, 2019 at 07:11:41AM -0700, Rob Clark wrote:
> > > > > On Tue, Aug 6, 2019 at 1:48 AM Christoph Hellwig <hch@lst.de> wrote:
> > > > > >
> > > > > > This goes in the wrong direction.  drm_cflush_* are a bad API we need to
> > > > > > get rid of, not add use of it.  The reason for that is two-fold:
> > > > > >
> > > > > >  a) it doesn't address how cache maintaince actually works in most
> > > > > >     platforms.  When talking about a cache we three fundamental operations:
> > > > > >
> > > > > >         1) write back - this writes the content of the cache back to the
> > > > > >            backing memory
> > > > > >         2) invalidate - this remove the content of the cache
> > > > > >         3) write back + invalidate - do both of the above
> > > > >
> > > > > Agreed that drm_cflush_* isn't a great API.  In this particular case
> > > > > (IIUC), I need wb+inv so that there aren't dirty cache lines that drop
> > > > > out to memory later, and so that I don't get a cache hit on
> > > > > uncached/wc mmap'ing.
> > > >
> > > > Is there a cacheable alias lying around (e.g. the linear map), or are
> > > > these addresses only mapped uncached/wc?
> > > >
> > > > If there's a cacheable alias, performing an invalidate isn't sufficient,
> > > > since a CPU can allocate a new (clean) entry at any point in time (e.g.
> > > > as a result of prefetching or arbitrary speculation).
> > >
> > > I *believe* that there are not alias mappings (that I don't control
> > > myself) for pages coming from
> > > shmem_file_setup()/shmem_read_mapping_page()..
> >
> > AFAICT, that's regular anonymous memory, so there will be a cacheable
> > alias in the linear/direct map.
> 
> tbh, I'm not 100% sure whether there is a cacheable alias, or whether
> any potential linear map is torn down.

I'm fairly confident that the linear/direct map cacheable alias is not
torn down when pages are allocated. The gneeric page allocation code
doesn't do so, and I see nothing the shmem code to do so.

For arm64, we can tear down portions of the linear map, but that has to
be done explicitly, and this is only possible when using rodata_full. If
not using rodata_full, it is not possible to dynamically tear down the
cacheable alias.

> My understanding is that a cacheable alias is "ok", with some
> caveats.. ie. that the cacheable alias is not accessed.  

Unfortunately, that is not true. You'll often get away with it in
practice, but that's a matter of probability rather than a guarantee.

You  cannot prevent a CPU from accessing a VA arbitrarily (e.g. as the
result of wild speculation). The ARM ARM (ARM DDI 0487E.a) points this
out explicitly:

| Entries for addresses that are Normal Cacheable can be allocated to
| the cache at any time, and so the cache invalidate instruction cannot
| ensure that the address is not present in a cache.

... along with:

| Caches introduce a number of potential problems, mainly because:
|
| * Memory accesses can occur at times other than when the programmer
|   would expect them.

;)

> I'm not entirely sure about pre-fetch from access to adjacent pages.
> We have been using shmem as a source for pages since the beginning,
> and I haven't seen it cause any problems in the last 6 years.  (This
> is limited to armv7 and armv8, I'm not really sure what would happen
> on armv6, but that is a combo I don't have to care about.)

Over time, CPUs get more aggressive w.r.t. prefetching and speculation,
so having not seen such issues in the past does not imply we won't in
future.

Anecdotally, we had an issue a few years ago that we were only able to
reproduce under heavy stress testing. A CPU would make speculative
instruction fetches from a read-destructive MMIO register, despite the
PC never going near the corresponding VA, and despite that code having
(apparently) caused no issue for years before that.

See commit:

  b6ccb9803e90c16b ("ARM: 7954/1: mm: remove remaining domain support from ARMv6")

... which unfortunately lacks the full war story.

Thanks,
Mark.
