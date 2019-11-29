Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D41C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDFC2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="RmK+wv0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfK2MJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 07:09:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33245 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2MJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 07:09:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so9787546pgk.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 04:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Qm6oKiM2ABO+RifKesimvx+ONcOc9pjFmAlUk+XGKuc=;
        b=RmK+wv0pWAtIVk3gDw86d6xPm3fd/ePOaadw8wpI5SIfIyvdQy9QQKrfOgcBn/xSem
         RVFQC3tu4XYZsD0nZnlZ/qFiH1zA+efqOjx8WYFUbBoiVbgnOUe6B5bDVU5PVfCsTY5F
         G2kdqHW3bN5PZkR/YI3YZkudxUk1tRIT7b28I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Qm6oKiM2ABO+RifKesimvx+ONcOc9pjFmAlUk+XGKuc=;
        b=W1u1303weaRSeqDT8T2w8UPIucFGDGs1tUzHrT/PTl7uyjM6Q9CLjELAS+Xrk/yFVf
         no7Cvb3v8Z/NaeHnYF4iCAzZIAllEuV00/WbxTeee/pR/x2kSf+t6ufsv5ngkfnyDCsT
         g4afUHb06OVT3cSwbx6EKBqH0oCdfseLnCWZPNIVd02REVJoyOQwY5H3G0AxZsf69mSw
         gUEGbKxhAmi+2rEcDa+3FhdyHjEPmeSxm48zW2cv0h1xqtZVuApM5bKylkNTSuLD2TOF
         /TBmqogO442kbEPp903AiGWVmlo8VYhqpo7+nKz6fAisdPweAUEn72du2/9ELbccZcZo
         NUSw==
X-Gm-Message-State: APjAAAVpIel0BFW24e/t32KWId2wdoUlauKYYMnViy9ReTiSnA5cwagh
        VKal7p0KLH4p8ZkPuwZkRfeKAQ==
X-Google-Smtp-Source: APXvYqyOoxv4Fn6O7kpK30eEyZ3WTIVIVniRJX4iEN2aXzT4yNpDehQhUnYXRieB8j+TUqLopRanFA==
X-Received: by 2002:a63:4d1f:: with SMTP id a31mr16309174pgb.360.1575029371290;
        Fri, 29 Nov 2019 04:09:31 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-4092-39f5-bb9d-b59a.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:4092:39f5:bb9d:b59a])
        by smtp.gmail.com with ESMTPSA id q9sm8641213pjb.27.2019.11.29.04.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 04:09:30 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Qian Cai <cai@lca.pw>, kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v11 1/4] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <CACT4Y+Z+VhfVpkfg-WFq_kFMY=DE+9b_DCi-mCSPK-udaf_Arg@mail.gmail.com>
References: <20191031093909.9228-1-dja@axtens.net> <20191031093909.9228-2-dja@axtens.net> <1573835765.5937.130.camel@lca.pw> <871ru5hnfh.fsf@dja-thinkpad.axtens.net> <952ec26a-9492-6f71-bab1-c1def887e528@virtuozzo.com> <CACT4Y+ZGO8b88fUyFe-WtV3Ubr11ChLY2mqk8YKWN9o0meNtXA@mail.gmail.com> <CACT4Y+Z+VhfVpkfg-WFq_kFMY=DE+9b_DCi-mCSPK-udaf_Arg@mail.gmail.com>
Date:   Fri, 29 Nov 2019 23:09:27 +1100
Message-ID: <874kymg9zc.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

