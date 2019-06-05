Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C460BC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A785D2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfFEAMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 20:12:07 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:52481 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFEAMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 20:12:07 -0400
Received: by mail-it1-f200.google.com with SMTP id z128so488828itb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 17:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FGuzGX/odArR8Wasi2hmCQXeCrMlVsnJR2R5E+8BwFQ=;
        b=gznRPMuZ9vX9WxhNxOPkoyXJUU8IMJFiRO8+JN/06HBlPenil8azcroFls9YRwbmDb
         FdE8GeFX3M6FjYuDkIX/zD3e9k4nxEgh41vFvrkA9r82XRFk854+YN6uRCy2UPKr4IGK
         f3W+zLbj31qQOVXc4I5oQodVGl/FVoK/KRkyw1zFkb52YdPtCIlDO0AevTTVHpd0FDSg
         2AscSUpX2aczltwKmUna5IlQ/9Iac9qdsD1rYC1APcXCCSgoO9dfy3YBRUuEpanNfWp+
         qKa0iYFKYY/CI2VB1ZXNI4aREcrkU/2g4s5UAQ1wrVeFrurrAa1TQLKTPYAizra++H0A
         VOog==
X-Gm-Message-State: APjAAAVC/qw54WSIlrdCa5VFrNs2gfNI1BmZ6nBYXhXFxgVBWBNiZh6X
        HAs9OxLM1+EJcRteeR1Ty+8Bovy+60dJ5wJ9aJSseiNYP6Iw
X-Google-Smtp-Source: APXvYqx0Aj831JIJffguwTlX4uz3Q/32KuSI38Eju+sXqcM9OTtpYBImR7kQ+fu2UKaBv4U7UIJd+hphh+G4QKtljQi9ZhVa2Txy
MIME-Version: 1.0
X-Received: by 2002:a24:7d08:: with SMTP id b8mr22607288itc.155.1559693526558;
 Tue, 04 Jun 2019 17:12:06 -0700 (PDT)
Date:   Tue, 04 Jun 2019 17:12:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bf1bd058a887277@google.com>
Subject: KMSAN: uninit-value in sd_init
From:   syzbot <syzbot+1a35278dd0ebfb3a038a@syzkaller.appspotmail.com>
To:     glider@google.com, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f75e4cfe kmsan: use kmsan_handle_urb() in urb.c
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=17eadebaa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=602468164ccdc30a
dashboard link: https://syzkaller.appspot.com/bug?extid=1a35278dd0ebfb3a038a
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
06d00afa61eef8f7f501ebdb4e8612ea43ec2d78)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147f4136a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17aec4f2a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1a35278dd0ebfb3a038a@syzkaller.appspotmail.com

usb 1-1: config 0 has an invalid interface number: 142 but max is 0
usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=08ca, idProduct=2018,  
bcdDevice=95.4a
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
gspca_main: sunplus-2.14.0 probing 08ca:2018
gspca_sunplus: reg_w_riv err -71
==================================================================
BUG: KMSAN: uninit-value in spca504B_PollingDataReady  
drivers/media/usb/gspca/sunplus.c:409 [inline]
BUG: KMSAN: uninit-value in sd_init+0x5b6f/0x5e60  
drivers/media/usb/gspca/sunplus.c:643
CPU: 0 PID: 3902 Comm: kworker/0:2 Not tainted 5.1.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x130/0x2a0 mm/kmsan/kmsan.c:622
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:310
  spca504B_PollingDataReady drivers/media/usb/gspca/sunplus.c:409 [inline]
  sd_init+0x5b6f/0x5e60 drivers/media/usb/gspca/sunplus.c:643
  gspca_dev_probe2+0xee0/0x2240 drivers/media/usb/gspca/gspca.c:1546
  gspca_dev_probe+0x346/0x3b0 drivers/media/usb/gspca/gspca.c:1619
  sd_probe+0x8d/0xa0 drivers/media/usb/gspca/gl860/gl860.c:523
  usb_probe_interface+0xd66/0x1320 drivers/usb/core/driver.c:361
  really_probe+0xdae/0x1d80 drivers/base/dd.c:513
  driver_probe_device+0x1b3/0x4f0 drivers/base/dd.c:671
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:778
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x454/0x730 drivers/base/dd.c:844
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:891
  bus_probe_device+0x137/0x390 drivers/base/bus.c:514
  device_add+0x288d/0x30e0 drivers/base/core.c:2106
  usb_set_configuration+0x30dc/0x3750 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x14c/0x200 drivers/usb/core/driver.c:266
  really_probe+0xdae/0x1d80 drivers/base/dd.c:513
  driver_probe_device+0x1b3/0x4f0 drivers/base/dd.c:671
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:778
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x454/0x730 drivers/base/dd.c:844
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:891
  bus_probe_device+0x137/0x390 drivers/base/bus.c:514
  device_add+0x288d/0x30e0 drivers/base/core.c:2106
  usb_new_device+0x23e5/0x2ff0 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x48d1/0x7290 drivers/usb/core/hub.c:5432
  process_one_work+0x1572/0x1f00 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:254
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:208 [inline]
  kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:162
  kmsan_kmalloc+0xa4/0x130 mm/kmsan/kmsan_hooks.c:175
  kmem_cache_alloc_trace+0x503/0xae0 mm/slub.c:2801
  kmalloc include/linux/slab.h:547 [inline]
  gspca_dev_probe2+0x30c/0x2240 drivers/media/usb/gspca/gspca.c:1480
  gspca_dev_probe+0x346/0x3b0 drivers/media/usb/gspca/gspca.c:1619
  sd_probe+0x8d/0xa0 drivers/media/usb/gspca/gl860/gl860.c:523
  usb_probe_interface+0xd66/0x1320 drivers/usb/core/driver.c:361
  really_probe+0xdae/0x1d80 drivers/base/dd.c:513
  driver_probe_device+0x1b3/0x4f0 drivers/base/dd.c:671
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:778
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x454/0x730 drivers/base/dd.c:844
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:891
  bus_probe_device+0x137/0x390 drivers/base/bus.c:514
  device_add+0x288d/0x30e0 drivers/base/core.c:2106
  usb_set_configuration+0x30dc/0x3750 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x14c/0x200 drivers/usb/core/driver.c:266
  really_probe+0xdae/0x1d80 drivers/base/dd.c:513
  driver_probe_device+0x1b3/0x4f0 drivers/base/dd.c:671
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:778
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x454/0x730 drivers/base/dd.c:844
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:891
  bus_probe_device+0x137/0x390 drivers/base/bus.c:514
  device_add+0x288d/0x30e0 drivers/base/core.c:2106
  usb_new_device+0x23e5/0x2ff0 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x48d1/0x7290 drivers/usb/core/hub.c:5432
  process_one_work+0x1572/0x1f00 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:254
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
