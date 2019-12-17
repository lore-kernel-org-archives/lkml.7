Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56CCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5B206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="hlRb01/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfLQNjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:39:01 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43787 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfLQNjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:39:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id g4so4599919pjs.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=meP6rIIMJsH6PBu0gAeUFjowyokD9WOSsMLtW0gmaNk=;
        b=hlRb01/oUfTMj+Y2cP46SWGqge8MBkPO6rf5sot4PWXne3mECfQVgWAuZKp8x9+Bnf
         4Sj9Pc+ki+jFD91LX1arr310kd7Q8AyH/oUWFiqQoXx+ba8la4YAe4qMn13RV1jh54n/
         vSj/facjFW+Wd8n29LwRmLa7VvXPIpJGdwobk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=meP6rIIMJsH6PBu0gAeUFjowyokD9WOSsMLtW0gmaNk=;
        b=EMWCbcmw0oPF1MWGaF73QB08ztD/9k8rDPkHSFty8ymdPSkhDrPArxQzJ6EIPI/Zuy
         bB+IYp2Z4ujfMc9chzgEmMn+3Makb+QGxSNJH6oduMZ49tCZgq7quRp75gFRNwKfofna
         HY4tCW1ATjlkr5UhFg19ICgce7rxMWCRJ0/Vm3RStznFCtTAs2v0uJQGOStyICHAVny8
         kKLSkLZP5ayrg9gRBEEaFCLI8EBgfDDX5uiMK+FrdoRpsbDzhxcfGNCoGKBrRQBZ9obO
         hc7zXYAyzBWGqL3LdstpOPuc0i66TwrBJIsYgqrx1hnF1uBKfb4ivie024/ErQx4Q/sJ
         Z7Cg==
X-Gm-Message-State: APjAAAVaA8dVkDvTlC87a9AumElbXZUmPS53FaHY3tSW/jBkAWqk1tzG
        B3Ya/XtMWIdsLONui4sGUssolA==
X-Google-Smtp-Source: APXvYqwlAbB7ZHikktNXvb8WaQRcCfjVNRyNttV6mS+WAsDL4oSKKGDn7Pjg7zMsp3Kzh8MK6Teocg==
X-Received: by 2002:a17:902:a503:: with SMTP id s3mr21643577plq.274.1576589940145;
        Tue, 17 Dec 2019 05:39:00 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-e4cb-43b3-6b6e-ca31.static.ipv6.internode.on.net. [2001:44b8:1113:6700:e4cb:43b3:6b6e:ca31])
        by smtp.gmail.com with ESMTPSA id q6sm27276649pfl.140.2019.12.17.05.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:38:59 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>, christian@kellner.me,
        cyphar@cyphar.com, "Reshetova\, Elena" <elena.reshetova@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>, ldv@altlinux.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Drewry <wad@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: INFO: rcu detected stall in sys_kill
In-Reply-To: <87a787ekd0.fsf@dja-thinkpad.axtens.net>
References: <00000000000036decf0598c8762e@google.com> <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com> <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com> <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com> <87a787ekd0.fsf@dja-thinkpad.axtens.net>
Date:   Wed, 18 Dec 2019 00:38:55 +1100
Message-ID: <87h81zax74.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:

> Hi Casey,
>
>> There haven't been Smack changes recently, so this is
>> going to have been introduced elsewhere. I'm perfectly
>> willing to accept that Smack is doing something horribly
>> wrong WRT rcu, and that it needs repair, but its going to
>> be tough for me to track down. I hope someone else is looking
>> into this, as my chances of finding the problem are pretty
>> slim.
>
> Yeah, I'm having a look, it's probably related to my kasan-vmalloc
> stuff. It's currently in a bit of flux as syzkaller finds a bunch of
> other bugs with it, once that stablises a bit I'll come back to Smack.

I have had a brief and wildly unsuccessful look at this. I'm happy to
come back to it and go over it with a finer toothed comb, but it will
almost certainly have to wait until next year.

I don't think it's related to RCU, we also have a plain lockup:
https://syzkaller.appspot.com/bug?id=be03729d17bb3b2df1754a7486a8f8628f6ff1ec

Dmitry, I've been really struggling to repro this locally, even with
your config. Is there an easy way to see the kernel command line you
booted with and anything else that makes this image special? I have zero
experience with smack so this is a steep learning curve.

Regards,
Daniel

