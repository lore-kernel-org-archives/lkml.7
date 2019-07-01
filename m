Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E591C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F3D208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfGAI1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:27:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54200 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfGAI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:27:05 -0400
Received: by mail-io1-f71.google.com with SMTP id h3so14397339iob.20
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 01:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GC+x39g8IYbrwQLY2vbqdImonYYsq5udUTs88YPbw4c=;
        b=FIlfTJP72i6D/ruzY1xVKWFD0ceelLH+tvXu3SNxWsX1vT7Scfq7BOoCPtzihLG36D
         EKdSIQQU2+q5HEJd1MhNFMDa2PBzvHlTmV8QcuVBuu30ZEB/DBe8ZQIA2OkPShg71qIr
         FBCaAEJyVzMxpe3pYZSwNsVeOdiMOryJ7E79sqgYV6b9zWxuLJv63LV58WZBd/DUK5WJ
         cvIN+SnapYsz7tDlNDf8BpBvuXCZ3KXGAbbF36033GNpeLCLBPmxEHuK1RzRHxCe10dM
         DE6Tt2Z20maeTxTcvMjcIXsQNn9x5Q/MYFoazEZhBDfT9JlvsNo54GGJIN+sZA/r/8dk
         4JDQ==
X-Gm-Message-State: APjAAAW185jiMiweLio01ob92ZkbR0b69zBsPWn41lTYID10Dl0s0gfr
        D6owzdg7xpNYUj/YFqg47KOWy2DZu0PThM1SVhgm7LSxHgsC
X-Google-Smtp-Source: APXvYqzXk16c6JPKZk5Bi6NHsGlxPqYqwOLITlQ/xP5jq0+WNDdT9E5QYirBgLcGdfA7650FRi5Q8lkOPCoGC4bgX5mQkGfnsHjy
MIME-Version: 1.0
X-Received: by 2002:a5d:8890:: with SMTP id d16mr8303258ioo.274.1561969624992;
 Mon, 01 Jul 2019 01:27:04 -0700 (PDT)
Date:   Mon, 01 Jul 2019 01:27:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5d3cb058c9a64f0@google.com>
Subject: kernel panic: corrupted stack end in dput
From:   syzbot <syzbot+d88a977731a9888db7ba@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7b75e49d net: dsa: mv88e6xxx: wait after reset deactivation
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10f51b13a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7c31a94f66cc0aa
dashboard link: https://syzkaller.appspot.com/bug?extid=d88a977731a9888db7ba
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130f49bda00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d88a977731a9888db7ba@syzkaller.appspotmail.com

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 1 PID: 8936 Comm: syz-executor.3 Not tainted 5.2.0-rc6+ #69
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x744 kernel/panic.c:219
  schedule_debug kernel/sched/core.c:3272 [inline]
  __schedule+0x155d/0x1560 kernel/sched/core.c:3381
  preempt_schedule_notrace kernel/sched/core.c:3664 [inline]
  preempt_schedule_notrace+0xa0/0x130 kernel/sched/core.c:3635
  ___preempt_schedule_notrace+0x16/0x2f
  rcu_is_watching+0x23/0x30 kernel/rcu/tree.c:873
  rcu_read_lock include/linux/rcupdate.h:594 [inline]
  dput+0x41e/0x690 fs/dcache.c:845
  __fput+0x424/0x890 fs/file_table.c:293
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:185 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:168
  prepare_exit_to_usermode arch/x86/entry/common.c:199 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
  do_syscall_64+0x58e/0x680 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413201
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffcee6f8e20 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000413201
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000001 R08: ffffffffffffffff R09: ffffffffffffffff
R10: 00007ffcee6f8f00 R11: 0000000000000293 R12: 000000000075c9a0
R13: 000000000075c9a0 R14: 00000000000127ed R15: ffffffffffffffff
Shutting down cpus with NMI
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