>> I am testing this support on next-20191129 and seeing the following warnings:
>>
>> BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
>> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 44, name: kworker/1:1
>> 4 locks held by kworker/1:1/44:
>>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
>> __write_once_size include/linux/compiler.h:247 [inline]
>>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
>> arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at: atomic64_set
>> include/asm-generic/atomic-instrumented.h:868 [inline]
>>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
>> atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
>>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at: set_work_data
>> kernel/workqueue.c:615 [inline]
>>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
>> set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
>>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
>> process_one_work+0x88b/0x1750 kernel/workqueue.c:2235
>>  #1: ffffc900002afdf0 (pcpu_balance_work){+.+.}, at:
>> process_one_work+0x8c0/0x1750 kernel/workqueue.c:2239
>>  #2: ffffffff8943f080 (pcpu_alloc_mutex){+.+.}, at:
>> pcpu_balance_workfn+0xcc/0x13e0 mm/percpu.c:1845
>>  #3: ffffffff89450c78 (vmap_area_lock){+.+.}, at: spin_lock
>> include/linux/spinlock.h:338 [inline]
>>  #3: ffffffff89450c78 (vmap_area_lock){+.+.}, at:
>> pcpu_get_vm_areas+0x1449/0x3df0 mm/vmalloc.c:3431
>> Preemption disabled at:
>> [<ffffffff81a84199>] spin_lock include/linux/spinlock.h:338 [inline]
>> [<ffffffff81a84199>] pcpu_get_vm_areas+0x1449/0x3df0 mm/vmalloc.c:3431
>> CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 5.4.0-next-20191129+ #5
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
>> Workqueue: events pcpu_balance_workfn
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x199/0x216 lib/dump_stack.c:118
>>  ___might_sleep.cold.97+0x1f5/0x238 kernel/sched/core.c:6800
>>  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
>>  prepare_alloc_pages mm/page_alloc.c:4681 [inline]
>>  __alloc_pages_nodemask+0x3cd/0x890 mm/page_alloc.c:4730
>>  alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2211
>>  alloc_pages include/linux/gfp.h:532 [inline]
>>  __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
>>  kasan_populate_vmalloc_pte mm/kasan/common.c:762 [inline]
>>  kasan_populate_vmalloc_pte+0x2f/0x1b0 mm/kasan/common.c:753
>>  apply_to_pte_range mm/memory.c:2041 [inline]
>>  apply_to_pmd_range mm/memory.c:2068 [inline]
>>  apply_to_pud_range mm/memory.c:2088 [inline]
>>  apply_to_p4d_range mm/memory.c:2108 [inline]
>>  apply_to_page_range+0x5ca/0xa00 mm/memory.c:2133
>>  kasan_populate_vmalloc+0x69/0xa0 mm/kasan/common.c:791
>>  pcpu_get_vm_areas+0x1596/0x3df0 mm/vmalloc.c:3439
>>  pcpu_create_chunk+0x240/0x7f0 mm/percpu-vm.c:340
>>  pcpu_balance_workfn+0x1033/0x13e0 mm/percpu.c:1934
>>  process_one_work+0x9b5/0x1750 kernel/workqueue.c:2264
>>  worker_thread+0x8b/0xd20 kernel/workqueue.c:2410
>>  kthread+0x365/0x450 kernel/kthread.c:255
>>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>>
>>
>> Not sure if it's the same or not. Is it addressed by something in flight?

It looks like this one is the same.

There is a patch to fix it:
https://lore.kernel.org/linux-mm/20191120052719.7201-1-dja@axtens.net/

Andrew said he had picked it up on the 22nd:
https://marc.info/?l=linux-mm-commits&m=157438241512561&w=2
It's landed in mmots but not mmotm, so hopefully that will happen and
then it will land in -next very soon!

I will look into your other bug report shortly.

Regards,
Daniel

>>
>> My config:
>> https://gist.githubusercontent.com/dvyukov/36c7be311fdec9cd51c649f7c3cb2ddb/raw/39c6f864fdd0ffc53f0822b14c354a73c1695fa1/gistfile1.txt
>
>
> I've tried this fix for pcpu_get_vm_areas:
> https://groups.google.com/d/msg/kasan-dev/t_F2X1MWKwk/h152Z3q2AgAJ
> and it helps. But this will break syzbot on linux-next soon.