>
> Regards,
> Daniel
>
>>
>>>>
>>>> I see 2 common this across all stalls:
>>>> 1. They all happen on the instance that uses smack (which is now
>>>> effectively dead), see smack instance here:
>>>> https://syzkaller.appspot.com/upstream
>>>> 2. They all contain this frame in the stack trace:
>>>> free_thread_stack+0x168/0x590 kernel/fork.c:280
>>>> The last commit that touches this file is "fork: support VMAP_STACK
>>>> with KASAN_VMALLOC".
>>>> That may be very likely the root cause. +Daniel
>>> I've stopped smack syzbot instance b/c it produces infinite stream of
>>> assorted crashes due to this.
>>> Please ping syzkaller@googlegroups.com when this is fixed, I will
>>> re-enable the instance.
>>>
>>>>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>>>         (detected by 1, t=10502 jiffies, g=6629, q=331)
>>>>> rcu: All QSes seen, last rcu_preempt kthread activity 10503
>>>>> (4294953794-4294943291), jiffies_till_next_fqs=1, root ->qsmask 0x0
>>>>> syz-executor.0  R  running task    24648  8293   8292 0x0000400a
>>>>> Call Trace:
>>>>>   <IRQ>
>>>>>   sched_show_task+0x40f/0x560 kernel/sched/core.c:5954
>>>>>   print_other_cpu_stall kernel/rcu/tree_stall.h:410 [inline]
>>>>>   check_cpu_stall kernel/rcu/tree_stall.h:538 [inline]
>>>>>   rcu_pending kernel/rcu/tree.c:2827 [inline]
>>>>>   rcu_sched_clock_irq+0x1861/0x1ad0 kernel/rcu/tree.c:2271
>>>>>   update_process_times+0x12d/0x180 kernel/time/timer.c:1726
>>>>>   tick_sched_handle kernel/time/tick-sched.c:167 [inline]
>>>>>   tick_sched_timer+0x263/0x420 kernel/time/tick-sched.c:1310
>>>>>   __run_hrtimer kernel/time/hrtimer.c:1514 [inline]
>>>>>   __hrtimer_run_queues+0x403/0x840 kernel/time/hrtimer.c:1576
>>>>>   hrtimer_interrupt+0x38c/0xda0 kernel/time/hrtimer.c:1638
>>>>>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
>>>>>   smp_apic_timer_interrupt+0x109/0x280 arch/x86/kernel/apic/apic.c:1135
>>>>>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
>>>>>   </IRQ>
>>>>> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
>>>>> RIP: 0010:check_kcov_mode kernel/kcov.c:70 [inline]
>>>>> RIP: 0010:__sanitizer_cov_trace_pc+0x1c/0x50 kernel/kcov.c:102
>>>>> Code: cc 07 48 89 de e8 64 02 3b 00 5b 5d c3 cc 48 8b 04 24 65 48 8b 0c 25
>>>>> c0 1d 02 00 65 8b 15 b8 81 8b 7e f7 c2 00 01 1f 00 75 2c <8b> 91 80 13 00
>>>>> 00 83 fa 02 75 21 48 8b 91 88 13 00 00 48 8b 32 48
>>>>> RSP: 0018:ffffc900021c7c28 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
>>>>> RAX: ffffffff81487433 RBX: 0000000000000000 RCX: ffff88809428a100
>>>>> RDX: 0000000000000001 RSI: 00000000fffffffc RDI: ffffea0002479240
>>>>> RBP: ffffc900021c7c50 R08: dffffc0000000000 R09: fffffbfff1287025
>>>>> R10: fffffbfff1287025 R11: 0000000000000000 R12: dffffc0000000000
>>>>> R13: dffffc0000000000 R14: 00000000fffffffc R15: ffff888091c57428
>>>>>   free_thread_stack+0x168/0x590 kernel/fork.c:280
>>>>>   release_task_stack kernel/fork.c:440 [inline]
>>>>>   put_task_stack+0xa3/0x130 kernel/fork.c:451
>>>>>   finish_task_switch+0x3f1/0x550 kernel/sched/core.c:3256
>>>>>   context_switch kernel/sched/core.c:3388 [inline]
>>>>>   __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
>>>>>   preempt_schedule_common kernel/sched/core.c:4236 [inline]
>>>>>   preempt_schedule+0xdb/0x120 kernel/sched/core.c:4261
>>>>>   ___preempt_schedule+0x16/0x18 arch/x86/entry/thunk_64.S:50
>>>>>   __raw_read_unlock include/linux/rwlock_api_smp.h:227 [inline]
>>>>>   _raw_read_unlock+0x3a/0x40 kernel/locking/spinlock.c:255
>>>>>   kill_something_info kernel/signal.c:1586 [inline]
>>>>>   __do_sys_kill kernel/signal.c:3640 [inline]
>>>>>   __se_sys_kill+0x5e9/0x6c0 kernel/signal.c:3634
>>>>>   __x64_sys_kill+0x5b/0x70 kernel/signal.c:3634
>>>>>   do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
>>>>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>> RIP: 0033:0x422a17
>>>>> Code: 44 00 00 48 c7 c2 d4 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e
>>>>> 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 3e 00 00 00 0f 05 <48> 3d 01 f0 ff
>>>>> ff 0f 83 dd 32 ff ff c3 66 2e 0f 1f 84 00 00 00 00
>>>>> RSP: 002b:00007fff38dca538 EFLAGS: 00000293 ORIG_RAX: 000000000000003e
>>>>> RAX: ffffffffffffffda RBX: 0000000000000064 RCX: 0000000000422a17
>>>>> RDX: 0000000000000bb8 RSI: 0000000000000009 RDI: 00000000fffffffe
>>>>> RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000001c62940
>>>>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000008
>>>>> R13: 00007fff38dca570 R14: 000000000000f0b6 R15: 00007fff38dca580
>>>>> rcu: rcu_preempt kthread starved for 10533 jiffies! g6629 f0x2
>>>>> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>>>>> rcu: RCU grace-period kthread stack dump:
>>>>> rcu_preempt     R  running task    29032    10      2 0x80004008
>>>>> Call Trace:
>>>>>   context_switch kernel/sched/core.c:3388 [inline]
>>>>>   __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
>>>>>   schedule+0x181/0x210 kernel/sched/core.c:4155
>>>>>   schedule_timeout+0x14f/0x240 kernel/time/timer.c:1895
>>>>>   rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
>>>>>   rcu_gp_kthread+0xed8/0x1770 kernel/rcu/tree.c:1821
>>>>>   kthread+0x332/0x350 kernel/kthread.c:255
>>>>>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>>>>>
>>>>>
>>>>> ---
>>>>> This bug is generated by a bot. It may contain errors.
>>>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>>>
>>>>> syzbot will keep track of this bug report. See:
>>>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>>>
>>>>> --
>>>>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>>>>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>>>>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000036decf0598c8762e%40google.com.
