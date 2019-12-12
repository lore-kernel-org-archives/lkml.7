Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BFEC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E5F24656
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLLF7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 00:59:12 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:41007 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfLLF7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:59:12 -0500
Received: by mail-il1-f199.google.com with SMTP id k9so817208ili.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 21:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SAddbRUONJMCe4FmSemnYWwj6GKqzuKJtJFlr0+R5cM=;
        b=Hsm+4dXYe7AJ3L2HO4YAYXDzMhDyi8h2wxIML5ZZtvVL6EhIlcJPAwkob4AXi8yZRb
         HyrVmjd3cZ2oEwNMdWVSOPIixZHnIAgY9zkz2DbUm9B3E6VZLrj7nPgTiPgu6wt1xx/D
         OJUwFFV09kIipglLrWGYBX6KNWH9Ib9lht79KkpIz1Zh5Q3I+RqCavmfwN3S6jWxRVp2
         DjWsYU26z5ykAHJhyG5t+kHdo8wbvwssAsQKlahb4EnHtn5iMLmQKW//0Lj29fSH0Hqk
         q+biexOWt4RjZAc7qsfLBMjU/4/Nud44HkM9Yq3k6IQNsVkDVvhZbqIcZ1fso/YmriW2
         i8Yg==
X-Gm-Message-State: APjAAAW3cdlNjBZoLuRignAbXvYq81FeZI4LCBlhwxNzAeP8jAEbVvlL
        0h0jmrzvnDFhsedTyk6jE3wQvZYCa0OJpKZpeJWM8oAowOQe
X-Google-Smtp-Source: APXvYqwQjVx6p/vCsgwyARJ1rVdnsjH584aBPbg7GE8enoZAxCxDTlArD1St/KntTqNh7WqsngZLT3zveFiV27TOnIp7SdLkZ6YS
MIME-Version: 1.0
X-Received: by 2002:a5d:8a0f:: with SMTP id w15mr1260330iod.109.1576130351375;
 Wed, 11 Dec 2019 21:59:11 -0800 (PST)
Date:   Wed, 11 Dec 2019 21:59:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6b03205997b71cf@google.com>
Subject: BUG: corrupted list in __dentry_kill (2)
From:   syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    938f49c8 Add linux-next specific files for 20191211
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=150eba1ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96834c884ba7bb81
dashboard link: https://syzkaller.appspot.com/bug?extid=31043da7725b6ec210f1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dc83dae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ac8396e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffff88808fd17b10, but was  
ffff88808fd17590
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:51!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 393 Comm: kworker/u4:5 Not tainted  
5.5.0-rc1-next-20191211-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:__list_del_entry_valid.cold+0xf/0x4f lib/list_debug.c:51
Code: e8 c9 00 cb fd 0f 0b 48 89 f1 48 c7 c7 c0 10 70 88 4c 89 e6 e8 b5 00  
cb fd 0f 0b 4c 89 f6 48 c7 c7 60 12 70 88 e8 a4 00 cb fd <0f> 0b 4c 89 ea  
4c 89 f6 48 c7 c7 a0 11 70 88 e8 90 00 cb fd 0f 0b
RSP: 0018:ffffc90001617980 EFLAGS: 00010286
RAX: 0000000000000054 RBX: ffff8880a1ce8840 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815e8576 RDI: fffff520002c2f22
RBP: ffffc90001617998 R08: 0000000000000054 R09: ffffed1015d26621
R10: ffffed1015d26620 R11: ffff8880ae933107 R12: ffff8880a1ce8940
R13: ffff88808fd17590 R14: ffff88808fd17b10 R15: ffff88808fd17b10
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000008d040000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:131 [inline]
  dentry_unlist fs/dcache.c:522 [inline]
  __dentry_kill+0x1fd/0x600 fs/dcache.c:575
  dentry_kill fs/dcache.c:698 [inline]
  dput+0x62f/0xe10 fs/dcache.c:859
  simple_recursive_removal+0x5bc/0x6d0 fs/libfs.c:302
  debugfs_remove fs/debugfs/inode.c:713 [inline]
  debugfs_remove+0x5e/0x80 fs/debugfs/inode.c:707
  nsim_ipsec_teardown+0x7c/0x8f drivers/net/netdevsim/ipsec.c:298
  nsim_destroy+0x42/0x70 drivers/net/netdevsim/netdev.c:331
  __nsim_dev_port_del+0x150/0x1f0 drivers/net/netdevsim/dev.c:674
  nsim_dev_port_del_all+0x8b/0xe0 drivers/net/netdevsim/dev.c:687
  nsim_dev_reload_destroy+0x58/0xf0 drivers/net/netdevsim/dev.c:856
  nsim_dev_reload_down+0x73/0xe0 drivers/net/netdevsim/dev.c:493
  devlink_reload+0xc8/0x3c0 net/core/devlink.c:2797
  devlink_pernet_pre_exit+0x104/0x1a0 net/core/devlink.c:8260
  ops_pre_exit_list net/core/net_namespace.c:162 [inline]
  cleanup_net+0x49b/0xaf0 net/core/net_namespace.c:585
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 700329e407063cc0 ]---
RIP: 0010:__list_del_entry_valid.cold+0xf/0x4f lib/list_debug.c:51
Code: e8 c9 00 cb fd 0f 0b 48 89 f1 48 c7 c7 c0 10 70 88 4c 89 e6 e8 b5 00  
cb fd 0f 0b 4c 89 f6 48 c7 c7 60 12 70 88 e8 a4 00 cb fd <0f> 0b 4c 89 ea  
4c 89 f6 48 c7 c7 a0 11 70 88 e8 90 00 cb fd 0f 0b
RSP: 0018:ffffc90001617980 EFLAGS: 00010286
RAX: 0000000000000054 RBX: ffff8880a1ce8840 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815e8576 RDI: fffff520002c2f22
RBP: ffffc90001617998 R08: 0000000000000054 R09: ffffed1015d26621
R10: ffffed1015d26620 R11: ffff8880ae933107 R12: ffff8880a1ce8940
R13: ffff88808fd17590 R14: ffff88808fd17b10 R15: ffff88808fd17b10
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000008d040000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
