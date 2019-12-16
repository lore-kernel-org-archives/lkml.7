Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DB1C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A6220726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLPFfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 00:35:09 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43190 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfLPFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 00:35:09 -0500
Received: by mail-il1-f197.google.com with SMTP id j17so5638968ilc.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 21:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cHr4ZU/jGrchslHcHxin8DI3JprrZdqhtemz0Ks88H4=;
        b=NbmeGToPisdqxm9wN8ujT4eDFUIzd5xKjrvlZQsX6v1ufEq+uNK0G6e83aIFy8/Asq
         x4WiITIv68LS2ed7RqNYot6G7Xvn5aPtQvLx7Byz/R8wtAJy+MvLFNNty5dweidwM2Qw
         3EoUdATtfD2Z2o/hfLhzjZ6lJ+pwtnX8gDGqDDE7NJ4WxfG3R42dIzM1GiHtd+wdtbIz
         A2VuOCLBZRSUwO3BSu79OhBkPWAdGannYlCEuDelV8R1nMQML6rkxRLbOP5R46yrtHjJ
         ogQonxAbNVwpwjONwiGXJzIygBHyIQdXioZHhMSbRvCgly3u0f+6X06AXeA1qhxedOjP
         hNlQ==
X-Gm-Message-State: APjAAAW/4icB4HRfE7EgTsiZ40py4e0LdasKnlBznlEtt58hJS+02ffj
        DnbIq+A89p9bCxvEtwzlnu/awk/mhxhDetZ3glLkG3tl1PDL
X-Google-Smtp-Source: APXvYqzURFIZ3bDDaQdm+J0sxjHtpAYH2DEpLU+Ch5WuszpZ0H/d6ChYBqfNhHJyDEQ1YHOAvkOGtCKrAbUjYbiIGZfTuc/4obGI
MIME-Version: 1.0
X-Received: by 2002:a92:bbc1:: with SMTP id x62mr9930741ilk.156.1576474508281;
 Sun, 15 Dec 2019 21:35:08 -0800 (PST)
Date:   Sun, 15 Dec 2019 21:35:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001051650599cb9358@google.com>
Subject: BUG: sleeping function called from invalid context in __do_page_fault
From:   syzbot <syzbot+9d337da2f26f10358060@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    07c4b9e9 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1225508ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=9d337da2f26f10358060
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d337da2f26f10358060@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at  
arch/x86/mm/fault.c:1399
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 9240, name:  
syz-executor.3
1 lock held by syz-executor.3/9240:
  #0: ffff8880927eb918 (&mm->mmap_sem#2){++++}, at: do_user_addr_fault  
arch/x86/mm/fault.c:1382 [inline]
  #0: ffff8880927eb918 (&mm->mmap_sem#2){++++}, at:  
__do_page_fault+0x33c/0xd80 arch/x86/mm/fault.c:1506
irq event stamp: 741026
hardirqs last  enabled at (741025): [<ffffffff81a342d0>] count_memcg_events  
include/linux/memcontrol.h:750 [inline]
hardirqs last  enabled at (741025): [<ffffffff81a342d0>]  
count_memcg_event_mm include/linux/memcontrol.h:771 [inline]
hardirqs last  enabled at (741025): [<ffffffff81a342d0>]  
handle_mm_fault+0x7a0/0xa50 mm/memory.c:4092
hardirqs last disabled at (741026): [<ffffffff8100675f>]  
trace_hardirqs_off_thunk+0x1a/0x1c arch/x86/entry/thunk_64.S:42
softirqs last  enabled at (737900): [<ffffffff880006cd>]  
__do_softirq+0x6cd/0x98c kernel/softirq.c:319
softirqs last disabled at (737885): [<ffffffff81478ceb>] invoke_softirq  
kernel/softirq.c:373 [inline]
softirqs last disabled at (737885): [<ffffffff81478ceb>]  
irq_exit+0x19b/0x1e0 kernel/softirq.c:413
CPU: 0 PID: 9240 Comm: syz-executor.3 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6800
  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
  do_user_addr_fault arch/x86/mm/fault.c:1399 [inline]
  __do_page_fault+0x369/0xd80 arch/x86/mm/fault.c:1506
  do_page_fault+0x38/0x590 arch/x86/mm/fault.c:1530
  page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0010:prepare_exit_to_usermode+0x157/0x3a0 arch/x86/entry/common.c:189
