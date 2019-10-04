Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C909C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27995215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbfJDRr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:47:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJDRr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:47:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F05430607E5;
        Fri,  4 Oct 2019 17:47:58 +0000 (UTC)
Received: from [10.36.116.35] (ovpn-116-35.ams2.redhat.com [10.36.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F61B5C1B5;
        Fri,  4 Oct 2019 17:47:56 +0000 (UTC)
Subject: Re: [PATCH] mm/page_isolation: fix a deadlock with printk()
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1570207346-30477-1-git-send-email-cai@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ada55387-82f4-57a0-cc8f-92b021d262c6@redhat.com>
Date:   Fri, 4 Oct 2019 19:47:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570207346-30477-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 04 Oct 2019 17:47:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.19 18:42, Qian Cai wrote:
> It is unsafe to call printk() while zone->lock was held, i.e.,
> 
> zone->lock --> console_sem
> 
> because the console could always allocate some memory in different code
> paths and form locking chains in an opposite order,
> 
> console_sem --> * --> zone->lock
> 
> As the result, it triggers lockdep splats like below and in [1]. It is
> fine to take zone->lock after has_unmovable_pages() (which has
> dump_stack()) in set_migratetype_isolate(). While at it, remove a
> problematic printk() in __offline_isolated_pages() only for debugging as
> well which will always disable lockdep on debug kernels.
> 
> The problem is probably there forever, but neither many developers will
> run memory offline with the lockdep enabled nor admins in the field are
> lucky enough yet to hit a perfect timing which required to trigger a
> real deadlock. In addition, there aren't many places that call printk()
> while zone->lock was held.
> 
> WARNING: possible circular locking dependency detected
> ------------------------------------------------------
> test.sh/1724 is trying to acquire lock:
> 0000000052059ec0 (console_owner){-...}, at: console_unlock+0x
> 01: 328/0xa30
> 
> but task is already holding lock:
> 000000006ffd89c8 (&(&zone->lock)->rlock){-.-.}, at: start_iso
> 01: late_page_range+0x216/0x538
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&(&zone->lock)->rlock){-.-.}:
>        lock_acquire+0x21a/0x468
>        _raw_spin_lock+0x54/0x68
>        get_page_from_freelist+0x8b6/0x2d28
>        __alloc_pages_nodemask+0x246/0x658
>        __get_free_pages+0x34/0x78
>        sclp_init+0x106/0x690
>        sclp_register+0x2e/0x248
>        sclp_rw_init+0x4a/0x70
>        sclp_console_init+0x4a/0x1b8
>        console_init+0x2c8/0x410
>        start_kernel+0x530/0x6a0
>        startup_continue+0x70/0xd0
> 
> -> #1 (sclp_lock){-.-.}:
>        lock_acquire+0x21a/0x468
>        _raw_spin_lock_irqsave+0xcc/0xe8
>        sclp_add_request+0x34/0x308
>        sclp_conbuf_emit+0x100/0x138
>        sclp_console_write+0x96/0x3b8
>        console_unlock+0x6dc/0xa30
>        vprintk_emit+0x184/0x3c8
>        vprintk_default+0x44/0x50
>        printk+0xa8/0xc0
>        iommu_debugfs_setup+0xf2/0x108
>        iommu_init+0x6c/0x78
>        do_one_initcall+0x162/0x680
>        kernel_init_freeable+0x4e8/0x5a8
>        kernel_init+0x2a/0x188
>        ret_from_fork+0x30/0x34
>        kernel_thread_starter+0x0/0xc
> 
> -> #0 (console_owner){-...}:
>        check_noncircular+0x338/0x3e0
>        __lock_acquire+0x1e66/0x2d88
>        lock_acquire+0x21a/0x468
>        console_unlock+0x3a6/0xa30
>        vprintk_emit+0x184/0x3c8
>        vprintk_default+0x44/0x50
>        printk+0xa8/0xc0
>        __dump_page+0x1dc/0x710
>        dump_page+0x2e/0x58
>        has_unmovable_pages+0x2e8/0x470
>        start_isolate_page_range+0x404/0x538
>        __offline_pages+0x22c/0x1338
>        memory_subsys_offline+0xa6/0xe8
>        device_offline+0xe6/0x118
>        state_store+0xf0/0x110
>        kernfs_fop_write+0x1bc/0x270
>        vfs_write+0xce/0x220
>        ksys_write+0xea/0x190
>        system_call+0xd8/0x2b4
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   console_owner --> sclp_lock --> &(&zone->lock)->rlock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&zone->lock)->rlock);
>                                lock(sclp_lock);
>                                lock(&(&zone->lock)->rlock);
>   lock(console_owner);
> 
>  *** DEADLOCK ***
> 
> 9 locks held by test.sh/1724:
>  #0: 000000000e925408 (sb_writers#4){.+.+}, at: vfs_write+0x201:
>  #1: 0000000050aa4280 (&of->mutex){+.+.}, at: kernfs_fop_write:
>  #2: 0000000062e5c628 (kn->count#198){.+.+}, at: kernfs_fop_write
>  #3: 00000000523236a0 (device_hotplug_lock){+.+.}, at:
> lock_device_hotplug_sysfs+0x30/0x80
>  #4: 0000000062e70990 (&dev->mutex){....}, at: device_offline
>  #5: 0000000051fd36b0 (cpu_hotplug_lock.rw_sem){++++}, at:
> __offline_pages+0xec/0x1338
>  #6: 00000000521ca470 (mem_hotplug_lock.rw_sem){++++}, at:
> percpu_down_write+0x38/0x210
>  #7: 000000006ffd89c8 (&(&zone->lock)->rlock){-.-.}, at:
> start_isolate_page_range+0x216/0x538
>  #8: 000000005205a100 (console_lock){+.+.}, at: vprintk_emit
> 
> stack backtrace:
> Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
> Call Trace:
> ([<00000000512ae218>] show_stack+0x110/0x1b0)
>  [<0000000051b6d506>] dump_stack+0x126/0x178
>  [<00000000513a4b08>] check_noncircular+0x338/0x3e0
>  [<00000000513aaaf6>] __lock_acquire+0x1e66/0x2d88
>  [<00000000513a7e12>] lock_acquire+0x21a/0x468
>  [<00000000513bb2fe>] console_unlock+0x3a6/0xa30
>  [<00000000513bde2c>] vprintk_emit+0x184/0x3c8
>  [<00000000513be0b4>] vprintk_default+0x44/0x50
>  [<00000000513beb60>] printk+0xa8/0xc0
>  [<000000005158c364>] __dump_page+0x1dc/0x710
>  [<000000005158c8c6>] dump_page+0x2e/0x58
>  [<00000000515d87c8>] has_unmovable_pages+0x2e8/0x470
>  [<000000005167072c>] start_isolate_page_range+0x404/0x538
>  [<0000000051b96de4>] __offline_pages+0x22c/0x1338
>  [<0000000051908586>] memory_subsys_offline+0xa6/0xe8
>  [<00000000518e561e>] device_offline+0xe6/0x118
>  [<0000000051908170>] state_store+0xf0/0x110
>  [<0000000051796384>] kernfs_fop_write+0x1bc/0x270
>  [<000000005168972e>] vfs_write+0xce/0x220
>  [<0000000051689b9a>] ksys_write+0xea/0x190
>  [<0000000051ba9990>] system_call+0xd8/0x2b4
> INFO: lockdep is turned off.
> 
> [1] https://lore.kernel.org/lkml/1568817579.5576.172.camel@lca.pw/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/page_alloc.c     |  4 ----
>  mm/page_isolation.c | 10 +++++-----
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 15c2050c629b..232bbb1dc521 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8588,10 +8588,6 @@ void zone_pcp_reset(struct zone *zone)
>  		BUG_ON(!PageBuddy(page));
>  		order = page_order(page);
>  		offlined_pages += 1 << order;
> -#ifdef CONFIG_DEBUG_VM
> -		pr_info("remove from free list %lx %d %lx\n",
> -			pfn, 1 << order, end_pfn);
> -#endif
>  		del_page_from_free_area(page, &zone->free_area[order]);
>  		for (i = 0; i < (1 << order); i++)
>  			SetPageReserved((page+i));
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 89c19c0feadb..8682ccb5fbd1 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -25,8 +25,6 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  
>  	zone = page_zone(page);
>  
> -	spin_lock_irqsave(&zone->lock, flags);
> -
>  	/*
>  	 * We assume the caller intended to SET migrate type to isolate.
>  	 * If it is already set, then someone else must have raced and
> @@ -74,16 +72,18 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  		int mt = get_pageblock_migratetype(page);
>  
>  		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
> +
> +		spin_lock_irqsave(&zone->lock, flags);

The migratetype has to be tested and set under lock, otherwise two
clients could race. I don't like such severe locking changes just to
make some printing we only need for debugging work.

Can't we somehow return some information (page / cause) from
has_unmovable_pages() and print from a save place instead?

To fix the BUG, I would much rather want to see all printing getting
ripped out instead. That's easy to backort.

We can then come back and think about how to log such stuff in order to
debug it.

-- 

Thanks,

David / dhildenb
