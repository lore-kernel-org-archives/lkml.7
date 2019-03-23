Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45473C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC43821902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfCWPwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:52:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53948 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCWPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:52:22 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1h7iwV-0004JO-FT; Sat, 23 Mar 2019 09:52:19 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1h7iwU-0001y4-0c; Sat, 23 Mar 2019 09:52:19 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>
Cc:     dvyukov@google.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <000000000000f4efae0584be37ab@google.com>
Date:   Sat, 23 Mar 2019 10:51:45 -0500
In-Reply-To: <000000000000f4efae0584be37ab@google.com> (syzbot's message of
        "Sat, 23 Mar 2019 00:50:00 -0700")
Message-ID: <875zs9oage.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1h7iwU-0001y4-0c;;;mid=<875zs9oage.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18YeBnoNbf6+00Wx+/D3NQjUwIM+RsCWVs=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: WARNING in request_end
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com> writes:

> syzbot has bisected this bug to:

Nope.  syzbot got it wrong.

At most that commit will allow a larger class of users to mount fuse
and thus be able to reproduce the problem.

It does look like syzbot has found something concerning though.

Miklos any ideas?



> commit 4ad769f3c346ec3d458e255548dec26ca5284cf6
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue May 29 14:04:46 2018 +0000
>
>     fuse: Allow fully unprivileged mounts
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b4518b200000
> start commit:   0238df64 Linux 4.19-rc7
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15b4518b200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b4518b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
> dashboard link: https://syzkaller.appspot.com/bug?extid=ef054c4d3f64cd7f7cec
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bf2e6400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1760f806400000
>
> Reported-by: syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com
> Fixes: 4ad769f3c346 ("fuse: Allow fully unprivileged mounts")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


