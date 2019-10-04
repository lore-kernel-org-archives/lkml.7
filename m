Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82013C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50115215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GfJc5hEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfJDQmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:42:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44126 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDQmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:42:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so6357888qkk.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=unSFjTLbf9GQT7sy0kNzX1d4U0PWNRJ2KKIBperdV9c=;
        b=GfJc5hEogfHv3dvtWQmwNQdiYbSLo2AgOZOIoAxWno6ebkUjo/B+FmXJRydZNbRNKW
         skICGP9GJCLqaEHK4Bd0SwtAYsWZ5HZniR7jiOefPED2Kl3TJWrfPNBrPyoxSSBkZolF
         aCfIN/OZHmkA9r2Uo+xUEIeJ2MDOKM80pX5jtnEPLSU5VySgZrcgMPLGKmCaI466l1mL
         uYpTVpz4pps1R3ww3/9ofYhyIK6v/PZ/S8og7Ytd+6i1RD0JUrqnlCVpwq5rcWUkehyi
         erSFeXxaJ5rdo0b9IGNaK5fEr7uTW0ZB2g52Az9wqX5LlEO5D824cM9hkbIO1DscHqdi
         FYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=unSFjTLbf9GQT7sy0kNzX1d4U0PWNRJ2KKIBperdV9c=;
        b=bsyrPHzyDtzOVzqVq0YEXXfqnLf4+kjof1DmcaBE7+/mq3E9KZkmq+p3J5NRNtx/6J
         igd5pbcmPSqMatkIuLJreM7LI4dm+Yj1IgsFWZ6oovOnnsquWBIieepWQ/V4vFAnwoPo
         IHp8xXLDS+W48wKV5ADMN6TV9tVKGR1BAhqZBC2qkK9OC+1TJ7fiSnNMFZcZK409ivxx
         GPeNO6HSl6XJ8jIlqRNP51DQ9Ij+MwvIt0rhHO3p5WDL4WTZta1AIUE5CjNnmkdqkPol
         dSxHHoEH+gDsJvDBk1z5X86dxSYvFiQhMvwrM2iHXtx+ryL4BuG3xhocqHVj+7lpveGn
         p9PQ==
X-Gm-Message-State: APjAAAXfpb3Xtos+DLzdhPdMgxGO+TjDnyJD4FsDrgJcVYk2QCqqhA2u
        390Wj0rqSHFs4jOm4vhedu2TKQ==
X-Google-Smtp-Source: APXvYqythj5h0hXoBiFZ+aqb2E82KtTnWBQy/T+8LXD87nNU4JmLrbWPfJCfaGag/bQueQjJllywmA==
X-Received: by 2002:a37:a083:: with SMTP id j125mr11495979qke.329.1570207369611;
        Fri, 04 Oct 2019 09:42:49 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 29sm3344748qkp.86.2019.10.04.09.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 09:42:48 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/page_isolation: fix a deadlock with printk()
Date:   Fri,  4 Oct 2019 12:42:26 -0400
Message-Id: <1570207346-30477-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unsafe to call printk() while zone->lock was held, i.e.,

zone->lock --> console_sem

because the console could always allocate some memory in different code
paths and form locking chains in an opposite order,

console_sem --> * --> zone->lock

As the result, it triggers lockdep splats like below and in [1]. It is
fine to take zone->lock after has_unmovable_pages() (which has
dump_stack()) in set_migratetype_isolate(). While at it, remove a
problematic printk() in __offline_isolated_pages() only for debugging as
well which will always disable lockdep on debug kernels.

The problem is probably there forever, but neither many developers will
run memory offline with the lockdep enabled nor admins in the field are
lucky enough yet to hit a perfect timing which required to trigger a
real deadlock. In addition, there aren't many places that call printk()
while zone->lock was held.

WARNING: possible circular locking dependency detected
------------------------------------------------------
test.sh/1724 is trying to acquire lock:
0000000052059ec0 (console_owner){-...}, at: console_unlock+0x
01: 328/0xa30

but task is already holding lock:
000000006ffd89c8 (&(&zone->lock)->rlock){-.-.}, at: start_iso
01: late_page_range+0x216/0x538

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&(&zone->lock)->rlock){-.-.}:
       lock_acquire+0x21a/0x468
       _raw_spin_lock+0x54/0x68
       get_page_from_freelist+0x8b6/0x2d28
       __alloc_pages_nodemask+0x246/0x658
       __get_free_pages+0x34/0x78
       sclp_init+0x106/0x690
       sclp_register+0x2e/0x248
       sclp_rw_init+0x4a/0x70
       sclp_console_init+0x4a/0x1b8
       console_init+0x2c8/0x410
       start_kernel+0x530/0x6a0
       startup_continue+0x70/0xd0

-> #1 (sclp_lock){-.-.}:
       lock_acquire+0x21a/0x468
       _raw_spin_lock_irqsave+0xcc/0xe8
       sclp_add_request+0x34/0x308
       sclp_conbuf_emit+0x100/0x138
       sclp_console_write+0x96/0x3b8
       console_unlock+0x6dc/0xa30
       vprintk_emit+0x184/0x3c8
       vprintk_default+0x44/0x50
       printk+0xa8/0xc0
       iommu_debugfs_setup+0xf2/0x108
       iommu_init+0x6c/0x78
       do_one_initcall+0x162/0x680
       kernel_init_freeable+0x4e8/0x5a8
       kernel_init+0x2a/0x188
       ret_from_fork+0x30/0x34
       kernel_thread_starter+0x0/0xc

