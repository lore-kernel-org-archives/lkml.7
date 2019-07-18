Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDFC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC9920880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390448AbfGRONb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:13:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:50396 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727742AbfGRONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:13:30 -0400
Received: (qmail 2620 invoked by uid 2102); 18 Jul 2019 10:13:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jul 2019 10:13:29 -0400
Date:   Thu, 18 Jul 2019 10:13:29 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Hillf Danton <hdanton@sina.com>,
        Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in shark_write_reg/usb_submit_urb
In-Reply-To: <CAAeHK+y03vvKOnP4FpAhs7UACoDotyz-GQVZ52YEEio+D48rcQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1907181006360.1422-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019, Andrey Konovalov wrote:

> On Tue, Jul 16, 2019 at 4:17 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> >
> > Hello,
> >
> > On Tue, 16 Jul 2019 03:38:05 -0700 (PDT)
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=111fc400600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d90745bdf884fc0a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4b3f8190f6e13b3efd74
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10784148600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d826a4600000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com
> > >
> > > usb 1-1: string descriptor 0 read error: -22
> > > usb 1-1: New USB device found, idVendor=077d, idProduct=627a, bcdDevice=
> > > 0.10
> > > usb 1-1: New USB device strings: Mfr=63, Product=5, SerialNumber=1
> > > ------------[ cut here ]------------
> > > usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> > > WARNING: CPU: 1 PID: 22 at drivers/usb/core/urb.c:477
> > > usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> > > Kernel panic - not syncing: panic_on_warn set ...
> > > CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #14
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  Google 01/01/2011
> > > Workqueue: usb_hub_wq hub_event
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> > >   panic+0x292/0x6c9 kernel/panic.c:219
> > >   __warn.cold+0x20/0x4b kernel/panic.c:576
> > >   report_bug+0x262/0x2a0 lib/bug.c:186
> > >   fixup_bug arch/x86/kernel/traps.c:179 [inline]
> > >   fixup_bug arch/x86/kernel/traps.c:174 [inline]
> > >   do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
> > >   do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
> > >   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
> > > RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> > > Code: 4d 85 ed 74 2c e8 c8 69 e8 fd 4c 89 f7 e8 f0 c4 12 ff 41 89 d8 44 89
> > > e1 4c 89 ea 48 89 c6 48 c7 c7 60 3a 1a 86 e8 53 2e be fd <0f> 0b e9 20 f4
> > > ff ff e8 9c 69 e8 fd 4c 89 f2 48 b8 00 00 00 00 00
> > > RSP: 0018:ffff8881d9f96f58 EFLAGS: 00010282
> > > RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> > > RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3f2ddd
> > > RBP: ffff8881cf557590 R08: ffff8881d9f88000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> > > R13: ffff8881d0c77000 R14: ffff8881d553cd20 R15: ffff8881d5123b00
> > >   usb_start_wait_urb+0x108/0x2b0 drivers/usb/core/message.c:57
> > >   usb_bulk_msg+0x228/0x550 drivers/usb/core/message.c:253
> > >   shark_write_reg+0x1ef/0x2b0 drivers/media/radio/radio-shark2.c:88
> >
> > Based on
> > drivers/media/radio/radio-shark2.c:88 and
> > drivers/usb/core/message.c:245
> >
> > I say that the warning reported is bogus.

You have misunderstood the problem.

drivers/usb/core/message.c:245 allows drivers to call usb_bulk_msg()  
when the target is actually an interrupt endpoint.  The bug in this
case is that drivers/media/radio/radio-shark2.c:88 calls
usb_interrupt_msg() with an INTERRUPT pipe type when the target is
actually a bulk endpoint.

These are two different things.  It can make sense to use an interrupt 
endpoint, especially if a bulk endpoint is not available.  But the 
reverse does not make sense, because bulk endpoints do not provide the 
bandwidth guarantees that interrupt endpoints do.

Alan Stern

