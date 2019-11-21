Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FBAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26432075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKUBzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:55:10 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:40173 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUBzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:55:10 -0500
Received: by mail-il1-f199.google.com with SMTP id x17so1516958ill.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 17:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8fbeBWdGj/FE0BKwqQYW5jR1SsZViMg8/WL8VmVrmIc=;
        b=c7BWyQvyr/NwQhQgSk+BPB8SsuVB9n4tBy46gMcR72Bx5Im03SdZ3srNpsCyew5QKo
         ssCSB6jzMHw1h/5FvSZB+2e8ZY3x+mzLxEL7+8OLEHa8iMRukaKUFCByYsCJ8nOVGtiu
         AlAhlXTpadXpJ3HzMrckYOKSY40yv+tcq3R4v4dWOXxPU/gD0YNhRdKVkRy8uq57++cd
         6Mq1Z6qSrcO9/K4Kj1K9Upk3xZuyrAUl6/gbVKZ7ejK88N+2KymrdH/E1KaYPBZErmze
         MHBPh4xyx9KUWAtOFzw7kR7YZTipyNurRS/qfO14uSzvqK1Uxo3Ii2yb3aKQjlTMiaJc
         i4uQ==
X-Gm-Message-State: APjAAAVEGkni1a3Wac5RP9CVV7wGzbqEGaZyedXCt+Eq0ZmWmLRttK69
        vHeH69+ctLWZ7VxxPiAiVqXspKKXZa7xJZyjz2NKCyLNGghi
X-Google-Smtp-Source: APXvYqwEqU8W/u8ikBzqbAT/+RtVR9QeUYzIHwKg13jbeazZsy5qvVKFctzJ9VZ2Ss2lpcmRghJVq1Acvqr2H0pWITFFpxSnlU+d
MIME-Version: 1.0
X-Received: by 2002:a92:d191:: with SMTP id z17mr7350540ilz.51.1574301309190;
 Wed, 20 Nov 2019 17:55:09 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:55:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004dccce0597d1967b@google.com>
Subject: general protection fault in tss_update_io_bitmap
From:   syzbot <syzbot+81e6ff9d4cdb05fd4f5e@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, ak@linux.intel.com, bigeasy@linutronix.de,
        bp@alien8.de, fenghua.yu@intel.com, frederic@kernel.org,
        hpa@zytor.com, keescook@chromium.org, kernelfans@gmail.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com, riel@surriel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, tonywwang-oc@zhaoxin.com,
        wang.yi59@zte.com.cn, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5d1131b4 Add linux-next specific files for 20191119
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177979d2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b60c562d89e5a8df
dashboard link: https://syzkaller.appspot.com/bug?extid=81e6ff9d4cdb05fd4f5e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1549ed8ce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f91012e00000

The bug was bisected to:

commit 111e7b15cf10f6e973ccf537c70c66a5de539060
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Nov 12 20:40:33 2019 +0000

     x86/ioperm: Extend IOPL config to control ioperm() as well

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10490e86e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12490e86e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14490e86e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+81e6ff9d4cdb05fd4f5e@syzkaller.appspotmail.com
Fixes: 111e7b15cf10 ("x86/ioperm: Extend IOPL config to control ioperm() as  
well")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8968 Comm: syz-executor566 Not tainted  
5.4.0-rc8-next-20191119-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:tss_update_io_bitmap+0x138/0x590 arch/x86/kernel/process.c:395
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 9e 03 00 00 4c 89  
ea 4c 8b 73 68 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 72 03 00 00 4d 3b 75 00 0f 85 35 02 00 00 48 8d
RSP: 0018:ffff8880a4effe80 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff8880ae80a000 RCX: ffffffff812a3228
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8880ae80a068
RBP: ffff8880a4efff10 R08: 1ffff110126f5020 R09: ffffed10126f5021
R10: ffffed10126f5020 R11: ffff8880937a8107 R12: 1ffff110149dffd2
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001e8f880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffff01c2038 CR3: 0000000099c07000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  prepare_exit_to_usermode arch/x86/entry/common.c:201 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_64+0x685/0x790 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4400f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffff000a2d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ac
RAX: 0000000000000000 RBX: 00000000004002c8 RCX: 00000000004400f9
RDX: 0000000000400a20 RSI: 0000000000000012 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000401980
R13: 0000000000401a10 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 6bbd68071a8b58ba ]---
RIP: 0010:tss_update_io_bitmap+0x138/0x590 arch/x86/kernel/process.c:395
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 9e 03 00 00 4c 89  
ea 4c 8b 73 68 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 72 03 00 00 4d 3b 75 00 0f 85 35 02 00 00 48 8d
RSP: 0018:ffff8880a4effe80 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff8880ae80a000 RCX: ffffffff812a3228
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8880ae80a068
RBP: ffff8880a4efff10 R08: 1ffff110126f5020 R09: ffffed10126f5021
R10: ffffed10126f5020 R11: ffff8880937a8107 R12: 1ffff110149dffd2
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001e8f880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffff01c2038 CR3: 0000000099c07000 CR4: 00000000001406f0
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
