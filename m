Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408E4C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DD52173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvHd8/k4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfIEMM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:12:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46682 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731798AbfIEMM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:12:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so1608391pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etutrtjnCH9KJJVtWgAtyf02/whkTOUpz/oWW/JUFkk=;
        b=mvHd8/k4d/Pd8TPU6TszNXi4qeXz+MsqoYkOS3aX/2MRIS2NgECR1q3yd1EvvCIEIy
         qs6wtV4weRfP8JCqt6hgo9HfgLQgzk+Sk7+HL+XpiX0XPH/Bw3i7j+q7FEoVfIoNfgtC
         FwO0UV/Jg5oeZ/PfqPqk55G2USM3j3RcGRildjcwf4IE12odFUr50RPYHmOJm4nCs8lK
         i9FF4d34OBodDcZY6l8rJJhWtL8ktorKnL1tppA8GLemSy0/LxoEZXpPanGNKHQBp7cN
         cXniw7Hf+mr9G1uNluyjePeTr8vLFwuPv2N4HAc2JHKiMNKnMV0ZVV143Cj5j653klUW
         FI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etutrtjnCH9KJJVtWgAtyf02/whkTOUpz/oWW/JUFkk=;
        b=TNJF/eLrglsh51JCW+r60CHv/hyriWVsADL6QVSZCSJsgMKV3MHUUFS+OrPHcEPdf+
         H60zcaRkuBYlBmrg/98HcwxCSt5XIUrwjPcz1W+uMZkMANWY5FFnuS/XHz3cXYTBzokd
         FGqimxd8Oc1+QZ+BK4rkDG0zDtZs1bxYwKlHtmAO8xoH4X8WU+qqzbIA3S764lG97FNn
         xUw201VXWKXBpz8ubac397dv+XsIOiHiUpKNW/nWSrfZqqqwj7+WqzgMgvdGKpkWG/7d
         0h6ZYV+pjIExpMHHtDlUhI5CsR85qW5U02cJSERrmzj+BQk+Zny5kADLFhCu62zhTV/S
         B8Yg==
X-Gm-Message-State: APjAAAV99FHPcQQDb/weMtUCbB7uSCu5yMEPP1eYK02pp2dh948SmrlO
        EjpbS1mD18w6CS1kEefbyVp2WD08Jf+67JfFM1lY7g==
X-Google-Smtp-Source: APXvYqznohsLv2t1ED/MYyXHxwfKId8b9hxbw5/sTYrRz2OmoZfJGuh45+WYCysvuxCqtV9lejcJ2LBER7/yrLp6buc=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr2855600pgq.130.1567685574307;
 Thu, 05 Sep 2019 05:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009c42670590796d1d@google.com>
In-Reply-To: <0000000000009c42670590796d1d@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 5 Sep 2019 14:12:43 +0200
Message-ID: <CAAeHK+wR00gc=F1WYbQ3-NTnqK9Ftjw3DckzyT2bB-5icaqE=Q@mail.gmail.com>
Subject: Re: KASAN: invalid-free in iowarrior_disconnect
To:     syzbot <syzbot+68a449e448766880a109@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 4:48 PM syzbot
<syzbot+68a449e448766880a109@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d0847550 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=15fb03ba600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
> dashboard link: https://syzkaller.appspot.com/bug?extid=68a449e448766880a109
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+68a449e448766880a109@syzkaller.appspotmail.com
>
> usb 1-1: USB disconnect, device number 99
> ==================================================================
> BUG: KASAN: double-free or invalid-free in iowarrior_delete
> drivers/usb/misc/iowarrior.c:243 [inline]
> BUG: KASAN: double-free or invalid-free in iowarrior_disconnect+0x1f8/0x2c0
> drivers/usb/misc/iowarrior.c:894
>
> CPU: 1 PID: 3267 Comm: kworker/1:6 Not tainted 5.3.0-rc4+ #26
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   kasan_report_invalid_free+0x61/0xa0 mm/kasan/report.c:444
>   __kasan_slab_free+0x162/0x180 mm/kasan/common.c:428
>   slab_free_hook mm/slub.c:1423 [inline]
>   slab_free_freelist_hook mm/slub.c:1474 [inline]
>   slab_free mm/slub.c:3016 [inline]
>   kfree+0xe4/0x2f0 mm/slub.c:3957
>   iowarrior_delete drivers/usb/misc/iowarrior.c:243 [inline]
>   iowarrior_disconnect+0x1f8/0x2c0 drivers/usb/misc/iowarrior.c:894
>   usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
>   __device_release_driver drivers/base/dd.c:1134 [inline]
>   device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
>   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
>   device_del+0x420/0xb10 drivers/base/core.c:2339
>   usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
>   usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
>   hub_port_connect drivers/usb/core/hub.c:4949 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
>   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>   kthread+0x318/0x420 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
> Allocated by task 2745:
>   save_stack+0x1b/0x80 mm/kasan/common.c:69
>   set_track mm/kasan/common.c:77 [inline]
>   __kasan_kmalloc mm/kasan/common.c:487 [inline]
>   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
>   kmalloc include/linux/slab.h:557 [inline]
>   iowarrior_probe+0x526/0x10b2 drivers/usb/misc/iowarrior.c:800
>   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
>   really_probe+0x281/0x6d0 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
>   bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:894
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2165
>   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
>   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
>   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
>   really_probe+0x281/0x6d0 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
>   bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:894
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2165
>   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
>   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
>   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>   kthread+0x318/0x420 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
> Freed by task 4897:
>   save_stack+0x1b/0x80 mm/kasan/common.c:69
>   set_track mm/kasan/common.c:77 [inline]
>   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
>   slab_free_hook mm/slub.c:1423 [inline]
>   slab_free_freelist_hook mm/slub.c:1474 [inline]
>   slab_free mm/slub.c:3016 [inline]
>   kfree+0xe4/0x2f0 mm/slub.c:3957
>   iowarrior_delete drivers/usb/misc/iowarrior.c:243 [inline]
>   iowarrior_release+0x123/0x280 drivers/usb/misc/iowarrior.c:670
>   __fput+0x2d7/0x840 fs/file_table.c:280
>   task_work_run+0x13f/0x1c0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>   exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
>   prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
>   do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff8881da290558
>   which belongs to the cache kmalloc-8 of size 8
> The buggy address is located 0 bytes inside of
>   8-byte region [ffff8881da290558, ffff8881da290560)
> The buggy address belongs to the page:
> page:ffffea000768a400 refcount:1 mapcount:0 mapping:ffff8881da003900
> index:0xffff8881da290de0
> flags: 0x200000000000200(slab)
> raw: 0200000000000200 ffffea0007343c00 0000000600000006 ffff8881da003900
> raw: ffff8881da290de0 0000000080aa002f 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8881da290400: fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc
>   ffff8881da290480: fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb
> > ffff8881da290500: fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc
>                                                      ^
>   ffff8881da290580: fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc
>   ffff8881da290600: fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb
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

#syz dup: KASAN: use-after-free Read in iowarrior_disconnect

https://syzkaller.appspot.com/bug?id=c59a8f0485cd6634443cdf23cdbf3ea264dd888d
