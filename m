Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C493CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D7B20644
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gLPaySJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfIPVbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:31:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42852 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfIPVbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:31:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id g16so1696869qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtI/pUMWSUWHSxCto+5Y9kOxVYNA3dv2B6oM7vamPh0=;
        b=gLPaySJPgGayIegWWI0zvrhMtv1ZMT+Fqgi/18YKjQ0dcFvSkf9vl6hki/2iMchqhz
         HmKzECaovdJ/2WbTha4LaX6re99tRsczM4VCE6/77v33tQmzh5ofT4SrD6JcB0CUT5Y1
         2o5WFiRPlUDIDhV5CWCalFyL9Onc8ZMcDK8hF0A039ePT6gR0AdKK9E3chrujS9HJdVd
         C9dLMFQH6KJYNRwtjoJXq06vDcGMq/iIMMouSxFaoX+KuktKIVTmLsBZT/bkx9j+LP2D
         tZKLUfG9fqYZAfEPamwucQhjzPiKhMm0mdUnXHu+7HL6UJGwOvA5WJ+jKqOUCMKDiAWN
         gV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtI/pUMWSUWHSxCto+5Y9kOxVYNA3dv2B6oM7vamPh0=;
        b=DjRT2xcJsqhB2KuDPrhy6kS6HUD2ZVvVu72iviiAHtIgid07FPYArOeKWRT2fc5UQN
         fybWA3IBtrvQJslkC0ogDv+4/lUGPPdmy30QkKg8M3Dx5DSfsM2Xt6dnNlXKlq2w0gPe
         PpKSpTnh74SLFLiOh+aOOw0uANa7oSah+E6YAXVC9N9fDesXMIU4+yfileaU1QW3KSOg
         q9RTbQK2d5/jBgoQLSsSpXVvC8ubYm3DyMWZ+B9FQjoUZ339nY7NQjboq3sfOULT2ufY
         3E9qU7AcdFSTh5ZAJn63iYcpbgBP4Nle8AJ5Jvt3IliG1Txt0CG+fIioNxSvtTJ9u1wv
         gIOA==
X-Gm-Message-State: APjAAAUt7JT4x79zunOoUCSXhxGzGDjxPx0AZfiLs2bEcXyMn+WQnAED
        g3/xxR6eiAkqQswLDVtB49TNi2KMVtA=
X-Google-Smtp-Source: APXvYqzNb9g9p/4qXQKa/UG9J98LCdjGB5VAXKUg4IHbiS+k0l5/307LRG6Wvg6h7NxSYsm0DSUYvA==
X-Received: by 2002:a0c:c251:: with SMTP id w17mr369272qvh.226.1568669497775;
        Mon, 16 Sep 2019 14:31:37 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a4sm115016qkf.91.2019.09.16.14.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 14:31:37 -0700 (PDT)
Message-ID: <1568669494.5576.157.camel@lca.pw>
Subject: Re: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
From:   Qian Cai <cai@lca.pw>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Date:   Mon, 16 Sep 2019 17:31:34 -0400
In-Reply-To: <20190916195115.g4hj3j3wstofpsdr@linutronix.de>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
         <20190916090336.2mugbds4rrwxh6uz@linutronix.de>
         <1568642487.5576.152.camel@lca.pw>
         <20190916195115.g4hj3j3wstofpsdr@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 21:51 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-16 10:01:27 [-0400], Qian Cai wrote:
> > On Mon, 2019-09-16 at 11:03 +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-09-13 12:27:44 [-0400], Qian Cai wrote:
> > > …
> > > > Chain exists of:
> > > >   random_write_wait.lock --> &rq->lock --> batched_entropy_u32.lock
> > > > 
> > > >  Possible unsafe locking scenario:
> > > > 
> > > >        CPU0                    CPU1
> > > >        ----                    ----
> > > >   lock(batched_entropy_u32.lock);
> > > >                                lock(&rq->lock);
> > > >                                lock(batched_entropy_u32.lock);
> > > >   lock(random_write_wait.lock);
> > > 
> > > would this deadlock still occur if lockdep knew that
> > > batched_entropy_u32.lock on CPU0 could be acquired at the same time
> > > as CPU1 acquired its batched_entropy_u32.lock?
> > 
> > I suppose that might fix it too if it can teach the lockdep the trick, but it
> > would be better if there is a patch if you have something in mind that could be
> > tested to make sure.
> 
> get_random_bytes() is heavier than get_random_int() so I would prefer to
> avoid its usage to fix what looks like a false positive report from
> lockdep.
> But no, I don't have a patch sitting around. A lock in per-CPU memory
> could lead to the scenario mentioned above if the lock could be obtained
> cross-CPU it just isn't so in that case. So I don't think it is that
> simple.

