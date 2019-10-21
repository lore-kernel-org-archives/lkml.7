Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB90BCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBCB2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAnf6DN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfJUHcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:32:14 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44076 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:32:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so11602670qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYy1/LrxYgUepstMy8ztXvJpwYGOSfKv6Ncg1+uVmSg=;
        b=NAnf6DN1LdnUJkuORHQl3vM9RWvqgsvaEScEAkiWAIfW9covbvp06qDeLpzocBwTwQ
         ZOO42HfViZMhbzoUV5PRGlItfYF2NujVeNv4jc8oZDLGr5tIntC9PZ0mZaY8oOX7R9iW
         +E3f+gXQpdtDZs2yCF7GSye0sQPmki++DJ++OZe9BUc5cD04QllfO25o45aGuMkrZdAN
         j/tXIJHC6ApNvsEi0PfaQwgd6NpgI2oECTLo+Q34sLEl+LdWKVubWY2a3Nl3y5koPiG2
         mUaiWm6l9nRl2CuDO1ZHORUoUvbAYqp2zwP2TxDicnM6ZjVvNyTcqQl4RBSsoZ92wZxj
         LTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYy1/LrxYgUepstMy8ztXvJpwYGOSfKv6Ncg1+uVmSg=;
        b=UZyqFFKfXKXuNJDv47JqJxLOqIeRc6c6aFqWKqGCYDVlD4s2uP5+D5F6qMYLVoQtU7
         d6+m162OIm4zdV9jqLPTei4t9CGPBJqKfXVtr5F7QcrWVoyS9gnnDhmtQLr0kaLAPmgo
         t8iVziXJhb4wVv31NAm8OGxygd7aqToigVlEJbD1YCt20Ik35qlF60vx3IQBalssv4EV
         2JehpE6k5BUiZCN5TyhoISF9pbryjdfjn7YRcT9M3wxxmyKR4Yz1Vke6/la42MpOtU52
         0SSFkr7Jtq3nRU4dw613QLCAf4ClNYjCtO1hSUeLPrdu5X6IPBZ67YTV7jt0PK30jHVS
         LzIQ==
X-Gm-Message-State: APjAAAW6QRB9hMCtH6+dxS/Cm0dnDVuVMOhcnP0hyltE1I6C1g8JGNQf
        u38qj4YAUFaSztOA4Qn7lBIWgX4cqJVZ7il/isyrVg==
X-Google-Smtp-Source: APXvYqy/FLbdKNrgK9P+aIODEkPEpmqv+KgCYbzQW8yo7HQznHSxGL3RI6LwSR90HaOz00MNtMb7taoUivccFhuGvgA=
X-Received: by 2002:a37:4a87:: with SMTP id x129mr20642441qka.43.1571643132113;
 Mon, 21 Oct 2019 00:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <CALRZ7UuS10CvHvDxMyFyN_wZF_xvzrABT-E_NRt1jKKtXk6Rng@mail.gmail.com>
 <CACT4Y+YxieAS3QrFk9ON6FiYnFzMO_CyzZBo9iTX25fLGzDj+g@mail.gmail.com> <CALRZ7Uvy_QQPPc6wgvDadxD6gemOmjpxCDpYPt=zsi9_1Xjvng@mail.gmail.com>
In-Reply-To: <CALRZ7Uvy_QQPPc6wgvDadxD6gemOmjpxCDpYPt=zsi9_1Xjvng@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Oct 2019 09:32:00 +0200
Message-ID: <CACT4Y+Z3PgnruKivBQPbD0-HEn_Hz7huQ0EHr2_7=RURjZwJ+A@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in del_timer
To:     zzoru <zzoru007@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        usb-storage@lists.one-eyed-alien.net,
        LKML <linux-kernel@vger.kernel.org>, dokyungs@uci.edu,
        syzkaller <syzkaller@googlegroups.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 1:36 AM zzoru <zzoru007@gmail.com> wrote:
>
> Hi
>
> The customizations are related to driver fuzzing.
> We added some more descriptions of USB driver & narrowed the
> constraints (targeted fuzzing).

Please consider upstreaming these improvements to syzkaller.

