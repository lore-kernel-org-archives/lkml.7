Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4C1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1202146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPZjeT/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLROQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:16:01 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34744 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLROQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:16:00 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so801504qvf.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8t0dYHbivI7jIsrUuwVR27YLo8SMDodvslI109VrSWw=;
        b=bPZjeT/Si7zg5n8LSw6mREj4nzn0v7zeb5tdVcOzQtqRartmQMSoetrcwoG527RlpB
         x/P49/9oUDO+xaylBL73qhgY7Eo4VxrgkR4MpotFdowIyoyvecXHwsbgH/5g8MDbZiYB
         xI19FvGg9z8g7v0ocgc2aE/7omDR9+QBUODdPe51yxkMEhhbn/51JOi/fwFmNbG89PPs
         0zoGXzm9CURMmf/O8SS6JM0NrV/atcrCuhgEI8IugNDesiOXRwbA0FZpOMMm53nSuUYW
         w7YTzur2VsWPnzwPmi7p8/OgXuyux+BR58rMlgdMuxLl9Yg6j7RCirnLHTsiX3FSBkOs
         mPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8t0dYHbivI7jIsrUuwVR27YLo8SMDodvslI109VrSWw=;
        b=elJ8UfN/mqRPpXFP8yoYvBLARH6WL5PBKO4e9eNaGwfSqgiWJKMcXh4MluSNVXPVQH
         MW0mD13F+H9yiBOfKnQ3lEtuDARZ36H2lPzRxZTM6wO465y1Fh29Bp5zrDKNBfAHKLW3
         EECu13X+Zs7LMRRNpOa5HDIIuj1F/sAStbOpeNPbjEBJ9gmmsl+tdv2EoJWHSXgeLHCH
         WIIrHO4+x03t4rATXEOm5EuEhX82uQoEg0vdfM4gDNuPTw1Sc5SLjVWu/gwKfODOOQDI
         wpm38bMOTZEig9eR7kOuprU5NYdsayzRuDqNJaxsbaxT/AkuGv4juqRPd+0SkE+FbiYO
         m9LA==
X-Gm-Message-State: APjAAAVZ/MdeZ4NFuOIsQlC+L1uV8uIFS6WxWKObtadjPMZKeDR4I+OU
        jg+8oHSvRHidqlNmv8ejcQ32L9JH6Ae2kBoI/MbDnw==
X-Google-Smtp-Source: APXvYqzvk28iWQCKgmrIf4BKVBzeHMF9fdGUqLg7DWJbS0kK/W/xmlvpj1CJNYgXqzikduJeeNQCkKabtCzgdBdnD5w=
X-Received: by 2002:ad4:4810:: with SMTP id g16mr2402347qvy.22.1576678558999;
 Wed, 18 Dec 2019 06:15:58 -0800 (PST)
MIME-Version: 1.0
References: <00000000000021cc1a0599f66f55@google.com> <CACT4Y+Y0FXiGgsMt=k9d73bkQvW-NqyUoS=w6KXQ=28_ROz1YA@mail.gmail.com>
 <87o8w5u47c.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87o8w5u47c.fsf@dja-thinkpad.axtens.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Dec 2019 15:15:47 +0100
