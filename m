Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704DEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3286B2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfCTDVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 23:21:40 -0400
Received: from mail5.windriver.com ([192.103.53.11]:59122 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfCTDVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 23:21:40 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2K3FQKd008948
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 19 Mar 2019 20:15:36 -0700
Received: from [128.224.162.180] (128.224.162.180) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 19 Mar
 2019 20:15:14 -0700
To:     Steven Rostedt <rostedt@goodmis.org>, <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, <will.deacon@arm.com>,
        <joel@joelfernandes.org>, <namhyung@kernel.org>,
        <akpm@linux-foundation.org>, <tglx@linutronix.de>,
        <rppt@linux.ibm.com>, <linux@dominikbrodowski.net>,
        <adobriyan@gmail.com>, <cai@lca.pw>, <ard.biesheuvel@linaro.org>,
        <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>
From:   He Zhe <zhe.he@windriver.com>
Subject: User Stack Tracer Causes Crash
Message-ID: <897cf5cf-fc24-8a64-cb28-847f2d2e63d2@windriver.com>
Date:   Wed, 20 Mar 2019 11:15:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.180]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

User stack tracer causes crash and hang since the following commit till now(5.1-rc1).

c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")

echo 1 > /proc/sys/kernel/stack_tracer_enabled
echo userstacktrace > /sys/kernel/debug/tracing/trace_options
echo 1 > /sys/kernel/debug/tracing/events/enable
dmesg

login[269]: segfault at 80 ip 00007f7e847edc19 sp 00007ffcc8cefdc0 error 7 in libc-2.29.so[7f7e8478e000+142000]
Code: ff ff 0f 1f 80 00 00 00 00 4a 8d 0c e0 48 8b 51 40 48 85 d2 0f 84 2a ff ff ff 48 81 fb ff 03 00 00 0f 87 ba 01 00 00 48 8b 32 <48> 89 71 40 42 80 2c 20 01 48 c7 42 08 00 00 00 00 48 83 c4 08 48
systemd[1]: segfault at b ip 00007ff15b8a8420 sp 00007ffc6eaab890 error 7 in libc-2.29.so[7ff15b7a1000+142000]
Code: b6 8f 08 00 ff 25 a0 71 08 00 48 83 ec 08 be 01 00 00 00 31 c0 83 3d 1e de 08 00 00 74 0c f0 0f b1 35 1c df 08 00 75 0b eb 23 <0f> b1 35 11 df 08 00 74 1a 48 8d 3d 08 df 08 00 48 81 ec 80 00 00
systemd[1]: segfault at 0 ip 00007ff15bab40db sp 00007ffc6eaaa7f0 error 7 in libsystemd-shared-241.so[7ff15ba2c000+12f000]
Code: cb d4 f7 ff 48 83 c4 20 44 8b 54 24 0c eb b3 41 57 41 56 4d 89 ce 41 55 4d 89 c5 41 54 55 89 f5 53 89 fb 48 81 ec 38 08 00 00 <48> 89 54 24 08 4c 8b bc 24 70 08 00 00 89 4c 24 18 64 48 8b 04 25
printk: systemd: 30 output lines suppressed due to ratelimiting
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU: 5 PID: 1 Comm: systemd Not tainted 5.1.0-rc1-yocto-standard+ #2
Hardware name: Intel Corporation Broadwell Client platform/Basking Ridge, BIOS BDW-E2R1.86C.0118.R01.1503110618 03/11/2015
Call Trace:
 dump_stack+0x67/0x95
 panic+0xfd/0x282
 ? do_exit+0xe34/0xf30
 do_exit+0xf24/0xf30
 ? do_exit+0x5/0xf30
 do_group_exit+0x5c/0xd0
 get_signal+0x18e/0xa40
 do_signal+0x37/0x830
 exit_to_usermode_loop+0x78/0xf0
 prepare_exit_to_usermode+0xa0/0x100
 ? page_fault+0x8/0x30
 retint_user+0x8/0x18
