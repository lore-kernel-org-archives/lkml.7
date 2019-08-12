Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF1EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E1A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfHLHwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:52:07 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69]:38911 "EHLO
        mail-ot1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfHLHwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:52:07 -0400
Received: by mail-ot1-f69.google.com with SMTP id j4so83086729otc.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OH93fWca/4l2t0OPYY7fQBiJZLVUQD1baC/AK+EW1xM=;
        b=RB4Sl4/wpcKi4533ZMB4Zy0gpFcT285h2WtFQBjQ9ovJioaFqpzjOPxHIVdxaohnrj
         kocx1eerWCzHl8OCbhuEpaUCCZvc3mwKmjAaVVSiYNQbY7UkMMvIowMxHlRZPWKmLm3h
         S4XfWeCk6H3rCiukyeDMSciFQx/A3dfdHSaK6BiRTZZnt6rYDJ9VvurpHDkndTBAqQgk
         qaC5bE3/vm8dAJWTORpIWIXmXucsFCDnrxsuNuEjCePbFqAIGGBECKdnbOciTPkujLzc
         xk47FOh/vmTh5i341gmGn4xqxF3gF58pC1PZiRuX85xra4+5PKq4f3a1phMgTSgQKuOe
         wNgg==
X-Gm-Message-State: APjAAAURtNpYG/Lhhccjl2w8KOugF9Rib0zNqjritBAb0+r++1q/maxr
        p/bC24X2xn47ZMYnb+O7ackQhTqVKZOr/EqYMu3G4MiM/x/Q
X-Google-Smtp-Source: APXvYqwjiuV14Ib/83tW7qKM3T1Y2FExDsRucLSOJrDxuYNKhCV9LdWnoTshXT4NGQ2cThhzidZhEwAYvcga5JwZ5LB8Vb9GWJt5
MIME-Version: 1.0
X-Received: by 2002:a02:a503:: with SMTP id e3mr15886876jam.134.1565596325373;
 Mon, 12 Aug 2019 00:52:05 -0700 (PDT)
Date:   Mon, 12 Aug 2019 00:52:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5f091058fe6cc6a@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in rxrpc_unuse_local
From:   syzbot <syzbot+ae09baad492cce05644a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    57c722e9 net/tls: swap sk_write_space on close
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13e6c6ee600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
dashboard link: https://syzkaller.appspot.com/bug?extid=ae09baad492cce05644a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae09baad492cce05644a@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000010
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 8bbd0067 P4D 8bbd0067 PUD 907a2067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 11895 Comm: syz-executor.3 Not tainted 5.3.0-rc3+ #157
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:arch_atomic_add_return arch/x86/include/asm/atomic.h:167 [inline]
RIP: 0010:arch_atomic_sub_return arch/x86/include/asm/atomic.h:179 [inline]
RIP: 0010:atomic_sub_return include/asm-generic/atomic-instrumented.h:160  
[inline]
RIP: 0010:atomic_dec_return include/linux/atomic-fallback.h:455 [inline]
RIP: 0010:rxrpc_unuse_local+0x23/0x70 net/rxrpc/local_object.c:405
Code: 1f 84 00 00 00 00 00 55 48 89 e5 41 54 49 89 fc 53 bb ff ff ff ff e8  
4c 1a d7 fa 49 8d 7c 24 10 be 04 00 00 00 e8 8d 09 11 fb <f0> 41 0f c1 5c  
24 10 bf 01 00 00 00 89 de e8 aa 1b d7 fa 83 fb 01
RSP: 0018:ffff88806ab1fb28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffffffff869b6f43
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000010
RBP: ffff88806ab1fb38 R08: ffff88805f40a480 R09: ffffed1010e9310f
R10: ffffed1010e9310e R11: ffff888087498877 R12: 0000000000000000
R13: ffff88805f48cd92 R14: ffff888087498680 R15: ffff88805f48d208
FS:  00007fe68c1f5700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 00000000a1353000 CR4: 00000000001406f0
Call Trace:
  rxrpc_release_sock net/rxrpc/af_rxrpc.c:904 [inline]
  rxrpc_release+0x47d/0x840 net/rxrpc/af_rxrpc.c:930
  __sock_release+0xce/0x280 net/socket.c:590
  sock_close+0x1e/0x30 net/socket.c:1268
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  get_signal+0x2078/0x2500 kernel/signal.c:2523
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x5a9/0x6a0 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe68c1f4c78 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: 0000000000000003 RBX: 0000000000000005 RCX: 0000000000459829
RDX: 0000000020003440 RSI: 0000000000000005 RDI: 00000000200033c0
RBP: 000000000075c070 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000020003480 R11: 0000000000000246 R12: 00007fe68c1f56d4
R13: 00000000004c6706 R14: 00000000004db7b8 R15: 00000000ffffffff
Modules linked in:
CR2: 0000000000000010


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
