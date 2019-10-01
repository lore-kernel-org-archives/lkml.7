Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA73FA373E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9732133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732821AbfJAIJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:09:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35721 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfJAIJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:09:08 -0400
Received: by mail-io1-f72.google.com with SMTP id r5so36892020iop.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 01:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TZHnxnwBg9SWjzB7PgFtARNKqp6U2FwwKhFhMBiCm1A=;
        b=h2E7Ow1fCzp416UGgRrp2St/ndmx7IW/ogr4Tes95IIY9uY56mW0+2TN+OtEkMll0w
         /DNkTkH0ePMF+jcpjvQUZbgjEr6eMDbNP52b8DlTc0hp4lnjRS/8bIu4NY748gmeItUL
         y0b+o1M05cntixwlI1Fl+lH0Qn7IqzFI23AOQdP0E3KtZ8UwFa+Irc5uEeIryxe3kfzb
         qVyT9WjaHQQ9J343LG6bssM3ZqIZ1jNdNKaijI0xCrevgKp3HyRHG0lAShgBKr7vPGum
         VfIhcp8XDOWkohZvd129t0Z9WBNS6U/9Co5i6XynWeLuLMP7snZ6yTxf5cocLOUF2AtQ
         3veQ==
X-Gm-Message-State: APjAAAVtTyxCm345VTfHDG5CKdT2TuWk4iM2WyTM2UeqxYlP8PYtmNDD
        ytqTfYykbixVWLh1qiCi/V+2WgPJ1xXUoM5Y1vfaJeRz6g6S
X-Google-Smtp-Source: APXvYqxgbr572cFCbhUsMP6ST+ceDbszU4NdaJ6ifddLVEg15jlzjWHqfaXjJvaUSsAk/DTqniDWsNpg2CMVrNuV9XsKoeBFbV+V
MIME-Version: 1.0
X-Received: by 2002:a6b:c947:: with SMTP id z68mr25337767iof.132.1569917347453;
 Tue, 01 Oct 2019 01:09:07 -0700 (PDT)
Date:   Tue, 01 Oct 2019 01:09:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2661c0593d4dd89@google.com>
Subject: WARNING in rcu_note_context_switch
From:   syzbot <syzbot+0e1a9dce275f13907b4e@syzkaller.appspotmail.com>
To:     dvhart@infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    54ecb8f7 Linux 5.4-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14972bf3600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb0b431ccdf08c1c
dashboard link: https://syzkaller.appspot.com/bug?extid=0e1a9dce275f13907b4e
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16875a35600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104bd519600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0e1a9dce275f13907b4e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7994 at kernel/rcu/tree_plugin.h:293  
rcu_note_context_switch+0xdde/0xee0 kernel/rcu/tree_plugin.h:293
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7994 Comm: syz-executor640 Not tainted 5.4.0-rc1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  panic+0x25c/0x799 kernel/panic.c:220
  __warn+0x20e/0x210 kernel/panic.c:581
  report_bug+0x1b6/0x2f0 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:rcu_note_context_switch+0xdde/0xee0 kernel/rcu/tree_plugin.h:293
Code: c8 73 4b 00 e9 b8 f3 ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 22 f3  
ff ff 48 89 df e8 4b 73 4b 00 83 3b 00 0f 8e 1a f3 ff ff <0f> 0b e9 13 f3  
ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c c9 f2 ff
RSP: 0018:ffff8880a929f838 EFLAGS: 00010002
RAX: 1ffff110126bc800 RBX: ffff8880935e46f8 RCX: ffffffff81608604
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff88be39a0
RBP: ffff8880a929f918 R08: dffffc0000000000 R09: fffffbfff117c735
R10: fffffbfff117c735 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880935e4380 R14: 0000000000000000 R15: ffff8880aeb35740
  __schedule+0xce/0xb80 kernel/sched/core.c:4007
  schedule+0x131/0x1e0 kernel/sched/core.c:4136
  freezable_schedule include/linux/freezer.h:172 [inline]
  futex_wait_queue_me+0x2a3/0x4b0 kernel/futex.c:2627
  futex_wait+0x252/0x770 kernel/futex.c:2733
  do_futex+0x42a/0x3de0 kernel/futex.c:3644
  __do_sys_futex kernel/futex.c:3705 [inline]
  __se_sys_futex+0x28c/0x360 kernel/futex.c:3673
  __x64_sys_futex+0xe5/0x100 kernel/futex.c:3673
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446709
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff032150db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446709
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc28
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffcc4d0fa9f R14: 00007ff0321519c0 R15: 000000000000002d
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
