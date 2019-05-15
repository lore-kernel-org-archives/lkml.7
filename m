Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F255C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A21420862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEOQRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:17:06 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:40229 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOQRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:17:06 -0400
Received: by mail-it1-f200.google.com with SMTP id u10so505101itb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/kDWjBB0jCL1YtbOqkI5qZw4O964lNtmlxXi0fZixK4=;
        b=NVEhxM1Xm4siH3FY0u3ZeLLd88URU0Sw8Z+uAZUS5t9Hq+sJOQdZJQxOlLe+hfhySY
         bu8P+TJiNd4cLA4KAXimlNdMbvF47RrCpEsvxJpkcoHnKfpWSPa4wQmgOQ/HWs/Gy7PD
         nEy+IyZNwTSBiBU8ipnGcFsQ5mha6EU7SXN+zYVVkFYynSUgycn4eqGyLGsZbB/0Hgqe
         JlOYu5GrGPi7ztvpDjwdwtDQNXyGHfR1vgfReN7DITt557OVTjte/3XGDqaPqW4QczKi
         vxGKx+c7ilrXnbVjw84qZHNCb456U+UwFIMCqWdlkJRb7mn+B7CzoSTZ3oe9jWNSckCw
         yGbg==
X-Gm-Message-State: APjAAAVRch4ugxcOkzuiL6RI4b7pT6KMT8KBkERjggL7oJvByZaPG1JX
        WWiikgMVCfNZ44gvhPqnRmtSc3/0nQL9xpBX7D5Bu5uX3X1K
X-Google-Smtp-Source: APXvYqykB3D2KbCA7ppkwMbMaz0GBUsa4he0CqdKkR9zOB32utCtFaO9CnEDA1gWJIHqbSHQyKnO4IeewHu+FyaoAvArH2q7TINb
MIME-Version: 1.0
X-Received: by 2002:a24:edcb:: with SMTP id r194mr8724352ith.164.1557937025379;
 Wed, 15 May 2019 09:17:05 -0700 (PDT)
Date:   Wed, 15 May 2019 09:17:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000faf6000588ef7a11@google.com>
Subject: KASAN: slab-out-of-bounds Read in au0828_rc_unregister (2)
From:   syzbot <syzbot+357d86bcb4cca1a2f572@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, sean@mess.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=162ca944a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95aff7278e7ff25e
dashboard link: https://syzkaller.appspot.com/bug?extid=357d86bcb4cca1a2f572
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+357d86bcb4cca1a2f572@syzkaller.appspotmail.com

au0828: recv_control_msg() Failed receiving control message, error -71.
au0828: recv_control_msg() Failed receiving control message, error -71.
au0828: recv_control_msg() Failed receiving control message, error -71.
au8522_writereg: writereg error (reg == 0x106, val == 0x0001, ret == -5)
usb 4-1: selecting invalid altsetting 5
au0828: Failure setting usb interface0 to as5
au0828: au0828_usb_probe() au0828_analog_register failed to register on V4L2
==================================================================
BUG: KASAN: slab-out-of-bounds in au0828_rc_unregister+0x9a/0xb0  
drivers/media/usb/au0828/au0828-input.c:353
Read of size 8 at addr ffff8881cb76f308 by task kworker/1:5/5626

CPU: 1 PID: 5626 Comm: kworker/1:5 Not tainted 5.1.0-rc3+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x67/0x231 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x35 mm/kasan/report.c:317
  au0828_rc_unregister+0x9a/0xb0 drivers/media/usb/au0828/au0828-input.c:353
  au0828_usb_disconnect+0x6a/0x130 drivers/media/usb/au0828/au0828-core.c:189
  au0828_usb_probe.cold+0x111/0x16e  
drivers/media/usb/au0828/au0828-core.c:661
  usb_probe_interface+0x30d/0x7b0 drivers/usb/core/driver.c:361
  really_probe+0x296/0x680 drivers/base/dd.c:509
  driver_probe_device+0xf9/0x200 drivers/base/dd.c:671
  __device_attach_driver+0x1c4/0x230 drivers/base/dd.c:778
  bus_for_each_drv+0x15e/0x1e0 drivers/base/bus.c:454
  __device_attach+0x21e/0x360 drivers/base/dd.c:844
  bus_probe_device+0x1ec/0x2a0 drivers/base/bus.c:514
  device_add+0xaf4/0x1700 drivers/base/core.c:2106
  usb_set_configuration+0xdf2/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0xa8/0x110 drivers/usb/core/driver.c:266
  really_probe+0x296/0x680 drivers/base/dd.c:509
  driver_probe_device+0xf9/0x200 drivers/base/dd.c:671
  __device_attach_driver+0x1c4/0x230 drivers/base/dd.c:778
  bus_for_each_drv+0x15e/0x1e0 drivers/base/bus.c:454
  __device_attach+0x21e/0x360 drivers/base/dd.c:844
  bus_probe_device+0x1ec/0x2a0 drivers/base/bus.c:514
  device_add+0xaf4/0x1700 drivers/base/core.c:2106
  usb_new_device.cold+0x8b8/0x1030 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1ac9/0x35a0 drivers/usb/core/hub.c:5432
  process_one_work+0x90a/0x1580 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30e/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the page:
page:ffffea00072ddb00 count:1 mapcount:0 mapping:0000000000000000 index:0x0  
compound_mapcount: 0
flags: 0x200000000010000(head)
raw: 0200000000010000 dead000000000100 dead000000000200 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cb76f200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  ffff8881cb76f280: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> ffff8881cb76f300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                       ^
  ffff8881cb76f380: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  ffff8881cb76f400: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