Message-ID: <CACT4Y+ZaT37yoxU7iXUF73iszxNSW_8QVys7NxRnXZZ-pa9Lgg@mail.gmail.com>
Subject: Re: BUG: soft lockup in sock_setsockopt
To:     Daniel Axtens <dja@axtens.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     syzbot <syzbot+e7e13ce5d4ca294ca90a@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, namit@vmware.com,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 2:57 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Dmitry Vyukov <dvyukov@google.com> writes:
>
> > On Wed, Dec 18, 2019 at 9:43 AM syzbot
> > <syzbot+e7e13ce5d4ca294ca90a@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    9065e063 Merge branch 'x86-urgent-for-linus' of git://git...
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=17185e99e00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=dcf10bf83926432a
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=e7e13ce5d4ca294ca90a
> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+e7e13ce5d4ca294ca90a@syzkaller.appspotmail.com
> >
> > +Daniel, kasan-dev,
> >
> > This looks like another stall caused by KASAN+vmalloc. Now it has
> > reached upstream and this instance uses Apparmor rather than Smack.
>
> weird. It looks like the hang happens while waiting for a tlb range
> flush - in particular CPU#0 hangs while waiting for CPU#1 to finish. I
> don't know what was running on CPU#1 122s ago, but it's currently
> SRCU. I see the SRCU code does smp_lock_irq_... but I don't know how
> interrupts would be disabled for that long. (Unless the IPI just gets
> dropped on the floor if it the CPU currently has IRQs off, but surely
> we'd have picked that up somewhere else first?)
>
> The whole code is deep magic to me. Am I accidentally violating any
> restrictions on what can be called when?

Maybe bpf_int_jit_compile stack is in srcu reader critical section and
try_check_zero waits forever for it to leave, while
bpf_int_jit_compile tries to send IPI which does not reach
try_check_zero CPU?

Should this:
    if (--trycount + !srcu_get_delay(ssp) <= 0)
      return false;
in try_check_zero break eventually? What is even the type of that
expression? That's playing with fire in C :)

Can if jump across 0 because  both trycount and srcu_get_delay change
at the same iteration? And then if it's unsigned type in the end, it
does not become -1, but instead 0xffffffff which is not <=0?....


> >> watchdog: BUG: soft lockup - CPU#0 stuck for 122s! [syz-executor.3:9634]
> >> Modules linked in:
> >> irq event stamp: 35786
> >> hardirqs last  enabled at (35785): [<ffffffff81006983>]
> >> trace_hardirqs_on_thunk+0x1a/0x1c arch/x86/entry/thunk_64.S:41
> >> hardirqs last disabled at (35786): [<ffffffff8100699f>]
> >> trace_hardirqs_off_thunk+0x1a/0x1c arch/x86/entry/thunk_64.S:42
> >> softirqs last  enabled at (5788): [<ffffffff880006cd>]
> >> __do_softirq+0x6cd/0x98c kernel/softirq.c:319
> >> softirqs last disabled at (5707): [<ffffffff81478ceb>] invoke_softirq
> >> kernel/softirq.c:373 [inline]
> >> softirqs last disabled at (5707): [<ffffffff81478ceb>] irq_exit+0x19b/0x1e0
> >> kernel/softirq.c:413
> >> CPU: 0 PID: 9634 Comm: syz-executor.3 Not tainted 5.5.0-rc2-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> Google 01/01/2011
> >> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> >> RIP: 0010:csd_lock_wait kernel/smp.c:109 [inline]
> >> RIP: 0010:smp_call_function_single+0x188/0x480 kernel/smp.c:311
> >> Code: 00 e8 6c 23 0b 00 48 8b 4c 24 08 48 8b 54 24 10 48 8d 74 24 40 8b 7c
> >> 24 1c e8 c4 f9 ff ff 41 89 c5 eb 07 e8 4a 23 0b 00 f3 90 <44> 8b 64 24 58
> >> 31 ff 41 83 e4 01 44 89 e6 e8 b5 24 0b 00 45 85 e4
> >> RSP: 0018:ffffc90004d3f480 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> >> RAX: 0000000000040000 RBX: 1ffff920009a7e94 RCX: ffffc90010442000
> >> RDX: 0000000000040000 RSI: ffffffff816a0856 RDI: 0000000000000005
> >> RBP: ffffc90004d3f550 R08: ffff88809e5161c0 R09: ffffed1015d27059
> >> R10: ffffed1015d27058 R11: ffff8880ae9382c7 R12: 0000000000000001
> >> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> >> FS:  00007f19610d6700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007fe53bcc09c0 CR3: 000000008ffc6000 CR4: 00000000001426f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>   smp_call_function_many+0x7ba/0x940 kernel/smp.c:451
> >>   smp_call_function+0x42/0x90 kernel/smp.c:509
> >>   on_each_cpu+0x2f/0x1f0 kernel/smp.c:616
> >>   flush_tlb_kernel_range+0x19b/0x250 arch/x86/mm/tlb.c:839
> >>   kasan_release_vmalloc+0xb4/0xc0 mm/kasan/common.c:976
> >>   __purge_vmap_area_lazy+0xca5/0x1ef0 mm/vmalloc.c:1313
> >>   _vm_unmap_aliases mm/vmalloc.c:1730 [inline]
> >>   _vm_unmap_aliases+0x396/0x480 mm/vmalloc.c:1695
> >>   vm_unmap_aliases+0x19/0x20 mm/vmalloc.c:1753
> >>   change_page_attr_set_clr+0x22e/0x840 arch/x86/mm/pageattr.c:1709
> >>   change_page_attr_clear arch/x86/mm/pageattr.c:1766 [inline]
> >>   set_memory_ro+0x7b/0xa0 arch/x86/mm/pageattr.c:1899
> >>   bpf_jit_binary_lock_ro include/linux/filter.h:790 [inline]
> >>   bpf_int_jit_compile+0xebd/0x12ce arch/x86/net/bpf_jit_comp.c:1659
> >>   bpf_prog_select_runtime+0x4b9/0x850 kernel/bpf/core.c:1801
> >>   bpf_migrate_filter net/core/filter.c:1275 [inline]
> >>   bpf_prepare_filter net/core/filter.c:1323 [inline]
> >>   bpf_prepare_filter+0x977/0xd60 net/core/filter.c:1289
> >>   __get_filter+0x212/0x2c0 net/core/filter.c:1492
> >>   sk_attach_filter+0x1e/0xa0 net/core/filter.c:1507
> >>   sock_setsockopt+0x1f44/0x22b0 net/core/sock.c:999
> >>   __sys_setsockopt+0x440/0x4c0 net/socket.c:2113
> >>   __do_sys_setsockopt net/socket.c:2133 [inline]
> >>   __se_sys_setsockopt net/socket.c:2130 [inline]
> >>   __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2130
> >>   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> >>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >> RIP: 0033:0x45a919
> >> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> >> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> >> ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> >> RSP: 002b:00007f19610d5c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> >> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 000000000045a919
> >> RDX: 000000000000001a RSI: 0000000000000001 RDI: 000000000000000c
> >> RBP: 000000000075c070 R08: 0000000000000010 R09: 0000000000000000
> >> R10: 0000000020000480 R11: 0000000000000246 R12: 00007f19610d66d4
> >> R13: 00000000004c9e34 R14: 00000000004e1f78 R15: 00000000ffffffff
> >> Sending NMI from CPU 0 to CPUs 1:
> >> NMI backtrace for cpu 1
> >> CPU: 1 PID: 3231 Comm: kworker/1:3 Not tainted 5.5.0-rc2-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> Google 01/01/2011
> >> Workqueue: rcu_gp process_srcu
> >> RIP: 0010:delay_tsc+0x33/0xc0 arch/x86/lib/delay.c:68
> >> Code: bf 01 00 00 00 41 55 41 54 53 e8 58 95 8b f9 e8 63 b4 cd fb 41 89 c5
> >> 0f 01 f9 66 90 48 c1 e2 20 48 09 c2 49 89 d4 eb 16 f3 90 <bf> 01 00 00 00
> >> e8 33 95 8b f9 e8 3e b4 cd fb 44 39 e8 75 36 0f 01
> >> RSP: 0018:ffffc9000898fbb0 EFLAGS: 00000286
> >> RAX: 0000000080000000 RBX: 000000c937e7f04b RCX: 0000000000000000
> >> RDX: 0000000000000001 RSI: ffffffff8392f013 RDI: 0000000000000001
> >> RBP: ffffc9000898fbd0 R08: ffff88809e1e2200 R09: 0000000000000040
> >> R10: 0000000000000040 R11: ffffffff89a4f487 R12: 000000c937e7c4ab
> >> R13: 0000000000000001 R14: 0000000000002ced R15: 0000000000000047
> >> FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007fbb9d9c6000 CR3: 0000000094911000 CR4: 00000000001426e0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>   __delay arch/x86/lib/delay.c:161 [inline]
> >>   __const_udelay+0x59/0x80 arch/x86/lib/delay.c:175
> >>   try_check_zero+0x201/0x330 kernel/rcu/srcutree.c:705
> >>   srcu_advance_state kernel/rcu/srcutree.c:1142 [inline]
> >>   process_srcu+0x329/0xe10 kernel/rcu/srcutree.c:1237
> >>   process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
> >>   worker_thread+0x98/0xe40 kernel/workqueue.c:2410
> >>   kthread+0x361/0x430 kernel/kthread.c:255
> >>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >>
> >>
> >> ---
> >> This bug is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this bug report. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000021cc1a0599f66f55%40google.com.
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/87o8w5u47c.fsf%40dja-thinkpad.axtens.net.
