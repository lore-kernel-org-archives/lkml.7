Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC6FCA9EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075192084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbfJVWoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:44:14 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:37140 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388216AbfJVWoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:44:13 -0400
Received: by mail-il1-f197.google.com with SMTP id u68so3329432ilc.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 15:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dvNgexL4MTfQfuzWCsSOBdjRrK9RO5oPSvx73xr85Bc=;
        b=qihKl4+xawX+xWE2ZQ/xpKqgmz1MUIWPGeVeu1s1P0vAT1cw9HlZQqmGIv/LNyxExD
         /Y4FXw2cpqmAEw5/U9lk4RbP22kkKFI5L3ZWhJifJifiJVZenY0/vx8HgVK9qXFCy+wv
         az+mn6j2wt3XkWwy8NsPIQn57Hjem4B7HZvvxhlSUWwC3LOkzznWcrSI/9W4oj8X5/Ln
         Z2z92UG1FoOSkZ0bGWKYpgQHpGfQABgt9gFBRX5av97hjcxIHQlJ3aZau/TodCUKIy0a
         WyLan9mPYbrObHn/XFVdwVxiiGzYvvUr4q84znvgs81Tu6u7hl3VWAchLOzq9N+dTkYN
         zcnQ==
X-Gm-Message-State: APjAAAX9I0lodRyrEgxeEoWP+XhQNvBjIBaY0hcXE3pMt8Ae4bi9XqIy
        bX2ma0pJw0tnKAWzjDuYHPb2LqdrHFXkPztnCgsRdVYct8pJ
X-Google-Smtp-Source: APXvYqyvIqFxbAMta15TN9O4BFvIhOHpmPLdzksoRW+V8gi4fHw+L83AcKp5mrhrZQQmmpax27S3jOc+csA8wbZxDiaGqbYVav0M
MIME-Version: 1.0
X-Received: by 2002:a92:b308:: with SMTP id p8mr33355252ilh.182.1571784251877;
 Tue, 22 Oct 2019 15:44:11 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:44:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff32e605958789e2@google.com>
Subject: KMSAN: uninit-value in build_audio_procunit
From:   syzbot <syzbot+85f45d8bd343473faf15@syzkaller.appspotmail.com>
To:     allison@lohutok.net, alsa-devel@alsa-project.org,
        benquike@gmail.com, dan.carpenter@oracle.com, g@b4.vu,
        glider@google.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tiwai@suse.com, wang6495@umn.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3c8ca708 test_kmsan.c: fix SPDX comment
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=133fb3cf600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c07a3d4f8a59e198
dashboard link: https://syzkaller.appspot.com/bug?extid=85f45d8bd343473faf15
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12201cef600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1281b8ff600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+85f45d8bd343473faf15@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=1d6b, idProduct=0101, bcdDevice=  
0.40
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
=====================================================
BUG: KMSAN: uninit-value in build_audio_procunit+0x1be8/0x2490  
sound/usb/mixer.c:2438
CPU: 1 PID: 3381 Comm: kworker/1:2 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x14a/0x2f0 mm/kmsan/kmsan_report.c:110
  __msan_warning+0x73/0xf0 mm/kmsan/kmsan_instr.c:245
  build_audio_procunit+0x1be8/0x2490 sound/usb/mixer.c:2438
  parse_audio_unit+0x115c/0x7490 sound/usb/mixer.c:2483
  snd_usb_mixer_controls sound/usb/mixer.c:3095 [inline]
  snd_usb_create_mixer+0x1d7c/0x4070 sound/usb/mixer.c:3445
  usb_audio_probe+0x286b/0x3eb0 sound/usb/card.c:653
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0xd91/0x1f90 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:721
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:828
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:430
  __device_attach+0x489/0x750 drivers/base/dd.c:894
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:941
  bus_probe_device+0x131/0x390 drivers/base/bus.c:490
  device_add+0x25b5/0x2df0 drivers/base/core.c:2201
  usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
  really_probe+0xd91/0x1f90 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:721
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:828
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:430
  __device_attach+0x489/0x750 drivers/base/dd.c:894
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:941
  bus_probe_device+0x131/0x390 drivers/base/bus.c:490
  device_add+0x25b5/0x2df0 drivers/base/core.c:2201
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
  kmsan_internal_poison_shadow+0x60/0x110 mm/kmsan/kmsan.c:134
  kmsan_slab_alloc+0xaa/0x130 mm/kmsan/kmsan_hooks.c:88
  slab_alloc_node mm/slub.c:2792 [inline]
  slab_alloc mm/slub.c:2801 [inline]
  __kmalloc+0x28e/0x430 mm/slub.c:3832
  kmalloc include/linux/slab.h:561 [inline]
  usb_get_configuration+0x50d/0x76a0 drivers/usb/core/config.c:857
  usb_enumerate_device drivers/usb/core/hub.c:2369 [inline]
  usb_new_device+0x224/0x2fb0 drivers/usb/core/hub.c:2505
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
