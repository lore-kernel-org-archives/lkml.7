Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFD0C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCC820705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ca4CajVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgAHWHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:07:50 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55714 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgAHWHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:07:50 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so206334pjz.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 14:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=3XosqsKJ9s5hNBu+kmyaaZT6uyg85Zvy6hJcIyut/ns=;
        b=ca4CajVRL0DmOTDvfx8ABIxAqjkV/WavI5kYV0kX3CRwXxSq/Uy4TlyEdRHbOZYET6
         HudGY5xM09i6dbxKTDkVjW7wQ9YFRXHpQyZ7sWL5nNa55WuVOFyMGTQcC+Jqqgt8PCq5
         HHbm40D6/DZb6usRv3+fUGVhnOEZtTZWJPk2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3XosqsKJ9s5hNBu+kmyaaZT6uyg85Zvy6hJcIyut/ns=;
        b=q1ymmxPn6CxhFnLFPXVhf8Q1NViQ4dw+v6x6mh0fAf32sF1fd4DEvcDcTUvmNTFZan
         Awmxa+vN2FfJBGpf7/AUTHZIBG3GN1s8Cjnkeqs1OjX7uFeRAjmUNa6cCHHMSs0VEUtk
         LO2sO3ttqKI9TixaPM3/VXRYujRVOcr5JlcDLPvd2mOLvFhr2bz74JNNFlfB2jevu49w
         1T7rFbRmHuKFh1yMwj2Ze+AbYZ5KEChDkGnf4hCi2kDoXKYs6gAtx3C/C7Gkm/H+FQms
         SnCn41RzdnLehdeyQ09ZQd2VBvCYk+0kiVNfWVyQ6v9nVciuKAQfl6qp2BvU+YJfy/1t
         ZSiA==
X-Gm-Message-State: APjAAAWndCZncwW1yG7+ZenVvWnjEZDbCD6xRr24HPttWJcXPULuq26H
        tHIZn76m/BR/rXULaHmS5enUtw==
X-Google-Smtp-Source: APXvYqySa+AJC0eXvrbtGA7dmAzI1Pf7feCBYlwrsafcC4C5JVjG42ogYjTf4YAANDt0AugNlDBFag==
X-Received: by 2002:a17:90a:3763:: with SMTP id u90mr991789pjb.107.1578521269301;
        Wed, 08 Jan 2020 14:07:49 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-5cb3-ebc3-7dc6-a17b.static.ipv6.internode.on.net. [2001:44b8:1113:6700:5cb3:ebc3:7dc6:a17b])
        by smtp.gmail.com with ESMTPSA id x21sm4660362pfn.164.2020.01.08.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 14:07:48 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+c3ed57cd8f699826dd95@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Drewry <wad@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: INFO: rcu detected stall in sys_poll (2)
In-Reply-To: <CACT4Y+ao_X9z7xVYqfrizB12hNGZj8a-CQPJnRyArMF9k2o8QQ@mail.gmail.com>
References: <000000000000322ad2059b9aa992@google.com> <CACT4Y+ao_X9z7xVYqfrizB12hNGZj8a-CQPJnRyArMF9k2o8QQ@mail.gmail.com>
Date:   Thu, 09 Jan 2020 09:07:44 +1100
Message-ID: <87eew9ob4f.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Wed, Jan 8, 2020 at 7:04 AM syzbot
> <syzbot+c3ed57cd8f699826dd95@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    ae608821 Merge tag 'trace-v5.5-rc5' of git://git.kernel.or..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=157edeb9e00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=db5ff86cbb23b415
>> dashboard link: https://syzkaller.appspot.com/bug?extid=c3ed57cd8f699826dd95
>> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
>> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+c3ed57cd8f699826dd95@syzkaller.appspotmail.com
>
> This is:
>
> #syz dup: INFO: rcu detected stall in sys_kill
>
> For details see:
> https://groups.google.com/g/syzkaller-bugs/c/Vv3ARjLvagc/m/nZAubeo9AQAJ
> https://syzkaller.appspot.com/bug?extid=de8d933e7d153aa0c1bb
>
> I temporarily re-enabled smack instance and it produces another 50
> stalls all over the kernel. So smack + KASAN + VMAP stack combination
> is sitll problematic.
>
I'm just back this week, so I'll try and have another look in the next
couple of days, but I've been really struggling to get anywhere.

Regards,
Daniel

