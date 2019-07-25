Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1195FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC17218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfGYMIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:08:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43672 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfGYMIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:08:07 -0400
Received: by mail-io1-f71.google.com with SMTP id q26so54619338ioi.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5iOWbFmUgbFmOQl+e0WLrg0Wm3wQuk+35UzAKIvZNcs=;
        b=AMio+aaFBOJ1zXIpFBPqfhegZaZIq16qsA/E7cqTFe0aE3808mTsrwVt/Hews9alkQ
         SDnbBQknnnmnWCTfsqhn/Zge6a8Y2VGE2PWuNmJ3v1f/Zm/JdgFihZj1j8dQeE8jAwgN
         ZvTKOCs9QWHNI/c/ylQB5wf7KzBEUd5Azzjup+5Fgaa42Ok7Ij2Y99RsdJoz2IW3E8vn
         ASdFADNiIS9p1Ci50FjYakageDR/4DrpcERkPR2QGrCVJvqlk4jGdVcmXFz3XRguilhE
         dpFi1ZBkYEbp31tGBh2byrlUa1vkVJy7a4BLdsJ9qoPIEozN+hQTlqrVPurgKOfrqjc5
         PdCg==
X-Gm-Message-State: APjAAAWkPsAXdB7YJqFY7yLPuiG4mPwibp/lzFu0lkOU+3GQWs0gU8DD
        5kk48gz6k+aB20ScuNVoYc+129ulhl31/Yy4oLtU6odubpS6
X-Google-Smtp-Source: APXvYqwx/xWAbPxZtcDcyUsUFHrVA31iLlD3g/mgUsUOn851tRPVS6iJnokHo4oF1zXEoKoidChsmXBwAr1JLsmxfLLd7bNTSxAk
MIME-Version: 1.0
X-Received: by 2002:a02:c80d:: with SMTP id p13mr5363029jao.59.1564056486183;
 Thu, 25 Jul 2019 05:08:06 -0700 (PDT)
Date:   Thu, 25 Jul 2019 05:08:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000448f5a058e804752@google.com>
Subject: WARNING in __uwb_rc_neh_rm
From:   syzbot <syzbot+c44bb3aca1a5e07c76df@syzkaller.appspotmail.com>
To:     alexios.zavras@intel.com, allison@lohutok.net,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rfontana@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=17eb58cc600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
dashboard link: https://syzkaller.appspot.com/bug?extid=c44bb3aca1a5e07c76df
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ebb65c600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d95382600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c44bb3aca1a5e07c76df@syzkaller.appspotmail.com

------------[ cut here ]------------
list_del corruption, ffff8881d0a03130->next is LIST_POISON1  
(dead000000000100)
WARNING: CPU: 0 PID: 5 at lib/list_debug.c:45  
__list_del_entry_valid+0xd3/0x170 lib/list_debug.c:45
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.2.0-rc6+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x6c9 kernel/panic.c:219
  __warn.cold+0x20/0x4b kernel/panic.c:576
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:__list_del_entry_valid+0xd3/0x170 lib/list_debug.c:45
Code: 93 00 00 00 49 8b 55 08 48 39 f2 75 51 b8 01 00 00 00 48 83 c4 08 41  
5c 41 5d c3 4c 89 ea 48 c7 c7 40 0b ba 85 e8 c8 d1 33 ff <0f> 0b 48 83 c4  
08 31 c0 41 5c 41 5d c3 4c 89 e2 48 c7 c7 a0 0b ba
RSP: 0018:ffff8881d9dc6d80 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff8881d0a030c0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3b8da2
RBP: 0000000000000000 R08: ffff8881d9d8e000 R09: 0000000000000008
R10: fffffbfff0d5dc9c R11: ffffffff86aee4e3 R12: dead000000000200
R13: dead000000000100 R14: ffff8881d3eab830 R15: 00000000ffffffb9
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  __uwb_rc_neh_rm+0xc5/0x220 drivers/uwb/neh.c:243
  uwb_rc_neh_rm+0x30/0x60 drivers/uwb/neh.c:259
  uwb_rc_cmd_async+0x29a/0x310 drivers/uwb/reset.c:93
  __uwb_rc_cmd+0x10f/0x1e0 drivers/uwb/reset.c:171
  uwb_rc_cmd+0xc2/0x130 drivers/uwb/reset.c:220
  uwb_rc_reset+0x15e/0x218 drivers/uwb/reset.c:292
  uwb_rc_setup+0x84/0x320 drivers/uwb/lc-rc.c:282
  uwb_rc_add+0x246/0x42f drivers/uwb/lc-rc.c:351
  hwarc_probe+0x3ce/0x980 drivers/uwb/hwa-rc.c:843
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
  usb_new_device.cold+0x6a4/0xe61 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1abd/0x3550 drivers/usb/core/hub.c:5441
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
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