get_random_u64() is also busted.

[  752.925079] WARNING: possible circular locking dependency detected
[  752.931951] 5.3.0-rc8-next-20190915+ #2 Tainted: G             L   
[  752.938906] ------------------------------------------------------
[  752.945774] ls/9665 is trying to acquire lock:
[  752.950905] ffff90001311fef8 (random_write_wait.lock){..-.}, at:
__wake_up_common_lock+0xa8/0x11c
[  752.960481] 
               but task is already holding lock:
[  752.967698] ffff008abc7b9c00 (batched_entropy_u64.lock){....}, at:
get_random_u64+0x6c/0x1dc
[  752.976835] 
               which lock already depends on the new lock.

[  752.987089] 
               the existing dependency chain (in reverse order) is:
[  752.995953] 
               -> #4 (batched_entropy_u64.lock){....}:
[  753.003702]        lock_acquire+0x320/0x364
[  753.008577]        _raw_spin_lock_irqsave+0x7c/0x9c
[  753.014145]        get_random_u64+0x6c/0x1dc
[  753.019109]        add_to_free_area_random+0x54/0x1c8
[  753.024851]        free_one_page+0x86c/0xc28
[  753.029818]        __free_pages_ok+0x69c/0xdac
[  753.034960]        __free_pages+0xbc/0xf8
[  753.039663]        __free_pages_core+0x2ac/0x3c0
[  753.044973]        memblock_free_pages+0xe0/0xf8
[  753.050281]        __free_pages_memory+0xcc/0xfc
[  753.055588]        __free_memory_core+0x70/0x78
[  753.060809]        free_low_memory_core_early+0x148/0x18c
[  753.066897]        memblock_free_all+0x18/0x54
[  753.072033]        mem_init+0x9c/0x160
[  753.076472]        mm_init+0x14/0x38
[  753.080737]        start_kernel+0x19c/0x52c
[  753.085607] 
               -> #3 (&(&zone->lock)->rlock){..-.}:
[  753.093092]        lock_acquire+0x320/0x364
[  753.097964]        _raw_spin_lock+0x64/0x80
[  753.102839]        rmqueue_bulk+0x50/0x15a0
[  753.107712]        get_page_from_freelist+0x2260/0x29dc
[  753.113627]        __alloc_pages_nodemask+0x36c/0x1ce0
[  753.119457]        alloc_page_interleave+0x34/0x17c
[  753.125023]        alloc_pages_current+0x80/0xe0
[  753.130334]        allocate_slab+0xfc/0x1d80
[  753.135296]        ___slab_alloc+0x5d4/0xa70
[  753.140257]        kmem_cache_alloc+0x588/0x66c
[  753.145480]        __debug_object_init+0x9d8/0xbac
[  753.150962]        debug_object_init+0x40/0x50
[  753.156098]        hrtimer_init+0x38/0x2b4
[  753.160885]        init_dl_task_timer+0x24/0x44
[  753.166108]        __sched_fork+0xc0/0x168
[  753.170894]        init_idle+0x80/0x3d8
[  753.175420]        idle_thread_get+0x60/0x8c
[  753.180385]        _cpu_up+0x10c/0x348
[  753.184824]        do_cpu_up+0x114/0x170
[  753.189437]        cpu_up+0x20/0x2c
[  753.193615]        smp_init+0xf8/0x1bc
[  753.198054]        kernel_init_freeable+0x198/0x26c
[  753.203622]        kernel_init+0x18/0x334
[  753.208323]        ret_from_fork+0x10/0x18
[  753.213107] 
               -> #2 (&rq->lock){-.-.}:
[  753.219550]        lock_acquire+0x320/0x364
[  753.224423]        _raw_spin_lock+0x64/0x80
[  753.229299]        task_fork_fair+0x64/0x22c
[  753.234261]        sched_fork+0x24c/0x3d8
[  753.238962]        copy_process+0xa60/0x29b0
[  753.243921]        _do_fork+0xb8/0xa64
[  753.248360]        kernel_thread+0xc4/0xf4
[  753.253147]        rest_init+0x30/0x320
[  753.257673]        arch_call_rest_init+0x10/0x18
[  753.262980]        start_kernel+0x424/0x52c
[  753.267849] 
               -> #1 (&p->pi_lock){-.-.}:
