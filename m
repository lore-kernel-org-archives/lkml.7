Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5C4C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA50205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEBMgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:36:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33520 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfEBMgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:36:08 -0400
Received: by mail-io1-f69.google.com with SMTP id m10so1712323iop.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 05:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7nT4D0e3UpI9qdP6WAVUdUj+K3nk0KwZc+6JXS3hbQg=;
        b=OMyPT/B4F15BtDWmpJVTrytLamffKlo7yQ7/oJ6iK+uo8x65pHoF/LWhHg2m3cyl0X
         1gYYAPq8EnRpng8uOGpp2tbRcfRMLV4wchqazsl8zAb0hvYlJLvdNSU35qgCR//7u/SF
         uRHtFBstPPkYd/5yN+gvuXf+tgPB+x/BCFboz726FJIMQ5l7+d3i6JHqeiP4g96s1NKM
         UD0GBbggwFMJEhwnlVmPnTPl44/fHi6l+zMnheMma3K5wLOU5/nT0sKye6FWNqOAsyoh
         aSvjKaCknJxoLbEPHlKiotUmw4q1fKX/81rnEoJ6rt0DEPDkZQr/Jusgwa7iWrXfTSSv
         AxEg==
X-Gm-Message-State: APjAAAWEMhQejnkLlrGBzlSWfL6ddP1z4twNXyemkFFCNNW9G2VhVEry
        RHEILTJ7+FVswn21Fn2kphdwgvdT0L5VJa09yZ6cXAtUESVP
X-Google-Smtp-Source: APXvYqyIfvb4VfeFy5xxPv+5SBAn8L1z4mCTmgGgBNZ+S7z8FvgTQ+GWL/Ot5T4EyegWvUqHDMfF4ktHdIAIuJIONac264fDwvmg
MIME-Version: 1.0
X-Received: by 2002:a24:7f95:: with SMTP id r143mr2066649itc.120.1556800566493;
 Thu, 02 May 2019 05:36:06 -0700 (PDT)
Date:   Thu, 02 May 2019 05:36:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c08c230587e6e01e@google.com>
Subject: KASAN: use-after-free Read in v4l2_fh_del
From:   syzbot <syzbot+d53275bc1af5eb01bfff@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, hans.verkuil@cisco.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=145cd8ff200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
dashboard link: https://syzkaller.appspot.com/bug?extid=d53275bc1af5eb01bfff
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d53275bc1af5eb01bfff@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x2930/0x37c0  
kernel/locking/lockdep.c:3573
Read of size 8 at addr ffff88806b57ec90 by task v4l_id/7959

CPU: 0 PID: 7959 Comm: v4l_id Not tainted 5.1.0-rc3-319004-g43151d6 #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  __lock_acquire+0x2930/0x37c0 kernel/locking/lockdep.c:3573
  lock_acquire+0x10d/0x2f0 kernel/locking/lockdep.c:4211
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x44/0x60 kernel/locking/spinlock.c:152
  v4l2_fh_del+0x4e/0x270 drivers/media/v4l2-core/v4l2-fh.c:81
  v4l2_fh_release+0x46/0x70 drivers/media/v4l2-core/v4l2-fh.c:104
  v4l2_release+0x2f0/0x390 drivers/media/v4l2-core/v4l2-dev.c:459
  __fput+0x2df/0x8c0 fs/file_table.c:278
  task_work_run+0x149/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x243/0x270 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x40c/0x4f0 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fd157cde2b0
Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 32 08 00 e8 c0  
07 02 00 83 3d 45 a3 2b 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 ce 8a 01 00 48 89 04 24
RSP: 002b:00007ffcf08bde38 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007fd157cde2b0
RDX: 0000000000000013 RSI: 0000000080685600 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000400884
R13: 00007ffcf08bdf90 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 17:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
  slab_post_alloc_hook mm/slab.h:437 [inline]
  slab_alloc_node mm/slub.c:2756 [inline]
  __kmalloc_node_track_caller+0xf3/0x320 mm/slub.c:4372
  alloc_dr drivers/base/devres.c:103 [inline]
  devm_kmalloc+0x8c/0x190 drivers/base/devres.c:793
  devm_kzalloc include/linux/device.h:679 [inline]
  usb_raremono_probe+0x34/0x235 drivers/media/radio/radio-raremono.c:298
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2023
  generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
  usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 17:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x290 mm/slub.c:3958
  release_nodes+0x4ac/0x920 drivers/base/devres.c:508
  devres_release_all+0x79/0xc8 drivers/base/devres.c:529
  __device_release_driver drivers/base/dd.c:1086 [inline]
  device_release_driver_internal+0x23a/0x4f0 drivers/base/dd.c:1113
  bus_remove_device+0x302/0x5c0 drivers/base/bus.c:556
  device_del+0x467/0xb90 drivers/base/core.c:2269
  usb_disable_device+0x242/0x790 drivers/usb/core/message.c:1237
  usb_disconnect+0x298/0x870 drivers/usb/core/hub.c:2197
  hub_port_connect drivers/usb/core/hub.c:4940 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0xcd2/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88806b57e600
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1680 bytes inside of
  4096-byte region [ffff88806b57e600, ffff88806b57f600)
The buggy address belongs to the page:
page:ffffea0001ad5e00 count:1 mapcount:0 mapping:ffff88812c3f4600 index:0x0  
compound_mapcount: 0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 0000000000000000 0000000100000001 ffff88812c3f4600
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88806b57eb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88806b57ec00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88806b57ec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff88806b57ed00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88806b57ed80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
