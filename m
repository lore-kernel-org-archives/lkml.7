Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE226C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A041D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCLStG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:49:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56134 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:49:05 -0400
Received: by mail-io1-f72.google.com with SMTP id l10so2444615iob.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 11:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Q1e34M/H3HeaUKSHtvVboUgF0b7c9dehVQ8F/3p9fR4=;
        b=GH4xHOUGJMwuvHWfENc2I+a7f9N6XXjdJqjEudy3JUJ0Y7RkbtaIK1fhNQdOv5ghfC
         CFZcaOdbiyInPcT70A9/aldLoW8uLzVKSg1N6H9cplLRFGgBBF0aFKBPBUi+qrVX950Y
         SU4M4z9ZvHP6PkQIgvjxTNMdQyWKXjpUtcF0bHp1Q/N81cfFM5HQgaqsc2+2IUEHD/QH
         bHD3bGlm2PwmJKaCVQ7QG7IurI7GOgsfzpHEt681qjnLVwlBftSFwFucSkI9YAhJpWtm
         c53Zckl28GF364lSwgypMR4quGpLlQWhALY3xtyLZgfqnPldV1tkhZKSGBUNykaHdTNm
         YmOw==
X-Gm-Message-State: APjAAAXM4VbMNgGvuTKRsUBn74aZyorQ5qEGu0HLLPST8LOJhyDaHovp
        Y1QGAEMx2fufI6UCCjV/peh5X+dBZw131sOAoJSxL8akMOug
X-Google-Smtp-Source: APXvYqzD+jBWsoWLRgjl/H0QHV95CysXaJFA+g5NS4gsESu4UlXG8gFEKtf37IKlgr9IRxNZSTeUvUtCpYNSrkj+VaLAVbjiS6V0
MIME-Version: 1.0
X-Received: by 2002:a5d:9b95:: with SMTP id r21mr2877255iom.38.1552416544747;
 Tue, 12 Mar 2019 11:49:04 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:49:04 -0700
In-Reply-To: <000000000000dbe73a057cd65da2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b18bf10583ea24d9@google.com>
Subject: Re: general protection fault in fib6_purge_rt
From:   syzbot <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    cf08baa2 Add linux-next specific files for 20190306
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12f6755f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8b6073d992e8217
dashboard link: https://syzkaller.appspot.com/bug?extid=a25307ad099309f1c2b9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b2c56f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b8890b200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com

