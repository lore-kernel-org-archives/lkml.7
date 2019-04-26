Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C33EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CF9206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDZLNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:13:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:39398 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfDZLNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:13:01 -0400
Received: by mail-it1-f199.google.com with SMTP id z125so2519696itf.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 04:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5d1srtrWhGvFC4lRTa9nAq3plNSmg0RW0hmh4X5Emzc=;
        b=uKQjBUHK7AZXmy9Z2obHPA47N+zAZSH+NE7b4bT/ifSClVwMpt0KjOsMH17ISppaeh
         QWOyZs2WBFbxGn1Yjkbo0SFl45b4N7L//WogEuqt/14nXACiauA89z6gtndh8p1pSHXk
         QNKDT2mgFErHlgDrgCn1RoyP5XWzIIWHX55D6m2CF4X42ca+qjuWA/grHZp8iBZNx4tD
         2S8ubB1r2rptgXFgAVVbn2dqrFJmY9ziuhQ5TOC4JTqCUOPs25nrR1zQYhPCU6C0f2Ru
         hKri7dgnfbpJ5p7uo8iajJGKf2bJkKqm1ACFW5vgtrgJvz8U4LNqWlXSRlcpbRqFIfmI
         ThPg==
X-Gm-Message-State: APjAAAUU3SRfDMqjcdG7mqoFCxYaemvLVVKDrnGtqvweLHTcVqBO4+hv
        HIDyyiehOyKbULhAJ9YlonF41LDAyabbwSp/bMLxd8nv8xPU
X-Google-Smtp-Source: APXvYqzuAGXXpBecAm4UEvoDth4VLM8Ima/8LCWfvl9FswlNd3GAaCI+CtCb8OSbhBOPjJV/lviQdWKeGywZFMa2xMVtWpd+0y6h
MIME-Version: 1.0
X-Received: by 2002:a6b:b291:: with SMTP id b139mr14638688iof.181.1556277180887;
 Fri, 26 Apr 2019 04:13:00 -0700 (PDT)
Date:   Fri, 26 Apr 2019 04:13:00 -0700
In-Reply-To: <20190426105511.GA18333@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089f82105876d041b@google.com>
Subject: Re: general protection fault in fanotify_handle_event
From:   syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
general protection fault in fanotify_handle_event

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13565 Comm: syz-executor.2 Not tainted 5.1.0-rc6+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fanotify_get_fsid fs/notify/fanotify/fanotify.c:352 [inline]
RIP: 0010:fanotify_handle_event+0x7d0/0xc40  
fs/notify/fanotify/fanotify.c:412
Code: ff ff 48 8b 18 48 8d 7b 68 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85  
47 04 00 00 48 8b 5b 68 48 8d 7b 3c 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 3a  
48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
RSP: 0018:ffff888085eb7b78 EFLAGS: 00010203
RAX: 1ffff11013db05ab RBX: 0000000000000000 RCX: ffffffff81c427ae
RDX: 0000000000000007 RSI: ffffffff81c427bb RDI: 000000000000003c
RBP: ffff888085eb7cc0 R08: ffff88808b0926c0 R09: 0000000000000000
R10: ffff88808b092f90 R11: ffff88808b0926c0 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
FS:  00007ff801b58700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f500e416000 CR3: 00000000a3f17000 CR4: 00000000001406f0
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
RSP: 002b:00007ff801b57c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458c29
RDX: 0000000000000007 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff801b586d4
R13: 00000000004c8386 R14: 00000000004de8b8 R15: 00000000ffffffff
Modules linked in:
---[ end trace 1767f2144c7cb47e ]---
RIP: 0010:fanotify_get_fsid fs/notify/fanotify/fanotify.c:352 [inline]
RIP: 0010:fanotify_handle_event+0x7d0/0xc40  
fs/notify/fanotify/fanotify.c:412
Code: ff ff 48 8b 18 48 8d 7b 68 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85  
47 04 00 00 48 8b 5b 68 48 8d 7b 3c 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 3a  
48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
RSP: 0018:ffff888085eb7b78 EFLAGS: 00010203
RAX: 1ffff11013db05ab RBX: 0000000000000000 RCX: ffffffff81c427ae
RDX: 0000000000000007 RSI: ffffffff81c427bb RDI: 000000000000003c
RBP: ffff888085eb7cc0 R08: ffff88808b0926c0 R09: 0000000000000000
R10: ffff88808b092f90 R11: ffff88808b0926c0 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
FS:  00007ff801b58700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f500e416000 CR3: 00000000a3f17000 CR4: 00000000001406f0


Tested on:

commit:         8c7008a0 fsnotify: Fix NULL ptr deref in fanotify_get_fsid()
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
console output: https://syzkaller.appspot.com/x/log.txt?x=13020ef4a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

