Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC8C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC5A207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbfJCT7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:59:09 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:51214 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbfJCT7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:59:09 -0400
Received: by mail-io1-f72.google.com with SMTP id x13so6909438ioa.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 12:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7ds/2si/BzP0N7QbxssLjIqM/liqQB0WfI0eXD3isW0=;
        b=oRooxH6bZrJF3jrvAHCkMTwol/r+lxTQUqoCQulOQkdXj39OL2JpDdm0jMyE8VBYLO
         I9E79N17Zey4usx32Yg6xzosWRzG3j8OAn5u1tzCEOJEhE2BAzgcMeOdaXWDJ7fqomkI
         SdXHDmP+f0KDCr8MAzsSSu11BkR4XI35IWqGZm11fM7O4hs6DEhJErlBp2LbE6u4Kg/4
         fFvmqGbEH112gQ/gKXyVkN6VKdC1Poft6wsIMt1EkV+q6sY68+CYyMfkH2Z78z52eaL8
         /eRwqT+HxN9FxSTen9sv6+e7R7h/juSqCbEkp+YMwkN1OoogmMA151UC/XUwSWoCrAJJ
         TGgQ==
X-Gm-Message-State: APjAAAXeJmjmDZ2RPcOCwqCIuCft+Gf9W/pGwP8wUCmfg14nfydeXpyL
        qgL2xP8L8a7PV1CksJR0TVgiA2fklLDFvDuBRyP1e88ky3LY
X-Google-Smtp-Source: APXvYqxSvzHU1Nes06xd7cOaIg5JeK06DcdHiK31nkd5G2LFLWGdSa9stksNPlrz429TiM7KIggt8LtBxBBbsAKG1FSHzbIQFi77
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4ce:: with SMTP id f14mr11496186ils.278.1570132748264;
 Thu, 03 Oct 2019 12:59:08 -0700 (PDT)
Date:   Thu, 03 Oct 2019 12:59:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5ec8b0594070456@google.com>
Subject: KMSAN: uninit-value in iowarrior_disconnect
From:   syzbot <syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    014077b5 DO-NOT-SUBMIT: usb-fuzzer: main usb gadget fuzzer..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=108eae5e600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
dashboard link: https://syzkaller.appspot.com/bug?extid=0761012cebf7bdb38137
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15161d99600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13632e3a600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in iowarrior_disconnect+0x27a/0x3e0  
drivers/usb/misc/iowarrior.c:884
CPU: 0 PID: 11102 Comm: kworker/0:5 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  iowarrior_disconnect+0x27a/0x3e0 drivers/usb/misc/iowarrior.c:884
  usb_unbind_interface+0x3a2/0xdd0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1120 [inline]
  device_release_driver_internal+0x911/0xd20 drivers/base/dd.c:1151
  device_release_driver+0x4b/0x60 drivers/base/dd.c:1174
  bus_remove_device+0x4bf/0x670 drivers/base/bus.c:556
  device_del+0xcd5/0x1d10 drivers/base/core.c:2339
  usb_disable_device+0x567/0x1150 drivers/usb/core/message.c:1241
  usb_disconnect+0x51e/0xd60 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:4949 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x3fd0/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:189 [inline]
  kmsan_internal_poison_shadow+0x58/0xb0 mm/kmsan/kmsan.c:148
  kmsan_slab_free+0x8d/0x100 mm/kmsan/kmsan_hooks.c:195
  slab_free_freelist_hook mm/slub.c:1472 [inline]
  slab_free mm/slub.c:3038 [inline]
  kfree+0x4c1/0x2db0 mm/slub.c:3980
  iowarrior_delete drivers/usb/misc/iowarrior.c:246 [inline]
  iowarrior_release+0x334/0x3a0 drivers/usb/misc/iowarrior.c:670
  __fput+0x4c9/0xba0 fs/file_table.c:280
  ____fput+0x37/0x40 fs/file_table.c:313
  task_work_run+0x22e/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop arch/x86/entry/common.c:163 [inline]
  prepare_exit_to_usermode+0x39d/0x4d0 arch/x86/entry/common.c:194
  syscall_return_slowpath+0x90/0x610 arch/x86/entry/common.c:274
  do_syscall_64+0xe2/0xf0 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
