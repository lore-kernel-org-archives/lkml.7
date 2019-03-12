Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8133BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50737214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfCLCDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:03:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbfCLCDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:03:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AAA7CD5F77A4AD620348;
        Tue, 12 Mar 2019 10:03:28 +0800 (CST)
Received: from [127.0.0.1] (10.184.38.59) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Mar 2019
 10:03:22 +0800
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Li Bin <huawei.libin@huawei.com>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        <luca.abeni@santannapisa.it>
CC:     <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Subject: WARN ON at kernel/sched/deadline.c task_non_contending
Message-ID: <dfb46874-3657-71c6-e068-9413ffe3f82e@huawei.com>
Date:   Tue, 12 Mar 2019 10:03:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.38.59]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

When looking to test SCHED_DEADLINE syzkaller report an warn in
task_non_contending(). I tested the mainline kernel with the C program
and captured the same call trace.

[The previous message contains some strings in other formats,

making the mail less readable. So I resend it. SORRY.]


[  948.126369] WARNING: CPU: 4 PID: 17089 at kernel/sched/deadline.c:255 
task_non_contending+0xae0/0x1950
[  948.130198] Kernel panic - not syncing: panic_on_warn set ...
[  948.130198]
[  948.134221] CPU: 4 PID: 17089 Comm: syz-executor.1 Not tainted 
4.19.27 #2
[  948.139072] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.10.2-1ubuntu1 04/01/2014
[  948.141603] Call Trace:
[  948.142277]  dump_stack+0xca/0x13e
[  948.164636]  panic+0x1f7/0x543
[  948.168704]  ? refcount_error_report+0x29d/0x29d
[  948.172438]  ? __warn+0x1d1/0x210
[  948.183359]  ? task_non_contending+0xae0/0x1950
[  948.191747]  __warn+0x1ec/0x210
[  948.196276]  ? task_non_contending+0xae0/0x1950
[  948.202476]  report_bug+0x1ee/0x2b0
[  948.204622]  fixup_bug.part.7+0x37/0x80
[  948.206879]  do_error_trap+0x22c/0x290
[  948.211340]  ? math_error+0x2f0/0x2f0
[  948.217033]  ? trace_hardirqs_off_caller+0x40/0x190
[  948.222477]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  948.229877]  invalid_op+0x14/0x20
[  948.238317] RIP: 0010:task_non_contending+0xae0/0x1950
[  948.253825] Code: 6d 29 83 48 89 4c 24 20 48 89 54 24 10 c6 05 d0 89 
5a 03 01 e8 11 ea ee ff 0f 0b 48 8b 4c 24 20 48 8b 54 24 10 e9 bb f7 ff 
ff <0f> 0b e9 1d f6 ff ff e8 d4 a7 09 00 85 c0 0f 85 74 f8 ff ff 48 c7
[  948.272329] RSP: 0018:ffff8883d443f8c0 EFLAGS: 00010002
[  948.293045] RAX: 0000000000000001 RBX: ffff8883d3572468 RCX: 
ffffffff813a6571
[  948.300323] RDX: 00000000000008ab RSI: ffffc900030e4000 RDI: 
ffff8883e2fe6278
[  948.305278] RBP: ffff8883e2f00000 R08: ffffed1078ea3ab2 R09: 
ffffed1078ea3ab2
[  948.316441] R10: 0000000000000001 R11: ffffed1078ea3ab1 R12: 
000000000002c680
[  948.320257] R13: ffff8883d357217c R14: 0000000000000001 R15: 
ffff8883d3572140
[  948.324500]  ? hrtimer_active+0x171/0x1f0
[  948.327421]  ? dequeue_task_dl+0x38/0x970
[  948.330572]  __schedule+0x94b/0x1a80
[  948.333578]  ? __sched_text_start+0x8/0x8
[  948.336141]  ? lock_downgrade+0x5e0/0x5e0
[  948.338111]  ? plist_add+0x23e/0x480
[  948.339706]  schedule+0x7c/0x1a0
[  948.341395]  futex_wait_queue_me+0x319/0x600
[  948.343329]  ? get_futex_key_refs+0xd0/0xd0
[  948.345037]  ? lock_downgrade+0x5e0/0x5e0
[  948.347206]  ? get_futex_key_refs+0xa4/0xd0
[  948.353007]  futex_wait+0x1e7/0x590
[  948.355328]  ? futex_wait_setup+0x2b0/0x2b0
[  948.360578]  ? __lock_acquire+0x60c/0x3b70
[  948.369186]  ? __save_stack_trace+0x92/0x100
[  948.374344]  ? hash_futex+0x15/0x210
[  948.376832]  ? drop_futex_key_refs+0x3c/0xd0
[  948.378591]  ? futex_wake+0x14e/0x450
[  948.381609]  do_futex+0x5c9/0x15e0
[  948.384567]  ? perf_syscall_enter+0xb1/0xc80
[  948.390307]  ? exit_robust_list+0x240/0x240
[  948.393566]  ? ftrace_syscall_exit+0x5c0/0x5c0
[  948.396369]  ? lock_downgrade+0x5e0/0x5e0
[  948.401748]  ? __might_fault+0x17c/0x1c0
[  948.404171]  __x64_sys_futex+0x296/0x380
[  948.406472]  ? __ia32_sys_futex+0x370/0x370
[  948.440630]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  948.441774]  ? trace_hardirqs_off_caller+0x40/0x190
[  948.442770]  ? do_syscall_64+0x3b/0x580
[  948.486728]  do_syscall_64+0xc8/0x580
[  948.489138]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  948.492072] RIP: 0033:0x462eb9
[  948.492788] Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
[  948.532016] RSP: 002b:00007f7ac8a67cd8 EFLAGS: 00000246 ORIG_RAX: 
00000000000000ca
[  948.536811] RAX: ffffffffffffffda RBX: 000000000073bf08 RCX: 
0000000000462eb9
[  948.542138] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 
000000000073bf08
[  948.548077] RBP: 000000000073bf00 R08: 0000000000000000 R09: 
0000000000000000
[  948.562535] R10: 0000000000000000 R11: 0000000000000246 R12: 
000000000073bf0c
[  948.569184] R13: 0000000000000000 R14: 000000000073bf00 R15: 
00007fff106d8c10



