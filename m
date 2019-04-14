Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36986C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14921214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfDNUGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:06:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48014 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfDNUGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:06:07 -0400
Received: by mail-io1-f70.google.com with SMTP id b199so12620004iof.14
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 13:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mnR1ARR6w9OS6jp8tpfEg3THUER7MsGlQPhDdl9c5kg=;
        b=VbeiFNsLgj6do4/XZJX8gDbq536PzbfwwpJi3uj5pwjGf1SBQU0Z3WqzXgnK2I6dt1
         RBN6qzuELRU3mPscYXa/isdgsoZtRMWjrlsFhtUcdG3DkcuvjlBT0/+b3onfmQ9pWqRb
         JMF2Hbm0sJ2x5XkOu9pq+hPWJzaexzBUA9ZDSV+sh/csnXIs1e50n42aMi3jH6oKR/ki
         N0HcYi6y0VxqDZrmB/KSpdPi2DS6lC0q8tVLVG0hwZCrlhSjslyQilhBDCOoK3Uz8NDW
         wCOlKZKtrMsMGNVMj+2gv2ok1093yNCsfwFYfns2clEQJtZAR7SQ2uj6vOy0MN8i4uPB
         Mz2A==
X-Gm-Message-State: APjAAAVvclYnrITGFauMu+IEIN0vPebyzEyFbN61RpmIgEQFXwn7iV3e
        gmsFzWsDQfMPubsPMqSSWh9Hec09jWk4qyAkrsFviA9FUKEG
X-Google-Smtp-Source: APXvYqxqs84iZ08v63U6oexgvaJ2ok316NHmTXOF8W++PKF54u79U05tURbtHj7j9dkvuYjfJZPV08oAmFp2g0QmAl616Zf8Qatx
MIME-Version: 1.0
X-Received: by 2002:a6b:720b:: with SMTP id n11mr3413980ioc.3.1555272366966;
 Sun, 14 Apr 2019 13:06:06 -0700 (PDT)
Date:   Sun, 14 Apr 2019 13:06:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f64e71058683105b@google.com>
Subject: INFO: trying to register non-static key in mxl111sf_ctrl_msg
From:   syzbot <syzbot+5ca0bf339f13c4243001@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, mkrufky@linuxtv.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1613e4f3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=5ca0bf339f13c4243001
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1259bedd200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12763bbb200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5ca0bf339f13c4243001@syzkaller.appspotmail.com

usb 1-1: dvb_usb_v2: found a 'Hauppauge 117xxx DVBT' in warm state
usb 1-1: dvb_usb_v2: will pass the complete MPEG2 transport stream to the  
software demuxer
dvbdev: DVB: registering new adapter (Hauppauge 117xxx DVBT)
usb 1-1: selecting invalid altsetting 2
set interface failed
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:786 [inline]
  register_lock_class+0x11b8/0x1250 kernel/locking/lockdep.c:1095
  __lock_acquire+0xfb/0x37c0 kernel/locking/lockdep.c:3582
  lock_acquire+0x10d/0x2f0 kernel/locking/lockdep.c:4211
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0xfe/0x12b0 kernel/locking/mutex.c:1072
  mxl111sf_ctrl_msg+0xc7/0x250 drivers/media/usb/dvb-usb-v2/mxl111sf.c:69
  mxl111sf_write_reg+0x9f/0x160 drivers/media/usb/dvb-usb-v2/mxl111sf.c:126
  mxl1x1sf_soft_reset+0x70/0x190  
drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c:56
  mxl111sf_attach_demod+0x291/0x770  
drivers/media/usb/dvb-usb-v2/mxl111sf.c:768
  dvb_usbv2_adapter_frontend_init  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:654 [inline]
  dvb_usbv2_adapter_init drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:817  
[inline]
  dvb_usbv2_init drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:878 [inline]
  dvb_usbv2_probe.cold+0x2170/0x29f6  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:993
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
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
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  ? p


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
