Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D332EC468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC992208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfFHTNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:13:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47222 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfFHTNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:13:08 -0400
Received: by mail-io1-f70.google.com with SMTP id r27so4343545iob.14
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 12:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=snVkNvVBfANbdI4HF13neB5Uwc3jmp+YNVgSctgCUSk=;
        b=LEGbcNCvMi+1+zH6iD4c/6HecI+HJlNxYvYV9L8DDE4s06Nwm+Sd1149zIfeCuanpR
         AbzjGgfOLYqvPF36OCePqE2hl8wky0aZbr5EAOxR8ofGJjwq7/rVaQcItl8z/tlsB6j8
         X0fmR8c2de2EkEI9pNvWzVfGm5Ml2BByp7hZCyRRgyD5fiUExuhn0tJeZwBiAiT0nxA/
         pWJcwpOdRhuHzdEl2qtxNCEAanXOIFln4q/p0H/3/fmynebPC9fAIqnFIsLNYpRsEPvE
         CbsBmFR32+maAFdLJ67TPPCflMOakJFUrCIQpD9Y80194A0aKHB1xHlcanMuIkuLRDZ0
         y9+g==
X-Gm-Message-State: APjAAAWoshs8tfVVWNpXMoSWDpIGnnvoGyLTkB9rIcrDRbUcTdgVNOw1
        wiKDyuCjkPz6JjqEtDX9FKnexZ/LkEUnhX5BbXs+6t/kaUpI
X-Google-Smtp-Source: APXvYqwbP7uIfXYGE5OpsxXtJYzQvAN35gaWaxfBkpoYIUfMyxQMjwcK1o+dwTapIydsGDb4IXHcjYpzA99qF5TdYgCkYSHqJMYf
MIME-Version: 1.0
X-Received: by 2002:a24:47c3:: with SMTP id t186mr8276615itb.86.1560021186378;
 Sat, 08 Jun 2019 12:13:06 -0700 (PDT)
Date:   Sat, 08 Jun 2019 12:13:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a802e6058ad4bc53@google.com>
Subject: general protection fault in mm_update_next_owner
From:   syzbot <syzbot+f625baafb9a1c4bfc3f6@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        andrea.parri@amarulasolutions.com, avagin@gmail.com,
        dbueso@suse.de, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        oleg@redhat.com, prsood@codeaurora.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    38e406f6 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10c90fbaa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=f625baafb9a1c4bfc3f6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1193d81ea00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f625baafb9a1c4bfc3f6@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8869 Comm: syz-executor.5 Not tainted 5.2.0-rc3+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
RIP: 0010:mm_update_next_owner+0x3c4/0x640 kernel/exit.c:453
Code: 30 03 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 48 02 00 00 4d 8b  
a4 24 30 03 00 00 49 8d 44 24 10 48 89 45 d0 48 c1 e8 03 <80> 3c 18 00 0f  
85 1b 02 00 00 49 8b 44 24 10 48 39 45 d0 4c 8d a0
RSP: 0018:ffff88808ff0fd18 EFLAGS: 00010206
RAX: 00000000000825ee RBX: dffffc0000000000 RCX: ffffffff814411a8
RDX: 0000000000000000 RSI: ffffffff814411b6 RDI: ffff88807a8b7fb0
RBP: ffff88808ff0fd78 R08: ffff88809069e300 R09: fffffbfff1141219
R10: fffffbfff1141218 R11: ffffffff88a090c3 R12: 0000000000412f61
R13: ffff88808fe32d80 R14: 0000000000000000 R15: ffff88809069e300
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000077fffb CR3: 00000000993de000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  exit_mm kernel/exit.c:546 [inline]
  do_exit+0x80e/0x2fa0 kernel/exit.c:864
  do_group_exit+0x135/0x370 kernel/exit.c:981
  __do_sys_exit_group kernel/exit.c:992 [inline]
  __se_sys_exit_group kernel/exit.c:990 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:990
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459279
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc3b89b6a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 0000000000459279
RDX: 0000000000412f61 RSI: fffffffffffffff7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffff R09: 00007ffc3b89b700
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc3b89b700 R14: 0000000000000000 R15: 00007ffc3b89b710
Modules linked in:

======================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
