Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718E1C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512EE20856
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfHUWiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 18:38:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55997 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfHUWiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 18:38:09 -0400
Received: by mail-io1-f70.google.com with SMTP id g23so4165274ioh.22
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WRQEcCHbNZipj1Fc4GKwtUGYeWpCWyABrWXv1siS/eA=;
        b=SkSCvf0DcvhoSeaVrH9cANAmdPtUdZjbjws4+SsIsPqtUKIulg0IeMmMGjJD9UKZT2
         4SPsnHZRriQeTSURH1gJZ4ACm4XL2lSsrYcuCwiIvyBuJMBtcs4PIWVIcWu0THiU57Rt
         AdXH8LGxo8HIEoQhF++JT5DfHcmJLeNWQqRwM8riwbZl6o/fk7pepKAX1dVZQ90zhnP4
         HyGyvWflflmgjD3pJETOkQt4ihcSDGbEgJZPhjAgE698VmF0vAcLNmoenqU82jDqNg5r
         7uCuSkoxrSr+M5QhqUrNkzER447+Ew95XLIrh8XaiKCm8ew02dG4q8vGhTPnOGXO4fbV
         +m6Q==
X-Gm-Message-State: APjAAAVqG00mDuAru5saUNpAWBdY9UCtevUYMgi6Qr/YuClXz8fRmSEj
        7w5LWv6qC6Mt6EB108g6bXL2L8Ry4RNu4oJlrF9+9pAwRsLM
X-Google-Smtp-Source: APXvYqykiI+qK8i+4jxuhP+u0nDmMJA3FMGd9sJrm8rC83se14HY5wVnpV8H3guSlYUFJYVt888/4ZP/rpeRXJgLJfATyavoKwQs
MIME-Version: 1.0
X-Received: by 2002:a5e:a811:: with SMTP id c17mr2694116ioa.122.1566427088119;
 Wed, 21 Aug 2019 15:38:08 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:38:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000276f580590a83ac2@google.com>
Subject: KMSAN: uninit-value in rtm_new_nexthop
From:   syzbot <syzbot+4f3abbb335d1bed2287c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, glider@google.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    61ccdad1 Revert "drm/bochs: Use shadow buffer for bochs fr..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1596d33c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27abc558ecb16a3b
dashboard link: https://syzkaller.appspot.com/bug?extid=4f3abbb335d1bed2287c
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15733302600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1028e9e2600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4f3abbb335d1bed2287c@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in rtm_to_nh_config net/ipv4/nexthop.c:1317  
[inline]
BUG: KMSAN: uninit-value in rtm_new_nexthop+0x447/0x98e0  
net/ipv4/nexthop.c:1474
CPU: 0 PID: 11026 Comm: syz-executor768 Not tainted 5.3.0-rc3+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  rtm_to_nh_config net/ipv4/nexthop.c:1317 [inline]
  rtm_new_nexthop+0x447/0x98e0 net/ipv4/nexthop.c:1474
  rtnetlink_rcv_msg+0x115a/0x1580 net/core/rtnetlink.c:5223
  netlink_rcv_skb+0x431/0x620 net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:5241
  netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
  netlink_unicast+0xf6c/0x1050 net/netlink/af_netlink.c:1328
  netlink_sendmsg+0x110f/0x1330 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg net/socket.c:657 [inline]
  ___sys_sendmsg+0x14ff/0x1590 net/socket.c:2311
  __sys_sendmsg net/socket.c:2356 [inline]
  __do_sys_sendmsg net/socket.c:2365 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2363
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2363
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:297
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x4401e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffef5128b58 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401e9
RDX: 0000000000000000 RSI: 0000000020000400 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a70
R13: 0000000000401b00 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:187 [inline]
  kmsan_internal_poison_shadow+0x53/0xa0 mm/kmsan/kmsan.c:146
  kmsan_slab_alloc+0xaa/0x120 mm/kmsan/kmsan_hooks.c:175
  slab_alloc_node mm/slub.c:2790 [inline]
  __kmalloc_node_track_caller+0xb55/0x1320 mm/slub.c:4388
  __kmalloc_reserve net/core/skbuff.c:141 [inline]
  __alloc_skb+0x306/0xa10 net/core/skbuff.c:209
  alloc_skb include/linux/skbuff.h:1056 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1174 [inline]
  netlink_sendmsg+0x783/0x1330 net/netlink/af_netlink.c:1892
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg net/socket.c:657 [inline]
  ___sys_sendmsg+0x14ff/0x1590 net/socket.c:2311
  __sys_sendmsg net/socket.c:2356 [inline]
  __do_sys_sendmsg net/socket.c:2365 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2363
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2363
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:297
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
