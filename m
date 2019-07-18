Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719F7C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F66020880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmbqnD9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390297AbfGRMa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:30:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44676 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfGRMa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:30:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so12840846pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 05:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNI/YJaWkX8UYTrYkvZcLx6RHalepOZBtGLT3HE85xM=;
        b=tmbqnD9Z2jyZ1PMaE2PPWh8eLA6VTQPsy2gwcEbFdjZsyY5zyAV9SRbzaxoHwaECNY
         0AY71fm67vmhf0SIMYZh4JXFJHXoa2XdYvSzAe8FRLd08zQtPNKfIcWZI14NfGUjtGul
         x3gLQyvIHZnuN+DnL2PKDuB3Y2pluW7q6DLQDlcXTu6ery2CGb89mK9HqApYaWnFmKIo
         V2CaMaJml90z94CKs3rAALrMAw7KNLBqaS4FVlKx63XAAVfGZK3XGC3BgeFFcaIsx2CA
         3YBWkSiU3pAkFz4GXRgJvPji4AtwORwuoIAnfXHXdmPZUOfhDTMSTi0UPPEvQsN9F7mS
         2AvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNI/YJaWkX8UYTrYkvZcLx6RHalepOZBtGLT3HE85xM=;
        b=tMoICd3jZViLdof78byTm10esNJIObl7soVA0uZXopaGDugXkkg9nYIeR4lVDHQdJl
         r+GhsfD5rBnKpPZe3ovhcCObUIzv8+BYqlvERDBg3vikACHv84aQE1Js1LMvQiyiSMOV
         UpamiBzbcSje/YT8GYT3MGhKS8w7VlhGaNxDATxZaVh2FZGJrCpr8Z9OK97dHhsjjs4I
         JU7ivujfhX4QiMdkQIHjXnJ355LKwICWVqUj8tMt97lbLUlW+1GqrRjFbP86FH34l5dN
         uwdCJhkOhMsHmRwvjaWc7C6XQM51xJur6TME9V+t2icoNo3AQyl9sqMjWoaZ4C9WgA6K
         9whQ==
X-Gm-Message-State: APjAAAXBOu9GvdTSvVrh7cURHHXMXiHbNruqQOoCA98SnOTdFVbyRyco
        KUmimG6P+evktIJyZWfiN4W67kp1qQCrDtcMr/zC4V7WGYM=
X-Google-Smtp-Source: APXvYqzwFskv0W8U7KSgufW5eWmQzcYdRC6ElGBUjTN0Tq/oISZutchUB/HHo7kibgWzx7x5hfc8+8+ufcUb5zuzjAk=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr47271992pgq.130.1563453026280;
 Thu, 18 Jul 2019 05:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d06dc2058dc9f8f2@google.com>
In-Reply-To: <000000000000d06dc2058dc9f8f2@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 18 Jul 2019 14:30:15 +0200
Message-ID: <CAAeHK+y03vvKOnP4FpAhs7UACoDotyz-GQVZ52YEEio+D48rcQ@mail.gmail.com>
Subject: Re: WARNING in shark_write_reg/usb_submit_urb
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 4:17 PM Hillf Danton <hdanton@sina.com> wrote:
>
>
> Hello,
>
> On Tue, 16 Jul 2019 03:38:05 -0700 (PDT)
> > syzbot found the following crash on:
> >
> > HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=111fc400600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d90745bdf884fc0a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4b3f8190f6e13b3efd74
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10784148600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d826a4600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com
> >
> > usb 1-1: string descriptor 0 read error: -22
> > usb 1-1: New USB device found, idVendor=077d, idProduct=627a, bcdDevice=
> > 0.10
> > usb 1-1: New USB device strings: Mfr=63, Product=5, SerialNumber=1
> > ------------[ cut here ]------------
> > usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> > WARNING: CPU: 1 PID: 22 at drivers/usb/core/urb.c:477
> > usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #14
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   panic+0x292/0x6c9 kernel/panic.c:219
> >   __warn.cold+0x20/0x4b kernel/panic.c:576
> >   report_bug+0x262/0x2a0 lib/bug.c:186
> >   fixup_bug arch/x86/kernel/traps.c:179 [inline]
> >   fixup_bug arch/x86/kernel/traps.c:174 [inline]
> >   do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
> >   do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
> >   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
> > RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> > Code: 4d 85 ed 74 2c e8 c8 69 e8 fd 4c 89 f7 e8 f0 c4 12 ff 41 89 d8 44 89
> > e1 4c 89 ea 48 89 c6 48 c7 c7 60 3a 1a 86 e8 53 2e be fd <0f> 0b e9 20 f4
> > ff ff e8 9c 69 e8 fd 4c 89 f2 48 b8 00 00 00 00 00
> > RSP: 0018:ffff8881d9f96f58 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3f2ddd
> > RBP: ffff8881cf557590 R08: ffff8881d9f88000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> > R13: ffff8881d0c77000 R14: ffff8881d553cd20 R15: ffff8881d5123b00
> >   usb_start_wait_urb+0x108/0x2b0 drivers/usb/core/message.c:57
> >   usb_bulk_msg+0x228/0x550 drivers/usb/core/message.c:253
> >   shark_write_reg+0x1ef/0x2b0 drivers/media/radio/radio-shark2.c:88
>
> Based on
> drivers/media/radio/radio-shark2.c:88 and
> drivers/usb/core/message.c:245
>
> I say that the warning reported is bogus.
>
> A similar one can be found at
> https://lore.kernel.org/lkml/CAAeHK+zO6s5zWmz_QP6HiXd81Q217X6Viua+v1HkyXiowS_2Sg@mail.gmail.com/

Hi Hilf,

As I replied to you in this other thread, this report is not bogus and
points to a missing endpoint type check in the driver. I've just made
sure that this report is produced on a stock Linux host by using a
hardware reproducer for this bug.

Thanks!

>
> >   radio_tea5777_set_freq+0x1ed/0x470 drivers/media/radio/radio-tea5777.c:213
> >   radio_tea5777_init+0xb7/0x600 drivers/media/radio/radio-tea5777.c:544
> >   usb_shark_probe+0x5b9/0x740 drivers/media/radio/radio-shark2.c:318
> >   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
> >   really_probe+0x281/0x660 drivers/base/dd.c:509
> >   driver_probe_device+0x104/0x210 drivers/base/dd.c:670
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:843
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2111
> >   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
> >   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
> >   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
> >   really_probe+0x281/0x660 drivers/base/dd.c:509
> >   driver_probe_device+0x104/0x210 drivers/base/dd.c:670
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:843
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2111
> >   usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2536
> >   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1b3d/0x35f0 drivers/usb/core/hub.c:5441
> >   process_one_work+0x905/0x1570 kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> >   kthread+0x30b/0x410 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> >
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d06dc2058dc9f8f2%40google.com.
> For more options, visit https://groups.google.com/d/optout.
