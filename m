Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC278C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A971E214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388539AbfETOSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:18:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44554 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbfETOSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:18:07 -0400
Received: by mail-io1-f72.google.com with SMTP id z10so11572575iom.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=P+sFv2uSPT1L4zUsLZGVb581nILdaxJm6Izz/gA2bCo=;
        b=iEbJ9YEvioW2rZcfnw/UW4FSHmgs22mn575H8Wxu9J0C+8pbk7D20Ab9vBz8V/kAWZ
         06oh2oF5enBr85iUYmQhjr3HJsZrTvPOHcqcMMfJE5qCDNTjeK52RtE6pW2GYl9kolAE
         fM/azHVycTqX6HadEH2MPIwjLysgA7sBGi2HGYEHM+iKp3DlRblmDSzGi/dKYUVmMQT2
         MoYa3wIm1LqCtqrq7k9B4zyzj4ycjGcMsPF+I4wcw6KfyU6Tc8ujqbYcMoR7Lt7CfTox
         EyLXaaxjrY43hWeqz4WJanllVAtwDwFi86pPDn/z9IyYfhEB2F7ovnUJ9yKUP0xc0WWq
         aM8w==
X-Gm-Message-State: APjAAAX71JPd60nHZSr46pLR+GsAX7CSJgIWtHVVfpgHJsCKaMlUNkZ3
        wPAjn189lC24uGJrBhoLx3czaSu9pEM6u5Q07alk9hhaHfOQ
X-Google-Smtp-Source: APXvYqxjFiFl8L3a9AU7tD857OMIH3xVNRoGOw4n8gDhqtEP+BPGkHVrYFTvYy50gR7dvZOqLw4OdNhbK04P9mZYN1JC0ltdjnNX
MIME-Version: 1.0
X-Received: by 2002:a6b:8b49:: with SMTP id n70mr15033070iod.198.1558361886677;
 Mon, 20 May 2019 07:18:06 -0700 (PDT)
Date:   Mon, 20 May 2019 07:18:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000afe2c70589526668@google.com>
Subject: WARNING in binder_transaction_buffer_release
From:   syzbot <syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    72cf0b07 Merge tag 'sound-fix-5.2-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c7d4bca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d103f114f9010324
dashboard link: https://syzkaller.appspot.com/bug?extid=8b3c354d33c4ac78bfad
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b99b44a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 8535 at drivers/android/binder.c:2368  
binder_transaction_buffer_release+0x673/0x8f0 drivers/android/binder.c:2368
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8535 Comm: syz-executor.2 Not tainted 5.1.0+ #19
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x715 kernel/panic.c:214
  __warn.cold+0x20/0x4c kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:binder_transaction_buffer_release+0x673/0x8f0  
drivers/android/binder.c:2368
Code: 31 ff 41 89 c5 89 c6 e8 7b 04 1f fc 45 85 ed 0f 85 1f 41 01 00 49 8d  
47 40 48 89 85 50 fe ff ff e9 9d fa ff ff e8 dd 02 1f fc <0f> 0b e9 7f fc  
ff ff e8 d1 02 1f fc 48 89 d8 45 31 c9 4c 89 fe 4c
RSP: 0018:ffff88807b2775f0 EFLAGS: 00010293
RAX: ffff888092b1e040 RBX: 0000000000000060 RCX: 1ffff11012563caa
RDX: 0000000000000000 RSI: ffffffff85519e13 RDI: ffff888097a2d248
RBP: ffff88807b2777d8 R08: ffff888092b1e040 R09: ffffed100f64eee3
R10: ffffed100f64eee2 R11: ffff88807b277717 R12: ffff88808fd2c340
R13: 0000000000000068 R14: ffff88807b2777b0 R15: ffff88809f7ea580
  binder_transaction+0x153d/0x6620 drivers/android/binder.c:3484
  binder_thread_write+0x87e/0x2820 drivers/android/binder.c:3792
  binder_ioctl_write_read drivers/android/binder.c:4836 [inline]
  binder_ioctl+0x102f/0x1833 drivers/android/binder.c:5013
  __do_compat_sys_ioctl fs/compat_ioctl.c:1052 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:998 [inline]
  __ia32_compat_sys_ioctl+0x195/0x620 fs/compat_ioctl.c:998
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xd7d arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f9e849
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f9a0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000c0306201
RDX: 0000000020000140 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
