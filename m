Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958C1C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7293E20718
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfKYJMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:12:12 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:39315 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKYJML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:12:11 -0500
Received: by mail-io1-f69.google.com with SMTP id u13so8056340iol.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 01:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5koVtO32iHG1fi3OYlKDnhYVJZ61U3UuaUrqfINFZwA=;
        b=V0QwIVFh3v14VieRfm/UDY3IwFCzCrLVMcEp4CejdiFyZWm5dH2Z8mbhjB1IvCrxyP
         ejH0TwZWuyFTzp8eEP7hAPLauFh8ThQtlqTL4d5H/n0gVLE6otHOuWAVHj3n1+bAddJc
         sG3+WhDbDo/S1QW4Zpb+0u/KSbXzUoibbvj8f+FP5A2h4fEdDLD6Y45IHDhFKIp2/n3f
         2GDop84vLprBVJDNFfOIX2KvfDqlG1AEuJDDmMjdSJkdoBkmBBgq1rz+qrvCpK6dK9bp
         /R9LRlItXgOMcG+fLz9aCTccLe+8eV7nszVsfLrC3fIXrJEMD7d0a6Ay1la+WMzLPbXY
         mA8w==
X-Gm-Message-State: APjAAAUM+UczzxHSGpwkmdaxsk78xnQRuK/LoP706x9G7XmROUMB71Un
        EEJ+x7SxiTR5vJMbHyEt/Om4OxlIrenwr7OG6OKYK8hq+Yaz
X-Google-Smtp-Source: APXvYqwmkHC5eBpCt0AiTaSyRIR3pm0vqd6V6ERDWDrbvCla3M7sn1YfGyYriNrrCnFLOl1DbYzknRIEDzLT25Wa+EwW1d+T6uLM
MIME-Version: 1.0
X-Received: by 2002:a92:9a17:: with SMTP id t23mr31910133ili.40.1574673128923;
 Mon, 25 Nov 2019 01:12:08 -0800 (PST)
Date:   Mon, 25 Nov 2019 01:12:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cace40598282858@google.com>
Subject: WARNING: refcount bug in smc_release (2)
From:   syzbot <syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kgraul@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        ubraun@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c4f2cbd3 Merge branch '100GbE' of git://git.kernel.org/pub..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=172bf5cae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ac526dc3578c3d3
dashboard link: https://syzkaller.appspot.com/bug?extid=96d3f9ff6a86d37e44c8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 20712 at lib/refcount.c:190  
refcount_sub_and_test_checked lib/refcount.c:190 [inline]
WARNING: CPU: 0 PID: 20712 at lib/refcount.c:190  
refcount_sub_and_test_checked+0x1d0/0x200 lib/refcount.c:180
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 20712 Comm: syz-executor.0 Not tainted 5.4.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x35 kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:refcount_sub_and_test_checked lib/refcount.c:190 [inline]
RIP: 0010:refcount_sub_and_test_checked+0x1d0/0x200 lib/refcount.c:180
Code: 1d fb 91 7d 06 31 ff 89 de e8 6c f1 2d fe 84 db 75 94 e8 23 f0 2d fe  
48 c7 c7 00 d9 e6 87 c6 05 db 91 7d 06 01 e8 b8 22 ff fd <0f> 0b e9 75 ff  
ff ff e8 04 f0 2d fe e9 6e ff ff ff 48 89 df e8 17
RSP: 0018:ffff88807446fa80 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000f9af RSI: ffffffff815d2076 RDI: ffffed100e88df42
RBP: ffff88807446fb18 R08: ffff888070648580 R09: ffffed1015d04101
R10: ffffed1015d04100 R11: ffff8880ae820807 R12: 00000000ffffffff
R13: 0000000000000001 R14: ffff88807446faf0 R15: 0000000000000000
  refcount_dec_and_test_checked+0x1b/0x20 lib/refcount.c:220
  sock_put include/net/sock.h:1728 [inline]
  smc_release+0x236/0x3e0 net/smc/af_smc.c:202
  __sock_release+0xce/0x280 net/socket.c:590
  sock_close+0x1e/0x30 net/socket.c:1268
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  get_signal+0x2078/0x2500 kernel/signal.c:2528
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a639
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1a52923c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffff8d RBX: 0000000000000003 RCX: 000000000045a639
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1a529246d4
R13: 00000000004c0dc8 R14: 00000000004d3a00 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
