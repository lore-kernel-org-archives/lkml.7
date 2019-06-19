Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D2CC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D350214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfFSTrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:47:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:43543 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSTrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:47:06 -0400
Received: by mail-io1-f72.google.com with SMTP id y5so817118ioj.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 12:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5QFhad2PBTWE+VNN+RgrE9KegTvvztFjsemnSd/+JYg=;
        b=e0XMZSuis+DDxxjzZafOFz5kH5aKzKiqwFURNcPv1SRDAFrq9E0eXnomyUrCvTAuif
         K0rMJOkZftzn1LcvmGvFSgk8+P6Xf7xaj1oru5LybBW8i8Tcf9WH8OWPwIr3VVZzwXRS
         vh3mNlsuwNfDhXfMdIm71eAIo/T5jVZYNp9xNJz0+ogDediK+6YiyDkaivjf/q2x4z6H
         6jgkasVIj6J2FX0Kp5tKXQccvLL/5J2P64Wh/gwcLll0wVIYax5LtfheVtLDT24gDsXO
         okOKeEocWnNxwsjF4ocpXZjSaOQI+ZYYzFi5gQHYP1sRM9UbWtk4hAQAUZCXQp1jLAbj
         eoAA==
X-Gm-Message-State: APjAAAUSWoLZHBHzTUNB/iaXam2sGmA5Fwied12u13ZvwR3FomuaVsfj
        vMKUhaudxJoZ/0G2KtpH8YnX+IuUgXkle2DbghUlCy8aTuAX
X-Google-Smtp-Source: APXvYqxBjRe3aj/4qM6/AmN8DDSCsN5skp1VMrK+BwqNyZr1WLEEtVp8LQioGfRtL6OUAemRf+I9IGZYu3hhunN7CCDe7nnheIBW
MIME-Version: 1.0
X-Received: by 2002:a02:5b88:: with SMTP id g130mr99697741jab.16.1560973625473;
 Wed, 19 Jun 2019 12:47:05 -0700 (PDT)
Date:   Wed, 19 Jun 2019 12:47:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000734545058bb27ebb@google.com>
Subject: WARNING in perf_reg_value
From:   syzbot <syzbot+10189b9b0f8c4664badd@syzkaller.appspotmail.com>
To:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de,
        eranian@google.com, hpa@zytor.com, jolsa@kernel.org,
        jolsa@redhat.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        vincent.weaver@maine.edu, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0011572c Merge branch 'for-5.2-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c38d66a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
dashboard link: https://syzkaller.appspot.com/bug?extid=10189b9b0f8c4664badd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1434b876a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e6c876a00000

The bug was bisected to:

commit 878068ea270ea82767ff1d26c91583263c81fba0
Author: Kan Liang <kan.liang@linux.intel.com>
Date:   Tue Apr 2 19:44:59 2019 +0000

     perf/x86: Support outputting XMM registers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14556d66a00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16556d66a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12556d66a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+10189b9b0f8c4664badd@syzkaller.appspotmail.com
Fixes: 878068ea270e ("perf/x86: Support outputting XMM registers")

WARNING: CPU: 0 PID: 8516 at arch/x86/kernel/perf_regs.c:71  
perf_reg_value+0xdb/0x110 arch/x86/kernel/perf_regs.c:75
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8516 Comm: syz-executor483 Not tainted 5.2.0-rc4+ #32
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x744 kernel/panic.c:219
  __warn.cold+0x20/0x4d kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:perf_reg_value+0xdb/0x110 arch/x86/kernel/perf_regs.c:71
Code: a0 00 00 00 77 26 48 b8 00 00 00 00 00 fc ff df 48 01 fb 48 89 da 48  
c1 ea 03 80 3c 02 00 75 34 48 8b 03 48 83 c4 08 5b 5d c3 <0f> 0b 48 83 c4  
08 31 c0 5b 5d c3 89 75 f0 e8 72 d6 78 00 8b 75 f0
RSP: 0018:ffff88809674f2b8 EFLAGS: 00010202
RAX: 00000000fffffff9 RBX: ffff88809674fa68 RCX: ffffffff81855a4e
RDX: 0000000000000000 RSI: 0000000000000019 RDI: ffff88809674fa68
RBP: ffff88809674f2c8 R08: ffff888092eda5c0 R09: ffffed1012f92ebb
R10: ffffed1012f92eba R11: ffff888097c975d7 R12: ffff88809674f320
R13: ffff88809674f508 R14: ffff88809674fa68 R15: ffff88809674f700
  perf_output_sample_regs+0xca/0x160 kernel/events/core.c:5914
  perf_output_sample+0x15c2/0x1a90 kernel/events/core.c:6351
  __perf_event_output kernel/events/core.c:6571 [inline]
  perf_event_output_forward+0x150/0x290 kernel/events/core.c:6585
  __perf_event_overflow+0x141/0x370 kernel/events/core.c:8052
  perf_swevent_overflow+0xaa/0x140 kernel/events/core.c:8128
  perf_swevent_event+0x1f7/0x2f0 kernel/events/core.c:8161
  do_perf_sw_event kernel/events/core.c:8269 [inline]
  ___perf_sw_event+0x31c/0x570 kernel/events/core.c:8300
  __perf_sw_event+0x51/0xa0 kernel/events/core.c:8312
  perf_sw_event include/linux/perf_event.h:1083 [inline]
  do_user_addr_fault arch/x86/mm/fault.c:1498 [inline]
  __do_page_fault+0x747/0xda0 arch/x86/mm/fault.c:1523
  do_page_fault+0x71/0x57d arch/x86/mm/fault.c:1554
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1156
RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20  
arch/x86/lib/copy_user_64.S:205
Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f  
80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f  
1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 89 d1 f3 a4
RSP: 0018:ffff88809674fb10 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000001000 RCX: 00000000000001c0
RDX: 0000000000001000 RSI: 0000000020001000 RDI: ffff888099b30e40
RBP: ffff88809674fb48 R08: ffffed1013366200 R09: 0000000000000000
R10: ffffed10133661ff R11: ffff888099b30fff R12: 00000000200001c0
R13: ffff888099b30000 R14: 00000000200011c0 R15: 00007ffffffff000
  copy_page_from_iter_iovec lib/iov_iter.c:295 [inline]
  copy_page_from_iter+0x3ad/0x7d0 lib/iov_iter.c:921
  pipe_write+0x281/0xf30 fs/pipe.c:454
  call_write_iter include/linux/fs.h:1872 [inline]
  new_sync_write+0x4d3/0x770 fs/read_write.c:483
  __vfs_write+0xe1/0x110 fs/read_write.c:496
  vfs_write+0x20c/0x580 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440529
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe36867c38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440529
RDX: 000000010000026f RSI: 00000000200001c0 RDI: 0000000000000007
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401db0
R13: 0000000000401e40 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
