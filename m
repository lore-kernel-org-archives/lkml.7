Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7B1C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32E820656
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFWMvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:51:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:36543 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWMvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:51:06 -0400
Received: by mail-io1-f71.google.com with SMTP id k21so18201783ioj.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 05:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=akj0uRzdQOuIMOVJzexqusSdGlgWZ/bYGADjUjTklDA=;
        b=FT/kSRxkhr/IyNpw4U6I9njkkl46wa+zeY0dbJfju4CNjnD+Bgb1hUgWiKDAB5IJWg
         G8GPfa/hxVOI1aNQ9Jg0bBBi/LlSSKrocZQKUdDi7fha0yQG4tWyongPGPYg9cre0vt0
         70ZPmTRAtlzhlBwTee6ipSI4j9YYSXgh7P+p1FnL6+xv+0E0nalQ+VWWhklpqzOdYwSl
         yn9qFthm7+O+NgqPEWO8LA7RotPOd/6+uknEvWmWFw8kCga3INbQU8MhirR7JyscBxyC
         PXlvpQ2kPXlEa2pP4ro8c85FiaT6RrGZOPfWKJNvJUqrHp2w7Ggc9z5WEMZ1YxmBk22O
         WbVQ==
X-Gm-Message-State: APjAAAV7aNzCDLhUUOX3dJFaN1aicXyzCV23AbFFAVf8C54XZWZwILSq
        /OlzpjSoKIMHGUy74wxFT4ozlqYMk2TxR2dTFYy98nXcZBCv
X-Google-Smtp-Source: APXvYqwfgI8Kr0Lm57kf2Z5J8KyLFcQQTYBnM7py8lZ5TNLmAVC+giJmqSmJq4+s4FA1K5uqL9uHT3IghDrwVL82mIM+x/xbMJb+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:38a:: with SMTP id y10mr37939351jap.104.1561294265707;
 Sun, 23 Jun 2019 05:51:05 -0700 (PDT)
Date:   Sun, 23 Jun 2019 05:51:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018f6f1058bfd26e4@google.com>
Subject: kernel BUG at arch/x86/mm/physaddr.c:LINE! (3)
From:   syzbot <syzbot+50a27df2d1cd8ae38609@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15068816a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
dashboard link: https://syzkaller.appspot.com/bug?extid=50a27df2d1cd8ae38609
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+50a27df2d1cd8ae38609@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:27!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 29308 Comm: kworker/0:0 Not tainted 5.2.0-rc5+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events cache_reap
RIP: 0010:__phys_addr+0xb3/0x120 arch/x86/mm/physaddr.c:27
Code: 08 4c 89 e3 31 ff 48 d3 eb 48 89 de e8 f6 00 3e 00 48 85 db 75 0f e8  
4c ff 3d 00 4c 89 e0 5b 41 5c 41 5d 5d c3 e8 3d ff 3d 00 <0f> 0b e8 36 ff  
3d 00 48 c7 c0 10 50 a7 88 48 ba 00 00 00 00 00 fc
RSP: 0018:ffff88804752fbd8 EFLAGS: 00010093
RAX: ffff888059350600 RBX: 0000000000000000 RCX: ffffffff8132c192
RDX: 0000000000000000 RSI: ffffffff8132c1f3 RDI: 0000000000000006
RBP: ffff88804752fbf0 R08: ffff888059350600 R09: ffffed1008ea5f80
R10: ffffed1008ea5f7f R11: 0000000000000003 R12: 0000778000000000
R13: 0000000080000000 R14: ffff88804dd46c00 R15: ffffea00025de388
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f423000 CR3: 000000009320c000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  virt_to_head_page include/linux/mm.h:729 [inline]
  free_block+0xa8/0x250 mm/slab.c:3349
  drain_array_locked+0x36/0x90 mm/slab.c:2142
  drain_array+0x8c/0xb0 mm/slab.c:3960
  cache_reap+0xf4/0x280 mm/slab.c:4001
  process_one_work+0x989/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x354/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:

======================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