-> #0 (console_owner){-...}:
       check_noncircular+0x338/0x3e0
       __lock_acquire+0x1e66/0x2d88
       lock_acquire+0x21a/0x468
       console_unlock+0x3a6/0xa30
       vprintk_emit+0x184/0x3c8
       vprintk_default+0x44/0x50
       printk+0xa8/0xc0
       __dump_page+0x1dc/0x710
       dump_page+0x2e/0x58
       has_unmovable_pages+0x2e8/0x470
       start_isolate_page_range+0x404/0x538
       __offline_pages+0x22c/0x1338
       memory_subsys_offline+0xa6/0xe8
       device_offline+0xe6/0x118
       state_store+0xf0/0x110
       kernfs_fop_write+0x1bc/0x270
       vfs_write+0xce/0x220
       ksys_write+0xea/0x190
       system_call+0xd8/0x2b4

other info that might help us debug this:

Chain exists of:
  console_owner --> sclp_lock --> &(&zone->lock)->rlock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&zone->lock)->rlock);
                               lock(sclp_lock);
                               lock(&(&zone->lock)->rlock);
  lock(console_owner);

 *** DEADLOCK ***

9 locks held by test.sh/1724:
 #0: 000000000e925408 (sb_writers#4){.+.+}, at: vfs_write+0x201:
 #1: 0000000050aa4280 (&of->mutex){+.+.}, at: kernfs_fop_write:
 #2: 0000000062e5c628 (kn->count#198){.+.+}, at: kernfs_fop_write
 #3: 00000000523236a0 (device_hotplug_lock){+.+.}, at:
lock_device_hotplug_sysfs+0x30/0x80
 #4: 0000000062e70990 (&dev->mutex){....}, at: device_offline
 #5: 0000000051fd36b0 (cpu_hotplug_lock.rw_sem){++++}, at:
__offline_pages+0xec/0x1338
 #6: 00000000521ca470 (mem_hotplug_lock.rw_sem){++++}, at:
percpu_down_write+0x38/0x210
 #7: 000000006ffd89c8 (&(&zone->lock)->rlock){-.-.}, at:
start_isolate_page_range+0x216/0x538
 #8: 000000005205a100 (console_lock){+.+.}, at: vprintk_emit

stack backtrace:
Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
Call Trace:
([<00000000512ae218>] show_stack+0x110/0x1b0)
 [<0000000051b6d506>] dump_stack+0x126/0x178
 [<00000000513a4b08>] check_noncircular+0x338/0x3e0
 [<00000000513aaaf6>] __lock_acquire+0x1e66/0x2d88
 [<00000000513a7e12>] lock_acquire+0x21a/0x468
 [<00000000513bb2fe>] console_unlock+0x3a6/0xa30
 [<00000000513bde2c>] vprintk_emit+0x184/0x3c8
 [<00000000513be0b4>] vprintk_default+0x44/0x50
 [<00000000513beb60>] printk+0xa8/0xc0
 [<000000005158c364>] __dump_page+0x1dc/0x710
 [<000000005158c8c6>] dump_page+0x2e/0x58
 [<00000000515d87c8>] has_unmovable_pages+0x2e8/0x470
 [<000000005167072c>] start_isolate_page_range+0x404/0x538
 [<0000000051b96de4>] __offline_pages+0x22c/0x1338
 [<0000000051908586>] memory_subsys_offline+0xa6/0xe8
 [<00000000518e561e>] device_offline+0xe6/0x118
 [<0000000051908170>] state_store+0xf0/0x110
 [<0000000051796384>] kernfs_fop_write+0x1bc/0x270
 [<000000005168972e>] vfs_write+0xce/0x220
 [<0000000051689b9a>] ksys_write+0xea/0x190
 [<0000000051ba9990>] system_call+0xd8/0x2b4
INFO: lockdep is turned off.

[1] https://lore.kernel.org/lkml/1568817579.5576.172.camel@lca.pw/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_alloc.c     |  4 ----
 mm/page_isolation.c | 10 +++++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 15c2050c629b..232bbb1dc521 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8588,10 +8588,6 @@ void zone_pcp_reset(struct zone *zone)
 		BUG_ON(!PageBuddy(page));
 		order = page_order(page);
 		offlined_pages += 1 << order;
-#ifdef CONFIG_DEBUG_VM
-		pr_info("remove from free list %lx %d %lx\n",
-			pfn, 1 << order, end_pfn);
-#endif
 		del_page_from_free_area(page, &zone->free_area[order]);
 		for (i = 0; i < (1 << order); i++)
 			SetPageReserved((page+i));
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 89c19c0feadb..8682ccb5fbd1 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -25,8 +25,6 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 
 	zone = page_zone(page);
 
-	spin_lock_irqsave(&zone->lock, flags);
-
 	/*
 	 * We assume the caller intended to SET migrate type to isolate.
 	 * If it is already set, then someone else must have raced and
@@ -74,16 +72,18 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 		int mt = get_pageblock_migratetype(page);
 
 		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
+
+		spin_lock_irqsave(&zone->lock, flags);
 		zone->nr_isolate_pageblock++;
 		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE,
 									NULL);
 
 		__mod_zone_freepage_state(zone, -nr_pages, mt);
-	}
+		spin_unlock_irqrestore(&zone->lock, flags);
 
-	spin_unlock_irqrestore(&zone->lock, flags);
-	if (!ret)
 		drain_all_pages(zone);
+	}
+
 	return ret;
 }
 
-- 
1.8.3.1

