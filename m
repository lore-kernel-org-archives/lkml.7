Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97683C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778862054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404048AbfFKOpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:45:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48893 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389454AbfFKOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:45:06 -0400
Received: by mail-io1-f70.google.com with SMTP id z19so10144727ioi.15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 07:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tUob3QbIRa6wmkeEyy9XTsPmW1BG3WSB6d8B47p1jt4=;
        b=aMzRwxAPc8C6VtcP2nI/X3/4kE+XZWH/fNr+dImrVgvJmn0wbLt+VUWXiftqS4RTcM
         0DoQsxzUt8eYmGflXiNz2MFAuiUAhD1d44EIEEuaAFxte+bFZvMM2KHRsaO3zqMOTgvi
         QxP014v4Nyv8f0Y06yftGhSkbMpSItqfaAYmPfaFEJUhPPrb8C2VCZoLHpyEMfKi0mPW
         rojpg2lAdgh4XQXi5oyDy9sHDxZaG4vqufhcDJ2RFIa7eYueO51bpeQzWoyCvWo0Yq4e
         x14/6t+O8ORIYcy6bY0LZD8lhyHvvXF5ET3ch0h6qgt4SzEYjWOM5VkkaNzuLk13xmjj
         VXAQ==
X-Gm-Message-State: APjAAAWm165qLC9e1N1E9n93vW+njnlFCREjnJmEGeOzwiJEj10jR1Aw
        BCDVX7I39Q48vXBdbUFAq+emjf8hbAskqpQwwfimLcz5ZyzQ
X-Google-Smtp-Source: APXvYqxUcaF8F+lxr/TKjqHdPHFrKqils+BWR4nhGGnebCV9hedlRnvZhYOzFq7Ue1OI/ANoVAi7xOOXefcmoubboxrhAswxLEnK
MIME-Version: 1.0
X-Received: by 2002:a02:b817:: with SMTP id o23mr34272047jam.134.1560264305324;
 Tue, 11 Jun 2019 07:45:05 -0700 (PDT)
Date:   Tue, 11 Jun 2019 07:45:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000acb99a058b0d5741@google.com>
Subject: WARNING in snd_usb_motu_microbookii_communicate/usb_submit_urb
From:   syzbot <syzbot+d952e5e28f5fb7718d23@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=111aabfea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=193d8457178b3229
dashboard link: https://syzkaller.appspot.com/bug?extid=d952e5e28f5fb7718d23
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e71f51a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d952e5e28f5fb7718d23@syzkaller.appspotmail.com

usb 2-1: Waiting for MOTU Microbook II to boot up...
------------[ cut here ]------------
usb 2-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 2059 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 2059 Comm: kworker/0:2 Not tainted 5.2.0-rc1+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x6c9 kernel/panic.c:218
  __warn.cold+0x20/0x4b kernel/panic.c:575
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 b8 06 e9 fd 4c 89 f7 e8 c0 44 13 ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 20 1c 1a 86 e8 03 db be fd <0f> 0b e9 20 f4  
ff ff e8 8c 06 e9 fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881cdba6dc0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127e98d RDI: ffffed1039b74daa
RBP: ffff8881d7b3bb80 R08: ffff8881ccffc800 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8881d9159510 R14: ffff8881d0f61a20 R15: ffff8881d0a28000
  usb_start_wait_urb+0x108/0x2b0 drivers/usb/core/message.c:57
  usb_bulk_msg+0x228/0x550 drivers/usb/core/message.c:253
  snd_usb_motu_microbookii_communicate.constprop.0+0xe3/0x240  
sound/usb/quirks.c:1011
  snd_usb_motu_microbookii_boot_quirk sound/usb/quirks.c:1051 [inline]
  snd_usb_apply_boot_quirk.cold+0x140/0x36b sound/usb/quirks.c:1280
  usb_audio_probe+0x2ec/0x2010 sound/usb/card.c:590
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
  process_one_work+0x905/0x1570 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30b/0x410 kernel/kthread.c:254
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
