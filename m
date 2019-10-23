Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E14EC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2282086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbfJWAPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:15:12 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40507 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732108AbfJWAPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:15:11 -0400
Received: by mail-io1-f70.google.com with SMTP id 125so6541952iou.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JH24AAtyajChpUja6+GJRkJf0NIvsivlD1pXa/ZEH7w=;
        b=sSIYpHt+3pzv5YBqRI0pT+niXuXvDV3Nk/PFs8pDsKGjV6+C9BR2MBaRCzOAPfckp9
         MLseRy21XRxI0Qr1XFfiLAws2Bh7wwzUCDS9FVLr8+O7Qq/x8b4qX6u5zvOLW1IoviAH
         ZcLUdu7WVXpWev3aa68Rqwc0CnFboSqNDsqFNBkuB0L6LMvtVpdurhC0hLkPd4bcBPhV
         kz2IWd6Af+dAwLMcAZ7J2VWewgXbv09i6pThumQ6Jt7Q7OoGbM0M8MiA0T6KoRnzcuSJ
         mmQFccKVMZKibaj2d8c9wEI5brRi65YkNdOFcXiS6qn72hts1u8+t37OLqwo2DzIFSKL
         Ud8A==
X-Gm-Message-State: APjAAAXTlMYsuAm7MmsMDTQJx3n6tuQtXWa5HcgO4QXSGgurkHwQd/YL
        3JqG2Vo9BLptjus+WYv/bNb8pw/GJbmZLsfnqPSjKiLED2o0
X-Google-Smtp-Source: APXvYqylg+sDJpklfUOgIokw07GcsikprsAIepACT+GRFsmzSdse0lHX0sld/zslY6B7QdMAe6b4OreGKbRBwflqDmydIHc8qPOK
MIME-Version: 1.0
X-Received: by 2002:a92:40d9:: with SMTP id d86mr34902794ill.303.1571789710775;
 Tue, 22 Oct 2019 17:15:10 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:15:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f6416059588cff9@google.com>
Subject: KASAN: slab-out-of-bounds Read in parse_term_proc_unit
From:   syzbot <syzbot+f586a582f79122007598@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, andreyknvl@google.com,
        benquike@gmail.com, dan.carpenter@oracle.com, g@b4.vu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tiwai@suse.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=141c4097600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
dashboard link: https://syzkaller.appspot.com/bug?extid=f586a582f79122007598
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169fe2df600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e2f3ef600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f586a582f79122007598@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
==================================================================
BUG: KASAN: slab-out-of-bounds in uac_processing_unit_iProcessing  
include/uapi/linux/usb/audio.h:429 [inline]
BUG: KASAN: slab-out-of-bounds in parse_term_proc_unit+0x57a/0x5e0  
sound/usb/mixer.c:896
Read of size 1 at addr ffff8881d48eeca9 by task kworker/1:2/83

CPU: 1 PID: 83 Comm: kworker/1:2 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
  kasan_report+0xe/0x20 mm/kasan/common.c:634
  uac_processing_unit_iProcessing include/uapi/linux/usb/audio.h:429 [inline]
  parse_term_proc_unit+0x57a/0x5e0 sound/usb/mixer.c:896
  __check_input_term+0xc32/0x13f0 sound/usb/mixer.c:984
  parse_audio_feature_unit sound/usb/mixer.c:1875 [inline]
  parse_audio_unit+0x101d/0x36f0 sound/usb/mixer.c:2753
  snd_usb_mixer_controls+0x715/0xb90 sound/usb/mixer.c:3095
  snd_usb_create_mixer+0x2b5/0x1890 sound/usb/mixer.c:3445
  usb_audio_probe+0xc76/0x2010 sound/usb/card.c:653
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5183 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5323 [inline]
  port_event drivers/usb/core/hub.c:5469 [inline]
  hub_event+0x1dd0/0x37e0 drivers/usb/core/hub.c:5551
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 83:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:483
  kmalloc include/linux/slab.h:561 [inline]
  usb_get_configuration+0x314/0x3050 drivers/usb/core/config.c:857
  usb_enumerate_device drivers/usb/core/hub.c:2369 [inline]
  usb_new_device+0xd3/0x160 drivers/usb/core/hub.c:2505
  hub_port_connect drivers/usb/core/hub.c:5183 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5323 [inline]
  port_event drivers/usb/core/hub.c:5469 [inline]
  hub_event+0x1dd0/0x37e0 drivers/usb/core/hub.c:5551
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 0:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:471
  slab_free_hook mm/slub.c:1424 [inline]
  slab_free_freelist_hook mm/slub.c:1475 [inline]
  slab_free mm/slub.c:3018 [inline]
  kfree+0xe4/0x320 mm/slub.c:3967
  free_task+0xe3/0x110 kernel/fork.c:472
  __put_task_struct+0x1e2/0x4c0 kernel/fork.c:748
  put_task_struct include/linux/sched/task.h:119 [inline]
  delayed_put_task_struct+0x1b4/0x2c0 kernel/exit.c:182
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2157 [inline]
  rcu_core+0x630/0x1ca0 kernel/rcu/tree.c:2377
  __do_softirq+0x221/0x912 kernel/softirq.c:292

The buggy address belongs to the object at ffff8881d48eec00
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 169 bytes inside of
  192-byte region [ffff8881d48eec00, ffff8881d48eecc0)
The buggy address belongs to the page:
page:ffffea0007523b80 refcount:1 mapcount:0 mapping:ffff8881da002a00  
index:0x0
flags: 0x200000000000200(slab)
raw: 0200000000000200 ffffea000753ce40 0000000e0000000e ffff8881da002a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d48eeb80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8881d48eec00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8881d48eec80: 00 00 00 00 03 fc fc fc fc fc fc fc fc fc fc fc
                                   ^
  ffff8881d48eed00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881d48eed80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
