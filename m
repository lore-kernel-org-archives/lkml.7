Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085F4C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5322087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfGJOAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:00:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54187 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfGJOAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:00:07 -0400
Received: by mail-io1-f70.google.com with SMTP id h3so2955356iob.20
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 07:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9oJpO2FtIsJzH3ju33fLd+Qk1oDny1RDRINbQVQp4z4=;
        b=HfVFkP6D6RMEZryFK/f0N65TF7vsagCNn2A4T8qjPIzxk8UTleUVxN5k3KTnMJx6Gu
         9FyqJrnH5RMmgV+OjvxV2ZrPV2Iz0hyvdYezkhxOrWPIh1MKD7MDnMdwRWiTWNoL3w4p
         1OIUCTy8ZnKjvmhtsYRNFcP5Kiq6bfLmXNYenAVt9StNO6h6Q0zT2moowXI7dNolQsAV
         EmzKlwriURy74atPCZS2jI8xWkdQoDpk1lKKpKubbNB/WVIx1kiCE1QEOeZwumgvYisd
         PghM+dbL5pD35+r6BLjG0YO3flcmHUnIPAWZ5U0KdI+v0oD5uPgQsYUXsuWiG8YSer4i
         JjIg==
X-Gm-Message-State: APjAAAWe6d/n5aaKRT5DPSX+ZHm8CCAfCSk2DN8i8qjn3wFNughMWIWx
        lOWEw5lOQQLuwY0WAUYZDpu8i3gt1lRmlHr1PEYl5XWXhGZh
X-Google-Smtp-Source: APXvYqzgbAljFWowOpWGG+hkyyP5HCFp04OGEzCoYfY5G7AeYNvGbtjNAEgtLa/yMSsw+ITKOA3KocKMXf685d5s/UzXT/o5zKLg
MIME-Version: 1.0
X-Received: by 2002:a5d:9282:: with SMTP id s2mr2027494iom.36.1562767206456;
 Wed, 10 Jul 2019 07:00:06 -0700 (PDT)
Date:   Wed, 10 Jul 2019 07:00:06 -0700
In-Reply-To: <00000000000041eeb7058d53ed4c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000352dce058d541834@google.com>
Subject: Re: KMSAN: uninit-value in friio_power_ctrl
From:   syzbot <syzbot+9e6bf7282557bd1fc80d@syzkaller.appspotmail.com>
To:     crope@iki.fi, glider@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    4009f3cf kmsan: slub: fix a compilation warning by moving ..
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=17f85018600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
dashboard link: https://syzkaller.appspot.com/bug?extid=9e6bf7282557bd1fc80d
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114535c4600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16236437a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9e6bf7282557bd1fc80d@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=7a69, idProduct=0001,  
bcdDevice=19.36
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: dvb_usb_v2: found a '774 Friio White ISDB-T USB2.0' in warm state
==================================================================
BUG: KMSAN: uninit-value in friio_reset  
drivers/media/usb/dvb-usb-v2/gl861.c:433 [inline]
BUG: KMSAN: uninit-value in friio_power_ctrl+0xb3e/0x1a70  
drivers/media/usb/dvb-usb-v2/gl861.c:482
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc4+ #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  friio_reset drivers/media/usb/dvb-usb-v2/gl861.c:433 [inline]
  friio_power_ctrl+0xb3e/0x1a70 drivers/media/usb/dvb-usb-v2/gl861.c:482
  dvb_usbv2_device_power_ctrl  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:540 [inline]
  dvb_usbv2_init drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:853 [inline]
  dvb_usbv2_probe+0xd3d/0x5dd0  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:980
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0x1344/0x1d90 drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:890
  bus_probe_device+0x131/0x390 drivers/base/bus.c:514
  device_add+0x25b5/0x2df0 drivers/base/core.c:2111
  usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
  ? __ms

