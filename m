Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F56C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D0D204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEGJoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:44:07 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:35945 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfEGJoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:44:06 -0400
Received: by mail-it1-f200.google.com with SMTP id z11so14153588itk.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 02:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NI9fqMXGZPuLk/9yc1ykaMzaXg9QTteWl3G8GIZCZ3Y=;
        b=SxZBIBYKnqSUtifWgbROJpvIGnzfwFXkCoxAc6fXWn0vSWiUtUru2bNXw2rpkKys7H
         Gy2VzAp1kRmFeDpDHE4j3WTDjdiF+EfPf2iC0aNK5O9IlqVcTHvSX2y0Z08/2a3rKW27
         jYcBhB1k666GFw1jRXGMUh2MglGJUpyg55Um9TGCOIKe8qbaXcCwvG7PWFbMVPfH0dhj
         NTA5QQWNmg6ZgqPODLwHuIgJ1l59CwrtJR5YQt3YH0UKbhcCQYC9XfIfTxRRxIKIjOMF
         2oxbaTGY49oJFHaoFD3Ffgja9bH+qyXDnJ4KAHIA8OLX9xZwidm+0xvWnB3VWMllJSAM
         s5lw==
X-Gm-Message-State: APjAAAXwJcWLpUp/LGlAWwwiRq2sK+z+LnIZtxdqj94IHMnfmhChZejE
        uCcDS9YIZCQ123KaOhmC2o02OQBGCqrc5WRc2z/hCE1MhG8I
X-Google-Smtp-Source: APXvYqxhGYZKKqBsfUjQ8TCMmCe87Ax1CGbuzi8MlSFK9j9T7F9jqxe8PJDjS7qQETlqvh608eigFS8j2vOmzFE6Ws6g3rcLtUxC
MIME-Version: 1.0
X-Received: by 2002:a24:3c5:: with SMTP id e188mr13224829ite.27.1557222246049;
 Tue, 07 May 2019 02:44:06 -0700 (PDT)
Date:   Tue, 07 May 2019 02:44:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cff4d50588490e45@google.com>
Subject: general protection fault in relay_close_buf
From:   syzbot <syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        jannh@google.com, jrdr.linux@gmail.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    371dd432 Merge branch 'for-5.1-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124077dd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=58320b7171734bf79d26
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6042 Comm: syz-executor.4 Not tainted 5.1.0-rc5+ #76
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:relay_close_buf+0x28/0x150 kernel/relay.c:495
Code: 00 00 55 48 89 e5 41 54 49 89 fc 53 e8 a1 1d ff ff 49 8d bc 24 ac 00  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 dc
RSP: 0018:ffff8880976d7918 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffffc9000e6c3000
RDX: 0000000020000015 RSI: ffffffff81716f0f RDI: 00000001000000ab
RBP: ffff8880976d7928 R08: ffff88808de7a640 R09: ffffed1012edaefa
R10: ffffed1012edaef9 R11: 0000000000000003 R12: 00000000ffffffff
R13: ffff88809f86a300 R14: 0000000000000007 R15: 00000000ffffffff
FS:  00007f4e560ef700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002540040 CR3: 00000000a158b000 CR4: 00000000001406f0
Call Trace:
  relay_open kernel/relay.c:612 [inline]
  relay_open+0x619/0x980 kernel/relay.c:563
  do_blk_trace_setup+0x414/0xb90 kernel/trace/blktrace.c:532
  __blk_trace_setup+0xe3/0x190 kernel/trace/blktrace.c:577
  blk_trace_ioctl+0x170/0x300 kernel/trace/blktrace.c:716
  blkdev_ioctl+0x276/0x1d10 block/ioctl.c:591
  block_ioctl+0xee/0x130 fs/block_dev.c:1933
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4e560eec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458c29
RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4e560ef6d4
R13: 00000000004c00f2 R14: 00000000004d24f8 R15: 00000000ffffffff
Modules linked in:
---[ end trace 9ca3bd995bc8baa6 ]---
RIP: 0010:relay_close_buf+0x28/0x150 kernel/relay.c:495
Code: 00 00 55 48 89 e5 41 54 49 89 fc 53 e8 a1 1d ff ff 49 8d bc 24 ac 00  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 dc
RSP: 0018:ffff8880976d7918 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffffc9000e6c3000
RDX: 0000000020000015 RSI: ffffffff81716f0f RDI: 00000001000000ab
RBP: ffff8880976d7928 R08: ffff88808de7a640 R09: ffffed1012edaefa
R10: ffffed1012edaef9 R11: 0000000000000003 R12: 00000000ffffffff
R13: ffff88809f86a300 R14: 0000000000000007 R15: 00000000ffffffff
FS:  00007f4e560ef700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002540040 CR3: 00000000a158b000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