> And sorry about I have not much time to make patches of these bugs.
>
> On Fri, Oct 18, 2019 at 2:33 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Oct 16, 2019 at 11:59 AM zzoru <zzoru007@gmail.com> wrote:
> > >
> > > We found the following crash on Linux 5.4-rc1 (Not patched in currnet
> > > HEAD commit 3b1f00aceb7a67bf079a5a64aa5c6baf78a8f442)
> > > with our customized syzkaller.
> >
> > Hi zzoru,
> >
> > Do you mind sharing what customizations you did to syzkaller? Are
> > these related to USB? I've noticed several reports were related to USB
> > subsystem.
> >
> > > ODEBUG: assert_init not available (active state 0) object type:
> > > timer_list hint: 0x0
> > > WARNING: CPU: 0 PID: 141 at linux/lib/debugobjects.c:484
> > > debug_print_object+0x15e/0x220 linux/lib/debugobjects.c:481
> > > Kernel panic - not syncing: panic_on_warn set ...
> > > CPU: 0 PID: 141 Comm: kworker/0:3 Not tainted 5.4.0-rc1 #5
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > > Workqueue: usb_hub_wq hub_event
> > > Call Trace:
> > >  __dump_stack linux/lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x7c/0xbb linux/lib/dump_stack.c:113
> > >  panic+0x205/0x48e linux/kernel/panic.c:220
> > >  __warn+0x19c/0x1c0 linux/kernel/panic.c:581
> > >  report_bug+0x1a9/0x2b0 linux/lib/bug.c:195
> > >  fixup_bug.part.11+0x32/0x80 linux/arch/x86/kernel/traps.c:179
> > >  fixup_bug linux/arch/x86/include/asm/irqflags.h:54 [inline]
> > >  do_error_trap+0xf5/0x160 linux/arch/x86/kernel/traps.c:272
> > >  do_invalid_op+0x31/0x40 linux/arch/x86/kernel/traps.c:291
> > >  invalid_op+0x23/0x30 linux/arch/x86/entry/entry_64.S:1028
> > > RIP: 0010:debug_print_object+0x15e/0x220 linux/lib/debugobjects.c:481
> > > Code: 3c dd 80 05 9a 85 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7f 48 8b
> > > 14 dd 80 05 9a 85 4c 89 ee 48 c7 c7 00 fb 99 85 e8 d2 a7 43 ff <0f> 0b
> > > 83 05 cd bd 70 05 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
> > > RSP: 0018:ffff888017017668 EFLAGS: 00010282
> > > RAX: 0000000000000000 RBX: 0000000000000005 RCX: ffffffff814153b0
> > > RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801a41f730
> > > RBP: 0000000000000001 R08: ffffed1003483ee7 R09: ffffed1003483ee7
> > > R10: 0000000000000001 R11: ffffed1003483ee6 R12: ffffffff86908460
> > > R13: ffffffff859a01a0 R14: ffffffff812b6bc0 R15: ffff888017fb0420
> > >  debug_object_assert_init+0x290/0x430 linux/lib/debugobjects.c:866
> > >  debug_timer_assert_init linux/kernel/time/timer.c:729 [inline]
> > >  debug_assert_init linux/kernel/time/timer.c:774 [inline]
> > >  del_timer+0x67/0xf0 linux/kernel/time/timer.c:1196
> > >  realtek_cr_destructor+0x5a/0x90 linux/drivers/usb/storage/realtek_cr.c:937
> > >  usb_stor_release_resources linux/drivers/usb/storage/usb.c:817 [inline]
> > >  release_everything+0xc0/0x2c0 linux/drivers/usb/storage/usb.c:879
> > >  usb_unbind_interface+0x19f/0x810 linux/drivers/usb/core/driver.c:423
> > >  __device_release_driver linux/drivers/base/dd.c:1134 [inline]
> > >  device_release_driver_internal+0x429/0x4f0 linux/drivers/base/dd.c:1165
> > >  bus_remove_device+0x2d1/0x490 linux/drivers/base/bus.c:532
> > >  device_del+0x403/0xaa0 linux/drivers/base/core.c:2375
> > >  usb_disable_device+0x1d7/0x5f0 linux/drivers/usb/core/message.c:1237
> > >  usb_disconnect+0x25a/0x840 linux/drivers/usb/core/hub.c:2199
> > >  hub_port_connect linux/drivers/usb/core/hub.c:4949 [inline]
> > >  hub_port_connect_change linux/drivers/usb/core/hub.c:5213 [inline]
> > >  port_event linux/drivers/usb/core/hub.c:5359 [inline]
> > >  hub_event+0x11f5/0x3610 linux/drivers/usb/core/hub.c:5441
> > >  process_one_work+0x8b5/0x17c0 linux/kernel/workqueue.c:2269
> > >  worker_thread+0x82/0xb80 linux/kernel/workqueue.c:2415
> > >  kthread+0x325/0x3e0 linux/kernel/kthread.c:255
> > >  ret_from_fork+0x24/0x30 linux/arch/x86/entry/entry_64.S:352
> > > Dumping ftrace buffer:
> > >    (ftrace buffer empty)
> > > Kernel Offset: disabled
> > >
> > > Following is my analysis of this bug (Just add some comments in source code):
> > > https://github.com/torvalds/linux/blob/e0703556644a531e50b5dc61b9f6ea83af5f6604/drivers/usb/storage/realtek_cr.c#L887-L891
> > > static int realtek_cr_autosuspend_setup(struct us_data *us)
> > > {
> > >     ...
> > >     if (retval != STATUS_SUCCESS) {
> > >         usb_stor_dbg(us, "Read status fail\n");
> > >         return -EIO; // Error!
> > >     }
> > >     ...
> > >     timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn,
> > > 0); // rts51x_suspend_timer wasn't be initialized. When
> > > realtek_cr_autosuspend_setup just returns an error.
> > > }
> > >
> > >
> > > https://github.com/torvalds/linux/blob/e0703556644a531e50b5dc61b9f6ea83af5f6604/drivers/usb/storage/realtek_cr.c#L1010-L1012
> > >
> > > #ifdef CONFIG_REALTEK_AUTOPM
> > > if (ss_en)
> > >     realtek_cr_autosuspend_setup(us); // There isn't any check about
> > > return code.
> > > #endif
> > >
> > > https://github.com/torvalds/linux/blob/e0703556644a531e50b5dc61b9f6ea83af5f6604/drivers/usb/storage/realtek_cr.c#L936-L939
> > > static void realtek_cr_destructor(void *extra)
> > > {
> > >     ...
> > >     if (ss_en) {
> > >         del_timer(&chip->rts51x_suspend_timer); // Ouch! :(
> > >         chip->timer_expires = 0;
> > >     }
> > >     ...
> > > }
