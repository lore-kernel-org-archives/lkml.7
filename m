Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36141C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38042053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRN+1znG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfLCIen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:34:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35880 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfLCIen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:34:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id v19so2653971qkv.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 00:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WE8c4qrvYO1bS4Cz4rfqeIP68iNlGE5erawwEVWjZZA=;
        b=KRN+1znG/HVo6LwSaucLwcBd4gEMtTbMC3S0gfN9TfVu2ISBdKBYAuZ+txXSBpIm3Q
         Qbv2zqdz3k8IBbLMrudE/lmoT0jT3BFq4F9onHntGlmFVtFP1qen4w9tqEppl3o9D5fo
         U5fbDHnNNbwnImF2iofBJ/IxdedrkLwB3E1pkLUxST2ON42z1Hr5O7vDwx0qOeV7IrYx
         QZi3oYII8HPaDBSeBQsEd9957ihEiw2KIzUpMSumY+o0zr01tvJWsiCPdVhIcT2+Sa//
         cUOAxN4e5uKWpW4/Y9MUjkgLkypNxwOpplhNCVNqNsauSAm2nZKOyO7Mx4/Qnlwnl+q4
         /OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WE8c4qrvYO1bS4Cz4rfqeIP68iNlGE5erawwEVWjZZA=;
        b=IqSt8Fq/+hqkuJYep0rkqLTxjaiMzg1nnxCgUA8fR0AX+2xNyUzpILKIaiZvm1Ks/O
         uag1aPAfVWXOw82rQc4Ylt6xdEqrMrfDGsjJlBq0ZuLeELZ/ERNdKFit+h6U8CMpMWfO
         bRDSSDQUUeuR74ktWbvTmWUDWvQFya6sxP5n+fTb+HEW/Wl1Magd5E9u9Qo6Z2UEik6R
         J1tzEaCOc65ahQ4eu83IHeR1GF0aKSBkYS34OWRw7JIXjyirHJjYV7cNwYRiiH8OMMWX
         UPGkYmo+mnznv1ksvSVH6lAdS1a3Poq6VT7JPnNmQbG8ZGX83wq8iKe1weFCxtFTPEdM
         kSzg==
X-Gm-Message-State: APjAAAXieu4D41F+XxHPaYExZZfPt+OerkZXrCpkDJ1dpNWcSiVv7uLC
        bvaODLLfxUdmKa5olbVyHYGBFObcZqyPR+KqpqajDw==
X-Google-Smtp-Source: APXvYqzZRtXFokiAFfn88fYPcjz/xe4t4r9eNR7i2sihaXS50yzqUZLX+JKguOJhfB/mjK6GsXJrXieoz3aIDez+o80=
X-Received: by 2002:a37:bdc3:: with SMTP id n186mr3583700qkf.407.1575362081539;
 Tue, 03 Dec 2019 00:34:41 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d2a8cc0598c8798f@google.com>
In-Reply-To: <000000000000d2a8cc0598c8798f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 3 Dec 2019 09:34:30 +0100
Message-ID: <CACT4Y+YVVK6sO6nE9wwYSgCjaZKR-h2HSJ120CFBimjjxZVJgQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in pipe_read
To:     syzbot <syzbot+7047406d4ba783c8eb7b@syzkaller.appspotmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>, christian@kellner.me,
        cyphar@cyphar.com, "Reshetova, Elena" <elena.reshetova@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>, ldv@altlinux.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 9:28 AM syzbot
<syzbot+7047406d4ba783c8eb7b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    596cf45c Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b1af36e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9bbcda576154a4b4
> dashboard link: https://syzkaller.appspot.com/bug?extid=7047406d4ba783c8eb7b
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7047406d4ba783c8eb7b@syzkaller.appspotmail.com

Something seriously broke in smack+kasan+vmap stacks, we now have 60
rcu stalls all over the place and counting. This is one of the
samples. Let's dup all of them to a single one and continue the
discussion there:

#syz dup: INFO: rcu detected stall in sys_kill

> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>         (detected by 0, t=10502 jiffies, g=5977, q=61)
> rcu: All QSes seen, last rcu_preempt kthread activity 10503
> (4294953644-4294943141), jiffies_till_next_fqs=1, root ->qsmask 0x0
> syz-executor.0  R  running task    24296  8125   8124 0x0000400a
> Call Trace:
>   <IRQ>
>   sched_show_task+0x40f/0x560 kernel/sched/core.c:5954
>   print_other_cpu_stall kernel/rcu/tree_stall.h:410 [inline]
>   check_cpu_stall kernel/rcu/tree_stall.h:538 [inline]
>   rcu_pending kernel/rcu/tree.c:2827 [inline]
>   rcu_sched_clock_irq+0x1861/0x1ad0 kernel/rcu/tree.c:2271
>   update_process_times+0x12d/0x180 kernel/time/timer.c:1726
>   tick_sched_handle kernel/time/tick-sched.c:167 [inline]
>   tick_sched_timer+0x263/0x420 kernel/time/tick-sched.c:1310
>   __run_hrtimer kernel/time/hrtimer.c:1514 [inline]
>   __hrtimer_run_queues+0x403/0x840 kernel/time/hrtimer.c:1576
>   hrtimer_interrupt+0x38c/0xda0 kernel/time/hrtimer.c:1638
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
>   smp_apic_timer_interrupt+0x109/0x280 arch/x86/kernel/apic/apic.c:1135
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
>   </IRQ>
> RIP: 0010:mod_memcg_page_state+0x2b/0x190 include/linux/memcontrol.h:653
> Code: 48 89 e5 41 57 41 56 41 54 53 41 89 f6 48 89 fb e8 da 28 2e 00 48 83
> c3 38 48 89 d8 48 c1 e8 03 49 bc 00 00 00 00 00 fc ff df <42> 80 3c 20 00
> 74 08 48 89 df e8 b6 9f 69 00 48 8b 1b 48 85 db 0f
> RSP: 0018:ffffc90001f27998 EFLAGS: 00000a02 ORIG_RAX: ffffffffffffff13
> RAX: 1ffffd40005452bf RBX: ffffea0002a295f8 RCX: ffff88808f094580
> RDX: 0000000000000000 RSI: 00000000fffffffc RDI: ffffea0002a295c0
> RBP: ffffc90001f279b8 R08: dffffc0000000000 R09: fffffbfff1287025
> R10: fffffbfff1287025 R11: 0000000000000000 R12: dffffc0000000000
> R13: dffffc0000000000 R14: 00000000fffffffc R15: ffff8880a8a6f4a8
>   free_thread_stack+0x168/0x590 kernel/fork.c:280
>   release_task_stack kernel/fork.c:440 [inline]
>   put_task_stack+0xa3/0x130 kernel/fork.c:451
>   finish_task_switch+0x3f1/0x550 kernel/sched/core.c:3256
>   context_switch kernel/sched/core.c:3388 [inline]
>   __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
>   preempt_schedule_common kernel/sched/core.c:4236 [inline]
>   preempt_schedule+0xdb/0x120 kernel/sched/core.c:4261
>   ___preempt_schedule+0x16/0x18 arch/x86/entry/thunk_64.S:50
>   __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
>   _raw_spin_unlock_irqrestore+0xcc/0xe0 kernel/locking/spinlock.c:191
>   spin_unlock_irqrestore include/linux/spinlock.h:393 [inline]
>   __wake_up_common_lock kernel/sched/wait.c:125 [inline]
>   __wake_up+0xe1/0x150 kernel/sched/wait.c:142
>   pipe_read+0x8e1/0x9e0 fs/pipe.c:374
>   call_read_iter include/linux/fs.h:1896 [inline]
>   new_sync_read fs/read_write.c:414 [inline]
>   __vfs_read+0x59e/0x730 fs/read_write.c:427
>   vfs_read+0x1dd/0x420 fs/read_write.c:461
>   ksys_read+0x117/0x220 fs/read_write.c:587
>   __do_sys_read fs/read_write.c:597 [inline]
>   __se_sys_read fs/read_write.c:595 [inline]
>   __x64_sys_read+0x7b/0x90 fs/read_write.c:595
>   do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x414190
> Code: 01 f0 ff ff 0f 83 90 1b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> 44 00 00 83 3d dd 42 66 00 00 75 14 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 64 1b 00 00 c3 48 83 ec 08 e8 6a fc ff ff
> RSP: 002b:00007fff84902588 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000414190
> RDX: 0000000000000038 RSI: 0000000000758040 RDI: 00000000000000f9
> RBP: 0000000000000002 R08: 00000000000003b8 R09: 0000000000004000
> R10: 0000000000717660 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff849025c0 R14: 000000000000e9c4 R15: 00007fff849025d0
> rcu: rcu_preempt kthread starved for 10534 jiffies! g5977 f0x2
> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> rcu: RCU grace-period kthread stack dump:
> rcu_preempt     R  running task    29104    10      2 0x80004000
> Call Trace:
>   context_switch kernel/sched/core.c:3385 [inline]
>   __schedule+0x9a0/0xcc0 kernel/sched/core.c:4081
>   schedule+0x181/0x210 kernel/sched/core.c:4155
>   schedule_timeout+0x14f/0x240 kernel/time/timer.c:1895
>   rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
>   rcu_gp_kthread+0xed8/0x1770 kernel/rcu/tree.c:1821
>   kthread+0x332/0x350 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d2a8cc0598c8798f%40google.com.