>
>> rcu: INFO: rcu_preempt self-detected stall on CPU
>> rcu:    0-...!: (1 GPs behind) idle=5da/1/0x4000000000000002
>> softirq=13907/13908 fqs=38
>>         (t=10501 jiffies g=6889 q=136)
>> rcu: rcu_preempt kthread starved for 10426 jiffies! g6889 f0x0
>> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
>> rcu: RCU grace-period kthread stack dump:
>> rcu_preempt     R  running task    29032    10      2 0x80004000
>> Call Trace:
>>   context_switch kernel/sched/core.c:3385 [inline]
>>   __schedule+0x9a0/0xcc0 kernel/sched/core.c:4081
>>   schedule+0x181/0x210 kernel/sched/core.c:4155
>>   schedule_timeout+0x14f/0x240 kernel/time/timer.c:1895
>>   rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
>>   rcu_gp_kthread+0xed8/0x1770 kernel/rcu/tree.c:1821
>>   kthread+0x332/0x350 kernel/kthread.c:255
>>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>> NMI backtrace for cpu 0
>> CPU: 0 PID: 8477 Comm: udevd Not tainted 5.5.0-rc5-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>   <IRQ>
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x1fb/0x318 lib/dump_stack.c:118
>>   nmi_cpu_backtrace+0xaf/0x1a0 lib/nmi_backtrace.c:101
>>   nmi_trigger_cpumask_backtrace+0x174/0x290 lib/nmi_backtrace.c:62
>>   arch_trigger_cpumask_backtrace+0x10/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>>   trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
>>   rcu_dump_cpu_stacks+0x15a/0x220 kernel/rcu/tree_stall.h:254
>>   print_cpu_stall kernel/rcu/tree_stall.h:455 [inline]
>>   check_cpu_stall kernel/rcu/tree_stall.h:529 [inline]
>>   rcu_pending kernel/rcu/tree.c:2827 [inline]
>>   rcu_sched_clock_irq+0xe25/0x1ad0 kernel/rcu/tree.c:2271
>>   update_process_times+0x12d/0x180 kernel/time/timer.c:1726
>>   tick_sched_handle kernel/time/tick-sched.c:167 [inline]
>>   tick_sched_timer+0x263/0x420 kernel/time/tick-sched.c:1310
>>   __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
>>   __hrtimer_run_queues+0x403/0x840 kernel/time/hrtimer.c:1579
>>   hrtimer_interrupt+0x38c/0xda0 kernel/time/hrtimer.c:1641
>>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
>>   smp_apic_timer_interrupt+0x109/0x280 arch/x86/kernel/apic/apic.c:1135
>>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
>>   </IRQ>
>> RIP: 0010:free_thread_stack+0x151/0x590 kernel/fork.c:280
>> Code: 31 f6 e8 02 8d 6f 00 43 80 3c 2e 00 74 08 4c 89 e7 e8 73 94 6a 00 49
>> 8b 1c 24 48 83 c3 08 48 89 d8 48 c1 e8 03 42 80 3c 28 00 <74> 08 48 89 df
>> e8 55 94 6a 00 48 8b 3b be fc ff ff ff e8 28 04 00
>> RSP: 0018:ffffc90001e57760 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
>> RAX: 1ffff11013e8ed61 RBX: ffff88809f476b08 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea0002a59a40
>> RBP: ffffc90001e57798 R08: 000000000003a728 R09: ffffed10125b3711
>> R10: ffffed10125b3711 R11: 0000000000000000 R12: ffff88809f476a20
>> R13: dffffc0000000000 R14: 1ffff11013e8ed44 R15: ffff888092d9b878
>>   release_task_stack kernel/fork.c:440 [inline]
>>   put_task_stack+0xa3/0x130 kernel/fork.c:451
>>   finish_task_switch+0x3f1/0x550 kernel/sched/core.c:3256
>>   context_switch kernel/sched/core.c:3388 [inline]
>>   __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
>>   schedule+0x181/0x210 kernel/sched/core.c:4155
>>   schedule_hrtimeout_range_clock+0x3c7/0x510 kernel/time/hrtimer.c:2130
>>   schedule_hrtimeout_range+0x2a/0x40 kernel/time/hrtimer.c:2175
>>   poll_schedule_timeout+0x11c/0x1c0 fs/select.c:243
>>   do_poll fs/select.c:951 [inline]
>>   do_sys_poll+0x83f/0x1250 fs/select.c:1001
>>   __do_sys_poll fs/select.c:1059 [inline]
>>   __se_sys_poll+0x1b0/0x360 fs/select.c:1047
>>   __x64_sys_poll+0x7b/0x90 fs/select.c:1047
>>   do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x7fe82049b678
>> Code: 11 48 83 c8 ff eb ea 90 90 90 90 90 90 90 90 90 90 90 48 83 ec 28 8b
>> 05 82 8f 2b 00 85 c0 75 17 48 63 d2 b8 07 00 00 00 0f 05 <48> 3d 00 f0 ff
>> ff 77 51 48 83 c4 28 c3 89 54 24 08 48 89 74 24 10
>> RSP: 002b:00007fffd9dcc090 EFLAGS: 00000246 ORIG_RAX: 0000000000000007
>> RAX: ffffffffffffffda RBX: 20c49ba5e353f7cf RCX: 00007fe82049b678
>> RDX: 000000000000ee2a RSI: 0000000000000001 RDI: 00007fffd9dcc150
>> RBP: 0000000000000000 R08: 00007fffd9dcc0a0 R09: 00007fffd9de50b8
>> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000150dc00
>> R13: 000000000000214d R14: 00007fffd9dcc124 R15: 0000000001509250
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000322ad2059b9aa992%40google.com.
