Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27013C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F23206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBQxDKIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfHMMy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:54:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36330 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfHMMy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:54:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id g4so2774329plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MD+0g6zXoZq5Qyz/nfj2779Oyuui4Qlp1ZERXfuNGc8=;
        b=UBQxDKIVIM0/h+T4ziLhDTkTjB01yVdzA8KTowgyvBdxYYU2xJZhJMUInpqERNqhGL
         ODEI+Sfn0J8Y8OJeBv5eRiNNbyCe9+zZ9u6I86DRa1CzCNx5OAxC3boHBLAVGlZWpHbk
         li+tdpG5ExavPPL3gSJ47aBcZV3KZNNZ0pADo2TOKz0ZxjUsf4mPwBt4/SZl9B3mJXZJ
         TAUlaykL3aCzGRvGF2Kaa4VBv+H0NT7vblsyh8eOzZO0UoYMhnMOpr8qqBRUxDKjiGfU
         zDMuTl6Ei95IyKIP+++NppNrsCz1F0l14ZBau6phFqVU2EZxLjYA7VC4Mo01ifXPyFaU
         xCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MD+0g6zXoZq5Qyz/nfj2779Oyuui4Qlp1ZERXfuNGc8=;
        b=KKCBqzowAbiMLEcf7hUqNFt/Vxy21g5Z8DgguWnjmbj3Bldhk+JhY+N5Jk/JDUiHDt
         EUXEsTwIITxT/XSPU/kwkdDkBUGVT+lbKTTGsQPnFtxDled8+vs1/UOqck5oYD8JUeHO
         B7Zt2xct/TKGHS8NmmwD7GZkg66lmY2Mfi8s2qs913JpzopWuctqO4QrwNE3WeYfjPfo
         mpAQsX8vRb8GGzjhnhjoHDAdlLvWAbCvLIhfl4/1jhvW4lMvtzSZPlDcimNdfkAsCH9f
         c9KdXIoF1EQcP7VDfCS/IicdtwTh+hyZNBvoolUoM1YJmWVD0Nh3aC8bhp2fPK+j9DHj
         S88A==
X-Gm-Message-State: APjAAAUE+rRw6QvbisgLZelmvuCvYPfaM2xrqvp63utHc3cDY3nZd7L3
        y55GCBqN/86fKLiHDEbUq9zSIJ1t0UdMypZKJWN8xA==
X-Google-Smtp-Source: APXvYqx7jkynxzEtMLecLSDmVymzr+bz634fXi+SJbGZHeXaqwTv/aZUzS2ThdTw5spI5Ud7WUor0UNxz1Dsfq8pwYE=
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr10015510plt.252.1565700868367;
 Tue, 13 Aug 2019 05:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000000631505868311c8@google.com>
In-Reply-To: <00000000000000631505868311c8@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Aug 2019 14:54:17 +0200
Message-ID: <CAAeHK+zB8JikzfFgTigjNkxtpUOkGYkHixo480REJ_yQidLB_w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in ds_probe
To:     syzbot <syzbot+5620801aaaf778ca83c6@syzkaller.appspotmail.com>
Cc:     florian.harbecke@fau.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, passt@h-hofmeier.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, zbr@ioremap.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 10:06 PM syzbot
<syzbot+5620801aaaf778ca83c6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=15fb7cd3200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> dashboard link: https://syzkaller.appspot.com/bug?extid=5620801aaaf778ca83c6
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1676f06b200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1373c65b200000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5620801aaaf778ca83c6@syzkaller.appspotmail.com
>
> usb 1-1: config 0 has no interface number 0
> usb 1-1: New USB device found, idVendor=04fa, idProduct=2490,
> bcdDevice=89.a4
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> ==================================================================
> BUG: KASAN: use-after-free in ds_probe+0x604/0x760
> drivers/w1/masters/ds2490.c:1019
> Read of size 1 at addr ffff8880a7996862 by task kworker/0:1/12
>
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xe8/0x16e lib/dump_stack.c:113
>   print_address_description+0x6c/0x236 mm/kasan/report.c:187
>   kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
>   ds_probe+0x604/0x760 drivers/w1/masters/ds2490.c:1019
>   usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
>   really_probe+0x2da/0xb10 drivers/base/dd.c:509
>   driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
>   __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
>   bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x223/0x3a0 drivers/base/dd.c:844
>   bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
>   device_add+0xad2/0x16e0 drivers/base/core.c:2106
>   usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
>   generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
>   usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
>   really_probe+0x2da/0xb10 drivers/base/dd.c:509
>   driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
>   __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
>   bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x223/0x3a0 drivers/base/dd.c:844
>   bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
>   device_add+0xad2/0x16e0 drivers/base/core.c:2106
>   usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
>   hub_port_connect drivers/usb/core/hub.c:5089 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
>   port_event drivers/usb/core/hub.c:5350 [inline]
>   hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
>   process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
>   worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
>   kthread+0x313/0x420 kernel/kthread.c:253
>   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
>
> Allocated by task 4260:
>   set_track mm/kasan/common.c:87 [inline]
>   __kasan_kmalloc mm/kasan/common.c:497 [inline]
>   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
>   kmalloc include/linux/slab.h:552 [inline]
>   kzalloc include/linux/slab.h:742 [inline]
>   lsm_task_alloc security/security.c:544 [inline]
>   security_task_alloc+0x113/0x180 security/security.c:1456
>   copy_process.part.0+0x1c62/0x76b0 kernel/fork.c:1898
>   copy_process kernel/fork.c:1709 [inline]
>   _do_fork+0x234/0xed0 kernel/fork.c:2226
>   do_syscall_64+0xcf/0x4f0 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 1405:
>   set_track mm/kasan/common.c:87 [inline]
>   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
>   slab_free_hook mm/slub.c:1429 [inline]
>   slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
>   slab_free mm/slub.c:3003 [inline]
>   kfree+0xce/0x290 mm/slub.c:3958
>   security_task_free+0x9a/0xf0 security/security.c:1470
>   __put_task_struct+0xec/0x4d0 kernel/fork.c:724
>   put_task_struct include/linux/sched/task.h:98 [inline]
>   delayed_put_task_struct+0x189/0x290 kernel/exit.c:181
>   __rcu_reclaim kernel/rcu/rcu.h:227 [inline]
>   rcu_do_batch kernel/rcu/tree.c:2475 [inline]
>   invoke_rcu_callbacks kernel/rcu/tree.c:2788 [inline]
>   rcu_core+0x83b/0x1a80 kernel/rcu/tree.c:2769
>   __do_softirq+0x22a/0x8cd kernel/softirq.c:293
>
> The buggy address belongs to the object at ffff8880a7996840
>   which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 34 bytes inside of
>   64-byte region [ffff8880a7996840, ffff8880a7996880)
> The buggy address belongs to the page:
> page:ffffea00029e6580 count:1 mapcount:0 mapping:ffff88812c3f5600 index:0x0
> flags: 0xfff00000000200(slab)
> raw: 00fff00000000200 ffffea000273f740 0000000500000005 ffff88812c3f5600
> raw: 0000000000000000 00000000002a002a 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8880a7996700: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
>   ffff8880a7996780: 00 00 00 00 00 00 fc fc fc fc fc fc 00 00 00 00
> > ffff8880a7996800: 00 00 fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>                                                         ^
>   ffff8880a7996880: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
>   ffff8880a7996900: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
> ==================================================================

#syz dup: KASAN: slab-out-of-bounds Read in ds_probe

>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
