Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE2C2396B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfE2ONF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:13:05 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55202 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727056AbfE2ONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:13:05 -0400
Received: (qmail 1762 invoked by uid 2102); 29 May 2019 10:13:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 May 2019 10:13:04 -0400
Date:   Wed, 29 May 2019 10:13:04 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in submit_rx_urb/usb_submit_urb
In-Reply-To: <0000000000004da71e058a06318b@google.com>
Message-ID: <Pine.LNX.4.44L0.1905291006110.1536-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=143d5972a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c309d28e15db39c5
> dashboard link: https://syzkaller.appspot.com/bug?extid=c2a1fa67c02faa0de723
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com
> 
> usb 2-1: Direct firmware load for prism2_ru.fw failed with error -2
> prism2_usb 2-1:0.191 (unnamed net_device) (uninitialized): prism2_usb:  
> Firmware not available, but not essential
> prism2_usb 2-1:0.191 (unnamed net_device) (uninitialized): prism2_usb: can  
> continue to use card anyway.
> ------------[ cut here ]------------
> usb 2-1: BOGUS urb xfer, pipe 3 != type 1
> WARNING: CPU: 0 PID: 5587 at drivers/usb/core/urb.c:477  
> usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 5587 Comm: kworker/0:2 Not tainted 5.2.0-rc1+ #9
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   panic+0x292/0x6df kernel/panic.c:218
>   __warn.cold+0x20/0x45 kernel/panic.c:575
>   report_bug+0x262/0x2a0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
>   do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
> RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> Code: 4d 85 ed 74 2c e8 b8 de e5 fd 4c 89 f7 e8 b0 7e 11 ff 41 89 d8 44 89  
> e1 4c 89 ea 48 89 c6 48 c7 c7 80 a3 17 86 e8 73 9b bb fd <0f> 0b e9 20 f4  
> ff ff e8 8c de e5 fd 4c 89 f2 48 b8 00 00 00 00 00
> RSP: 0018:ffff8881cb876f98 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 0000000000040000 RSI: ffffffff812824fd RDI: ffffed103970ede5
> RBP: ffff8881d33a5c00 R08: ffff8881cbf5b000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
> R13: ffff8881d2fa3918 R14: ffff8881d5feab20 R15: ffff8881d60e8008
>   submit_rx_urb+0x2e1/0x3e0 drivers/staging/wlan-ng/hfa384x_usb.c:353
>   hfa384x_drvr_start+0x1cb/0x420 drivers/staging/wlan-ng/hfa384x_usb.c:2484
>   prism2sta_ifstate+0x2ea/0x4a0 drivers/staging/wlan-ng/prism2sta.c:471
>   prism2sta_probe_usb.cold+0x1c8/0x49e  
> drivers/staging/wlan-ng/prism2usb.c:112

The problem is that hfa384x_create() in hfa384x_usb.c assumes ep1-IN
and ep2-OUT exist and are bulk endpoints, without actually checking.

Since this function does not return an error code, it's not clear how 
to respond when the expected endpoints do not exist.

Alan Stern

