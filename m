Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B36EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77862082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfC1QZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:25:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34355 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1QZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:25:07 -0400
Received: by mail-io1-f71.google.com with SMTP id y13so16200897iol.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Yf4H6VlySuXfZGixloSBAIzofGWW3QZDm4eHyshp3o4=;
        b=lkxbDO4/V8ylzqJVvUvrOPiv6wT+Z8393Qg/68C73xn0dJp5438LZSJrOGsPaWMVJO
         Eeuj58Ff9Uj1fvRgjB+W3UNcq7G3r3kCHiVyRkGx6i70Bv41llWn84kuRptIIsLnjBXO
         fMgB2G5Vq6Omv/1m5nOvZOjMdTAFUPOWclLpJClVFnUXBoDLuyifPcYyuPVOgt+Nl3/I
         8wjI/bijj01MUNwP7gdgQY1X2oK7XdMbrIGYx7SyUizypZTX0WfdeB1ivOM/Sia9dQ/G
         H3DCFaJnGTaK+8ljbnKKQtwOCUNiSWlD/t+iz1ZBLJ3oX8kIRazwQzWrW3iqWByR7Rdu
         8Mdw==
X-Gm-Message-State: APjAAAWpuXnjfXy1wtEpJi7qLYTYGRf8qcblk5doYtWPStJ5qkBoTvSx
        vNIalrgkF2Hw0zlsy5IykGzFOfzFmbUjiYgDpoTIa9H9SWsF
X-Google-Smtp-Source: APXvYqzeJMtQUIuiaX34di5C/02mqcV8MCivvGNJtL37j+mzdE86bExEER+gNfu226FfeB016jIbtFnlw+s1bO3DstCx0wOb7/N8
MIME-Version: 1.0
X-Received: by 2002:a05:660c:34a:: with SMTP id b10mr253327itl.13.1553790305877;
 Thu, 28 Mar 2019 09:25:05 -0700 (PDT)
Date:   Thu, 28 Mar 2019 09:25:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003cca5a058529ffe6@google.com>
Subject: KMSAN: uninit-value in tipc_nl_compat_name_table_dump (2)
From:   syzbot <syzbot+3ce8520484b0d4e260a5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a695dc5e kmsan: fixup mm/sl[au]b.[ch] after rebase
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=1683e04d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5675814e8eae69e
dashboard link: https://syzkaller.appspot.com/bug?extid=3ce8520484b0d4e260a5
compiler:       clang version 8.0.0 (trunk 350509)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bdf95f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b5a4cf200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3ce8520484b0d4e260a5@syzkaller.appspotmail.com

sshd (11234) used greatest stack depth: 54160 bytes left
==================================================================
BUG: KMSAN: uninit-value in __arch_swab32  
arch/x86/include/uapi/asm/swab.h:10 [inline]
BUG: KMSAN: uninit-value in __fswab32 include/uapi/linux/swab.h:59 [inline]
BUG: KMSAN: uninit-value in tipc_nl_compat_name_table_dump+0x54f/0xcd0  
net/tipc/netlink_compat.c:872
CPU: 1 PID: 11248 Comm: syz-executor646 Not tainted 5.0.0+ #11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:600
  __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
  __arch_swab32 arch/x86/include/uapi/asm/swab.h:10 [inline]
  __fswab32 include/uapi/linux/swab.h:59 [inline]
  tipc_nl_compat_name_table_dump+0x54f/0xcd0 net/tipc/netlink_compat.c:872
  __tipc_nl_compat_dumpit+0x59e/0xda0 net/tipc/netlink_compat.c:215
  tipc_nl_compat_dumpit+0x63a/0x820 net/tipc/netlink_compat.c:280
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1226 [inline]
  tipc_nl_compat_recv+0x1b5f/0x2750 net/tipc/netlink_compat.c:1265
  genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
  genl_rcv_msg+0x185f/0x1a60 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x431/0x620 net/netlink/af_netlink.c:2477
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0xf3e/0x1020 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x127f/0x1300 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg net/socket.c:632 [inline]
  ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2115
  __sys_sendmsg net/socket.c:2153 [inline]
  __do_sys_sendmsg net/socket.c:2162 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2160
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2160
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x444069
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffda17b3718 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444069
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
R10: 0000000000001900 R11: 0000000000000246 R12: 0000000000401d10
R13: 0000000000401da0 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:205 [inline]
  kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:159
  kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:176
  kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:185
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2773 [inline]
  __kmalloc_node_track_caller+0xe9e/0xff0 mm/slub.c:4398
  __kmalloc_reserve net/core/skbuff.c:140 [inline]
  __alloc_skb+0x309/0xa20 net/core/skbuff.c:208
  alloc_skb include/linux/skbuff.h:1012 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
  netlink_sendmsg+0xb82/0x1300 net/netlink/af_netlink.c:1892
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg net/socket.c:632 [inline]
  ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2115
  __sys_sendmsg net/socket.c:2153 [inline]
  __do_sys_sendmsg net/socket.c:2162 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2160
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2160
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
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
