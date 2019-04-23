Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ABBC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E2F20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfDWQHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:07:10 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45043 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfDWQHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:07:08 -0400
Received: by mail-io1-f69.google.com with SMTP id w9so2509163ior.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KR12zUlTr2Xk8ujyEDH7Kxe9ncILjqmJGGth/fcaif0=;
        b=qLegX/DuOKBw3B3AuIIqgEI5hPczU4ephwJljPhyccrfE0rgAWbwq+unUgLGz0enJT
         wU2BHQmKVGpoFYNDX8sBkNZ5ipK1NFlo8orTiNWhmEBK4IkdJZNS1KIRkpBQ89sYHqOF
         Jjsy/SQt+3JWX8X1Upjdhp7BDIn02NJquHkfnBtsF8WhnY+KCiylD4QvUzj/l1WmNkml
         5fnCY3CuEAwfXNDAMorPKhm4uQ26zXv9N9+g4wUcs7R4Qhjqxh+nD8N5/Bdc0BbSe/7z
         jlVnx9N5iG86NhCUSIcFK3eMFNc9rczVvRlUxYD0ry3lHCA0L4RpkGtjaHABqLcXTBKN
         o35g==
X-Gm-Message-State: APjAAAUv7ADpKptsEZOBtEJNzgCiHp9BAgtXEam8Hbf57kvZZtxBlXFo
        dUjUaGNL7UO2rsg2WnVU6Ox8WRUGG3iyEizv59S/ljTZgFby
X-Google-Smtp-Source: APXvYqw9j5+1bwsznzH8RS8CqKnjT9aQdm32X3EL0vAuLtAzkxqjyO8IEMNXgeLZijlRaRzqASe5aHpETCj5UYq83V6QeiGrSvjw
MIME-Version: 1.0
X-Received: by 2002:a5d:9715:: with SMTP id h21mr18162278iol.266.1556035626787;
 Tue, 23 Apr 2019 09:07:06 -0700 (PDT)
Date:   Tue, 23 Apr 2019 09:07:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caeb1c058734c654@google.com>
Subject: general protection fault in fib6_purge_rt (2)
From:   syzbot <syzbot+d53d5d9b6793dc70eb9d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c543cb4a ipv4: ensure rcu_read_lock() in ipv4_link_failure()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17fd659f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=d53d5d9b6793dc70eb9d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d53d5d9b6793dc70eb9d@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 30586 Comm: syz-executor.3 Not tainted 5.1.0-rc4+ #166
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fib6_drop_pcpu_from net/ipv6/ip6_fib.c:924 [inline]
RIP: 0010:fib6_purge_rt+0x4b3/0x670 net/ipv6/ip6_fib.c:960
Code: 0f b6 35 8f df 43 03 31 ff 44 89 f6 e8 a6 f7 59 fb 45 84 f6 0f 84 b3  
00 00 00 e8 58 f6 59 fb 49 8d 7f 70 48 89 f8 48 c1 e8 03 <80> 3c 18 00 0f  
85 64 01 00 00 48 89 f8 4d 8b 77 70 48 c1 e8 03 80
RSP: 0018:ffff8880549fefa8 EFLAGS: 00010203
RAX: 0000000000000020 RBX: dffffc0000000000 RCX: ffffc9000c42e000
RDX: 0000000000040000 RSI: ffffffff861698a8 RDI: 0000000000000104
RBP: ffff8880549ff000 R08: ffff88808e5a0140 R09: ffffed1011ad04be
R10: ffffed1011ad04bd R11: ffff88808d6825ef R12: 0000000000000001
R13: ffff88808d6825c0 R14: 0000000000000001 R15: 0000000000000094
FS:  00007f90dbdce700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020651000 CR3: 00000000905bd000 CR4: 00000000001406e0
Call Trace:
  fib6_del_route net/ipv6/ip6_fib.c:1813 [inline]
  fib6_del+0xac2/0x10a0 net/ipv6/ip6_fib.c:1844
  fib6_clean_node+0x3a8/0x590 net/ipv6/ip6_fib.c:2006
  fib6_walk_continue+0x495/0x900 net/ipv6/ip6_fib.c:1928
  fib6_walk+0x9d/0x100 net/ipv6/ip6_fib.c:1976
  fib6_clean_tree+0xe0/0x120 net/ipv6/ip6_fib.c:2055
  __fib6_clean_all+0x118/0x2a0 net/ipv6/ip6_fib.c:2071
  fib6_clean_all+0x2b/0x40 net/ipv6/ip6_fib.c:2082
  rt6_sync_down_dev+0x134/0x150 net/ipv6/route.c:4053
  rt6_disable_ip+0x27/0x5f0 net/ipv6/route.c:4058
  addrconf_ifdown+0xa2/0x1220 net/ipv6/addrconf.c:3705
  addrconf_notify+0x19a/0x2260 net/ipv6/addrconf.c:3630
  notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1753
  call_netdevice_notifiers_extack net/core/dev.c:1765 [inline]
  call_netdevice_notifiers net/core/dev.c:1779 [inline]
  __dev_notify_flags+0x1e9/0x2c0 net/core/dev.c:7623
  dev_change_flags+0x10d/0x170 net/core/dev.c:7659
  devinet_ioctl+0xde6/0x1cf0 net/ipv4/devinet.c:1104
  inet_ioctl+0x2d4/0x410 net/ipv4/af_inet.c:954
  sock_do_ioctl+0xde/0x300 net/socket.c:1037
  sock_ioctl+0x32b/0x610 net/socket.c:1168
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f90dbdcdc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458c29
RDX: 0000000020000040 RSI: 0000000000008914 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f90dbdce6d4
R13: 00000000004c44a2 R14: 00000000004d7d48 R15: 00000000ffffffff
Modules linked in:
---[ end trace ee9d5c7f957c3ef2 ]---
RIP: 0010:fib6_drop_pcpu_from net/ipv6/ip6_fib.c:924 [inline]
RIP: 0010:fib6_purge_rt+0x4b3/0x670 net/ipv6/ip6_fib.c:960
Code: 0f b6 35 8f df 43 03 31 ff 44 89 f6 e8 a6 f7 59 fb 45 84 f6 0f 84 b3  
00 00 00 e8 58 f6 59 fb 49 8d 7f 70 48 89 f8 48 c1 e8 03 <80> 3c 18 00 0f  
85 64 01 00 00 48 89 f8 4d 8b 77 70 48 c1 e8 03 80
RSP: 0018:ffff8880549fefa8 EFLAGS: 00010203
RAX: 0000000000000020 RBX: dffffc0000000000 RCX: ffffc9000c42e000
RDX: 0000000000040000 RSI: ffffffff861698a8 RDI: 0000000000000104
RBP: ffff8880549ff000 R08: ffff88808e5a0140 R09: ffffed1011ad04be
R10: ffffed1011ad04bd R11: ffff88808d6825ef R12: 0000000000000001
R13: ffff88808d6825c0 R14: 0000000000000001 R15: 0000000000000094
FS:  00007f90dbdce700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020651000 CR3: 00000000905bd000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