RIP: 0033:0x7ff15bab40db
Code: Bad RIP value.
RSP: 002b:00007ffc6eaaa7f0 EFLAGS: 00010206
RAX: 00007ffc6eaab070 RBX: 0000000000000000 RCX: 00000000000000d8
RDX: 0000559989da74d5 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000559989daa4b5 R09: 0000559989da8150
R10: 0000000000000004 R11: 0000000000000246 R12: 000000000000000b
R13: 0000559989daa4b5 R14: 0000559989da8150 R15: 000000000000000b
Kernel Offset: 0x33200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
------------[ cut here ]------------
sched: Unexpected reschedule of offline CPU#1!
WARNING: CPU: 5 PID: 1 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x95/0xc0
Modules linked in:
CPU: 5 PID: 1 Comm: systemd Not tainted 5.1.0-rc1-yocto-standard+ #2
Hardware name: Intel Corporation Broadwell Client platform/Basking Ridge, BIOS BDW-E2R1.86C.0118.R01.1503110618 03/11/2015
RIP: 0010:native_smp_send_reschedule+0x95/0xc0
Code: 5d 5d c3 b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 b8 bc b6 b5 e8 0a 85 13 00 44 89 e6 48 c7 c7 c8 7f 78 b5 e8 eb c5 02 00 <0f> 0b b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 88 bc b6 b5 e8
RSP: 0018:ffff9434f8d43c38 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb5b83e98
RBP: ffff9434f8d43c50 R08: 0000000000010004 R09: 00000000000002bf
R10: ffff9434f8d43b70 R11: 00000000000002be R12: 0000000000000001
R13: 0000000000000001 R14: ffff9434f8d43d28 R15: ffff9434f0570000
FS:  00007ff15b6b6840(0000) GS:ffff9434f8d40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff15bab40b1 CR3: 000000007220e005 CR4: 00000000003606e0
Call Trace:
 <IRQ>
 resched_curr+0xac/0x180
 check_preempt_curr+0x56/0xb0
 ttwu_do_wakeup.isra.17+0x1e/0x270
 ttwu_do_activate+0x78/0x90
 try_to_wake_up+0x243/0x5c0
 ? default_wake_function+0x5/0x20
 default_wake_function+0x12/0x20
 autoremove_wake_function+0x12/0x40
 __wake_up_common+0x8c/0x130
 __wake_up_common_lock+0x80/0xc0
 __wake_up+0x13/0x20
 wake_up_klogd_work_func+0x4c/0x80
 irq_work_run_list+0x6c/0x90
 ? tick_sched_handle.isra.5+0x50/0x50
 irq_work_tick+0x55/0x60
 update_process_times+0x42/0x60
 tick_sched_handle.isra.5+0x34/0x50
 tick_sched_timer+0x40/0xa0
 __hrtimer_run_queues+0x175/0x450
 hrtimer_interrupt+0x141/0x290
 smp_apic_timer_interrupt+0x8f/0x260
 apic_timer_interrupt+0xf/0x20
 </IRQ>
RIP: 0010:panic+0x242/0x282
Code: b0 83 3d 8a e4 bf 01 00 74 05 e8 4b c6 02 00 48 c7 c6 00 91 e7 b5 48 c7 c7 68 f7 78 b5 e8 ab 74 07 00 e8 e3 60 10 00 fb 31 db <4c> 39 eb 7c 1d 41 83 f4 01 48 8b 05 30 e4 bf 01 44 89 e7 e8 78 64
RSP: 0018:ffffb306c038fc58 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffffb42815d4 RDI: ffffffffb427ac5d
RBP: ffffb306c038fcd0 R08: 0000000080000000 R09: 000000000000b7cc
R10: 0000000000000944 R11: 00000000000002bc R12: 0000000000000000
R13: 0000000000000000 R14: ffff9434f5f80070 R15: ffff9434f5f80000
 ? do_exit+0xf24/0xf30
 ? panic+0x23f/0x282
 ? panic+0x23f/0x282
 ? do_exit+0xe34/0xf30
 do_exit+0xf24/0xf30
 ? do_exit+0x5/0xf30
 do_group_exit+0x5c/0xd0
 get_signal+0x18e/0xa40
 do_signal+0x37/0x830
 exit_to_usermode_loop+0x78/0xf0
 prepare_exit_to_usermode+0xa0/0x100
 ? page_fault+0x8/0x30
 retint_user+0x8/0x18
