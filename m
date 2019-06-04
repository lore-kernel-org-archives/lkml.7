Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03543C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4DF24AE6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFDFBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:01:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:60090 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFDFBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:01:06 -0400
Received: by mail-it1-f197.google.com with SMTP id h133so17005485ith.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 22:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=A4yfKrNSVnkTK0Cf/TTluXfNnZtEW8Q1ZWKjTfgslK8=;
        b=R+k2ia3NMdqZf0JC557/V8zMs4oqHn7R7mPQxKXbNoAWSKFu+9FenxslBYsxhn24Rh
         jFsceux7qNjpAqmMOOyqInJiVgTeBcxgNTkeMoa+qk9plkFCy8XFA7/PuQF0oDffQxe3
         S7xZ4QWBGGBvng15nPsaio+8c98uOz1tdPFy4HUXJgRHpSqsFxyMY6ZhwWPBa1jG3pv9
         8SZAL//F+9EQ39lEPxVVSNwqBmyC6v5Xqe1+XExa8saJrwO2G3DcUZc8UNbOP7VsxK+4
         iUlYF2w5Smj2Az+PaJRoDDEk1zIWEwc7+vw+681UZdnjQkb5N94B1SUrJjq/lhhI7Q1D
         NY2Q==
X-Gm-Message-State: APjAAAUJ6jPwgrB41JK81h8y8Rgi3Nl7yFNjAGubrjC3IRpsfZDMq21i
        EVG4TMV8Ad1mlP2LQR7Cv8hhh5ZhrLYLs0Ah+MIipS4E3Zg8
X-Google-Smtp-Source: APXvYqxvBtoBnpGZ176bCjqPOCoQQLbnMDyZv7dGlOFR9r0pi0+wg0kLQgXx5LvYnz50XFrPpJNtK2NuJD4frwys3GDrSWAQc0eR
MIME-Version: 1.0
X-Received: by 2002:a24:da83:: with SMTP id z125mr8336026itg.126.1559624465476;
 Mon, 03 Jun 2019 22:01:05 -0700 (PDT)
Date:   Mon, 03 Jun 2019 22:01:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f73d9058a785eec@google.com>
Subject: KASAN: user-memory-access Write in fib6_purge_rt (2)
From:   syzbot <syzbot+420d3f70afb5d69d5a96@syzkaller.appspotmail.com>
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

HEAD commit:    58e8b370 Merge branch 'net-phy-dp83867-add-some-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17bb8b9aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
dashboard link: https://syzkaller.appspot.com/bug?extid=420d3f70afb5d69d5a96
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+420d3f70afb5d69d5a96@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in fib6_drop_pcpu_from  
net/ipv6/ip6_fib.c:925 [inline]
BUG: KASAN: user-memory-access in fib6_purge_rt+0x1b3/0x5e0  
net/ipv6/ip6_fib.c:937
Write of size 8 at addr 000000000000ebb4 by task syz-executor.3/14149

CPU: 0 PID: 14149 Comm: syz-executor.3 Not tainted 5.2.0-rc1+ #33
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __kasan_report.cold+0x5/0x40 mm/kasan/report.c:321
  kasan_report+0x12/0x20 mm/kasan/common.c:614
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_write+0x14/0x20 mm/kasan/common.c:100
  fib6_drop_pcpu_from net/ipv6/ip6_fib.c:925 [inline]
  fib6_purge_rt+0x1b3/0x5e0 net/ipv6/ip6_fib.c:937
  fib6_del_route net/ipv6/ip6_fib.c:1812 [inline]
  fib6_del+0xac2/0x10a0 net/ipv6/ip6_fib.c:1843
  fib6_clean_node+0x3a5/0x590 net/ipv6/ip6_fib.c:2005
  fib6_walk_continue+0x4a9/0x8e0 net/ipv6/ip6_fib.c:1927
  fib6_walk+0x9d/0x100 net/ipv6/ip6_fib.c:1975
  fib6_clean_tree+0xe0/0x120 net/ipv6/ip6_fib.c:2054
  __fib6_clean_all+0x118/0x2a0 net/ipv6/ip6_fib.c:2070
  fib6_clean_all+0x2b/0x40 net/ipv6/ip6_fib.c:2081
  rt6_sync_down_dev+0x134/0x150 net/ipv6/route.c:4169
  rt6_disable_ip+0x27/0x5f0 net/ipv6/route.c:4174
  addrconf_ifdown+0xa2/0x1220 net/ipv6/addrconf.c:3709
  addrconf_notify+0x5db/0x2270 net/ipv6/addrconf.c:3634
  notifier_call_chain+0xc2/0x230 kernel/notifier.c:95
  __raw_notifier_call_chain kernel/notifier.c:396 [inline]
  raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:403
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1753
  call_netdevice_notifiers_extack net/core/dev.c:1765 [inline]
  call_netdevice_notifiers net/core/dev.c:1779 [inline]
  __dev_notify_flags+0x1e9/0x2c0 net/core/dev.c:7628
  dev_change_flags+0x10d/0x170 net/core/dev.c:7664
  devinet_ioctl+0x138a/0x1c50 net/ipv4/devinet.c:1104
  inet_ioctl+0x1f4/0x340 net/ipv4/af_inet.c:952
  sock_do_ioctl+0xd8/0x2f0 net/socket.c:1049
  sock_ioctl+0x3ed/0x780 net/socket.c:1200
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd5f/0x1380 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459279
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f79b318dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459279
RDX: 0000000020000080 RSI: 0000000000008914 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f79b318e6d4
R13: 00000000004c4c76 R14: 00000000004d89b8 R15: 00000000ffffffff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
