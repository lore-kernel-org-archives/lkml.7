Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD53DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8FD2190F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfJGOaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:30:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbfJGOaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:30:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9871AF5B;
        Mon,  7 Oct 2019 14:30:02 +0000 (UTC)
Date:   Mon, 7 Oct 2019 16:30:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, mhocko@kernel.org,
        linux-mm@kvack.org, john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570228005-24979-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-10-04 18:26:45, Qian Cai wrote:
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

This code takes locks: sclp_lock --> &(&zone->lock)->rlock

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

This code path takes: console_owner --> sclp_lock

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

And this code path takes: &(&zone->lock)->rlock --> console_owner

> other info that might help us debug this:
> 
> Chain exists of:
>   console_owner --> sclp_lock --> &(&zone->lock)->rlock

All three code paths together create a cyclic dependency. This
is why lockdep reports a possible deadlock.

I believe that it cannot really happen because:

	static int __init
	sclp_console_init(void)
	{
	[...]
		rc = sclp_rw_init();
	[...]
		register_console(&sclp_console);
		return 0;
	}

sclp_rw_init() is called before register_console(). And
console_unlock() will never call sclp_console_write() before
the console is registered.

AFAIK, lockdep only compares existing chain of locks. It does
not know about console registration that would make some
code paths mutually exclusive.

I believe that it is a false positive. I do not know how to
avoid this lockdep report. I hope that it will disappear
by deferring all printk() calls rather soon.

Best Regards,
Petr
