Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C5D21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ta4janmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442214AbfJRJeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:34:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38383 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfJRJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:34:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so8151342qta.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pE1CurwBz5WOK/o7RHgRSfOlxAfMbJGYVS5GAQqtQnM=;
        b=Ta4janmUpPHvzLRibRX0UjcZdCJXuOa21yDABoT12e1FR94459ebZ8RGYR09Uuoqzb
         qMqyxx/gqckZBg8AB4f0/gfjpQ2Ub5owrI43O2NUxEU4Gg3u2rs5MRyjEeK3FRzorNF8
         rO6lqwWtWczKmMEnopyLR5u3rBrRJ7XfUiUm6xJRueGTh24TI1yE+rDolJSo8pLhFMr3
         at8NdjjnQfodeWjiNE9LkfGFyS1EeSRlVXwACU+pln0FLCiBBsL66hNpH8xkk1dk0QNd
         KFDBLhbV06muAXnUt90vPatURRsD7ne3hQqZqvP6rzhMZAVZnw0LZq2ppGBFggsScFmN
         jbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pE1CurwBz5WOK/o7RHgRSfOlxAfMbJGYVS5GAQqtQnM=;
        b=qFYkjNjVOUeTg7vTfdSS4p0RsfypwEznlNv910DR8j0W0FhfHlcxen3buzfUI603ai
         MNoyCtSjgvA09etUuqNY7C7TBm4o2Kq1Rn62t3jXI2KAnCgo/iwTuA2DSvRZShzv2zIr
         zsny8JbhRaXGEdN1eJOMhO+zGv3EfkUC7Ky3o0OLHeEEaZTCqau7rZyQsk19Cv3BVAm6
         tuIQx4mMy/eyWw48kYZ+MILlYKmPtffnPefYa+0WFTot1A8ART8F5hp/RpH5ekKCtoiN
         5E8bYYbxJK033P9A6hxaFJmBS5381W2ejZi8iIM7qJuMXGWRBi5kOVMoRCieS/ePdiDw
         XLgw==
X-Gm-Message-State: APjAAAWdK2egXT+cEyDvu+GAcGnj24iSuDDvN3FlsRz9NhIC/pAARjha
        V7oMVlOTTleQK93YMNTL7MHGThxqgRWgGlF7LB0MsQ==
X-Google-Smtp-Source: APXvYqwPVEJQ3WduZvVjVj+X5eckRpyLUSjGJlSiTXoBE2or+OtRK0PrvPkYm/MMJQ4O9EeUMjAU85WJs3IWc5nrkTg=
X-Received: by 2002:a0c:c3c5:: with SMTP id p5mr8755561qvi.34.1571391238265;
 Fri, 18 Oct 2019 02:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <CALRZ7UuS10CvHvDxMyFyN_wZF_xvzrABT-E_NRt1jKKtXk6Rng@mail.gmail.com>
In-Reply-To: <CALRZ7UuS10CvHvDxMyFyN_wZF_xvzrABT-E_NRt1jKKtXk6Rng@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 18 Oct 2019 11:33:46 +0200
Message-ID: <CACT4Y+YxieAS3QrFk9ON6FiYnFzMO_CyzZBo9iTX25fLGzDj+g@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in del_timer
To:     zzoru <zzoru007@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        usb-storage@lists.one-eyed-alien.net,
        LKML <linux-kernel@vger.kernel.org>, dokyungs@uci.edu,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:59 AM zzoru <zzoru007@gmail.com> wrote:
>
> We found the following crash on Linux 5.4-rc1 (Not patched in currnet
> HEAD commit 3b1f00aceb7a67bf079a5a64aa5c6baf78a8f442)
> with our customized syzkaller.

Hi zzoru,

Do you mind sharing what customizations you did to syzkaller? Are
these related to USB? I've noticed several reports were related to USB
subsystem.

