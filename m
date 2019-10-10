Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D963C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5E7208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJpu7S/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfJJPSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:18:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38285 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfJJPSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:18:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id u28so4688693lfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DhBiRU6l/Q5tEj9PULYkC72j1j35gKyBT3ikpjmzIXs=;
        b=DJpu7S/LmkKE5/LNv5/Y9zOPsohe1dBpr0nf7o1F8vSqFRE97tKCH70g+4D0KdFZsg
         FrWFKE/8ijGqQDH5tWW0dXqVpFDI6mFT+vOLps3F/EHIUhXCAarwYoxnTH/6o0VmJSjc
         uWVQeMfzchVsysNTFh3v5Zu+yIs6X4cOqijNJqsXxowW8J1307eaZoaL32Bgxp6FYI6B
         mGkpofAOuZx44NqhEdLlwDmT5qEjkPlbMNLQ2ZaMKb70iapgH29kVApL6reGmIG1F+sX
         DMM5WzntatoC24/MyexNeYpWACnRY9KhthgIcfFMAog0ktFvPBqRKZJSik0R/IbFheEa
         ke6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DhBiRU6l/Q5tEj9PULYkC72j1j35gKyBT3ikpjmzIXs=;
        b=BQ+3wXqHwKXy/w7BVIRkupkUAHt7Lx3scmOSFpE2BrTa3gqDlFyuMOdkzXrVx1JPNI
         WxBZiBSS2FPXhRIf7CWe0xgVbHqGj0Dcl0DYFh9nkgYsdxYpWfFu6THcKzHU1Twqxfbo
         pFUhbXrxwCiRUsVbHSrnBxdVm6aEh3L+ME3eeY+SuQJ1uACapxf4oI1IZyg3c+iFC4Ur
         gqG3kDkQWAOuqj+KdymsXVYLGMrMFZDbYO/edeX3qmDFJqhcIYkT9MOa2qItCQxZqdjF
         gmR8hj8Ey0Sd+JjRfc4EHPzktfcoxWgYqblXya5HstPaGrcmkiKar/MsX3eIzy3JW25D
         n6Iw==
X-Gm-Message-State: APjAAAVK0HdMgMto5x0lN5rIMW/haQHVFnFNPnQxdxxXfReXDsYz8xXx
        x1iaxwhKLp3hTkX/mLO71MI=
X-Google-Smtp-Source: APXvYqzjTWxS9IFCdv7VeOQLFLNHH4z4vy1luZQzA06WtAYnBVJZOX9r31IM4s6c1NcwXTgAqX6MdA==
X-Received: by 2002:ac2:4a83:: with SMTP id l3mr6351240lfp.73.1570720677697;
        Thu, 10 Oct 2019 08:17:57 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id q3sm1251245ljq.4.2019.10.10.08.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 08:17:56 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 10 Oct 2019 17:17:49 +0200
To:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-ID: <20191010151749.GA14740@pc636>
References: <20191009164934.10166-1-urezki@gmail.com>
 <20191009151901.1be5f7211db291e4bd2da8ca@linux-foundation.org>
 <20191009221725.0b83151e@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009221725.0b83151e@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > A few questions about the resulting alloc_vmap_area():
> > 
> > : static struct vmap_area *alloc_vmap_area(unsigned long size,
> > : 				unsigned long align,
> > : 				unsigned long vstart, unsigned long vend,
> > : 				int node, gfp_t gfp_mask)
> > : {
> > : 	struct vmap_area *va, *pva;
> > : 	unsigned long addr;
> > : 	int purged = 0;
> > : 
> > : 	BUG_ON(!size);
> > : 	BUG_ON(offset_in_page(size));
> > : 	BUG_ON(!is_power_of_2(align));
> > : 
> > : 	if (unlikely(!vmap_initialized))
> > : 		return ERR_PTR(-EBUSY);
> > : 
> > : 	might_sleep();
> > : 
> > : 	va = kmem_cache_alloc_node(vmap_area_cachep,
> > : 			gfp_mask & GFP_RECLAIM_MASK, node);
> > 
> > Why does this use GFP_RECLAIM_MASK?  Please add a comment explaining
> > this.
> > 
I need to think about it. Initially it was like that.

> > : 	if (unlikely(!va))
> > : 		return ERR_PTR(-ENOMEM);
> > : 
> > : 	/*
> > : 	 * Only scan the relevant parts containing pointers to other objects
> > : 	 * to avoid false negatives.
> > : 	 */
> > : 	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask & GFP_RECLAIM_MASK);
> > : 
> > : retry:
> > : 	/*
> > : 	 * Preload this CPU with one extra vmap_area object. It is used
> > : 	 * when fit type of free area is NE_FIT_TYPE. Please note, it
> > : 	 * does not guarantee that an allocation occurs on a CPU that
> > : 	 * is preloaded, instead we minimize the case when it is not.
> > : 	 * It can happen because of migration, because there is a race
> > : 	 * until the below spinlock is taken.
> > : 	 *
> > : 	 * The preload is done in non-atomic context, thus it allows us
> > : 	 * to use more permissive allocation masks to be more stable under
> > : 	 * low memory condition and high memory pressure.
> > : 	 *
> > : 	 * Even if it fails we do not really care about that. Just proceed
> > : 	 * as it is. "overflow" path will refill the cache we allocate from.
> > : 	 */
> > : 	if (!this_cpu_read(ne_fit_preload_node)) {
> > 
> > Readability nit: local `pva' should be defined here, rather than having
> > function-wide scope.
> > 
> > : 		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> > 
> > Why doesn't this honour gfp_mask?  If it's not a bug, please add
> > comment explaining this.
> > 
But there is a comment, if understand you correctly:

<snip>
* Even if it fails we do not really care about that. Just proceed
* as it is. "overflow" path will refill the cache we allocate from.
<snip>

> > The kmem_cache_alloc() in adjust_va_to_fit_type() omits the caller's
> > gfp_mask also.  If not a bug, please document the unexpected behaviour.
> > 
I will add a comment there.

> 
> These questions appear to be for the code that this patch touches, not
> for the patch itself.
> 
> > : 
> > : 		if (this_cpu_cmpxchg(ne_fit_preload_node, NULL,
> > pva)) { : 			if (pva)
> > : 				kmem_cache_free(vmap_area_cachep,
> > pva); : 		}
> > : 	}
> > : 
> > : 	spin_lock(&vmap_area_lock);
> > : 
> > : 	/*
> > : 	 * If an allocation fails, the "vend" address is
> > : 	 * returned. Therefore trigger the overflow path.
> > : 	 */
> > 
> > As for the intent of this patch, why not preallocate the vmap_area
> > outside the spinlock and use it within the spinlock?  Does spin_lock()
> > disable preemption on RT?  I forget, but it doesn't matter much anyway
> 
> spin_lock() does not disable preemption on RT. But it does disable
> migration (thus the task should remain on the current CPU).
> 
> > - doing this will make the code better in the regular kernel I think? 
> > Something like this:
> > 
> > 	struct vmap_area *pva = NULL;
> > 
> > 	...
> > 
> > 	if (!this_cpu_read(ne_fit_preload_node))
> > 		pva = kmem_cache_alloc_node(vmap_area_cachep, ...);
> > 
> > 	spin_lock(&vmap_area_lock);
> > 
> > 	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
> > 		kmem_cache_free(vmap_area_cachep, pva);
> > 
> 
> 
> This looks fine to me.
> 
Yes, i agree that is better. I was thinking about doing so, but decided
to keep as it is, because of low number of "corner cases" anyway.

I will upload the v2.

Thanks for the comments!

--
Vlad Rezki
