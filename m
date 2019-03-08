Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA39C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0052081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCHJl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:41:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8825 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfCHJl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:41:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9A9A80F9A;
        Fri,  8 Mar 2019 09:41:26 +0000 (UTC)
Received: from [10.36.112.64] (ovpn-112-64.ams2.redhat.com [10.36.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CACFD1001E6E;
        Fri,  8 Mar 2019 09:41:20 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [Regression]: NMI watchdog regression from v4.19 onwards
To:     peterz@infradead.org, oleg@redhat.com
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        Peter Xu <peterx@redhat.com>
Message-ID: <b99c5a25-a5fe-18dd-2f1d-bdd6834f03e5@redhat.com>
Date:   Fri, 8 Mar 2019 10:41:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 08 Mar 2019 09:41:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Oleg,

NMI watchdog fires systematically on my machine with recent Kernels, 
whereas the NMI watch is supposed to be disabled:

# cat /proc/sys/kernel/watchdog
0
# cat /proc/sys/kernel/nmi_watchdog
0
#
[   53.765648] NMI watchdog: Watchdog detected hard LOCKUP on cpu 7
[   53.765648] Modules linked in: nft_chain_route_ipv4 xt_CHECKSUM 
nft_chain_nat_ipv4 ipt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 
nft_counter nft_cd
[   53.765661] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.0.0 #22
[   53.765661] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 
2.4.3 01/17/2017
[   53.765661] RIP: 0010:poll_idle+0xa0/0x102
[   53.765662] Code: 54 48 69 db e8 03 00 00 eb 1b f3 90 83 e8 01 75 19 
65 8b 3d e2 a4 5b 6e e8 fd 9f 8a ff 48 29 e8 48 39 d8 77 60 b8 c9 00 00 
00 <65> 48 8b5
[   53.765662] RSP: 0000:ffffa77ac01f3e70 EFLAGS: 00000206
[   53.765663] RAX: 000000000000000a RBX: 00000000000007d0 RCX: 
000000000000001f
[   53.765663] RDX: 0000000000000000 RSI: 0000000028000347 RDI: 
fffff386de8dd002
[   53.765663] RBP: 0000000c84ad17fc R08: 0000000000000004 R09: 
0000000000021540
[   53.765664] R10: 000028124ceb5144 R11: 0000000000000010 R12: 
ffff9905dfbea648
[   53.765664] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[   53.765664] FS:  0000000000000000(0000) GS:ffff9905dfbc0000(0000) 
knlGS:0000000000000000
[   53.765665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.765665] CR2: 0000000000000000 CR3: 000000037f60e001 CR4: 
00000000003606e0
[   53.765665] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   53.765665] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   53.765666] Call Trace:
[   53.765666]  cpuidle_enter_state+0x73/0x440
[   53.765666]  do_idle+0x1f1/0x230
[   53.765666]  cpu_startup_entry+0x19/0x20
[   53.765667]  start_secondary+0x195/0x1e0
[   53.765667]  secondary_startup_64+0xb6/0xc0
[   53.765667] Kernel panic - not syncing: Hard LOCKUP
[   53.765667] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.0.0 #22
[   53.765668] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 
2.4.3 01/17/2017
[   53.765668] Call Trace:
[   53.765668]  <NMI>
[   53.765668]  dump_stack+0x46/0x60
[   53.765669]  panic+0xfb/0x29b
[   53.765669]  ? startup_64+0x1/0x30
[   53.765669]  ? startup_64+0x30/0x30
[   53.765669]  nmi_panic.cold.9+0xc/0xc
[   53.765670]  watchdog_overflow_callback.cold.7+0x5c/0x70
[   53.765670]  __perf_event_overflow+0x52/0xe0
[   53.765670]  handle_pmi_common+0x1b3/0x210
[   53.765670]  ? set_pte_vaddr_p4d+0x4a/0x60
[   53.765671]  ? ghes_copy_tofrom_phys+0xc0/0x170
[   53.765671]  intel_pmu_handle_irq+0xc9/0x1c0
[   53.765671]  perf_event_nmi_handler+0x2d/0x50
[   53.765671]  nmi_handle+0x63/0x110
[   53.765672]  default_do_nmi+0x4e/0x100
[   53.765672]  do_nmi+0x100/0x160
[   53.765672]  end_repeat_nmi+0x16/0x50
[   53.765672] RIP: 0010:poll_idle+0xa0/0x102
[   53.765673] Code: 54 48 69 db e8 03 00 00 eb 1b f3 90 83 e8 01 75 19 
65 8b 3d e2 a4 5b 6e e8 fd 9f 8a ff 48 29 e8 48 39 d8 77 60 b8 c9 00 00 
00 <65> 48 8b5
[   53.765673] RSP: 0000:ffffa77ac01f3e70 EFLAGS: 00000206
[   53.765674] RAX: 000000000000000a RBX: 00000000000007d0 RCX: 
000000000000001f
[   53.765674] RDX: 0000000000000000 RSI: 0000000028000347 RDI: 
fffff386de8dd002
[   53.765674] RBP: 0000000c84ad17fc R08: 0000000000000004 R09: 
0000000000021540
[   53.765675] R10: 000028124ceb5144 R11: 0000000000000010 R12: 
ffff9905dfbea648
[   53.765675] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[   53.765675]  ? poll_idle+0xa0/0x102
[   53.765675]  ? poll_idle+0xa0/0x102
[   53.765676]  </NMI>
[   53.765676]  cpuidle_enter_state+0x73/0x440
[   53.765676]  do_idle+0x1f1/0x230
[   53.765676]  cpu_startup_entry+0x19/0x20
[   53.765677]  start_secondary+0x195/0x1e0
[   53.765677]  secondary_startup_64+0xb6/0xc0
[   54.804636] NMI watchdog: Watchdog detected hard LOCKUP on cpu 6
[   54.804637] Modules linked in: nft_chain_route_ipv4 xt_CHECKSUM 
nft_chain_nat_ipv4 ipt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 
nft_counter nft_cd
[   54.804649] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.0.0 #22
[   54.804649] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 
2.4.3 01/17/2017
[   54.804649] RIP: 0010:poll_idle+0xa0/0x102
[   54.804650] Code: 54 48 69 db e8 03 00 00 eb 1b f3 90 83 e8 01 75 19 
65 8b 3d e2 a4 5b 6e e8 fd 9f 8a ff 48 29 e8 48 39 d8 77 60 b8 c9 00 00 
00 <65> 48 8b5
[   54.804650] RSP: 0000:ffffa77ac01ebe70 EFLAGS: 00000202
[   54.804650] RAX: 0000000000000046 RBX: 00000000000007d0 RCX: 
000000000000001f
[   54.804651] RDX: 0000000000000000 RSI: 0000000028000347 RDI: 
fffff386de8dd002
[   54.804651] RBP: 0000000c84aebd9f R08: 0000000000000002 R09: 
0000000000021540
[   54.804651] R10: 000028124cf09684 R11: 0000000000000032 R12: 
ffff9905dfbaa648
[   54.804652] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[   54.804652] FS:  0000000000000000(0000) GS:ffff9905dfb80000(0000) 
knlGS:0000000000000000
[   54.804652] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.804653] CR2: 0000000000000000 CR3: 000000037f60e001 CR4: 
00000000003606e0
[   54.804653] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   54.804653] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   54.804653] Call Trace:
[   54.804654]  cpuidle_enter_state+0x73/0x440
[   54.804654]  do_idle+0x1f1/0x230
[   54.804654]  cpu_startup_entry+0x19/0x20
[   54.804654]  start_secondary+0x195/0x1e0
[   54.804655]  secondary_startup_64+0xb6/0xc0
[   54.804655] Shutting down cpus with NMI
[   54.804655] Kernel Offset: 0x10200000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   55.495398] ---[ end Kernel panic - not syncing: Hard LOCKUP ]---


