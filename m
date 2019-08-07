Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8453FC41514
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3D821BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfHGLsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:48:06 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:55846 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfHGLsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:48:06 -0400
Received: by mail-ot1-f71.google.com with SMTP id p7so54213470otk.22
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 04:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GoZRE87G5nmPn2K8yJgOw8W+FOPUWswgfdnrBbwx8HE=;
        b=un4q5f5kCab0aT94kdk/GMoaOkPHO1VpaCCE8Fe7n2HwSBVDlrcBrj/SP8QQWa5nUW
         DeZy/Me+0l59Vvwh3GekSG+mwCPXcmTr6QnkREq0E44UhuVhgbEoV2TFBY+bSDIhW5ls
         nEYsZ5zLJsMaKFhqGPtFujKhqq9LXByv84fELSr1Vdr2jY2mOyLH57QSRN0LB8qrlzk7
         U8SoTAGvM+C+hRZ9yxlihDDPYhK1UXZaFUsmScQ4LCebCfRLUnOrlgAtPU7L/BocTf93
         1HtYSP71xyNAdSdRHFQ1vIHu2RO2KAJfCvhUjtcNcdCCk8oDM+rluBFSxPHvGXkQvTFS
         nDIw==
X-Gm-Message-State: APjAAAXmCKv6mG6QjD6T1Fk3Th8qvPWnyCNlnCgXY6SiwtSnPVhaR6s+
        daQlYtlI8Lgvx5tzS3Srhw6lSACSc2vlzq28oYHPwOS2ORhO
X-Google-Smtp-Source: APXvYqxNxE4YTZ+L2Gw7fd493v4JQnlEXMFWmmOWo0R8nRsooRqqZBNEK5vZN+wNttdNxrhC10CHlgomhtLGMzk/HML3NnGXpeMK
MIME-Version: 1.0
X-Received: by 2002:a6b:6d08:: with SMTP id a8mr8669980iod.191.1565178485118;
 Wed, 07 Aug 2019 04:48:05 -0700 (PDT)
Date:   Wed, 07 Aug 2019 04:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d9e43058f85838c@google.com>
Subject: KMSAN: uninit-value in smsc75xx_wait_eeprom
From:   syzbot <syzbot+532222e4d7ddadadd1c8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, steve.glendinning@shawell.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ae0c578a kmsan: include gfp.h from kmsan.h
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=10e4f474600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27abc558ecb16a3b
dashboard link: https://syzkaller.appspot.com/bug?extid=532222e4d7ddadadd1c8
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+532222e4d7ddadadd1c8@syzkaller.appspotmail.com

usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1: config 0 descriptor??
smsc75xx v1.0.0
==================================================================
BUG: KMSAN: uninit-value in smsc75xx_wait_eeprom+0x1fb/0x3d0  
drivers/net/usb/smsc75xx.c:307
CPU: 1 PID: 10983 Comm: kworker/1:5 Not tainted 5.3.0-rc3+ #16
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  smsc75xx_wait_eeprom+0x1fb/0x3d0 drivers/net/usb/smsc75xx.c:307
  smsc75xx_read_eeprom+0x3c2/0x920 drivers/net/usb/smsc75xx.c:364
  smsc75xx_init_mac_address drivers/net/usb/smsc75xx.c:771 [inline]
  smsc75xx_bind+0x675/0x12d0 drivers/net/usb/smsc75xx.c:1489
  usbnet_probe+0x10ae/0x3960 drivers/net/usb/usbnet.c:1722
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:882
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2114
  usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
  generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
  usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
  really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:882
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2114
  usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Local variable description: ----buf.i.i@smsc75xx_wait_eeprom
Variable was created at:
  __smsc75xx_read_reg drivers/net/usb/smsc75xx.c:83 [inline]
  smsc75xx_read_reg drivers/net/usb/smsc75xx.c:147 [inline]
  smsc75xx_wait_eeprom+0xb6/0x3d0 drivers/net/usb/smsc75xx.c:301
  smsc75xx_read_eeprom+0x3c2/0x920 drivers/net/usb/smsc75xx.c:364
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
