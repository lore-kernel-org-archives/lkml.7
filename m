Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED306C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6F420651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfG3OKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:10:06 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37950 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728827AbfG3OKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:10:06 -0400
Received: (qmail 2766 invoked by uid 2102); 30 Jul 2019 10:10:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jul 2019 10:10:05 -0400
Date:   Tue, 30 Jul 2019 10:10:05 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb
In-Reply-To: <000000000000161dc3058ed0777c@google.com>
Message-ID: <Pine.LNX.4.44L0.1907301007000.1507-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=12386cb4600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> dashboard link: https://syzkaller.appspot.com/bug?extid=a7a6b9c609b9457c62c6
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> usb 2-1: BOGUS urb xfer, pipe 2 != type 2
> WARNING: CPU: 0 PID: 3730 at drivers/usb/core/urb.c:477  
> usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 3730 Comm: syz-executor.1 Not tainted 5.2.0-rc6+ #15
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
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
> RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> Code: 4d 85 ed 74 2c e8 f8 d3 f4 fd 4c 89 f7 e8 a0 51 1c ff 41 89 d8 44 89  
> e1 4c 89 ea 48 89 c6 48 c7 c7 00 0e f7 85 e8 83 98 ca fd <0f> 0b e9 20 f4  
> ff ff e8 cc d3 f4 fd 4c 89 f2 48 b8 00 00 00 00 00
> RSP: 0018:ffff8881d4f479d0 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
> RDX: 0000000000005dfa RSI: ffffffff8127ef3d RDI: ffffed103a9e8f2c
> RBP: 0000000000000000 R08: ffff8881af663000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> R13: ffff8881d462ed38 R14: ffff8881d18f9a20 R15: ffff8881d80e1c00
>   usb_start_wait_urb+0x108/0x2b0 drivers/usb/core/message.c:57
>   usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
>   usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:152
>   usbhid_set_raw_report drivers/hid/usbhid/hid-core.c:917 [inline]
>   usbhid_raw_request+0x21f/0x640 drivers/hid/usbhid/hid-core.c:1265
>   hid_hw_raw_request include/linux/hid.h:1079 [inline]
>   hidraw_send_report+0x296/0x500 drivers/hid/hidraw.c:151
>   hidraw_ioctl+0x5b4/0xaf0 drivers/hid/hidraw.c:421
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   file_ioctl fs/ioctl.c:509 [inline]
>   do_vfs_ioctl+0xcda/0x12e0 fs/ioctl.c:696
>   ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
>   __do_sys_ioctl fs/ioctl.c:720 [inline]
>   __se_sys_ioctl fs/ioctl.c:718 [inline]
>   __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
>   do_syscall_64+0xb7/0x560 arch/x86/entry/common.c:301
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe

This is very strange.  It looks like the kernel is complaining that 2
!= 2.

A more likely explanation is a race in the usbhid driver.  If
usbhid_set_raw_report() gets called _after_ usbhid has been unbound
from the device and while the endpoint is being destroyed, we could get
something like this.

Perhaps one of Oliver's patches will also fix this.

Alan Stern

