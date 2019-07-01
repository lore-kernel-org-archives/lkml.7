Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA706C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3992089F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfGANRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:17:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54456 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGANRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:17:08 -0400
Received: by mail-io1-f70.google.com with SMTP id n8so15098150ioo.21
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 06:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tstkKwEY4CPkaozMUdkgXJDuYpws5/cbs4UFbhfKbG4=;
        b=LjOznWB+mwk2rnaq5DcTBh+ISA3EUIwNGtdFjv8npoqUGAn2sQn2SDsXFj9pcdMZ3L
         j4+oKpxpHPP10HlwNkHixXg5gzze1yjqKzrSGAw9MyyEAERmtfu/jMi50c8bg2NkSizX
         wCEM0qpQ79fLiTJk9r+PdGw+NR2/CTk4yjkxzp3lvC8dmP181h1wxYG2awPKM5ifSIck
         mEPTOVW3QEMZ3f5PFYkQW1QuUmtVRWnLw3qmgktZAK63tPqVgxAQL2IHU4n4f8cixZMN
         /F/NwReuOjwhxw+BHmlqqyUu/O5wNjVDQPLkxeK9YFqyIc5gaISsP32aiOgfI6SKF23Z
         5UjQ==
X-Gm-Message-State: APjAAAXlMx1k1f1b9HrmoTEZx66EO1NrIe6m5P07K2ZzRmr6+xQ5uU9g
        9gQLyadufNzG7+4iQUBn6TZsUfAKwNdgJ78o0O8t9cOF8UTO
X-Google-Smtp-Source: APXvYqwPbSJK13gyooT2AAQAJajswUbeeHfdJMexvsUAXXhBi8bopgeR85lr8uG0x4w2/0T26oKn3rIw5pb+EFq038tS301o+cKv
MIME-Version: 1.0
X-Received: by 2002:a6b:fb10:: with SMTP id h16mr5392419iog.195.1561987026832;
 Mon, 01 Jul 2019 06:17:06 -0700 (PDT)
Date:   Mon, 01 Jul 2019 06:17:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0dc0d058c9e7142@google.com>
Subject: general protection fault in get_task_pid
From:   syzbot <syzbot+002e636502bc4b64eb5c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arunks@codeaurora.org,
        christian@brauner.io, ebiederm@xmission.com,
        elena.reshetova@intel.com, gregkh@linuxfoundation.org, guro@fb.com,
        jannh@google.com, ktsanaktsidis@zendesk.com,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        peterz@infradead.org, riel@surriel.com, rppt@linux.vnet.ibm.com,
        scuttimmy@gmail.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk, willy@infradead.org,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    556e2f60 Merge tag 'clk-fixes-for-linus' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112a45a9a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=002e636502bc4b64eb5c
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1716d35ba00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1489f565a00000

The bug was bisected to:

commit 6fd2fe494b17bf2dec37b610d23a43a72b16923a
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Jun 27 02:22:09 2019 +0000

     copy_process(): don't use ksys_close() on cleanups

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=135a66f9a00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10da66f9a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=175a66f9a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+002e636502bc4b64eb5c@syzkaller.appspotmail.com
Fixes: 6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")

R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffc15fbb0ff R14: 00007ff07e47e9c0 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7990 Comm: syz-executor290 Not tainted 5.2.0-rc6+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
RIP: 0010:get_task_pid+0xe1/0x210 kernel/pid.c:372
Code: 89 ff e8 62 27 5f 00 49 8b 07 44 89 f1 4c 8d bc c8 90 01 00 00 eb 0c  
e8 0d fe 25 00 49 81 c7 38 05 00 00 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 74  
08 4c 89 ff e8 31 27 5f 00 4d 8b 37 e8 f9 47 12 00
RSP: 0018:ffff88808a4a7d78 EFLAGS: 00010203
RAX: 00000000000000a7 RBX: dffffc0000000000 RCX: ffff888088180600
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88808a4a7d90 R08: ffffffff814fb3a8 R09: ffffed1015d66bf8
R10: ffffed1015d66bf8 R11: 1ffff11015d66bf7 R12: 0000000000041ffc
R13: 1ffff11011494fbc R14: 0000000000000000 R15: 000000000000053d
FS:  00007ff07e47e700(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b5100 CR3: 0000000094df2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  _do_fork+0x1b9/0x5f0 kernel/fork.c:2360
  __do_sys_clone kernel/fork.c:2454 [inline]
  __se_sys_clone kernel/fork.c:2448 [inline]
  __x64_sys_clone+0xc1/0xd0 kernel/fork.c:2448
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446649
Code: e8 bc b5 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff07e47ddb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446649
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000041ffc
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffc15fbb0ff R14: 00007ff07e47e9c0 R15: 0000000000000000
Modules linked in:
---[ end trace 403a74d6aeda7e67 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
RIP: 0010:get_task_pid+0xe1/0x210 kernel/pid.c:372
Code: 89 ff e8 62 27 5f 00 49 8b 07 44 89 f1 4c 8d bc c8 90 01 00 00 eb 0c  
e8 0d fe 25 00 49 81 c7 38 05 00 00 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 74  
08 4c 89 ff e8 31 27 5f 00 4d 8b 37 e8 f9 47 12 00
RSP: 0018:ffff88808a4a7d78 EFLAGS: 00010203
RAX: 00000000000000a7 RBX: dffffc0000000000 RCX: ffff888088180600
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88808a4a7d90 R08: ffffffff814fb3a8 R09: ffffed1015d66bf8
R10: ffffed1015d66bf8 R11: 1ffff11015d66bf7 R12: 0000000000041ffc
R13: 1ffff11011494fbc R14: 0000000000000000 R15: 000000000000053d
FS:  00007ff07e47e700(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b5100 CR3: 0000000094df2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
