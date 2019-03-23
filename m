Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685DFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 07:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C9E218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 07:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+E+YwoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCWHYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 03:24:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40520 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfCWHYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 03:24:48 -0400
Received: by mail-io1-f66.google.com with SMTP id d201so3584664iof.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 00:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPPBFWW2DEsHQ8ZDhBo/0unOfNCSzYyuy1IQYfH6rNI=;
        b=c+E+YwoCI5CF1yr96mgFT1uzrBzxCif58gY62vrXgYwsbrqxZLqIu3dNA2hpYW14W8
         ggJnakP5ONOTkAM5Apt2qJGuv0A3hXGY3FL/lkklhFzSqJP6LZBGMvlOWp7+LjT6pebk
         Rchqyq/iLs+Sx0q3ftPPn0c45/n8TQ6Vy018FYsTZ4lX+I/XkYbl/ZmPq8ncG5+0C2Yd
         3eU0JpxNzGHSgmuD23bJfwfqxduTv6RCuHpZZVuOKzVZgPcUDGAEMCFoQ0u32ujsc5v1
         0BwthvgOFrwIdKec6TWwNfyaDle/lpgQ1L5ubi+5MZR5zGBg4sl/a7ERr0oPEdfi4VCW
         3Iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPPBFWW2DEsHQ8ZDhBo/0unOfNCSzYyuy1IQYfH6rNI=;
        b=VLRpWa2P/ioZvDhreWj7qOS8BfVBE5xiMAZ9B3ll9NsDfRo4LCQOtTVPV1otMXr5nt
         KwznGME8Q963U2omHIDqRn0EP0Eb1qLwfovhyeNtbvWvmtWwQJYJhR8PFE1Zdl3hhiz7
         1rZXiDQXV303HW8QxIzGLo9WFfJu61gDBSDpNo84hhulqlhd9PcdV1c7ZsoPCXwPjBht
         9gv55PD8IUQ/1l2XQJt2EikexB38MP6B/N2KCiHfZTZxJ20Q5fvnVaZdGm8PemYdDVay
         8GuurnGyI7aDmwfMpXVv5FLEMdDHvQROb2RxU1PkK4IGY+MC0kS/1EKbD63ZJaen5doR
         aj+Q==
X-Gm-Message-State: APjAAAXwi1SiBJE9vxmho90WWHK9nt5A5aYhZvw1brqSsawS0xOQbLTh
        57QZoWxUCOePYh7eTL249fq1CvXERfeH6UMNwz9scg==
X-Google-Smtp-Source: APXvYqyZ5giIHj8t6q0lo2vmna7pcuIuGZ8PUWWjARpWa8R41zN2soSgTUg7G0JkMsjY3+DxVQtpxgTaqUSLXtpkas0=
X-Received: by 2002:a5d:9457:: with SMTP id x23mr5897651ior.271.1553325886627;
 Sat, 23 Mar 2019 00:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f746f705752f95a6@google.com> <d39c169e-9201-7e0d-44e7-ad775b185115@gmail.com>
