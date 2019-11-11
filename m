Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D4AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F1720656
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKKQiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:38:10 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:39099 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfKKQiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:38:10 -0500
Received: by mail-io1-f70.google.com with SMTP id e17so12647755ioc.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 08:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6xGIatM585+y9way6GTbuYnN+gi1LVULfVZFLKPdCMk=;
        b=qDoiSRCx+Tsyf83WbD0hRAHBCZkRq1YgtRBUaV+xl72XkKoGcT7N4CwfTxRbqB1+ZX
         DwJcUF3hyiWqiWeoriHCUrAbt8dt0aNb0HRtNs6L4dR5pOeV9QnrtIl7T+rzy1cMXYo7
         yEuuZukcgjQ5PVO/ag+Sw+co2TVJtvHPuW3/ldmU/3w3TiLMUvNGMOGl4aS/FBQ84EJa
         GJgxeo3g4tSbe9c5MxkkXE7mKS+Z+D/aXeRoZpgDlmLRvpRrQ2DAEr4NpsKGyCXrU8HH
         YM3oZmjuFOHM3L2BtE449+z1t+uGEY5q2h7Lnrff6AU7VMiCyGg4MtvRkM2HF/pCILBT
         QARQ==
X-Gm-Message-State: APjAAAX18zXvf+u+CP3o4Wz0IKluZe3nOK7XLD0zUu7xkTrRJODHV+Tp
        I8oWDvk0Gnf1r/drxoTOB/e0LnDVsFSf7tKeemeaCMyWK0YM
X-Google-Smtp-Source: APXvYqwj3RfA6oWKkf3zkjMvjEH+2ejXtOS+uLLggxzGC3VSsnFcY4rnii9jzCwFxO17UiKd1S24dzl31MJTxNjjX2PoUtK3lsPx
MIME-Version: 1.0
X-Received: by 2002:a5e:a501:: with SMTP id 1mr10332198iog.211.1573490289053;
 Mon, 11 Nov 2019 08:38:09 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:38:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc9d78059714c1ac@google.com>
Subject: KASAN: use-after-free Read in snd_timer_close_locked
From:   syzbot <syzbot+4a89123a06517944d4c1@syzkaller.appspotmail.com>
To:     allison@lohutok.net, alsa-devel@alsa-project.org,
        enric.balletbo@collabora.com, gregkh@linuxfoundation.org,
        kirr@nexedi.com, linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        perex@perex.cz, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6980b7f6 Add linux-next specific files for 20191111
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16a82b9ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2af7db1972ec750e
dashboard link: https://syzkaller.appspot.com/bug?extid=4a89123a06517944d4c1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4a89123a06517944d4c1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in snd_timer_close_locked+0xb5f/0xbd0  
sound/core/timer.c:380
Read of size 8 at addr ffff8880a906be78 by task syz-executor.4/9580

CPU: 1 PID: 9580 Comm: syz-executor.4 Not tainted 5.4.0-rc6-next-20191111 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  snd_timer_close_locked+0xb5f/0xbd0 sound/core/timer.c:380
  snd_timer_close+0x88/0xf0 sound/core/timer.c:418
  snd_seq_timer_close+0x91/0xe0 sound/core/seq/seq_timer.c:318
  queue_delete+0x52/0xb0 sound/core/seq/seq_queue.c:134
  snd_seq_queue_delete+0x4e/0x70 sound/core/seq/seq_queue.c:196
  snd_seq_ioctl_delete_queue+0x6a/0x90 sound/core/seq/seq_clientmgr.c:1570
  snd_seq_kernel_client_ctl+0xf8/0x140 sound/core/seq/seq_clientmgr.c:2353
  delete_seq_queue.part.0+0xb6/0x120 sound/core/seq/oss/seq_oss_init.c:376
  delete_seq_queue sound/core/seq/oss/seq_oss_init.c:372 [inline]
  snd_seq_oss_release+0x116/0x150 sound/core/seq/oss/seq_oss_init.c:421
  odev_release+0x54/0x80 sound/core/seq/oss/seq_oss.c:140
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413db1
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fffcff8b860 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000413db1
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000001 R08: 00000000ca6eb3e2 R09: 00000000ca6eb3e6
R10: 00007fffcff8b940 R11: 0000000000000293 R12: 000000000075bf20
R13: 00000000000361f0 R14: 00000000007607e0 R15: 000000000075bf2c

Allocated by task 9581:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  snd_timer_instance_new+0x4a/0x300 sound/core/timer.c:96
  snd_timer_user_tselect sound/core/timer.c:1725 [inline]
  __snd_timer_user_ioctl.isra.0+0x665/0x2070 sound/core/timer.c:2008
  snd_timer_user_ioctl+0x7a/0xa7 sound/core/timer.c:2038
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9581:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  snd_timer_instance_free sound/core/timer.c:120 [inline]
  snd_timer_instance_free+0x7c/0xa0 sound/core/timer.c:114
  snd_timer_user_tselect sound/core/timer.c:1740 [inline]
  __snd_timer_user_ioctl.isra.0+0x160d/0x2070 sound/core/timer.c:2008
  snd_timer_user_ioctl+0x7a/0xa7 sound/core/timer.c:2038
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a906be00
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 120 bytes inside of
  256-byte region [ffff8880a906be00, ffff8880a906bf00)
The buggy address belongs to the page:
page:ffffea0002a41ac0 refcount:1 mapcount:0 mapping:ffff8880aa4008c0  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00025db908 ffff8880aa401648 ffff8880aa4008c0
raw: 0000000000000000 ffff8880a906b000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a906bd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a906bd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8880a906be00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                 ^
  ffff8880a906be80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a906bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
