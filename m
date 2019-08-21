Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD7FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6752122DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqGCwQ5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfHURDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:03:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41983 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHURDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:03:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so1642842pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFhGbXUvnOkFZSwaerOn40oKBEb8S6Yi9Qx6EyobhbA=;
        b=EqGCwQ5Z4GerS8x9+xDl81VBqIPAakjNtba5LJDJgr/SM6jyXC5M/VsVrfvlWGRV/r
         MqMPbjtxXbBBfkEr/yMr8kWt06PmC3+03YQ8fZrPoCvVtaev+lBtE89VcE7tjBrw4gOm
         JCGOHhVQVNwJkHzo+UtwZR5rF56XQikzY2vZ9kQAa/j9skAw3386WWfcjCmbNNhnqPdy
         P2jK1TIJLtnlWHmaCAvJz8794N5goTYS3o+OfKzgwTtKKTRE6ouVgmdv9C6Wdyk3MLtl
         pN5gjb2xrI+Qa2ReymS1oe53AGz+qcIEchI/1U3kn7rjPoAtU0jVTyyxDw2wSWVcmDBo
         mdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFhGbXUvnOkFZSwaerOn40oKBEb8S6Yi9Qx6EyobhbA=;
        b=I+kjmfSnOX3puYaTo3RzhVIenuDaGPhNGn2akWZ+e9r/Js8PDhhF/JDwDN5waldmrA
         9z5rNKWhNAGtbSX5pCvU+jHtpBA4O3+eeCdQPr8WoPtV67FP/P26jJrBD64w83dwKqs8
         rwsubaDTE3memHRPC1qspTZTXWbC4TLizo8sZYFAC0A70EUrszhFBGps2eqb9WY6nmEu
         keyoFCe4KcHg68xqycTUFAKFFF7fUYgcQYsiZincKpmGKviH8IjaoUoYNROGPhUYlCpb
         UoHZEAzdDnnsVXyIhPYyOu0Lt4nCA1CoMGRJ0w6/qBrQKkhTB527Kcj+QSysf8QEbMrE
         JaEw==
X-Gm-Message-State: APjAAAVHcKd3Z3mCpOD4lXf2R+m7v7a/d3jwXqf2iApwGX+LC4upbyy7
        XAdQAt8TCiJsOvTYxv1sHpuG2lx+BF1e6gwSDZikdA==
X-Google-Smtp-Source: APXvYqzuumex/UExXsK4Jfgam09/QMuLPfgtzM6gD+WvShyGZsy5FPS/0ZF8fJihZAN74Zr3VrienKJ4fsnnEAY3rEQ=
X-Received: by 2002:a17:902:bb94:: with SMTP id m20mr34213718pls.336.1566407016629;
 Wed, 21 Aug 2019 10:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d6225c058f72a7df@google.com>
In-Reply-To: <000000000000d6225c058f72a7df@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 19:03:25 +0200
Message-ID: <CAAeHK+whTqboP6zBZtgOgxgSC=uR-0jTnVyP6qq2n9DeR6iN-g@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in usbhid_close
To:     syzbot <syzbot+3268ee512f866a903602@syzkaller.appspotmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 3:18 PM syzbot
<syzbot+3268ee512f866a903602@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=117a9f42600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3268ee512f866a903602
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3268ee512f866a903602@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in __lock_acquire+0x302a/0x3b50
> kernel/locking/lockdep.c:3753
> Read of size 8 at addr ffff8881ceab68a0 by task syz-executor.0/3352
>
> CPU: 1 PID: 3352 Comm: syz-executor.0 Not tainted 5.3.0-rc2+ #25
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
>   kasan_report+0xe/0x12 mm/kasan/common.c:612
>   __lock_acquire+0x302a/0x3b50 kernel/locking/lockdep.c:3753
>   lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
>   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
>   _raw_spin_lock_irq+0x2d/0x40 kernel/locking/spinlock.c:167
>   spin_lock_irq include/linux/spinlock.h:363 [inline]
>   usbhid_close+0x51/0x210 drivers/hid/usbhid/hid-core.c:740
>   hid_hw_close+0xa8/0xd0 drivers/hid/hid-core.c:2046
>   drop_ref.part.0+0x32/0xe0 drivers/hid/hidraw.c:337
>   drop_ref drivers/hid/hidraw.c:360 [inline]
>   hidraw_release+0x34f/0x440 drivers/hid/hidraw.c:356
>   __fput+0x2d7/0x840 fs/file_table.c:280
>   task_work_run+0x13f/0x1c0 kernel/task_work.c:113
>   exit_task_work include/linux/task_work.h:22 [inline]
>   do_exit+0x8ef/0x2c50 kernel/exit.c:878
>   do_group_exit+0x125/0x340 kernel/exit.c:982
>   get_signal+0x466/0x23d0 kernel/signal.c:2728
>   do_signal+0x88/0x14e0 arch/x86/kernel/signal.c:815
>   exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:159
>   prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
>   do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459829
> Code: Bad RIP value.
> RSP: 002b:00007f123439dcf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000075bf28 RCX: 0000000000459829
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000075bf28
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000075bf2c
> R13: 00007ffe9281699f R14: 00007f123439e9c0 R15: 000000000075bf2c
>
> Allocated by task 0:
> (stack is not available)
>
> Freed by task 0:
> (stack is not available)
>
> The buggy address belongs to the object at ffff8881ceab6880
>   which belongs to the cache shmem_inode_cache of size 1168
> The buggy address is located 32 bytes inside of
>   1168-byte region [ffff8881ceab6880, ffff8881ceab6d10)
> The buggy address belongs to the page:
> page:ffffea00073aad00 refcount:1 mapcount:0 mapping:ffff8881da115180
> index:0x0 compound_mapcount: 0
> flags: 0x200000000010200(slab|head)
> raw: 0200000000010200 dead000000000100 dead000000000122 ffff8881da115180
> raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8881ceab6780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff8881ceab6800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8881ceab6880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                                 ^
>   ffff8881ceab6900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8881ceab6980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Looks like the same bug:

#syz dup: KASAN: slab-out-of-bounds Read in hidraw_ioctl
