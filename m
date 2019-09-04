Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E296C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC8B20449
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="p/FtG1F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfIDVYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:24:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35172 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIDVYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:24:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so247301qth.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vJQh2NC10XsFCn3yA5gEOWEes5fZ0ez3OSO7Jvc0SJY=;
        b=p/FtG1F1lAMzom5b1ia1JeEJUZMRtwKYZOY54Sbmcyv0uSRopmJl3niYgWnvlPJ7ES
         p76aXLTCQsIembQ8qoQp0KJACa2yKGynfjiV9Vm/tZuL1YXVQswbF6f2aXKM92yP7DXB
         T5nOMPfbDD5F3L3Cmu9Mnocb2m2f8HHxTUeru2/fmshglRCZuEwyTCFcWjL9QOSnN/pJ
         0soKjtRKWiIHXCIG11dIMwmL8ZR7MhfMVn7C9yJTvKZnQMhjOkS6k2UdxQuYkSksBKmU
         2tUtr3nqcfTSszV96gI2EkxABksH9eJfi2CkhA6cEbRrYlrvLbAMsWaAWIDrcEIGyV1W
         0uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vJQh2NC10XsFCn3yA5gEOWEes5fZ0ez3OSO7Jvc0SJY=;
        b=p/wXi5k+el3Cm5Jp/E1Gx/8K7cbebLbjfpBYxIfD7bHlNa7/LnpryqJP6+ceEnl2vI
         rwbp2d+Lwu53PfBYxouiHj7MlKNzDpIJKGqhl43oOcks5bkcee2Bc3zwLaEd1Ouj2LBz
         mwZqpWy2THd3eFalI7FFG/qbcmWdJqoXcJq0FTYJyXHws4UmbqzhbG/RlCkQlMth9Fwp
         6dM2x3+KAdjd0vM7I22hJz/jpGckEG4x/2w7m94JDnApX29eOKtUHnn5bfGM/bkTz+kO
         OWYxSy+gxwAidyt/Y0B03sq3kWO7bzwI8KFz8iGULV8uFwNHDVHdm7FROHh27+3Myaj5
         Z/wg==
X-Gm-Message-State: APjAAAUWZdUVJ0GXXl7qs9MuR66ktgJd3q1kK0QhaDr3ir0CtBJgq0+D
        3iDxnkwZqRgh6stWE77z2Oekbw==
X-Google-Smtp-Source: APXvYqwSN7oO5NaLRxSsgPBQxT8virQS/3uqxTlU4qj0cFV7d2QUgugMr3VRfOTwBCGo4pLD7Hj+7Q==
X-Received: by 2002:ac8:6688:: with SMTP id d8mr168489qtp.25.1567632292270;
        Wed, 04 Sep 2019 14:24:52 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f83sm148254qke.80.2019.09.04.14.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 14:24:51 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        don.brace@microsemi.com, esc.storagedev@microsemi.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RFC PATCH] iommu/amd: fix a race in increase_address_space()
Date:   Wed,  4 Sep 2019 17:24:22 -0400
Message-Id: <1567632262-21284-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system is under some memory pressure, it could cause disks on
the "smartpqi" driver going offline below. From the UBSAN report, it
indicates that "domain->mode" becomes 7. Further investigation indicates
that the only place that would increase "domain->mode" is
increase_address_space() but it has this check before actually
increasing it,

	if (domain->mode == PAGE_MODE_6_LEVEL)
		/* address space already 64 bit large */
		return false;

This gives a clue that there must be a race between multiple concurrent
threads in increase_address_space().

In amd_iommu_map() and amd_iommu_unmap(), there is
mutex_lock() and mutex_unlock() around a iommu_map_page(). There are
several places that could call iommu_map_page() with interrupt enabled.
One for sure is alloc_coherent() which call __map_single() that had a
comment said that it needs to hold a lock but not so. I am not sure
about the map_page() and map_sg() where my investigation so far
indicating that many call sites there are in the atomic context.

smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
address=0xff702a00 flags=0x0010]
UBSAN: Undefined behaviour in drivers/iommu/amd_iommu.c:1464:29
shift exponent 66 is too large for 64-bit type 'long unsigned int'
CPU: 39 PID: 821 Comm: kswapd4 Tainted: G           O
5.3.0-rc7-next-20190903+ #4
Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
07/10/2019
Call Trace:
 dump_stack+0x62/0x9a
 ubsan_epilogue+0xd/0x3a
smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
address=0xff702c80 flags=0x0010]
 __ubsan_handle_shift_out_of_bounds.cold.12+0x21/0x68
 iommu_map_page.cold.39+0x7f/0x84
 map_sg+0x1ce/0x2f0
 scsi_dma_map+0xc6/0x160
 pqi_raid_submit_scsi_cmd_with_io_request+0x1c3/0x470 [smartpqi]
smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000
address=0xff702900 flags=0x0010]
 pqi_scsi_queue_command+0x7d6/0xeb0 [smartpqi]
 scsi_queue_rq+0x7ee/0x12b0
 __blk_mq_try_issue_directly+0x295/0x3f0
 blk_mq_try_issue_directly+0xad/0x130
 blk_mq_make_request+0xb12/0xee0
 generic_make_request+0x179/0x4a0
 submit_bio+0xaa/0x270
 __swap_writepage+0x8f5/0xba0
 swap_writepage+0x65/0xb0
 pageout.isra.3+0x3e5/0xa00
 shrink_page_list+0x15a0/0x2660
 shrink_inactive_list+0x373/0x770
 shrink_node_memcg+0x4ff/0x1550
 shrink_node+0x123/0x800
 balance_pgdat+0x493/0x9b0
 kswapd+0x39b/0x7f0
 kthread+0x1df/0x200
 ret_from_fork+0x22/0x40
========================================================================
smartpqi 0000:23:00.0: resetting scsi 0:1:0:0
INFO: task khugepaged:797 blocked for more than 122 seconds.
      Tainted: G           O      5.3.0-rc7-next-20190903+ #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
khugepaged      D22656   797      2 0x80004000
Call Trace:
 __schedule+0x4bb/0xc20
 schedule+0x6c/0x140
 io_schedule+0x21/0x50
 rq_qos_wait+0x18e/0x2b0
 wbt_wait+0x12b/0x1b0
 __rq_qos_throttle+0x3b/0x60
 blk_mq_make_request+0x217/0xee0
 generic_make_request+0x179/0x4a0
 submit_bio+0xaa/0x270
 __swap_writepage+0x8f5/0xba0
 swap_writepage+0x65/0xb0
 pageout.isra.3+0x3e5/0xa00
 shrink_page_list+0x15a0/0x2660
 shrink_inactive_list+0x373/0x770
 shrink_node_memcg+0x4ff/0x1550
 shrink_node+0x123/0x800
 do_try_to_free_pages+0x22f/0x820
 try_to_free_pages+0x242/0x4d0
 __alloc_pages_nodemask+0x9f6/0x1bb0
 khugepaged_alloc_page+0x6f/0xf0
 collapse_huge_page+0x103/0x1060
 khugepaged_scan_pmd+0x840/0xa70
 khugepaged+0x1571/0x18d0
 kthread+0x1df/0x200
 ret_from_fork+0x22/0x40
INFO: task systemd-journal:3112 blocked for more than 123 seconds.
      Tainted: G           O      5.3.0-rc7-next-20190903+ #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
systemd-journal D20744  3112      1 0x00004120
Call Trace:
 __do_page_cache_readahead+0x149/0x3a0
 filemap_fault+0x9da/0x1050
 __xfs_filemap_fault+0x167/0x450 [xfs]
 xfs_filemap_fault+0x68/0x70 [xfs]
 __do_fault+0x83/0x220
 __handle_mm_fault+0x1034/0x1a50
 handle_mm_fault+0x17f/0x37e
 __do_page_fault+0x369/0x630
 do_page_fault+0x50/0x2d3
 page_fault+0x2f/0x40
RIP: 0033:0x56088e81faa0
Code: Bad RIP value.
RSP: 002b:00007ffdc2158ba8 EFLAGS: 000102_iter+0x135/0x850
 shrink_node+0x123/0x800
 do_try_to_free_pages+0x22f/0x820
 try_to_free_pages+0x242/0x4d0
 __alloc_pages_nodemask+0x9f6/0x1bb0
