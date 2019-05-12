Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45511C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3E82086A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfELKHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 06:07:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48496 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfELKHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 06:07:06 -0400
Received: by mail-io1-f69.google.com with SMTP id l6so7735288ioc.15
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 03:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SwbK8/dps54l1dG2kcxdWF2w0m2EZhw7g0kf1iePc7Y=;
        b=Vtpgq2lc7xwXXQ37rfEJLHecjDJCvS8+SPvt9+XaVk1p7eLM6wENoHxYtIaUFOMQVC
         YJ3OA+tDARwfqaJblsDunt3vOktVNAOPsU3N2GED+eM+/LprxM//77dM1fqh9l7LErlN
         XoLICp61hFW0wIDdVkhkKKTRkygb3L/sBk9iGnVIMSgNc2Or4yNQtdOCJIJmeVdsN5uD
         mP5c87FqKoRxVE3BRIOGvwBGS3TgzfioDRUKeA1ZCwQc1psjKL+o3t5IyfZtuhNvYIQ8
         Zl56iQUgboAjsbEsYIVWZEGL1fah0FBowkYvTrWygXnCdXDF/7UbxEocTMdYAsqeuZdQ
         NxvQ==
X-Gm-Message-State: APjAAAUG3rTinGoGEvyDE3pETTLUcJHedGxGb966YH2EAQJzDblWWA+C
        hazOk8ZhplNlCc+72XsRXLvPZ0YgaSZBTTh3Iuy8J8svbfBf
X-Google-Smtp-Source: APXvYqyOaMxthrTUjL1A0w5tUrIJpEtyHwJlm875IzMh2+D1D7El/3HjtS+KJDf4aWLep6vpgwTrIkBnjAkg3DwZTVsGIQ2r029V
MIME-Version: 1.0
X-Received: by 2002:a24:7d45:: with SMTP id b66mr3216581itc.120.1557655625728;
 Sun, 12 May 2019 03:07:05 -0700 (PDT)
Date:   Sun, 12 May 2019 03:07:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000410d500588adf637@google.com>
Subject: KMSAN: kernel-infoleak in copy_siginfo_to_user (2)
From:   syzbot <syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, glider@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d062d017 usb-fuzzer: main usb gadget fuzzer driver
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=137348b4a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67ebf8b3cce62ce7
dashboard link: https://syzkaller.appspot.com/bug?extid=0d602a1b0d8c95bdf299
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
06d00afa61eef8f7f501ebdb4e8612ea43ec2d78)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175d65e0a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ae05c0a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com

ptrace attach of "./syz-executor353086472"[10278] was attempted  
by "./syz-executor353086472"[10279]
ptrace attach of "./syz-executor353086472"[10280] was attempted  
by "./syz-executor353086472"[10281]
ptrace attach of "./syz-executor353086472"[10282] was attempted  
by "./syz-executor353086472"[10283]
==================================================================
BUG: KMSAN: kernel-infoleak in _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
CPU: 1 PID: 10284 Comm: syz-executor353 Not tainted 5.1.0-rc7+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x130/0x2a0 mm/kmsan/kmsan.c:619
  kmsan_internal_check_memory+0x974/0xa80 mm/kmsan/kmsan.c:713
  kmsan_copy_to_user+0xa9/0xb0 mm/kmsan/kmsan_hooks.c:492
  _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
  copy_to_user include/linux/uaccess.h:174 [inline]
  copy_siginfo_to_user+0x80/0x160 kernel/signal.c:3059
  ptrace_peek_siginfo kernel/ptrace.c:742 [inline]
  ptrace_request+0x24bd/0x2950 kernel/ptrace.c:913
  arch_ptrace+0x9fa/0x1090 arch/x86/kernel/ptrace.c:868
  __do_sys_ptrace kernel/ptrace.c:1155 [inline]
  __se_sys_ptrace+0x2b9/0x7b0 kernel/ptrace.c:1120
  __x64_sys_ptrace+0x56/0x70 kernel/ptrace.c:1120
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x441cc9
Code: e8 bc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00000000007efdd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000065
RAX: ffffffffffffffda RBX: 0000000000000063 RCX: 0000000000441cc9
RDX: 00000000200000c0 RSI: 0000000000000007 RDI: 0000000000004209
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000716000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000402a00 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----info.i@ptrace_request
Variable was created at:
  ptrace_peek_siginfo kernel/ptrace.c:714 [inline]
  ptrace_request+0x2161/0x2950 kernel/ptrace.c:913
  arch_ptrace+0x9fa/0x1090 arch/x86/kernel/ptrace.c:868

Bytes 0-47 of 48 are uninitialized
Memory access of size 48 starts at ffff8880a902fd70
Data copied to user address 0000000000716000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
