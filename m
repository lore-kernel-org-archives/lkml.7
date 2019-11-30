Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E9C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 07:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555232084E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 07:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eM0XQg7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfK3H6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 02:58:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36513 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3H6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 02:58:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id y10so35096226qto.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 23:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7cazaUnsITY1FKb1YrD4ScYodUQeo/iAP9GwMqKKXQ=;
        b=eM0XQg7w2dGagXPdqNor51cT6u3IvO94CtGVORqZ9lPTabtwbAdEt0HHmvXFyqGfif
         04opuaf052tZX3TdGZysuEJza01PIAW7UHGcCxM9WLy3GRhlengWHD2GN28ViNN/478G
         EM7saYq5PFiDuiDIsu18RxFKMeTHssqTYssq57VU1O2+gq7C+Cvx27bymz4pEAzK7Yso
         oFQzGwH8+4UA82GZGju/+GViN5noZaNZ4aIDlcaUHeqWIXlquLs350u+VHNb9iy0IEyM
         ukjVPcFl0sNKI5Fd1oel7+X14l03Nz4KQ+uHnaRH0zcYEb2qe+jZF402xQqyvxI7N3dC
         Z47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7cazaUnsITY1FKb1YrD4ScYodUQeo/iAP9GwMqKKXQ=;
        b=Kkox/ojrF7ToKhq+GBXVUzACV5o/eJjI61HXHdwrtWtWclw66a/hrz7DfTrh7IrtL/
         /1wpE+1r4ZBcuGS7h53jzpCgXpwsQ4ei+H4sSrJSI9mcvwrn4ECWCLGFmw4uMWAKo7iF
         vnKhPUHkTmit4AqL3BBB3O7gmGVfEQvB7HuC+DqdcpySnbz5onvdGll7fbO1EHojMs3C
         p4JyCejcXxKpruX4Ry4yVJ8lOqkS6ksPUASjnvcYDtQj2Q5jY+eXv+29hUj0PVCIycXQ
         5VJ6Sb9TzoY+HlK4IuFnI2EN+3gyrN1NW3jUiiiCl/jL0wg5LQMMc9uw/NAjxNh8qTDT
         C4ww==
X-Gm-Message-State: APjAAAUN6kAU0R4e2+XuP6Ur1fI1Bb22/tXG6sTVAQnl4aDUkbae9ez5
        4/ylCnCcVRXuvQv1J14CtG6uUl1J7JgDx5x0eBE87g==
X-Google-Smtp-Source: APXvYqxpLPjuz8XiO5EMpXZ1AtGHQNoho6Q4p0uuQP7v5eoeI0kYkA7SZUrW+/C0qZjsGVCEMw+X8q5idXrdJQaMPXY=
X-Received: by 2002:ac8:3905:: with SMTP id s5mr39162303qtb.158.1575100684045;
 Fri, 29 Nov 2019 23:58:04 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c280ba05988b6242@google.com>
In-Reply-To: <000000000000c280ba05988b6242@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 30 Nov 2019 08:57:52 +0100
Message-ID: <CACT4Y+Z_E8tNtt5y4r_Sp+dWDjxundr4vor9DYxDr8FNj5U90A@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context in __alloc_pages_nodemask
To:     syzbot <syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com>,
        Daniel Axtens <dja@axtens.net>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 8:35 AM syzbot
<syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    419593da Add linux-next specific files for 20191129
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12cc369ce00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04b0959e75c206
> dashboard link: https://syzkaller.appspot.com/bug?extid=4925d60532bf4c399608
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com

+Daniel, kasan-dev
This is presumably from the new CONFIG_KASAN_VMALLOC

> BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2710, name:
> kworker/0:2
> 4 locks held by kworker/0:2/2710:
>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: __write_once_size
> include/linux/compiler.h:247 [inline]
>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: arch_atomic64_set
> arch/x86/include/asm/atomic64_64.h:34 [inline]
>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: atomic64_set
> include/asm-generic/atomic-instrumented.h:868 [inline]
>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: atomic_long_set
> include/asm-generic/atomic-long.h:40 [inline]
>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: set_work_data
> kernel/workqueue.c:615 [inline]
>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at:
> set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at:
> process_one_work+0x88b/0x1740 kernel/workqueue.c:2235
>   #1: ffffc9000802fdc0 (pcpu_balance_work){+.+.}, at:
> process_one_work+0x8c1/0x1740 kernel/workqueue.c:2239
>   #2: ffffffff8983ff20 (pcpu_alloc_mutex){+.+.}, at:
> pcpu_balance_workfn+0xb7/0x1310 mm/percpu.c:1845
>   #3: ffffffff89851b18 (vmap_area_lock){+.+.}, at: spin_lock
> include/linux/spinlock.h:338 [inline]
>   #3: ffffffff89851b18 (vmap_area_lock){+.+.}, at:
> pcpu_get_vm_areas+0x3b27/0x3f00 mm/vmalloc.c:3431
> Preemption disabled at:
> [<ffffffff81a89ce7>] spin_lock include/linux/spinlock.h:338 [inline]
> [<ffffffff81a89ce7>] pcpu_get_vm_areas+0x3b27/0x3f00 mm/vmalloc.c:3431
> CPU: 0 PID: 2710 Comm: kworker/0:2 Not tainted
> 5.4.0-next-20191129-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events pcpu_balance_workfn
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x197/0x210 lib/dump_stack.c:118
>   ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6800
>   __might_sleep+0x95/0x190 kernel/sched/core.c:6753
>   prepare_alloc_pages mm/page_alloc.c:4681 [inline]
>   __alloc_pages_nodemask+0x523/0x910 mm/page_alloc.c:4730
>   alloc_pages_current+0x107/0x210 mm/mempolicy.c:2211
>   alloc_pages include/linux/gfp.h:532 [inline]
>   __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
>   kasan_populate_vmalloc_pte mm/kasan/common.c:762 [inline]
>   kasan_populate_vmalloc_pte+0x2f/0x1c0 mm/kasan/common.c:753
>   apply_to_pte_range mm/memory.c:2041 [inline]
>   apply_to_pmd_range mm/memory.c:2068 [inline]
>   apply_to_pud_range mm/memory.c:2088 [inline]
>   apply_to_p4d_range mm/memory.c:2108 [inline]
>   apply_to_page_range+0x445/0x700 mm/memory.c:2133
>   kasan_populate_vmalloc+0x68/0x90 mm/kasan/common.c:791
>   pcpu_get_vm_areas+0x3c77/0x3f00 mm/vmalloc.c:3439
>   pcpu_create_chunk+0x24e/0x7f0 mm/percpu-vm.c:340
>   pcpu_balance_workfn+0xf1b/0x1310 mm/percpu.c:1934
>   process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
>   worker_thread+0x98/0xe40 kernel/workqueue.c:2410
>   kthread+0x361/0x430 kernel/kthread.c:255
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c280ba05988b6242%40google.com.