Started in network mode
Own node identity ac1414aa, cluster identity 4711
New replicast peer: 172.20.20.187
Enabled bearer <udp:syz1>, priority 10
Enabling of bearer <udp:syz1> rejected, already enabled
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7821 Comm: syz-executor772 Not tainted 5.0.0-next-20190306 #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fib6_drop_pcpu_from net/ipv6/ip6_fib.c:924 [inline]
RIP: 0010:fib6_purge_rt+0x4b3/0x670 net/ipv6/ip6_fib.c:960
Code: 0f b6 35 5a f6 44 03 31 ff 44 89 f6 e8 a6 1c 5b fb 45 84 f6 0f 84 b3  
00 00 00 e8 58 1b 5b fb 49 8d 7f 70 48 89 f8 48 c1 e8 03 <80> 3c 18 00 0f  
85 64 01 00 00 48 89 f8 4d 8b 77 70 48 c1 e8 03 80
RSP: 0018:ffff8880a5a26e98 EFLAGS: 00010202
RAX: 000000000000000e RBX: dffffc0000000000 RCX: ffffffff861579a9
RDX: 0000000000000000 RSI: ffffffff861578d8 RDI: 0000000000000071
RBP: ffff8880a5a26ef0 R08: ffff88808f9a6300 R09: ffffed101406c2f6
R10: ffffed101406c2f5 R11: ffff8880a03617af R12: 0000000000000000
R13: ffff8880a0361780 R14: 0000000000000001 R15: 0000000000000001
FS:  00007fe8383f8700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005612a363f110 CR3: 0000000093362000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  fib6_del_route net/ipv6/ip6_fib.c:1813 [inline]
  fib6_del+0xac2/0x10a0 net/ipv6/ip6_fib.c:1844
  fib6_clean_node+0x3a8/0x590 net/ipv6/ip6_fib.c:2006
  fib6_walk_continue+0x495/0x900 net/ipv6/ip6_fib.c:1928
  fib6_walk+0x9d/0x100 net/ipv6/ip6_fib.c:1976
  fib6_clean_tree+0xe0/0x120 net/ipv6/ip6_fib.c:2055
  __fib6_clean_all+0x118/0x2a0 net/ipv6/ip6_fib.c:2071
  fib6_clean_all+0x2b/0x40 net/ipv6/ip6_fib.c:2082
  rt6_sync_down_dev+0x134/0x150 net/ipv6/route.c:4051
  rt6_disable_ip+0x27/0x5f0 net/ipv6/route.c:4056
  addrconf_ifdown+0xa2/0x1220 net/ipv6/addrconf.c:3705
  addrconf_notify+0x19a/0x2260 net/ipv6/addrconf.c:3630
  notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
  call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
  call_netdevice_notifiers net/core/dev.c:1765 [inline]
  dev_close_many+0x33f/0x6f0 net/core/dev.c:1508
  rollback_registered_many+0x43b/0xfd0 net/core/dev.c:8161
  rollback_registered+0x109/0x1d0 net/core/dev.c:8226
  unregister_netdevice_queue net/core/dev.c:9273 [inline]
  unregister_netdevice_queue+0x1ee/0x2c0 net/core/dev.c:9266
  unregister_netdevice include/linux/netdevice.h:2655 [inline]
  __tun_detach+0xd5b/0x1000 drivers/net/tun.c:727
  tun_detach drivers/net/tun.c:744 [inline]
  tun_chr_close+0xe0/0x180 drivers/net/tun.c:3435
  __fput+0x2e5/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x90a/0x2fa0 kernel/exit.c:876
  do_group_exit+0x135/0x370 kernel/exit.c:980
  get_signal+0x399/0x1d50 kernel/signal.c:2577
  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44bca9
Code: 5b 65 73 63 61 70 65 20 63 6f 6e 74 72 6f 6c 2d 63 68 61 72 61 63 74  
65 72 73 5d 20 00 5b 64 72 6f 70 20 63 6f 6e 74 72 6f 6c <2d> 63 68 61 72  
61 63 74 65 72 73 5d 20 00 5b 73 6c 61 73 68 65 73
RSP: 002b:00007fe8383f7cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006dec48 RCX: 000000000044bca9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dec48
RBP: 00000000006dec40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dec4c
R13: 00007ffd4d27000f R14: 00007fe8383f89c0 R15: 000000000000002d
Modules linked in:
---[ end trace 9a88786341e68810 ]---
RIP: 0010:fib6_drop_pcpu_from net/ipv6/ip6_fib.c:924 [inline]
RIP: 0010:fib6_purge_rt+0x4b3/0x670 net/ipv6/ip6_fib.c:960
Code: 0f b6 35 5a f6 44 03 31 ff 44 89 f6 e8 a6 1c 5b fb 45 84 f6 0f 84 b3  
00 00 00 e8 58 1b 5b fb 49 8d 7f 70 48 89 f8 48 c1 e8 03 <80> 3c 18 00 0f  
85 64 01 00 00 48 89 f8 4d 8b 77 70 48 c1 e8 03 80
RSP: 0018:ffff8880a5a26e98 EFLAGS: 00010202
RAX: 000000000000000e RBX: dffffc0000000000 RCX: ffffffff861579a9
RDX: 0000000000000000 RSI: ffffffff861578d8 RDI: 0000000000000071
RBP: ffff8880a5a26ef0 R08: ffff88808f9a6300 R09: ffffed101406c2f6
R10: ffffed101406c2f5 R11: ffff8880a03617af R12: 0000000000000000
R13: ffff8880a0361780 R14: 0000000000000001 R15: 0000000000000001
FS:  00007fe8383f8700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005612a363f110 CR3: 0000000093362000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

