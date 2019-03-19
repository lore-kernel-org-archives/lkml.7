Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AF5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06276206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfCSQCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:02:24 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37903 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfCSQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:02:10 -0400
Received: by mail-io1-f72.google.com with SMTP id b16so12498876iot.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=roCZi5s2b/dI7FAC/RIrKCyTDsvj24Z+Ft1Cw0iJWJY=;
        b=UDjsOntSbdT6oAYwn47kpNop0kohUrzzomxsWcuMpr5FZLuTUc2Zy1N4qwZqpKM+en
         lNiKmjppQq7WoNI/AeHVX8rRPM8zMmyTPI3fJQBq1MFphOcJyE7Pmme4r7EVH/eHQwFq
         hu+kNYooWK5wV5yB5+2MkQ2tb/7Ok3nTS41L1veeENplBgeSDfppAFR//SOJQsHNuKvV
         kk6+ZJAa5a7aVrfNw8canBrpecMLTDathlT057yFb05bblRq7nCzMxF+iiaEcYTWiMCd
         Vili0Ziu8n8rYgNFzkgznlOe+7s4u/PEinaeRUmZGxZiLn47ZMrYdcnmvSw9leV5kGoS
         dQIw==
X-Gm-Message-State: APjAAAWvT82/kUTcjNuB7gmJXdeg/BkAYGkuH5YZunZXm/NDtMuMd2GM
        YmDvn2Sw3RyQgngJ3e2Fs/e+/AdUXW9slJlGojcICraNez6t
X-Google-Smtp-Source: APXvYqxffIx9xSvOKkruLsrK1bYV3TeOoC4qzpcDLu5IdeNaSnDC5eWC2pMUA1Cb5QWbYUDwNr/FBSccwdhR6dcKO+BfaLoaORoG
MIME-Version: 1.0
X-Received: by 2002:a5e:8b44:: with SMTP id z4mr15079115iom.1.1553011329386;
 Tue, 19 Mar 2019 09:02:09 -0700 (PDT)
Date:   Tue, 19 Mar 2019 09:02:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ed0ce058474a0c1@google.com>
Subject: WARNING: suspicious RCU usage in xfrm_get_policy
From:   syzbot <syzbot+670c11fba80a72c50a6a@syzkaller.appspotmail.com>
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

HEAD commit:    75e6a83b Add linux-next specific files for 20190319
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16d4088b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84a8ad88e2cbdfd4
dashboard link: https://syzkaller.appspot.com/bug?extid=670c11fba80a72c50a6a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129a0aa3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+670c11fba80a72c50a6a@syzkaller.appspotmail.com

netlink: 104 bytes leftover after parsing attributes in process  
`syz-executor.3'.
=============================
WARNING: suspicious RCU usage
5.1.0-rc1-next-20190319 #6 Not tainted
-----------------------------
net/xfrm/xfrm_user.c:1080 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor.3/15797:
  #0: 00000000ead151cf (&net->xfrm.xfrm_cfg_mutex){+.+.}, at:  
xfrm_netlink_rcv+0x61/0x90 net/xfrm/xfrm_user.c:2691

stack backtrace:
CPU: 0 PID: 15797 Comm: syz-executor.3 Not tainted 5.1.0-rc1-next-20190319  
#6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5162
  xfrm_nlmsg_unicast net/xfrm/xfrm_user.c:1080 [inline]
  xfrm_get_policy+0xa98/0xbe0 net/xfrm/xfrm_user.c:1922
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
RIP: 0033:0x458079
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f407a90dc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458079
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f407a90e6d4
R13: 00000000004c56c3 R14: 00000000004d95f0 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
