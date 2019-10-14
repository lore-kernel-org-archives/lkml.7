Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0958DC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2A02089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUOZyqvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbfJNOaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:30:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39907 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:30:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so16867590ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4KnYoOPPFHv3dN60JOLlRL3+ZtlpFRy9C6DeF61vf5c=;
        b=OUOZyqvx29wH7rc3CvwAuaIZ+GQ5KtGKHC0FM4FK3djf6hvWrK015gRit7CP83xlYW
         PgsYPJjieD53vd1HTelsUN1NVCHikg2pCv0EUbmhuNqceogGNPCkp+VWVw9yL8E8aHee
         fSm25qBu/KNV8xLQh17zvJ1HwykkS/SqGylohlpxqHOtAAKTMqmwCe/6x+thl45pyPwh
         RRqB7WqoT1bDxdQG4REZJA8R6d3J5X+l0n/RMZPbi3IlC+jveOSx3d5b8yxZrhcolGhl
         elHE7DeDFv0rJNdYqYav3e+K9Rt166V10VmXpuJ9a6n/7hBnvM5q7GM2ts2FvqwZalVd
         OAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4KnYoOPPFHv3dN60JOLlRL3+ZtlpFRy9C6DeF61vf5c=;
        b=JVZKjTUviCdjZhgv1xTD6LsRsZpC3hGPh6dtkA82VD1fBkhmzxpI4TzTU5cHlzAFnr
         fbfgEM5dzr45EqdGjt2jldXYyLmgXSMA2aJRYkYGHebsNdDvcLwgI5CX77gIOuVAYdzv
         qZu7msaV6PmKW5XXr/yrAZsf3SpCoODLbDN/zD3hlJT9evOTuSad44VlNoQahTRetwaa
         JwSp+Fxc+8WagqRmGlhcZq3a/7vKDmlYUt1OCUEqxBRSHJo4jxn8adj7wbIS0kIY/BVq
         XBNi/vRU4Rq+dEFSwKT46rK3QRUc7vmPLA7J5eHLTki8lnXZSyY38ZTL+5GW0RI/I8JF
         WJuw==
X-Gm-Message-State: APjAAAWyx1sBQ8cBatNcoKbWzJxJhlL50GjLED0S/Jtxpfu7tjuz2fmd
        Pjfs7LvR7GDBURjOdDLfstE=
X-Google-Smtp-Source: APXvYqy3orK/l+Ogj4KsrJzIOsl0EmsAJXTu6NSe1IuG36oa+BnGsDcPb7RoF3bstoEHQhUJMstC3g==
X-Received: by 2002:a2e:8e87:: with SMTP id z7mr16735369ljk.207.1571063406842;
        Mon, 14 Oct 2019 07:30:06 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id t25sm4231134ljj.93.2019.10.14.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:30:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 14 Oct 2019 16:30:03 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/1] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-ID: <20191014143003.GB17874@pc636>
References: <20191010223318.28115-1-urezki@gmail.com>
 <20191014131308.GG317@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014131308.GG317@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 03:13:08PM +0200, Michal Hocko wrote:
> On Fri 11-10-19 00:33:18, Uladzislau Rezki (Sony) wrote:
> > Get rid of preempt_disable() and preempt_enable() when the
> > preload is done for splitting purpose. The reason is that
> > calling spin_lock() with disabled preemtion is forbidden in
> > CONFIG_PREEMPT_RT kernel.
> 
> I think it would be really helpful to describe why the preemption was
> disabled in that path. Some of that is explained in the comment but the
> changelog should mention that explicitly.
>  
Will do that, makes sense.

> > Therefore, we do not guarantee that a CPU is preloaded, instead
> > we minimize the case when it is not with this change.
> > 
> > For example i run the special test case that follows the preload
> > pattern and path. 20 "unbind" threads run it and each does
> > 1000000 allocations. Only 3.5 times among 1000000 a CPU was
> > not preloaded. So it can happen but the number is negligible.
> > 
> > V1 -> V2:
> >   - move __this_cpu_cmpxchg check when spin_lock is taken,
> >     as proposed by Andrew Morton
> >   - add more explanation in regard of preloading
> >   - adjust and move some comments
> > 
> > Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for split purpose")
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 50 +++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 33 insertions(+), 17 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index e92ff5f7dd8b..f48cd0711478 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -969,6 +969,19 @@ adjust_va_to_fit_type(struct vmap_area *va,
> >  			 * There are a few exceptions though, as an example it is
> >  			 * a first allocation (early boot up) when we have "one"
> >  			 * big free space that has to be split.
> > +			 *
> > +			 * Also we can hit this path in case of regular "vmap"
> > +			 * allocations, if "this" current CPU was not preloaded.
> > +			 * See the comment in alloc_vmap_area() why. If so, then
> > +			 * GFP_NOWAIT is used instead to get an extra object for
> > +			 * split purpose. That is rare and most time does not
> > +			 * occur.
> > +			 *
> > +			 * What happens if an allocation gets failed. Basically,
> > +			 * an "overflow" path is triggered to purge lazily freed
> > +			 * areas to free some memory, then, the "retry" path is
> > +			 * triggered to repeat one more time. See more details
> > +			 * in alloc_vmap_area() function.
> >  			 */
> >  			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> 
> This doesn't seem to have anything to do with the patch. Have you
> considered to make it a patch on its own? Btw. I find this comment very
> useful!
> 
Makes sense, will make it as separate patch.

> >  			if (!lva)
> > @@ -1078,31 +1091,34 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  
> >  retry:
> >  	/*
> > -	 * Preload this CPU with one extra vmap_area object to ensure
> > -	 * that we have it available when fit type of free area is
> > -	 * NE_FIT_TYPE.
> > +	 * Preload this CPU with one extra vmap_area object. It is used
> > +	 * when fit type of free area is NE_FIT_TYPE. Please note, it
> > +	 * does not guarantee that an allocation occurs on a CPU that
> > +	 * is preloaded, instead we minimize the case when it is not.
> > +	 * It can happen because of migration, because there is a race
> > +	 * until the below spinlock is taken.
> 
> s@migration@cpu migration@ because migration without on its own is quite
> ambiguous, especially in the MM code where it usually refers to memory.
> 
Thanks, will update it.


Thank you for the comments!

--
Vlad Rezki
