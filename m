Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EDE2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfCBHGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 02:06:06 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:50520 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCBHGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 02:06:06 -0500
Received: by mail-it1-f200.google.com with SMTP id i63so294743itb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 23:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GcOEXG3GmyuuYWL1612wKcGetlvIDeKp/oDsfhEz0NQ=;
        b=ATK7GC0ed0JlSl+Pony/Sa4xC9RADajezWJb7gJ2YNiQca+a98iWnf7EZU3+GXTEtn
         YPRlXFhtsvsTdZMOZNARXdyK7xCoqepYRVq+/bZyMvOGGftocOBiwqKV7eAUT3tIOPtL
         r4nFforx6Iz5vR03A1rJB5PF07kRnkEYSSXbL73pNMitwWuG/nZzVbiX3Gpx0EkzT3EV
         bPtS6YvTCMdAI4mkSVx2lSGB8DzVJNO6alGif4pcODhNl9JKPnNePyeq5fMyznF4F8On
         Y/QTu+FhD/1LnU6mKurozNJDD65baR6YqH5eEKhWdICxrB8UURIWMVzLdTh7wGpui7g9
         k2mA==
X-Gm-Message-State: APjAAAVWKBcE35cPK9r3HXk2dyg5jMlyNa955afbOsjCEckiO/D/UUT0
        TFwPr0d145V4xtYLwGJB+BEHV6K2k3ivKO3znpbkA1X/JIQr
X-Google-Smtp-Source: APXvYqxqcJRm3h6ZiUZEvRhiy/FQc9fqegAjRDdOaMy7LHnMQKPaiAq/uQLYooYP+Lg8oMkwZWiGG5P28XBXRVKJMhFm6w6mtXR+
MIME-Version: 1.0
X-Received: by 2002:a5d:8c97:: with SMTP id g23mr5237499ion.0.1551510364853;
 Fri, 01 Mar 2019 23:06:04 -0800 (PST)
Date:   Fri, 01 Mar 2019 23:06:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000299b190583172880@google.com>
Subject: BUG: MAX_STACK_TRACE_ENTRIES too low!
From:   syzbot <syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com>
To:     darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c63e9e91a254 Add linux-next specific files for 20190301
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16a559b2c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5875f9dc6e009b2
dashboard link: https://syzkaller.appspot.com/bug?extid=78923eea7cf44364f4fb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com

BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.
CPU: 0 PID: 19385 Comm: syz-executor.0 Not tainted 5.0.0-rc8-next-20190301  
#1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  save_trace kernel/locking/lockdep.c:467 [inline]
  save_trace.cold+0x14/0x19 kernel/locking/lockdep.c:437
  mark_lock+0x2fb/0x1380 kernel/locking/lockdep.c:3401
  __lock_acquire+0x548/0x3fb0 kernel/locking/lockdep.c:3648
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4202
  flush_workqueue+0x126/0x14c0 kernel/workqueue.c:2774
  drain_workqueue+0x1b4/0x470 kernel/workqueue.c:2939
  destroy_workqueue+0x21/0x700 kernel/workqueue.c:4315
  xfs_destroy_mount_workqueues+0x11d/0x1c0 fs/xfs/xfs_super.c:906
  xfs_fs_fill_super+0x8e9/0x1670 fs/xfs/xfs_super.c:1786
  mount_bdev+0x307/0x3c0 fs/super.c:1346
  xfs_fs_mount+0x35/0x40 fs/xfs/xfs_super.c:1834
  legacy_get_tree+0xf2/0x200 fs/fs_context.c:584
  vfs_get_tree+0x123/0x450 fs/super.c:1481
  do_new_mount fs/namespace.c:2622 [inline]
  do_mount+0x1436/0x2c40 fs/namespace.c:2942
  ksys_mount+0xdb/0x150 fs/namespace.c:3151
  __do_sys_mount fs/namespace.c:3165 [inline]
  __se_sys_mount fs/namespace.c:3162 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3162
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a89a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 2d 8e fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0a 8e fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f6d038b0a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6d038b0b30 RCX: 000000000045a89a
RDX: 00007f6d038b0ad0 RSI: 0000000020000140 RDI: 00007f6d038b0af0
RBP: 0000000020000140 R08: 00007f6d038b0b30 R09: 00007f6d038b0ad0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
R13: 0000000000000000 R14: 00000000004dbde0 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
