Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483C4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2767A208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfICMJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:09:13 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45681 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbfICMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:08:10 -0400
Received: by mail-io1-f69.google.com with SMTP id k4so22663587iok.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 05:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9qcwAP8TyQOShBtKcIxQIZ1ZYBk9OO6jqYC8avhKSZk=;
        b=J4dyWGf2alDL1Ebjf2G+PF19V6F7wvzT0kv4t4wbIepAAD2Gkyblw7mIs+8H9EuPMC
         OWN8rlHZqnN+jbQaZzKCSYP0L5B+3N4KVO1NBeazX8ZJR19WYR9kVNwWHyKdRF79LkEH
         897ld/3JzfkJddDFOpMMPvJPa/zzqUjEWzrpAFeT02c2EjkIGBCmE814Wdj/J0hoZ0CP
         pvhufgTtP1lJQLJ6GQ++6DgT3g9oZveKUy6dZklUL8tj/tynBjLsg/PChVu7wUF2JDDG
         nsU6ASAAzsV0L3Ahcsh5IG0LlZLLRnHYwwESV9OwrU3piOOmurK7Sf1SKRK9JpbiYV7a
         sshw==
X-Gm-Message-State: APjAAAWPsAUl6fuLZ3afrIL+OgviyvACTUkwlJsWxahbZ8Svh48JlUaE
        i3drJ4vCNkeAoFiKzBo9fZajttPUi/EMsc0P06vREQVPsj3r
X-Google-Smtp-Source: APXvYqwwqbKTPGz2NUq7PxoNh2zfl4YgeuHzXT7I0s1vKHgyCKW1nN1WB7GOMBnQxAJTmXhKHLgkzswzbqEgK7KCFCwSVilEbmDL
MIME-Version: 1.0
X-Received: by 2002:a02:90cb:: with SMTP id c11mr14354446jag.104.1567512489540;
 Tue, 03 Sep 2019 05:08:09 -0700 (PDT)
Date:   Tue, 03 Sep 2019 05:08:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ec3580591a4f1ad@google.com>
Subject: WARNING: ODEBUG bug in appledisplay_probe
From:   syzbot <syzbot+5bb7a3b6f59db285e759@syzkaller.appspotmail.com>
To:     2pi@mok.nu, alex.theissen@me.com, andreyknvl@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=101b49ea600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=5bb7a3b6f59db285e759
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159cd5ea600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16717666600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5bb7a3b6f59db285e759@syzkaller.appspotmail.com

appledisplay 1-1:0.16: Error while getting initial brightness: -110
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint:  
delayed_work_timer_fn+0x0/0x90 include/linux/topology.h:80
WARNING: CPU: 0 PID: 12 at lib/debugobjects.c:481  
debug_print_object+0x160/0x250 lib/debugobjects.c:481
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0-rc5+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x2a3/0x6da kernel/panic.c:219
  __warn.cold+0x20/0x4a kernel/panic.c:576
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:debug_print_object+0x160/0x250 lib/debugobjects.c:481
Code: dd 80 ef da 85 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48  
8b 14 dd 80 ef da 85 48 c7 c7 c0 e4 da 85 e8 e5 dd 31 ff <0f> 0b 83 05 4b  
0f a8 05 01 48 83 c4 20 5b 5d 41 5c 41 5d c3 48 89
RSP: 0018:ffff8881da20f140 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81288cfd RDI: ffffed103b441e1a
RBP: 0000000000000001 R08: ffff8881da1f9800 R09: fffffbfff11ad79a
R10: fffffbfff11ad799 R11: ffffffff88d6bccf R12: ffffffff86d0dc60
R13: ffffffff812e7b70 R14: ffff8881d56f8f68 R15: ffff8881d4ee4578
  __debug_check_no_obj_freed lib/debugobjects.c:963 [inline]
  debug_check_no_obj_freed+0x2df/0x443 lib/debugobjects.c:994
  slab_free_hook mm/slub.c:1420 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0x20b/0x2f0 mm/slub.c:3957
  appledisplay_probe+0x772/0xb37 drivers/usb/misc/appledisplay.c:312
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
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