[11967.13967  __swap_writepage+0x8f5/0xba0
 swap_writepage+0x65/0xb0
 pageout.isra.3+0x3e5/0xa00
 shrink_page_list+0x15a0/0x2660
 io_schedule+0x21/0x50
 rq_qos_wait+0x18e/0x2b0
 wbt_wait+0x12b/0x1b0
 __rq_qos_throttle+0x3b/0x60
 blk_mq_make_request+0x217/0xee0
 schedule+0x6c/0x140
 io_schedule+0x21/0x50
 rq_qos_wait+0x18e/0x2b0
 wbt_wait+0x12b/0x1b0
 __rq_qos_throttle+0x3b/0x60
 blk_mq_make_request+0x217/0xee0
[11968.69198.0+0x60/0x60
 swap_writepage+0x65/0xb0
 pageout.isra.3+0x3e5/0xa00
 shrink_page_list+0x15a0/0x2660
 generic_make_request+0x179/0x4a0
 submit_bio+0xaa/0x270
 __swap_writepage+0x8f5/0xba0
 swap_writepage+0x65/0xb0
 pageout.isra.3+0x3e5/0xa00
 __swap_writepage+0x8f5/0xba0
 swap_writepage+0x65/0xb0
 pageout.isra.3+0x3e5/0xa00
 shrink_page_list+0x15a0/0x2660
 wbt_wait+0x12b/0x1b0
 __rq_qos_throttle+0x3b/0x60
 blk_mq_make_request+0x217/0xee0
 generic_make_request+0x179/0x4a0
 submit_bio+0xaa/0x270
 __swap_writepage+0x8f5/0xba0
1 lock held by khungtaskd/791:
 #0: ffffffffa1b8b360 (rcu_read_lock){....}, at:
debug_show_all_locks+0x33/0x16a
1 lock held by khugepaged/797:
 #0: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by kswapd0/820:
 #0: ffffffffa1cc55c0 (fs_reclaim){....}, at:
__fs_reclaim_acquire+0x5/0x30
 #1: ffff88846fa43538 (&md->io_barrier){....}, at:
dm_get_live_table+0x5/0x70 [dm_mod]
2 locks held by kswapd4/821:
 #0: ffffffffa1cc55c0 (fs_reclaim){....}, at:
__fs_reclaim_acquire+0x5/0x30
 #1: ffff88846fa43538 (&md->io_barrier){....}, at:
dm_get_live_table+0x5/0x70 [dm_mod]
1 lock held by scsi_eh_0/1577:
 #0: ffff8884cb52cca0 (&ctrl_info->lun_reset_mutex){....}, at:
pqi_eh_device_reset_handler+0x313/0x970 [smartpqi]
[11acquire.part.15+0x5/0x30
2 locks held by oom01/121253:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121254:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121255:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121256:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
[11971.6650x5/0x30
2 locks held by oom01/121278:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121279:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121280:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121281:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acqfffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121299:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121300:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121301:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121302:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, 2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121320:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121321:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121322:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121323:
 #0: ffff888338118840 (&om01/121340:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121341:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121342:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121343:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121366:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121367:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121368:
 #0: ffff888338118840 (&mm->mmap_sem#2){....}, at:
__do_page_fault+0x18e/0x630
 #1: ffffffffa1cc55c0 (fs_reclaim){....}, at:
fs_reclaim_acquire.part.15+0x5/0x30
2 locks held by oom01/121369:
smartpqi 0000:23:00.0: no heartbeat detected - last heartbeat count:
11794
smartpqi 0000:23:00.0: controller offline
smartpqi 0000:23:00.0: reset of scsi 0:1:0:0: FAILED
sd 0:1:0:0: Device offlined - not ready after error recovery
sd 0:1:0:0: Device offlined - not ready after error recovery
sd 0:1:0:0: Device offlined - not ready after error recovery
sd 0:1:0:0: Device offlined - not ready after error recovery
sd 0:1:0:0: Device offlined - not ready after error recovery
sd 0:1:0:0: Device offlined - not ready after error recovery
sd 0:1:0:0: Device offlined - not ready after error recovery
========================================================================
sd 0:1:0:0: Device offlined - not ready after error recovery
UBSAN: Undefined behaviour in drivers/iommu/amd_iommu.c:1526:28
shift exponent 66 is too large for 64-bit type 'long unsigned int'
CPU: 8 PID: 49038 Comm: kworker/8:0 Tainted: G           O
5.3.0-rc7-next-20190903+ #4
Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
07/10/2019
sd 0:1:0:0: Device offlined - not ready after error recovery
Workqueue: events pqi_ctrl_offline_worker [smartpqi]
sd 0:1:0:0: Device offlined - not ready after error recovery
Call Trace:
 dump_stack+0x62/0x9a
 ubsan_epilogue+0xd/0x3a
sd 0:1:0:0: Device offlined - not ready after error recovery
 __ubsan_handle_shift_out_of_bounds.cold.12+0x21/0x68
 fetch_pte.cold.23+0x9c/0xcf
 iommu_unmap_page+0xcd/0x180
sd 0:1:0:0: Device offlined - not ready after error recovery
 __unmap_single.isra.18+0x6a/0x120
 unmap_sg+0x74/0x90
 scsi_dma_unmap+0xdc/0x140
sd 0:1:0:0: Device offlined - not ready after error recovery
 pqi_raid_io_complete+0x2d/0x60 [smartpqi]
 pqi_ctrl_offline_worker+0x128/0x270 [smartpqi]
sd 0:1:0:0: Device offlined - not ready after error recovery
 process_one_work+0x53b/0xa70
 worker_thread+0x63/0x5b0
 kthread+0x1df/0x200
sd 0:1:0:0: Device offlined - not ready after error recovery
sd 0:1:0:0: Device offlined - not ready after error recovery
sd 0:1:0:0: Device offlined - not ready after error recovery
 ret_from_fork+0x22/0x40
sd 0:1:0:0: Device offlined - not ready after error recovery
========================================================================
sd 0:1:0:0: Device offlined - not ready after error recovery
========================================================================
sd 0:1:0:0: Device offlined - not ready after error recovery
UBSAN: Undefined behaviour in drivers/iommu/amd_iommu.c:1527:16
shift exponent 66 is too large for 64-bit type 'long long unsigned int'
CPU: 8 PID: 49038 Comm: kworker/8:0 Tainted: G           O
5.3.0-rc7-next-20190903+ #4
sd 0:1:0:0: Device offlined - not ready after error recovery
Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
07/10/2019
Workqueue: events pqi_ctrl_offline_worker [smartpqi]
Call Trace:
 dump_stack+0x62/0x9a
sd 0:1:0:0: Device offlined - not ready after error recovery
 ubsan_epilogue+0xd/0x3a
sd 0:1:0:0: Device offlined - not ready after error recovery
 __ubsan_handle_shift_out_of_bounds.cold.12+0x21/0x68
sd 0:1:0:0: Device offlined - not ready after error recovery
 fetch_pte.cold.23+0xca/0xcf
 iommu_unmap_page+0xcd/0x180
 __unmap_single.isra.18+0x6a/0x120
sd 0:1:0:0: Device offlined - not ready after error recovery
 unmap_sg+0x74/0x90
sd 0:1:0:0: Device offlined - not ready after error recovery
 scsi_dma_unmap+0xdc/0x140
 pqi_raid_io_complete+0x2d/0x60 [smartpqi]
 pqi_ctrl_offline_worker+0x128/0x270 [smartpqi]
sd 0:1:0:0: Device offlined - not ready after error recovery
 process_one_work+0x53b/0xa70
 worker_thread+0x63/0x5b0
 kthread+0x1df/0x200
sd 0:1:0:0: Device offlined - not ready after error recovery
sd 0:1:0:0: Device offlined - not ready after error recovery
 ret_from_fork+0x22/0x40
========================================================================
sd 0:1:0:0: rejecting I/O to offline device
sd 0:1:0:0: Device offlined - not ready after error recovery
blk_update_request: I/O error, dev sda, 43208)
Write-error on swap-device (254:1:29843216)
Write-error on swap-device (254:1:29843224)
Write-error on swap-device (254:1:29843232)
Write-error on swap-device (254:1:29843240)
---
 drivers/iommu/amd_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b607a92791d3..3874a0f5e197 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2660,8 +2660,10 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	if (!dma_mask)
 		dma_mask = *dev->dma_mask;
 
+	mutex_lock(&domain->api_lock);
 	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
 				 size, DMA_BIDIRECTIONAL, dma_mask);
+	mutex_unlock(&domain->api_lock);
 
 	if (*dma_addr == DMA_MAPPING_ERROR)
 		goto out_free;
@@ -2696,7 +2698,9 @@ static void free_coherent(struct device *dev, size_t size,
 
 	dma_dom = to_dma_ops_domain(domain);
 
+	mutex_lock(&domain->api_lock);
 	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
+	mutex_unlock(&domain->api_lock);
 
 free_mem:
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-- 
1.8.3.1

