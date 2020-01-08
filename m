Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE1C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48B52072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgAHJOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:14:25 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:44354 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgAHJON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:14:13 -0500
Received: by mail-io1-f72.google.com with SMTP id t17so1637851ioi.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nNcDxjC0i6zW6d8RtDPzoCYZPPPoHTcAJTNqAlStvFM=;
        b=RNv+zjjS1CzAF90NpE/AZVzpMUQwa1DNL3uvmSccSpawRX624EWox45+NeCk1ezHdj
         6q05lgJPPVJG6vKt0VxDLMqH+Lnl0cEkZ5Bjs/pQOBJXG/uwqjksfyUqfnE8nWYmcudm
         wbu1LjY45tjH/A25qeEoGyByjbCHnXHz/EyalpTlj5//pMW6jmqBSSNPIbq0GP/R+fMc
         /FKmbDjqbYiMxGXtUivcmvazndk/uXztrHDSVXZxkfnEIGc/DROECBiIFK6D+RIQKjlf
         lJvyLpX5fK32PsDlil2cljQHEN9D+cU9aMwzJmtBzZDTCO2lk8Wnta7/addZu8FmCojj
         k5Gw==
X-Gm-Message-State: APjAAAVCePBcoL8uD9YXxV5NiyKf2Jp7cnzAZ1a+lcNnr+FugI6cve4x
        gN7QpGGQs5GN5Sp+PDDkdH9/M4GaW/uu72Krg+qZt0jHBVht
X-Google-Smtp-Source: APXvYqxFGFNRTWCHDCrDVH1GZp4bbMYJoNqEMb08afJMFsFUPTXkCjhrqJMEdj4Gz1QxzbQWgO9zXqHbxj4I+zCJO66eysq1S783
MIME-Version: 1.0
X-Received: by 2002:a6b:6a02:: with SMTP id x2mr2478010iog.20.1578474852851;
 Wed, 08 Jan 2020 01:14:12 -0800 (PST)
Date:   Wed, 08 Jan 2020 01:14:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e428d5059b9d50fd@google.com>
Subject: general protection fault in hash_netport6_uadt
From:   syzbot <syzbot+e2362b2c3f229b2c9447@syzkaller.appspotmail.com>
To:     allison@lohutok.net, coreteam@netfilter.org, davem@davemloft.net,
        fw@strlen.de, info@metux.net, jeremy@azazel.net,
        kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ae608821 Merge tag 'trace-v5.5-rc5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d79459e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18698c0c240ba616
dashboard link: https://syzkaller.appspot.com/bug?extid=e2362b2c3f229b2c9447
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161800d1e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e2362b2c3f229b2c9447@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 10079 Comm: syz-executor.0 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:hash_netport6_uadt+0x21d/0xdb0  
net/netfilter/ipset/ip_set_hash_netport.c:382
Code: 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 3a 09 00 00 4c 89  
f2 45 8b 7f 04 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 4c  
89 f0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 ff
RSP: 0018:ffffc90002077160 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90002077320 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8680fd4a RDI: ffff8880a774f460
RBP: ffffc900020772b8 R08: 0000000000000000 R09: 0000000000000000
R10: ffffed1015d0703c R11: ffff8880ae8381e3 R12: ffff8880a28c6700
R13: ffffc900020771e0 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f34b39a8700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a2b58000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip_set_utest+0x55b/0x890 net/netfilter/ipset/ip_set_core.c:1867
  nfnetlink_rcv_msg+0xcf2/0xfb0 net/netfilter/nfnetlink.c:229
  netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
  nfnetlink_rcv+0x1ba/0x460 net/netfilter/nfnetlink.c:563
  netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
  netlink_unicast+0x58c/0x7d0 net/netlink/af_netlink.c:1328
  netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:639 [inline]
  sock_sendmsg+0xd7/0x130 net/socket.c:659
  ____sys_sendmsg+0x753/0x880 net/socket.c:2330
  ___sys_sendmsg+0x100/0x170 net/socket.c:2384
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2417
  __do_sys_sendmsg net/socket.c:2426 [inline]
  __se_sys_sendmsg net/socket.c:2424 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2424
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45af49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f34b39a7c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045af49
RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000007
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f34b39a86d4
R13: 00000000004c9e62 R14: 00000000004e2e98 R15: 00000000ffffffff
Modules linked in:
---[ end trace 7984c015f140cf61 ]---
RIP: 0010:hash_netport6_uadt+0x21d/0xdb0  
net/netfilter/ipset/ip_set_hash_netport.c:382
Code: 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 3a 09 00 00 4c 89  
f2 45 8b 7f 04 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 4c  
89 f0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 ff
RSP: 0018:ffffc90002077160 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90002077320 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8680fd4a RDI: ffff8880a774f460
RBP: ffffc900020772b8 R08: 0000000000000000 R09: 0000000000000000
R10: ffffed1015d0703c R11: ffff8880ae8381e3 R12: ffff8880a28c6700
R13: ffffc900020771e0 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f34b39a8700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a2b58000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
