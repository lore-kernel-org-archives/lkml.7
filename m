Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C698C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 06:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6AF21734
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 06:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfIHGIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 02:08:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38357 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfIHGIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 02:08:10 -0400
Received: by mail-io1-f70.google.com with SMTP id m5so13654194ioj.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 23:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bj4+tbcbPbywqjEKabAZDF2vUG9cCMisfKIR7PH3K0Q=;
        b=jFcTMarnNJElVZy9MYJxNwVA8ZoeiY7WmgBml8YyaUJjcXRwo6rQZoX3pAIOedHGM4
         EijGYwoEWQYwc9ojBEtLD+PeQrBYOQwqP4eAT7AHNqgbQM8b1DHe9jFd0zGttuBhD9dK
         fHzDFpt8iia58DVICq2r6C57mmAE4ULVf7gUHySt6X1c5CJ8qiFKPhwJWBxjuqtd0Iqs
         ix4wNBjDquQ4l7yIKQYFW6hTFCQwPGMnUtpLZfGrC3vaiF0/Ch0E+rmYOeaV4X8FjYva
         lbEDTvefaMz/tdNdl2XkXM0PnklsjiS2QrXLK+9jQ8Edpu2CR2DXap+XsyY1mTOcVYN6
         iNew==
X-Gm-Message-State: APjAAAUSzLKvGcJNCOBHaOk+1We5pKkxsDzOn3J8G5kTdOH/CUGkJo7d
        e5GJU9IXyxqSV+3aSP+Ry7YiVp5yiVsYEvWwnKS5c2DpeYoJ
X-Google-Smtp-Source: APXvYqxva32GGs4AWdYjNdgBRdT3CcX8MBoEDzaS5PmZiXjPIKBzmuhF+8rCq5wYh7pmKF07cMEzuBqhF75BU1HyhhmTXMs85sC2
MIME-Version: 1.0
X-Received: by 2002:a05:6602:104:: with SMTP id s4mr4521425iot.125.1567922889145;
 Sat, 07 Sep 2019 23:08:09 -0700 (PDT)
Date:   Sat, 07 Sep 2019 23:08:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7c76f0592047ef9@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in tc_bind_tclass
From:   syzbot <syzbot+21b29db13c065852f64b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0e5b36bc r8152: adjust the settings of ups flags
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e5ad76600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b69b427c3b2dbf
dashboard link: https://syzkaller.appspot.com/bug?extid=21b29db13c065852f64b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cebbda600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fb9d0a600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+21b29db13c065852f64b@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device batadv0
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD a9ba0067 P4D a9ba0067 PUD a7851067 PMD 0
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8672 Comm: syz-executor994 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffff888097fb74d8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffff884a7740 RCX: ffffffff85b55676
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8880a4cd7400
RBP: ffff888097fb75d0 R08: ffff88808dc2e440 R09: ffff888097fb7658
R10: ffffed1012ff6ed9 R11: ffff888097fb76cf R12: ffff8880a4cd7400
R13: 0000000000000001 R14: ffff888097fb75a8 R15: ffffffff884a7740
FS:  0000555556952880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000009c578000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  tc_bind_tclass+0x13e/0x2f0 net/sched/sch_api.c:1923
  tc_ctl_tclass+0xadb/0xcd0 net/sched/sch_api.c:2059
  rtnetlink_rcv_msg+0x463/0xb00 net/core/rtnetlink.c:5223
  netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5241
  netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
  netlink_unicast+0x531/0x710 net/netlink/af_netlink.c:1328
  netlink_sendmsg+0x8a5/0xd60 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg+0xd7/0x130 net/socket.c:657
  ___sys_sendmsg+0x803/0x920 net/socket.c:2311
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2356
  __do_sys_sendmsg net/socket.c:2365 [inline]
  __se_sys_sendmsg net/socket.c:2363 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2363
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441cd9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc9938bcf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000315f6576616c RCX: 0000000000441cd9
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 735f656764697262 R08: 0000000001bbbbbb R09: 0000000001bbbbbb
R10: 0000000001bbbbbb R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000403270 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: 0000000000000000
---[ end trace d5605e2bdb92fab7 ]---
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffff888097fb74d8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffff884a7740 RCX: ffffffff85b55676
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8880a4cd7400
RBP: ffff888097fb75d0 R08: ffff88808dc2e440 R09: ffff888097fb7658
R10: ffffed1012ff6ed9 R11: ffff888097fb76cf R12: ffff8880a4cd7400
R13: 0000000000000001 R14: ffff888097fb75a8 R15: ffffffff884a7740
FS:  0000555556952880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000009c578000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
