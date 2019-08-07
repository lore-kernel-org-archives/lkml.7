Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCAAC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E341E21E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbfHGN4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:56:02 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72]:50330 "EHLO
        mail-ot1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbfHGN4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:56:01 -0400
Received: by mail-ot1-f72.google.com with SMTP id a21so54933554otk.17
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Bk+2r34Stl2rUBhRx5Gcygsy2Z7wB8nfPpt4MphB9xU=;
        b=eFHOe2DuPQyMoGO2r0wihGmy5LvXd1COkoXfiIk78NxMxyciQ1XLge2ZCk2IDUepxt
         pZcjEy2x5ow8qne5uRI3MXyKW25VH5RVvgUlQwJY7ZAbwq1K+5wWdxRVCCaDna9tKvYb
         m7cuS/hvygm5ioAusmeOtdmtwoYqNUpsghZN65dHPfLmQTThE/DoIlSK8rYqh47YWj4s
         7zDPN0P0HDArHjiJQ9kvEQPNmMyZMhBgKUw8k0uWqFuOfxElsm1l+rMKxwOs27I8RpP/
         kfoRnlf3U0EjYbieJxxWE5ZxXtd+/jjULhKnWk6vVJIr6R8ZhKxp97XGdsajPUkz/ofs
         KNyQ==
X-Gm-Message-State: APjAAAVx/CSdowMW0wTJ3Q5etrRgHXN5a1XlDNpHaUSdiQDL6gFyvjn4
        qf925K5ZRFtqSDixQMKR9LJbO4Aph5PYCR5KtBFfIM8JlXow
X-Google-Smtp-Source: APXvYqz9nLua2ezFhBEBS/7mQaa0WuGqbxesIHCg0yzqzhVCeqS0n/CSMvTS+LmlmuK/6ZRJZNEbJm6WQPnpQIDiuEk1W+eOhdu0
MIME-Version: 1.0
X-Received: by 2002:a6b:3b03:: with SMTP id i3mr9381073ioa.302.1565186160323;
 Wed, 07 Aug 2019 06:56:00 -0700 (PDT)
Date:   Wed, 07 Aug 2019 06:56:00 -0700
In-Reply-To: <CAAeHK+zDVmxgjkZ6dR-sk1=99-Aj=Z4wwxaRCaOXeuYYG3-bUw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017f30b058f874dc2@google.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
From:   syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
KASAN: use-after-free Read in device_release_driver_internal

usb 4-1: USB disconnect, device number 2
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3a5d/0x5340  
kernel/locking/lockdep.c:3665
Read of size 8 at addr ffff8881d4a54510 by task kworker/0:3/2876

CPU: 0 PID: 2876 Comm: kworker/0:3 Not tainted 5.2.0-rc6+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x67/0x231 mm/kasan/report.c:188
  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:317
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  __lock_acquire+0x3a5d/0x5340 kernel/locking/lockdep.c:3665
  lock_acquire+0x100/0x2b0 kernel/locking/lockdep.c:4303
  __mutex_lock_common kernel/locking/mutex.c:926 [inline]
  __mutex_lock+0xf9/0x12b0 kernel/locking/mutex.c:1073
  device_release_driver_internal+0x23/0x4c0 drivers/base/dd.c:1109
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
  device_del+0x460/0xb80 drivers/base/core.c:2274
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x830 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:4949 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x13bd/0x3550 drivers/usb/core/hub.c:5441
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 22:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:462
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  usb_set_configuration+0x2c4/0x1670 drivers/usb/core/message.c:1846
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_new_device.cold+0x6a4/0xe61 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1abd/0x3550 drivers/usb/core/hub.c:5441
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 2876:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:451
  slab_free_hook mm/slub.c:1421 [inline]
  slab_free_freelist_hook mm/slub.c:1448 [inline]
  slab_free mm/slub.c:2994 [inline]
  kfree+0xd7/0x280 mm/slub.c:3949
  device_release+0x71/0x200 drivers/base/core.c:1064
  kobject_cleanup lib/kobject.c:691 [inline]
  kobject_release lib/kobject.c:720 [inline]
  kref_put include/linux/kref.h:65 [inline]
  kobject_put+0x171/0x280 lib/kobject.c:737
  put_device+0x1b/0x30 drivers/base/core.c:2210
  klist_put+0xce/0x170 lib/klist.c:221
  bus_remove_device+0x3a4/0x4a0 drivers/base/bus.c:552
  device_del+0x460/0xb80 drivers/base/core.c:2274
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x830 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:4949 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x13bd/0x3550 drivers/usb/core/hub.c:5441
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881d4a54400
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 272 bytes inside of
  2048-byte region [ffff8881d4a54400, ffff8881d4a54c00)
The buggy address belongs to the page:
page:ffffea0007529400 refcount:1 mapcount:0 mapping:ffff8881dac02800  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 ffffea000753da00 0000000500000005 ffff8881dac02800
raw: 0000000000000000 00000000000f000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d4a54400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d4a54480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881d4a54500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8881d4a54580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d4a54600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=132aca2c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

