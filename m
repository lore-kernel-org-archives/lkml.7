Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD86208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfICMIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:08:44 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56017 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbfICMIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:08:12 -0400
Received: by mail-io1-f69.google.com with SMTP id i2so17120527iof.22
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 05:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TC3iHUTCSChpOO9kdTIrV60rE1zk74Z3qCyK3WcbrFo=;
        b=qkmlM5f7XfDMlMtaJS/C1kE8RrhJ1MixaD2gfpig/U95WYMHoVv5cD9xKixsWM7sti
         Xc+0O5B9YT+t5JAWBqeOmD4miW3OsyBIRS/6ptHQ5illJtG+LHSOjCi6cEAsL6AAsyZW
         LSsj0H5D2b9sSD+qO6Tsrgegp1UHTbmFwn5NHGa2KzmFI1q3uosAeS48cVlTYuSVZTPi
         bQ+Lsxl2Mufxswz0FNFrDmmXnk54FEr/8bD54vRjs/1usr0a1jSBftDqfwXQxwdEBunZ
         /+ZhutEyn4ujwcJll2yHJw2zHHrJA1FmgR+J7CD9aeoZsA3Q4LuJopNLLFSZtEqRWHXz
         gFvw==
X-Gm-Message-State: APjAAAXxzHDGNimbeZa5oDMrUmdOb5w3heff6XqeJ/QlhKWufVwI/j5g
        xC0fOudbuAo5Scn/Y1y/kZQhhwtVo8ZS3DBqbt2mTw6YiQDL
X-Google-Smtp-Source: APXvYqxp5hGtiwCZRsxNl3oATS0MGb9xC/IxFV4uCFj/jeSGy+LB434biLqFKaGtZL26dPKjHpSBfNjw3iXFe6UVrO6LLhms0lqn
MIME-Version: 1.0
X-Received: by 2002:a5e:9b12:: with SMTP id j18mr23942819iok.54.1567512491747;
 Tue, 03 Sep 2019 05:08:11 -0700 (PDT)
Date:   Tue, 03 Sep 2019 05:08:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004070630591a4f124@google.com>
Subject: KASAN: use-after-free Read in usbhid_close
From:   syzbot <syzbot+90b997df76897a013829@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=140a786c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=90b997df76897a013829
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+90b997df76897a013829@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x302a/0x3b50  
kernel/locking/lockdep.c:3753
Read of size 8 at addr ffff8881d34368a0 by task syz-executor.3/10760

CPU: 0 PID: 10760 Comm: syz-executor.3 Not tainted 5.3.0-rc5+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  __lock_acquire+0x302a/0x3b50 kernel/locking/lockdep.c:3753
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
  _raw_spin_lock_irq+0x2d/0x40 kernel/locking/spinlock.c:167
  spin_lock_irq include/linux/spinlock.h:363 [inline]
  usbhid_close+0x51/0x210 drivers/hid/usbhid/hid-core.c:740
  hid_hw_close+0xa8/0xd0 drivers/hid/hid-core.c:2046
  drop_ref.part.0+0x32/0xe0 drivers/hid/hidraw.c:337
  drop_ref drivers/hid/hidraw.c:360 [inline]
  hidraw_release+0x34f/0x440 drivers/hid/hidraw.c:356
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413561
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffc873b3300 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000413561
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000055395a94 R09: 0000000055395a98
R10: 00007ffc873b33e0 R11: 0000000000000293 R12: 000000000075bfc8
R13: 0000000000096f96 R14: 0000000000762460 R15: ffffffffffffffff

The buggy address belongs to the page:
page:ffffea00074d0d80 refcount:0 mapcount:0 mapping:0000000000000000  
index:0x0
flags: 0x200000000000000()
raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d3436780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8881d3436800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff8881d3436880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                ^
  ffff8881d3436900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff8881d3436980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
