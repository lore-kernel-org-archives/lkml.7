Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB58BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8722C20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgAHOhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:37:11 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38828 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAHOhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:37:11 -0500
Received: by mail-il1-f197.google.com with SMTP id i67so2242860ilf.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=slkdBcCrCKrQOIz+gSLsDffMFWU+ouPRazk5TC/rW3I=;
        b=MGbcsLT3nUUvUKnnEO2IoMXFdPVHi+MNdewTgufL5xkwSpypL4AIfK72IispMTXeh0
         lgYIipFuXMZq7UpX/M6of9LUGxbB2rgblm436MeV94YA3Cg9nnO6fq484NMghwUnBmKR
         2l7HIlCfEcppVNlHvfiBUS6KhpY7fL4G+UExYYsV7dc28iJsL+DvuIErdCq5Ja5nZrBF
         NjhlMLVVvEnnQoA2JqLmAlnaqDfIOHlMCKEdU1t8a9YLWgCsg59dr7ISEQB/FLovKAuv
         XcvNEfTHW/XBmC2DFYBNAy+wo3+o7ICACiccDj5IT/2ru9gcxOmv44/yqvClFKW2wT/r
         9TLw==
X-Gm-Message-State: APjAAAXp22cdZtSnh8IW2o5pwI/B4yfNlR2IRQwf5PHtMG2Qf7C9paI2
        Cmg5JcEUpjwfAk6Z1n4Z9zl/OA50Gwf1kSYiwgSWg8lBactC
X-Google-Smtp-Source: APXvYqw+arUA+BcEOZ2DGy5gyhbvT3wEzIO1b5mv+h1rJDZOSMuMDAc+znhnPUcaS2eyitg8A6tJUzWevq8WHrIR/GSL1jFWZlaD
MIME-Version: 1.0
X-Received: by 2002:a6b:740c:: with SMTP id s12mr3723013iog.108.1578494230548;
 Wed, 08 Jan 2020 06:37:10 -0800 (PST)
Date:   Wed, 08 Jan 2020 06:37:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e45b52059ba1d3b9@google.com>
Subject: BUG: unable to handle kernel paging request in csi_J
From:   syzbot <syzbot+3f1750a5249afd5d7d2d@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ae608821 Merge tag 'trace-v5.5-rc5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c75ec6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18698c0c240ba616
dashboard link: https://syzkaller.appspot.com/bug?extid=3f1750a5249afd5d7d2d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3f1750a5249afd5d7d2d@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 000000010000000e
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 87451067 P4D 87451067 PUD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8720 Comm: syz-executor.3 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:csi_J+0x2bf/0xb00 drivers/tty/vt/vt.c:1529
Code: ff df 43 8d 4c 2d 00 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c  
01 0f 8e af 06 00 00 0f b7 83 c8 03 00 00 d1 e9 4c 89 e7 <f3> 66 ab 48 89  
df e8 46 f2 ff ff 31 ff 41 89 c6 89 c6 e8 5a ae 88
RSP: 0018:ffffc900050c7860 EFLAGS: 00010202
RAX: 0000000000000e20 RBX: ffff8880a3160000 RCX: 0000000000000001
RDX: 1ffff1101462c079 RSI: ffffffff83ec7986 RDI: 000000010000000e
RBP: ffffc900050c78a0 R08: ffff888094aba440 R09: ffff888094abacd0
R10: fffffbfff14f70c0 R11: ffffffff8a7b8607 R12: 000000010000000e
R13: 7fffffff80000001 R14: 0000000000000011 R15: 0000000000000000
FS:  00007ff78cd6b700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 0000000059f28000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  do_con_trol+0x50cc/0x61b0 drivers/tty/vt/vt.c:2367
  do_con_write.part.0+0xfd9/0x1ef0 drivers/tty/vt/vt.c:2797
  do_con_write drivers/tty/vt/vt.c:2565 [inline]
  con_write+0x46/0xd0 drivers/tty/vt/vt.c:3135
  process_output_block drivers/tty/n_tty.c:595 [inline]
  n_tty_write+0x40e/0x1080 drivers/tty/n_tty.c:2333
  do_tty_write drivers/tty/tty_io.c:962 [inline]
  tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
  __vfs_write+0x8a/0x110 fs/read_write.c:494
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45af49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff78cd6ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045af49
RDX: 0000000000000078 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff78cd6b6d4
R13: 00000000004cce19 R14: 00000000004e81c0 R15: 00000000ffffffff
Modules linked in:
CR2: 000000010000000e
---[ end trace f0537194244cf2be ]---
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:csi_J+0x2bf/0xb00 drivers/tty/vt/vt.c:1529
Code: ff df 43 8d 4c 2d 00 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c  
01 0f 8e af 06 00 00 0f b7 83 c8 03 00 00 d1 e9 4c 89 e7 <f3> 66 ab 48 89  
df e8 46 f2 ff ff 31 ff 41 89 c6 89 c6 e8 5a ae 88
RSP: 0018:ffffc900050c7860 EFLAGS: 00010202
RAX: 0000000000000e20 RBX: ffff8880a3160000 RCX: 0000000000000001
RDX: 1ffff1101462c079 RSI: ffffffff83ec7986 RDI: 000000010000000e
RBP: ffffc900050c78a0 R08: ffff888094aba440 R09: ffff888094abacd0
R10: fffffbfff14f70c0 R11: ffffffff8a7b8607 R12: 000000010000000e
R13: 7fffffff80000001 R14: 0000000000000011 R15: 0000000000000000
FS:  00007ff78cd6b700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 0000000059f28000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
