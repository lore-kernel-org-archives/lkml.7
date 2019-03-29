Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F8D218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfC2WeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:34:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39806 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfC2WeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:34:06 -0400
Received: by mail-io1-f71.google.com with SMTP id c17so2898117iot.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1MpGLydJK6kRhkUNlBZIUXo3MtEC4ma2/eQn9OW27+k=;
        b=sjSyhitd6qcQQq+151fnquanOe93frrlFBlu6BgrxLdL6mJxe48xFtwc9pWeWxCWvR
         ypdE6gh8yJeGwufXvtAON9WszljLSJFf7qGpHM1uNQqG0CyIpmwQ1ukV1jjVD0/cHKx2
         vSKrKqnSb5gFz1KTOOv5HtXxSLKXfOwVGHRs9eTPT8oUsl8zq9o552tQi7WY364CgTpW
         bx0o3aPm1I8slddREs96pMW3V7/r04AFt82/YKvyy7ObUW1ynS8hRRfLye92BycphThX
         NDrt9uosgwbVnNuYwwUTJNKe4XqRf5D1bV2+mAtFYj+NncNFFkT12T7sMnn6k2+zREJb
         5T4g==
X-Gm-Message-State: APjAAAU6F/Xqf9q5rkEypzXSY2Al+dAAhb1SdLHcOWZnhZPZvn8Lp9hg
        AA6vChA/lgRkM+HzOcTFEnkYprUqZMCrrdvsc0cyGkXIiCHC
X-Google-Smtp-Source: APXvYqzhBehMTWHxdZGBwlbwuh2wsN6bHpxa6haBW9EuTOO0gDmAhMltjWji0i9vMcwU9uFg/JRwXEx03FtZ9bSVgGkS04FSXEiU
MIME-Version: 1.0
X-Received: by 2002:a24:7b4c:: with SMTP id q73mr2543141itc.1.1553898845272;
 Fri, 29 Mar 2019 15:34:05 -0700 (PDT)
Date:   Fri, 29 Mar 2019 15:34:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b08190058543449f@google.com>
Subject: INFO: rcu detected stall in corrupted (3)
From:   syzbot <syzbot+65cecdd27b726c261799@syzkaller.appspotmail.com>
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

HEAD commit:    8c2ffd91 Linux 5.1-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15099d2b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
dashboard link: https://syzkaller.appspot.com/bug?extid=65cecdd27b726c261799
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d3c67d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d4f317200000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111a358b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=151a358b200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+65cecdd27b726c261799@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P8340
rcu: 	(detected by 1, t=10502 jiffies, g=5905, q=81)
syz-executor586 R  running task    27832  8340   8338 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3518
  preempt_schedule_common+0x4f/0xe0 kernel/sched/core.c:3642
  preempt_schedule+0x4b/0x60 kernel/sched/core.c:3668
  ___preempt_schedule+0x16/0x18
  __sched_setscheduler+0x12fb/0x1e70 kernel/sched/core.c:4398
  sched_setattr kernel/sched/core.c:4440 [inline]
  __do_sys_sched_setattr kernel/sched/core.c:4616 [inline]
  __se_sys_sched_setattr kernel/sched/core.c:4595 [inline]
  __x64_sys_sched_setattr+0x184/0x2b0 kernel/sched/core.c:4595
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4403c9
Code: 76 77 78 5d 20 5b 2d 6c 3c 68 6f 73 74 6c 69 73 74 3e 5d 20 5b 2d 73  
3c 64 6f 6d 61 69 6e 6c 69 73 74 3e 5d 0a 20 20 20 20 20 <20> 20 20 20 20  
20 20 20 20 20 20 5b 2d 66 3c 63 6f 6e 66 66 69 6c
RSP: 002b:00007ffea1a49298 EFLAGS: 00000246 ORIG_RAX: 000000000000013a
RAX: ffffffffffffffda RBX: 00007ffea1a49340 RCX: 00000000004403c9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000002b80 R09: 0000000000400d10
R10: 000000000000f8f8 R11: 0000000000000246 R12: 0000000000401c90
R13: 0000000000401d20 R14: 0000000000000000 R15: 0000000000000000
syz-executor586 R  running task    27832  8340   8338 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3518
  preempt_schedule_common+0x4f/0xe0 kernel/sched/core.c:3642
  preempt_schedule+0x4b/0x60 kernel/sched/core.c:3668
  ___preempt_schedule+0x16/0x18
  __sched_setscheduler+0x12fb/0x1e70 kernel/sched/core.c:4398
  sched_setattr kernel/sched/core.c:4440 [inline]
  __do_sys_sched_setattr kernel/sched/core.c:4616 [inline]
  __se_sys_sched_setattr kernel/sched/core.c:4595 [inline]
  __x64_sys_sched_setattr+0x184/0x2b0 kernel/sched/core.c:4595
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4403c9
Code: 76 77 78 5d 20 5b 2d 6c 3c 68 6f 73 74 6c 69 73 74 3e 5d 20 5b 2d 73  
3c 64 6f 6d 61 69 6e 6c 69 73 74 3e 5d 0a 20 20 20 20 20 <20> 20 20 20 20  
20 20 20 20 20 20 5b 2d 66 3c 63 6f 6e 66 66 69 6c
RSP: 002b:00007ffea1a49298 EFLAGS: 00000246 ORIG_RAX: 000000000000013a
RAX: ffffffffffffffda RBX: 00007ffea1a49340 RCX: 00000000004403c9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000002b80 R09: 0000000000400d10
R10: 000000000000f8f8 R11: 0000000000000246 R12: 0000000000401c90
R13: 0000000000401d20 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
