Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8D5CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EE72070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409561AbfJXPE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:04:28 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56528 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2407327AbfJXPE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:04:27 -0400
Received: (qmail 3185 invoked by uid 2102); 24 Oct 2019 11:04:26 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Oct 2019 11:04:26 -0400
Date:   Thu, 24 Oct 2019 11:04:26 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com>
cc:     Jacky.Cao@sony.com, <andreyknvl@google.com>, <balbi@kernel.org>,
        <chunfeng.yun@mediatek.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: divide error in dummy_timer
In-Reply-To: <0000000000004f221d0595a86c33@google.com>
Message-ID: <Pine.LNX.4.44L0.1910241053590.1676-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e2fda7600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fe29bc39eff9627
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ab8bf161038a8768553
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f664e4e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14674000e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com
> 
> divide error: 0000 [#1] SMP KASAN
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> RIP: 0010:transfer drivers/usb/gadget/udc/dummy_hcd.c:1426 [inline]
> RIP: 0010:dummy_timer+0xad5/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1950
> Code: 0f 84 f5 fd ff ff e8 8a 55 ab fd 89 de 44 89 e7 e8 70 56 ab fd 41 39  
> dc 0f 82 b0 08 00 00 e8 72 55 ab fd 44 89 e0 31 d2 31 ff <f7> f3 89 d6 89  
> 94 24 c0 00 00 00 e8 cb 56 ab fd 8b 94 24 c0 00 00
> RSP: 0018:ffff8881db209b20 EFLAGS: 00010046
> RAX: 0000000000000040 RBX: 0000000000000000 RCX: ffffffff8392c330
> RDX: 0000000000000000 RSI: ffffffff8392c33e RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff86c2b200 R09: ffffed103b641353
> R10: ffffed103b641352 R11: 0000000000000003 R12: 0000000000000040
> R13: ffff8881d58c0000 R14: dffffc0000000000 R15: ffff8881d78d5a00
> FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb771a61000 CR3: 00000001d2295000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   call_timer_fn+0x179/0x650 kernel/time/timer.c:1404
>   expire_timers kernel/time/timer.c:1449 [inline]
>   __run_timers kernel/time/timer.c:1773 [inline]
>   __run_timers kernel/time/timer.c:1740 [inline]
>   run_timer_softirq+0x5e3/0x1490 kernel/time/timer.c:1786
>   __do_softirq+0x221/0x912 kernel/softirq.c:292
>   invoke_softirq kernel/softirq.c:373 [inline]
>   irq_exit+0x178/0x1a0 kernel/softirq.c:413
>   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>   smp_apic_timer_interrupt+0x12f/0x500 arch/x86/kernel/apic/apic.c:1137
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
>   </IRQ>
> RIP: 0010:default_idle+0x28/0x2e0 arch/x86/kernel/process.c:581
> Code: 90 90 41 56 41 55 65 44 8b 2d f4 00 92 7a 41 54 55 53 0f 1f 44 00 00  
> e8 c6 b2 d3 fb e9 07 00 00 00 0f 00 2d ea a5 52 00 fb f4 <65> 44 8b 2d d0  
> 00 92 7a 0f 1f 44 00 00 5b 5d 41 5c 41 5d 41 5e c3
> RSP: 0018:ffffffff86c07da8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000007 RBX: ffffffff86c2b200 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffff86c2ba4c
> RBP: fffffbfff0d85640 R08: ffffffff86c2b200 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   cpuidle_idle_call kernel/sched/idle.c:154 [inline]
>   do_idle+0x3b6/0x500 kernel/sched/idle.c:263
>   cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:355
>   start_kernel+0x82a/0x864 init/main.c:784
>   secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
> Modules linked in:
> ---[ end trace 02e2d9c7c53d85a5 ]---
> RIP: 0010:transfer drivers/usb/gadget/udc/dummy_hcd.c:1426 [inline]
> RIP: 0010:dummy_timer+0xad5/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1950
> Code: 0f 84 f5 fd ff ff e8 8a 55 ab fd 89 de 44 89 e7 e8 70 56 ab fd 41 39  
> dc 0f 82 b0 08 00 00 e8 72 55 ab fd 44 89 e0 31 d2 31 ff <f7> f3 89 d6 89  
> 94 24 c0 00 00 00 e8 cb 56 ab fd 8b 94 24 c0 00 00
> RSP: 0018:ffff8881db209b20 EFLAGS: 00010046
> RAX: 0000000000000040 RBX: 0000000000000000 RCX: ffffffff8392c330
> RDX: 0000000000000000 RSI: ffffffff8392c33e RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff86c2b200 R09: ffffed103b641353
> R10: ffffed103b641352 R11: 0000000000000003 R12: 0000000000000040
> R13: ffff8881d58c0000 R14: dffffc0000000000 R15: ffff8881d78d5a00
> FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb771a61000 CR3: 00000001d2295000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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

Is this really the sort of thing we need to catch?  It isn't a bug in
any existing kernel code, as far as I know.  Maybe only gadgetfs and 
configfs need to worry about it.

Alan Stern

#syz test: https://github.com/google/kasan.git 22be26f7

 drivers/usb/gadget/udc/dummy_hcd.c |    2 ++
 1 file changed, 2 insertions(+)

Index: usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/udc/dummy_hcd.c
+++ usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
@@ -522,6 +522,8 @@ static int dummy_enable(struct usb_ep *_
 	 * For SS devices the wMaxPacketSize is limited by 1024.
 	 */
 	max = usb_endpoint_maxp(desc);
+	if (max == 0)
+		return -EINVAL;
 
 	/* drivers must not request bad settings, since lower levels
 	 * (hardware or its drivers) may not check.  some endpoints

