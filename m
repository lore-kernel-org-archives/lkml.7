Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A30C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9CB23789
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfE2OIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:08:06 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:35152 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfE2OIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:08:06 -0400
Received: by mail-it1-f197.google.com with SMTP id m188so2019994ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 07:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZT9NVl7P92I+s83jnVhBn/W4UWjhmDLkpznnFNz26lA=;
        b=s9AU5omv+4vVb1N8Bj4EFC02u6Qn43iEvUAXQMVEpaRgdu8P8sPy6ZP/6j8DZZGT05
         4oe44+ubr+AWZ9Uu+c7ztr6dKz6ioVxC+xjXyh3aMo8lgAwi5s/pUxppK+Ul5Rt7zywX
         bUd51DqTSFum9uLb+vGg1nlRYt5wWyZr/OnIpLW2cxdfCv44WYWq2xtwwVinifoHGR8P
         wY2mt1p3ElYgCC5xIVVu3/UPqwUHNGJXAC35+OUABZ+7jjMxMc5CH6sOpdYp5pg3LBcl
         po00TwnSatw1Vq+eHTUe8uJI2x7lB4CP72pQKbQ/DZ2JxdsaaOtyPubU27kyGxlmsgGx
         A3+g==
X-Gm-Message-State: APjAAAXi5DBcCPpIak2rthXAi2jXGkLRV2DShpLgeq0qFygdKhI7XHoJ
        YVI+tLMYpBgIFNd9Ac5BZhozW+QbbgJlcBxP1qTnogQt0W52
X-Google-Smtp-Source: APXvYqwv2AnyEv9rrsX+e+gven1RJfMZ5luPwbi0AmIXsE4qN4ArL+zaxfdPTfCuh0gdsgaUn2yIuMixSUoovzEDDHOIEdgJ77sY
MIME-Version: 1.0
X-Received: by 2002:a24:81d4:: with SMTP id q203mr7362487itd.55.1559138885210;
 Wed, 29 May 2019 07:08:05 -0700 (PDT)
Date:   Wed, 29 May 2019 07:08:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000689ecb058a074f45@google.com>
Subject: general protection fault in usb_gadget_udc_reset (2)
From:   syzbot <syzbot+326669f39a76a997dc02@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=156d9486a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c309d28e15db39c5
dashboard link: https://syzkaller.appspot.com/bug?extid=326669f39a76a997dc02
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+326669f39a76a997dc02@syzkaller.appspotmail.com

general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.2.0-rc1+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_gadget_udc_reset+0x23/0xb0 drivers/usb/gadget/udc/core.c:1051
Code: eb d4 0f 1f 44 00 00 41 54 49 89 fc 53 48 89 f3 e8 a2 b0 9d fd 48 8d  
7b 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
70 48 8b 43 40 4c 89 e7 e8 ab b1 00 02 49 8d 7c 24
RSP: 0018:ffff8881d9dcf4d8 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000e5f0000
RDX: 0000000000000008 RSI: ffffffff839f654e RDI: 0000000000000040
RBP: ffff8881d1c88bf4 R08: ffff8881d9d96000 R09: ffffed103a391001
R10: ffffed103a391000 R11: ffff8881d1c88003 R12: ffff8881d1c88bf8
R13: ffff8881d1c88000 R14: ffff8881d1cc5923 R15: ffff8881d1cc58e4
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f345281df88 CR3: 00000001cf13e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  set_link_state+0x7be/0xcf0 drivers/usb/gadget/udc/dummy_hcd.c:463
  dummy_hub_control+0xf28/0x16b0 drivers/usb/gadget/udc/dummy_hcd.c:2289
  rh_call_control drivers/usb/core/hcd.c:685 [inline]
  rh_urb_enqueue drivers/usb/core/hcd.c:844 [inline]
  usb_hcd_submit_urb+0x814/0x1ed0 drivers/usb/core/hcd.c:1652
  usb_submit_urb+0x6e5/0x13b0 drivers/usb/core/urb.c:569
  usb_start_wait_urb+0x108/0x2b0 drivers/usb/core/message.c:57
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:152
  set_port_feature+0x69/0x90 drivers/usb/core/hub.c:428
  hub_port_reset+0x20a/0x1440 drivers/usb/core/hub.c:2871
  hub_port_init+0x9b2/0x2c10 drivers/usb/core/hub.c:4688
  hub_port_connect drivers/usb/core/hub.c:5021 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x18ff/0x35a0 drivers/usb/core/hub.c:5432
  process_one_work+0x90a/0x1580 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30e/0x420 kernel/kthread.c:254
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 3e0b2150af1908f2 ]---
RIP: 0010:usb_gadget_udc_reset+0x23/0xb0 drivers/usb/gadget/udc/core.c:1051
Code: eb d4 0f 1f 44 00 00 41 54 49 89 fc 53 48 89 f3 e8 a2 b0 9d fd 48 8d  
7b 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
70 48 8b 43 40 4c 89 e7 e8 ab b1 00 02 49 8d 7c 24
RSP: 0018:ffff8881d9dcf4d8 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000e5f0000
RDX: 0000000000000008 RSI: ffffffff839f654e RDI: 0000000000000040
RBP: ffff8881d1c88bf4 R08: ffff8881d9d96000 R09: ffffed103a391001
R10: ffffed103a391000 R11: ffff8881d1c88003 R12: ffff8881d1c88bf8
R13: ffff8881d1c88000 R14: ffff8881d1cc5923 R15: ffff8881d1cc58e4
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f345281df88 CR3: 00000001cf13e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
