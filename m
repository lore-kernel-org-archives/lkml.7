Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6929BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B75520891
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1nTY8lI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfKSNdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:33:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36971 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfKSNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:33:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id bb5so11776522plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 05:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJwVIsRx3AazC18GtEPRsLmuOqGwQRmE+0eQ3O5nq0w=;
        b=s1nTY8lIAmSwKqbsnP/zO1Qtk0Q6pZ7MsmpAv4Us4+AlTpFfQcUqJGyAQQK7Q1aH8E
         +AJtV6B4l/dGQ7c1swwfSXZYtwUS5KWCgd/Xs3p6pwIqYhS3qkx/anVSbKsDBQWrYQiP
         g8d3TzuWQEoyCmWQh0scuODR+ZBEMV90nJru6HAuuut707l0lu0s76oY4UqsgMon7Y7f
         6oFe6CJY6p2Pnsf0NfvTOSYhEUEHxliatE5nxmgmJqeAisOHpKn+6mvstuAE2iFYBEgP
         /8d9N9oxajG2CnKa3blysQbEHsuSXgyglAFnvP8+uPPceNGBW7FspjmxMrLDFlEdysDM
         0tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJwVIsRx3AazC18GtEPRsLmuOqGwQRmE+0eQ3O5nq0w=;
        b=QkOAca4uJ0litOqbwCWjF3a0pvEVAlzUInasijydz+KzwVIpbM543mvr+RSSRsXnlS
         7+UNhj5gXsNyAtuBOCO4/vYIHmGrsXgqFpTNUKllRF8pmFJqHT6/SFLhO5za+k6mtj5M
         PNKvpDC+FLN4Zl40Q8oHZC9L06vnf+0gHmvrIVVWK7wcmyRfgcnxebcqRFnnwhq2zHFW
         oRZZregjebp3JjBqa5vma5BwKRjGuaO/xlXg+/yD0Pq2lY94QS+X/N1LKj0WOJ+8LRfh
         +SymcaTDIwnHQgxzQeNiBoXJQppdkCZDDfSfqHOG85p6EoiLHBL47ayx7cQq71k2qGh/
         yuqA==
X-Gm-Message-State: APjAAAXaH6HBXkmLUsyx7OeihyCuvYdrgKqZQbZkFxPZqmAJ49XOj5EC
        29Gce5BaqBYOgEFtijl1ECUvMUJxZZNHwOZbqQiNuUjhk/s=
X-Google-Smtp-Source: APXvYqygC5QgVi6scwq1SsK5M2ZG6A0RvZmIHZlXlYYMsAhejCNKfjmbCP9HTKyv2i4mF4qDlkimVavZrbMl24oYCGc=
X-Received: by 2002:a17:90a:35d0:: with SMTP id r74mr6485311pjb.47.1574170427315;
 Tue, 19 Nov 2019 05:33:47 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a901ed058d51adc3@google.com>
In-Reply-To: <000000000000a901ed058d51adc3@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Nov 2019 14:33:34 +0100
Message-ID: <CAAeHK+xEqkHCmnu8e0MJ63DCQ4dqi0zneoL6wffzRe4jw30SWA@mail.gmail.com>
Subject: Re: WARNING in iforce_get_id_packet/usb_submit_urb
To:     syzbot <syzbot+9584b712baf1965b590c@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 1:07 PM syzbot
<syzbot+9584b712baf1965b590c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b6b3f8600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
> dashboard link: https://syzkaller.appspot.com/bug?extid=9584b712baf1965b590c
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d09e28600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1410e1f7a00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9584b712baf1965b590c@syzkaller.appspotmail.com
>
> usb 1-1: config 0 interface 47 altsetting 0 bulk endpoint 0x8A has invalid
> maxpacket 0
> usb 1-1: New USB device found, idVendor=061c, idProduct=c0a4,
> bcdDevice=4e.a0
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> ------------[ cut here ]------------
> URB 0000000044363614 submitted while active
> WARNING: CPU: 0 PID: 12 at drivers/usb/core/urb.c:362
> usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:362
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc6+ #13
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   panic+0x292/0x6c9 kernel/panic.c:219
>   __warn.cold+0x20/0x4b kernel/panic.c:576
>   report_bug+0x262/0x2a0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
>   do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
> RIP: 0010:usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:362
> Code: 89 de e8 72 dd e8 fd 84 db 0f 85 42 f6 ff ff e8 35 dc e8 fd 4c 89 fe
> 48 c7 c7 00 23 1a 86 c6 05 4b 78 57 04 01 e8 ca a0 be fd <0f> 0b e9 20 f6
> ff ff c7 44 24 14 01 00 00 00 e9 d7 f6 ff ff 41 bd
> RSP: 0018:ffff8881d9e0f010 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3c1df4
> RBP: ffff8881d4b67d00 R08: ffff8881d9df9800 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881cf2c9980
> R13: 00000000fffffff0 R14: ffffffff862df820 R15: ffff8881d4b67d00
>   iforce_get_id_packet+0x19c/0x52c
> drivers/input/joystick/iforce/iforce-packets.c:238
>   iforce_init_device+0x391/0x138d
> drivers/input/joystick/iforce/iforce-main.c:293
>   iforce_usb_probe+0x97c/0xd90 drivers/input/joystick/iforce/iforce-usb.c:163
>   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
>   really_probe+0x281/0x660 drivers/base/dd.c:509
>   driver_probe_device+0x104/0x210 drivers/base/dd.c:670
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:843
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2111
>   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
>   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
>   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
>   really_probe+0x281/0x660 drivers/base/dd.c:509
>   driver_probe_device+0x104/0x210 drivers/base/dd.c:670
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:843
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2111
>   usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
>   hub_port_connect drivers/usb/core/hub.c:5089 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
>   port_event drivers/usb/core/hub.c:5350 [inline]
>   hub_event+0x1ada/0x3590 drivers/usb/core/hub.c:5432
>   process_one_work+0x905/0x1570 kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>   kthread+0x30b/0x410 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
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
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz dup: WARNING in __iforce_usb_xmit/usb_submit_urb
