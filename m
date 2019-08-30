Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605BDC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458F421897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfH3T2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:28:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41119 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbfH3T2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:28:09 -0400
Received: by mail-io1-f71.google.com with SMTP id t8so9650668iom.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FsZT3YOiyb+RSdO03B9uEqR9QzRRsgEZdKe73XL3LGE=;
        b=EWfc6nZbo+YHa5T3BUMcgJFXAE/UG8+WLGu1SZTTzXq3c3pZ8CF3TcZp5/Mqq0tgy1
         +fiWLwasNq4I1vRt1uFlGo6jyA+Q0JQ7XqmwaJs7CeVilURQ2GeoCJD4EamNI4qC4XeS
         8l6RTPbVoS+xsEGKxOQQSUxtboKndnsHD/ScLHJXADvjQsxOcoSa3wQ3QMSe+DVZ9LTt
         cQTsqnqprQvMO/8S33fuRLUqIM30F+T2QvvdLGnOGTGKM00D+KBkggREOsn4FvPtIOMY
         q2jL4OwkXw2Aaf3Z/sF98mtiXy5LhJdDbF6ozxt//wOJXopt+Y9ByrBeujlFru8TpL/8
         g75Q==
X-Gm-Message-State: APjAAAWl0gxhm5++GnMQqvomERr9bqPOWlBumFof0BU8To/fXkx6H3N5
        KjM7v3rLzo51HP1aY9gFOtcX49JJ+HQZZ096/wHvVasr5aIX
X-Google-Smtp-Source: APXvYqyIC295ngKPQvaPHvVRjgln7ZY90xzgn2aZ5O1dn/DrG9wZm3Vq2gAOhal8qpX/PfOpzXdW2QpihYYiAcBNzXYuuaem2zH0
MIME-Version: 1.0
X-Received: by 2002:a6b:ba85:: with SMTP id k127mr904273iof.101.1567193287992;
 Fri, 30 Aug 2019 12:28:07 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:28:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039af4d05915a9f56@google.com>
Subject: INFO: task hung in p9_fd_close
From:   syzbot <syzbot+8b41a1365f1106fd0f33@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6525771f Merge tag 'arc-5.3-rc7' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1118a71e600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58485246ad14eafe
dashboard link: https://syzkaller.appspot.com/bug?extid=8b41a1365f1106fd0f33
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1125ee12600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8b41a1365f1106fd0f33@syzkaller.appspotmail.com

INFO: task syz-executor.1:13699 blocked for more than 143 seconds.
       Not tainted 5.3.0-rc6+ #94
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D28888 13699   9148 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:3254 [inline]
  __schedule+0x877/0xc50 kernel/sched/core.c:3880
  schedule+0x131/0x1e0 kernel/sched/core.c:3947
  schedule_timeout+0x46/0x240 kernel/time/timer.c:1783
  do_wait_for_common+0x2e7/0x4d0 kernel/sched/completion.c:83
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x47/0x60 kernel/sched/completion.c:136
  __flush_work+0xd4/0x150 kernel/workqueue.c:3040
  __cancel_work_timer+0x420/0x570 kernel/workqueue.c:3127
  cancel_work_sync+0x17/0x20 kernel/workqueue.c:3163
  p9_conn_destroy net/9p/trans_fd.c:868 [inline]
  p9_fd_close+0x297/0x3c0 net/9p/trans_fd.c:898
  p9_client_create+0x974/0xee0 net/9p/client.c:1068
  v9fs_session_init+0x192/0x18e0 fs/9p/v9fs.c:406
  v9fs_mount+0x82/0x810 fs/9p/vfs_super.c:120
  legacy_get_tree+0xf9/0x1a0 fs/fs_context.c:661
  vfs_get_tree+0x8f/0x380 fs/super.c:1413
  do_new_mount fs/namespace.c:2791 [inline]
  do_mount+0x169d/0x2490 fs/namespace.c:3111
  ksys_mount+0xcc/0x100 fs/namespace.c:3320
  __do_sys_mount fs/namespace.c:3334 [inline]
  __se_sys_mount fs/namespace.c:3331 [inline]
  __x64_sys_mount+0xbf/0xd0 fs/namespace.c:3331
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459879
Code: 8b 44 24 18 48 8b 4c 24 30 48 83 c1 08 48 89 0c 24 48 89 44 24 08 48  
c7 44 24 10 10 00 00 00 e8 0d da fa ff 48 8b 44 24 18 48 <89> 44 24 40 48  
8b 6c 24 20 48 83 c4 28 c3 e8 14 b9 ff ff eb 82 cc
RSP: 002b:00007f6b4dda7c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000459879
RDX: 0000000020000140 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 000000000075c118 R08: 0000000020000480 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6b4dda86d4
R13: 00000000004c5e2f R14: 00000000004da930 R15: 00000000ffffffff
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 1057 Comm: khungtaskd Not tainted 5.3.0-rc6+ #94
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  nmi_cpu_backtrace+0xaf/0x1a0 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x174/0x290 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x10/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace+0x17/0x20 include/linux/nmi.h:146
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xbb9/0xbd0 kernel/hung_task.c:289
  kthread+0x332/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0xe/0x10  
arch/x86/include/asm/irqflags.h:60


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
