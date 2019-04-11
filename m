Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A72C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455AF2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfDKX3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:29:12 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:51984 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKX3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:29:12 -0400
Received: by mail-it1-f200.google.com with SMTP id y127so7457707itb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 16:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=c9eqkMlMXJKYNsd2gPtF4r6eghDdcc2KpRiU+4OfLtA=;
        b=iSJM02zXDg/qSbo8hV6gj+labGT0yfwqwKdtAQfSBBvAFqO09IdoNYr75w58NS96KN
         1rfoZY/PGgs3+WW1T0RHrrd7gRr0Cc6W0tIKvJOIqrNba0CYPBBQ4ApiCFnhSpQ3A41T
         xGlThkPiy+7zmMY4ubqsSstG+447kdnsngTp6UYsVdXpWoblHwhSW0g6Vv05JhR5xlfc
         N6KZKhO55cuLrY4EeL6DJ7BkK5os8BYVXE5ETsZ87toWdbO7iqdQAjvzndOAjVEQAD3U
         /3OFFbJOqfZLSsB/tdchMbL43sv3YNQSXhZXwmMUonbzq9kIKCibIHsEF8yfqqCBRMlu
         uTxQ==
X-Gm-Message-State: APjAAAWtoiQl7G37Z/oWvB2pm5XawixdO+XWk/rBjotridIgurQEpHwC
        WFLBJoOBXsH3Pz9g3me8iAehaZoLBHO2cVRlkL6cib9fpfxM
X-Google-Smtp-Source: APXvYqy99V5GU2vWlocx20k91er73FCjR6HmV9VIemH+UtGtveSh31T4ne5l6gixkmcvWs6Id/bZCV71qEyidyVg+njbN+RUdrra
MIME-Version: 1.0
X-Received: by 2002:a6b:4402:: with SMTP id r2mr999941ioa.30.1555025351684;
 Thu, 11 Apr 2019 16:29:11 -0700 (PDT)
Date:   Thu, 11 Apr 2019 16:29:11 -0700
In-Reply-To: <000000000000d9f094057a17b97b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b439370586498dff@google.com>
Subject: Re: WARNING in rollback_registered_many (2)
From:   syzbot <syzbot+40918e4d826fb2ff9b96@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, andreyknvl@google.com,
        avagin@virtuozzo.com, davem@davemloft.net,
        devel@driverdev.osuosl.org, ebiederm@xmission.com,
        edumazet@google.com, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, kai.heng.feng@canonical.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=10d552b7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=40918e4d826fb2ff9b96
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a4c1af200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121b274b200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+40918e4d826fb2ff9b96@syzkaller.appspotmail.com

usb 1-1: r8712u: MAC Address from efuse = 00:e0:4c:87:00:00
usb 1-1: r8712u: Loading firmware from "rtlwifi/rtl8712u.bin"
usb 1-1: USB disconnect, device number 2
usb 1-1: Direct firmware load for rtlwifi/rtl8712u.bin failed with error -2
usb 1-1: r8712u: Firmware request failed
WARNING: CPU: 0 PID: 575 at net/core/dev.c:8152  
rollback_registered_many+0x1f3/0xe70 net/core/dev.c:8152
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 575 Comm: kworker/0:4 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  panic+0x29d/0x5f2 kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x130/0x1f0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:rollback_registered_many+0x1f3/0xe70 net/core/dev.c:8152
Code: 05 00 00 31 ff 44 89 fe e8 5a 15 f3 f4 45 84 ff 0f 85 49 ff ff ff e8  
1c 14 f3 f4 0f 1f 44 00 00 e8 12 14 f3 f4 e8 0d 14 f3 f4 <0f> 0b 4c 89 e7  
e8 33 72 f2 f6 31 ff 41 89 c4 89 c6 e8 27 15 f3 f4
RSP: 0018:ffff88809d087698 EFLAGS: 00010293
RAX: ffff88809d058000 RBX: ffff888096240000 RCX: ffffffff8c7eb146
RDX: 0000000000000000 RSI: ffffffff8c7eb163 RDI: 0000000000000001
RBP: ffff88809d0877c8 R08: ffff88809d058000 R09: fffffbfff2708111
R10: fffffbfff2708110 R11: ffffffff93840887 R12: ffff888096240070
R13: dffffc0000000000 R14: ffff88809d087758 R15: 0000000000000000
  rollback_registered+0xf7/0x1c0 net/core/dev.c:8228
  unregister_netdevice_queue net/core/dev.c:9275 [inline]
  unregister_netdevice_queue+0x1dc/0x2b0 net/core/dev.c:9268
  unregister_netdevice include/linux/netdevice.h:2655 [inline]
  unregister_netdev+0x1d/0x30 net/core/dev.c:9316
  r871xu_dev_remove+0xe7/0x223 drivers/staging/rtl8712/usb_intf.c:604
  usb_unbind_interface+0x1c9/0x980 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1082 [inline]
  device_release_driver_internal+0x436/0x4f0 drivers/base/dd.c:1113
  bus_remove_device+0x302/0x5c0 drivers/base/bus.c:556
  device_del+0x467/0xb90 drivers/base/core.c:2269
  usb_disable_device+0x242/0x790 drivers/usb/core/message.c:1235
  usb_disconnect+0x298/0x870 drivers/usb/core/hub.c:2197
  hub_port_connect drivers/usb/core/hub.c:4940 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0xcd2/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..

