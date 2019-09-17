Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64934C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BAA21897
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+xRrcAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfIQMVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:21:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39503 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfIQMVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:21:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id i1so2069977pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BRlkDiRVpYHDuvyTB4ajOSpeeuxZXo5KFyEK1n6laU=;
        b=n+xRrcAxRqHVDzDR8635HzhcaJc9SQ5a/X+xP5vM+yGZVFp7VNLWK02OxrDd1G45x3
         b2+4l08qr1pXwzGWdMejaAU5FsvShMnP1RxUBt8V45ojCcED5nGW2ZSu0vfKTT/Fe475
         rHMifPXiXzTCUdF2lZaxw/ErXTv+9WLWAZ4PG1FywT2//+Jy2guEoNey0v9ekNlvftQ+
         QxGaHvCV3SQ+toXL9oQUUZd0CbuFHQg0mADO/1tcJkPSFuP5OwrTJqBPiKlDnCQ42cg5
         KK6dhqG1ARgtYEvOCSmzVVIVnyYPRSwi6VcjNZUIRSUWhbTDkfxGskWp1HQdNL8kM/Uu
         l5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BRlkDiRVpYHDuvyTB4ajOSpeeuxZXo5KFyEK1n6laU=;
        b=P1gRzeZOZGlI+eF/KujjRkiUC+jeTEavxC99KYGEJFGAWjCZye3qxJHyiOi3yKAlBJ
         xs7rr2pSVVTDczVpiCQPEawktyt8HDQF1DsgRBn6qsW/hPacm5sHA/z4oX+NliuDFF3Q
         ahj7DgfP0khkZIt1MSk9H2lxj8bSUSXx4G1/7zwJyG3vbgBJs7xVHUdo4pZ1FZpWVLOU
         vGVXFZstWgpP8KPwQ31fxdbuEzjcI16+IHUuwH+GvKmFpgidzRno4Ze6tfrB9+qcoIml
         FgakQL1JJ72JTLaDJrFxUa2bi0H1PxKXPxzQvApbxnwyIf75KEYt5sA4vuuYzXTjLbEA
         57tA==
X-Gm-Message-State: APjAAAV/wqiyB+O4Vi9ZuwJuKltemv067qsmcuYvF0IWISaAj0OQGGTd
        jfUhzpl76rOd84CmOSbAIHKIGEaaGlsSxxQ97hNzgw==
X-Google-Smtp-Source: APXvYqz85P2t1gk6XbriGFr+HUaiGczYquTiq8YyL69AsLE8BXdF4U6nsNjDL862ow7ePc6f/hPNV9XSNJ31zR1l0W8=
X-Received: by 2002:a17:90a:1990:: with SMTP id 16mr4585471pji.47.1568722904678;
 Tue, 17 Sep 2019 05:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000361fc90592b00fa4@google.com>
In-Reply-To: <000000000000361fc90592b00fa4@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 17 Sep 2019 14:21:33 +0200
Message-ID: <CAAeHK+wOgbfLHz=1DXG+UxZZNG+N7=nWYAwmE3PHR4Hk2rmxsg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ld_usb_read
To:     syzbot <syzbot+2a4f0b034e05c34252d0@syzkaller.appspotmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, enric.balletbo@collabora.com,
        Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kirr@nexedi.com, LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, lkundrak@v3.sk,
        logang@deltatee.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 8:49 PM syzbot
<syzbot+2a4f0b034e05c34252d0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    014077b5 DO-NOT-SUBMIT: usb-fuzzer: main usb gadget fuzzer..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=1510d63a600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
> dashboard link: https://syzkaller.appspot.com/bug?extid=2a4f0b034e05c34252d0
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13887b71600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14761d99600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2a4f0b034e05c34252d0@syzkaller.appspotmail.com
>
> ldusb 4-1:0.28: Read buffer overflow, -414328874449497579 bytes dropped
> ==================================================================
> BUG: KMSAN: uninit-value in _copy_to_user+0x1aa/0x1f0 lib/usercopy.c:29
> CPU: 0 PID: 12202 Comm: syz-executor155 Not tainted 5.3.0-rc7+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>   kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
>   __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
>   _copy_to_user+0x1aa/0x1f0 lib/usercopy.c:29
>   copy_to_user include/linux/uaccess.h:174 [inline]
>   ld_usb_read+0x58d/0xc40 drivers/usb/misc/ldusb.c:495
>   __vfs_read+0x1a9/0xc90 fs/read_write.c:425
>   vfs_read+0x359/0x6f0 fs/read_write.c:461
>   ksys_read+0x265/0x430 fs/read_write.c:587
>   __do_sys_read fs/read_write.c:597 [inline]
>   __se_sys_read+0x92/0xb0 fs/read_write.c:595
>   __x64_sys_read+0x4a/0x70 fs/read_write.c:595
>   do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:297
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x441839
> Code: e8 8c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd47c58b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441839
> RDX: 0000001788000335 RSI: 0000000020000140 RDI: 0000000000000004
> RBP: 0000000000017997 R08: 000000000000000f R09: 00000009004002c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402590
> R13: 0000000000402620 R14: 0000000000000000 R15: 0000000000000000
>
> Uninit was created at:
>   kmsan_save_stack_with_flags+0x37/0x70 mm/kmsan/kmsan.c:189
>   kmsan_internal_alloc_meta_for_pages+0x123/0x510 mm/kmsan/kmsan_hooks.c:114
>   kmsan_alloc_page+0x7a/0xf0 mm/kmsan/kmsan_hooks.c:244
>   __alloc_pages_nodemask+0x142d/0x5fa0 mm/page_alloc.c:4757
>   alloc_pages_current+0x68d/0x9a0 mm/mempolicy.c:2153
>   alloc_pages include/linux/gfp.h:511 [inline]
>   kmalloc_order mm/slab_common.c:1257 [inline]
>   kmalloc_order_trace+0x87/0x320 mm/slab_common.c:1269
>   kmalloc_large include/linux/slab.h:485 [inline]
>   __kmalloc+0x2e6/0x430 mm/slub.c:3823
>   kmalloc_array+0x86/0x110 include/linux/slab.h:676
>   ld_usb_probe+0x650/0x1650 drivers/usb/misc/ldusb.c:700
>   usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
>   really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
>   driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
>   __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
>   bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
>   __device_attach+0x489/0x750 drivers/base/dd.c:882
>   device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
>   bus_probe_device+0x131/0x390 drivers/base/bus.c:514
>   device_add+0x25b5/0x2df0 drivers/base/core.c:2165
>   usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
>   generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
>   usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
>   really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
>   driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
>   __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
>   bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
>   __device_attach+0x489/0x750 drivers/base/dd.c:882
>   device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
>   bus_probe_device+0x131/0x390 drivers/base/bus.c:514
>   device_add+0x25b5/0x2df0 drivers/base/core.c:2165
>   usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
>   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
>   process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
>   worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
>   kthread+0x4b5/0x4f0 kernel/kthread.c:256
>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
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
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000361fc90592b00fa4%40google.com.

Need to wait until all HID fixes are upstream, before we can actually
tell if this is a new issue or not. Duping to the Logitech bug for
now.

#syz dup: general protection fault in __pm_runtime_resume