RIP: 0033:0x7ff15bab40db
Code: Bad RIP value.
RSP: 002b:00007ffc6eaaa7f0 EFLAGS: 00010206
RAX: 00007ffc6eaab070 RBX: 0000000000000000 RCX: 00000000000000d8
RDX: 0000559989da74d5 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000559989daa4b5 R09: 0000559989da8150
R10: 0000000000000004 R11: 0000000000000246 R12: 000000000000000b
R13: 0000559989daa4b5 R14: 0000559989da8150 R15: 000000000000000b
---[ end trace 3a4eec2e1252dd20 ]---
------------[ cut here ]------------
sched: Unexpected reschedule of offline CPU#6!
WARNING: CPU: 5 PID: 1 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x95/0xc0
Modules linked in:
CPU: 5 PID: 1 Comm: systemd Tainted: G        W         5.1.0-rc1-yocto-standard+ #2
Hardware name: Intel Corporation Broadwell Client platform/Basking Ridge, BIOS BDW-E2R1.86C.0118.R01.1503110618 03/11/2015
RIP: 0010:native_smp_send_reschedule+0x95/0xc0
Code: 5d 5d c3 b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 b8 bc b6 b5 e8 0a 85 13 00 44 89 e6 48 c7 c7 c8 7f 78 b5 e8 eb c5 02 00 <0f> 0b b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 88 bc b6 b5 e8
RSP: 0018:ffff9434f8d43b20 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb5b83e98
RBP: ffff9434f8d43b38 R08: 0000000000010006 R09: 0000000000000307
R10: ffff9434f8d43a58 R11: 0000000000000306 R12: 0000000000000006
R13: 0000000000000001 R14: ffff9434f8d43c10 R15: ffff9434f5138000
FS:  00007ff15b6b6840(0000) GS:ffff9434f8d40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff15bab40b1 CR3: 000000007220e005 CR4: 00000000003606e0
Call Trace:
 <IRQ>
 resched_curr+0xac/0x180
 check_preempt_curr+0x56/0xb0
 ttwu_do_wakeup.isra.17+0x1e/0x270
 ttwu_do_activate+0x78/0x90
 try_to_wake_up+0x243/0x5c0
 ? default_wake_function+0x5/0x20
 default_wake_function+0x12/0x20
 __wake_up_common+0x8c/0x130
 __wake_up_common_lock+0x80/0xc0
 __wake_up+0x13/0x20
 ep_poll_callback+0x1bb/0x350
 __wake_up_common+0x8c/0x130
 __wake_up_common_lock+0x80/0xc0
 __wake_up+0x13/0x20
 wake_up_klogd_work_func+0x4c/0x80
 irq_work_run_list+0x6c/0x90
 ? tick_sched_handle.isra.5+0x50/0x50
 irq_work_tick+0x55/0x60
 update_process_times+0x42/0x60
 tick_sched_handle.isra.5+0x34/0x50
 tick_sched_timer+0x40/0xa0
 __hrtimer_run_queues+0x175/0x450
 hrtimer_interrupt+0x141/0x290
 smp_apic_timer_interrupt+0x8f/0x260
 apic_timer_interrupt+0xf/0x20
 </IRQ>
RIP: 0010:panic+0x242/0x282
Code: b0 83 3d 8a e4 bf 01 00 74 05 e8 4b c6 02 00 48 c7 c6 00 91 e7 b5 48 c7 c7 68 f7 78 b5 e8 ab 74 07 00 e8 e3 60 10 00 fb 31 db <4c> 39 eb 7c 1d 41 83 f4 01 48 8b 05 30 e4 bf 01 44 89 e7 e8 78 64
RSP: 0018:ffffb306c038fc58 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffffb42815d4 RDI: ffffffffb427ac5d
RBP: ffffb306c038fcd0 R08: 0000000080000000 R09: 000000000000b7cc
R10: 0000000000000944 R11: 00000000000002bc R12: 0000000000000000
R13: 0000000000000000 R14: ffff9434f5f80070 R15: ffff9434f5f80000
 ? do_exit+0xf24/0xf30
 ? panic+0x23f/0x282
 ? panic+0x23f/0x282
 ? do_exit+0xe34/0xf30
 do_exit+0xf24/0xf30
 ? do_exit+0x5/0xf30
 do_group_exit+0x5c/0xd0
 get_signal+0x18e/0xa40
 do_signal+0x37/0x830
 exit_to_usermode_loop+0x78/0xf0
 prepare_exit_to_usermode+0xa0/0x100
 ? page_fault+0x8/0x30
 retint_user+0x8/0x18