From https://syzkaller.appspot.com/x/report.txt?x=15b4518b200000
> [  448.045793] ==================================================================
> [  448.053414] BUG: KASAN: use-after-free in fuse_dev_do_read.isra.24+0x166f/0x1be0
> [  448.060937] Read of size 8 at addr ffff8801cec98430 by task syz-executor0/9001
> [  448.068286] 
> [  448.069901] CPU: 1 PID: 9001 Comm: syz-executor0 Not tainted 4.16.0-rc6+ #1
> [  448.076990] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> [  448.086330] Call Trace:
> [  448.089107]  dump_stack+0x153/0x201
> [  448.092926]  ? arch_local_irq_restore+0x43/0x43
> [  448.097579]  ? printk+0x9a/0xc0
> [  448.100844]  ? show_regs_print_info+0xb/0xb
> [  448.105265]  print_address_description.cold.7+0x9/0x1c9
> [  448.110739]  kasan_report.cold.8+0x242/0x2fe
> [  448.115255]  ? fuse_dev_do_read.isra.24+0x166f/0x1be0
> [  448.120476]  __asan_report_load8_noabort+0x14/0x20
> [  448.125393]  fuse_dev_do_read.isra.24+0x166f/0x1be0
> [  448.130397]  ? debug_check_no_locks_freed+0x310/0x310
> [  448.135574]  ? end_requests+0x470/0x470
> [  448.139529]  ? print_usage_bug+0xc0/0xc0
> [  448.143576]  ? prepare_to_wait+0x4f0/0x4f0
> [  448.147932]  ? print_usage_bug+0xc0/0xc0
> [  448.152139]  ? __unqueue_futex+0x270/0x270
> [  448.156376]  ? add_lock_to_list.isra.29+0x4b0/0x4b0
> [  448.161703]  ? wake_up_q+0x9c/0xe0
> [  448.165236]  ? futex_wake+0x245/0x8a0
> [  448.169025]  ? find_held_lock+0x36/0x1c0
> [  448.173085]  ? aa_file_perm+0x319/0xda0
> [  448.177065]  ? lock_downgrade+0x900/0x900
> [  448.181241]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [  448.185813]  ? debug_smp_processor_id+0x17/0x20
> [  448.190557]  ? rcu_is_watching+0x69/0x180
> [  448.194700]  ? __lock_is_held+0xb5/0x140
> [  448.198859]  ? rcu_dynticks_eqs_exit+0x70/0x70
> [  448.203436]  ? aa_file_perm+0x336/0xda0
> [  448.207393]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [  448.211958]  ? aa_path_link+0x610/0x610
> [  448.215913]  ? rcu_dynticks_eqs_exit+0x70/0x70
> [  448.220485]  ? memset+0x31/0x40
> [  448.223752]  fuse_dev_read+0x185/0x240
> [  448.227665]  ? fuse_dev_splice_read+0x7a0/0x7a0
> [  448.232375]  ? find_held_lock+0x36/0x1c0
> [  448.236439]  __vfs_read+0x54a/0xd20
> [  448.240161]  ? debug_lockdep_rcu_enabled+0x77/0x90
> [  448.245069]  ? vfs_copy_file_range+0xb60/0xb60
> [  448.249737]  ? fsnotify_first_mark+0x280/0x280
> [  448.254360]  ? rw_verify_area+0xb8/0x2b0
> [  448.258411]  ? __fdget_raw+0x10/0x10
> [  448.262151]  vfs_read+0xf5/0x300
> [  448.265509]  SyS_read+0xf5/0x250
> [  448.268860]  ? kernel_write+0x130/0x130
> [  448.272823]  ? do_fast_syscall_32+0x151/0x1016
> [  448.277396]  do_fast_syscall_32+0x3d5/0x1016
> [  448.281797]  ? _raw_spin_unlock_irq+0x27/0x80
> [  448.286317]  ? trace_hardirqs_on_caller+0x421/0x5c0
> [  448.291337]  ? do_int80_syscall_32+0x9f0/0x9f0
> [  448.296277]  ? _raw_spin_unlock_irq+0x60/0x80
> [  448.300761]  ? finish_task_switch+0x1f4/0x890
> [  448.305411]  ? syscall_return_slowpath+0x215/0x4e0
> [  448.310337]  ? prepare_exit_to_usermode+0x300/0x300
> [  448.315348]  ? sysret32_from_system_call+0x5/0x3c
> [  448.320187]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [  448.325080]  entry_SYSENTER_compat+0x70/0x7f
> [  448.329492] RIP: 0023:0xf7f8fcb9
> [  448.332846] RSP: 002b:00000000f7f8b0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000003
> [  448.340546] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020001000
> [  448.347796] RDX: 00000000ffffff20 RSI: 0000000000000000 RDI: 0000000000000000
> [  448.355047] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [  448.362301] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  448.369595] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  448.376890] 
> [  448.378514] Allocated by task 9010:
> [  448.382133]  save_stack+0x43/0xd0
> [  448.385681]  kasan_kmalloc+0xc7/0xe0
> [  448.389408]  kasan_slab_alloc+0x12/0x20
> [  448.393373]  kmem_cache_alloc+0x12e/0x790
> [  448.397518]  __fuse_request_alloc+0x23/0xc0
> [  448.401827]  __fuse_get_req+0x186/0x8d0
> [  448.405790]  fuse_simple_request+0x20/0x610
> [  448.410101]  fuse_do_setattr+0x820/0x1f60
> [  448.414262]  fuse_setattr+0x1a6/0x470
> [  448.418074]  notify_change+0x779/0xda0
> [  448.421942]  utimes_common.isra.1+0x3f8/0x7f0
> [  448.426420]  do_utimes+0x199/0x250
> [  448.430053]  compat_SyS_utimes+0x1f8/0x2e0
> [  448.434563]  do_fast_syscall_32+0x3d5/0x1016
> [  448.438956]  entry_SYSENTER_compat+0x70/0x7f
> [  448.443357] 
> [  448.444974] Freed by task 9010:
> [  448.448305]  save_stack+0x43/0xd0
> [  448.451740]  __kasan_slab_free+0x102/0x150
> [  448.455957]  kasan_slab_free+0xe/0x10
> [  448.459750]  kmem_cache_free+0x83/0x2d0
> [  448.463719]  fuse_request_free+0x77/0x90
> [  448.467762]  fuse_put_request+0x22a/0x2d0
> [  448.471901]  fuse_simple_request+0x38a/0x610
> [  448.476394]  fuse_do_setattr+0x820/0x1f60
> [  448.480525]  fuse_setattr+0x1a6/0x470
> [  448.484304]  notify_change+0x779/0xda0
> [  448.488342]  utimes_common.isra.1+0x3f8/0x7f0
> [  448.492918]  do_utimes+0x199/0x250
> [  448.496443]  compat_SyS_utimes+0x1f8/0x2e0
> [  448.500769]  do_fast_syscall_32+0x3d5/0x1016
> [  448.505172]  entry_SYSENTER_compat+0x70/0x7f
> [  448.509660] 
> [  448.511273] The buggy address belongs to the object at ffff8801cec98400
> [  448.511273]  which belongs to the cache fuse_request of size 448
> [  448.524116] The buggy address is located 48 bytes inside of
> [  448.524116]  448-byte region [ffff8801cec98400, ffff8801cec985c0)
> [  448.535897] The buggy address belongs to the page:
> [  448.540853] page:ffffea00073b2600 count:1 mapcount:0 mapping:ffff8801cec98000 index:0x0
> [  448.549166] flags: 0x2fffc0000000100(slab)
> [  448.553534] raw: 02fffc0000000100 ffff8801cec98000 0000000000000000 0000000100000008
> [  448.561407] raw: ffffea0007656660 ffffea00076359e0 ffff8801d4de8680 0000000000000000
> [  448.569270] page dumped because: kasan: bad access detected
> [  448.574960]
> [  448.576564] Memory state around the buggy address:
> [  448.581477]  ffff8801cec98300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  448.588871]  ffff8801cec98380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [  448.596217] >ffff8801cec98400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  448.603596]                                      ^
> [  448.608507]  ffff8801cec98480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  448.615843]  ffff8801cec98500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  448.623284] ==================================================================

Eric
