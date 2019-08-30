Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AE9C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C048423430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfH3T2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:28:20 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35594 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbfH3T2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:28:09 -0400
Received: by mail-io1-f72.google.com with SMTP id 18so9749272iof.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aslq8WbI7sl258ogTqxoqYwMQreox4L8FhFx1BHXH+8=;
        b=fsyuLC4kpHBJgMGho80roGNhEUEwWNmp0ocjj8Hc/cFv8hQVTmR2ttOgRRU5IXvFRw
         HINUzKJayqQTU3Q+iv/GaAaotaVXm8PAV7BYipY5rqP7fYP6ZnfHfkM9L5xZPtCuYcd7
         NTQPi+112/TvLkKhoJlP4DzcWedMy2CAtL4Bu2yhyFuX8hocq82zqGAiFAormieNkQ8p
         DdiNqyk8JmYcQNU+7BqZajhxIaJSSRGqLDFptvgQ35rIk56aAYQn4q3QnXNISBABaAic
         yKvX2Gvo7eeqafJ+SzgxWtA8sgxE4aLEgcTVbHNY9wnjKsyYrxiDQCSD4MysNvvctRUj
         Jd4Q==
X-Gm-Message-State: APjAAAU2+Ay7mwU9MtMmI9nd1DH9Np9Nn/tbnex/rIw/ApDyRDfoVFdI
        ZsRK+PUhXJzkvH+EaCEchxlaQMDcNqFkfQ/nVCVapmAJgF6b
X-Google-Smtp-Source: APXvYqzN3n3JD6vBoBDCDagvbEYokl+smV3OkA9CBX+rF8MMuQmEQfrrxlNrCZwHz7QwotylScfq6aDW/cIf3W1Ym7nYHXRqKip5
MIME-Version: 1.0
X-Received: by 2002:a5d:8913:: with SMTP id b19mr14031111ion.83.1567193288766;
 Fri, 30 Aug 2019 12:28:08 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:28:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000457d1405915a9f19@google.com>
Subject: WARNING: suspicious RCU usage in ext4_release_system_zone
From:   syzbot <syzbot+5bda120b4032f831c57f@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ed858b88 Add linux-next specific files for 20190826
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=121b506c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee8373cd9733e305
dashboard link: https://syzkaller.appspot.com/bug?extid=5bda120b4032f831c57f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5bda120b4032f831c57f@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.3.0-rc6-next-20190826 #73 Not tainted
-----------------------------
fs/ext4/block_validity.c:333 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor.4/8779:
  #0: ffff888091c4a518 (&type->s_umount_key#32){++++}, at: deactivate_super  
fs/super.c:363 [inline]
  #0: ffff888091c4a518 (&type->s_umount_key#32){++++}, at:  
deactivate_super+0x1aa/0x1d0 fs/super.c:360

stack backtrace:
CPU: 0 PID: 8779 Comm: syz-executor.4 Not tainted 5.3.0-rc6-next-20190826  
#73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5438
  ext4_release_system_zone+0x166/0x1a0 fs/ext4/block_validity.c:333
  ext4_put_super+0x954/0xd70 fs/ext4/super.c:992
  generic_shutdown_super+0x14c/0x370 fs/super.c:460
  kill_block_super+0xa0/0x100 fs/super.c:1434
  deactivate_locked_super+0x95/0x100 fs/super.c:333
  deactivate_super fs/super.c:364 [inline]
  deactivate_super+0x1b2/0x1d0 fs/super.c:360
  cleanup_mnt+0x351/0x4c0 fs/namespace.c:1102
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1109
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c2a7
Code: 64 89 04 25 d0 02 00 00 58 5f ff d0 48 89 c7 e8 2f be ff ff 66 2e 0f  
1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 9d 8d fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffdccad768 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000045c2a7
RDX: 0000000000403520 RSI: 0000000000000002 RDI: 00007fffdccad810
RBP: 000000000000011b R08: 0000000000000000 R09: 000000000000000b
R10: 0000000000000005 R11: 0000000000000202 R12: 00007fffdccae8a0
R13: 00005555565a4940 R14: 0000000000000000 R15: 00007fffdccae8a0
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: percpu_counter hint: 0x0
WARNING: CPU: 1 PID: 8779 at lib/debugobjects.c:481  
debug_print_object+0x168/0x250 lib/debugobjects.c:481


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
