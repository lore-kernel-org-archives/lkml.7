Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4CCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4583A2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfCOXmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:42:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50579 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfCOXmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:42:06 -0400
Received: by mail-io1-f71.google.com with SMTP id s24so4511799ioe.17
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 16:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OHHMNKda6fsn8tXd8GrjxtZRk9TwcJHlJaeZGhrz3Ps=;
        b=gtbFyooJW+uYUz5wrbMwQagX+R10TWHcyq1ACTu0vfvYrK/pCznMHKSl915K6yHZ40
         g0UUc8LoDWkT5lUwuatUovfUtcScrRv89uwnDU4t95PrqPHCoX2v0kxAH2ZTTnFnDXDH
         tNcGzm1nZCWl+ir6x8IbVgM4dlvxxz8gdu7gLSttuCeoAjZETeqPcNGth3bZ6iM2Iq+L
         4nq7QINev6v5W7W3mHP+76I5l6D9tnInsS0c2rKuKtDFRYZa0PASc5z1Qn12MTSieLQD
         DYimyhPvigm0SDzP0q+DYPP+IvxknD0r3FVxTsnfWM5Wl9zlPL4TDZprqsFY/m7TBfmn
         S9DQ==
X-Gm-Message-State: APjAAAVe/sDx5vu0fxivrL77u4tcvJy0klADBrZ/vU1SEEiMus+puOVC
        BAOCVLBnD4Q24YkiViDQxtLyk/NjRJOzMAjkYwpvID2Xp6ZB
X-Google-Smtp-Source: APXvYqyVXLEo/jjMIszbb+57gbeMIcQQQ4NHLHVnymlruXfTyWTLRs3a4/mdm1hNEeOE3zoLVQ1xM5hrt3ZJB5fvKi4ssQxwKUhj
MIME-Version: 1.0
X-Received: by 2002:a24:548:: with SMTP id 69mr3334743itl.29.1552693325315;
 Fri, 15 Mar 2019 16:42:05 -0700 (PDT)
Date:   Fri, 15 Mar 2019 16:42:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019ca8105842a9660@google.com>
Subject: possible deadlock in dev_uc_sync_multiple
From:   syzbot <syzbot+829513abde137358d25d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        ivan.khoronzhuk@linaro.org, jiri@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        petrm@mellanox.com, sunlw.fnst@cn.fujitsu.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3b319ee2 Merge tag 'acpi-5.1-rc1-2' of git://git.kernel.or..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11c3d30b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f05902bca21d8935
dashboard link: https://syzkaller.appspot.com/bug?extid=829513abde137358d25d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+829513abde137358d25d@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
============================================
WARNING: possible recursive locking detected
5.0.0+ #122 Not tainted
--------------------------------------------
syz-executor.5/22213 is trying to acquire lock:
0000000074b895b8 (&vlan_netdev_addr_lock_key/2){+...}, at:  
netif_addr_lock_nested include/linux/netdevice.h:4058 [inline]
0000000074b895b8 (&vlan_netdev_addr_lock_key/2){+...}, at:  
dev_uc_sync_multiple+0x126/0x1f0 net/core/dev_addr_lists.c:674

but task is already holding lock:
00000000bb344d7d (&vlan_netdev_addr_lock_key/2){+...}, at: spin_lock_bh  
include/linux/spinlock.h:334 [inline]
00000000bb344d7d (&vlan_netdev_addr_lock_key/2){+...}, at:  
netif_addr_lock_bh include/linux/netdevice.h:4063 [inline]
00000000bb344d7d (&vlan_netdev_addr_lock_key/2){+...}, at:  
dev_set_rx_mode+0x20/0x40 net/core/dev.c:7493

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&vlan_netdev_addr_lock_key/2);
   lock(&vlan_netdev_addr_lock_key/2);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

4 locks held by syz-executor.5/22213:
  #0: 00000000cc51f097 (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:76
  #1: 00000000bb344d7d (&vlan_netdev_addr_lock_key/2){+...}, at:  
spin_lock_bh include/linux/spinlock.h:334 [inline]
  #1: 00000000bb344d7d (&vlan_netdev_addr_lock_key/2){+...}, at:  
netif_addr_lock_bh include/linux/netdevice.h:4063 [inline]
  #1: 00000000bb344d7d (&vlan_netdev_addr_lock_key/2){+...}, at:  
dev_set_rx_mode+0x20/0x40 net/core/dev.c:7493
  #2: 00000000ae9bba03 (&dev_addr_list_lock_key#2/1){+...}, at:  
netif_addr_lock_nested include/linux/netdevice.h:4058 [inline]
  #2: 00000000ae9bba03 (&dev_addr_list_lock_key#2/1){+...}, at:  
dev_mc_sync+0x126/0x1f0 net/core/dev_addr_lists.c:865
  #3: 00000000a2ed60f7 (rcu_read_lock){....}, at: team_set_rx_mode+0x0/0x230  
drivers/net/team/team.c:1440

stack backtrace:
CPU: 0 PID: 22213 Comm: syz-executor.5 Not tainted 5.0.0+ #122
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_deadlock_bug kernel/locking/lockdep.c:2100 [inline]
  check_deadlock kernel/locking/lockdep.c:2144 [inline]
  validate_chain kernel/locking/lockdep.c:2698 [inline]
  __lock_acquire.cold+0x233/0x50d kernel/locking/lockdep.c:3701
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
  _raw_spin_lock_nested+0x35/0x50 kernel/locking/spinlock.c:354
  netif_addr_lock_nested include/linux/netdevice.h:4058 [inline]
  dev_uc_sync_multiple+0x126/0x1f0 net/core/dev_addr_lists.c:674
  team_set_rx_mode+0xd2/0x230 drivers/net/team/team.c:1745
  __dev_set_rx_mode+0x1eb/0x300 net/core/dev.c:7488
  dev_mc_sync+0x1a4/0x1f0 net/core/dev_addr_lists.c:868
  vlan_dev_set_rx_mode+0x3f/0x80 net/8021q/vlan_dev.c:485
  __dev_set_rx_mode+0x1eb/0x300 net/core/dev.c:7488
  dev_set_rx_mode+0x28/0x40 net/core/dev.c:7494
  __dev_open+0x28a/0x3d0 net/core/dev.c:1403
  __dev_change_flags+0x568/0x6e0 net/core/dev.c:7567
  dev_change_flags+0x92/0x170 net/core/dev.c:7638
  vlan_device_event+0x588/0x22d0 net/8021q/vlan.c:464
  notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
  call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
  call_netdevice_notifiers net/core/dev.c:1765 [inline]
  __dev_notify_flags+0x121/0x2c0 net/core/dev.c:7605
  dev_change_flags+0x10d/0x170 net/core/dev.c:7643
  devinet_ioctl+0xde6/0x1cf0 net/ipv4/devinet.c:1104
  inet_ioctl+0x2d4/0x410 net/ipv4/af_inet.c:954
  packet_ioctl+0xcb/0x2b0 net/packet/af_packet.c:4099
  sock_do_ioctl+0xde/0x300 net/socket.c:972
  sock_ioctl+0x32b/0x610 net/socket.c:1096
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458079
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3b4fed9c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458079
RDX: 0000000020000240 RSI: 0000000000008914 RDI: 0000000000000003
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3b4feda6d4
R13: 00000000004c3670 R14: 00000000004d64a8 R15: 00000000ffffffff
IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
