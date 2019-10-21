Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FCDCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFF62084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfJUFZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:25:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56917 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJUFZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:25:07 -0400
Received: by mail-io1-f69.google.com with SMTP id a22so16235543ioq.23
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 22:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BJjOacao/xSZdJkfKNvfgayBr+tvt4yWLfw3O1pfZnM=;
        b=cO6ZAtVQJijyhnrDixOBgc/3+LhEudVJoK5vXisWJUNpXeyK6xlfF+B971363bCzWl
         HNVT6VHXm8yS+JlkZ0DVyS1k77AKN7yVO32GIw4b/dLvcWLXLCd8a/PGsojWfkYKJ+W/
         DxivsO2EgLm56VWBqMK5IEg+HyQd7m3acI9HhHFj/c3FyFe0DtYf7+nfjbSTEmhKkrOG
         U1aGt5LP3zkOIig8Q6DcWCJNn+YlWhHzjlX+YpMSJGpZ9ZQGyTDII70kQVuI/4XU0xeP
         XxzMSDBICNHWSCtrD2Ml70bhyEKKkKXatLi51ZCVT5sEt6jqYnmEjSGS5XZAp+x/6Mq1
         LHHA==
X-Gm-Message-State: APjAAAXVY9/TuLM61HUu36l4Fqi/jpHvBWcEyoQqwS/zr5lYrOhlww2E
        VaaMgzA2YPzCUtOwhEbtA2HRrGgsENme7S+sJYv8TUMATErK
X-Google-Smtp-Source: APXvYqzqO8EInoc9fWb4rurG8YxnJy3l3A6MVsxjqKwXTNpiPU1L2sykAO54wZ2xzCt0jBw+JBC9wkXL9dB1Pb4RJtHdkcoWhZm4
MIME-Version: 1.0
X-Received: by 2002:a92:9957:: with SMTP id p84mr3872177ili.290.1571635506211;
 Sun, 20 Oct 2019 22:25:06 -0700 (PDT)
Date:   Sun, 20 Oct 2019 22:25:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000107499059564e831@google.com>
Subject: general protection fault in fire_user_return_notifiers
From:   syzbot <syzbot+529818c5c7cdf607bf0e@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eda57a0e Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17310520e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=966954bb171a60e7
dashboard link: https://syzkaller.appspot.com/bug?extid=529818c5c7cdf607bf0e
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+529818c5c7cdf607bf0e@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7781 Comm: syz-executor.2 Not tainted 5.4.0-rc2+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fire_user_return_notifiers+0x90/0x110  
kernel/user-return-notifier.c:42
Code: 00 48 8b 1b 48 85 db 74 06 48 83 c3 f8 75 10 e8 96 e2 e3 ff eb 54 0f  
1f 40 00 e8 8b e2 e3 ff 48 8d 7b 08 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00  
74 05 e8 b4 1b 1d 00 4c 8b 73 08 48 89 d8 48 c1 e8
RSP: 0018:ffff888068db7e38 EFLAGS: 00010a02
RAX: 1bd5a00000000020 RBX: dead0000000000f8 RCX: ffff888068dac0c0
RDX: 0000000000000000 RSI: 0023001000000000 RDI: dead000000000100
RBP: ffff888068db7e50 R08: ffffffff8109b34e R09: ffffed100d1b5819
R10: ffffed100d1b5819 R11: 0000000000000000 R12: 0000000000000800
R13: dffffc0000000000 R14: dead000000000100 R15: dffffc0000000000
FS:  00000000024a9940(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000068d86000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  exit_to_usermode_loop arch/x86/entry/common.c:168 [inline]
  prepare_exit_to_usermode+0x3fd/0x580 arch/x86/entry/common.c:194
  syscall_return_slowpath+0x113/0x4a0 arch/x86/entry/common.c:274
  do_syscall_64+0x11f/0x1c0 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457f00
Code: c0 5b 5d c3 66 0f 1f 44 00 00 8b 04 24 48 83 c4 18 5b 5d c3 66 0f 1f  
44 00 00 83 3d 51 e8 61 00 00 75 14 b8 23 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 24 d3 fb ff c3 48 83 ec 08 e8 ea 46 00 00
RSP: 002b:00007fff163eec28 EFLAGS: 00000246 ORIG_RAX: 0000000000000023
RAX: 0000000000000000 RBX: 000000000007cbd9 RCX: 0000000000457f00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff163eec30
RBP: 0000000000000a99 R08: 0000000000000001 R09: 00000000024a9940
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000d
R13: 00007fff163eec80 R14: 000000000007c8a4 R15: 00007fff163eec90
Modules linked in:
---[ end trace ff1f073ed00222a2 ]---
RIP: 0010:fire_user_return_notifiers+0x90/0x110  
kernel/user-return-notifier.c:42
Code: 00 48 8b 1b 48 85 db 74 06 48 83 c3 f8 75 10 e8 96 e2 e3 ff eb 54 0f  
1f 40 00 e8 8b e2 e3 ff 48 8d 7b 08 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00  
74 05 e8 b4 1b 1d 00 4c 8b 73 08 48 89 d8 48 c1 e8
RSP: 0018:ffff888068db7e38 EFLAGS: 00010a02
RAX: 1bd5a00000000020 RBX: dead0000000000f8 RCX: ffff888068dac0c0
RDX: 0000000000000000 RSI: 0023001000000000 RDI: dead000000000100
RBP: ffff888068db7e50 R08: ffffffff8109b34e R09: ffffed100d1b5819
R10: ffffed100d1b5819 R11: 0000000000000000 R12: 0000000000000800
R13: dffffc0000000000 R14: dead000000000100 R15: dffffc0000000000
FS:  00000000024a9940(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000068d86000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
