Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4D2C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158082190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfGVOiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:38:12 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47841 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfGVOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:38:12 -0400
Received: by mail-io1-f72.google.com with SMTP id r27so43664145iob.14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 07:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=biUyI2z00QE637y9oixlRtsJtjJXbQ+bvKbVFhqozzI=;
        b=FMLsZ86ooQTL7epIYg/0yNnSIim15oql3Qb07IeStLIaocWRGmItCRtToWhXA+Z+TL
         z/Fs7E65PccD+FO8rVUYm/M/c6FSCgV95hd2vjJO7ux5JJd1yot2I5d3opMrJWmC8Z2w
         Hir/m3OgYI/1NdxYJkLNz9SnAYhP0URuq/EbkILlUHJHnAl3OzizYsas5tmDXMnNujRP
         XsEJzRZ/JRoXoQqreM0Up0kYfyP7y0Vp2cS9bthKk1gJsl31YUXH3flKAHZuIq/13t04
         rGlAsMDuxxiUW8cLr3rcMOiOqwTSUkZL1u5aN4Y47gkTMAgC4Iy3wT0q8LB/O+/edEAs
         xQTA==
X-Gm-Message-State: APjAAAWCKHqkpb5zV4vpW1DIW+Ftg7JEsn0muXPikOXUA5ssj5fGQWZZ
        /zclFlBY3glogPOOGaQEpiat7uw8Tpe08xB6KE5k+73Metvj
X-Google-Smtp-Source: APXvYqzs2rLTXtYoGOqSLLMHqSG4lQ6HPtIIv13aigQxozauUTAeTOoktwIXterCgs8RezmVJSHPYJIN9w+8PaXAQgCOWXZ8+3Nq
MIME-Version: 1.0
X-Received: by 2002:a5e:8a46:: with SMTP id o6mr33181914iom.36.1563806290878;
 Mon, 22 Jul 2019 07:38:10 -0700 (PDT)
Date:   Mon, 22 Jul 2019 07:38:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000772876058e46063f@google.com>
Subject: general protection fault in tcf_ife_init
From:   syzbot <syzbot+fbb5b288c9cb6a2eeac4@syzkaller.appspotmail.com>
To:     gwshan@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, ruscur@russell.cc, stewart@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3bfe1fc4 Merge tag 'for-5.3/dm-changes-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163c6e58600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8841b9f4365c7de
dashboard link: https://syzkaller.appspot.com/bug?extid=fbb5b288c9cb6a2eeac4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110322afa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c1c168600000

The bug was bisected to:

commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
Author: Russell Currey <ruscur@russell.cc>
Date:   Mon Feb 8 04:08:20 2016 +0000

     powerpc/powernv: Remove support for p5ioc2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10367478600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12367478600000
console output: https://syzkaller.appspot.com/x/log.txt?x=14367478600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fbb5b288c9cb6a2eeac4@syzkaller.appspotmail.com
Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")

netlink: 4 bytes leftover after parsing attributes in process  
`syz-executor960'.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9229 Comm: syz-executor960 Not tainted 5.2.0+ #69
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:nla_parse_nested_deprecated /./include/net/netlink.h:1167 [inline]
RIP: 0010:tcf_ife_init+0x25c/0x1850 /net/sched/act_ife.c:484
Code: 00 00 48 c7 c7 40 c2 da 88 e8 f0 8c a2 fb 48 89 da 48 b8 00 00 00 00  
00 fc ff df 48 c7 85 e8 fe ff ff 00 00 00 00 48 c1 ea 03 <0f> b6 14 02 48  
89 d8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 e2
RSP: 0018:ffff88809032eeb8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff110119c21b0
RDX: 0000000000000000 RSI: 1ffff110119c21b7 RDI: 0000000000000282
RBP: ffff88809032f060 R08: 0000000000000002 R09: ffff88808ce10d88
R10: fffffbfff134a0cf R11: ffffffff89a5067f R12: 0000000000000001
R13: ffff8882166dd240 R14: ffff88809032f8c0 R15: 0000000000000000
FS:  0000555556e20880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000180 CR3: 0000000088374000 CR4: 00000000001406f0
Call Trace:
  tcf_action_init_1+0x6f2/0xa80 /net/sched/act_api.c:915
  tcf_action_init+0x241/0x360 /net/sched/act_api.c:971
  tcf_action_add+0xe8/0x370 /net/sched/act_api.c:1356
  tc_ctl_action+0x3b5/0x4bc /net/sched/act_api.c:1408
  rtnetlink_rcv_msg+0x463/0xb00 /net/core/rtnetlink.c:5223
  netlink_rcv_skb+0x177/0x450 /net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x1d/0x30 /net/core/rtnetlink.c:5241
  netlink_unicast_kernel /net/netlink/af_netlink.c:1302 [inline]
  netlink_unicast+0x531/0x710 /net/netlink/af_netlink.c:1328
  netlink_sendmsg+0x8a5/0xd60 /net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec /net/socket.c:633 [inline]
  sock_sendmsg+0xd7/0x130 /net/socket.c:653
  ___sys_sendmsg+0x803/0x920 /net/socket.c:2307
  __sys_sendmsg+0x105/0x1d0 /net/socket.c:2352
  __do_sys_sendmsg /net/socket.c:2361 [inline]
  __se_sys_sendmsg /net/socket.c:2359 [inline]
  __x64_sys_sendmsg+0x78/0xb0 /net/socket.c:2359
  do_syscall_64+0xfd/0x6a0 /arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4401d9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff767975d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401d9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a60
R13: 0000000000401af0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 6937a8efb11262f5 ]---
RIP: 0010:nla_parse_nested_deprecated /./include/net/netlink.h:1167 [inline]
RIP: 0010:tcf_ife_init+0x25c/0x1850 /net/sched/act_ife.c:484
Code: 00 00 48 c7 c7 40 c2 da 88 e8 f0 8c a2 fb 48 89 da 48 b8 00 00 00 00  
00 fc ff df 48 c7 85 e8 fe ff ff 00 00 00 00 48 c1 ea 03 <0f> b6 14 02 48  
89 d8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 e2
RSP: 0018:ffff88809032eeb8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff110119c21b0
RDX: 0000000000000000 RSI: 1ffff110119c21b7 RDI: 0000000000000282
RBP: ffff88809032f060 R08: 0000000000000002 R09: ffff88808ce10d88
R10: fffffbfff134a0cf R11: ffffffff89a5067f R12: 0000000000000001
R13: ffff8882166dd240 R14: ffff88809032f8c0 R15: 0000000000000000
FS:  0000555556e20880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000180 CR3: 0000000088374000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
