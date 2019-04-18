Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF72C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D732171F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbfDRRGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:06:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42022 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRRGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:06:07 -0400
Received: by mail-io1-f70.google.com with SMTP id i1so2478181ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RfQlSRhPbvxU6HDnCxwNXok1nlQXWVy6VvmeuP6HTjs=;
        b=Ngo0ho+9RmqNGwqgwf1VmKEpgA+yseCEKbTnRREccxGOaBDUEMuNFJudwPJkZBGQWM
         i1sp2MJfzyCU5zQCfq0fM6qp5rBhpsqIh2gS9rhGSKsTgoJ5/eelZIlLDtbV0OVavaDO
         KPPF4+zHBWo9X8AqWfzJZMTKP++ZH602BDe5GXJK1OnInUyBlIOY+3HRdefSsdkR0uUl
         ze5p/uXy4tMLtbeVssPNXxtMeMIuRU8tp7oLlBQaJIlDt2GL6j2BUQ9fm7RcLdqEEZif
         5ubVtgvQeEwCCXdbLXABLa2liBtNuSfhX1qVdBU6kFRRHJploXSKXhhL0Ybh2eVgxC1b
         Fmdw==
X-Gm-Message-State: APjAAAVQ+2XAvnm9UXjZhK+8ORvEIM9DiDEwz1hZD9Vrym4SfvGyaWOc
        DYWtmEU7jE93WYpFH9zcY48YJgh9YLxZq0HPCdc8FilPv0RN
X-Google-Smtp-Source: APXvYqy62SLLidhq2XJ6k0Q/b27gmpEzGCNMMTd3hNjjcmdkkKvIom3ZBB/6ktVDslia4BsGSxxnFn/fM59vggBkGP59FG9srpBO
MIME-Version: 1.0
X-Received: by 2002:a5d:9c0b:: with SMTP id 11mr1583857ioe.230.1555607166499;
 Thu, 18 Apr 2019 10:06:06 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:06:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091becf0586d104c6@google.com>
Subject: general protection fault in fanotify_handle_event
From:   syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e53f31bf Merge tag '5.1-rc5-smb3-fixes' of git://git.samba..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174ea35b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=15927486a4f1bfcbaf91
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166cf35b200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 12999 Comm: syz-executor.0 Not tainted 5.1.0-rc5+ #73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fanotify_get_fsid fs/notify/fanotify/fanotify.c:352 [inline]
RIP: 0010:fanotify_handle_event+0x7d0/0xc40  
fs/notify/fanotify/fanotify.c:412
Code: ff ff 48 8b 18 48 8d 7b 68 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85  
47 04 00 00 48 8b 5b 68 48 8d 7b 3c 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 3a  
48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
RSP: 0018:ffff8880a8947b78 EFLAGS: 00010203
RAX: 1ffff110127b460d RBX: 0000000000000000 RCX: ffffffff81c41e9e
RDX: 0000000000000007 RSI: ffffffff81c41eab RDI: 000000000000003c
RBP: ffff8880a8947cc0 R08: ffff888087904240 R09: 0000000000000000
R10: ffff888087904b10 R11: ffff888087904240 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
FS:  00007f9f15bf7700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9f15bb4db8 CR3: 000000008d545000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  send_to_group fs/notify/fsnotify.c:243 [inline]
  fsnotify+0x725/0xbc0 fs/notify/fsnotify.c:381
  fsnotify_path include/linux/fsnotify.h:54 [inline]
  fsnotify_path include/linux/fsnotify.h:47 [inline]
  fsnotify_modify include/linux/fsnotify.h:263 [inline]
  vfs_write+0x4dc/0x580 fs/read_write.c:551
  ksys_write+0x14f/0x2d0 fs/read_write.c:599
  __do_sys_write fs/read_write.c:611 [inline]
  __se_sys_write fs/read_write.c:608 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:608
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9f15bf6c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458c29
RDX: 0000000000000007 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9f15bf76d4
R13: 00000000004c8386 R14: 00000000004de8b8 R15: 00000000ffffffff
Modules linked in:
---[ end trace 026b9c3311d87f36 ]---
RIP: 0010:fanotify_get_fsid fs/notify/fanotify/fanotify.c:352 [inline]
RIP: 0010:fanotify_handle_event+0x7d0/0xc40  
fs/notify/fanotify/fanotify.c:412
Code: ff ff 48 8b 18 48 8d 7b 68 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85  
47 04 00 00 48 8b 5b 68 48 8d 7b 3c 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 3a  
48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
RSP: 0018:ffff8880a8947b78 EFLAGS: 00010203
RAX: 1ffff110127b460d RBX: 0000000000000000 RCX: ffffffff81c41e9e
RDX: 0000000000000007 RSI: ffffffff81c41eab RDI: 000000000000003c
RBP: ffff8880a8947cc0 R08: ffff888087904240 R09: 0000000000000000
R10: ffff888087904b10 R11: ffff888087904240 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
FS:  00007f9f15bf7700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9f15bb4db8 CR3: 000000008d545000 CR4: 00000000001406e0
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