In-Reply-To: <d39c169e-9201-7e0d-44e7-ad775b185115@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 23 Mar 2019 08:24:35 +0100
Message-ID: <CACT4Y+bLOcYAoiSe=gsOfmHcCLVS6smGaMM7NWciPS9aT=7yeQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in bpf_tcp_close (2)
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     syzbot <syzbot+579adfa56843da894bc5@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 9:53 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> On 09/06/2018 01:22 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    11f026b4e306 libbpf: Remove the duplicate checking of func..
> > git tree:       bpf-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=153c55ca400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
> > dashboard link: https://syzkaller.appspot.com/bug?extid=579adfa56843da894bc5
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+579adfa56843da894bc5@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
> > BUG: KASAN: use-after-free in virt_spin_lock arch/x86/include/asm/qspinlock.h:65 [inline]
> > BUG: KASAN: use-after-free in native_queued_spin_lock_slowpath+0x189/0x1220 kernel/locking/qspinlock.c:305
> > Read of size 4 at addr ffff8801bfd651a0 by task syz-executor1/9753
> >
> > CPU: 1 PID: 9753 Comm: syz-executor1 Not tainted 4.19.0-rc2+ #89
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
> >  print_address_description+0x6c/0x20b mm/kasan/report.c:256
> >  kasan_report_error mm/kasan/report.c:354 [inline]
> >  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
> >  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
> >  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
> >  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
> >  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
> >  virt_spin_lock arch/x86/include/asm/qspinlock.h:65 [inline]
> >  native_queued_spin_lock_slowpath+0x189/0x1220 kernel/locking/qspinlock.c:305
> >  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:679 [inline]
> >  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:32 [inline]
> >  queued_spin_lock include/asm-generic/qspinlock.h:88 [inline]
> >  do_raw_spin_lock+0x1a7/0x200 kernel/locking/spinlock_debug.c:113
> >  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
> >  _raw_spin_lock_bh+0x39/0x40 kernel/locking/spinlock.c:168
> >  bpf_tcp_close+0x68e/0x10d0 kernel/bpf/sockmap.c:349
> >  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
> >  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:457
> >  __sock_release+0xd7/0x250 net/socket.c:579
> >  sock_close+0x19/0x20 net/socket.c:1139
> >  __fput+0x38a/0xa40 fs/file_table.c:278
> >  ____fput+0x15/0x20 fs/file_table.c:309
> >  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
> >  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
> >  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
> >  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
> >  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
> >  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x410c51
> > Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> > RSP: 002b:00007ffeacb37d60 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> > RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000410c51
> > RDX: 0000000000000000 RSI: 0000000000731f70 RDI: 0000000000000007
> > RBP: 0000000000000000 R08: ffffffffffffffff R09: ffffffffffffffff
> > R10: 00007ffeacb37c90 R11: 0000000000000293 R12: 0000000000000010
> > R13: 0000000000022aa9 R14: 000000000000004d R15: badc0ffeebadface
> >
> > Allocated by task 9754:
> >  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >  set_track mm/kasan/kasan.c:460 [inline]
> >  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
> >  kmem_cache_alloc_trace+0x152/0x730 mm/slab.c:3620
> >  kmalloc include/linux/slab.h:513 [inline]
> >  kzalloc include/linux/slab.h:707 [inline]
> >  sock_map_alloc+0x209/0x430 kernel/bpf/sockmap.c:1653
> >  find_and_alloc_map kernel/bpf/syscall.c:129 [inline]
> >  map_create+0x3bd/0x1100 kernel/bpf/syscall.c:509
> >  __do_sys_bpf kernel/bpf/syscall.c:2356 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:2333 [inline]
> >  __x64_sys_bpf+0x303/0x510 kernel/bpf/syscall.c:2333
> >  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Freed by task 13:
> >  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >  set_track mm/kasan/kasan.c:460 [inline]
> >  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
> >  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
> >  __cache_free mm/slab.c:3498 [inline]
> >  kfree+0xd9/0x210 mm/slab.c:3813
> >  sock_map_remove_complete kernel/bpf/sockmap.c:1561 [inline]
> >  sock_map_free+0x428/0x570 kernel/bpf/sockmap.c:1756
> >  bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:290
> >  process_one_work+0xc73/0x1aa0 kernel/workqueue.c:2153
> >  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
> >  kthread+0x35a/0x420 kernel/kthread.c:246
> >  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
> >
> > The buggy address belongs to the object at ffff8801bfd65080
> >  which belongs to the cache kmalloc-512 of size 512
> > The buggy address is located 288 bytes inside of
> >  512-byte region [ffff8801bfd65080, ffff8801bfd65280)
> > The buggy address belongs to the page:
> > page:ffffea0006ff5940 count:1 mapcount:0 mapping:ffff8801dac00940 index:0xffff8801bfd65300
> > flags: 0x2fffc0000000100(slab)
> > raw: 02fffc0000000100 ffffea000702a488 ffffea00075c4148 ffff8801dac00940
> > raw: ffff8801bfd65300 ffff8801bfd65080 0000000100000001 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff8801bfd65080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8801bfd65100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >> ffff8801bfd65180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                ^
> >  ffff8801bfd65200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8801bfd65280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ==================================================================
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
>
> Introduced here (by a new reference to the map from the
> tcp close context where a parallel free'ing of the map which
> does not have a RCU grace period before free),
>
> commit 585f5a6252ee43ec8feeee07387e3fcc7e8bb292
> Author: Daniel Borkmann <daniel@iogearbox.net>
> Date:   Thu Aug 16 21:49:10 2018 +0200
>
>     bpf, sockmap: fix sock_map_ctx_update_elem race with exist/noexist
>
> I'll have a fix shortly.
>
> Thanks,
> John

John, did you fix it or not?
syzbot has closed it, so we may have lose this forever if not fixed.
If you fixed it, please include the Reported-by tag as asked by the reporter.

---------- Forwarded message ---------
From: syzbot <syzbot+579adfa56843da894bc5@syzkaller.appspotmail.com>
Date: Sat, Mar 23, 2019 at 5:55 AM
Subject: Re: KASAN: use-after-free Read in bpf_tcp_close (2)
To: <syzkaller-bugs@googlegroups.com>

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
