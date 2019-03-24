Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D3AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACD1222D9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyIwnEgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfCXNHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 09:07:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54062 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfCXNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 09:07:27 -0400
Received: by mail-it1-f195.google.com with SMTP id w85so3112480itc.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZZ/sjeQy1Qzo5135I0TS+qKGwN2fjLNrrQRGFIigVA=;
        b=DyIwnEgRi52Qoh6N68IJFxvThLhA/7pacR5SBuEYoNV/WwAmjySyJap0hV1hQIFaFr
         +q2tAhr+rS9JSnEy24ITbe6Z87GzYx3lK7xAU9Izf6orIKLWHbmNxzRrLibodW5OthpX
         WZwLF6122WTTDqPi4LDDZCIwzvyQy/xQ6iRfaCidbGdxRYi/SU7IzuQsSD7JaoOSYbT5
         SNvyvjDQPipYNGVYdGi7Htnptwy2AbrhH0LkZ7ETRiy3AGWysKfX3gRU6NR8NJQ176Ek
         Zl8jIz1Gva5CJP7z8lA6u9iwy2E+bNwGhiewNyivnOOi1ffL+xV8rk85KwvP1hFcmyL3
         TfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZZ/sjeQy1Qzo5135I0TS+qKGwN2fjLNrrQRGFIigVA=;
        b=JZoaMkDQl1xWS6nFwf+3GRHvx53Mqj/PlVzL+/72fa3xnD2qLiF5h2j2bIdqJBGweI
         pDmtgUvtWP1g6m3etVxfTi/laO9C3aBQcs9/+rMN/GV58bfVBXutS9GjL5pQpBBVDJoM
         vaM8aKywpoofmuDMq1rZvM2ZK92JVi5JJJEKOF5lOflyFeapdnScOU7qpcN91LVpetuj
         RciDAHCSfi/qiJJ4FrpCO/+SG+SG/pY+HtgaeNFi6cv4LmhiDA9DVzH8TING6FbWOUGB
         ltm4re8vWhidg76/9rz/9hBiPl/u1iKrBQptWbYEiULeF8dB7CmAiX5z4q4+vXylOc2q
         cjqA==
X-Gm-Message-State: APjAAAVkEe/rmnvIS/EtRoTehxFiNXEasDyDNThlEa2U1ozuWrZI1qyR
        4iVbIIazImCzbSUD0lxz/EnZLDQvut3JuD6nSxgJTw==
X-Google-Smtp-Source: APXvYqxWVpUVNuNaZRvgM1W2RUjW3BGapO4iY3N8vtaJEfiNhpEsiatZCQVlTNh1QfhfmdWvkohEnoqMgw/zoRM36EQ=
X-Received: by 2002:a05:6638:211:: with SMTP id e17mr13905399jaq.35.1553432846360;
 Sun, 24 Mar 2019 06:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000639f6a0584d11b82@google.com> <20190324090719.GA23289@zn.tnic>
In-Reply-To: <20190324090719.GA23289@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 24 Mar 2019 14:07:14 +0100
Message-ID: <CACT4Y+bRopxWvo1ssYD7V++KG1tmVXyab0iKkcSXZFMuK63rvA@mail.gmail.com>
Subject: Re: WARNING in arch_install_hw_breakpoint
To:     Borislav Petkov <bp@alien8.de>
Cc:     syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:07 AM Borislav Petkov <bp@alien8.de> wrote:
>
> syzbot folks,
>
> please fix your bot - I got 164(!) copies of this mail. No, wait, 165.
>
> This is really annoying.

Oops. Sorry. This should be fixed by
https://github.com/google/syzkaller/commit/8e1b6f644671a0401ceadcaf0b611ab248b88355
now.