RIP: 0033:0x7ff15bab40db
Code: Bad RIP value.
RSP: 002b:00007ffc6eaaa7f0 EFLAGS: 00010206
RAX: 00007ffc6eaab070 RBX: 0000000000000000 RCX: 00000000000000d8
RDX: 0000559989da74d5 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000559989daa4b5 R09: 0000559989da8150
R10: 0000000000000004 R11: 0000000000000246 R12: 000000000000000b
R13: 0000559989daa4b5 R14: 0000559989da8150 R15: 000000000000000b
---[ end trace 3a4eec2e1252dd21 ]---
------------[ cut here ]------------
sched: Unexpected reschedule of offline CPU#2!
WARNING: CPU: 5 PID: 1 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x95/0xc0
Modules linked in:
CPU: 5 PID: 1 Comm: systemd Tainted: G        W         5.1.0-rc1-yocto-standard+ #2
Hardware name: Intel Corporation Broadwell Client platform/Basking Ridge, BIOS BDW-E2R1.86C.0118.R01.1503110618 03/11/2015
RIP: 0010:native_smp_send_reschedule+0x95/0xc0
Code: 5d 5d c3 b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 b8 bc b6 b5 e8 0a 85 13 00 44 89 e6 48 c7 c7 c8 7f 78 b5 e8 eb c5 02 00 <0f> 0b b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 88 bc b6 b5 e8
RSP: 0018:ffff9434f8d43df8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb5b83e98
RBP: ffff9434f8d43e10 R08: 0000000000010001 R09: 0000000000000352
R10: 0000000000000000 R11: 0000000000000351 R12: 0000000000000002
R13: 0000000000000001 R14: 0000000000000002 R15: 0000000000000000
FS:  00007ff15b6b6840(0000) GS:ffff9434f8d40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff15bab40b1 CR3: 000000007220e005 CR4: 00000000003606e0
Call Trace:
 <IRQ>
 kick_ilb+0xe2/0x110
 trigger_load_balance+0x113/0x200
 scheduler_tick+0xa9/0xd0
 ? tick_sched_handle.isra.5+0x50/0x50
 update_process_times+0x47/0x60
 tick_sched_handle.isra.5+0x34/0x50
 tick_sched_timer+0x40/0xa0
 __hrtimer_run_queues+0x175/0x450
 hrtimer_interrupt+0x141/0x290
 smp_apic_timer_interrupt+0x8f/0x260
 apic_timer_interrupt+0xf/0x20
 </IRQ>
RIP: 0010:panic+0x242/0x282
Code: b0 83 3d 8a e4 bf 01 00 74 05 e8 4b c6 02 00 48 c7 c6 00 91 e7 b5 48 c7 c7 68 f7 78 b5 e8 ab 74 07 00 e8 e3 60 10 00 fb 31 db <4c> 39 eb 7c 1d 41 83 f4 01 48 8b 05 30 e4 bf 01 44 89 e7 e8 78 64
RSP: 0018:ffffb306c038fc58 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffffb42815d4 RDI: ffffffffb427ac5d
RBP: ffffb306c038fcd0 R08: 0000000080000000 R09: 000000000000b7cc
R10: 0000000000000944 R11: 00000000000002bc R12: 0000000000000000
R13: 0000000000000000 R14: ffff9434f5f80070 R15: ffff9434f5f80000
 ? do_exit+0xf24/0xf30
 ? panic+0x23f/0x282
 ? panic+0x23f/0x282
 ? do_exit+0xe34/0xf30
 do_exit+0xf24/0xf30
 ? do_exit+0x5/0xf30
 do_group_exit+0x5c/0xd0
 get_signal+0x18e/0xa40
 do_signal+0x37/0x830
 exit_to_usermode_loop+0x78/0xf0
 prepare_exit_to_usermode+0xa0/0x100
 ? page_fault+0x8/0x30
 retint_user+0x8/0x18
RIP: 0033:0x7ff15bab40db
Code: Bad RIP value.
RSP: 002b:00007ffc6eaaa7f0 EFLAGS: 00010206
RAX: 00007ffc6eaab070 RBX: 0000000000000000 RCX: 00000000000000d8
RDX: 0000559989da74d5 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000559989daa4b5 R09: 0000559989da8150
R10: 0000000000000004 R11: 0000000000000246 R12: 000000000000000b
R13: 0000559989daa4b5 R14: 0000559989da8150 R15: 000000000000000b
---[ end trace 3a4eec2e1252dd22 ]---



Zhe
