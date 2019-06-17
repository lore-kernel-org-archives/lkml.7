Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A1C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF6B2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfFQQ3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:29:10 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:39977 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQQ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:29:10 -0400
Received: by mail-io1-f69.google.com with SMTP id v11so12681288iop.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 09:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=muFNrLl9l1iPQfQXFbXcYvX7CR04g6PUu08tnHTmkks=;
        b=Tz8AHqBkdQoBjNYV0KQqJ+oVfptX+YD++/mzdnfcsYKmvf5XFmqMvSKBtzkmZpuXss
         Kw9ldpCnA7wVyT/cK2UJ0NeIL/RFVa5IkrIL94xYvN2XagNYAP7orhWRZGXQSUgxuw8X
         qRgwEGzGdydfXuHatnXhoMCJ8eLjcd3U9AsiCFMWDXPnaH2COEy4k/EMLEvuGBqllm7c
         DI2Ez0iB0a+twHDze06ZNeN0r+1aOh16v3xBBvC7J8Yf0EpPhjvEOns4TAHYMY0m724Z
         yE8os1EPILjpsPn7vGucITUpZYazrFQ5kUkUg93m8V0qmnw23ORmqhV4F03kGE8xvTf3
         PmZQ==
X-Gm-Message-State: APjAAAUfEGgLpm4QGtLCeB0OemYjObjPyum+oZg0itWhsnb4sS4TCp25
        XQDIiX4YU35xO8Lvz+ZZx2Crvs3AW8hFq4b+JzfhY+50REsj
X-Google-Smtp-Source: APXvYqybC408vLpW4F3WQROPJIi8HkQJk4Ph1pW7orLBe75tRfNpyj/uHM3axyZfY4t8KK1fKeflzfapv0NwIenrpxWV+wVbWGwL
MIME-Version: 1.0
X-Received: by 2002:a5e:aa15:: with SMTP id s21mr2677859ioe.221.1560788949822;
 Mon, 17 Jun 2019 09:29:09 -0700 (PDT)
Date:   Mon, 17 Jun 2019 09:29:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec7273058b877e1f@google.com>
Subject: BUG: MAX_LOCKDEP_ENTRIES too low!
From:   syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f4788d37 Add linux-next specific files for 20190614
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f2e3f1a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=daee2e11d008b604
dashboard link: https://syzkaller.appspot.com/bug?extid=cd0ec5211ac07c18c049
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_ENTRIES too low!
turning off the locking correctness validator.
CPU: 0 PID: 25825 Comm: syz-executor.4 Not tainted 5.2.0-rc4-next-20190614  
#15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  alloc_list_entry kernel/locking/lockdep.c:1219 [inline]
  add_lock_to_list.isra.0.cold+0x11/0x18 kernel/locking/lockdep.c:1240
  check_prev_add kernel/locking/lockdep.c:2449 [inline]
  check_prevs_add kernel/locking/lockdep.c:2502 [inline]
  validate_chain kernel/locking/lockdep.c:2892 [inline]
  __lock_acquire+0x2cb2/0x4af0 kernel/locking/lockdep.c:3885
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4418
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
  vprintk_emit+0x115/0x700 kernel/printk/printk.c:1966
  vprintk_default+0x28/0x30 kernel/printk/printk.c:2013
  vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:386
  printk+0xba/0xed kernel/printk/printk.c:2046
  _udf_err+0xdc/0x110 fs/udf/super.c:2286
  udf_read_tagged+0x49c/0x530 fs/udf/misc.c:212
  udf_check_anchor_block+0x1ef/0x680 fs/udf/super.c:1785
  udf_scan_anchors+0x1cf/0x680 fs/udf/super.c:1825
  udf_find_anchor fs/udf/super.c:1882 [inline]
  udf_load_vrs+0x67f/0xc80 fs/udf/super.c:1947
  udf_fill_super+0x7d8/0x16d1 fs/udf/super.c:2140
  mount_bdev+0x304/0x3c0 fs/super.c:1346
  udf_mount+0x35/0x40 fs/udf/super.c:131
  legacy_get_tree+0x108/0x220 fs/fs_context.c:661
  vfs_get_tree+0x8e/0x390 fs/super.c:1476
  do_new_mount fs/namespace.c:2790 [inline]
  do_mount+0x138c/0x1c00 fs/namespace.c:3110
  ksys_mount+0xdb/0x150 fs/namespace.c:3319
  __do_sys_mount fs/namespace.c:3333 [inline]
  __se_sys_mount fs/namespace.c:3330 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3330
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4592c9
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb3d01d1c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00000000004592c9
RDX: 0000000020000140 RSI: 0000000020000180 RDI: 00000000200000c0
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb3d01d26d4
R13: 00000000004c570b R14: 00000000004d9aa0 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