Code: 00 00 00 fc ff df 65 4c 8b 2c 25 c0 1e 02 00 49 8d bd 94 08 00 00 48  
89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 <38> 00 00 00 00  
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0000:ffffc90001ea7f28 EFLAGS: 00010002
RAX: 0000000000000007 RBX: ffff88805d892000 RCX: ffffffff81009b3f
RDX: 0000000000000000 RSI: ffffffff81009b49 RDI: ffff88805d892894
RBP: ffffc90001ea7f48 R08: ffff88805d892000 R09: ffffed100bb12401
R10: ffffed100bb12400 R11: ffff88805d892007 R12: ffffc90001ea7f58
R13: ffff88805d892000 R14: 0000000000000000 R15: 0000000000000000
  ret_from_intr+0x26/0x36
RIP: 0033:0x4036e2
Code: 55 41 54 49 89 fc 55 53 48 81 ec b8 10 00 00 64 48 8b 04 25 28 00 00  
00 48 89 84 24 a8 10 00 00 31 c0 be 02 00 00 00 4c 89 e7 <e8> 49 9c 05 00  
85 c0 0f 84 00 03 00 00 4c 89 e7 e8 69 51 05 00 48
RSP: 002b:0000000000a6ecc0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000004a9df RCX: 00000000004143c0
RDX: 000000000000000c RSI: 0000000000000002 RDI: 0000000000a6fdf0
RBP: 00000000000000c2 R08: 0000000000000001 R09: 0000000001d5f940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000a6fdf0
R13: 0000000000a6fde0 R14: 0000000000000000 R15: 0000000000a6fdf0
BUG: kernel NULL pointer dereference, address: 0000000000000007
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 5d84a067 P4D 5d84a067 PUD 5d84b067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9240 Comm: syz-executor.3 Tainted: G        W          
5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:prepare_exit_to_usermode+0x157/0x3a0 arch/x86/entry/common.c:189
Code: 00 00 00 fc ff df 65 4c 8b 2c 25 c0 1e 02 00 49 8d bd 94 08 00 00 48  
89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 <38> 00 00 00 00  
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0000:ffffc90001ea7f28 EFLAGS: 00010002
RAX: 0000000000000007 RBX: ffff88805d892000 RCX: ffffffff81009b3f
RDX: 0000000000000000 RSI: ffffffff81009b49 RDI: ffff88805d892894
RBP: ffffc90001ea7f48 R08: ffff88805d892000 R09: ffffed100bb12401
R10: ffffed100bb12400 R11: ffff88805d892007 R12: ffffc90001ea7f58
R13: ffff88805d892000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001d5f940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000007 CR3: 000000005d849000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ret_from_intr+0x26/0x36
RIP: 0033:0x4036e2
Code: 55 41 54 49 89 fc 55 53 48 81 ec b8 10 00 00 64 48 8b 04 25 28 00 00  
00 48 89 84 24 a8 10 00 00 31 c0 be 02 00 00 00 4c 89 e7 <e8> 49 9c 05 00  
85 c0 0f 84 00 03 00 00 4c 89 e7 e8 69 51 05 00 48
RSP: 002b:0000000000a6ecc0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000004a9df RCX: 00000000004143c0
RDX: 000000000000000c RSI: 0000000000000002 RDI: 0000000000a6fdf0
RBP: 00000000000000c2 R08: 0000000000000001 R09: 0000000001d5f940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000a6fdf0
R13: 0000000000a6fde0 R14: 0000000000000000 R15: 0000000000a6fdf0
Modules linked in:
CR2: 0000000000000007
---[ end trace 130dd6b41d308e67 ]---
RIP: 0010:prepare_exit_to_usermode+0x157/0x3a0 arch/x86/entry/common.c:189
Code: 00 00 00 fc ff df 65 4c 8b 2c 25 c0 1e 02 00 49 8d bd 94 08 00 00 48  
89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 <38> 00 00 00 00  
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0000:ffffc90001ea7f28 EFLAGS: 00010002
RAX: 0000000000000007 RBX: ffff88805d892000 RCX: ffffffff81009b3f
RDX: 0000000000000000 RSI: ffffffff81009b49 RDI: ffff88805d892894
RBP: ffffc90001ea7f48 R08: ffff88805d892000 R09: ffffed100bb12401
R10: ffffed100bb12400 R11: ffff88805d892007 R12: ffffc90001ea7f58
R13: ffff88805d892000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001d5f940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000007 CR3: 000000005d849000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
