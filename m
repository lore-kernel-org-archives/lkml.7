Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDEBC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEEC21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hoPkJgMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391992AbfIYQpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:45:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390600AbfIYQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6zJPlAYn8c0O7MARtGXgdQGRjAiE59wQIYqRXLNRrrQ=; b=hoPkJgMrJsNNzMte6q6cCv61ok
        s9DN3Gz4KN6NLLdcb8X8STVzN+Pz5LZuPw1Neg3c01Doqy3V4lgB+XB7QULc7MafsKOPEnEKWzsFe
        Uk5kJ0tNXlU95hTBhFB5y1JvS3htodRK92nE4C+Fc+sAsm8rzvz0apkhWH98QeEnWK+G3fUlKf6GJ
        tqN2NjhkY9lVVvSWWaI97XI0aDtpFMSeBEWH4TzuLxDZ4GICMcXqSPq4uwQLUnWdTcgaSqHSLz/WD
        tmbvQ4Q41Gd3oVbeJG03jkIfgzmJP/F2jbTVMbIp4TJ8tlmYnYHALgGjrN+Hm2MNU6UV+n+9bcMeY
        g+V7IdHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDAPy-00036k-00; Wed, 25 Sep 2019 16:45:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EE31302A71;
        Wed, 25 Sep 2019 18:44:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EDD920249302; Wed, 25 Sep 2019 18:45:27 +0200 (CEST)
Date:   Wed, 25 Sep 2019 18:45:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        mingo@redhat.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
Message-ID: <20190925164527.GG4553@hirez.programming.kicks-ass.net>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
 <20190925093153.GC4553@hirez.programming.kicks-ass.net>
 <1569424727.5576.221.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569424727.5576.221.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 11:18:47AM -0400, Qian Cai wrote:
> On Wed, 2019-09-25 at 11:31 +0200, Peter Zijlstra wrote:
> > On Fri, Sep 13, 2019 at 12:27:44PM -0400, Qian Cai wrote:

> > > -> #3 (batched_entropy_u32.lock){-.-.}:
> > >        lock_acquire+0x31c/0x360
> > >        _raw_spin_lock_irqsave+0x7c/0x9c
> > >        get_random_u32+0x6c/0x1dc
> > >        new_slab+0x234/0x6c0
> > >        ___slab_alloc+0x3c8/0x650
> > >        kmem_cache_alloc+0x4b0/0x590
> > >        __debug_object_init+0x778/0x8b4
> > >        debug_object_init+0x40/0x50
> > >        debug_init+0x30/0x29c
> > >        hrtimer_init+0x30/0x50
> > >        init_dl_task_timer+0x24/0x44
> > >        __sched_fork+0xc0/0x168
> > >        init_idle+0x78/0x26c
> > >        fork_idle+0x12c/0x178
> > >        idle_threads_init+0x108/0x178
> > >        smp_init+0x20/0x1bc
> > >        kernel_init_freeable+0x198/0x26c
> > >        kernel_init+0x18/0x334
> > >        ret_from_fork+0x10/0x18
> > > 
> > > -> #2 (&rq->lock){-.-.}:
> > 
> > This relation is silly..
> > 
> > I suspect the below 'works'...
> 
> Unfortunately, the relation is still there,
> 
> copy_process()->rt_mutex_init_task()->"&p->pi_lock"
> 
> [24438.676716][    T2] -> #2 (&rq->lock){-.-.}:
> [24438.676727][    T2]        __lock_acquire+0x5b4/0xbf0
> [24438.676736][    T2]        lock_acquire+0x130/0x360
> [24438.676754][    T2]        _raw_spin_lock+0x54/0x80
> [24438.676771][    T2]        task_fork_fair+0x60/0x190
> [24438.676788][    T2]        sched_fork+0x128/0x270
> [24438.676806][    T2]        copy_process+0x7a4/0x1bf0
> [24438.676823][    T2]        _do_fork+0xac/0xac0
> [24438.676841][    T2]        kernel_thread+0x70/0xa0
> [24438.676858][    T2]        rest_init+0x4c/0x42c
> [24438.676884][    T2]        start_kernel+0x778/0x7c0
> [24438.676902][    T2]        start_here_common+0x1c/0x334

That's the 'where we took #2 while holding #1' stacktrace and not
relevant to our discussion.

