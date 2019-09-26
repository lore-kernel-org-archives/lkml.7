Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA2DC352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6622222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Khqf4vPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfIZM3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:29:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34838 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfIZM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:29:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so1586604qkf.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R8gFRBbQ4X4rxN/qoLZjY0YoA+uaNjhGigYwkGyjnDE=;
        b=Khqf4vPSsVuShXxTMPD+5XfiQXQVxRK+wi9v8nb6LfrcD/xeG+FlsnqmxKdsCgnTOd
         Xry8p/BW6w4MlAc2RwQHg/vpkrSvv7uf/3gUpup6RigpglYdxXYoD2ChytRJ5Pk+xGAw
         Itjp9OGA3pWWvsVzWmwRT0Jz32VUyGfPe4pw8EuSwlQFe7+RdLUjdCCpFD7RBA37vx1b
         SLZtpE9nwmP1x0BV+hC9J3bvD16ifldtZXX608HaMky+VwfDC2uztB6QHWUo+mQvRSDm
         sabTQm62tPNCgUvczjdDe9o7Y7Sq/uF7AhC5dT7+8VgVmpjZ3ubdnTB+49t4iz7nEBjJ
         Ol6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8gFRBbQ4X4rxN/qoLZjY0YoA+uaNjhGigYwkGyjnDE=;
        b=tyYupq+B2tyAVECjFVNGwHrJLltHi3MONRFC3NvLLUeMffWkheLAaaUQOzyGktV0zL
         ugtAAoe1KQnEzv4fEjt+KY0uAlTNISJiLaky3m+DF1JH5IZLIJoL2yGvrHFxHPzNE/tE
         OXvjBchHzPXuv5RsJSrOSTwSmGBFm/2zNhnBIO2XGVJuAkiWJR3iXSEeulr/Q6QK6ZmU
         fvpxu+yyDFtsmiATBmtMrdKbHrGfebyZRDa3+7+TTbdBfk3lywyj1/TetYH3l0IhEv6o
         nbu1CmnRx001rg5XviopqqWcLm1d8N5aHfHVp50/FJ2Z5dlxbmOL4BmrJHmIM+OxHYDD
         CVFA==
X-Gm-Message-State: APjAAAWzkidmlVpd/EDCFdFvEF13Pj8sDe5F6XTvZpBUgPQWc1f4YPgB
        D4TViVWGWOgT1MxZ6V82+rVs/Q==
X-Google-Smtp-Source: APXvYqwi0hZu9RnIvnj9vYe1+RHjipqKXUMq5d1WpZK20SWd5VBo8C9efBydGRgCxMg0WE66/DlvWw==
X-Received: by 2002:a37:691:: with SMTP id 139mr2964477qkg.476.1569500977779;
        Thu, 26 Sep 2019 05:29:37 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p56sm1027967qtp.81.2019.09.26.05.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 05:29:36 -0700 (PDT)
Message-ID: <1569500974.5576.234.camel@lca.pw>
Subject: Re: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        mingo@redhat.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Date:   Thu, 26 Sep 2019 08:29:34 -0400
In-Reply-To: <20190925164527.GG4553@hirez.programming.kicks-ass.net>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
         <20190925093153.GC4553@hirez.programming.kicks-ass.net>
         <1569424727.5576.221.camel@lca.pw>
         <20190925164527.GG4553@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-25 at 18:45 +0200, Peter Zijlstra wrote:
> On Wed, Sep 25, 2019 at 11:18:47AM -0400, Qian Cai wrote:
> > On Wed, 2019-09-25 at 11:31 +0200, Peter Zijlstra wrote:
> > > On Fri, Sep 13, 2019 at 12:27:44PM -0400, Qian Cai wrote:
> > > > -> #3 (batched_entropy_u32.lock){-.-.}:
> > > >        lock_acquire+0x31c/0x360
> > > >        _raw_spin_lock_irqsave+0x7c/0x9c
> > > >        get_random_u32+0x6c/0x1dc
> > > >        new_slab+0x234/0x6c0
> > > >        ___slab_alloc+0x3c8/0x650
> > > >        kmem_cache_alloc+0x4b0/0x590
> > > >        __debug_object_init+0x778/0x8b4
> > > >        debug_object_init+0x40/0x50
> > > >        debug_init+0x30/0x29c
> > > >        hrtimer_init+0x30/0x50
> > > >        init_dl_task_timer+0x24/0x44
> > > >        __sched_fork+0xc0/0x168
> > > >        init_idle+0x78/0x26c
> > > >        fork_idle+0x12c/0x178
> > > >        idle_threads_init+0x108/0x178
> > > >        smp_init+0x20/0x1bc
> > > >        kernel_init_freeable+0x198/0x26c
> > > >        kernel_init+0x18/0x334
> > > >        ret_from_fork+0x10/0x18
> > > > 
> > > > -> #2 (&rq->lock){-.-.}:
> > > 
> > > This relation is silly..
> > > 
> > > I suspect the below 'works'...
> > 
> > Unfortunately, the relation is still there,
> > 
> > copy_process()->rt_mutex_init_task()->"&p->pi_lock"
> > 
> > [24438.676716][    T2] -> #2 (&rq->lock){-.-.}:
> > [24438.676727][    T2]        __lock_acquire+0x5b4/0xbf0
> > [24438.676736][    T2]        lock_acquire+0x130/0x360
> > [24438.676754][    T2]        _raw_spin_lock+0x54/0x80
> > [24438.676771][    T2]        task_fork_fair+0x60/0x190
> > [24438.676788][    T2]        sched_fork+0x128/0x270
> > [24438.676806][    T2]        copy_process+0x7a4/0x1bf0
> > [24438.676823][    T2]        _do_fork+0xac/0xac0
> > [24438.676841][    T2]        kernel_thread+0x70/0xa0
> > [24438.676858][    T2]        rest_init+0x4c/0x42c
> > [24438.676884][    T2]        start_kernel+0x778/0x7c0
> > [24438.676902][    T2]        start_here_common+0x1c/0x334
> 
> That's the 'where we took #2 while holding #1' stacktrace and not
> relevant to our discussion.

