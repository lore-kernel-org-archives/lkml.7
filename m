Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4A2C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB43420673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g1nbejpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502299AbfIWTpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:45:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfIWTpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T1wJieVaGSw4lrkxEJrL75LlxCo53ZqCpjN+xiCeBz8=; b=g1nbejpoexev69wtsvisH4Osm
        brLtMi6HvXX6Ax3zVt39fQ8/JNWMV0C7C07CJ/YZMiFFEQhbf7ibX5hLf2mVvTj9LF95yLY6rMPsa
        dx6SrWL9uAUf/SRVJ4q/ULpWzw/RdMAYnp7HLSTEVi4IHWSZxWg7LG3uQGEbP4jjupy/OR6PUNZfQ
        Pq43gOnI9oaW0CrDNUehEaVArnHBvia3krsGo4CY+xUbh7RrZctDY6trAQir3aY5Ke/RZ2jls2VDa
        beG65sms9r5lgsNG3CNlluxt4/HufjcAz+ixMe5hvE8ZRs+TSX/4pgBSulMFzG50MvQKP70eDATuG
        9fTP0e5Yg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCUGj-00046c-3r; Mon, 23 Sep 2019 19:45:09 +0000
Date:   Mon, 23 Sep 2019 12:45:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Lin Feng <linf@wangsu.com>, Michal Hocko <mhocko@kernel.org>,
        corbet@lwn.net, mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        keescook@chromium.org, mchehab+samsung@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: Is congestion broken?
Message-ID: <20190923194509.GC1855@bombadil.infradead.org>
References: <20190917115824.16990-1-linf@wangsu.com>
 <20190917120646.GT29434@bombadil.infradead.org>
 <20190918123342.GF12770@dhcp22.suse.cz>
 <6ae57d3e-a3f4-a3db-5654-4ec6001941a9@wangsu.com>
 <20190919034949.GF9880@bombadil.infradead.org>
 <20190923111900.GH15392@bombadil.infradead.org>
 <45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 01:38:23PM -0600, Jens Axboe wrote:
> On 9/23/19 5:19 AM, Matthew Wilcox wrote:
> > 
> > Ping Jens?
> > 
> > On Wed, Sep 18, 2019 at 08:49:49PM -0700, Matthew Wilcox wrote:
> >> On Thu, Sep 19, 2019 at 10:33:10AM +0800, Lin Feng wrote:
> >>> On 9/18/19 20:33, Michal Hocko wrote:
> >>>> I absolutely agree here. From you changelog it is also not clear what is
> >>>> the underlying problem. Both congestion_wait and wait_iff_congested
> >>>> should wake up early if the congestion is handled. Is this not the case?
> >>>
> >>> For now I don't know why, codes seem should work as you said, maybe I need to
> >>> trace more of the internals.
> >>> But weird thing is that once I set the people-disliked-tunable iowait
> >>> drop down instantly, this is contradictory to the code design.
> >>
> >> Yes, this is quite strange.  If setting a smaller timeout makes a
> >> difference, that indicates we're not waking up soon enough.  I see
> >> two possibilities; one is that a wakeup is missing somewhere -- ie the
> >> conditions under which we call clear_wb_congested() are wrong.  Or we
> >> need to wake up sooner.
> >>
> >> Umm.  We have clear_wb_congested() called from exactly one spot --
> >> clear_bdi_congested().  That is only called from:
> >>
> >> drivers/block/pktcdvd.c
> >> fs/ceph/addr.c
> >> fs/fuse/control.c
> >> fs/fuse/dev.c
> >> fs/nfs/write.c
> >>
> >> Jens, is something supposed to be calling clear_bdi_congested() in the
> >> block layer?  blk_clear_congested() used to exist until October 29th
> >> last year.  Or is something else supposed to be waking up tasks that
> >> are sleeping on congestion?
> 
> Congestion isn't there anymore. It was always broken as a concept imho,
> since it was inherently racy. We used the old batching mechanism in the
> legacy stack to signal it, and it only worked for some devices.

Umm.  OK.  Well, something that used to work is now broken.  So how
should we fix it?  Take a look at shrink_node() in mm/vmscan.c.  If we've
submitted a lot of writes to a device, and overloaded it, we want to
sleep until it's able to take more writes:

                /*
                 * Stall direct reclaim for IO completions if underlying BDIs
                 * and node is congested. Allow kswapd to continue until it
                 * starts encountering unqueued dirty pages or cycling through
                 * the LRU too quickly.
                 */
                if (!sc->hibernation_mode && !current_is_kswapd() &&
                   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
                        wait_iff_congested(BLK_RW_ASYNC, HZ/10);

With a standard block device, that now sleeps until the timeout (100ms)
expires, which is far too long for a modern SSD but is probably tuned
just right for some legacy piece of spinning rust (or indeed a modern
USB stick).  How would the block layer like to indicate to the mm layer
"I am too busy, please let the device work for a bit"?
