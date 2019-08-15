Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA05C3A59B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824032086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565895932;
	bh=vL6Cs8B++Iqbbp4CmUzhrnpbMk0LJlIJR7D4aWeerKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J7QIlsZGmrvGdFW1Vt+P3npFJDjjyRTi4AJXBreSY51yReyO0G7KrcAs+GmGv9ye9
	 cVYF3mXF08DwrJisNbB1EQ1KQYwEV1aTIuBQaaCg20ZV5ArxfRaTv45jFCq3sD3wll
	 xd+3yTxpfP48pCLnqo/MJ7J8yuzivNb5TrLhp4og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfHOTFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:05:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729407AbfHOTFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:05:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C095AD72;
        Thu, 15 Aug 2019 19:05:28 +0000 (UTC)
Date:   Thu, 15 Aug 2019 21:05:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190815190525.GS9477@dhcp22.suse.cz>
References: <20190814202027.18735-3-daniel.vetter@ffwll.ch>
 <20190814235805.GB11200@ziepe.ca>
 <20190815065829.GA7444@phenom.ffwll.local>
 <20190815122344.GA21596@ziepe.ca>
 <20190815132127.GI9477@dhcp22.suse.cz>
 <20190815141219.GF21596@ziepe.ca>
 <20190815155950.GN9477@dhcp22.suse.cz>
 <20190815165631.GK21596@ziepe.ca>
 <20190815174207.GR9477@dhcp22.suse.cz>
 <20190815182448.GP21596@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815182448.GP21596@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-08-19 15:24:48, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2019 at 07:42:07PM +0200, Michal Hocko wrote:
> > On Thu 15-08-19 13:56:31, Jason Gunthorpe wrote:
> > > On Thu, Aug 15, 2019 at 06:00:41PM +0200, Michal Hocko wrote:
> > > 
> > > > > AFAIK 'GFP_NOWAIT' is characterized by the lack of __GFP_FS and
> > > > > __GFP_DIRECT_RECLAIM..
> > > > >
> > > > > This matches the existing test in __need_fs_reclaim() - so if you are
> > > > > OK with GFP_NOFS, aka __GFP_IO which triggers try_to_compact_pages(),
> > > > > allocations during OOM, then I think fs_reclaim already matches what
> > > > > you described?
> > > > 
> > > > No GFP_NOFS is equally bad. Please read my other email explaining what
> > > > the oom_reaper actually requires. In short no blocking on direct or
> > > > indirect dependecy on memory allocation that might sleep.
> > > 
> > > It is much easier to follow with some hints on code, so the true
> > > requirement is that the OOM repear not block on GFP_FS and GFP_IO
> > > allocations, great, that constraint is now clear.
> > 
> > I still do not get why do you put FS/IO into the picture. This is really
> > about __GFP_DIRECT_RECLAIM.
> 
> Like I said this is complicated, translating "no blocking on direct or
> indirect dependecy on memory allocation that might sleep" into GFP
> flags is hard for us outside the mm community.
> 
> So the contraint here is no __GFP_DIRECT_RECLAIM?

OK, I am obviously failing to explain that. Sorry about that. You are
right that this is not simple. Let me try again.

The context we are calling !blockable notifiers from has to finish in a
_finite_ amount of time (and swift is hugely appreciated by users of
otherwise non-responsive system that is under OOM). We are out of memory
so we cannot be blocked waiting for memory. Directly or indirectly (via
a lock, waiting for an event that needs memory to finish in general). So
you need to track dependency over more complicated contexts than the
direct call path (think of workqueue for example).

> I bring up FS/IO because that is what Tejun mentioned when I asked him
> about reclaim restrictions, and is what fs_reclaim_acquire() is
> already sensitive too. It is pretty confusing if we have places using
> the word 'reclaim' with different restrictions. :(

fs_reclaim has been invented to catch potential deadlocks when a
GFP_NO{FS/IO} allocation hits into fs/io reclaim. This is a subset of
the reclaim that we have. The oom context is more restricted and it
cannot depend on _any_ memory reclaim because by the time we have got to
this context all the reclaim has already failed and wait some more will
simply not help.

> > >        CPU0                                 CPU1
> > >                                         mutex_lock()
> > >                                         kmalloc(GFP_KERNEL)
> > 
> > no I mean __GFP_DIRECT_RECLAIM here.
> > 
> > >                                         mutex_unlock()
> > >   fs_reclaim_acquire()
> > >   mutex_lock() <- illegal: lock dep assertion
> > 
> > I cannot really comment on how that is achieveable by lockdep.
> 
> ??? I am trying to explain this is already done and working today. The
> above example will already fault with lockdep enabled.
> 
> This is existing debugging we can use and improve upon rather that
> invent new debugging.

This is what you claim and I am saying that fs_reclaim is about a
restricted reclaim context and it is an ugly hack. It has proven to
report false positives. Maybe it can be extended to a generic reclaim.
I haven't tried that. Do not aim to try it.
-- 
Michal Hocko
SUSE Labs
