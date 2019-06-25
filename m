Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C1C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812EA2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfFYGVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:21:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40631 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfFYGVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:21:00 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfep6-0005b0-V5; Tue, 25 Jun 2019 08:20:57 +0200
Date:   Tue, 25 Jun 2019 08:20:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in mark_lock
In-Reply-To: <0000000000005aedf1058c1bf7e8@google.com>
Message-ID: <alpine.DEB.2.21.1906250820060.32342@nanos.tec.linutronix.de>
References: <0000000000005aedf1058c1bf7e8@google.com>
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

On Mon, 24 Jun 2019, syzbot wrote:

> Hello,

CC++ Peterz 

> 
> syzbot found the following crash on:
> 
> HEAD commit:    dc636f5d Add linux-next specific files for 20190620
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=162b68b1a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=99c104b0092a557b
> dashboard link: https://syzkaller.appspot.com/bug?extid=a861f52659ae2596492b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110b24f6a00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 0 PID: 9968 at kernel/locking/lockdep.c:167 hlock_class
> kernel/locking/lockdep.c:167 [inline]
> WARNING: CPU: 0 PID: 9968 at kernel/locking/lockdep.c:167 hlock_class
> kernel/locking/lockdep.c:156 [inline]
> WARNING: CPU: 0 PID: 9968 at kernel/locking/lockdep.c:167
> mark_lock+0x22b/0x11e0 kernel/locking/lockdep.c:3594
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 9968 Comm: syz-executor.2 Not tainted 5.2.0-rc5-next-20190620 #19
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> 01/01/2011
> Call Trace:
> <IRQ>
> __dump_stack lib/dump_stack.c:77 [inline]
> dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> panic+0x2dc/0x755 kernel/panic.c:219
> __warn.cold+0x20/0x4c kernel/panic.c:576
> report_bug+0x263/0x2b0 lib/bug.c:186
> fixup_bug arch/x86/kernel/traps.c:179 [inline]
> fixup_bug arch/x86/kernel/traps.c:174 [inline]
> do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
> do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
> invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
> RIP: 0010:hlock_class kernel/locking/lockdep.c:167 [inline]
> RIP: 0010:hlock_class kernel/locking/lockdep.c:156 [inline]
> RIP: 0010:mark_lock+0x22b/0x11e0 kernel/locking/lockdep.c:3594
> Code: d0 7c 08 84 d2 0f 85 33 0f 00 00 44 8b 15 4d 14 4a 08 45 85 d2 75 b6 48
> c7 c6 c0 a6 8b 87 48 c7 c7 00 a7 8b 87 e8 ad e6 eb ff <0f> 0b 31 db e9 a8 fe
> ff ff 48 c7 c7 80 71 86 8a e8 f0 95 53 00 e9
> RSP: 0018:ffff8880ae809ad0 EFLAGS: 00010082
> RAX: 0000000000000000 RBX: 0000000000000f1d RCX: 0000000000000000
> RDX: 0000000000010000 RSI: ffffffff815b37e6 RDI: ffffed1015d0134c
> RBP: ffff8880ae809b20 R08: ffff88808662e0c0 R09: fffffbfff11b3285
> R10: fffffbfff11b3284 R11: ffffffff88d99423 R12: 0000000000000000
> R13: ffff88808662e9c8 R14: 000000000000004f R15: 00000000000c4f1d
> mark_usage kernel/locking/lockdep.c:3485 [inline]
> __lock_acquire+0x1e1a/0x4680 kernel/locking/lockdep.c:3839
> lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4418
> __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
> try_to_wake_up+0x90/0x1430 kernel/sched/core.c:2000
> wake_up_process+0x10/0x20 kernel/sched/core.c:2114

  ^^^^^^^^^^^^^^

> hrtimer_wakeup+0x48/0x60 kernel/time/hrtimer.c:1636
> __run_hrtimer kernel/time/hrtimer.c:1388 [inline]
> __hrtimer_run_queues+0x364/0xe40 kernel/time/hrtimer.c:1450
> hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1508
> local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
> smp_apic_timer_interrupt+0x12a/0x5b0 arch/x86/kernel/apic/apic.c:1066
> apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
> </IRQ>
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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
