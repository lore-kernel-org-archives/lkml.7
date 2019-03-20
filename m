Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D83BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D322175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCTNgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:36:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:41159 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfCTNgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:36:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 06:36:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="154066609"
Received: from mirmoha-mobl.amr.corp.intel.com ([10.252.205.74])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2019 06:36:52 -0700
Message-ID: <dc177e76fa37dbf759f247f12b3ca33c9ff00bd4.camel@linux.intel.com>
Subject: Re: KASAN use after free
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 20 Mar 2019 08:36:52 -0500
In-Reply-To: <20190319235622.0e76463e@oasis.local.home>
References: <20190319235622.0e76463e@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 2019-03-19 at 23:56 -0400, Steven Rostedt wrote:
> Hi Tom,
> 
> I ran the latest kernel (5.1-rc1) with full KASAN enabled, and ran
> the
> ftrace tests, and hit the following:
> 
> ==================================================================
> BUG: KASAN: use-after-free in destroy_hist_field+0x30/0x70
> Read of size 8 at addr ffff888086df2210 by task bash/1694
> 
> CPU: 6 PID: 1694 Comm: bash Not tainted 5.1.0-rc1-test+ #15
> Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01
> v03.03 07/14/2016
> Call Trace:
>  dump_stack+0x71/0xa0
>  ? destroy_hist_field+0x30/0x70
>  print_address_description.cold.3+0x9/0x1fb
>  ? destroy_hist_field+0x30/0x70
>  ? destroy_hist_field+0x30/0x70
>  kasan_report.cold.4+0x1a/0x33
>  ? __kasan_slab_free+0x100/0x150
>  ? destroy_hist_field+0x30/0x70
>  destroy_hist_field+0x30/0x70
>  track_data_destroy+0x55/0xe0
>  destroy_hist_data+0x1f0/0x350
>  hist_unreg_all+0x203/0x220
>  event_trigger_open+0xbb/0x130
>  do_dentry_open+0x296/0x700
>  ? stacktrace_count_trigger+0x30/0x30
>  ? generic_permission+0x56/0x200
>  ? __x64_sys_fchdir+0xd0/0xd0
>  ? inode_permission+0x55/0x200
>  ? security_inode_permission+0x18/0x60
>  path_openat+0x633/0x22b0
>  ? path_lookupat.isra.50+0x420/0x420
>  ? __kasan_kmalloc.constprop.12+0xc1/0xd0
>  ? kmem_cache_alloc+0xe5/0x260
>  ? getname_flags+0x6c/0x2a0
>  ? do_sys_open+0x149/0x2b0
>  ? do_syscall_64+0x73/0x1b0
>  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  ? _raw_write_lock_bh+0xe0/0xe0
>  ? __kernel_text_address+0xe/0x30
>  ? unwind_get_return_address+0x2f/0x50
>  ? __list_add_valid+0x2d/0x70
>  ? deactivate_slab.isra.62+0x1f4/0x5a0
>  ? getname_flags+0x6c/0x2a0
>  ? set_track+0x76/0x120
>  do_filp_open+0x11a/0x1a0
>  ? may_open_dev+0x50/0x50
>  ? _raw_spin_lock+0x7a/0xd0
>  ? _raw_write_lock_bh+0xe0/0xe0
>  ? __alloc_fd+0x10f/0x200
>  do_sys_open+0x1db/0x2b0
>  ? filp_open+0x50/0x50
>  do_syscall_64+0x73/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fa7b24a4ca2
> Code: 25 00 00 41 00 3d 00 00 41 00 74 4c 48 8d 05 85 7a 0d 00 8b 00
> 85 c0 75 6d 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48>
> 3d 00 f0 ff ff 0f 87 a2 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
> RSP: 002b:00007fffbafb3af0 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000101
> RAX: ffffffffffffffda RBX: 000055d3648ade30 RCX: 00007fa7b24a4ca2
> RDX: 0000000000000241 RSI: 000055d364a55240 RDI: 00000000ffffff9c
> RBP: 00007fffbafb3bf0 R08: 0000000000000020 R09: 0000000000000002
> R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000003 R14: 0000000000000001 R15: 000055d364a55240
> 
> Allocated by task 1694:
>  __kasan_kmalloc.constprop.12+0xc1/0xd0
>  kmem_cache_alloc_trace+0x11a/0x280
>  create_hist_field+0x54/0x460
>  create_var_ref+0x2f/0xb0
>  event_hist_trigger_func+0x19cb/0x26a0
>  event_trigger_write+0x1a7/0x250
>  vfs_write+0xe1/0x240
>  ksys_write+0xa1/0x130
>  do_syscall_64+0x73/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Freed by task 1694:
>  __kasan_slab_free+0x111/0x150
>  kfree+0x8d/0x1c0
>  destroy_hist_data+0x13b/0x350
>  hist_unreg_all+0x203/0x220
>  event_trigger_open+0xbb/0x130
>  do_dentry_open+0x296/0x700
>  path_openat+0x633/0x22b0
>  do_filp_open+0x11a/0x1a0
>  do_sys_open+0x1db/0x2b0
>  do_syscall_64+0x73/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The buggy address belongs to the object at ffff888086df2208
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 8 bytes inside of
>  192-byte region [ffff888086df2208, ffff888086df22c8)
> The buggy address belongs to the page:
> page:ffffea00021b7c00 count:1 mapcount:0 mapping:ffff8880d000cc40
> index:0x0 compound_mapcount: 0
> flags: 0xffff000010200(slab|head)
> raw: 000ffff000010200 ffffea00021b7708 ffffea000312ee08
> ffff8880d000cc40
> raw: 0000000000000000 00000000001e001e 00000001ffffffff
> 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff888086df2100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888086df2180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff888086df2200: fc fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> 
>                          ^
>  ffff888086df2280: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
>  ffff888086df2300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> Disabling lock debugging due to kernel taint
> 
> I can easily reproduce it with the following commands:
> 
> # cd /sys/kernel/debug/tracing
> # echo
> 'hist:keys=pid:vals=hitcount:ts0=common_timestamp.usecs:sort=hitcount
> :size=2048:clock=global if comm=="ping"' > \
>   events/sched/sched_waking/trigger
> # echo
> 'hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-
> $ts0:sort=hitcount:size=2048:clock=global:onmax($wakeup_lat).save(nex
> t_comm,prev_pid,prev_prio,prev_comm) if next_comm=="ping"' > \
>   events/sched/sched_switch/trigger
> # echo
> '!hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-
> $ts0:sort=hitcount:size=2048:clock=global:onmax($wakeup_lat).save(nex
> t_comm,prev_pid,prev_prio,prev_comm) if next_comm=="ping"' > \
>   events/sched/sched_switch/trigger
> 
> And boom, KASAN complains.
> 
> I tried to debug it, but the hist code is rather complex, and I can't
> figure out how the var_refs is associated to the fields. I figured
> I'd
> pass it off to you.

OK, thanks for reporting and trying to debug, will take a look and send
a fix..

Tom

> 
> -- Steve