> [24438.675836][    T2] -> #4 (batched_entropy_u64.lock){-...}:
> [24438.675860][    T2]        __lock_acquire+0x5b4/0xbf0
> [24438.675878][    T2]        lock_acquire+0x130/0x360
> [24438.675906][    T2]        _raw_spin_lock_irqsave+0x70/0xa0
> [24438.675923][    T2]        get_random_u64+0x60/0x100
> [24438.675944][    T2]        add_to_free_area_random+0x164/0x1b0
> [24438.675962][    T2]        free_one_page+0xb24/0xcf0
> [24438.675980][    T2]        __free_pages_ok+0x448/0xbf0
> [24438.675999][    T2]        deferred_init_maxorder+0x404/0x4a4
> [24438.676018][    T2]        deferred_grow_zone+0x158/0x1f0
> [24438.676035][    T2]        get_page_from_freelist+0x1dc8/0x1e10
> [24438.676063][    T2]        __alloc_pages_nodemask+0x1d8/0x1940
> [24438.676083][    T2]        allocate_slab+0x130/0x2740
> [24438.676091][    T2]        new_slab+0xa8/0xe0
> [24438.676101][    T2]        kmem_cache_open+0x254/0x660
> [24438.676119][    T2]        __kmem_cache_create+0x44/0x2a0
> [24438.676136][    T2]        create_boot_cache+0xcc/0x110
> [24438.676154][    T2]        kmem_cache_init+0x90/0x1f0
> [24438.676173][    T2]        start_kernel+0x3b8/0x7c0
> [24438.676191][    T2]        start_here_common+0x1c/0x334
> [24438.676208][    T2] 
> [24438.676208][    T2] -> #3 (&(&zone->lock)->rlock){-.-.}:
> [24438.676221][    T2]        __lock_acquire+0x5b4/0xbf0
> [24438.676247][    T2]        lock_acquire+0x130/0x360
> [24438.676264][    T2]        _raw_spin_lock+0x54/0x80
> [24438.676282][    T2]        rmqueue_bulk.constprop.23+0x64/0xf20
> [24438.676300][    T2]        get_page_from_freelist+0x718/0x1e10
> [24438.676319][    T2]        __alloc_pages_nodemask+0x1d8/0x1940
> [24438.676339][    T2]        alloc_page_interleave+0x34/0x170
> [24438.676356][    T2]        allocate_slab+0xd1c/0x2740
> [24438.676374][    T2]        new_slab+0xa8/0xe0
> [24438.676391][    T2]        ___slab_alloc+0x580/0xef0
> [24438.676408][    T2]        __slab_alloc+0x64/0xd0
> [24438.676426][    T2]        kmem_cache_alloc+0x5c4/0x6c0
> [24438.676444][    T2]        fill_pool+0x280/0x540
> [24438.676461][    T2]        __debug_object_init+0x60/0x6b0
> [24438.676479][    T2]        hrtimer_init+0x5c/0x310
> [24438.676497][    T2]        init_dl_task_timer+0x34/0x60
> [24438.676516][    T2]        __sched_fork+0x8c/0x110
> [24438.676535][    T2]        init_idle+0xb4/0x3c0
> [24438.676553][    T2]        idle_thread_get+0x78/0x120
> [24438.676572][    T2]        bringup_cpu+0x30/0x230
> [24438.676590][    T2]        cpuhp_invoke_callback+0x190/0x1580
> [24438.676618][    T2]        do_cpu_up+0x248/0x460
> [24438.676636][    T2]        smp_init+0x118/0x1c0
> [24438.676662][    T2]        kernel_init_freeable+0x3f8/0x8dc
> [24438.676681][    T2]        kernel_init+0x2c/0x154
> [24438.676699][    T2]        ret_from_kernel_thread+0x5c/0x74
> [24438.676716][    T2] 
> [24438.676716][    T2] -> #2 (&rq->lock){-.-.}:

This then shows we now have:

	rq->lock
	  zone->lock.rlock
	    batched_entropy_u64.lock

Which, to me, appears to be distinctly different from the last time,
which was:

	rq->lock
	  batched_entropy_u32.lock

Notable: "u32" != "u64".

But #3 has:

> [24438.676516][    T2]        __sched_fork+0x8c/0x110
> [24438.676535][    T2]        init_idle+0xb4/0x3c0

Which seems to suggest you didn't actually apply the patch; or rather,
if you did, i'm not immediately seeing where #2 is acquired.

