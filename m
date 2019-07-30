Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FECEC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECABD20665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfG3JiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:38:20 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55001 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbfG3JiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:38:07 -0400
Received: by mail-io1-f70.google.com with SMTP id n8so70724427ioo.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qC0fsXMfMK53cx7YDAcq54+W59oVrprCrvBMxYygca4=;
        b=YG77jZfozIq7ThWHw6oI1yZxivPUnD/N4yvnMkfBGGzhHzGAQZ3ff8ykvCZN79LidQ
         He8VdwBXRcpUiLjpHDmvH+iENzjG1ejQVswNmjuOEy5VcDx5oBL2T9bJ81hWkO/JFm/f
         mOJRj92mEdCDFPengyQuR7w+dDwVuqU2Lxtki+ARH7X97HmK9jTRhXvd6TtjE/YgvSgQ
         sGS8fKhs3z2VbO/MWJkd1x5gnfsvry2PU6Cu+XqXVlvxj8k3xsaEKNFpp3w9ZpEJ84PS
         LXTjA5iYjC6tRXiMGfkNHJIz9rEbXZmUYTs4E5ez5RP7S5L/8ljSalwUQffYZHG/VHsI
         lzOQ==
X-Gm-Message-State: APjAAAWPcHrIfzECxOEnlqCG3NZFAyq0odWObusIA94T1WgUaNIFTO75
        YYfNf38Jx1BES+JxNNERHb/jnqSiuTWebf2ttq4BZNXF9ILW
X-Google-Smtp-Source: APXvYqyo3rkj27TdtlaK6oaBRgH2PsyoSXAuRfFg1fLBcyAHxQrF8W1UQ5JGC7mZ4ggPnZE95T2p7fbVHS8sPd1Wr+rVxudl7GZQ
MIME-Version: 1.0
X-Received: by 2002:a02:ac03:: with SMTP id a3mr121670663jao.132.1564479487000;
 Tue, 30 Jul 2019 02:38:07 -0700 (PDT)
Date:   Tue, 30 Jul 2019 02:38:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014c877058ee2c4a6@google.com>
Subject: KMSAN: kernel-usb-infoleak in pcan_usb_pro_send_req
From:   syzbot <syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    41550654 [UPSTREAM] KVM: x86: degrade WARN to pr_warn_rate..
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=13e95183a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
dashboard link: https://syzkaller.appspot.com/bug?extid=513e4d0985298538bf9b
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eafa1ba00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b87983a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=0c72, idProduct=0014,  
bcdDevice=8b.53
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
peak_usb 1-1:0.146: PEAK-System PCAN-USB X6 v0 fw v0.0.0 (2 channels)
==================================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x7ef/0x1f50  
drivers/usb/core/urb.c:405
CPU: 0 PID: 3359 Comm: kworker/0:2 Not tainted 5.2.0-rc4+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan.c:611
  kmsan_internal_check_memory+0x974/0xa80 mm/kmsan/kmsan.c:705
  kmsan_handle_urb+0x28/0x40 mm/kmsan/kmsan_hooks.c:617
  usb_submit_urb+0x7ef/0x1f50 drivers/usb/core/urb.c:405
  usb_start_wait_urb+0x143/0x410 drivers/usb/core/message.c:58
  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
  usb_control_msg+0x49f/0x7f0 drivers/usb/core/message.c:156
  pcan_usb_pro_send_req+0x26b/0x3e0  
drivers/net/can/usb/peak_usb/pcan_usb_pro.c:336
  pcan_usb_fd_drv_loaded drivers/net/can/usb/peak_usb/pcan_usb_fd.c:460  
[inline]
  pcan_usb_fd_init+0x16ee/0x1900  
drivers/net/can/usb/peak_usb/pcan_usb_fd.c:885
  peak_usb_create_dev drivers/net/can/usb/peak_usb/pcan_usb_core.c:809  
[inline]
  peak_usb_probe+0x1416/0x1b20  
drivers/net/can/usb/peak_usb/pcan_usb_core.c:907
  usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
  really_probe+0x1344/0x1d90 drivers/base/dd.c:513
  driver_probe_device+0x1ba/0x510 drivers/base/dd.c:670
  __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:777
  bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
  __device_attach+0x489/0x750 drivers/base/dd.c:843
  device_initial_probe+0x4a/0x60 drivers/base/dd.c:890


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
