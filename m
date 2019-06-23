Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B07C48BE4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DFA20820
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFWMvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:51:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47269 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFWMvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:51:06 -0400
Received: by mail-io1-f72.google.com with SMTP id r27so18184958iob.14
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 05:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kXaTpUMB141Sio/v1vYpi203tFotQH/1Wy9zkwXn66s=;
        b=Fb99xDeQHBjHFUySHhLB9GQDEstxzx8VHYDC4yshslSZkF7uBsQCMSm7xHlJT2bQTj
         +L22wK7cEpsqm0OgDlODCe4kIGIDhFAESBpIaMStDmKxdNvssConJXrV8X5S0pVDQbfo
         OUWXUK6JS0XJVRXn/4j+kltm4dwdSu4AafGKAAq8yMlLw8AY0O52qEHjUDI6PORQib1q
         y3/uzodDu5kYm+gFRqx+TMpzsD9b+HLZDqgcIWBsmcmZHwaeqLGp5VtftSfg+pUZSbcI
         SmUjxK/thZMURQSg2BOSsaKHwHXASz2QCAd2w4tNzR8MWJTu1tR3Yn2Cq+BALX4DjIvd
         KzkA==
X-Gm-Message-State: APjAAAUcW5lejaUXKpTOi3f59ReU+6rCSWKY876LJNYPpHzOw/qvom4a
        e9g2cWMmpacPCT2g3VWam+HZkPU6irGcRlQ5krwU4c8iqP86
X-Google-Smtp-Source: APXvYqzcFA+EMFZhoK5ooQwachkSlc25xxKAQ9TDLwSYySrT2apNKBVdu5TzHbNy0NWZzRwZUBBo1Dm6J+Vy9B4JPNJQ88jGhvuG
MIME-Version: 1.0
X-Received: by 2002:a02:c6b8:: with SMTP id o24mr78442599jan.80.1561294265890;
 Sun, 23 Jun 2019 05:51:05 -0700 (PDT)
Date:   Sun, 23 Jun 2019 05:51:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bbe63058bfd26d9@google.com>
Subject: WARNING in kernfs_remove_by_name_ns
From:   syzbot <syzbot+b76f1b62f3f98711bd93@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a6c806a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
dashboard link: https://syzkaller.appspot.com/bug?extid=b76f1b62f3f98711bd93
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b76f1b62f3f98711bd93@syzkaller.appspotmail.com

------------[ cut here ]------------
kernfs: can not remove 'nr_tags', no directory
WARNING: CPU: 0 PID: 19627 at fs/kernfs/dir.c:1503  
kernfs_remove_by_name_ns+0x9f/0xb0 fs/kernfs/dir.c:1503
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 19627 Comm: syz-executor.1 Not tainted 5.2.0-rc5+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x744 kernel/panic.c:219
  __warn.cold+0x20/0x4d kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:kernfs_remove_by_name_ns+0x9f/0xb0 fs/kernfs/dir.c:1503
Code: 99 ff 48 c7 c7 60 22 c9 88 41 bc fe ff ff ff e8 a7 c4 44 05 eb d7 e8  
f0 4e 99 ff 4c 89 ee 48 c7 c7 80 c8 78 87 e8 ff 87 6b ff <0f> 0b 41 bc fe  
ff ff ff eb b9 0f 1f 80 00 00 00 00 55 48 89 e5 41
RSP: 0018:ffff888058aaf798 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff88f18128 RCX: 0000000000000000
RDX: 000000000001e0a4 RSI: ffffffff815ad926 RDI: ffffed100b155ee5
RBP: ffff888058aaf7b0 R08: ffff88804eb8a240 R09: ffffed1015d060a1
R10: ffffed1015d060a0 R11: ffff8880ae830507 R12: 0000000000000000
R13: ffffffff87a35540 R14: 0000000000000000 R15: ffffffff87a35480
  kernfs_remove_by_name include/linux/kernfs.h:567 [inline]
  remove_files.isra.0+0x7b/0x190 fs/sysfs/group.c:27
  sysfs_remove_group+0xb6/0x1b0 fs/sysfs/group.c:264
  sysfs_remove_groups fs/sysfs/group.c:288 [inline]
  sysfs_remove_groups+0x61/0xb0 fs/sysfs/group.c:280
  kobject_del+0x9c/0x170 lib/kobject.c:619
  blk_mq_unregister_hctx.part.0+0x126/0x170 block/blk-mq-sysfs.c:243
  blk_mq_unregister_hctx block/blk-mq-sysfs.c:237 [inline]
  blk_mq_sysfs_unregister+0x16b/0x200 block/blk-mq-sysfs.c:373
  __blk_mq_update_nr_hw_queues block/blk-mq.c:3286 [inline]
  blk_mq_update_nr_hw_queues+0x4f9/0xd30 block/blk-mq.c:3321
  nbd_start_device+0x156/0xac0 drivers/block/nbd.c:1166
  nbd_start_device_ioctl drivers/block/nbd.c:1207 [inline]
  __nbd_ioctl drivers/block/nbd.c:1278 [inline]
  nbd_ioctl+0x53f/0xbd0 drivers/block/nbd.c:1318
  __blkdev_driver_ioctl block/ioctl.c:304 [inline]
  blkdev_ioctl+0xece/0x1c10 block/ioctl.c:606
  block_ioctl+0xee/0x130 fs/block_dev.c:1930
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd5f/0x1380 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4592c9
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9aba72cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00000000004592c9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9aba72d6d4
R13: 00000000004c2a81 R14: 00000000004d5b10 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
