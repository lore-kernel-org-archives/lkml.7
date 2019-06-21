Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5286FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3085E21530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfFUM5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:57:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37429 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfFUM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:57:09 -0400
Received: by mail-io1-f72.google.com with SMTP id j18so10611403ioj.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 05:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Zvbsmz/vlPAoWqOvDPCv7wJ7c1FJsPtQmsqpqt7onR0=;
        b=n2RN64VNS4N/01CENNBl3rRQ7y+UHENi8i95L7NGBahTQ1XaXWgHX8kK3TrlC75CVe
         8nMGY4HAaLhqqXmdLfqP/vrFRsHgfkw1YMBul1ABUvCp7rZ4EsPiBAka4h6unbFWENX1
         fPyYvegT1s4pWmB7D9ZGqHtF6py6Wp15YUK/cFmonKcwluXEdZ3vMo/pC7fKJjCEFH5v
         InJQJ+NQmLQm/MiXwWq7eb5LSmA5qpHY3iHEw2QyN9t7sG6PO7W9kocK0PgMtk/4M4FZ
         Kq2OAiSc9THujIqB0wP8g0wTwikNJjxQI3I1NO912lETC5uHMxpU1sgLWvC9MCtldDzv
         /OVA==
X-Gm-Message-State: APjAAAXAWM2FNUXc1Yn8pHUXHUv4+nF5uNeG12oEY3t0zGYAfzrG485N
        rlWBW/L+oAmFPdxiuNo72x6H5O+7DiANMAkbi2u3uDndmKC6
X-Google-Smtp-Source: APXvYqwEtzOE6MToHSnFavYNNM9pK5WauqLIQEFUcQFXggOthTW2Cv4zFZxtLBTE+D9ryHlUfqnbCBZAvBTGc2aikpUcwBRxQpPd
MIME-Version: 1.0
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr16766423iog.43.1561121828431;
 Fri, 21 Jun 2019 05:57:08 -0700 (PDT)
Date:   Fri, 21 Jun 2019 05:57:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008f38a058bd500b9@google.com>
Subject: BUG: unable to handle kernel paging request in cpuacct_account_field
From:   syzbot <syzbot+a952f743523593b39174@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164d94f6a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
dashboard link: https://syzkaller.appspot.com/bug?extid=a952f743523593b39174
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1372abc6a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a952f743523593b39174@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffde202771d9b9
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Thread overran stack, or stack corrupted
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8777 Comm: syz-executor.5 Not tainted 5.2.0-rc5+ #38
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:cpuacct_account_field+0x12b/0x2f0 kernel/sched/cpuacct.c:366
Code: c5 60 02 75 88 48 89 fa 48 c1 ea 03 42 80 3c 32 00 0f 85 81 01 00 00  
48 03 1c c5 60 02 75 88 4a 8d 3c 3b 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00  
0f 85 89 01 00 00 4e 01 2c 3b 49 8d bc 24 28 01 00
RSP: 0018:ffff8880ae909c78 EFLAGS: 00010802
RAX: 1fffe2202771d9b9 RBX: ffff11013b8ecdb8 RCX: ffffffff83358d3e
RDX: 1ffffffff10ea04d RSI: ffffffff83358d4c RDI: ffff11013b8ecdc8
RBP: ffff8880ae909ca8 R08: ffff888090866500 R09: 0000000000000001
R10: fffffbfff1141b45 R11: ffff888090866500 R12: ffff88808cfecc80
R13: 0000000000966a20 R14: dffffc0000000000 R15: 0000000000000010
FS:  0000555555ff5940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffde202771d9b9 CR3: 000000008533e000 CR4: 00000000001406e0
Call Trace:
  <IRQ>
  cgroup_account_cputime_field include/linux/cgroup.h:789 [inline]
  task_group_account_field kernel/sched/cputime.c:109 [inline]
  account_system_index_time+0x11d/0x390 kernel/sched/cputime.c:172
  irqtime_account_process_tick.isra.0+0x386/0x490 kernel/sched/cputime.c:389
  account_process_tick+0x27f/0x350 kernel/sched/cputime.c:484
  update_process_times+0x25/0x80 kernel/time/timer.c:1637
  tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:167
  tick_sched_timer+0x47/0x130 kernel/time/tick-sched.c:1298
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x33b/0xdd0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
  smp_apic_timer_interrupt+0x111/0x550 arch/x86/kernel/apic/apic.c:1066
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
  </IRQ>
Modules linked in:
CR2: ffffde202771d9b9
---[ end trace 4a0799d29c250606 ]---
RIP: 0010:cpuacct_account_field+0x12b/0x2f0 kernel/sched/cpuacct.c:366
Code: c5 60 02 75 88 48 89 fa 48 c1 ea 03 42 80 3c 32 00 0f 85 81 01 00 00  
48 03 1c c5 60 02 75 88 4a 8d 3c 3b 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00  
0f 85 89 01 00 00 4e 01 2c 3b 49 8d bc 24 28 01 00
RSP: 0018:ffff8880ae909c78 EFLAGS: 00010802
RAX: 1fffe2202771d9b9 RBX: ffff11013b8ecdb8 RCX: ffffffff83358d3e
RDX: 1ffffffff10ea04d RSI: ffffffff83358d4c RDI: ffff11013b8ecdc8
RBP: ffff8880ae909ca8 R08: ffff888090866500 R09: 0000000000000001
R10: fffffbfff1141b45 R11: ffff888090866500 R12: ffff88808cfecc80
R13: 0000000000966a20 R14: dffffc0000000000 R15: 0000000000000010
FS:  0000555555ff5940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffde202771d9b9 CR3: 000000008533e000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
