Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D710A2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfCOXmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:42:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33121 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfCOXmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:42:05 -0400
Received: by mail-io1-f72.google.com with SMTP id n15so8329471ioc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 16:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Nsnf//GuMQcOLFjTV3KKzijAqjmjSSrLGCrx4Ctnfkk=;
        b=ggY7J5zLRMZ/q1dvLyFF4SXWvQQturqtySo9QJ9ucTIm71jmJEjFtKB7pEOIZGpQpV
         ja6bI/L7oNZh53N/QhQLqOQShNhENh4aJQljut4Tt1CiebbxbXQ2qprkmVMj2nxiX/g2
         PfM0D0sgKicSswxuL0bLkPvv00zBWNOUAs3vJjicHwrKTlg1b077vTK1Bwomyp+vH7WX
         CfDiHfjix0+jQc91Yyf8EmX0T0uyqqdfc8V4ITXFLgJYcPWZntj79S3Z4SxrLNn/nQm6
         1zjkRFG9ayD2GJHKj5gceL8VIsqhXvYcP6SRg2+A2eTgYA/i+xVtbgA5l9ZlkZAOTUSO
         1o1w==
X-Gm-Message-State: APjAAAUL1XlOHwygiNvS/QWLAaY0P+0ft9zrpcS4F2LcttmbvZwvbDhf
        oEPhY7DmPrReEX0BoqaSvb1FQPBI/EjxKrwbftLcaigJAYhR
X-Google-Smtp-Source: APXvYqx/kuvGnLBvq2g8RfapgwlNobNMEE/Advf1PfAk8Vm7pN7fKiu+kaJxGNKhi4f1gj40zl5unOtSjHSG0dyt3G2BFEjmX+9e
MIME-Version: 1.0
X-Received: by 2002:a02:6a1c:: with SMTP id l28mr3724871jac.8.1552693325006;
 Fri, 15 Mar 2019 16:42:05 -0700 (PDT)
Date:   Fri, 15 Mar 2019 16:42:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000150ed605842a96af@google.com>
Subject: WARNING in wiphy_register (4)
From:   syzbot <syzbot+8f91bd563bbff230d0ee@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3b319ee2 Merge tag 'acpi-5.1-rc1-2' of git://git.kernel.or..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d8a2d7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f05902bca21d8935
dashboard link: https://syzkaller.appspot.com/bug?extid=8f91bd563bbff230d0ee
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16590b5f200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8f91bd563bbff230d0ee@syzkaller.appspotmail.com

netlink: 'syz-executor.5': attribute type 23 has an invalid length.
WARNING: CPU: 1 PID: 7527 at net/wireless/core.c:639  
wiphy_verify_combinations net/wireless/core.c:639 [inline]
WARNING: CPU: 1 PID: 7527 at net/wireless/core.c:639  
wiphy_register+0x2200/0x25f0 net/wireless/core.c:784
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7527 Comm: syz-executor.5 Not tainted 5.0.0+ #98
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:wiphy_verify_combinations net/wireless/core.c:639 [inline]
RIP: 0010:wiphy_register+0x2200/0x25f0 net/wireless/core.c:784
Code: 06 f6 de fa 0f 0b 41 bc ea ff ff ff e9 8b e2 ff ff e8 c4 aa b1 fa 48  
8b 7c 24 60 e8 fa ee 16 fb e9 a6 de ff ff e8 e0 f5 de fa <0f> 0b 41 bc ea  
ff ff ff e9 65 e2 ff ff 48 89 df e8 db ee 16 fb e9
RSP: 0018:ffff88808b897190 EFLAGS: 00010293
RAX: ffff88808c448040 RBX: 0000000000000001 RCX: ffffffff869160af
RDX: 0000000000000000 RSI: ffffffff86916e50 RDI: 0000000000000004
RBP: ffff88808b8972c8 R08: ffff88808c448040 R09: ffffed10149cb1c1
R10: ffffed10149cb1c0 R11: ffff8880a4e58e05 R12: 0000000000000002
R13: 0000000000000002 R14: 0000000000000800 R15: ffff8880a4e5b974
  ieee80211_register_hw+0x1674/0x3c00 net/mac80211/main.c:1128
  mac80211_hwsim_new_radio+0x1f16/0x3de0  
drivers/net/wireless/mac80211_hwsim.c:2929
  hwsim_new_radio_nl+0x9e3/0x1070 drivers/net/wireless/mac80211_hwsim.c:3477
  genl_family_rcv_msg+0x6e1/0xd90 net/netlink/genetlink.c:601
  genl_rcv_msg+0xca/0x16c net/netlink/genetlink.c:626
  netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2485
  genl_rcv+0x29/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:632
  ___sys_sendmsg+0x806/0x930 net/socket.c:2137
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2175
  __do_sys_sendmsg net/socket.c:2184 [inline]
  __se_sys_sendmsg net/socket.c:2182 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2182
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458079
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5ae4523c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458079
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ae45246d4
R13: 00000000004c564c R14: 00000000004d9520 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
