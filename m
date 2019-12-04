Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5590C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4292084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfLDPZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:25:08 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:44421 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:25:08 -0500
Received: by mail-io1-f71.google.com with SMTP id t17so133474ioi.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=R41k+MjjXFhQCoZNnHjmE15JlRIjB+cesfAEejAJYG0=;
        b=Fv7j62W4KhFjd0RUJPj8rs9XB9veVCJFrzLSrJtDoCDq3pbB8EkFJhISWDD9aggjQT
         y2SbdKBV3DmGZS0u70aAl7U/VYqVNs/ZZnInx+YoZH8dFggUOxbsIUGKmmzHNRBOaVH3
         Yyk7015AaJKawcyLb1bl5cCjJJ7xLIollCYKDU2lQI4LXn2V9ylXrXd9y1L1qmwoU3y4
         Zgt9H98CBWdH61nr+xM3EEZFS0TfM+VkW/ZAHvVC/F+ZyIS5sgOPtLWVnnUIiSMIL0Xl
         kTl2m62MUXCxPFeFd8tMOWALgjWfJqakF/rTieE6zc+6N6ihxAM5sHg5A8c1r+v7jLTb
         grsA==
X-Gm-Message-State: APjAAAUe6o5eHXBijnF2n/0RGW+lJZJJXIQAoC/D/Mv778f4DikJf3Zz
        7HdlZdkTLIrTd5ISuolcWrjZs2y6A6OwGhqfx4QDSvurAIZA
X-Google-Smtp-Source: APXvYqxBQdZd91ZAyXu2/vwDmYInTYMBLA4Zz26THKFs4NA2w0d8nZYILnQT0sZ7piXAbm1N6WtFcfXlGIdxiljJBo1RkQZwRkvZ
MIME-Version: 1.0
X-Received: by 2002:a92:58ca:: with SMTP id z71mr3773652ilf.5.1575473107474;
 Wed, 04 Dec 2019 07:25:07 -0800 (PST)
Date:   Wed, 04 Dec 2019 07:25:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eca3eb0598e26a3d@google.com>
Subject: KMSAN: kernel-infoleak in vcs_read (2)
From:   syzbot <syzbot+31a641689d43387f05d3@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        jwilk@jwilk.net, linux-kernel@vger.kernel.org, nico@fluxnic.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    141b13f7 fixup "kmsan: ext4: skip block merging logic "
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1201f061e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fde150fb1e865232
dashboard link: https://syzkaller.appspot.com/bug?extid=31a641689d43387f05d3
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+31a641689d43387f05d3@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0xa9/0xb0  
mm/kmsan/kmsan_hooks.c:257
CPU: 0 PID: 18848 Comm: syz-executor.5 Not tainted 5.4.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x220 lib/dump_stack.c:118
  kmsan_report+0x128/0x220 mm/kmsan/kmsan_report.c:108
  kmsan_internal_check_memory+0x215/0x440 mm/kmsan/kmsan.c:455
  kmsan_copy_to_user+0xa9/0xb0 mm/kmsan/kmsan_hooks.c:257
  _copy_to_user+0x16b/0x1f0 lib/usercopy.c:33
  copy_to_user include/linux/uaccess.h:174 [inline]
  vcs_read+0x1edb/0x22e0 drivers/tty/vt/vc_screen.c:424
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_iter_read+0x8e0/0xe10 fs/read_write.c:935
  vfs_readv fs/read_write.c:997 [inline]
  do_readv+0x37f/0x710 fs/read_write.c:1034
  __do_sys_readv fs/read_write.c:1125 [inline]
  __se_sys_readv+0x9b/0xb0 fs/read_write.c:1122
  __x64_sys_readv+0x4a/0x70 fs/read_write.c:1122
  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45a679
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbb48b2cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 0000000000000002 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbb48b2d6d4
R13: 00000000004c89bc R14: 00000000004e0408 R15: 00000000ffffffff

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:149 [inline]
  kmsan_internal_chain_origin+0xb9/0x170 mm/kmsan/kmsan.c:317
  kmsan_memcpy_memmove_metadata+0x25c/0x2e0 mm/kmsan/kmsan.c:252
  kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:272
  __msan_memcpy+0x56/0x70 mm/kmsan/kmsan_instr.c:129
  vc_uniscr_copy_line+0x4ce/0x750 drivers/tty/vt/vt.c:566
  vcs_read+0xd37/0x22e0 drivers/tty/vt/vc_screen.c:332
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_iter_read+0x8e0/0xe10 fs/read_write.c:935
  vfs_readv fs/read_write.c:997 [inline]
  do_readv+0x37f/0x710 fs/read_write.c:1034
  __do_sys_readv fs/read_write.c:1125 [inline]
  __se_sys_readv+0x9b/0xb0 fs/read_write.c:1122
  __x64_sys_readv+0x4a/0x70 fs/read_write.c:1122
  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:149 [inline]
  kmsan_internal_poison_shadow+0x5c/0x110 mm/kmsan/kmsan.c:132
  kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:86
  slab_alloc_node mm/slub.c:2773 [inline]
  slab_alloc mm/slub.c:2782 [inline]
  __kmalloc+0x28b/0x410 mm/slub.c:3815
  kmalloc include/linux/slab.h:561 [inline]
  vc_uniscr_alloc+0xa6/0x730 drivers/tty/vt/vt.c:353
  vc_do_resize+0x608/0x2b60 drivers/tty/vt/vt.c:1192
  vt_resize+0x10e/0x170 drivers/tty/vt/vt.c:1325
  tty_ioctl+0x2c39/0x3100 drivers/tty/tty_io.c:2503
  do_vfs_ioctl+0xea8/0x2c50 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:718
  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:718
  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Bytes 0-23 of 216 are uninitialized
Memory access of size 216 starts at ffff8d212e741000
Data copied to user address 0000000020000280
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
