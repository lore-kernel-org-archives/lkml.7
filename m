Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87E9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0F3206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553687102;
	bh=Kio6SDYjK2T6k+leQ8Z8TPGLE4GYZBqVLuWHkNOstL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SD1CRB9lPwA9gfzrk253LNX6RfRgJAVCH857XdB7LytFoelPQri3nag62cbpZEBw8
	 yPy+2t51u4kl26HxYDsKrH/D5MIs+WLqU6cvJQlqCC+jdJTWwDixuO7McF2UaCP26F
	 GFd9NzYwaQ0IyxhI94deuMd1gwDXuYkg25sYnOSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfC0LpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:45:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbfC0LpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:45:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BD45AEF5;
        Wed, 27 Mar 2019 11:44:59 +0000 (UTC)
Date:   Wed, 27 Mar 2019 12:44:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com, cl@linux.com,
        willy@infradead.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190327114458.GF11927@dhcp22.suse.cz>
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
 <651bd879-c8c0-b162-fee7-1e523904b14e@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651bd879-c8c0-b162-fee7-1e523904b14e@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-03-19 07:34:32, Qian Cai wrote:
> On 3/27/19 4:44 AM, Michal Hocko wrote:
> >> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> >> index a2d894d3de07..7f4545ab1f84 100644
> >> --- a/mm/kmemleak.c
> >> +++ b/mm/kmemleak.c
> >> @@ -580,7 +580,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
> >>  	struct rb_node **link, *rb_parent;
> >>  	unsigned long untagged_ptr;
> >>  
> >> -	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> >> +	/*
> >> +	 * The tracked memory was allocated successful, if the kmemleak object
> >> +	 * failed to allocate for some reasons, it ends up with the whole
> >> +	 * kmemleak disabled, so try it harder.
> >> +	 */
> >> +	gfp = (in_atomic() || irqs_disabled()) ?
> >> +	       gfp_kmemleak_mask(gfp) | GFP_ATOMIC :
> >> +	       gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
> > 
> > 
> > The comment for in_atomic says:
> >  * Are we running in atomic context?  WARNING: this macro cannot
> >  * always detect atomic context; in particular, it cannot know about
> >  * held spinlocks in non-preemptible kernels.  Thus it should not be
> >  * used in the general case to determine whether sleeping is possible.
> >  * Do not use in_atomic() in driver code.
> 
> That is why it needs both in_atomic() and irqs_disabled(), so irqs_disabled()
> can detect kernel functions held spinlocks even in non-preemptible kernels.
> 
> According to [1],
> 
> "This [2] is useful if you know that the data in question is only ever
> manipulated from a "process context", ie no interrupts involved."
> 
> Since kmemleak only deal with kernel context, if a spinlock was held, it always
> has local interrupt disabled.

What? Normal spin lock implementation doesn't disable interrupts. So
either I misunderstand what you are saying or you seem to be confused.
the thing is that in_atomic relies on preempt_count to work properly and
if you have CONFIG_PREEMPT_COUNT=n then you simply never know whether
preemption is disabled so you do not know that a spin_lock is held.
irqs_disabled on the other hand checks whether arch specific flag for
IRQs handling is set (or cleared). So you would only catch irq safe spin
locks with the above check.

> ftrace is in the same boat where this commit was merged a while back that has
> the same check.
> 
> ef99b88b16be
> tracing: Handle ftrace_dump() atomic context in graph_trace_open()
> 
> [1] https://www.kernel.org/doc/Documentation/locking/spinlocks.txt
> [2]
> 	spin_lock(&lock);
> 	...
> 	spin_unlock(&lock);

-- 
Michal Hocko
SUSE Labs
