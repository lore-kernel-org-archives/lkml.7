Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD4C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D879921848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568881332;
	bh=GdIZZlFGEjv0CJajsn6Bw6rMD+Npvpwr2YWM59KC5uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u8WzOOhXO5QkjkC5yCEW1zAJiZncL88cT0MJp2x/jDZfbXWucPVOAzab5H8j1MY0E
	 0q4ZabaEuMHrO/Na3Rs2xJyIL4LySpVQrEcH5/2SQV7fxLnlY60loMDyKzdSevKIby
	 S7+t3xInI9ZPoTfOFXIV/qEMWOqIRtaPHLM7VtXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfISIWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:22:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:44200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730886AbfISIWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:22:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A07A8AFBF;
        Thu, 19 Sep 2019 08:22:09 +0000 (UTC)
Date:   Thu, 19 Sep 2019 10:22:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Lin Feng <linf@wangsu.com>
Cc:     Matthew Wilcox <willy@infradead.org>, corbet@lwn.net,
        mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        keescook@chromium.org, mchehab+samsung@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] [RFC] vmscan.c: add a sysctl entry for controlling
 memory reclaim IO congestion_wait length
Message-ID: <20190919082208.GB15782@dhcp22.suse.cz>
References: <20190917115824.16990-1-linf@wangsu.com>
 <20190917120646.GT29434@bombadil.infradead.org>
 <20190918123342.GF12770@dhcp22.suse.cz>
 <6ae57d3e-a3f4-a3db-5654-4ec6001941a9@wangsu.com>
 <20190919034949.GF9880@bombadil.infradead.org>
 <33090db5-c7d4-8d7d-0082-ee7643d15775@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33090db5-c7d4-8d7d-0082-ee7643d15775@wangsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-09-19 15:46:11, Lin Feng wrote:
> 
> 
> On 9/19/19 11:49, Matthew Wilcox wrote:
> > On Thu, Sep 19, 2019 at 10:33:10AM +0800, Lin Feng wrote:
> > > On 9/18/19 20:33, Michal Hocko wrote:
> > > > I absolutely agree here. From you changelog it is also not clear what is
> > > > the underlying problem. Both congestion_wait and wait_iff_congested
> > > > should wake up early if the congestion is handled. Is this not the case?
> > > 
> > > For now I don't know why, codes seem should work as you said, maybe I need to
> > > trace more of the internals.
> > > But weird thing is that once I set the people-disliked-tunable iowait
> > > drop down instantly, this is contradictory to the code design.
> > 
> > Yes, this is quite strange.  If setting a smaller timeout makes a
> > difference, that indicates we're not waking up soon enough.  I see
> > two possibilities; one is that a wakeup is missing somewhere -- ie the
> > conditions under which we call clear_wb_congested() are wrong.  Or we
> > need to wake up sooner.
> > 
> > Umm.  We have clear_wb_congested() called from exactly one spot --
> > clear_bdi_congested().  That is only called from:
> > 
> > drivers/block/pktcdvd.c
> > fs/ceph/addr.c
> > fs/fuse/control.c
> > fs/fuse/dev.c
> > fs/nfs/write.c
> > 
> > Jens, is something supposed to be calling clear_bdi_congested() in the
> > block layer?  blk_clear_congested() used to exist until October 29th
> > last year.  Or is something else supposed to be waking up tasks that
> > are sleeping on congestion?
> > 
> 
> IIUC it looks like after commit a1ce35fa49852db60fc6e268038530be533c5b15,

This is something for Jens to comment on. Not waiting up on congestion
indeed sounds like a bug.

> besides those *.c places as you mentioned above, vmscan codes will always
> wait as long as 100ms and nobody wakes them up.

Yes this is true but you should realize that this path is triggered only
under heavy memory reclaim cases where there is nothing to reclaim
because there are too many pages already isolated and we are waiting for
reclaimers to make some progress on them. It is also possible that there
are simply no reclaimable pages at all and we are heading the OOM
situation. In both cases waiting a bit shouldn't be critical because
this is really a cold path. It would be much better to have a mechanism
to wake up earlier but this is likely to be non trivial and I am not
sure worth the effort considering how rare this should be.
-- 
Michal Hocko
SUSE Labs
