Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E08C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43132075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAS9PQqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfC0JUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:20:45 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38782 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfC0JUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:20:45 -0400
Received: by mail-yw1-f66.google.com with SMTP id m207so2852242ywd.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FX6ankHFoEgu3uAFeOamCU9TDkJqknsanlNyfsu/pyA=;
        b=cAS9PQqzodypJxJv2cbiou20FZQ72+Q/oEYF0T9GC/bxSRYy6wJec/yu5KsBu1mKB/
         cxFw2F/kO/Y4fBTwKiOXg6dT/Ku5vM2bbf83CiJMzPDvG75ugIwjkA0OyvBHDc4kFFwv
         Z8r0hzGERaOo1nms9+1kOpiO1/K2p7rzc9EOlve/QYspYhJBy90nCaG6ZeHKaKRRE/Or
         mq9sQ7If3Nqoo5nEDa8oSEbsHOMIaWpEwuwkRc10vhgDKs1q+hpB68EeakXJ9xX9XpSa
         OEBxxhAB73ozaS0+zbOs5mYJVXkBtiGC5WbyJzUBbtUYSCXVDg7UN3ZCe3YrHiLLbCQR
         OwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FX6ankHFoEgu3uAFeOamCU9TDkJqknsanlNyfsu/pyA=;
        b=fSFphukFkkKb7JrD6OImJs1UfqWaRSWgGg4GwbWnPCuBZw2ch70JAtZx0VpOuUckvE
         Mn+1uKZnWQsEWlb5UlT1l6Rv7691fhw2onzpIIJR4geFV095t8t1Psw5bSaOeeGbE0nU
         QFKf/fVisuHdyoJYuZoB2CBMMCqEOQ8S9TIFfCJlHNOUaCVrffeXTUoAyeds7ZJqrdsz
         wQLqYRArz98o0zRToV1Pyd777u/WAlyJhqy6AYzVyRrHMpCJ9cN4nKalofSRsXg0NSEB
         yANxHWNS467YG1GPqqKq1wAxo6J9OJQBllE6ec7py8NQZTUsCjyZt/PHlWnr03QItgyY
         dvNw==
X-Gm-Message-State: APjAAAWMItv7rZou/A/tzFRlrGfFKdhvlbR1LTWjMVezXhytUNmtbUyX
        fMtKmzROATvoBViIyUqDM2CTHDfbLirOjJjBys7h5A==
X-Google-Smtp-Source: APXvYqyU+kPLPdZxljyqdej2QBL3K8ZSnFRCyi7qZAnIFKqaxbcIPdEh1fFwnja5EYfpg1trG0w46EUcSpEq+APjvMQ=
X-Received: by 2002:a81:1d45:: with SMTP id d66mr30270311ywd.37.1553678443547;
 Wed, 27 Mar 2019 02:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004cd71f05850f17c2@google.com> <CACT4Y+Yt9vfk1OM1b3fsVJ_i+qZx7kz71ty6heDE3GwujGNevQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Yt9vfk1OM1b3fsVJ_i+qZx7kz71ty6heDE3GwujGNevQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 27 Mar 2019 02:20:32 -0700
Message-ID: <CANn89iKiLe1e3P_hx2R612DCqZyw59vJcdp3dm2YRdrTJHHT=A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __icmp_send
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+aa9105f99c12b6abfe27@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 1:22 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Mar 27, 2019 at 9:19 AM syzbot
> <syzbot+aa9105f99c12b6abfe27@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    1d965c4d Merge branch 'Refactor-flower-classifier-to-remov..
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14ff71df200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f05902bca21d8935
> > dashboard link: https://syzkaller.appspot.com/bug?extid=aa9105f99c12b6abfe27
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+aa9105f99c12b6abfe27@syzkaller.appspotmail.com
>
> Eric, do you think this is also fixed by "tun: properly test for
> IFF_UP" as the bug in icmp6_send?

Very possibly.

