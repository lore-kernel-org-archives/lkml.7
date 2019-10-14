Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E632C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4DC207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfJNHDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:03:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfJNHDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:03:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B33F869579410FFCB488;
        Mon, 14 Oct 2019 15:03:13 +0800 (CST)
Received: from [127.0.0.1] (10.177.224.82) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 15:03:03 +0800
To:     LKML <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <patrick.bellasi@arm.com>, <valentin.schneider@arm.com>,
        <tglx@linutronix.de>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Subject: [QUESTION] Hung task warning while running syzkaller test
Message-ID: <0d7aa66d-d2b9-775c-56b3-543d132fdb84@huawei.com>
Date:   Mon, 14 Oct 2019 15:03:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------629EEFE2DAB4CD04D145207B"
X-Originating-IP: [10.177.224.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------629EEFE2DAB4CD04D145207B
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit

Hi, everyone. We met a hung task problem while running syzkaller test. The stacks of hung tasks vary in net/fs/sched, and we provide a stable reproduce test case in fs. The higher the kernel version, the lower the probability of reproduce. Maybe the mainline has gradually optimized the scheduling and mutex.

Environment:
	A. qemu(x86_64 8-core 16GB-RAM)
	B. physical machine (x86_64 8-core 314GB-RAM)

	./syz-execprog -executor=/home/abc/syz-executor -repeat=0 -procs=16 -cover=0 repro
repro is a configuration file containing syzkaller execution instructions, which shown as follows:
	syz_execute_func(&(0x7f0000000140)="f2aa984413e80f059532058300000071f32ef30f1b6f002e676666440f381d953b0000009fcc77a7141e8f6978e394db96000000928640c4e2b140da6c4f086447deecf2460fd6c40f49100045660fc462c0f726448047000040df6e32b8417e10bd61796e91565646bc16442ecbb1a978c33537771656c441add398b50000000feb76f7f7210173dddfc421785a6600a32c9f5d04ecc7c764660f600500040000c4035922770063c4217be62e450f8a0163000021f0c4e25dbe044c31e053b3eb53b3eb890f32d393400f383ca8faffec1f8dbf4feeee1e480404fb2e400f1ad30fae746d00ab07c4a2d538cb0ff803461439f5e3480f5140a3c4c4021bf7e8561eeaea0f6c3dce67460ffd1a000fb2430f12f5c423557904e774")
	socket(0x1, 0x80000, 0x4)

Hung task in kernel-4.4(See full message in hung_task_verbose.log):
	[  420.762345] INFO: task syz-executor.1:8244 blocked for more than 140 seconds.
	[  420.763691]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
	[  420.764645] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	[  420.765931] syz-executor.1  D ffff88040e6efc80 13728  8244   8242 0x00000000
	[  420.767189]  ffff88040e6efc80 ffff88040e71c990 ffff880400000000 ffff880077df3d80
	[  420.768497]  ffff88040e71bd80 ffff88040e6f0000 0000000000000246 ffff88041f5007c0
	[  420.769800]  ffff88040e71bd80 00000000ffffffff ffff88040e6efc98 ffffffff818c6ebc
	[  420.771109] Call Trace:
	[  420.771540]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
	[  420.772369]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
	[  420.773437]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
	[  420.774421]  [<ffffffff81252fdf>] ? walk_component+0x21f/0x310
	[  420.775396]  [<ffffffff8124fb4a>] ? __inode_permission+0x3a/0x80
	[  420.776391]  [<ffffffff81252fdf>] walk_component+0x21f/0x310
	[  420.777333]  [<ffffffff81253f3b>] ? path_lookupat+0x1b/0x110
	[  420.778273]  [<ffffffff81253f7d>] path_lookupat+0x5d/0x110
	[  420.779197]  [<ffffffff81255bc1>] filename_lookup+0xb1/0x180
	[  420.780130]  [<ffffffff811133dd>] ? rcu_read_lock_sched_held+0x6d/0x80
	[  420.781211]  [<ffffffff81228db0>] ? kmem_cache_alloc+0x240/0x2b0
	[  420.782212]  [<ffffffff811132ed>] ? debug_lockdep_rcu_enabled+0x1d/0x20
	[  420.783312]  [<ffffffff81255d66>] user_path_at_empty+0x36/0x40
	[  420.784284]  [<ffffffff8126fcd3>] path_removexattr+0x43/0xb0
	[  420.785229]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
	[  420.786283]  [<ffffffff81270c50>] SyS_lremovexattr+0x10/0x20
	[  420.787232]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
	[  420.788302] 1 lock held by syz-executor.1/8244:
	[  420.789051]  #0:  (&sb->s_type->i_mutex_key#2){+.+.+.}, at: [<ffffffff81252fdf>] walk_component+0x21f/0x310

Hung task in kernel-5.3-rc6:
	[30391.827102] INFO: task syz-executor.6:12211 blocked for more than 143 seconds.
	[30391.827194]       Not tainted 5.3.0-rc6-514.55.6.9.x86_64 #41
	[30391.827214] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	[30391.827239] syz-executor.6  D13904 12211  12143 0x00000000
	[30391.827319] Call Trace:
	[30391.828583]  ? __schedule+0x3cc/0x8b0
	[30391.828669]  schedule+0x30/0xb0
	[30391.828785]  rwsem_down_write_slowpath+0x2d2/0x730
	[30391.829039]  ? filename_create+0x9d/0x1d0
	[30391.829110]  ? filename_create+0x9d/0x1d0
	[30391.829136]  ? rwsem_down_write_slowpath+0x5/0x730
	[30391.829163]  filename_create+0x9d/0x1d0
	[30391.829247]  do_mkdirat+0x54/0x120
	[30391.829361]  do_syscall_64+0x85/0x380
	[30391.829445]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[30391.829509] RIP: 0033:0x20000148
	[30391.829562] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f2 aa 98 44 13 e8 0f 05 <95> 32 05 83 00 00 00 71 f3 2e f3 0f 1b 6f 00 2e 67 66 66 44 0f 38
	[30391.829604] RSP: 002b:00007fd154213bd8 EFLAGS: 00000203 ORIG_RAX: 0000000000000053
	[30391.829638] RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 0000000020000148
	[30391.829659] RDX: da194cf4f57fa1d4 RSI: 0000000000000000 RDI: 00007fd15421460a
	[30391.829680] RBP: 0000000000000045 R08: 0000000000000005 R09: 0000000000000006
	[30391.829703] R10: 0000000000000007 R11: 0000000000000203 R12: 000000000000000b
	[30391.829724] R13: 000000000000014c R14: 000000000000000d R15: 00000000ffffffff


Intro of attachments:
	hung_task_verbose.log: verbose of hung task(with lockdep)
	repro: reproduction file which contains syzkaller execution instructions

Any ideas or suggestions? Thanks a lot.

--------------629EEFE2DAB4CD04D145207B
Content-Type: text/plain; charset="UTF-8"; name="hung_task_verbose.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hung_task_verbose.log"

[  420.762345] INFO: task syz-executor.1:8244 blocked for more than 140 seconds.
[  420.763691]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
[  420.764645] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  420.765931] syz-executor.1  D ffff88040e6efc80 13728  8244   8242 0x00000000
[  420.767189]  ffff88040e6efc80 ffff88040e71c990 ffff880400000000 ffff880077df3d80
[  420.768497]  ffff88040e71bd80 ffff88040e6f0000 0000000000000246 ffff88041f5007c0
[  420.769800]  ffff88040e71bd80 00000000ffffffff ffff88040e6efc98 ffffffff818c6ebc
[  420.771109] Call Trace:
[  420.771540]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
[  420.772369]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
[  420.773437]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
[  420.774421]  [<ffffffff81252fdf>] ? walk_component+0x21f/0x310
[  420.775396]  [<ffffffff8124fb4a>] ? __inode_permission+0x3a/0x80
[  420.776391]  [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  420.777333]  [<ffffffff81253f3b>] ? path_lookupat+0x1b/0x110
[  420.778273]  [<ffffffff81253f7d>] path_lookupat+0x5d/0x110
[  420.779197]  [<ffffffff81255bc1>] filename_lookup+0xb1/0x180
[  420.780130]  [<ffffffff811133dd>] ? rcu_read_lock_sched_held+0x6d/0x80
[  420.781211]  [<ffffffff81228db0>] ? kmem_cache_alloc+0x240/0x2b0
[  420.782212]  [<ffffffff811132ed>] ? debug_lockdep_rcu_enabled+0x1d/0x20
[  420.783312]  [<ffffffff81255d66>] user_path_at_empty+0x36/0x40
[  420.784284]  [<ffffffff8126fcd3>] path_removexattr+0x43/0xb0
[  420.785229]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
[  420.786283]  [<ffffffff81270c50>] SyS_lremovexattr+0x10/0x20
[  420.787232]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
[  420.788302] 1 lock held by syz-executor.1/8244:
[  420.789051]  #0:  (&sb->s_type->i_mutex_key#2){+.+.+.}, at: [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  420.790815] INFO: task syz-executor.1:8735 blocked for more than 140 seconds.
[  420.791990]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
[  420.792901] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  420.794184] syz-executor.1  D ffff88040b047c30 13856  8735   8729 0x00000000
[  420.795398]  ffff88040b047c30 ffff88040b7caad0 ffff880400000000 ffff88040a570000
[  420.796698]  ffff88040b7c9ec0 ffff88040b048000 0000000000000246 ffff88041f5007c0
[  420.798003]  ffff88040b7c9ec0 00000000ffffffff ffff88040b047c48 ffffffff818c6ebc
[  420.799320] Call Trace:
[  420.799731]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
[  420.800555]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
[  420.801614]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
[  420.802603]  [<ffffffff81252fdf>] ? walk_component+0x21f/0x310
[  420.803566]  [<ffffffff8124fb4a>] ? __inode_permission+0x3a/0x80
[  420.804556]  [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  420.805493]  [<ffffffff81253f3b>] ? path_lookupat+0x1b/0x110
[  420.806431]  [<ffffffff81253f7d>] path_lookupat+0x5d/0x110
[  420.807349]  [<ffffffff81255bc1>] filename_lookup+0xb1/0x180
[  420.808288]  [<ffffffff811133dd>] ? rcu_read_lock_sched_held+0x6d/0x80
[  420.809364]  [<ffffffff81228db0>] ? kmem_cache_alloc+0x240/0x2b0
[  420.810353]  [<ffffffff81255d66>] user_path_at_empty+0x36/0x40
[  420.811331]  [<ffffffff8127e925>] do_utimes+0x115/0x160
[  420.812202]  [<ffffffff8127ea0b>] SyS_utime+0x9b/0xd0
[  420.813034]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
[  420.814081]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
[  420.815149] 1 lock held by syz-executor.1/8735:
[  420.815903]  #0:  (&sb->s_type->i_mutex_key#2){+.+.+.}, at: [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  420.817647] INFO: task syz-executor.1:8795 blocked for more than 140 seconds.
[  420.818828]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
[  420.819736] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  420.821016] syz-executor.1  D ffff88040ad6fc80 13952  8795   8791 0x00000000
[  420.822233]  ffff88040ad6fc80 ffff88040acc2ad0 ffff880400000000 ffff88040ac30000
[  420.823539]  ffff88040acc1ec0 ffff88040ad70000 0000000000000246 ffff88041f5007c0
[  420.824840]  ffff88040acc1ec0 00000000ffffffff ffff88040ad6fc98 ffffffff818c6ebc
[  420.826138] Call Trace:
[  420.826565]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
[  420.827392]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
[  420.828454]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
[  420.829433]  [<ffffffff81252fdf>] ? walk_component+0x21f/0x310
[  420.830400]  [<ffffffff8124fb4a>] ? __inode_permission+0x3a/0x80
[  420.831402]  [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  420.832341]  [<ffffffff81253f3b>] ? path_lookupat+0x1b/0x110
[  420.833278]  [<ffffffff81253f7d>] path_lookupat+0x5d/0x110
[  420.834191]  [<ffffffff81255bc1>] filename_lookup+0xb1/0x180
[  420.835127]  [<ffffffff811133dd>] ? rcu_read_lock_sched_held+0x6d/0x80
[  420.836201]  [<ffffffff81228db0>] ? kmem_cache_alloc+0x240/0x2b0
[  420.837196]  [<ffffffff811132ed>] ? debug_lockdep_rcu_enabled+0x1d/0x20
[  420.838287]  [<ffffffff81255d66>] user_path_at_empty+0x36/0x40
[  420.839261]  [<ffffffff8126fcd3>] path_removexattr+0x43/0xb0
[  420.840199]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
[  420.841246]  [<ffffffff81270c50>] SyS_lremovexattr+0x10/0x20
[  420.842186]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
[  420.843256] 1 lock held by syz-executor.1/8795:
[  420.844001]  #0:  (&sb->s_type->i_mutex_key#2){+.+.+.}, at: [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  420.845766] INFO: task syz-executor.1:9075 blocked for more than 140 seconds.
[  420.846948]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
[  420.847855] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  420.849136] syz-executor.1  D ffff880409783df0 14176  9075   9073 0x00000000
[  420.850352]  ffff880409783df0 ffff8804094e8c10 ffff880400000000 ffff8803fe8c9ec0
[  420.851662]  ffff8804094e8000 ffff880409784000 0000000000000246 ffff88041f5007c0
[  420.852962]  ffff8804094e8000 00000000ffffffff ffff880409783e08 ffffffff818c6ebc
[  420.854272] Call Trace:
[  420.854691]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
[  420.855517]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
[  420.856578]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
[  420.857555]  [<ffffffff81255f7f>] ? filename_create+0x7f/0x170
[  420.858524]  [<ffffffff810f0b9c>] ? percpu_down_read+0x5c/0xa0
[  420.859501]  [<ffffffff81255f7f>] filename_create+0x7f/0x170
[  420.860440]  [<ffffffff81256ed1>] SyS_mkdir+0x51/0xe0
[  420.861279]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
[  420.862342] 2 locks held by syz-executor.1/9075:
[  420.863109]  #0:  (sb_writers#2){.+.+.+}, at: [<ffffffff81247e97>] __sb_start_write+0xb7/0xf0
[  420.864642]  #1:  (&sb->s_type->i_mutex_key#2/1){+.+.+.}, at: [<ffffffff81255f7f>] filename_create+0x7f/0x170
[  431.979231] INFO: task syz-executor.1:9569 blocked for more than 140 seconds.
[  431.980483]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
[  431.981429] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  431.982754] syz-executor.1  D ffff8804064d7c30 14272  9569   7814 0x00000000
[  431.983969]  ffff8804064d7c30 ffff88040687c990 ffff880400000000 ffff880406c43d80
[  431.985281]  ffff88040687bd80 ffff8804064d8000 0000000000000246 ffff88041f5007c0
[  431.986596]  ffff88040687bd80 00000000ffffffff ffff8804064d7c48 ffffffff818c6ebc
[  431.987898] Call Trace:
[  431.988329]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
[  431.989149]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
[  431.990210]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
[  431.991203]  [<ffffffff81252fdf>] ? walk_component+0x21f/0x310
[  431.992177]  [<ffffffff8124fb4a>] ? __inode_permission+0x3a/0x80
[  431.993183]  [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  431.994116]  [<ffffffff81253f3b>] ? path_lookupat+0x1b/0x110
[  431.995064]  [<ffffffff81253f7d>] path_lookupat+0x5d/0x110
[  431.995977]  [<ffffffff81255bc1>] filename_lookup+0xb1/0x180
[  431.996922]  [<ffffffff811133dd>] ? rcu_read_lock_sched_held+0x6d/0x80
[  431.998001]  [<ffffffff81228db0>] ? kmem_cache_alloc+0x240/0x2b0
[  431.999005]  [<ffffffff81255d66>] user_path_at_empty+0x36/0x40
[  431.999974]  [<ffffffff8127e925>] do_utimes+0x115/0x160
[  432.000842]  [<ffffffff8127ea0b>] SyS_utime+0x9b/0xd0
[  432.001687]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
[  432.002751]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
[  432.003819] 1 lock held by syz-executor.1/9569:
[  432.004577]  #0:  (&sb->s_type->i_mutex_key#2){+.+.+.}, at: [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  432.006328] INFO: task syz-executor.1:9810 blocked for more than 140 seconds.
[  432.007516]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
[  432.008428] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  432.009720] syz-executor.1  D ffff88040523bc80 13952  9810   9808 0x00000000
[  432.010950]  ffff88040523bc80 ffff880405230c10 ffff880400000000 ffff880404c43d80
[  432.012265]  ffff880405230000 ffff88040523c000 0000000000000246 ffff88041f5007c0
[  432.013574]  ffff880405230000 00000000ffffffff ffff88040523bc98 ffffffff818c6ebc
[  432.014886] Call Trace:
[  432.015310]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
[  432.016131]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
[  432.017195]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
[  432.018182]  [<ffffffff81252fdf>] ? walk_component+0x21f/0x310
[  432.019149]  [<ffffffff8124fb4a>] ? __inode_permission+0x3a/0x80
[  432.020140]  [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  432.021079]  [<ffffffff81253f3b>] ? path_lookupat+0x1b/0x110
[  432.022017]  [<ffffffff81253f7d>] path_lookupat+0x5d/0x110
[  432.022941]  [<ffffffff81255bc1>] filename_lookup+0xb1/0x180
[  432.023880]  [<ffffffff811133dd>] ? rcu_read_lock_sched_held+0x6d/0x80
[  432.024959]  [<ffffffff81228db0>] ? kmem_cache_alloc+0x240/0x2b0
[  432.025953]  [<ffffffff811132ed>] ? debug_lockdep_rcu_enabled+0x1d/0x20
[  432.027049]  [<ffffffff81255d66>] user_path_at_empty+0x36/0x40
[  432.028016]  [<ffffffff8126fcd3>] path_removexattr+0x43/0xb0
[  432.028953]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
[  432.030003]  [<ffffffff81270c50>] SyS_lremovexattr+0x10/0x20
[  432.030949]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
[  432.032011] 1 lock held by syz-executor.1/9810:
[  432.032767]  #0:  (&sb->s_type->i_mutex_key#2){+.+.+.}, at: [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  432.034509] INFO: task syz-executor.1:9826 blocked for more than 140 seconds.
[  432.035690]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
[  432.036606] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  432.037895] syz-executor.1  D ffff8804053cfc80 13856  9826   9816 0x00000000
[  432.039113]  ffff8804053cfc80 ffff88040539c990 ffff880400000000 ffff88040513dc40
[  432.040427]  ffff88040539bd80 ffff8804053d0000 0000000000000246 ffff88041f5007c0
[  432.041730]  ffff88040539bd80 00000000ffffffff ffff8804053cfc98 ffffffff818c6ebc
[  432.043035] Call Trace:
[  432.043459]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
[  432.044287]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
[  432.045355]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
[  432.046339]  [<ffffffff81252fdf>] ? walk_component+0x21f/0x310
[  432.047343]  [<ffffffff8124fb4a>] ? __inode_permission+0x3a/0x80
[  432.048338]  [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  432.049278]  [<ffffffff81253f3b>] ? path_lookupat+0x1b/0x110
[  432.050218]  [<ffffffff81253f7d>] path_lookupat+0x5d/0x110
[  432.051132]  [<ffffffff81255bc1>] filename_lookup+0xb1/0x180
[  432.052071]  [<ffffffff811133dd>] ? rcu_read_lock_sched_held+0x6d/0x80
[  432.053148]  [<ffffffff81228db0>] ? kmem_cache_alloc+0x240/0x2b0
[  432.054139]  [<ffffffff811132ed>] ? debug_lockdep_rcu_enabled+0x1d/0x20
[  432.055233]  [<ffffffff81255d66>] user_path_at_empty+0x36/0x40
[  432.056201]  [<ffffffff8126fcd3>] path_removexattr+0x43/0xb0
[  432.057133]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
[  432.058178]  [<ffffffff81270c50>] SyS_lremovexattr+0x10/0x20
[  432.059114]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
[  432.060175] 1 lock held by syz-executor.1/9826:
[  432.060922]  #0:  (&sb->s_type->i_mutex_key#2){+.+.+.}, at: [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  432.062672] INFO: task syz-executor.1:9902 blocked for more than 140 seconds.
[  432.063852]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
[  432.064762] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  432.066049] syz-executor.1  D ffff880404417c70 13856  9902   9862 0x00000000
[  432.067280]  ffff880404417c70 ffff880404aec990 ffff880400000000 ffff88040533bd80
[  432.068587]  ffff880404aebd80 ffff880404418000 0000000000000246 ffff88041f5007c0
[  432.069890]  ffff880404aebd80 00000000ffffffff ffff880404417c88 ffffffff818c6ebc
[  432.071243] Call Trace:
[  432.071656]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
[  432.072483]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
[  432.073546]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
[  432.074534]  [<ffffffff81252fdf>] ? walk_component+0x21f/0x310
[  432.075505]  [<ffffffff8124fb4a>] ? __inode_permission+0x3a/0x80
[  432.076502]  [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  432.077446]  [<ffffffff81253f3b>] ? path_lookupat+0x1b/0x110
[  432.078391]  [<ffffffff81253f7d>] path_lookupat+0x5d/0x110
[  432.079314]  [<ffffffff81255bc1>] filename_lookup+0xb1/0x180
[  432.080260]  [<ffffffff811133dd>] ? rcu_read_lock_sched_held+0x6d/0x80
[  432.081348]  [<ffffffff81228db0>] ? kmem_cache_alloc+0x240/0x2b0
[  432.082351]  [<ffffffff81255d66>] user_path_at_empty+0x36/0x40
[  432.083331]  [<ffffffff8127021b>] path_getxattr+0x4b/0xb0
[  432.084234]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
[  432.085291]  [<ffffffff81270ab1>] SyS_lgetxattr+0x11/0x20
[  432.086195]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
[  432.087273] 1 lock held by syz-executor.1/9902:
[  432.088025]  #0:  (&sb->s_type->i_mutex_key#2){+.+.+.}, at: [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  445.381195] INFO: task syz-executor.1:9914 blocked for more than 140 seconds.
[  445.382485]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
[  445.383408] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  445.384705] syz-executor.1  D ffff880404df7c80 13856  9914   9907 0x00000000
[  445.385931]  ffff880404df7c80 ffff880404e18c10 ffff880400000000 ffff8804059d0000
[  445.387264]  ffff880404e18000 ffff880404df8000 0000000000000246 ffff88041f5007c0
[  445.388582]  ffff880404e18000 00000000ffffffff ffff880404df7c98 ffffffff818c6ebc
[  445.389896] Call Trace:
[  445.390327]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
[  445.391157]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
[  445.392229]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
[  445.393226]  [<ffffffff81252fdf>] ? walk_component+0x21f/0x310
[  445.394203]  [<ffffffff8124fb4a>] ? __inode_permission+0x3a/0x80
[  445.395219]  [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  445.396157]  [<ffffffff81253f3b>] ? path_lookupat+0x1b/0x110
[  445.397100]  [<ffffffff81253f7d>] path_lookupat+0x5d/0x110
[  445.398017]  [<ffffffff81255bc1>] filename_lookup+0xb1/0x180
[  445.398971]  [<ffffffff811133dd>] ? rcu_read_lock_sched_held+0x6d/0x80
[  445.400059]  [<ffffffff81228db0>] ? kmem_cache_alloc+0x240/0x2b0
[  445.401060]  [<ffffffff811132ed>] ? debug_lockdep_rcu_enabled+0x1d/0x20
[  445.402159]  [<ffffffff81255d66>] user_path_at_empty+0x36/0x40
[  445.403139]  [<ffffffff8126fcd3>] path_removexattr+0x43/0xb0
[  445.404085]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
[  445.405138]  [<ffffffff81270c50>] SyS_lremovexattr+0x10/0x20
[  445.406081]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
[  445.407160] 1 lock held by syz-executor.1/9914:
[  445.407932]  #0:  (&sb->s_type->i_mutex_key#2){+.+.+.}, at: [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  445.409681] INFO: task syz-executor.1:9921 blocked for more than 140 seconds.
[  445.410870]       Not tainted 4.4.186-514.55.6.9.x86_64 #1
[  445.411786] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  445.413080] syz-executor.1  D ffff880404473c30 14208  9921   9902 0x00000000
[  445.414306]  ffff880404473c30 ffff880404b96850 ffff880400000000 ffff880405339ec0
[  445.415624]  ffff880404b95c40 ffff880404474000 0000000000000246 ffff88041f5007c0
[  445.416934]  ffff880404b95c40 00000000ffffffff ffff880404473c48 ffffffff818c6ebc
[  445.418258] Call Trace:
[  445.418681]  [<ffffffff818c6ebc>] schedule+0x3c/0x90
[  445.419513]  [<ffffffff818c72a5>] schedule_preempt_disabled+0x15/0x20
[  445.420583]  [<ffffffff818c9692>] mutex_lock_nested+0x182/0x500
[  445.421569]  [<ffffffff81252fdf>] ? walk_component+0x21f/0x310
[  445.422544]  [<ffffffff8124fb4a>] ? __inode_permission+0x3a/0x80
[  445.423548]  [<ffffffff81252fdf>] walk_component+0x21f/0x310
[  445.424498]  [<ffffffff81253f3b>] ? path_lookupat+0x1b/0x110
[  445.425442]  [<ffffffff81253f7d>] path_lookupat+0x5d/0x110
[  445.426360]  [<ffffffff81255bc1>] filename_lookup+0xb1/0x180
[  445.427314]  [<ffffffff811133dd>] ? rcu_read_lock_sched_held+0x6d/0x80
[  445.428400]  [<ffffffff81228db0>] ? kmem_cache_alloc+0x240/0x2b0
[  445.429401]  [<ffffffff81255d66>] user_path_at_empty+0x36/0x40
[  445.430379]  [<ffffffff8127e925>] do_utimes+0x115/0x160
[  445.431260]  [<ffffffff8127ea0b>] SyS_utime+0x9b/0xd0
[  445.432098]  [<ffffffff81003044>] ? lockdep_sys_exit_thunk+0x12/0x14
[  445.433155]  [<ffffffff818cdda1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
[  445.434227] 1 lock held by syz-executor.1/9921:
[  445.434985]  #0:  (&sb->s_type->i_mutex_key#2){+.+.+.}, at: [<ffffffff81252fdf>] walk_component+0x21f/0x310
--------------629EEFE2DAB4CD04D145207B
Content-Type: text/plain; charset="UTF-8"; name="repro"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="repro"

syz_execute_func(&(0x7f0000000140)="f2aa984413e80f059532058300000071f32ef30f1b6f002e676666440f381d953b0000009fcc77a7141e8f6978e394db96000000928640c4e2b140da6c4f086447deecf2460fd6c40f49100045660fc462c0f726448047000040df6e32b8417e10bd61796e91565646bc16442ecbb1a978c33537771656c441add398b50000000feb76f7f7210173dddfc421785a6600a32c9f5d04ecc7c764660f600500040000c4035922770063c4217be62e450f8a0163000021f0c4e25dbe044c31e053b3eb53b3eb890f32d393400f383ca8faffec1f8dbf4feeee1e480404fb2e400f1ad30fae746d00ab07c4a2d538cb0ff803461439f5e3480f5140a3c4c4021bf7e8561eeaea0f6c3dce67460ffd1a000fb2430f12f5c423557904e774")
socket(0x1, 0x80000, 0x4)

--------------629EEFE2DAB4CD04D145207B--