> ODEBUG: assert_init not available (active state 0) object type:
> timer_list hint: 0x0
> WARNING: CPU: 0 PID: 141 at linux/lib/debugobjects.c:484
> debug_print_object+0x15e/0x220 linux/lib/debugobjects.c:481
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 141 Comm: kworker/0:3 Not tainted 5.4.0-rc1 #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  __dump_stack linux/lib/dump_stack.c:77 [inline]
>  dump_stack+0x7c/0xbb linux/lib/dump_stack.c:113
>  panic+0x205/0x48e linux/kernel/panic.c:220
>  __warn+0x19c/0x1c0 linux/kernel/panic.c:581
>  report_bug+0x1a9/0x2b0 linux/lib/bug.c:195
>  fixup_bug.part.11+0x32/0x80 linux/arch/x86/kernel/traps.c:179
>  fixup_bug linux/arch/x86/include/asm/irqflags.h:54 [inline]
>  do_error_trap+0xf5/0x160 linux/arch/x86/kernel/traps.c:272
>  do_invalid_op+0x31/0x40 linux/arch/x86/kernel/traps.c:291
>  invalid_op+0x23/0x30 linux/arch/x86/entry/entry_64.S:1028
> RIP: 0010:debug_print_object+0x15e/0x220 linux/lib/debugobjects.c:481
> Code: 3c dd 80 05 9a 85 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7f 48 8b
> 14 dd 80 05 9a 85 4c 89 ee 48 c7 c7 00 fb 99 85 e8 d2 a7 43 ff <0f> 0b
> 83 05 cd bd 70 05 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
> RSP: 0018:ffff888017017668 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000005 RCX: ffffffff814153b0
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801a41f730
> RBP: 0000000000000001 R08: ffffed1003483ee7 R09: ffffed1003483ee7
> R10: 0000000000000001 R11: ffffed1003483ee6 R12: ffffffff86908460
> R13: ffffffff859a01a0 R14: ffffffff812b6bc0 R15: ffff888017fb0420
>  debug_object_assert_init+0x290/0x430 linux/lib/debugobjects.c:866
>  debug_timer_assert_init linux/kernel/time/timer.c:729 [inline]
>  debug_assert_init linux/kernel/time/timer.c:774 [inline]
>  del_timer+0x67/0xf0 linux/kernel/time/timer.c:1196
>  realtek_cr_destructor+0x5a/0x90 linux/drivers/usb/storage/realtek_cr.c:937
>  usb_stor_release_resources linux/drivers/usb/storage/usb.c:817 [inline]
>  release_everything+0xc0/0x2c0 linux/drivers/usb/storage/usb.c:879
>  usb_unbind_interface+0x19f/0x810 linux/drivers/usb/core/driver.c:423
>  __device_release_driver linux/drivers/base/dd.c:1134 [inline]
>  device_release_driver_internal+0x429/0x4f0 linux/drivers/base/dd.c:1165
>  bus_remove_device+0x2d1/0x490 linux/drivers/base/bus.c:532
>  device_del+0x403/0xaa0 linux/drivers/base/core.c:2375
>  usb_disable_device+0x1d7/0x5f0 linux/drivers/usb/core/message.c:1237
>  usb_disconnect+0x25a/0x840 linux/drivers/usb/core/hub.c:2199
>  hub_port_connect linux/drivers/usb/core/hub.c:4949 [inline]
>  hub_port_connect_change linux/drivers/usb/core/hub.c:5213 [inline]
>  port_event linux/drivers/usb/core/hub.c:5359 [inline]
>  hub_event+0x11f5/0x3610 linux/drivers/usb/core/hub.c:5441
>  process_one_work+0x8b5/0x17c0 linux/kernel/workqueue.c:2269
>  worker_thread+0x82/0xb80 linux/kernel/workqueue.c:2415
>  kthread+0x325/0x3e0 linux/kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 linux/arch/x86/entry/entry_64.S:352
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
>
> Following is my analysis of this bug (Just add some comments in source code):
> https://github.com/torvalds/linux/blob/e0703556644a531e50b5dc61b9f6ea83af5f6604/drivers/usb/storage/realtek_cr.c#L887-L891
> static int realtek_cr_autosuspend_setup(struct us_data *us)
> {
>     ...
>     if (retval != STATUS_SUCCESS) {
>         usb_stor_dbg(us, "Read status fail\n");
>         return -EIO; // Error!
>     }
>     ...
>     timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn,
> 0); // rts51x_suspend_timer wasn't be initialized. When
> realtek_cr_autosuspend_setup just returns an error.
> }
>
>
> https://github.com/torvalds/linux/blob/e0703556644a531e50b5dc61b9f6ea83af5f6604/drivers/usb/storage/realtek_cr.c#L1010-L1012
>
> #ifdef CONFIG_REALTEK_AUTOPM
> if (ss_en)
>     realtek_cr_autosuspend_setup(us); // There isn't any check about
> return code.
> #endif
>
> https://github.com/torvalds/linux/blob/e0703556644a531e50b5dc61b9f6ea83af5f6604/drivers/usb/storage/realtek_cr.c#L936-L939
> static void realtek_cr_destructor(void *extra)
> {
>     ...
>     if (ss_en) {
>         del_timer(&chip->rts51x_suspend_timer); // Ouch! :(
>         chip->timer_expires = 0;
>     }
>     ...
> }
