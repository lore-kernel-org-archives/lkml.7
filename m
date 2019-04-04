Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A812F2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujG4GcCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfDDD7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:59:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42563 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfDDD7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:59:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id v22so747746lje.9;
        Wed, 03 Apr 2019 20:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpAPtvEpIq9wihslXvpjBmdg34s0i/8cbcbkYCKUVS4=;
        b=ujG4GcCaaRQrfHNneOpBAY40qv6p+G1MGKQh9CZKWcExsYJE0mG1nwPj2CDu4w7rCO
         L+gakNXVkD7PlC9omVtfC2du5qys3YyDnXndUfWCKLaLEWK1BgIn6PHl3NA02cgB+tXR
         6K0TF34wu+mkFDFtBSZMvrlEuUz/hHmNRGBdBBrUbVeyvr4rEC47KGFDLjdaY/mo7E7R
         QZAahltdsfzX7sCzQVJ7jYY70lI0MtAJVU14fR8EMYjEc8VFcLYrgK7wnaKz/o9cotvp
         FakyUosmNeodzFGuZmIffOWzIHnJV/kP6mrVrHPf0xjgOCLzM7m8Rpe7txBQOiBjiTpL
         seBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpAPtvEpIq9wihslXvpjBmdg34s0i/8cbcbkYCKUVS4=;
        b=cWXNxuGS4SUzGT20cj0yVxEFuygAHWhGOlNXI4sAKpJ15RSB3SQ1iWjClnabbMMI23
         flWDhg0v6fJLBuOcgM19kIFv2CDRKiKJ219A8VQoiQOcBVsvAPodMT9VobsUzc6GTAdF
         U9RiqnBZEbKnJgrM9s5wtiJ8zgRI6QDFILUo710zspr+Bt6OZBrh/aaN4es8aMSKz5gy
         +sQPmUoX0R6g6SzMHyTr4iwnVPinX8QsVAGFQi2a01YOlk3HOTPnFWkGU6AvBr0MjsM7
         lZccM7G3fdASqdUm6fTwnVAtapmGyTXrA0HpOXqi492AribxvlmSwRLpxi2ZlRQF/GlQ
         R32g==
X-Gm-Message-State: APjAAAUbki/H4Mr3LWXrzDEubmc/5al+cvrQyLFOTRBdq1h2IN7oMnoK
        T+O5AJs5X0xyFpCY4cQEZ/8xQ/ZfdrVGHXI1V/Q=
X-Google-Smtp-Source: APXvYqyP69hDt0oDeLsWR6T8M1DhXEHf3+DTWJbDFb+3lv70Lfr/br5Hfv+s3UHBzsYiUXBFlEEZD1Z4cEpMne2MqXE=
X-Received: by 2002:a2e:731a:: with SMTP id o26mr1858436ljc.69.1554350376432;
 Wed, 03 Apr 2019 20:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009cd09a056f1451d1@google.com> <cc82200a-6374-0a87-a3e0-471d04a8306a@gmail.com>
In-Reply-To: <cc82200a-6374-0a87-a3e0-471d04a8306a@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 3 Apr 2019 20:59:24 -0700
Message-ID: <CAADnVQKbZgXDvbwSREYYGTeTX42oD-Q4UrKRjowTVsdktu4t4w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __dev_map_entry_free
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     syzbot <syzbot+457d3e2ffbcf31aee5c0@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 1:03 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 06/20/2018 08:19 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
> > git tree:       bpf-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15ad7d10400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=457d3e2ffbcf31aee5c0
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1195225f800000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171a7ce4400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+457d3e2ffbcf31aee5c0@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in dev_map_flush_old kernel/bpf/devmap.c:365 [inline]
> > BUG: KASAN: use-after-free in __dev_map_entry_free+0x2a8/0x300 kernel/bpf/devmap.c:379
> > Read of size 8 at addr ffff8801b8da38c8 by task ksoftirqd/1/18
> >
> > CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 4.17.0+ #39
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
> >  print_address_description+0x6c/0x20b mm/kasan/report.c:256
> >  kasan_report_error mm/kasan/report.c:354 [inline]
> >  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
> >  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> >  dev_map_flush_old kernel/bpf/devmap.c:365 [inline]
> >  __dev_map_entry_free+0x2a8/0x300 kernel/bpf/devmap.c:379
> >  __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
> >  rcu_do_batch kernel/rcu/tree.c:2558 [inline]
> >  invoke_rcu_callbacks kernel/rcu/tree.c:2818 [inline]
> >  __rcu_process_callbacks kernel/rcu/tree.c:2785 [inline]
> >  rcu_process_callbacks+0xe9d/0x1760 kernel/rcu/tree.c:2802
> >  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:284
> >  run_ksoftirqd+0x86/0x100 kernel/softirq.c:645
> >  smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
> >  kthread+0x345/0x410 kernel/kthread.c:240
> >  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> >
> > Allocated by task 6675:
> >  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >  set_track mm/kasan/kasan.c:460 [inline]
> >  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
> >  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
> >  kmalloc include/linux/slab.h:513 [inline]
> >  kzalloc include/linux/slab.h:706 [inline]
> >  dev_map_alloc+0x208/0x7f0 kernel/bpf/devmap.c:102
> >  find_and_alloc_map kernel/bpf/syscall.c:129 [inline]
> >  map_create+0x393/0x1010 kernel/bpf/syscall.c:453
> >  __do_sys_bpf kernel/bpf/syscall.c:2351 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:2328 [inline]
> >  __x64_sys_bpf+0x303/0x510 kernel/bpf/syscall.c:2328
> >  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Freed by task 26:
> >  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >  set_track mm/kasan/kasan.c:460 [inline]
> >  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
> >  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
> >  __cache_free mm/slab.c:3498 [inline]
> >  kfree+0xd9/0x260 mm/slab.c:3813
> >  dev_map_free+0x4fa/0x670 kernel/bpf/devmap.c:191
> >  bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:262
> >  process_one_work+0xc64/0x1b70 kernel/workqueue.c:2153
> >  worker_thread+0x181/0x13a0 kernel/workqueue.c:2296
> >  kthread+0x345/0x410 kernel/kthread.c:240
> >  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> >
> > The buggy address belongs to the object at ffff8801b8da37c0
> >  which belongs to the cache kmalloc-512 of size 512
> > The buggy address is located 264 bytes inside of
> >  512-byte region [ffff8801b8da37c0, ffff8801b8da39c0)
> > The buggy address belongs to the page:
> > page:ffffea0006e368c0 count:1 mapcount:0 mapping:ffff8801da800940 index:0xffff8801b8da3540
> > flags: 0x2fffc0000000100(slab)
> > raw: 02fffc0000000100 ffffea0007217b88 ffffea0006e30cc8 ffff8801da800940
> > raw: ffff8801b8da3540 ffff8801b8da3040 0000000100000004 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff8801b8da3780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> >  ffff8801b8da3800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >> ffff8801b8da3880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                               ^
> >  ffff8801b8da3900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8801b8da3980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
>
> What about something like :
>
>
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 191b79948424f4b21b7aa120abc03801264bf0a6..1e525d70f83354e451b738ffb8e42d83b5fa932f 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -164,6 +164,9 @@ static void dev_map_free(struct bpf_map *map)
>         bpf_clear_redirect_map(map);
>         synchronize_rcu();
>
> +       /* Make sure prior __dev_map_entry_free() have completed. */
> +       rcu_barrier();
> +

Eric, Thank you for looking at it. The fix makes sense to me.

Jesper, thoughts?
