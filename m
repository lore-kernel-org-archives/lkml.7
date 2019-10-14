Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B25CECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45041217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571070628;
	bh=aGuqZDNdhA5aKb0g/cBtL0w++5aTb33V6NKZQsKNzsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=beIVPZVP/uIWtJQvcpCv9o6CAmZTZxCweDckYZY6v+FQyMR0JtLt/7bj1+OZ9XulZ
	 Eqr49CVPcHixz8it9vBNN/l2FvXmLsHefE82a1DUt/fxmJ8tjEgli6jXdhtGK4Mgp7
	 w1PXwDkMzzbKiRNFfrdVZZKdn3ba4eDKjyPtmi4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfJNQa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:30:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:38358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfJNQa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:30:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57697AC8E;
        Mon, 14 Oct 2019 16:30:24 +0000 (UTC)
Date:   Mon, 14 Oct 2019 18:30:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-ID: <20191014163022.GL317@dhcp22.suse.cz>
References: <20191009164934.10166-1-urezki@gmail.com>
 <20191009151901.1be5f7211db291e4bd2da8ca@linux-foundation.org>
 <20191009221725.0b83151e@oasis.local.home>
 <20191010151749.GA14740@pc636>
 <20191011165515.a25e7d1c22e6b5e3e6fb69da@linux-foundation.org>
 <20191014142719.GA17874@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014142719.GA17874@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-10-19 16:27:19, Uladzislau Rezki wrote:
> On Fri, Oct 11, 2019 at 04:55:15PM -0700, Andrew Morton wrote:
> > On Thu, 10 Oct 2019 17:17:49 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > > > > : 	 * The preload is done in non-atomic context, thus it allows us
> > > > > : 	 * to use more permissive allocation masks to be more stable under
> > > > > : 	 * low memory condition and high memory pressure.
> > > > > : 	 *
> > > > > : 	 * Even if it fails we do not really care about that. Just proceed
> > > > > : 	 * as it is. "overflow" path will refill the cache we allocate from.
> > > > > : 	 */
> > > > > : 	if (!this_cpu_read(ne_fit_preload_node)) {
> > > > > 
> > > > > Readability nit: local `pva' should be defined here, rather than having
> > > > > function-wide scope.
> > > > > 
> > > > > : 		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> > > > > 
> > > > > Why doesn't this honour gfp_mask?  If it's not a bug, please add
> > > > > comment explaining this.
> > > > > 
> > > But there is a comment, if understand you correctly:
> > > 
> > > <snip>
> > > * Even if it fails we do not really care about that. Just proceed
> > > * as it is. "overflow" path will refill the cache we allocate from.
> > > <snip>
> > 
> > My point is that the alloc_vmap_area() caller passed us a gfp_t but
> > this code ignores it, as does adjust_va_to_fit_type().  These *look*
> > like potential bugs.  If not, they should be commented so they don't
> > look like bugs any more ;)
> > 
> I got it, there was misunderstanding from my side :) I agree.
> 
> In the first case i should have used and respect the passed "gfp_mask",
> like below:
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index f48cd0711478..880b6e8cdeae 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1113,7 +1113,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>                  * Just proceed as it is. If needed "overflow" path
>                  * will refill the cache we allocate from.
>                  */
> -               pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> +               pva = kmem_cache_alloc_node(vmap_area_cachep,
> +                               gfp_mask & GFP_RECLAIM_MASK, node);
>  
>         spin_lock(&vmap_area_lock);
> 
> It should be sent as a separate patch, i think.

Yes. I do not think this would make any real difference because that
battle is lost long ago. vmalloc is simply not gfp mask friendly. There
are places like page table allocation which are hardcoded GFP_KERNEL so
GFP_NOWAIT semantic is not going to work, really. The above makes sense
from a pure aesthetic POV, though, I would say.
-- 
Michal Hocko
SUSE Labs
