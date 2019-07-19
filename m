Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148CCC76197
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6812184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfGSDfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:35:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33931 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGSDfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:35:06 -0400
Received: by mail-io1-f71.google.com with SMTP id u84so33248012iod.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 20:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bqDgpOq4EZp5pgQlB1rL7ChcDj36IUT/kLHpPRLJieQ=;
        b=bsA+u/BxLrH1bH+MXRmN1ZNQqZeXS471zfcXHTb6fomUsPYHYJLSQdfKArn1kTU8+/
         M4bZj0U69noLmQEDYWwLN+IxHjjhRTtP1bzzGRHxtJydWyMsR6tdbnw2m5EdjNJC9KRv
         /nmbqgIHnfU3jQUtXSo+fJ/27vlZWaNNpdhjFQ0bB7OEfgdVKpQ4mJZoH/cRMJBOGpZR
         NQn8l3iYCgtG+A0jXrJxianHqkHc2Ez7SikNJqp2HFZ9qE8lLLIVum2fGxdeuoCLKMJT
         62fHxkHHZ2b4vJcAbPwIt2iGlEkwvC+pWPf7CYPXr8XGbFCaCXA0BHBW4rEGg0O6V7jq
         AnIw==
X-Gm-Message-State: APjAAAVToaJUkdWuhBoIH13ZyGRZA0Gy8LWhAqYSLYe0Ld678rR1qNrJ
        EERz+xQoMVviKSIoIuA317buyfnOloTSQHqP7WbTuFRCTfpn
X-Google-Smtp-Source: APXvYqwRkyj2r//80kfbXcBFnzJbW8M8j2NN6/I977/eCe4BJBA4YH6I/GXq6SnMoCoHJMbO9cbK6RbXVs5W2qAeMr04nh6sgMxB
MIME-Version: 1.0
X-Received: by 2002:a5e:8b43:: with SMTP id z3mr44387251iom.287.1563507305597;
 Thu, 18 Jul 2019 20:35:05 -0700 (PDT)
Date:   Thu, 18 Jul 2019 20:35:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dd6bb058e006938@google.com>
Subject: WARNING in __mmdrop
From:   syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, keescook@chromium.org,
        ldv@altlinux.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6d21a41b Add linux-next specific files for 20190718
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=134920f0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
dashboard link: https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 9142 at kernel/fork.c:677 __mmdrop+0x26a/0x320  
/kernel/fork.c:677
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9142 Comm: syz-executor.0 Not tainted 5.2.0-next-20190718 #41
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack /lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 /lib/dump_stack.c:113
  panic+0x2dc/0x755 /kernel/panic.c:219
  __warn.cold+0x20/0x4c /kernel/panic.c:576
  report_bug+0x263/0x2b0 /lib/bug.c:186
  fixup_bug /arch/x86/kernel/traps.c:179 [inline]
  fixup_bug /arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 /arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 /arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 /arch/x86/entry/entry_64.S:1008
RIP: 0010:__mmdrop+0x26a/0x320 /kernel/fork.c:677
Code: 5f 5d c3 e8 18 7e 2f 00 4c 89 ef e8 60 d7 2b 00 eb d2 e8 09 7e 2f 00  
0f 0b e8 02 7e 2f 00 0f 0b e9 fa fd ff ff e8 f6 7d 2f 00 <0f> 0b e9 2b fe  
ff ff e8 ea 7d 2f 00 4c 89 e7 e8 a2 f7 67 00 e9 85
RSP: 0018:ffff8880a176fac0 EFLAGS: 00010293
RAX: ffff888098f02600 RBX: ffff888098f02600 RCX: ffffffff81430bab
RDX: 0000000000000000 RSI: ffffffff814306fa RDI: ffff888098f02a30
RBP: ffff8880a176fae8 R08: ffff888098f02600 R09: ffffed10148dd4ec
R10: ffffed10148dd4eb R11: ffff8880a46ea75f R12: ffff8880a46ea700
R13: ffff8880a46ea828 R14: ffff8880a46eac50 R15: 0000000000000000
  mmdrop /./include/linux/sched/mm.h:49 [inline]
  __mmput /kernel/fork.c:1074 [inline]
  mmput+0x3f0/0x4d0 /kernel/fork.c:1085
  exit_mm /kernel/exit.c:547 [inline]
  do_exit+0x84e/0x2ea0 /kernel/exit.c:864
  do_group_exit+0x135/0x360 /kernel/exit.c:981
  get_signal+0x47c/0x2500 /kernel/signal.c:2728
  do_signal+0x87/0x1700 /arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 /arch/x86/entry/common.c:159
  prepare_exit_to_usermode /arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath /arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x5a9/0x6a0 /arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459819
Code: Bad RIP value.
RSP: 002b:00007f75afccbc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000459819
RDX: 00000000200023c0 RSI: 000000004028af11 RDI: 0000000000000003
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f75afccc6d4
R13: 00000000004c4722 R14: 00000000004d87d0 R15: 00000000ffffffff
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
