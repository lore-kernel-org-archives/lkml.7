Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F40C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671842085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfCSQCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:02:11 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:57668 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfCSQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:02:08 -0400
Received: by mail-it1-f199.google.com with SMTP id 190so17834725itl.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=K1AnMyOkFlKWFp5dtCSegjjSy/srrRMmUwAkRlCW9qY=;
        b=EDUjLwRWGf/W11JLK7o23xMRqq7eA+5CcaUZnKEnqMLPoAw3O90Uwtzhl0Tk0kU7Pn
         /y8gQig6RI67aMg0MYAhxgfYUTw9ACrYQMIHNh+ZTBweiR3lJooKWZ794eSxpThD0qux
         Lr3505V98av7Vw7EWJjyNRA5OSKeqkCcxBjJrIin2EHI7cJpwpXsVY0F3pMsfV8OoXi4
         t16VXhLQfGRpSuII1NMlVimmfrx+WMFMibkEoWLWDJcUdVzv5vGlcDwHnlrhsy4uWR5B
         aJ2syhgIK92glDk7EjdTVeWc+GYXHBVtyo7uz2nP3OM6Q+pzEpmdNcC1YBWCJU1QpO8y
         EzGQ==
X-Gm-Message-State: APjAAAUX1ZcEg2Ne5T7GiNxBpzeie8bUrz9k7SkVLjj1Ug1pUsXDQMTN
        f02E2JKhXmPA3OLMm2H1HxSO3EfDwJWGIKe3EMBHbbapG/6e
X-Google-Smtp-Source: APXvYqywRBT9Tyw5rcvoGc4qWwwK0Tgkh2MieECBnHCDitsIwmFz+48NUNxtq0hhjy3CF64ZrUUZG1SvptPTV/aabHlAU1/YLUVn
MIME-Version: 1.0
X-Received: by 2002:a24:794c:: with SMTP id z73mr2449652itc.0.1553011326809;
 Tue, 19 Mar 2019 09:02:06 -0700 (PDT)
Date:   Tue, 19 Mar 2019 09:02:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007783a2058474a0b9@google.com>
Subject: WARNING: suspicious RCU usage in xfrm_alloc_userspi
From:   syzbot <syzbot+59752237f7ab21c3f3c3@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17a2e24d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59cd5d43b5df6955
dashboard link: https://syzkaller.appspot.com/bug?extid=59752237f7ab21c3f3c3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e70cb3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17292127200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+59752237f7ab21c3f3c3@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.1.0-rc1-next-20190318 #5 Not tainted
-----------------------------
net/xfrm/xfrm_user.c:1080 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor085/7946:
  #0: 00000000a55031b5 (&net->xfrm.xfrm_cfg_mutex){+.+.}, at:  
xfrm_netlink_rcv+0x61/0x90 net/xfrm/xfrm_user.c:2691

stack backtrace:
CPU: 0 PID: 7946 Comm: syz-executor085 Not tainted 5.1.0-rc1-next-20190318  
#5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5162
  xfrm_nlmsg_unicast net/xfrm/xfrm_user.c:1080 [inline]
  xfrm_alloc_userspi+0x7d5/0xa80 net/xfrm/xfrm_user.c:1356
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
RIP: 0033:0x440499
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcf12caf08 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440499
RDX: 0000000000000000 RSI: 00000000200006c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000040


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