> On Sat, Mar 23, 2019 at 11:22:06PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    fd1f297b Merge tag 'drm-fixes-2019-03-22' of git://anongit..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1574f56d200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
> > dashboard link: https://syzkaller.appspot.com/bug?extid=370a6b0f11867bf13515
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1157b7cf200000
> >
> > Bisection is inconclusive: the bug happens on the oldest tested release.
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ca39b3200000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=12ca39b3200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14ca39b3200000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > Can't find any breakpoint slot
> > WARNING: CPU: 0 PID: 8058 at arch/x86/kernel/hw_breakpoint.c:121
> > arch_install_hw_breakpoint+0x2d6/0x3a0 arch/x86/kernel/hw_breakpoint.c:121
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: 8058 Comm: syz-executor.1 Not tainted 5.1.0-rc1+ #33
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> >  panic+0x2cb/0x65c kernel/panic.c:214
> >  __warn.cold+0x20/0x45 kernel/panic.c:571
> >  report_bug+0x263/0x2b0 lib/bug.c:186
> >  fixup_bug arch/x86/kernel/traps.c:179 [inline]
> >  fixup_bug arch/x86/kernel/traps.c:174 [inline]
> >  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
> >  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
> >  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
> > RIP: 0010:arch_install_hw_breakpoint+0x2d6/0x3a0
> > arch/x86/kernel/hw_breakpoint.c:121
> > Code: c8 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 0f 0b 48 c7 c7
> > 40 23 65 87 89 45 d4 c6 05 ed 9d 32 08 01 e8 98 43 1b 00 <0f> 0b 8b 45 d4 e9
> > bc fd ff ff 40 88 75 c8 e8 a7 8e 80 00 0f b6 75
> > RSP: 0018:ffff8880a512f6d8 EFLAGS: 00010086
> > RAX: 0000000000000000 RBX: ffff8880ae81ec98 RCX: 0000000000000000
> > RDX: 0000000040000000 RSI: ffffffff815ae266 RDI: ffffed1014a25ecd
> > RBP: ffff8880a512f718 R08: ffff8880857382c0 R09: fffffbfff11335f5
> > R10: fffffbfff11335f4 R11: ffffffff8899afa3 R12: ffff888085730380
> > R13: dffffc0000000000 R14: 0000000000000004 R15: 000000000001eca0
> >  hw_breakpoint_add+0xa7/0x130 kernel/events/hw_breakpoint.c:632
> >  event_sched_in kernel/events/core.c:2281 [inline]
> >  event_sched_in.isra.0+0x373/0xbf0 kernel/events/core.c:2245
> >  group_sched_in+0xe4/0x3d0 kernel/events/core.c:2317
> >  flexible_sched_in+0x615/0x9c0 kernel/events/core.c:3311
> >  visit_groups_merge+0x336/0x5d0 kernel/events/core.c:3259
> >  ctx_flexible_sched_in kernel/events/core.c:3345 [inline]
> >  ctx_sched_in+0x330/0x670 kernel/events/core.c:3390
> >  perf_event_sched_in+0x6e/0xa0 kernel/events/core.c:2426
> >  perf_event_context_sched_in kernel/events/core.c:3430 [inline]
> >  __perf_event_task_sched_in+0x609/0x820 kernel/events/core.c:3469
> >  perf_event_task_sched_in include/linux/perf_event.h:1115 [inline]
> >  finish_task_switch+0x2c2/0x780 kernel/sched/core.c:2725
> >  context_switch kernel/sched/core.c:2880 [inline]
> >  __schedule+0x81f/0x1cc0 kernel/sched/core.c:3518
> >  schedule+0x92/0x180 kernel/sched/core.c:3562
> >  freezable_schedule include/linux/freezer.h:172 [inline]
> >  ptrace_stop+0x3fe/0x950 kernel/signal.c:2111
> >  do_jobctl_trap kernel/signal.c:2330 [inline]
> >  get_signal+0x1502/0x1d50 kernel/signal.c:2456
> >  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
> >  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
> >  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
> >  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
> >  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x458209
> > Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> > 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f6b1a2a8c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000129
> > RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000458209
> > RDX: 0000000000000016 RSI: 000000000000002a RDI: 000000000000002a
> > RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000020000100 R11: 0000000000000246 R12: 00007f6b1a2a96d4
> > R13: 00000000004c4f84 R14: 00000000004d8bd8 R15: 00000000ffffffff
> >
> > ======================================================
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190324090719.GA23289%40zn.tnic.
> For more options, visit https://groups.google.com/d/optout.
