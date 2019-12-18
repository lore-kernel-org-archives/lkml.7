Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7177CC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C23921D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLRLgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:36:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:40629 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:36:11 -0500
Received: by mail-il1-f199.google.com with SMTP id 138so554903ilb.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 03:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rUYOAmprzzwSZ1SExj6u5VDSkud8JlPzr8WL2vUkB5Y=;
        b=JRjY27nCB+l4hJFgwUDtJk5Vy864YaXSJu9aLuUbK+FRVdmvAiAO+h3hRNV8Si6wyX
         OYJg6vH6Vaoet4XovlBmsC4BH120Rnsjinma80laW19TMs8E5Y1cAn4OboNHaAE1GULg
         29pEsUhRW5259atYD6AQSDYf6XFW1IULj+058+qnq3HcpNfbUixDXmvXvTZ7depK9eis
         3nlaNLsNEXE5MQU72RX3M7BXV/qOVG2VcU6YFtpIQ9Z3EU4gl/nh03iWdEffPf0v8/Oo
         TBg8CxRUkqxoXNvGF70kSB7PkrulPbcpxMuQzRB6uFiEkl3mvspUwRmijRNO+ehsHSi7
         o38w==
X-Gm-Message-State: APjAAAWSW1+PwUy67GjMINLeW0WiTlPIZ3bZFhb2g2IZsc9j9hIXyJPo
        WIa68ln2G2DKiwQQiu2VdjH+dQW/4ccJM7ENKIocVr/BEx4s
X-Google-Smtp-Source: APXvYqwqzQBj3s7DOPdgew9KKcoV50sx+/SGzNvS6nUcHbfJ3/IaK3KZrHuSTScFnyeXU+21JFHJpXFa6yppVAbmSEhEs9XGLQrJ
MIME-Version: 1.0
X-Received: by 2002:a92:3c41:: with SMTP id j62mr1328186ila.149.1576668968899;
 Wed, 18 Dec 2019 03:36:08 -0800 (PST)
Date:   Wed, 18 Dec 2019 03:36:08 -0800
In-Reply-To: <0000000000002df264056a35b16b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1dc120599f8d953@google.com>
Subject: Re: kernel BUG at fs/buffer.c:LINE!
From:   syzbot <syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    2187f215 Merge tag 'for-5.5-rc2-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154f72fee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcf10bf83926432a
dashboard link: https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1171ba8ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107440aee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/buffer.c:3094!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10075 Comm: syz-executor292 Not tainted 5.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:submit_bh_wbc+0x71c/0x900 fs/buffer.c:3094
Code: 14 e5 ff f0 80 63 01 f7 e9 ab fa ff ff e8 bc a5 a7 ff 41 81 cd 00 10  
00 00 e9 4d fe ff ff e8 ab a5 a7 ff 0f 0b e8 a4 a5 a7 ff <0f> 0b e8 9d a5  
a7 ff 0f 0b e8 96 a5 a7 ff 0f 0b e8 8f a5 a7 ff 0f
RSP: 0018:ffffc90001f37bf8 EFLAGS: 00010293
RAX: ffff888097cd6540 RBX: ffff88808c089888 RCX: ffffffff81cd7f8d
RDX: 0000000000000000 RSI: ffffffff81cd85fc RDI: 0000000000000001
RBP: ffffc90001f37c40 R08: ffff888097cd6540 R09: ffffed1011811312
R10: ffffed1011811311 R11: ffff88808c08988f R12: 0000000000000000
R13: 0000000000000800 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000001f36940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41849f0ef0 CR3: 0000000095d70000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  submit_bh fs/buffer.c:3141 [inline]
  __sync_dirty_buffer+0x12b/0x350 fs/buffer.c:3227
  sync_dirty_buffer+0x1b/0x20 fs/buffer.c:3240
  fat_set_state+0x242/0x330 fs/fat/inode.c:708
  fat_put_super+0x46/0xd0 fs/fat/inode.c:734
  generic_shutdown_super+0x14c/0x370 fs/super.c:462
  kill_block_super+0xa0/0x100 fs/super.c:1442
  deactivate_locked_super+0x95/0x100 fs/super.c:335
  deactivate_super fs/super.c:366 [inline]
  deactivate_super+0x1b2/0x1d0 fs/super.c:362
  cleanup_mnt+0x351/0x4c0 fs/namespace.c:1102
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1109
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x448c07
Code: 00 00 00 b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 5d a2 fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3d a2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc40282788 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 000000000002675b RCX: 0000000000448c07
RDX: 0000000000400dc7 RSI: 0000000000000002 RDI: 00007ffc40282830
RBP: 0000000000002abe R08: 0000000000000000 R09: 000000000000000a
R10: 0000000000000005 R11: 0000000000000206 R12: 00007ffc40283890
R13: 0000000001f37940 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace c010b278a98f0232 ]---
RIP: 0010:submit_bh_wbc+0x71c/0x900 fs/buffer.c:3094
Code: 14 e5 ff f0 80 63 01 f7 e9 ab fa ff ff e8 bc a5 a7 ff 41 81 cd 00 10  
00 00 e9 4d fe ff ff e8 ab a5 a7 ff 0f 0b e8 a4 a5 a7 ff <0f> 0b e8 9d a5  
a7 ff 0f 0b e8 96 a5 a7 ff 0f 0b e8 8f a5 a7 ff 0f
RSP: 0018:ffffc90001f37bf8 EFLAGS: 00010293
RAX: ffff888097cd6540 RBX: ffff88808c089888 RCX: ffffffff81cd7f8d
RDX: 0000000000000000 RSI: ffffffff81cd85fc RDI: 0000000000000001
RBP: ffffc90001f37c40 R08: ffff888097cd6540 R09: ffffed1011811312
R10: ffffed1011811311 R11: ffff88808c08988f R12: 0000000000000000
R13: 0000000000000800 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000001f36940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000152d458 CR3: 0000000095d70000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

