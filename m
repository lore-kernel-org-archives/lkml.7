Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431AEC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117802133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570435668;
	bh=9VMlwZg1cGe1XTqvSRrybnr8zC4o8PtodXQXLBKYQmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vflorRp/s79PLA2FrFxP5dq8IavDiCJYJT4z0fLT17ms3c3OtI5dClH+k99t5aww9
	 yn0ftTGj7sAy/SMQf2jzDsp4xPQBv+P+z2cTPnaGs8GeSRUJU/0nmjPW4jKt4nAm+n
	 fKMA0DZsi9HIAZOGEa81CTjwurzcPHQPBQQPfgBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfJGIHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:07:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:52942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbfJGIHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:07:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C63AEACC9;
        Mon,  7 Oct 2019 08:07:43 +0000 (UTC)
Date:   Mon, 7 Oct 2019 10:07:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, john.ogness@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191007080742.GD2381@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570228005-24979-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 18:26:45, Qian Cai wrote:
> It is unsafe to call printk() while zone->lock was held, i.e.,
> 
> zone->lock --> console_lock
> 
> because the console could always allocate some memory in different code
> paths and form locking chains in an opposite order,
> 
> console_lock --> * --> zone->lock
> 
> As the result, it triggers lockdep splats like below and in different
> code paths in this thread [1]. Since has_unmovable_pages() was only used
> in set_migratetype_isolate() and is_pageblock_removable_nolock(). Only
> the former will set the REPORT_FAILURE flag which will call printk().
> Hence, unlock the zone->lock just before the dump_page() there where
> when has_unmovable_pages() returns true, there is no need to hold the
> lock anyway in the rest of set_migratetype_isolate().
> 
> While at it, remove a problematic printk() in __offline_isolated_pages()
> only for debugging as well which will always disable lockdep on debug
> kernels.

I do not think that removing the printk is the right long term solution.
While I do agree that removing the debugging printk __offline_isolated_pages
does make sense because it is essentially of a very limited use, this
doesn't really solve the underlying problem.  There are likely other
printks from zone->lock. It would be much more saner to actually
disallow consoles to allocate any memory while printk is called from an
atomic context.

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

I am also wondering what does this lockdep report actually say. How come
we have a dependency between a start_kernel path and a syscall?

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
-- 
Michal Hocko
SUSE Labs
