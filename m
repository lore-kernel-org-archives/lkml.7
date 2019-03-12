Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D4EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748D72147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfCLNwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:52:06 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:34268 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfCLNwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:52:06 -0400
Received: by mail-it1-f199.google.com with SMTP id x87so1579149ita.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6YL8D4kjGRwkz8EPaUWAhEPQmB+7QGdJiD53mOqeSpg=;
        b=f8cfp0+48C3pghw+85GufOSROhZt44ZCBtde69g58ux2Fm4OPbWJoh4AYjEPMCEV05
         vAqwWVKqJbGjSSXh0dejOdZE+IOCDhpdiMAmgHykSuMkEuwO5p2ygb0K2Qm3SWNbJFRN
         sZ0nYl3m4hCR9qJqDRG5+2DgE9RG3YmH4n6hE4xXpvF3KLDqVZRmeee04yAf6l4qKY/A
         tWnXYGk5hGJbFoHNfpxm9AtnsIgwRQrIMLVOidlanPXshB5RAfq51hLt+NhxrZoT6Ie+
         xY++pMdPPqpG9r/42jnZmsiLHRRP1dZ7SF2gh8oyDeWgJMokSGq0IjjU2MkH39GYaoap
         mvRw==
X-Gm-Message-State: APjAAAUqM9pcFSeyeEMMk6rG68jMWiq5tGJTpQM6QMqIL56sCKhbJySd
        tCnba1wcqcJtaeVKFGEzQ512C7D+RTLAn/hWDAyOK2mOJBil
X-Google-Smtp-Source: APXvYqyg7zqRYcoiC3utMyLVpABz9nW5lLHxPFOs7qBD//YIZSce45HQQx8XPOyEPD1kjZsUSxOzza8OiP4W1/aoQExcplYRR1XE
MIME-Version: 1.0
X-Received: by 2002:a5d:9a0d:: with SMTP id s13mr3464311iol.26.1552398724739;
 Tue, 12 Mar 2019 06:52:04 -0700 (PDT)
Date:   Tue, 12 Mar 2019 06:52:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089bb100583e5fe7a@google.com>
Subject: general protection fault in sctp_assoc_rwnd_increase
From:   syzbot <syzbot+85e0b422ff140b03672a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a089e4fe Merge tag 'linux-watchdog-5.1-rc1' of git://www.l..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144e9ee7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b613f0327d980b6b
dashboard link: https://syzkaller.appspot.com/bug?extid=85e0b422ff140b03672a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12613b13200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f1884d200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+85e0b422ff140b03672a@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446679
RDX: 0000000000000066 RSI: 0000000000000084 RDI: 0000000000000003
RBP: 00000000006dbc30 R08: 0000000020000140 R09: 0000000000000038
R10: 0000000020000040 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00007f47f49ded90 R14: 0000000000000004 R15: 20c49ba5e353f7cf
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7680 Comm: syz-executor161 Not tainted 5.0.0+ #18
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:sctp_assoc_rwnd_increase+0x34/0x520 net/sctp/associola.c:1498
Code: 41 54 49 89 fc 53 89 f3 48 83 ec 10 e8 95 90 f1 fa 49 8d bc 24 60 06  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e 2f 04 00 00 45 8b ac 24 60 06
RSP: 0018:ffff88808da476f8 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 00000000000000cb RSI: ffffffff867ecd5b RDI: 000000000000065f
RBP: ffff88808da47730 R08: ffff88808c5d64c0 R09: ffff88808c5d6d88
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffffffffff
R13: 0000000000000000 R14: ffff88808c4d6f00 R15: 0000000000000000
FS:  00007f47f49df700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000044 CR3: 0000000097508000 CR4: 00000000001406f0
Call Trace:
  sctp_ulpevent_release_data net/sctp/ulpevent.c:1092 [inline]
  sctp_ulpevent_free+0x21f/0x4e0 net/sctp/ulpevent.c:1129
  sctp_queue_purge_ulpevents+0xc4/0x110 net/sctp/ulpevent.c:1146
  sctp_close+0x148/0x860 net/sctp/socket.c:1515
  inet_release+0x105/0x1f0 net/ipv4/af_inet.c:428
  inet6_release+0x53/0x80 net/ipv6/af_inet6.c:473
  __sock_release+0x1fe/0x2b0 net/socket.c:579
  sock_release+0x18/0x20 net/socket.c:599
  sctp_do_peeloff+0x38a/0x470 net/sctp/socket.c:5649
  sctp_getsockopt_peeloff_common.isra.0+0x8e/0x270 net/sctp/socket.c:5665
  sctp_getsockopt_peeloff net/sctp/socket.c:5707 [inline]
  sctp_getsockopt net/sctp/socket.c:7802 [inline]
  sctp_getsockopt+0x1ec1/0x6741 net/sctp/socket.c:7758
  sock_common_getsockopt+0x9a/0xe0 net/core/sock.c:3079
  __sys_getsockopt+0x168/0x250 net/socket.c:1960
  __do_sys_getsockopt net/socket.c:1971 [inline]
  __se_sys_getsockopt net/socket.c:1968 [inline]
  __x64_sys_getsockopt+0xbe/0x150 net/socket.c:1968
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446679
Code: e8 6c b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f47f49ded88 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446679
RDX: 0000000000000066 RSI: 0000000000000084 RDI: 0000000000000003
RBP: 00000000006dbc30 R08: 0000000020000140 R09: 0000000000000038
R10: 0000000020000040 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00007f47f49ded90 R14: 0000000000000004 R15: 20c49ba5e353f7cf
Modules linked in:
---[ end trace dfa9a15945f164b7 ]---
RIP: 0010:sctp_assoc_rwnd_increase+0x34/0x520 net/sctp/associola.c:1498
Code: 41 54 49 89 fc 53 89 f3 48 83 ec 10 e8 95 90 f1 fa 49 8d bc 24 60 06  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e 2f 04 00 00 45 8b ac 24 60 06
RSP: 0018:ffff88808da476f8 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 00000000000000cb RSI: ffffffff867ecd5b RDI: 000000000000065f
RBP: ffff88808da47730 R08: ffff88808c5d64c0 R09: ffff88808c5d6d88
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffffffffff
R13: 0000000000000000 R14: ffff88808c4d6f00 R15: 0000000000000000
FS:  00007f47f49df700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000044 CR3: 0000000097508000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