It always triggers on isolated CPUs (CPU6 and CPU7 out of 8 CPUs are
isolated). This is the Kernel cmdline:

BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.0.0 root=/dev/mapper/rhel_xxxxx-root 
ro crashkernel=auto resume=/dev/mapper/rhel_xxxxx-swap 
rd.lvm.lv=rhel_xxxxx/root rd.lvm.lv=rhel_xxxxx/swap console=ttyS1,115200 
skew_tick=1 isolcpus=6-7 intel_pstate=disable nosoftlockup nohz=on 
nohz_full=6-7 rcu_nocbs=6-7 skew_tick=1 isolcpus=6-7 
intel_pstate=disable nosoftlockup nohz=on nohz_full=6-7 rcu_nocbs=6-7


Just setting this command line is not enough to reproduce the issue.
The system uses tuned with realtime-virtual-host profile [0], which
among other tunings disables NMI watchdog through its sysctl interface.

I have tried to manually write same sysctls with same values by
strace'ing tuned daemon, but it does not reproduce the issue. So
there is certainly something more to do to trigger it.

As the issue does not reproduce on Kernel v4.18, I have managed to
bisect it down to one of your commit:

# good: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
git bisect good 94710cac0ef4ee177a63b5227664b38c95bbf703
# bad: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
git bisect bad 1c163f4c7b3f621efff9b28a47abb36f7378d783
# skip: [18d0eae30e6a4f8644d589243d7ac1d70d29203d] Merge tag 
'char-misc-4.20-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect skip 18d0eae30e6a4f8644d589243d7ac1d70d29203d
# bad: [9be66f55b1319d71d492ac1e58a3c352e0b23070] Merge tag 
'renesas-fixes-for-v4.20' of 
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into fixes
git bisect bad 9be66f55b1319d71d492ac1e58a3c352e0b23070
# bad: [07b5e16e9830878291bc83df70e87cdb0833517c] tty: serial: imx: add 
lock for registers save/restore
git bisect bad 07b5e16e9830878291bc83df70e87cdb0833517c
# bad: [54dbe75bbf1e189982516de179147208e90b5e45] Merge tag 
'drm-next-2018-08-15' of git://anongit.freedesktop.org/drm/drm
git bisect bad 54dbe75bbf1e189982516de179147208e90b5e45
# bad: [0a957467c5fd46142bc9c52758ffc552d4c5e2f7] x86: i8259: Add 
missing include file
git bisect bad 0a957467c5fd46142bc9c52758ffc552d4c5e2f7
# bad: [958f338e96f874a0d29442396d6adf9c1e17aa2d] Merge branch 
'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 958f338e96f874a0d29442396d6adf9c1e17aa2d
# bad: [85a0b791bc17f7a49280b33e2905d109c062a47b] Merge branch 
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect bad 85a0b791bc17f7a49280b33e2905d109c062a47b
# bad: [8603596a327c978534f5c45db135e6c36b4b1425] Merge branch 
'perf-core-for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 8603596a327c978534f5c45db135e6c36b4b1425
# good: [2406fb8d94fb17fee3ace0c09427c08825eacb16] Merge branch 
'sched-urgent-for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 2406fb8d94fb17fee3ace0c09427c08825eacb16
# good: [95f04328e42dc7d1eb08f3cb38150c1f2ec09f57] perf list: Unify 
metric group description format with PMU event description
git bisect good 95f04328e42dc7d1eb08f3cb38150c1f2ec09f57
# good: [fd2efaa4eb5317c3a86357a83a7d456a1b86a0ac] locking/atomics: 
Rework ordering barriers
git bisect good fd2efaa4eb5317c3a86357a83a7d456a1b86a0ac
# bad: [2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a] sched/fair: Remove 
#ifdefs from scale_rt_capacity()
git bisect bad 2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
# bad: [c079629862b20c101e8336362a8b042ec7d942fe] sched/pelt: Move PELT 
related code in a dedicated file
git bisect bad c079629862b20c101e8336362a8b042ec7d942fe
# bad: [9cf57731b63e37ed995b46690adc604891a9a28f] watchdog/softlockup: 
Replace "watchdog/%u" threads with cpu_stop_work
git bisect bad 9cf57731b63e37ed995b46690adc604891a9a28f
# good: [8f894bf47dc9e8b77166125a084a7217693a28cd] sched/debug: Use 
match_string() helper instead of open-coded logic
git bisect good 8f894bf47dc9e8b77166125a084a7217693a28cd
# good: [03585a95cd830e7a92697d2a8fe9a34df87563db] sched/fair: Remove 
stale tg_unthrottle_up() comments
git bisect good 03585a95cd830e7a92697d2a8fe9a34df87563db
# good: [4520843dfa34417eb1e2061f60d2345d9ca614e1] Merge branch 
'sched/urgent' into sched/core, to pick up fixes
git bisect good 4520843dfa34417eb1e2061f60d2345d9ca614e1
# first bad commit: [9cf57731b63e37ed995b46690adc604891a9a28f] 
watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work

------
commit 9cf57731b63e37ed995b46690adc604891a9a28f (HEAD)
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Jun 7 10:52:03 2018 +0200

     watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work

     Oleg suggested to replace the "watchdog/%u" threads with
     cpu_stop_work. That removes one thread per CPU while at the same time
     fixes softlockup vs SCHED_DEADLINE.

     But more importantly, it does away with the single
     smpboot_update_cpumask_percpu_thread() user, which allows
     cleanups/shrinkage of the smpboot interface.

     Suggested-by: Oleg Nesterov <oleg@redhat.com>
     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
     Cc: Linus Torvalds <torvalds@linux-foundation.org>
     Cc: Peter Zijlstra <peterz@infradead.org>
     Cc: Thomas Gleixner <tglx@linutronix.de>
     Cc: linux-kernel@vger.kernel.org
     Signed-off-by: Ingo Molnar <mingo@kernel.org>
-----

I'll continue to try to reproduce it manually, without tuned, but
maybe that does ring a bell for you?

I have my machine available for any tests you might find useful to
run.

Regards,
Maxime

[0]: https://github.com/redhat-performance/tuned
