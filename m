Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8856DC32792
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4516820862
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRgvQOPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJEE3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 00:29:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39229 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJEE3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 00:29:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id n7so11563649qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 21:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6rLntvHPNDREE+PhYe+AYIJSbvllGPf0SwOZII9Niw=;
        b=FRgvQOPw4zZYUD4lqEawwSnIGRxOxyUVCbsKwBUrc1Kz2sgGweBI+GLNb+BBKUZIfm
         4DcV+0vW34plCLDFjoJqKZHmI9GcoZmJxGRddNsbwEVvwKTh3r13Pso4gkNnLb+7lAPv
         OrvDJZZIFY868X4Ah1zQi4gJb9bvGQgMBdkfv0gkXntNOaiWqhhO23R9BVVAbDSlM0Pu
         FuMAIWZO5J9UPBc6rX0pYpSZLY5SmUFhDEs3pvOTnBopa/Co/E52bUv7+U/ETVmGMr5a
         vUNHmXLHk0YUud+QpP0SduWwali5myzmDljLJDKwROBzpWV/YpuG+qTx89BUHwsvBgXL
         XvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6rLntvHPNDREE+PhYe+AYIJSbvllGPf0SwOZII9Niw=;
        b=ob6YcoChFLm3DpMA16yuS7N+DCcqcc5AW3ba+Fphn82Ol67uD6s1fvuUuPp9fbsMN9
         4V5djOoX+TWgjGsb8G+Ntqu6bmgWkvcAZnJbkbxHpoX/Ct1F4hJzya2VO3wFbVBl92bE
         xSrfihbMelzynKgJqaSMNvGMHLqH12X0/Vb7vCuQLwOHO6+1QbzIE3HgE75jFA9pDOG0
         ZI1mm6TUdMNEzWcvWuKsq84zDtzNQK04r5AvMvUH9tkQ6tydEsBuT7Cgh3iargfnbg+8
         mdZWNTZJtvCdtkmot8kpvplCmWB+g7qEkYZN1HNWYRd53yjFfpn5G35LeUW1GGS0fZ/k
         VeIw==
X-Gm-Message-State: APjAAAVZgXTW8ZoYDlZ1Ouh6GAHsoO3Kn+CVksWVk/M580v6BA226+Js
        EzLGHOKSfpbvBqxTv1TRgyYHxHT4WUlExMtNUSjSXw==
X-Google-Smtp-Source: APXvYqzFghYY5wRTzwYg3zcY3G1ZW52bU6Fmv+M3teF98nWQhPRXELdt56uiZgpaJXqG7Oh0W5OQRp2EAJ4mZHOSfyE=
X-Received: by 2002:ac8:7646:: with SMTP id i6mr20063805qtr.50.1570249790871;
 Fri, 04 Oct 2019 21:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009b403005942237bf@google.com>
In-Reply-To: <0000000000009b403005942237bf@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 5 Oct 2019 06:29:39 +0200
Message-ID: <CACT4Y+bcUggJkCFTYzT3PNgTtQb5i-uc3nHwixQp+nJORYk4RA@mail.gmail.com>
Subject: Re: KCSAN: data-race in taskstats_exit / taskstats_exit
To:     syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        Christian Brauner <christian@brauner.io>
Cc:     bsingharora@gmail.com, Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 6:26 AM syzbot
<syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    b4bd9343 x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=125329db600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> dashboard link: https://syzkaller.appspot.com/bug?extid=c5d03165a1bd1dead0c1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com

+Christian, you wanted races in process mgmt ;)


> ==================================================================
> BUG: KCSAN: data-race in taskstats_exit / taskstats_exit
>
> write to 0xffff8881157bbe10 of 8 bytes by task 7951 on cpu 0:
>   taskstats_tgid_alloc kernel/taskstats.c:567 [inline]
>   taskstats_exit+0x6b7/0x717 kernel/taskstats.c:596
>   do_exit+0x2c2/0x18e0 kernel/exit.c:864
>   do_group_exit+0xb4/0x1c0 kernel/exit.c:983
>   get_signal+0x2a2/0x1320 kernel/signal.c:2734
>   do_signal+0x3b/0xc00 arch/x86/kernel/signal.c:815
>   exit_to_usermode_loop+0x250/0x2c0 arch/x86/entry/common.c:159
>   prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
>   do_syscall_64+0x2d7/0x2f0 arch/x86/entry/common.c:299
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> read to 0xffff8881157bbe10 of 8 bytes by task 7949 on cpu 1:
>   taskstats_tgid_alloc kernel/taskstats.c:559 [inline]
>   taskstats_exit+0xb2/0x717 kernel/taskstats.c:596
>   do_exit+0x2c2/0x18e0 kernel/exit.c:864
>   do_group_exit+0xb4/0x1c0 kernel/exit.c:983
>   __do_sys_exit_group kernel/exit.c:994 [inline]
>   __se_sys_exit_group kernel/exit.c:992 [inline]
>   __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:992
>   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 7949 Comm: syz-executor.3 Not tainted 5.3.0+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> ==================================================================
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 7949 Comm: syz-executor.3 Not tainted 5.3.0+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xf5/0x159 lib/dump_stack.c:113
>   panic+0x209/0x639 kernel/panic.c:219
>   end_report kernel/kcsan/report.c:135 [inline]
>   kcsan_report.cold+0x57/0xeb kernel/kcsan/report.c:283
>   __kcsan_setup_watchpoint+0x342/0x500 kernel/kcsan/core.c:456
>   __tsan_read8 kernel/kcsan/kcsan.c:31 [inline]
>   __tsan_read8+0x2c/0x30 kernel/kcsan/kcsan.c:31
>   taskstats_tgid_alloc kernel/taskstats.c:559 [inline]
>   taskstats_exit+0xb2/0x717 kernel/taskstats.c:596
>   do_exit+0x2c2/0x18e0 kernel/exit.c:864
>   do_group_exit+0xb4/0x1c0 kernel/exit.c:983
>   __do_sys_exit_group kernel/exit.c:994 [inline]
>   __se_sys_exit_group kernel/exit.c:992 [inline]
>   __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:992
>   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x459a59
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffc4ccf3408 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 000000000000001e RCX: 0000000000459a59
> RDX: 0000000000413741 RSI: fffffffffffffff7 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 000000007f8e4506 R09: 00007ffc4ccf3460
> R10: ffffffff81007108 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc4ccf3460 R14: 0000000000000000 R15: 00007ffc4ccf3470
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009b403005942237bf%40google.com.
