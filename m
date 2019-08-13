Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7970C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9412620844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfHMOsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:48:06 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72]:54951 "EHLO
        mail-ot1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbfHMOsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:48:06 -0400
Received: by mail-ot1-f72.google.com with SMTP id y18so4451286oto.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qKRmS8Pukop7C0xjn0nFaye40L0MErSoh046YSsneTE=;
        b=lVzvzuwNeNfPeNRqGr+aHfd3reHJbWruCTyZ3gUexnsEl2nQH21pJxJ8MgLVJXnp/C
         qV3Y0FLMz4+rAforEYchOC+I3JuJvbxVjrNpscCLP5x8oEB+sguK+vq8qI7y7plUHf7e
         4vGs32ESZYyVrwZmhGolE0iaD6p3acOFFpxyYRYM9jhRSgadHHZnwLh6ut0K0BX7iXLi
         GnYlaTI6YVhFUen6afh6liUY4dcbMLnl92L/0kJ7ZyLt81EhoArVqux6Cw6jdP2BSmEp
         Glg2dvPdOuy3LbFH3BDEvfn6hkdPe5s7Z5h+2KzmqvKCFdvXiqGh0ytKrQdsm9FMd5YK
         pCPg==
X-Gm-Message-State: APjAAAWj+l9WqebztU2vCZ9JGBqJEzK5lQycSCUAq0zCFIyMKdCvDg9z
        4fAkKQwuQdvp5T6b9ZGiM6KbYpQmTKrfEcKZiiPtvboZ1xgo
X-Google-Smtp-Source: APXvYqye54lU8FpqTevFpEYjhZmfiH/BhKObMucueBlLE1fCRQ/e9TuP96uw7XN6evxSK0f3GUh9fIzvebU/mDfXVq6tJ0zHm78+
MIME-Version: 1.0
X-Received: by 2002:a6b:cac2:: with SMTP id a185mr9329142iog.142.1565707685371;
 Tue, 13 Aug 2019 07:48:05 -0700 (PDT)
Date:   Tue, 13 Aug 2019 07:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068a9b7059000ba1a@google.com>
Subject: KMSAN: uninit-value in ipv6_find_tlv
From:   syzbot <syzbot+8257f4dcef79de670baf@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    61ccdad1 Revert "drm/bochs: Use shadow buffer for bochs fr..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1229a18c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27abc558ecb16a3b
dashboard link: https://syzkaller.appspot.com/bug?extid=8257f4dcef79de670baf
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12480dce600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1659dc4a600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8257f4dcef79de670baf@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in ipv6_find_tlv+0x370/0x3c0  
net/ipv6/exthdrs_core.c:147
CPU: 1 PID: 12844 Comm: syz-executor755 Not tainted 5.3.0-rc3+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  ipv6_find_tlv+0x370/0x3c0 net/ipv6/exthdrs_core.c:147
  ip6_find_1stfragopt+0x2b6/0x500 net/ipv6/output_core.c:102
  ip6_fragment+0x275/0x37d0 net/ipv6/ip6_output.c:775
  __ip6_finish_output+0x753/0x8f0 net/ipv6/ip6_output.c:140
  ip6_finish_output+0x2db/0x420 net/ipv6/ip6_output.c:152
  NF_HOOK_COND include/linux/netfilter.h:294 [inline]
  ip6_output+0x5d3/0x720 net/ipv6/ip6_output.c:175
  dst_output include/net/dst.h:436 [inline]
  ip6_local_out+0x164/0x1d0 net/ipv6/output_core.c:179
  ip6_send_skb net/ipv6/ip6_output.c:1791 [inline]
  ip6_push_pending_frames+0x215/0x4f0 net/ipv6/ip6_output.c:1811
  rawv6_push_pending_frames net/ipv6/raw.c:613 [inline]
  rawv6_sendmsg+0x40da/0x5b10 net/ipv6/raw.c:954
  inet_sendmsg+0x2d8/0x2e0 net/ipv4/af_inet.c:807
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg net/socket.c:657 [inline]
  sock_write_iter+0x599/0x650 net/socket.c:989
  call_write_iter include/linux/fs.h:1870 [inline]
  new_sync_write fs/read_write.c:483 [inline]
  __vfs_write+0xa2c/0xcb0 fs/read_write.c:496
  vfs_write+0x481/0x920 fs/read_write.c:558
  ksys_write+0x265/0x430 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write+0x92/0xb0 fs/read_write.c:620
  __x64_sys_write+0x4a/0x70 fs/read_write.c:620
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:297
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x452be9
Code: e8 7c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b 05 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbf62544ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006efa08 RCX: 0000000000452be9
RDX: 00000000000041a0 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00000000006efa00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006efa0c
R13: 00007ffec68fe78f R14: 00007fbf625459c0 R15: 20c49ba5e353f7cf

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:187 [inline]
  kmsan_internal_poison_shadow+0x53/0xa0 mm/kmsan/kmsan.c:146
  kmsan_slab_alloc+0xaa/0x120 mm/kmsan/kmsan_hooks.c:175
  slab_alloc_node mm/slub.c:2790 [inline]
  __kmalloc_node_track_caller+0xb55/0x1320 mm/slub.c:4388
  __kmalloc_reserve net/core/skbuff.c:141 [inline]
  __alloc_skb+0x306/0xa10 net/core/skbuff.c:209
  alloc_skb include/linux/skbuff.h:1056 [inline]
  __ip6_append_data+0x46ad/0x6060 net/ipv6/ip6_output.c:1514
  ip6_append_data+0x3c2/0x650 net/ipv6/ip6_output.c:1683
  rawv6_sendmsg+0x232e/0x5b10 net/ipv6/raw.c:947
  inet_sendmsg+0x2d8/0x2e0 net/ipv4/af_inet.c:807
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg net/socket.c:657 [inline]
  sock_write_iter+0x599/0x650 net/socket.c:989
  call_write_iter include/linux/fs.h:1870 [inline]
  new_sync_write fs/read_write.c:483 [inline]
  __vfs_write+0xa2c/0xcb0 fs/read_write.c:496
  vfs_write+0x481/0x920 fs/read_write.c:558
  ksys_write+0x265/0x430 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write+0x92/0xb0 fs/read_write.c:620
  __x64_sys_write+0x4a/0x70 fs/read_write.c:620
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
