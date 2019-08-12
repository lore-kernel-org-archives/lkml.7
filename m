Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DA020820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfHLMSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:18:23 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70]:34088 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfHLMSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:18:08 -0400
Received: by mail-ot1-f70.google.com with SMTP id a26so9903673otl.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aPp6ZgunP/Q/0ga2QgjyTpz76p9a/7J3yEd/nbSWCVI=;
        b=t/5mW37b4lXM+A4/aNxczzQI0XznZcWBAdxzFvbMPi79Ck1y4uU5+uh1kLlHruU3/7
         RYGvEj+2TPbv+QBn6veGgH6GBgQ/Q2UuS+a0N5/ne3+WUqmeI0FpX41IbnslFy2dA6ru
         kK/G1IsSaxl7LdEpnUKeRWC9T4mdh4H20UhjmYKMOgCLxy1HKYD9f4A9O69XdcxriTG+
         9WRTpaGXuBVRfqAtxW93uuc46CYMwrUAI5aOIr5lWRzIfE6g7OfqnSnyzp7J+MOMGLNy
         3jPxW0mrDnKTZVY9vWv/jDndr/sr9TEWmuepuHBh6RMzYWCeXFn2n1VDOGc4i3lJNm2T
         tV4g==
X-Gm-Message-State: APjAAAXmha+nWYXikZvD4HXHImGDkP3O/H+Ifs/6EltmGrmwzQtSPK5Q
        Kce+Xt4e7RBQ2LW15am6cpTrO9Rvy9/VfPesxg2dDC9Mv++j
X-Google-Smtp-Source: APXvYqz/Vcp+CzjWkVyVvjmoddOK6pfLDQjmq9Aq1ErzrGX5KpAiYAEejCsN1BMI9bqqcufy9idFVz1T07h3e+BpbyIOZ18lIdZP
MIME-Version: 1.0
X-Received: by 2002:a6b:ea12:: with SMTP id m18mr16480217ioc.173.1565612287707;
 Mon, 12 Aug 2019 05:18:07 -0700 (PDT)
Date:   Mon, 12 Aug 2019 05:18:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043d7e6058fea8482@google.com>
Subject: KASAN: slab-out-of-bounds Read in mceusb_dev_recv
From:   syzbot <syzbot+c7fdb6cb36e65f2fe8c9@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, as1033x@comcast.net, brad@nextdimension.cc,
        gregkh@linuxfoundation.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, rfontana@redhat.com,
        sean@mess.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=13e270e2600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=c7fdb6cb36e65f2fe8c9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b73802600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161b8cd2600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c7fdb6cb36e65f2fe8c9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in mceusb_handle_command  
drivers/media/rc/mceusb.c:1080 [inline]
BUG: KASAN: slab-out-of-bounds in mceusb_process_ir_data  
drivers/media/rc/mceusb.c:1171 [inline]
BUG: KASAN: slab-out-of-bounds in mceusb_dev_recv+0x1014/0x12e0  
drivers/media/rc/mceusb.c:1254
Read of size 1 at addr ffff8881d5357880 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.3.0-rc2+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  mceusb_handle_command drivers/media/rc/mceusb.c:1080 [inline]
  mceusb_process_ir_data drivers/media/rc/mceusb.c:1171 [inline]
  mceusb_dev_recv+0x1014/0x12e0 drivers/media/rc/mceusb.c:1254
  __usb_hcd_giveback_urb+0x1f2/0x470 drivers/usb/core/hcd.c:1757
  usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1822
  dummy_timer+0x120f/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1965
  call_timer_fn+0x179/0x650 kernel/time/timer.c:1322
  expire_timers kernel/time/timer.c:1366 [inline]
  __run_timers kernel/time/timer.c:1685 [inline]
  __run_timers kernel/time/timer.c:1653 [inline]
  run_timer_softirq+0x5cc/0x14b0 kernel/time/timer.c:1698
  __do_softirq+0x221/0x912 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x178/0x1a0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:537 [inline]
  smp_apic_timer_interrupt+0x12f/0x500 arch/x86/kernel/apic/apic.c:1095
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:828
  </IRQ>
RIP: 0010:default_idle+0x28/0x2e0 arch/x86/kernel/process.c:581
Code: 90 90 41 56 41 55 65 44 8b 2d 54 fa 93 7a 41 54 55 53 0f 1f 44 00 00  
e8 76 7f d5 fb e9 07 00 00 00 0f 00 2d 6a 9f 54 00 fb f4 <65> 44 8b 2d 30  
fa 93 7a 0f 1f 44 00 00 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffff8881da217dc8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: ffff8881da1fb000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8881da1fb844
RBP: ffffed103b43f600 R08: ffff8881da1fb000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x3c2/0x4f0 kernel/sched/idle.c:263
  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:354
  start_secondary+0x297/0x340 arch/x86/kernel/smpboot.c:264
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

Allocated by task 21:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:557 [inline]
  hcd_buffer_alloc+0x1ca/0x290 drivers/usb/core/buffer.c:135
  usb_alloc_coherent+0x5d/0x80 drivers/usb/core/usb.c:910
  mceusb_dev_probe+0x714/0x2f20 drivers/media/rc/mceusb.c:1576
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 1:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1470 [inline]
  slab_free mm/slub.c:3012 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3953
  akcipher_request_free include/crypto/akcipher.h:210 [inline]
  public_key_verify_signature+0x874/0xc40  
crypto/asymmetric_keys/public_key.c:314
  x509_check_for_self_signed+0x33c/0x560  
crypto/asymmetric_keys/x509_public_key.c:132
  x509_cert_parse+0x61e/0x8a0 crypto/asymmetric_keys/x509_cert_parser.c:135
  x509_key_preparse+0x61/0x8e0 crypto/asymmetric_keys/x509_public_key.c:165
  asymmetric_key_preparse+0xab/0x110  
crypto/asymmetric_keys/asymmetric_type.c:385
  key_create_or_update+0x32e/0xb30 security/keys/key.c:857
  load_keys_from_buffer net/wireless/reg.c:742 [inline]
  load_builtin_regdb_keys net/wireless/reg.c:780 [inline]
  regulatory_init_db+0x29b/0x45b net/wireless/reg.c:3916
  do_one_initcall+0xf0/0x614 init/main.c:939
  do_initcall_level init/main.c:1007 [inline]
  do_initcalls init/main.c:1015 [inline]
  do_basic_setup init/main.c:1032 [inline]
  kernel_init_freeable+0x4a9/0x596 init/main.c:1192
  kernel_init+0xd/0x1bf init/main.c:1110
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881d5357780
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 0 bytes to the right of
  256-byte region [ffff8881d5357780, ffff8881d5357880)
The buggy address belongs to the page:
page:ffffea000754d5c0 refcount:1 mapcount:0 mapping:ffff8881da002780  
index:0x0
flags: 0x200000000000200(slab)
raw: 0200000000000200 ffffea000754cac0 0000000500000005 ffff8881da002780
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d5357780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881d5357800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8881d5357880: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
                    ^
  ffff8881d5357900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881d5357980: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
