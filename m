Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256B0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000C22077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLJUZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:25:13 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:50215 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfLJUZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:25:10 -0500
Received: by mail-io1-f69.google.com with SMTP id e13so5690441iob.17
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IBtinwMCRMWLO1FGG87GH33R7/HTzSA1E26knQt0doY=;
        b=DlZP9lMyvPGK8VuS+eqZ9MtNVqFDsOfryDnnzUNBViQg51/40jNhUrL9HvUB83hfhG
         RDwE+qmnL9yAXZYRdws3BrxbzQ2uONae/3zB/g+i/+0AVYWA8RQ06y0WdC9ICyzMRqrD
         97fPH9bnRs2Rop2hyf1UpBv0uty1+soKbv5aJ7B1s+mh/AxvWumOmfCCVAucBxlbaZSi
         3Go8fidxTDrRyiBUkaaBckbRhrnpeiCymuAfJET3U0vVPgoC8kxB4jXipTth0/wdIuf8
         cbHzZHnUwIV6OZqV450Qe8ABYbfEhAKxXgcTTkDCrTjHSXwi/u1Hz6CeQSBSD8IZStmR
         nSkQ==
X-Gm-Message-State: APjAAAUkj6QntR0rEK5QbfE0rxzqU4h8WfeWNknjK4eX+TCqNFXIWXMK
        bkeQr4+aHFZFe70vuejjb3vnUYk+Hh8AcY6D2dK6S60fFUe5
X-Google-Smtp-Source: APXvYqyzamLGmwMNg8Ei/LfCVUrfm7ezUDQQ7Tr14xk/byEnpsxmwIa8xTvkyBl9GZd0pCSuX51XtU0kz8ow3ieCCRvyJRnBj3kn
MIME-Version: 1.0
X-Received: by 2002:a02:cd0d:: with SMTP id g13mr2258513jaq.110.1576009509276;
 Tue, 10 Dec 2019 12:25:09 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6967505995f4e9d@google.com>
Subject: KASAN: wild-memory-access Read in insert_char
From:   syzbot <syzbot+ebd135f6bfef7f74a68c@syzkaller.appspotmail.com>
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

HEAD commit:    6794862a Merge tag 'for-5.5-rc1-kconfig-tag' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158cd061e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=ebd135f6bfef7f74a68c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144d1282e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141a5db1e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ebd135f6bfef7f74a68c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: wild-memory-access in memmove include/linux/string.h:395  
[inline]
BUG: KASAN: wild-memory-access in scr_memmovew include/linux/vt_buffer.h:68  
[inline]
BUG: KASAN: wild-memory-access in insert_char+0x206/0x400  
drivers/tty/vt/vt.c:839
Read of size 212 at addr 00000000ffffff3a by task syz-executor266/8995

CPU: 1 PID: 8995 Comm: syz-executor266 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  __kasan_report.cold+0x5/0x41 mm/kasan/report.c:510
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memmove+0x24/0x50 mm/kasan/common.c:116
  memmove include/linux/string.h:395 [inline]
  scr_memmovew include/linux/vt_buffer.h:68 [inline]
  insert_char+0x206/0x400 drivers/tty/vt/vt.c:839
  csi_at drivers/tty/vt/vt.c:1964 [inline]
  do_con_trol+0x41a6/0x61b0 drivers/tty/vt/vt.c:2431
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
  __ia32_sys_write+0x71/0xb0 fs/read_write.c:620
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fc6a39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffdae18c EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000000
RDX: 0000000000000078 RSI: 00000000080eb080 RDI: 00000000ffdae1e0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
