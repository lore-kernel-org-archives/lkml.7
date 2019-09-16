Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B916EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828FF2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfIPXjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:39:09 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40862 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIPXjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:39:09 -0400
Received: by mail-io1-f69.google.com with SMTP id l9so2689356ioj.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iKc+zhdxH+3nqPb6vBtY+hBOW4mmEkW3AOEpTJNuYoo=;
        b=HelZmqbE+HmH/x5R5FipqklfLB2KieOswY6j4Yzq47vAufE0LBVpILNQrWvU8lT13v
         fPnUpg6O7XZVRAgJaYoTSublecp7k491PnrP7FQW/E0CCJdzoFfq63k43CjGqTCfo4ja
         EdJblxTD9U9F6TFLyAuCAQStt6D/rJJaIYLx11yDTj0QcPmUU+9YZ/FGoTqS6W6dDWEG
         JBCEEq6z0sjKlLeRJFfswAKjVR8M/KJgCd9/GBs0NvjfvnP72N2doEaBglC1vlB6uqdK
         QHbmOtGgKqgcEycm2I1lFAypsf2ahN557wushbowx/1og7NVSNYnE4eOvyYXDAjYTG4e
         jxxQ==
X-Gm-Message-State: APjAAAXDOONQQdo+64dl0BLk0wHYTiSYyWJaufldmM0wfTNF/7VYr6ob
        XYvPLNMXDmmu/vbqrU9n95QYJC9xx7nnz5bUWvG0txreAi3l
X-Google-Smtp-Source: APXvYqxyRmV1cJ7RB0nr2RIYjAg5oky0Es0WzQT7R66QLfOWteLexRkpo4qSHaQHFZBp0Y0+LSzkW44fNJr9uwdiA5i9EnC4OfDQ
MIME-Version: 1.0
X-Received: by 2002:a02:1c02:: with SMTP id c2mr814086jac.118.1568677148227;
 Mon, 16 Sep 2019 16:39:08 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:39:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003006220592b41c5b@google.com>
Subject: general protection fault in trace_probe_unlink
From:   syzbot <syzbot+2f807f4d3a2a4e87f18f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        mingo@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2015a28f Add linux-next specific files for 20190915
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10f1dc65600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=110691c2286b679a
dashboard link: https://syzkaller.appspot.com/bug?extid=2f807f4d3a2a4e87f18f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e2ff1600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1255ba65600000

The bug was bisected to:

commit ca89bc071d5e4e981dcc52e0ca90f4500d332e42
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Wed Jun 19 15:07:49 2019 +0000

     tracing/kprobe: Add multi-probe per event support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a0f2b5600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1460f2b5600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1060f2b5600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2f807f4d3a2a4e87f18f@syzkaller.appspotmail.com
Fixes: ca89bc071d5e ("tracing/kprobe: Add multi-probe per event support")

RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00007ffc04171a30 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8633 Comm: syz-executor797 Not tainted 5.3.0-rc8-next-20190915  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0x85/0xf5 lib/list_debug.c:51
Code: 0f 84 e1 00 00 00 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 e2 00  
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75  
53 49 8b 14 24 4c 39 f2 0f 85 99 00 00 00 49 8d 7d
RSP: 0018:ffff888090a7f9d8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88809b6f90c0 RCX: ffffffff817c0ca9
RDX: 0000000000000000 RSI: ffffffff817c0a73 RDI: ffff88809b6f90c8
RBP: ffff888090a7f9f0 R08: ffff88809a04e600 R09: ffffed1015d26aed
R10: ffffed1015d26aec R11: ffff8880ae935763 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88809b6f90c0 R15: ffff88809b6f90d0
FS:  0000555556f99880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cc090 CR3: 00000000962b2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:131 [inline]
  list_del_init include/linux/list.h:190 [inline]
  trace_probe_unlink+0x1f/0x200 kernel/trace/trace_probe.c:959
  trace_probe_cleanup+0xd3/0x110 kernel/trace/trace_probe.c:973
  trace_probe_init+0x3f2/0x510 kernel/trace/trace_probe.c:1011
  alloc_trace_uprobe+0x5e/0x250 kernel/trace/trace_uprobe.c:353
  create_local_trace_uprobe+0x109/0x4a0 kernel/trace/trace_uprobe.c:1508
  perf_uprobe_init+0x131/0x210 kernel/trace/trace_event_perf.c:314
  perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:8898
  perf_try_init_event+0x135/0x590 kernel/events/core.c:10184
  perf_init_event kernel/events/core.c:10228 [inline]
  perf_event_alloc.part.0+0x1b89/0x33d0 kernel/events/core.c:10505
  perf_event_alloc kernel/events/core.c:10887 [inline]
  __do_sys_perf_event_open+0xa2d/0x2d00 kernel/events/core.c:10989
  __se_sys_perf_event_open kernel/events/core.c:10871 [inline]
  __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10871
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441269
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc04171a18 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441269
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00007ffc04171a30 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace ef71b9b0abb5d24f ]---
RIP: 0010:__list_del_entry_valid+0x85/0xf5 lib/list_debug.c:51
Code: 0f 84 e1 00 00 00 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 e2 00  
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75  
53 49 8b 14 24 4c 39 f2 0f 85 99 00 00 00 49 8d 7d
RSP: 0018:ffff888090a7f9d8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88809b6f90c0 RCX: ffffffff817c0ca9
RDX: 0000000000000000 RSI: ffffffff817c0a73 RDI: ffff88809b6f90c8
RBP: ffff888090a7f9f0 R08: ffff88809a04e600 R09: ffffed1015d26aed
R10: ffffed1015d26aec R11: ffff8880ae935763 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88809b6f90c0 R15: ffff88809b6f90d0
FS:  0000555556f99880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cc090 CR3: 00000000962b2000 CR4: 00000000001406e0
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
