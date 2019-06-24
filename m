Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC6AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBE2212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfFXMHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:07:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:35140 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfFXMHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:07:06 -0400
Received: by mail-io1-f69.google.com with SMTP id w17so21741877iom.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 05:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UGhJIyNooByBIQwghNYXd2AUJKMl6V+JYhFL1m8VV5g=;
        b=WSJfnZAHH9C0kVee1jL9Kw8tT4LKVkU2jTyitXibhpdLZ+7B+coVg1gg96KAYqN9nT
         LV5EpZQMxt++IbOhOdU1ypgGRBpA+R+vsZCWZE//yRKc9/qAgWLKvOvVRFy3iEaSiwk5
         gr1hhKmy80cIAr4CkTnsnMCFAF7XnIbLrspLeygNK8NuCil9vpr2mZV6d5yj6YHYTFgK
         CVu2TkQDkXIJDyzzxdkVm6bXxytEWOuObx+bcGu4PeczMOpBoxfFZQsiw6Rgcescmtwr
         ffbzOVQRcGo+VOkYYnnF8zuXdKuvy1gwuC6R10JvZpIQuvexnV+1SJ7wfdwuepsTLuVR
         wzAQ==
X-Gm-Message-State: APjAAAWDxBx1HWnDjMCkEsO8lgn2c3+rAVwXSskhGWovip1gvyA1AnB4
        BEfk2nuPBAG11iee2nVPuJjfu3yC4qqvEBS+5fivrVk9Ur/F
X-Google-Smtp-Source: APXvYqxR/tYsvKiMqAC13+NvLqrNK+/RBaFWoLBWzH6xb58aCGAjHzGagS7p4kIYGN9dkrABIdKIHu9D/9WuZjUzVuwPN7Fxlm1g
MIME-Version: 1.0
X-Received: by 2002:a05:6638:63a:: with SMTP id h26mr1330802jar.92.1561378025312;
 Mon, 24 Jun 2019 05:07:05 -0700 (PDT)
Date:   Mon, 24 Jun 2019 05:07:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f19f7058c10a633@google.com>
Subject: KASAN: global-out-of-bounds Read in qmi_wwan_probe
From:   syzbot <syzbot+b68605d7fadd21510de1@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, bjorn@mork.no, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9939f56e usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1615a669a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df134eda130bb43a
dashboard link: https://syzkaller.appspot.com/bug?extid=b68605d7fadd21510de1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10630af6a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1127da69a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b68605d7fadd21510de1@syzkaller.appspotmail.com

usb 1-1: new high-speed USB device number 2 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 8
usb 1-1: New USB device found, idVendor=12d1, idProduct=14f1,  
bcdDevice=d4.d9
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
==================================================================
BUG: KASAN: global-out-of-bounds in qmi_wwan_probe+0x342/0x360  
drivers/net/usb/qmi_wwan.c:1417
Read of size 8 at addr ffffffff8618c140 by task kworker/1:1/22

CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.2.0-rc5+ #11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x67/0x231 mm/kasan/report.c:188
  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:317
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  qmi_wwan_probe+0x342/0x360 drivers/net/usb/qmi_wwan.c:1417
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
