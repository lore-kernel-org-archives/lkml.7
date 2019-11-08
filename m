Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56192C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20247206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfKHREL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:04:11 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42374 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfKHREL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:04:11 -0500
Received: by mail-io1-f69.google.com with SMTP id w1so5827027ioj.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 09:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pFzCAJ0CGlySD/wXXpzl2ok+erCxiE6zz9f3FzQlnXk=;
        b=qwTuG0svynosx4qIUAM/QorNx1jGMui8oZdTbopbgWcUIGyUKRbMWYKOhNzWBtCXNZ
         29RiR9Cj++Xc9bJJA5ITZ1BtHRj7M9QuN7+HIIJ2Y/IaVQhT1KeP21eKIw8dtHoTvTmQ
         2sZWDfCtQUnYZY2FEsF1DORZ/7dVS1Rd4L1hDC2JiQ6ri5TPYiKZlvIJX9jhsgoVbtxV
         qw0aTw2H5agftTNISl+txbx9gehQk8KibJ+Fbgw3L+cSoGSJiYi0xzPli7Nez3Or7Xgg
         vQJHB3srI+EXj2AGfqm0pc40AEkQgcnKTGypuy/1zg9qomzUt9SzMAwrUkXQ+MRpLL/7
         JzuQ==
X-Gm-Message-State: APjAAAVlx4hEeFYGGSaNfjSrj8fviHDCFYSKnq7nXi3XZ9CzeP5SLfic
        q9VEiaN4s3mgBidHku4uY6WIWGJ0jLZtp2JrffwR7U9P4t3L
X-Google-Smtp-Source: APXvYqzYTsdH44lrdqX2YHZSgA0wtmXvEAhKnkksoLLmbuoiqzpuDdMMtL0c2U5MMAOkOzxqvZhKcE7TWdyz0HH+3r9RZX4DrqFi
MIME-Version: 1.0
X-Received: by 2002:a5e:dd09:: with SMTP id t9mr2555994iop.182.1573232650667;
 Fri, 08 Nov 2019 09:04:10 -0800 (PST)
Date:   Fri, 08 Nov 2019 09:04:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004acf5b0596d8c522@google.com>
Subject: KMSAN: uninit-value in get_min_max_with_quirks
From:   syzbot <syzbot+abe1ab7afc62c6bb6377@syzkaller.appspotmail.com>
To:     allison@lohutok.net, alsa-devel@alsa-project.org,
        benquike@gmail.com, dan.carpenter@oracle.com, g@b4.vu,
        glider@google.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tiwai@suse.com, wang6495@umn.edu, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c2453450 kmsan: kcov: prettify the code unpoisoning area->..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=119f1173600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3684f3c73f43899a
dashboard link: https://syzkaller.appspot.com/bug?extid=abe1ab7afc62c6bb6377
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16255fe7600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e73290e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+abe1ab7afc62c6bb6377@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: 0:2 : does not exist
=====================================================
BUG: KMSAN: uninit-value in get_min_max_with_quirks+0xd6f/0x2ea0  
sound/usb/mixer.c:1239
CPU: 0 PID: 2859 Comm: kworker/0:2 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x14a/0x2f0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x73/0xf0 mm/kmsan/kmsan_instr.c:245
  get_min_max_with_quirks+0xd6f/0x2ea0 sound/usb/mixer.c:1239
  __build_feature_ctl+0x12b9/0x29e0 sound/usb/mixer.c:1665
  build_feature_ctl sound/usb/mixer.c:1709 [inline]
  parse_audio_feature_unit sound/usb/mixer.c:1918 [inline]
  parse_audio_unit+0x218c/0x7490 sound/usb/mixer.c:2753
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

Local variable description: ----saved@get_min_max_with_quirks
Variable was created at:
  get_min_max_with_quirks+0xa8b/0x2ea0 sound/usb/mixer.c:1231
  get_min_max_with_quirks+0xa8b/0x2ea0 sound/usb/mixer.c:1231
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
