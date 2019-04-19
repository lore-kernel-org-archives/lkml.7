Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0BC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3524D205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfDSU3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:29:34 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:32972 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725878AbfDSU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:29:33 -0400
Received: (qmail 8731 invoked by uid 2102); 19 Apr 2019 16:29:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Apr 2019 16:29:32 -0400
Date:   Fri, 19 Apr 2019 16:29:32 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+53f029db71c19a47325a@syzkaller.appspotmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
cc:     andreyknvl@google.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <wen.yang99@zte.com.cn>
Subject: Re: general protection fault in smsusb_init_device
In-Reply-To: <0000000000008d89900586ccd37b@google.com>
Message-ID: <Pine.LNX.4.44L0.1904191624050.1406-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d34f9519 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=128ec3fd200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
> dashboard link: https://syzkaller.appspot.com/bug?extid=53f029db71c19a47325a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16138e67200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128dddbf200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+53f029db71c19a47325a@syzkaller.appspotmail.com
> 
> usb 1-1: config 0 descriptor??
> usb 1-1: string descriptor 0 read error: -71
> smsusb:smsusb_probe: board id=18, interface number 0
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI
> CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.1.0-rc5-319617-gd34f951 #4
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:smsusb_init_device+0x366/0x937  
> drivers/media/usb/siano/smsusb.c:429
> Code: 48 c1 ea 03 80 3c 02 00 74 05 e8 24 1e 66 f7 4d 8b b6 f0 04 00 00 b8  
> ff ff 37 00 48 c1 e0 2a 49 8d 7e 04 48 89 fa 48 c1 ea 03 <8a> 14 02 48 89  
> f8 83 e0 07 ff c0 38 d0 7c 09 84 d2 74 05 e8 b1 1d
> RSP: 0018:ffff8880a86570d0 EFLAGS: 00010247
> RAX: dffffc0000000000 RBX: ffff88809a81b300 RCX: ffffffff8a42b5b3
> RDX: 0000000000000000 RSI: ffffffff8a42b6a3 RDI: 0000000000000004
> RBP: ffff88808ca70000 R08: ffff8880a8503100 R09: ffff8880a8657130
> R10: ffffed10150cae34 R11: ffff8880a86571a7 R12: ffff88809a81be54
> R13: ffff88809a81be5c R14: 0000000000000000 R15: ffff88808ca70000
> FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1ad259d000 CR3: 000000009a3aa000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   smsusb_probe+0xd64/0xe08 drivers/media/usb/siano/smsusb.c:570

The reason for this bug is clear.  The code in smsusb_probe() at line
429 does this:

		dev->response_alignment =
		    le16_to_cpu(dev->udev->ep_in[1]->desc.wMaxPacketSize) -
		    sizeof(struct sms_msg_hdr);

which assumes there really is an ep1-IN endpoint.  If there isn't, the 
code crashes.

Testing that the endpoint exists is easy enough, but I'm not sure how 
this test should be integrated with the rest of the function.  Someone 
who knows the code better ought to be able to do it with no trouble.

Alan Stern

