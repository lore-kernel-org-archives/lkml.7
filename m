Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B9DC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5746D2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfGJRSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:18:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41939 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfGJRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:18:10 -0400
Received: by mail-io1-f72.google.com with SMTP id x17so3559130iog.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 10:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=N+nVQfn9OhvXMYxEbgglbdkopqMyXUoX5ywftFYxY8Q=;
        b=SW5ANqxQdppV19I5h0m0QUoQr4lEkCAnJvZxrTksunzDgCZUFJcV4xWtK/VuN7OJuX
         L+/xPpm0TKPQyMhsmMjBlvTSIbwm4t+5MYkdqQSMY2r3RqVethmaZkaFMg/CealgXN1Q
         N7+S9bfyOBcqlOWZVfqZXCJ/vgZgkFLLMScGAjHfAWp0xtkhqTMSNHptHrpmWNsv3+J4
         mBj3sRXi3Jf4HsNb5NcLUXiG95zP8Mmhy3dr0kDox6+7YaRX5+4W86/6CRVsOV7M1sXR
         MwltPoC/m76xhwQ32GQwNmR7qaho33wYL6ViCHcJi5edo+s+Mcw626UJUbB7iNitMjNe
         K6Bg==
X-Gm-Message-State: APjAAAXnkWQAGAIJfV8L2qztiSVMF9LJbHBiA0+YLsUEyx9rQjIAGhkO
        lhR5T0kGZduaNXOaOhYoZ1KMs/zvxt/DRQwkJKJ5tUJ8semN
X-Google-Smtp-Source: APXvYqx9OG26o/Opi8hTxF8cE4ksPs2QrbCxbRsjQZkqxriuSHOE56TCnRqkbB7yn5Alxt0l76sXjUV+00jZkxKfTfdJh7ZxKRJj
MIME-Version: 1.0
X-Received: by 2002:a02:8a:: with SMTP id 132mr35327597jaa.89.1562779088676;
 Wed, 10 Jul 2019 10:18:08 -0700 (PDT)
Date:   Wed, 10 Jul 2019 10:18:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000717347058d56dcc2@google.com>
Subject: KASAN: global-out-of-bounds Read in dvb_pll_attach
From:   syzbot <syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andreyknvl@google.com,
        hverkuil-cisco@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, rfontana@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tskd08@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=150f8c47a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=8a8f48672560c8ca59dd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16384e27a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16056038600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com

usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (774 Friio White ISDB-T USB2.0)
usb 1-1: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
tc90522 0-0018: Toshiba TC90522 attached.
usb 1-1: DVB: registering adapter 0 frontend 0 (Toshiba TC90522 ISDB-T  
module)...
dvbdev: dvb_create_media_entity: media entity 'Toshiba TC90522 ISDB-T  
module' registered.
==================================================================
BUG: KASAN: global-out-of-bounds in dvb_pll_attach+0x6c5/0x830  
drivers/media/dvb-frontends/dvb-pll.c:798
Read of size 4 at addr ffffffff89c9e5e0 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc6+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x67/0x231 mm/kasan/report.c:188
  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:317
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  dvb_pll_attach+0x6c5/0x830 drivers/media/dvb-frontends/dvb-pll.c:798
  dvb_pll_probe+0xfe/0x174 drivers/media/dvb-frontends/dvb-pll.c:877
  i2c_device_probe+0x790/0xaa0 drivers/i2c/i2c-core-base.c:389
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  i2c_new_client_device+0x5b3/0xc40 drivers/i2c/i2c-core-base.c:778
  i2c_new_device+0x19/0x50 drivers/i2c/i2c-core-base.c:821
  dvb_module_probe+0xf9/0x220 drivers/media/dvb-core/dvbdev.c:985
  friio_tuner_attach+0x125/0x1d0 drivers/media/usb/dvb-usb-v2/gl861.c:536
  dvb_usbv2_adapter_frontend_init  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:675 [inline]
  dvb_usbv2_adapter_init drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:804  
[inline]
  dvb_usbv2_init drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:865 [inline]
  dvb_usbv2_probe.cold+0x24dc/0x255d  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:980
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1ada/0x3590 drivers/usb/core/hub.c:5432
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the variable:
  id+0x100/0x120

Memory state around the buggy address:
  ffffffff89c9e480: fa fa fa fa 00 00 fa fa fa fa fa fa 00 00 00 00
  ffffffff89c9e500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffffff89c9e580: 00 00 00 00 00 00 00 00 00 00 00 00 fa fa fa fa
                                                        ^
  ffffffff89c9e600: 04 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
  ffffffff89c9e680: 04 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