Oh, you were talking about took #3 while holding #2. Anyway, your patch is
working fine so far. Care to post/merge it officially or do you want me to post
it?

> 
> > [24438.675836][    T2] -> #4 (batched_entropy_u64.lock){-...}:
> > [24438.675860][    T2]        __lock_acquire+0x5b4/0xbf0
> > [24438.675878][    T2]        lock_acquire+0x130/0x360
> > [24438.675906][    T2]        _raw_spin_lock_irqsave+0x70/0xa0
> > [24438.675923][    T2]        get_random_u64+0x60/0x100
> > [24438.675944][    T2]        add_to_free_area_random+0x164/0x1b0
> > [24438.675962][    T2]        free_one_page+0xb24/0xcf0
> > [24438.675980][    T2]        __free_pages_ok+0x448/0xbf0
> > [24438.675999][    T2]        deferred_init_maxorder+0x404/0x4a4
> > [24438.676018][    T2]        deferred_grow_zone+0x158/0x1f0
> > [24438.676035][    T2]        get_page_from_freelist+0x1dc8/0x1e10
> > [24438.676063][    T2]        __alloc_pages_nodemask+0x1d8/0x1940
> > [24438.676083][    T2]        allocate_slab+0x130/0x2740
> > [24438.676091][    T2]        new_slab+0xa8/0xe0
> > [24438.676101][    T2]        kmem_cache_open+0x254/0x660
> > [24438.676119][    T2]        __kmem_cache_create+0x44/0x2a0
> > [24438.676136][    T2]        create_boot_cache+0xcc/0x110
> > [24438.676154][    T2]        kmem_cache_init+0x90/0x1f0
> > [24438.676173][    T2]        start_kernel+0x3b8/0x7c0
> > [24438.676191][    T2]        start_here_common+0x1c/0x334
> > [24438.676208][    T2] 
> > [24438.676208][    T2] -> #3 (&(&zone->lock)->rlock){-.-.}:
> > [24438.676221][    T2]        __lock_acquire+0x5b4/0xbf0
> > [24438.676247][    T2]        lock_acquire+0x130/0x360
> > [24438.676264][    T2]        _raw_spin_lock+0x54/0x80
> > [24438.676282][    T2]        rmqueue_bulk.constprop.23+0x64/0xf20
> > [24438.676300][    T2]        get_page_from_freelist+0x718/0x1e10
> > [24438.676319][    T2]        __alloc_pages_nodemask+0x1d8/0x1940
> > [24438.676339][    T2]        alloc_page_interleave+0x34/0x170
> > [24438.676356][    T2]        allocate_slab+0xd1c/0x2740
> > [24438.676374][    T2]        new_slab+0xa8/0xe0
> > [24438.676391][    T2]        ___slab_alloc+0x580/0xef0
> > [24438.676408][    T2]        __slab_alloc+0x64/0xd0
> > [24438.676426][    T2]        kmem_cache_alloc+0x5c4/0x6c0
> > [24438.676444][    T2]        fill_pool+0x280/0x540
> > [24438.676461][    T2]        __debug_object_init+0x60/0x6b0
> > [24438.676479][    T2]        hrtimer_init+0x5c/0x310
> > [24438.676497][    T2]        init_dl_task_timer+0x34/0x60
> > [24438.676516][    T2]        __sched_fork+0x8c/0x110
> > [24438.676535][    T2]        init_idle+0xb4/0x3c0
> > [24438.676553][    T2]        idle_thread_get+0x78/0x120
> > [24438.676572][    T2]        bringup_cpu+0x30/0x230
> > [24438.676590][    T2]        cpuhp_invoke_callback+0x190/0x1580
> > [24438.676618][    T2]        do_cpu_up+0x248/0x460
> > [24438.676636][    T2]        smp_init+0x118/0x1c0
> > [24438.676662][    T2]        kernel_init_freeable+0x3f8/0x8dc
> > [24438.676681][    T2]        kernel_init+0x2c/0x154
> > [24438.676699][    T2]        ret_from_kernel_thread+0x5c/0x74
> > [24438.676716][    T2] 
> > [24438.676716][    T2] -> #2 (&rq->lock){-.-.}:
> 
> This then shows we now have:
> 
> 	rq->lock
> 	  zone->lock.rlock
> 	    batched_entropy_u64.lock
> 
> Which, to me, appears to be distinctly different from the last time,
> which was:
> 
> 	rq->lock
> 	  batched_entropy_u32.lock
> 
> Notable: "u32" != "u64".
> 
> But #3 has:
> 
> > [24438.676516][    T2]        __sched_fork+0x8c/0x110
> > [24438.676535][    T2]        init_idle+0xb4/0x3c0
> 
> Which seems to suggest you didn't actually apply the patch; or rather,
> if you did, i'm not immediately seeing where #2 is acquired.
> 
