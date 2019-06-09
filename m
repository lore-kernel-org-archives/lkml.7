Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A272C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 07:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09942070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 07:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfFIHmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 03:42:07 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:60007 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfFIHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 03:42:07 -0400
Received: by mail-it1-f200.google.com with SMTP id u127so1204894ith.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 00:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zkrChJMHz/iadpuCPI3c7i7RrSxYQdDGlDejewpN83o=;
        b=houY+kzS8wFQkmy4waH3NWFZP2OL0jhLgin7bopPddyyaWGQnaI4dSGW2GZwufaH8c
         Yr3V2vESwqOf5CXwEw12UkKyhNGISPwrExti1vqkYU8i4TDDAzvxbKlUmeyyQGBYiG/w
         GoYCL95FchmqQGA6IUkBbhQ414o2nvh5Smdx+ZXKbrfVqBQ0XZJmu9dce5RFvsRZ89Nk
         BGPvcJPbaGfyRo8mbtSOc+xrp22daRaymZ/6Y7CrPSu3+Qc70jpAGgxeW0CGjs5BYQ4X
         STwLISb1oJYE+1zDf79APEEwqMsxLZgjKOjSO95uDRbwdZQWCfV5YX2gpbw1700DS/At
         ysvQ==
X-Gm-Message-State: APjAAAWxIoG72hwccymBK/OjNVH2ZGfAP/IPyrXAmcY7cTKbHJT6Zn4y
        z1gEq9WL4c/rGMkOACT+vWnnKvhWQMhZr7OiGZmAqptMkp4x
X-Google-Smtp-Source: APXvYqybvuuFVipRvLLTFhZ4lVOnX8mIiOO72N8I0DGALWju5p/V0DSN6tV85qPghVYeKr15jBdezTmL23ylTE3mpE/fO4Yqv1XR
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6a3:: with SMTP id d3mr14703485jad.33.1560066126075;
 Sun, 09 Jun 2019 00:42:06 -0700 (PDT)
Date:   Sun, 09 Jun 2019 00:42:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000456245058adf33a4@google.com>
Subject: BUG: Dentry still in use [unmount of tmpfs tmpfs]
From:   syzbot <syzbot+7008b8b8ba7df475fdc8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    79c3ba32 Merge tag 'drm-fixes-2019-06-07-1' of git://anong..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16eacf36a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=7008b8b8ba7df475fdc8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7008b8b8ba7df475fdc8@syzkaller.appspotmail.com

BUG: Dentry 00000000c5e232d4{i=15d04,n=/}  still in use (2) [unmount of  
tmpfs tmpfs]
WARNING: CPU: 0 PID: 22126 at fs/dcache.c:1529 umount_check  
fs/dcache.c:1520 [inline]
WARNING: CPU: 0 PID: 22126 at fs/dcache.c:1529 umount_check.cold+0xe9/0x10a  
fs/dcache.c:1510
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 22126 Comm: syz-executor.5 Not tainted 5.2.0-rc3+ #16
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
RIP: 0010:umount_check fs/dcache.c:1529 [inline]
RIP: 0010:umount_check.cold+0xe9/0x10a fs/dcache.c:1510
Code: 89 ff e8 50 62 f0 ff 48 81 c3 68 06 00 00 45 89 e8 4c 89 e1 53 4d 8b  
0f 4c 89 f2 4c 89 e6 48 c7 c7 c0 ff 75 87 e8 31 d4 a1 ff <0f> 0b 58 e9 bd  
2a ff ff e8 20 62 f0 ff e9 29 ff ff ff 45 31 f6 e9
RSP: 0018:ffff8880659d7bf8 EFLAGS: 00010286
RAX: 0000000000000054 RBX: ffff8880934748a8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ac976 RDI: ffffed100cb3af71
RBP: ffff8880659d7c28 R08: 0000000000000054 R09: ffffed1015d06011
R10: ffffed1015d06010 R11: ffff8880ae830087 R12: ffff88808fa10840
R13: 0000000000000002 R14: 0000000000015d04 R15: ffffffff88c21260
  d_walk+0x194/0x950 fs/dcache.c:1264
  do_one_tree+0x28/0x40 fs/dcache.c:1536
  shrink_dcache_for_umount+0x72/0x170 fs/dcache.c:1552
  generic_shutdown_super+0x6d/0x370 fs/super.c:443
  kill_anon_super+0x3e/0x60 fs/super.c:1137
  kill_litter_super+0x50/0x60 fs/super.c:1146
  deactivate_locked_super+0x95/0x100 fs/super.c:331
  deactivate_super fs/super.c:362 [inline]
  deactivate_super+0x1b2/0x1d0 fs/super.c:358
  cleanup_mnt+0xbf/0x160 fs/namespace.c:1120
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1127
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:185 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:168
  prepare_exit_to_usermode arch/x86/entry/common.c:199 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
  do_syscall_64+0x58e/0x680 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x412f61
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff7b2152c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000412f61
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000001 R08: 00000000ea5b01f8 R09: ffffffffffffffff
R10: 00007fff7b2153a0 R11: 0000000000000293 R12: 0000000000760d58
R13: 0000000000077aaa R14: 0000000000077ad7 R15: 000000000075bf2c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
