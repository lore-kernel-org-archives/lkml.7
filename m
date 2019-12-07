Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B428C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 07:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC20F206DB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 07:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLGHPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 02:15:10 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:35166 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfLGHPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 02:15:09 -0500
Received: by mail-il1-f198.google.com with SMTP id t15so7136018ilh.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 23:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vbpExfUjnTG9aVNCGlbCdm6W2vaByL7mQ2ZMHuqk2KI=;
        b=NaH18wgAR8i7gpClxVF+kAFyHMGFIOVv7r/gNPukJfW9q7mqvDXlcqJat0EkJB7GGZ
         9V1fdhlEquRDNK5ewidmmLl2wy5E1cyQ1MfLOI1lniz0sAJ3Cm/83qJWQPobtMeC5Gm1
         jyTot37u0ujDQM6mQWQltDu44Px9GUgPLqSTb/KLvQfe2hLu7v4Dhq/zw/nK6vuvoNEC
         JhXsR51bkTYs75fq7wtQBF++nxk0uLst/0v2m6cTUuc3jWwp6BBCBrWu5G2N3aBy2afU
         YNM3rRIFd9GTa07tz6Sy3Yc63b4m43WKsows+d6Gc5dZvk+Wa9gPngwfZ5KtzVd7sot5
         ZiKA==
X-Gm-Message-State: APjAAAU5y3m+M8hh9vvcFZTdQipPRcLeulRzh102EKMmdnKE+nb8mwxc
        noKE9/tIf8tNgsfCmWM8pCZVf2PA7/6T+QFu3wzPmHE46eJP
X-Google-Smtp-Source: APXvYqw3PUcnBXQS+L+/OjlD87mrU7sA3J3K9/YEGET/p9evThEIsDDqfHWZBghgYVMAFbxXgQaWcZtlo10knNcmjl5JY/0SEdBR
MIME-Version: 1.0
X-Received: by 2002:a6b:7310:: with SMTP id e16mr13806023ioh.107.1575702908343;
 Fri, 06 Dec 2019 23:15:08 -0800 (PST)
Date:   Fri, 06 Dec 2019 23:15:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f9f5f059917ec2e@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in x25_connect
From:   syzbot <syzbot+eec0c87f31a7c3b66f7b@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andrew.hendry@gmail.com, arnd@arndb.de,
        davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        willemb@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a350d2e7 net: thunderx: start phy before starting autonego..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10217c82e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da7be58727ceb6f7
dashboard link: https://syzkaller.appspot.com/bug?extid=eec0c87f31a7c3b66f7b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eec0c87f31a7c3b66f7b@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 00000000000000c8
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 97b39067 P4D 97b39067 PUD a2fba067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 28617 Comm: syz-executor.4 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:arch_atomic_fetch_sub arch/x86/include/asm/atomic.h:189 [inline]
RIP: 0010:atomic_fetch_sub include/asm-generic/atomic-instrumented.h:200  
[inline]
RIP: 0010:refcount_sub_and_test include/linux/refcount.h:253 [inline]
RIP: 0010:refcount_dec_and_test include/linux/refcount.h:281 [inline]
RIP: 0010:x25_neigh_put include/net/x25.h:252 [inline]
RIP: 0010:x25_connect+0x974/0x1020 net/x25/af_x25.c:820
Code: 3c 02 00 0f 85 e4 05 00 00 4d 8b b4 24 98 04 00 00 be 04 00 00 00 bb  
ff ff ff ff 4d 8d be c8 00 00 00 4c 89 ff e8 6c e4 ca fa <f0> 41 0f c1 9e  
c8 00 00 00 bf 01 00 00 00 89 de e8 97 a0 8d fa 83
RSP: 0018:ffffc90001927c78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffffffff86e75b54
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000000000c8
RBP: ffffc90001927d90 R08: 1ffffffff1476954 R09: fffffbfff1476955
R10: fffffbfff1476954 R11: ffffffff8a3b4aa3 R12: ffff888063f60000
R13: 00000000fffffe00 R14: 0000000000000000 R15: 00000000000000c8
FS:  00007f117ef4c700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000c8 CR3: 0000000064f3b000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __sys_connect_file+0x25d/0x2e0 net/socket.c:1848
  __sys_connect+0x51/0x90 net/socket.c:1861
  __do_sys_connect net/socket.c:1872 [inline]
  __se_sys_connect net/socket.c:1869 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1869
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a679
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f117ef4bc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 0000000000000012 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 000000000075c118 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f117ef4c6d4
R13: 00000000004c0f1c R14: 00000000004d4c48 R15: 00000000ffffffff
Modules linked in:
CR2: 00000000000000c8
---[ end trace 20e51d278d7d0fc8 ]---
RIP: 0010:arch_atomic_fetch_sub arch/x86/include/asm/atomic.h:189 [inline]
RIP: 0010:atomic_fetch_sub include/asm-generic/atomic-instrumented.h:200  
[inline]
RIP: 0010:refcount_sub_and_test include/linux/refcount.h:253 [inline]
RIP: 0010:refcount_dec_and_test include/linux/refcount.h:281 [inline]
RIP: 0010:x25_neigh_put include/net/x25.h:252 [inline]
RIP: 0010:x25_connect+0x974/0x1020 net/x25/af_x25.c:820
Code: 3c 02 00 0f 85 e4 05 00 00 4d 8b b4 24 98 04 00 00 be 04 00 00 00 bb  
ff ff ff ff 4d 8d be c8 00 00 00 4c 89 ff e8 6c e4 ca fa <f0> 41 0f c1 9e  
c8 00 00 00 bf 01 00 00 00 89 de e8 97 a0 8d fa 83
RSP: 0018:ffffc90001927c78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffffffff86e75b54
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000000000c8
RBP: ffffc90001927d90 R08: 1ffffffff1476954 R09: fffffbfff1476955
R10: fffffbfff1476954 R11: ffffffff8a3b4aa3 R12: ffff888063f60000
R13: 00000000fffffe00 R14: 0000000000000000 R15: 00000000000000c8
FS:  00007f117ef4c700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000c8 CR3: 0000000064f3b000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
