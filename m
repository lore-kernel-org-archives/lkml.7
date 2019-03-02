Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D454C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAA22083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfCBHFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 02:05:06 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:36089 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfCBHFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 02:05:06 -0500
Received: by mail-it1-f197.google.com with SMTP id i4so296664itb.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 23:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xuilmwSUkMHUDLhuVilB7fgYtSmCUjO8KFUDRjAcl+I=;
        b=UtXI/xex5D2OqKlfL2RAazShzt5m0MiiQeq1Gw3Os3YFvM/c/4A1AakWodPJ7aMvNz
         gdLeRc31KF/oXhUN0Zrr3Fzix/B/1ln8l7tbQFAd8YEZMD7oOiyChNxBSt5qJwi23x01
         VZAzDN2GMhi1wtRcohuqo0ZscCdXX1oLbjS13PgaTcmcZetMz2rNFBdEtJ0LiuWag12p
         n/f6RS5D1LmCCczlVqGMLDMepgEUYrYSRclH29UMqbrOOmUCQZsGPfJYrO7mGvyzxnsN
         fcjtb5WbTnNamTKe7sG71EYu2vgkTVeWgTrOiVAKy+ZLrUy8eiPYIuNqsk1BTzTgKF2T
         8Akg==
X-Gm-Message-State: AHQUAuYe3qtxh3Rs89qx1Mj50QxeukqdYO2aMdwC2jja0+EuvBhOzQDY
        Ciziq346KA6/rTs7X7/5EJpbXf1ytr3TKOj+QknRSnVl2hhc
X-Google-Smtp-Source: APXvYqzMHBzZoaMwA1uXoL6UYjxnxxZ+7NlLtzal5NF1nHzMZypOfRiW1wIj288keg81d3LdE7jxXhHo7wzvssREtOVkTdZfNc6h
MIME-Version: 1.0
X-Received: by 2002:a24:5c81:: with SMTP id q123mr5346247itb.34.1551510305173;
 Fri, 01 Mar 2019 23:05:05 -0800 (PST)
Date:   Fri, 01 Mar 2019 23:05:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009af83005831724a4@google.com>
Subject: kernel BUG at include/linux/mm.h:LINE! (4)
From:   syzbot <syzbot+cc252aa9d2d3b576246f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    42fd8df9d1d9 Add linux-next specific files for 20190228
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16c3cd5cc00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0f38652d28b522f
dashboard link: https://syzkaller.appspot.com/bug?extid=cc252aa9d2d3b576246f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cc252aa9d2d3b576246f@syzkaller.appspotmail.com

page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
page->mem_cgroup:ffff888059786cc0
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:579!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 22405 Comm: syz-executor.3 Not tainted 5.0.0-rc8-next-20190228  
#45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:put_page_testzero include/linux/mm.h:579 [inline]
RIP: 0010:put_page include/linux/mm.h:1025 [inline]
RIP: 0010:generic_pipe_buf_release+0x120/0x160 fs/pipe.c:224
Code: bd ff 4c 89 e7 e8 90 43 db ff e8 5b 07 bd ff 5b 41 5c 41 5d 5d c3 e8  
4f 07 bd ff 48 c7 c6 60 98 75 87 4c 89 e7 e8 c0 db e4 ff <0f> 0b e8 39 07  
bd ff 4d 8d 65 ff e9 3d ff ff ff 48 89 df e8 e8 f8
RSP: 0018:ffff888056c57920 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffea0002283db4 RCX: ffffc9000c456000
RDX: 0000000000040000 RSI: ffffffff81984e72 RDI: ffffed100ad8af08
RBP: ffff888056c57938 R08: 0000000000000021 R09: ffffed1015d05011
R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffffea0002283d80
R13: 0000000000000000 R14: ffff88809ad3c800 R15: ffff8880592ac928
FS:  00007fb53aaf2700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff65e0fdb8 CR3: 0000000093a2f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  pipe_buf_release include/linux/pipe_fs_i.h:129 [inline]
  iter_file_splice_write+0x7d1/0xbe0 fs/splice.c:759
  do_splice_from fs/splice.c:847 [inline]
  direct_splice_actor+0x126/0x1a0 fs/splice.c:1019
  splice_direct_to_actor+0x369/0x970 fs/splice.c:974
  do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
  do_sendfile+0x597/0xd00 fs/read_write.c:1442
  __do_sys_sendfile64 fs/read_write.c:1503 [inline]
  __se_sys_sendfile64 fs/read_write.c:1489 [inline]
  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1489
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb53aaf1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457e29
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000102000000 R11: 0000000000000246 R12: 00007fb53aaf26d4
R13: 00000000004c4dce R14: 00000000004d8af8 R15: 00000000ffffffff
Modules linked in:
---[ end trace ce17ea3937b628f2 ]---
RIP: 0010:put_page_testzero include/linux/mm.h:579 [inline]
RIP: 0010:put_page include/linux/mm.h:1025 [inline]
RIP: 0010:generic_pipe_buf_release+0x120/0x160 fs/pipe.c:224
Code: bd ff 4c 89 e7 e8 90 43 db ff e8 5b 07 bd ff 5b 41 5c 41 5d 5d c3 e8  
4f 07 bd ff 48 c7 c6 60 98 75 87 4c 89 e7 e8 c0 db e4 ff <0f> 0b e8 39 07  
bd ff 4d 8d 65 ff e9 3d ff ff ff 48 89 df e8 e8 f8
RSP: 0018:ffff888056c57920 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffea0002283db4 RCX: ffffc9000c456000
RDX: 0000000000040000 RSI: ffffffff81984e72 RDI: ffffed100ad8af08
RBP: ffff888056c57938 R08: 0000000000000021 R09: ffffed1015d05011
R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffffea0002283d80
R13: 0000000000000000 R14: ffff88809ad3c800 R15: ffff8880592ac928
FS:  00007fb53aaf2700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30225000 CR3: 0000000093a2f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