[  753.274467]        lock_acquire+0x320/0x364
[  753.279342]        _raw_spin_lock_irqsave+0x7c/0x9c
[  753.284910]        try_to_wake_up+0x74/0x128c
[  753.289959]        default_wake_function+0x38/0x48
[  753.295440]        pollwake+0x118/0x158
[  753.299967]        __wake_up_common+0x16c/0x240
[  753.305187]        __wake_up_common_lock+0xc8/0x11c
[  753.310754]        __wake_up+0x3c/0x4c
[  753.315193]        account+0x390/0x3e0
[  753.319632]        extract_entropy+0x2cc/0x37c
[  753.324766]        _xfer_secondary_pool+0x35c/0x3c4
[  753.330333]        push_to_pool+0x54/0x308
[  753.335119]        process_one_work+0x558/0xb1c
[  753.340339]        worker_thread+0x494/0x650
[  753.345300]        kthread+0x1cc/0x1e8
[  753.349739]        ret_from_fork+0x10/0x18
[  753.354522] 
               -> #0 (random_write_wait.lock){..-.}:
[  753.362093]        validate_chain+0xfcc/0x2fd4
[  753.367227]        __lock_acquire+0x868/0xc2c
[  753.372274]        lock_acquire+0x320/0x364
[  753.377147]        _raw_spin_lock_irqsave+0x7c/0x9c
[  753.382715]        __wake_up_common_lock+0xa8/0x11c
[  753.388282]        __wake_up+0x3c/0x4c
[  753.392720]        account+0x390/0x3e0
[  753.397159]        extract_entropy+0x2cc/0x37c
[  753.402292]        crng_reseed+0x60/0x350
[  753.406991]        _extract_crng+0xd8/0x164
[  753.411864]        crng_reseed+0x7c/0x350
[  753.416563]        _extract_crng+0xd8/0x164
[  753.421436]        get_random_u64+0xec/0x1dc
[  753.426396]        arch_mmap_rnd+0x18/0x78
[  753.431187]        load_elf_binary+0x6d0/0x1730
[  753.436411]        search_binary_handler+0x10c/0x35c
[  753.442067]        __do_execve_file+0xb58/0xf7c
[  753.447287]        __arm64_sys_execve+0x6c/0xa4
[  753.452509]        el0_svc_handler+0x170/0x240
[  753.457643]        el0_svc+0x8/0xc
[  753.461732] 
               other info that might help us debug this:

[  753.471812] Chain exists of:
                 random_write_wait.lock --> &(&zone->lock)->rlock -->
batched_entropy_u64.lock

[  753.486588]  Possible unsafe locking scenario:

[  753.493890]        CPU0                    CPU1
[  753.499108]        ----                    ----
[  753.504324]   lock(batched_entropy_u64.lock);
[  753.509372]                                lock(&(&zone->lock)->rlock);
[  753.516675]                                lock(batched_entropy_u64.lock);
[  753.524238]   lock(random_write_wait.lock);
[  753.529113] 
                *** DEADLOCK ***

[  753.537111] 1 lock held by ls/9665:
[  753.541287]  #0: ffff008abc7b9c00 (batched_entropy_u64.lock){....}, at:
get_random_u64+0x6c/0x1dc
[  753.550858] 
               stack backtrace:
[  753.556602] CPU: 121 PID: 9665 Comm: ls Tainted: G             L    5.3.0-
rc8-next-20190915+ #2
[  753.565987] Hardware name: HPE Apollo 70             /C01_APACHE_MB         ,
BIOS L50_5.13_1.11 06/18/2019
[  753.576414] Call trace:
[  753.579553]  dump_backtrace+0x0/0x264
[  753.583905]  show_stack+0x20/0x2c
[  753.587911]  dump_stack+0xd0/0x140
[  753.592003]  print_circular_bug+0x368/0x380
[  753.596876]  check_noncircular+0x28c/0x294
[  753.601664]  validate_chain+0xfcc/0x2fd4
[  753.606276]  __lock_acquire+0x868/0xc2c
[  753.610802]  lock_acquire+0x320/0x364
[  753.615154]  _raw_spin_lock_irqsave+0x7c/0x9c
[  753.620202]  __wake_up_common_lock+0xa8/0x11c
[  753.625248]  __wake_up+0x3c/0x4c
[  753.629171]  account+0x390/0x3e0
[  753.633095]  extract_entropy+0x2cc/0x37c
[  753.637708]  crng_reseed+0x60/0x350
[  753.641887]  _extract_crng+0xd8/0x164
[  753.646238]  crng_reseed+0x7c/0x350
[  753.650417]  _extract_crng+0xd8/0x164
[  753.654768]  get_random_u64+0xec/0x1dc
[  753.659208]  arch_mmap_rnd+0x18/0x78
[  753.663474]  load_elf_binary+0x6d0/0x1730
[  753.668173]  search_binary_handler+0x10c/0x35c
[  753.673308]  __do_execve_file+0xb58/0xf7c
[  753.678007]  __arm64_sys_execve+0x6c/0xa4
[  753.682707]  el0_svc_handler+0x170/0x240
[  753.687319]  el0_svc+0x8/0xc
