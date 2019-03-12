Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2397C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E47F2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 04:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfCLE3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:29:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725824AbfCLE3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 00:29:50 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A5F7D81340387420B4A0;
        Tue, 12 Mar 2019 12:29:45 +0800 (CST)
Received: from [127.0.0.1] (10.184.212.80) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Mar 2019
 12:29:38 +0800
From:   "liwei (GF)" <liwei391@huawei.com>
CC:     chengjian 00427203 <cj.chengjian@huawei.com>,
        guohanjun 00470146 <guohanjun@huawei.com>,
        libin 00196512 <huawei.libin@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [BUG] perf/core: report a task hung issue in
 __perf_event_ctx_lock_double()
To:     <peterz@infradead.org>, <alexander.shishkin@linux.intel.com>,
        <acme@redhat.com>, <jolsa@redhat.com>, <keescook@chromium.org>
Message-ID: <03a379ca-c848-4090-5f7a-1320faefb77a@huawei.com>
Date:   Tue, 12 Mar 2019 12:28:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.212.80]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi peter,
The syzkaller reported a task hung issue, and it was on a qemu x86_64 machine with kernel 4.19.27.
I analysed and found that, the gctx got in __perf_event_ctx_lock_double and ctx are just equal.It is
caused by race between two concurrent sys_perf_event_open() calls where both try and move the same
pre-existing software group into a hardware context. In commit 321027c1fe77f8 ("perf/core: Fix
concurrent sys_perf_event_open() vs. 'move_group' race"), i found you have tried to solve this
problem before. I am afraid a only check can not avoid the race, should we use a lock here?

[ 1295.914975] INFO: task syz-executor.2:23733 blocked for more than 140 seconds.
[ 1295.921446]       Not tainted 4.19.27 #2
[ 1295.922994] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1295.925517] syz-executor.2  D27904 23733   2683 0x10000004
[ 1295.927009] Call Trace:
[ 1295.928737]  ? __schedule+0x755/0x1a80
[ 1295.931396]  ? __sched_text_start+0x8/0x8
[ 1295.936207]  ? do_raw_spin_unlock+0x54/0x220
[ 1295.937339]  schedule+0x7c/0x1a0
[ 1295.938256]  schedule_preempt_disabled+0x11/0x20
[ 1295.939493]  __mutex_lock+0x83b/0x1240
[ 1295.940548]  ? perf_event_ctx_lock_nested+0x1fd/0x440
[ 1295.952024]  ? mutex_lock_io_nested+0x10d0/0x10d0
[ 1295.953217]  ? perf_event_ctx_lock_nested+0x1fd/0x440
[ 1295.954488]  ? ftrace_ops_list_func+0x1c1/0x380
[ 1295.955611]  ? perf_trace_buf_alloc+0x200/0x200
[ 1295.956759]  ? ftrace_call+0x5/0x34
[ 1295.969703]  ? perf_event_ctx_lock_nested+0x1fd/0x440
[ 1295.971336]  ? perf_event_ctx_lock_nested+0x1fd/0x440
[ 1295.972778]  perf_event_ctx_lock_nested+0x1fd/0x440
[ 1295.974994]  ? perf_event_read_event+0x2a0/0x2a0
[ 1295.976346]  ? perf_event_release_kernel+0x94d/0xc70
[ 1295.977643]  ? perf_event_release_kernel+0x955/0xc70
[ 1295.978941]  perf_event_release_kernel+0x108/0xc70
[ 1295.980134]  ? ftrace_call+0x5/0x34
[ 1295.981086]  ? locks_remove_file+0x2b5/0x3e0
[ 1295.992160]  ? put_event+0x40/0x40
[ 1295.993186]  ? perf_event_release_kernel+0xc70/0xc70
[ 1295.994496]  perf_release+0x33/0x40
[ 1295.995494]  __fput+0x27f/0x7f0
[ 1295.996445]  task_work_run+0x136/0x1b0
[ 1295.997536]  exit_to_usermode_loop+0x1a7/0x1d0
[ 1295.998727]  do_syscall_64+0x461/0x580
[ 1295.999800]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1296.001076] RIP: 0033:0x412387
[ 1296.001962] Code: Bad RIP value.
[ 1296.002768] RSP: 002b:00007ffde0b42b40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[ 1296.009717] RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000412387
[ 1296.011609] RDX: 0000000000000000 RSI: 0000000000741c60 RDI: 0000000000000004
[ 1296.013436] RBP: 00007ffde0b42bac R08: 00000000000ffd52 R09: 00000000000ffd52
[ 1296.035032] R10: 00007ffde0b42a80 R11: 0000000000000293 R12: 0000000000000001
[ 1296.039400] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000002
[ 1296.052258] INFO: task syz-executor.2:23734 blocked for more than 140 seconds.
[ 1296.067589]       Not tainted 4.19.27 #2
[ 1296.068545] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1296.070573] syz-executor.2  D28432 23734   2683 0x10000004
[ 1296.072028] Call Trace:
[ 1296.072700]  ? __schedule+0x755/0x1a80
[ 1296.073747]  ? __sched_text_start+0x8/0x8
[ 1296.081141]  ? do_raw_spin_unlock+0x54/0x220
[ 1296.082784]  schedule+0x7c/0x1a0
[ 1296.084135]  schedule_preempt_disabled+0x11/0x20
[ 1296.085506]  __mutex_lock+0x83b/0x1240
[ 1296.086609]  ? __do_sys_perf_event_open+0xff5/0x2090
[ 1296.088051]  ? mutex_lock_io_nested+0x10d0/0x10d0
[ 1296.097169]  ? __do_sys_perf_event_open+0xff5/0x2090
[ 1296.098224]  ? ftrace_ops_list_func+0x1c1/0x380
[ 1296.099256]  ? perf_trace_buf_alloc+0x200/0x200
[ 1296.110608]  ? ftrace_call+0x5/0x34
[ 1296.111662]  ? __do_sys_perf_event_open+0xff5/0x2090
[ 1296.113844]  ? __do_sys_perf_event_open+0xff5/0x2090
[ 1296.115350]  __do_sys_perf_event_open+0xff5/0x2090
[ 1296.116812]  ? perf_event_set_output+0x480/0x480
[ 1296.118742]  ? rcu_read_lock_sched_held+0x107/0x120
[ 1296.120136]  ? syscall_trace_enter+0x285/0xb80
[ 1296.122451]  ? do_syscall_64+0x3e3/0x580
[ 1296.124165]  do_syscall_64+0xc8/0x580
[ 1296.125766]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1296.128241] RIP: 0033:0x462eb9
[ 1296.130131] Code: Bad RIP value.
[ 1296.131104] RSP: 002b:00007f6024d51c58 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[ 1296.132763] RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462eb9
[ 1296.148678] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000020000040
[ 1296.151821] RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
[ 1296.156380] R10: 0000000000000008 R11: 0000000000000246 R12: 00007f6024d526bc
[ 1296.160438] R13: 00000000004c2df7 R14: 00000000006ffc10 R15: 00000000ffffffff
[ 1296.165410] 
[ 1296.165410] Showing all locks held in the system:
[ 1296.168411] 1 lock held by khungtaskd/54:
[ 1296.170580]  #0: 00000000d6c02832 (rcu_read_lock){....}, at: debug_show_all_locks+0x57/0x310
[ 1296.175315] 2 locks held by mingetty/2544:
[ 1296.177933]  #0: 00000000456410e4 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x80
[ 1296.182492]  #1: 000000008edb9b44 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x1f7/0x1640
[ 1296.187036] 2 locks held by mingetty/2545:
[ 1296.189314]  #0: 000000009aa198a3 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x80
[ 1296.204916]  #1: 0000000042b7b2da (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x1f7/0x1640
[ 1296.219194] 2 locks held by mingetty/2546:
[ 1296.221824]  #0: 00000000f6de8ca8 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x80
[ 1296.225920]  #1: 00000000d0591283 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x1f7/0x1640
[ 1296.230199] 2 locks held by mingetty/2547:
[ 1296.232317]  #0: 000000007948d514 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x80
[ 1296.237411]  #1: 000000004c06529b (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x1f7/0x1640
[ 1296.241735] 2 locks held by mingetty/2548:
[ 1296.243249]  #0: 00000000ffb56700 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x80
[ 1296.246098]  #1: 00000000b1156838 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x1f7/0x1640
[ 1296.251057] 2 locks held by mingetty/2549:
[ 1296.252910]  #0: 0000000040841ffc (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x80
[ 1296.255309]  #1: 00000000729b4211 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x1f7/0x1640
[ 1296.257465] 2 locks held by agetty/2550:
[ 1296.258726]  #0: 000000006bdfce31 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x80
[ 1296.264181]  #1: 000000000945aba2 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x1f7/0x1640
[ 1296.270268] 1 lock held by syz-executor.2/23733:
[ 1296.272249]  #0: 00000000f7dcaa66 (&cpuctx_mutex){+.+.}, at: perf_event_ctx_lock_nested+0x1fd/0x440
[ 1296.274329] 2 locks held by syz-executor.2/23734:
[ 1296.275344]  #0: 00000000f7dcaa66 (&cpuctx_mutex){+.+.}, at: __do_sys_perf_event_open+0xfe8/0x2090
[ 1296.277915]  #1: 00000000f7dcaa66 (&cpuctx_mutex/1){+.+.}, at: __do_sys_perf_event_open+0xff5/0x2090
[ 1296.280048] 
[ 1296.280502] =============================================
[ 1296.280502] 

Thanks,
Wei Li

