Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B954FC4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AFA21655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569327408;
	bh=SPtlLZ5dDWqCslzcANSB32luVHhiI7mSdlspYMVnyfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gG9OJouZEQSbdHEJF5rKgbOMXYHd9mE19MiUbA3BFlCVWTlphc0STCAd7ce3eXcFA
	 xoD+xvR2sAksVHFza3uB3TkAh8fWcycef+jUSKm71eSuzN84TjihopiIlsZjXF4qI4
	 ooO4zVxtLKy2D2h10/2OV8OHnCQkqMAoAfHy6ltY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfIXMQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:16:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:45420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbfIXMQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:16:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4609B97F;
        Tue, 24 Sep 2019 12:16:44 +0000 (UTC)
Date:   Tue, 24 Sep 2019 14:16:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, Lin Feng <linf@wangsu.com>,
        corbet@lwn.net, mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        keescook@chromium.org, mchehab+samsung@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: Is congestion broken?
Message-ID: <20190924121643.GO23050@dhcp22.suse.cz>
References: <20190917115824.16990-1-linf@wangsu.com>
 <20190917120646.GT29434@bombadil.infradead.org>
 <20190918123342.GF12770@dhcp22.suse.cz>
 <6ae57d3e-a3f4-a3db-5654-4ec6001941a9@wangsu.com>
 <20190919034949.GF9880@bombadil.infradead.org>
 <20190923111900.GH15392@bombadil.infradead.org>
 <45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk>
 <20190923194509.GC1855@bombadil.infradead.org>
 <ce7975cd-6353-3f29-b52c-7a81b1d07caa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce7975cd-6353-3f29-b52c-7a81b1d07caa@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-09-19 13:51:21, Jens Axboe wrote:
> On 9/23/19 1:45 PM, Matthew Wilcox wrote:
> > On Mon, Sep 23, 2019 at 01:38:23PM -0600, Jens Axboe wrote:
> >> On 9/23/19 5:19 AM, Matthew Wilcox wrote:
> >>>
> >>> Ping Jens?
> >>>
> >>> On Wed, Sep 18, 2019 at 08:49:49PM -0700, Matthew Wilcox wrote:
> >>>> On Thu, Sep 19, 2019 at 10:33:10AM +0800, Lin Feng wrote:
> >>>>> On 9/18/19 20:33, Michal Hocko wrote:
> >>>>>> I absolutely agree here. From you changelog it is also not clear what is
> >>>>>> the underlying problem. Both congestion_wait and wait_iff_congested
> >>>>>> should wake up early if the congestion is handled. Is this not the case?
> >>>>>
> >>>>> For now I don't know why, codes seem should work as you said, maybe I need to
> >>>>> trace more of the internals.
> >>>>> But weird thing is that once I set the people-disliked-tunable iowait
> >>>>> drop down instantly, this is contradictory to the code design.
> >>>>
> >>>> Yes, this is quite strange.  If setting a smaller timeout makes a
> >>>> difference, that indicates we're not waking up soon enough.  I see
> >>>> two possibilities; one is that a wakeup is missing somewhere -- ie the
> >>>> conditions under which we call clear_wb_congested() are wrong.  Or we
> >>>> need to wake up sooner.
> >>>>
> >>>> Umm.  We have clear_wb_congested() called from exactly one spot --
> >>>> clear_bdi_congested().  That is only called from:
> >>>>
> >>>> drivers/block/pktcdvd.c
> >>>> fs/ceph/addr.c
> >>>> fs/fuse/control.c
> >>>> fs/fuse/dev.c
> >>>> fs/nfs/write.c
> >>>>
> >>>> Jens, is something supposed to be calling clear_bdi_congested() in the
> >>>> block layer?  blk_clear_congested() used to exist until October 29th
> >>>> last year.  Or is something else supposed to be waking up tasks that
> >>>> are sleeping on congestion?
> >>
> >> Congestion isn't there anymore. It was always broken as a concept imho,
> >> since it was inherently racy. We used the old batching mechanism in the
> >> legacy stack to signal it, and it only worked for some devices.
> > 
> > Umm.  OK.  Well, something that used to work is now broken.  So how
> 
> It didn't really...

Maybe it would have been better to tell users who are using interface
that rely on this.
 
> > should we fix it?  Take a look at shrink_node() in mm/vmscan.c.  If we've
> > submitted a lot of writes to a device, and overloaded it, we want to
> > sleep until it's able to take more writes:
> > 
> >                  /*
> >                   * Stall direct reclaim for IO completions if underlying BDIs
> >                   * and node is congested. Allow kswapd to continue until it
> >                   * starts encountering unqueued dirty pages or cycling through
> >                   * the LRU too quickly.
> >                   */
> >                  if (!sc->hibernation_mode && !current_is_kswapd() &&
> >                     current_may_throttle() && pgdat_memcg_congested(pgdat, root))
> >                          wait_iff_congested(BLK_RW_ASYNC, HZ/10);
> > 
> > With a standard block device, that now sleeps until the timeout (100ms)
> > expires, which is far too long for a modern SSD but is probably tuned
> > just right for some legacy piece of spinning rust (or indeed a modern
> > USB stick).  How would the block layer like to indicate to the mm layer
> > "I am too busy, please let the device work for a bit"?
> 
> Maybe base the sleep on the bdi write speed? We can't feasibly tell you
> if something is congested. It used to sort of work on things like sata
> drives, since we'd get congested when we hit the queue limit and that
> wasn't THAT far off with reality. Didn't work on SCSI with higher queue
> depths, and certainly doesn't work on NVMe where most devices have very
> deep queues.
> 
> Or we can have something that does "sleep until X requests/MB have been
> flushed", something that the vm would actively call. Combined with a
> timeout as well, probably.
> 
> For the vm case above, it's further complicated by it being global
> state. I think you'd be better off just making the delay smaller.  100ms
> is an eternity, and 10ms wakeups isn't going to cause any major issues
> in terms of CPU usage. If we're calling the above wait_iff_congested(),
> it better because we're otherwise SOL.

I do not mind using a shorter sleeps. A downside would be that very slow
storages could go OOM sooner because we do not wait long enough on one
side or reintroducing stalls during direct reclaim fixed by 0e093d99763eb.

I do agree that our poor's man congestion feedback mechanism is far from
being great. It would be really great to have something more resembling
a real feedback though. The global aspect of the thing is surely not
helping much but the reclaim is encountering pages from different bdis
and accounting each of them sounds like an overkill and too elaborate to
implement. Would it be possible to have something like "throttle on at
least one too busy bdi"?
-- 
Michal Hocko
SUSE Labs
