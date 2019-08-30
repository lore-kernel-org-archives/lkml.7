Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CA7C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D703823430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfH3T2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:28:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47447 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3T2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:28:08 -0400
Received: by mail-io1-f70.google.com with SMTP id b22so9682916iod.14
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=p47YUPFSeld9b1Z1fm9Ospk7ZJwCpJKPzbtlk0MmrDU=;
        b=CF49pfeB4SHte2TLw8qTn/ztpCVk59h6imhJ6eF7keTC8GaHy5Yia56CXYT1d6KpT9
         GbG5iC5vneWFK0IxWLhSXRfi2AZvZsmIDwuNQPYYZLB7nohxxmtjb7CHObw/yQpDzqtQ
         Gk6ZHcJEG7Q+oqT0He30DPVKgdenw0vV2bze6g4+WTfeqUQ2s5rBUwgpDlfNfbNrRgiF
         4QUaId5PpXqEDzRDqCC18V6NmKH3YZ6/VvVugWPucKry3Qegvf8kIiiBLUdCaAOZSKh+
         F3OtQAjwHvzrOXYGnN+2YLAK7jvWc+Ljc0AemQNgh7PnqYRh59QH2l3nNHXXVlGdrDuv
         rRLw==
X-Gm-Message-State: APjAAAXvfcaN/P1O7KWMc/WV0olVglPVFxSE+UHE/QySgNck2KaiZhPn
        FL4/v3deAV9FhePpP2xb4674i36AZ7BJ+BrTukE2CK0LOHBT
X-Google-Smtp-Source: APXvYqxHQXcZy+X862EGgglzUrqPpcK4rpnEvQvwmWENnX4vDveFAAUnc/28TEBPj2NAu7p063c8yzbVIogXPtuhDSISIIXtQ81p
MIME-Version: 1.0
X-Received: by 2002:a5e:a811:: with SMTP id c17mr19081828ioa.122.1567193287781;
 Fri, 30 Aug 2019 12:28:07 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:28:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003675ae05915a9fd3@google.com>
Subject: WARNING in kfree
From:   syzbot <syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ed2393ca Add linux-next specific files for 20190827
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ed648e600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ef5940a07ed45f4
dashboard link: https://syzkaller.appspot.com/bug?extid=5aca688dac0796c56129
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1595ee12600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16df7fd2600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5aca688dac0796c56129@syzkaller.appspotmail.com

------------[ cut here ]------------
virt_to_cache: Object is not a Slab page!
WARNING: CPU: 0 PID: 8815 at mm/slab.h:473 virt_to_cache mm/slab.h:473  
[inline]
WARNING: CPU: 0 PID: 8815 at mm/slab.h:473 kfree+0x1d3/0x2c0 mm/slab.c:3748
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8815 Comm: syz-executor970 Not tainted 5.3.0-rc6-next-20190827  
#74
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:220
  __warn.cold+0x2f/0x3c kernel/panic.c:581
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:virt_to_cache mm/slab.h:473 [inline]
RIP: 0010:kfree+0x1d3/0x2c0 mm/slab.c:3748
Code: 53 ff e9 67 fe ff ff 80 3d 5d e4 14 08 00 75 1c 48 c7 c6 a0 6c b5 87  
48 c7 c7 d0 be a7 88 c6 05 46 e4 14 08 01 e8 d5 b8 96 ff <0f> 0b f6 c7 02  
75 6d 48 83 3d 2e 23 46 07 00 0f 85 4b ff ff ff 0f
RSP: 0018:ffff888089e978e8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000282 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815bd606 RDI: ffffed10113d2f0f
RBP: ffff888089e97908 R08: ffff8880a03e0680 R09: ffffed1015d04109
R10: ffffed1015d04108 R11: ffff8880ae820847 R12: ffffffff81756100
R13: ffffffff829d0110 R14: ffff8880aa0bae80 R15: ffff88821b827170
  debugfs_release_dentry+0x60/0x80 fs/debugfs/inode.c:194
  __dentry_kill+0x3f7/0x600 fs/dcache.c:584
  shrink_dentry_list+0x152/0x4a0 fs/dcache.c:1120
  shrink_dcache_parent+0x23d/0x400 fs/dcache.c:1547
  do_one_tree+0x16/0x40 fs/dcache.c:1601
  shrink_dcache_for_umount+0x72/0x170 fs/dcache.c:1618
  generic_shutdown_super+0x6d/0x370 fs/super.c:445
  kill_anon_super+0x3e/0x60 fs/super.c:1104
  kill_litter_super+0x50/0x60 fs/super.c:1113
  deactivate_locked_super+0x95/0x100 fs/super.c:333
  deactivate_super fs/super.c:364 [inline]
  deactivate_super+0x1b2/0x1d0 fs/super.c:360
  put_fs_context+0xae/0x5b0 fs/fs_context.c:499
  fscontext_release+0x51/0x70 fs/fsopen.c:73
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x904/0x2e60 kernel/exit.c:879
  do_group_exit+0x135/0x360 kernel/exit.c:983
  __do_sys_exit_group kernel/exit.c:994 [inline]
  __se_sys_exit_group kernel/exit.c:992 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:992
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43fde8
Code: Bad RIP value.
RSP: 002b:00007ffd9fbe5158 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043fde8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf670 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
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
