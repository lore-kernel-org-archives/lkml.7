Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653C0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfCSQCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:02:24 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:43546 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfCSQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:02:10 -0400
Received: by mail-io1-f69.google.com with SMTP id n23so16571597ioj.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QVXbb85YBUlns7yJ9jGjCpA+7Hkx5/eG/hgJRqhL1yY=;
        b=bmb5SacNPBLTua38kp0TP6g8y2rL0pCqh53HxFPS+TkBn4Z5QO6aw6sSXIxYVpjASb
         1po6H2AvVN6g5Y/KFrrHa7PPlkIzrJjeOvgBseuGLWuu6wqZDuo5u2oT0G9jAfCASHuU
         +e8ZC3YDx/K8W6tgEf4+r/I8IU4zk2CcIN2f2Uo1AW3WAS/vKXNpo29x8UhmZRvEcC/a
         /0RBYDHm7uIhyfOAz4LynSanvBF+tJF+c8jVwfdPwvCz3mf0YfCqtSzqqBxve06+/ble
         xcOG+3yATh9oWWGT89d640LitJfeq15mfjcJ6eHeU5wPoZCeKqeTQYMXC2cvmTXqAwUP
         km6A==
X-Gm-Message-State: APjAAAWSYuMO68ZBVh7hWrRPyRQ+tWnradV3qLjEIEULgr/0aGy7h5ki
        YJEcfRFLn8s0an7B/4x89H/cnKWqzSCG3QjYenpOdEI6d5mZ
X-Google-Smtp-Source: APXvYqw0C3GmAeQm9tE0lxXLdDHxi096kmf4YHypyDn0icGWmnPuqsQF5oNXIWMd5xQgiPfvkBGG7VsdDIqMkyjjUw6XdRV3ES5m
MIME-Version: 1.0
X-Received: by 2002:a24:152:: with SMTP id 79mr2324162itk.25.1553011329209;
 Tue, 19 Mar 2019 09:02:09 -0700 (PDT)
Date:   Tue, 19 Mar 2019 09:02:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c1aca058474a076@google.com>
Subject: WARNING: suspicious RCU usage in xfrm_get_sadinfo
From:   syzbot <syzbot+2792672c6a63f1dc867c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b9998194 Add linux-next specific files for 20190318
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b162a3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59cd5d43b5df6955
dashboard link: https://syzkaller.appspot.com/bug?extid=2792672c6a63f1dc867c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a2e24d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131ab8ef200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2792672c6a63f1dc867c@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.1.0-rc1-next-20190318 #5 Not tainted
-----------------------------
net/xfrm/xfrm_user.c:1080 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor501/7913:
  #0: 0000000071883b7f (&net->xfrm.xfrm_cfg_mutex){+.+.}, at:  
xfrm_netlink_rcv+0x61/0x90 net/xfrm/xfrm_user.c:2691

stack backtrace:
CPU: 1 PID: 7913 Comm: syz-executor501 Not tainted 5.1.0-rc1-next-20190318  
#5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5162
  xfrm_nlmsg_unicast net/xfrm/xfrm_user.c:1080 [inline]
  xfrm_get_sadinfo+0x57b/0x650 net/xfrm/xfrm_user.c:1273
  xfrm_user_rcv_msg+0x458/0x770 net/xfrm/xfrm_user.c:2684
  netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2485
  xfrm_netlink_rcv+0x70/0x90 net/xfrm/xfrm_user.c:2692
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  ___sys_sendmsg+0x806/0x930 net/socket.c:2260
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2298
  __do_sys_sendmsg net/socket.c:2307 [inline]
  __se_sys_sendmsg net/socket.c:2305 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2305
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4401d9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe965c5678 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401d9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