>
> > ==================================================================
> > BUG: KASAN: use-after-free in atomic_read
> > include/asm-generic/atomic-instrumented.h:26 [inline]
> > BUG: KASAN: use-after-free in queued_spin_trylock
> > include/asm-generic/qspinlock.h:69 [inline]
> > BUG: KASAN: use-after-free in do_raw_spin_trylock+0x6a/0x180
> > kernel/locking/spinlock_debug.c:119
> > Read of size 4 at addr ffff88808a28ccd4 by task syz-executor.0/17585
> >
> > CPU: 0 PID: 17585 Comm: syz-executor.0 Not tainted 5.0.0+ #105
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   <IRQ>
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> >   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> >   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
> >   check_memory_region_inline mm/kasan/generic.c:185 [inline]
> >   check_memory_region+0x123/0x190 mm/kasan/generic.c:191
> >   kasan_check_read+0x11/0x20 mm/kasan/common.c:102
> >   atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
> >   queued_spin_trylock include/asm-generic/qspinlock.h:69 [inline]
> >   do_raw_spin_trylock+0x6a/0x180 kernel/locking/spinlock_debug.c:119
> >   __raw_spin_trylock include/linux/spinlock_api_smp.h:89 [inline]
> >   _raw_spin_trylock+0x1c/0x80 kernel/locking/spinlock.c:128
> >   spin_trylock include/linux/spinlock.h:339 [inline]
> >   icmp_xmit_lock net/ipv4/icmp.c:219 [inline]
> >   __icmp_send+0x553/0x1400 net/ipv4/icmp.c:666
> >   icmp_send include/net/icmp.h:47 [inline]
> >   ipv4_link_failure+0x31/0x210 net/ipv4/route.c:1190
> >   dst_link_failure include/net/dst.h:416 [inline]
> >   arp_error_report+0xd1/0x1c0 net/ipv4/arp.c:297
> >   neigh_invalidate+0x24b/0x570 net/core/neighbour.c:995
> >   neigh_timer_handler+0xc35/0xf30 net/core/neighbour.c:1081
> >   call_timer_fn+0x190/0x720 kernel/time/timer.c:1325
> >   expire_timers kernel/time/timer.c:1362 [inline]
> >   __run_timers kernel/time/timer.c:1681 [inline]
> >   __run_timers kernel/time/timer.c:1649 [inline]
> >   run_timer_softirq+0x652/0x1700 kernel/time/timer.c:1694
> >   __do_softirq+0x266/0x95a kernel/softirq.c:293
> >   invoke_softirq kernel/softirq.c:374 [inline]
> >   irq_exit+0x180/0x1d0 kernel/softirq.c:414
> >   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
> >   smp_apic_timer_interrupt+0x14a/0x570 arch/x86/kernel/apic/apic.c:1062
> >   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
> >   </IRQ>
> > RIP: 0010:filename_mountpoint+0x25d/0x3c0 fs/namei.c:2722
> > Code: 14 02 4c 89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 1c 01 00 00
> > 45 8b 24 24 31 ff 44 89 e6 e8 58 ea ba ff 45 85 e4 74 62 <e8> ce e8 ba ff
> > e8 49 2a fe ff 4c 89 f7 e8 81 f2 ff ff e8 bc e8 ba
> > RSP: 0018:ffff8880a857fc30 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> > RAX: dffffc0000000000 RBX: 1ffff110150aff88 RCX: ffffffff81b57ad4
> > RDX: 1ffff1100bd8e54c RSI: ffffffff81b57ae2 RDI: ffff88805ec72a60
> > RBP: ffff8880a857fdc8 R08: ffff88805ec72300 R09: 0000000000000001
> > R10: 000000000000001c R11: ffff8880ae82de3b R12: 0000000000000000
> > R13: 0000000000000000 R14: ffff888097790e00 R15: ffff8880a857fe68
> >   user_path_mountpoint_at+0x3a/0x50 fs/namei.c:2745
> >   ksys_umount+0x167/0xf00 fs/namespace.c:1687
> >   __do_sys_umount fs/namespace.c:1713 [inline]
> >   __se_sys_umount fs/namespace.c:1711 [inline]
> >   __x64_sys_umount+0x54/0x80 fs/namespace.c:1711
> >   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x45ac57
> > Code: 44 00 00 b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 4d 8e fb ff c3
> > 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff
> > ff 0f 83 2d 8e fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007ffe6359ff08 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000045ac57
> > RDX: 0000000000402ea0 RSI: 0000000000000002 RDI: 00007ffe6359ffb0
> > RBP: 00000000000019e0 R08: 0000000000000000 R09: 000000000000000d
> > R10: 0000000000000006 R11: 0000000000000202 R12: 00007ffe635a1040
> > R13: 0000000000bfa940 R14: 0000000000000000 R15: 00007ffe635a1040
> >
> > Allocated by task 12478:
> >   save_stack+0x45/0xd0 mm/kasan/common.c:75
> >   set_track mm/kasan/common.c:87 [inline]
> >   __kasan_kmalloc mm/kasan/common.c:497 [inline]
> >   __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
> >   kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:505
> >   slab_post_alloc_hook mm/slab.h:436 [inline]
> >   slab_alloc mm/slab.c:3392 [inline]
> >   kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3554
> >   getname_flags fs/namei.c:138 [inline]
> >   getname_flags+0xd6/0x5b0 fs/namei.c:128
> >   getname+0x1a/0x20 fs/namei.c:209
> >   do_sys_open+0x2c9/0x5d0 fs/open.c:1057
> >   __do_sys_open fs/open.c:1081 [inline]
> >   __se_sys_open fs/open.c:1076 [inline]
> >   __x64_sys_open+0x7e/0xc0 fs/open.c:1076
> >   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Freed by task 12478:
> >   save_stack+0x45/0xd0 mm/kasan/common.c:75
> >   set_track mm/kasan/common.c:87 [inline]
> >   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
> >   kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
> >   __cache_free mm/slab.c:3498 [inline]
> >   kmem_cache_free+0x86/0x260 mm/slab.c:3764
> >   putname+0xef/0x130 fs/namei.c:259
> >   do_sys_open+0x318/0x5d0 fs/open.c:1072
> >   __do_sys_open fs/open.c:1081 [inline]
> >   __se_sys_open fs/open.c:1076 [inline]
> >   __x64_sys_open+0x7e/0xc0 fs/open.c:1076
> >   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > The buggy address belongs to the object at ffff88808a28c780
> >   which belongs to the cache names_cache of size 4096
> > The buggy address is located 1364 bytes inside of
> >   4096-byte region [ffff88808a28c780, ffff88808a28d780)
> > The buggy address belongs to the page:
> > page:ffffea000228a300 count:1 mapcount:0 mapping:ffff88812c2d8dc0 index:0x0
> > compound_mapcount: 0
> > flags: 0x1fffc0000010200(slab|head)
> > raw: 01fffc0000010200 ffffea00025c8908 ffffea0001840a08 ffff88812c2d8dc0
> > raw: 0000000000000000 ffff88808a28c780 0000000100000001 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >   ffff88808a28cb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff88808a28cc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > ffff88808a28cc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                                   ^
> >   ffff88808a28cd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff88808a28cd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004cd71f05850f17c2%40google.com.
> > For more options, visit https://groups.google.com/d/optout.
