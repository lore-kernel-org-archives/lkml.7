Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7288C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814FE21902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfCUQmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:42:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49926 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfCUQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:42:05 -0400
Received: by mail-io1-f72.google.com with SMTP id z6so5509532ioh.16
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lucdnKixUea4/G3DSwpS9jSnxM9gJ6/FVEjncwUji1w=;
        b=unUtl6OgB8orFwOb/3f2AEkWh1sQqPks49GsZQpQA1mRy9Pk0ykhkFE2h5F4FG0WU9
         L98h6AdNWbuODpbtoLhhVrY4lNnrAvtlFaqdOWSKF8mFBBHGr0mR0AelpBH4vSjT/t7p
         7zZo/bPOq2SyNjVx3E2KHK1xKiuyjud2diCrO4oAQZYkJKz/iYBfUp66pU2aCfcjFvln
         1b+aSOxhNZcKDnPt/uQjA/w0XShex0uzHh9W499WxF/YGA+653ylIebwA2CM+eS2vTvm
         EcodaAoHSDjAzB9u3yNmmzPb9kjhK6iDmz690W7wqFgGmc5gGVdCdqy+aY9guzIuQS7I
         6hMQ==
X-Gm-Message-State: APjAAAVFztOc6iKiK61OjMruwnaa3WwiKFAf1I0bJlzfL9YYErgckz8n
        X60bB62XRWeizxxIXWRopma64FWDF6peO4OEWEntJcwD1tn3
X-Google-Smtp-Source: APXvYqyyHNE1zJTl3xweQah7qrfBrGByL3s9/gdYLandSqiHWEoHwOI9doo1o2Hs78XuvZ/EbGJc89e+5z3x3AB3+O28CyD7kM8q
MIME-Version: 1.0
X-Received: by 2002:a5e:c901:: with SMTP id z1mr3508839iol.304.1553186524977;
 Thu, 21 Mar 2019 09:42:04 -0700 (PDT)
Date:   Thu, 21 Mar 2019 09:42:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017690505849d6b3c@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in hci_uart_set_flow_control
From:   syzbot <syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    54c49016 Merge tag 'arc-5.1-rc2' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150552df200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
dashboard link: https://syzkaller.appspot.com/bug?extid=79337b501d6aa974d0f6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15397fd7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151e9e6d200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com

BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
#PF error: [INSTR]
PGD a7d75067 P4D a7d75067 PUD 9fa83067 PMD 0
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1173 Comm: kworker/u5:0 Not tainted 5.1.0-rc1+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci0 hci_power_on
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff8880a7807a28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff87ac4d20 RCX: 0000000000000000
RDX: 1ffffffff0f589bd RSI: 1ffff11014fff58f RDI: ffff8880a0f6ca00
RBP: ffff8880a7807b00 R08: ffff8880a7ffa380 R09: 0000000000000004
R10: ffffed10141ed945 R11: ffff8880a0f6ca2f R12: ffff8880a0f6ca00
R13: 1ffff11014f00f47 R14: ffff8880a0f6ca10 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000009fa85000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  hci_uart_set_flow_control+0x41e/0x600 drivers/bluetooth/hci_ldisc.c:327
  mrvl_setup+0x22/0x110 drivers/bluetooth/hci_mrvl.c:348
  hci_uart_setup+0x1c4/0x490 drivers/bluetooth/hci_ldisc.c:418
  hci_dev_do_open+0x78c/0x1780 net/bluetooth/hci_core.c:1450
  hci_power_on+0x10d/0x580 net/bluetooth/hci_core.c:2173
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: 0000000000000000
---[ end trace 1fd0bc84b188ab23 ]---
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff8880a7807a28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff87ac4d20 RCX: 0000000000000000
RDX: 1ffffffff0f589bd RSI: 1ffff11014fff58f RDI: ffff8880a0f6ca00
RBP: ffff8880a7807b00 R08: ffff8880a7ffa380 R09: 0000000000000004
R10: ffffed10141ed945 R11: ffff8880a0f6ca2f R12: ffff8880a0f6ca00
R13: 1ffff11014f00f47 R14: ffff8880a0f6ca10 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000009fa85000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