WARNING at :

```cpp
static void task_non_contending(struct task_struct *p){
     // ......
     WARN_ON(hrtimer_active(&dl_se->inactive_timer));
     WARN_ON(dl_se->dl_non_contending);
}
```

I have debug for it and found that hrtimer_try_to_cancel FAILED(return 
-1) in
migrate_task_rq_dl() because the timer handler `inactive_task_timer()` 
is running
at that time. so when the task  blocks later, theinactive_timer is still 
active
indequeue_task_dl().


```cpp
static void migrate_task_rq_dl(struct task_struct *p, int new_cpu 
__maybe_unused){
     /*
      * If the timer handler is currently running and the
      * timer cannot be cancelled, inactive_task_timer()
      * will see that dl_not_contending is not set, and
      * will not touch the rq's active utilization,
      * so we are still safe.
     */
     if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
         put_task_struct(p);
}
```

I also read the comment and i think this is a Non-issue phenomenon.
If you delete WARN_ON, the kernel can still work very well.
correct?

However the task_struct's refcount is still held, so the code looks like 
this :

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 31c050a0d0ce..d73cb033a06d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -252,7 +252,6 @@ static void task_non_contending(struct task_struct *p)
         if (dl_entity_is_special(dl_se))
                 return;

-       WARN_ON(hrtimer_active(&dl_se->inactive_timer));
         WARN_ON(dl_se->dl_non_contending);

         zerolag_time = dl_se->deadline -
@@ -287,7 +286,9 @@ static void task_non_contending(struct task_struct *p)
         }

         dl_se->dl_non_contending = 1;
-       get_task_struct(p);
+
+       if (!hrtimer_active(&dl_se->inactive_timer));
+               get_task_struct(p);
         hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL);
  }


Did I miss something ?

I saw it directly remove the hrtimer in hrtime_start() if hrtime is queued,
it may be unsafe here when the timer handler is running.

Help ?

I put the syzkaller log and C demo in attachments.

Thanks.



