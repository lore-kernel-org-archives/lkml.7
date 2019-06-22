Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B47C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E729D20657
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfFVTbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 15:31:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVTbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 15:31:44 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1heljf-0004Cj-7n; Sat, 22 Jun 2019 21:31:39 +0200
Date:   Sat, 22 Jun 2019 21:31:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+a952f743523593b39174@syzkaller.appspotmail.com>
cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: BUG: unable to handle kernel paging request in
 cpuacct_account_field
In-Reply-To: <00000000000008f38a058bd500b9@google.com>
Message-ID: <alpine.DEB.2.21.1906222131040.5503@nanos.tec.linutronix.de>
References: <00000000000008f38a058bd500b9@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, syzbot wrote:

Cc+: ....

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164d94f6a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
> dashboard link: https://syzkaller.appspot.com/bug?extid=a952f743523593b39174
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1372abc6a00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a952f743523593b39174@syzkaller.appspotmail.com
> 
> BUG: unable to handle page fault for address: ffffde202771d9b9
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Thread overran stack, or stack corrupted
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8777 Comm: syz-executor.5 Not tainted 5.2.0-rc5+ #38
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> 01/01/2011
> RIP: 0010:cpuacct_account_field+0x12b/0x2f0 kernel/sched/cpuacct.c:366
> Code: c5 60 02 75 88 48 89 fa 48 c1 ea 03 42 80 3c 32 00 0f 85 81 01 00 00 48
> 03 1c c5 60 02 75 88 4a 8d 3c 3b 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 0f 85
> 89 01 00 00 4e 01 2c 3b 49 8d bc 24 28 01 00
> RSP: 0018:ffff8880ae909c78 EFLAGS: 00010802
> RAX: 1fffe2202771d9b9 RBX: ffff11013b8ecdb8 RCX: ffffffff83358d3e
> RDX: 1ffffffff10ea04d RSI: ffffffff83358d4c RDI: ffff11013b8ecdc8
> RBP: ffff8880ae909ca8 R08: ffff888090866500 R09: 0000000000000001
> R10: fffffbfff1141b45 R11: ffff888090866500 R12: ffff88808cfecc80
> R13: 0000000000966a20 R14: dffffc0000000000 R15: 0000000000000010
> FS:  0000555555ff5940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffde202771d9b9 CR3: 000000008533e000 CR4: 00000000001406e0
> Call Trace:
> <IRQ>
> cgroup_account_cputime_field include/linux/cgroup.h:789 [inline]
> task_group_account_field kernel/sched/cputime.c:109 [inline]
> account_system_index_time+0x11d/0x390 kernel/sched/cputime.c:172
> irqtime_account_process_tick.isra.0+0x386/0x490 kernel/sched/cputime.c:389
> account_process_tick+0x27f/0x350 kernel/sched/cputime.c:484
> update_process_times+0x25/0x80 kernel/time/timer.c:1637
> tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:167
> tick_sched_timer+0x47/0x130 kernel/time/tick-sched.c:1298
> __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
> __hrtimer_run_queues+0x33b/0xdd0 kernel/time/hrtimer.c:1451
> hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
> local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
> smp_apic_timer_interrupt+0x111/0x550 arch/x86/kernel/apic/apic.c:1066
> apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
> </IRQ>
> Modules linked in:
> CR2: ffffde202771d9b9
> ---[ end trace 4a0799d29c250606 ]---
> RIP: 0010:cpuacct_account_field+0x12b/0x2f0 kernel/sched/cpuacct.c:366
> Code: c5 60 02 75 88 48 89 fa 48 c1 ea 03 42 80 3c 32 00 0f 85 81 01 00 00 48
> 03 1c c5 60 02 75 88 4a 8d 3c 3b 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 0f 85
> 89 01 00 00 4e 01 2c 3b 49 8d bc 24 28 01 00
> RSP: 0018:ffff8880ae909c78 EFLAGS: 00010802
> RAX: 1fffe2202771d9b9 RBX: ffff11013b8ecdb8 RCX: ffffffff83358d3e
> RDX: 1ffffffff10ea04d RSI: ffffffff83358d4c RDI: ffff11013b8ecdc8
> RBP: ffff8880ae909ca8 R08: ffff888090866500 R09: 0000000000000001
> R10: fffffbfff1141b45 R11: ffff888090866500 R12: ffff88808cfecc80
> R13: 0000000000966a20 R14: dffffc0000000000 R15: 0000000000000010
> FS:  0000555555ff5940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffde202771d9b9 CR3: 000000008533e000 CR4: 00000000001406e0
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
