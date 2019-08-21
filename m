Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD4FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFBE20644
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ei8A/Vrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfHUOKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:10:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37206 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfHUOKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:10:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id bj8so1410151plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91W+niEv0WVmZiALbnZljY1AEmpvTE5WjjWmApzWgws=;
        b=Ei8A/VrqJNaxWogf0kSzbXRLM1PuETnVyT/kWpMA0bQzXs+WTR4VPku+JXT5nejQDj
         3IFfur7TD31ZP8QU71uSA2zCFcHw3vPpdkgRGBIUiiPxlQWzfoDAuwoYEBKGsaVJDSke
         /2DqtACqhpk9GU/RdfMic4epwSfg3CYSVNfhGFMRcTnNw2zxptgvRr4F41lB+Kt2uYGU
         /sQM/lTBViuj6naxnXYm4C8rlN4tldULXI5PMdWImHX+DWdn0iffutdvrfWzGoyS05b0
         UGV9pxvyqmFnpIamWX+kQW5+DeyTCCCBwhumb2HbRTYdguwge9g1yOxfHseGYbC547Vq
         +WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91W+niEv0WVmZiALbnZljY1AEmpvTE5WjjWmApzWgws=;
        b=T8kzWnQgdMVv2+P8XiVnxCyrRqoYIEN+CfA7ygjd9oNN6M9WvguE73+7aQqfR3R0Gb
         455ZO5uSuwsm+kFd+n/sglWuDvEIpxhwOUf/5/Kq8lyOwUOzhG7L2odbpmOUEWm7y7m3
         J9zIuI/wJi9GLq+OHYF6b2G6wikzMmj9ALo9TSdis4Frif6JFcICTk1hDgShOAipX4kD
         fEGGIMixOxfXjGVsht5Jg3qiYLZOefISlMsGYbAmy4R2IHiRGPmYhdaErV+hSTWjZK2n
         6tWlmdozJPQqoqZ0zeWjFzzxmzhjwBYit5rmF8Wckm43slcXufD6hBPmwg5Ns2TlzgRp
         lFBQ==
X-Gm-Message-State: APjAAAWq9u47VGrAc/s6zKUCUEuxFTtYB/wkMb+3plKzjmztP5xmi9Sf
        J3Ra810xppt7id8WJhmAjC55AL9kOelXeCDCqrMbEQ==
X-Google-Smtp-Source: APXvYqxK+ApEEyxrw888Ur2Oy2D+0iAa/di4rkBrqE3p50khUcWy9sP6H2oqqnNe/VXvBAYxIOsTuI+5xF5Gw7TWhhw=
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr31535731plt.252.1566396615972;
 Wed, 21 Aug 2019 07:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+yEUO0f7qgTgWYRp0nv=LY2cX12=gK54yHzPkxZT0SyHQ@mail.gmail.com>
 <00000000000027b5750590a087dc@google.com>
In-Reply-To: <00000000000027b5750590a087dc@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 16:10:05 +0200
Message-ID: <CAAeHK+xS0zb9ya=s=CVJWwvhn6=4iLPBRSky9ZQjGWsnm8+GYw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in hidraw_ioctl
To:     syzbot <syzbot+ded1794a717e3b235226@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 3:27 PM syzbot
<syzbot+ded1794a717e3b235226@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer still triggered
> crash:
> KASAN: use-after-free Read in hidraw_ioctl

OK, so this looks like a different bug.

>
> ==================================================================
> BUG: KASAN: use-after-free in hidraw_ioctl+0x609/0xaf0
> drivers/hid/hidraw.c:380
> Read of size 4 at addr ffff8881d2db4218 by task syz-executor.1/3343
>
> CPU: 1 PID: 3343 Comm: syz-executor.1 Not tainted 5.2.0-rc6+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x67/0x231 mm/kasan/report.c:188
>   __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:317
>   kasan_report+0xe/0x20 mm/kasan/common.c:614
>   hidraw_ioctl+0x609/0xaf0 drivers/hid/hidraw.c:380
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   file_ioctl fs/ioctl.c:509 [inline]
>   do_vfs_ioctl+0xcda/0x12e0 fs/ioctl.c:696
>   ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
>   __do_sys_ioctl fs/ioctl.c:720 [inline]
>   __se_sys_ioctl fs/ioctl.c:718 [inline]
>   __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
>   do_syscall_64+0xb7/0x560 arch/x86/entry/common.c:301
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459829
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fac801dac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
> RDX: 00000000200015c0 RSI: 0000000080044801 RDI: 0000000000000005
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fac801db6d4
> R13: 00000000004c21ee R14: 00000000004d53f8 R15: 00000000ffffffff
>
> Allocated by task 2911:
>   save_stack+0x1b/0x80 mm/kasan/common.c:71
>   set_track mm/kasan/common.c:79 [inline]
>   __kasan_kmalloc mm/kasan/common.c:489 [inline]
>   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:462
>   kmalloc include/linux/slab.h:547 [inline]
>   kzalloc include/linux/slab.h:742 [inline]
>   hid_allocate_device+0x3e/0x480 drivers/hid/hid-core.c:2389
>   usbhid_probe+0x23e/0xfa0 drivers/hid/usbhid/hid-core.c:1321
>   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
>   really_probe+0x281/0x660 drivers/base/dd.c:509
>   driver_probe_device+0x104/0x210 drivers/base/dd.c:670
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:843
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2111
>   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
>   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
>   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
>   really_probe+0x281/0x660 drivers/base/dd.c:509
>   driver_probe_device+0x104/0x210 drivers/base/dd.c:670
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:843
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2111
>   usb_new_device.cold+0x6a4/0xe61 drivers/usb/core/hub.c:2536
>   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x1abd/0x3550 drivers/usb/core/hub.c:5441
>   process_one_work+0x905/0x1570 kernel/workqueue.c:2269
>   process_scheduled_works kernel/workqueue.c:2331 [inline]
>   worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
>   kthread+0x30b/0x410 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
> Freed by task 2895:
>   save_stack+0x1b/0x80 mm/kasan/common.c:71
>   set_track mm/kasan/common.c:79 [inline]
>   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:451
>   slab_free_hook mm/slub.c:1421 [inline]
>   slab_free_freelist_hook mm/slub.c:1448 [inline]
>   slab_free mm/slub.c:2994 [inline]
>   kfree+0xd7/0x280 mm/slub.c:3949
>   device_release+0x71/0x200 drivers/base/core.c:1064
>   kobject_cleanup lib/kobject.c:691 [inline]
>   kobject_release lib/kobject.c:720 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   kobject_put+0x171/0x280 lib/kobject.c:737
>   put_device+0x1b/0x30 drivers/base/core.c:2210
>   usbhid_disconnect+0x90/0xd0 drivers/hid/usbhid/hid-core.c:1413
>   usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
>   __device_release_driver drivers/base/dd.c:1081 [inline]
>   device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1112
>   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
>   device_del+0x460/0xb80 drivers/base/core.c:2274
>   usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
>   usb_disconnect+0x284/0x830 drivers/usb/core/hub.c:2199
>   hub_port_connect drivers/usb/core/hub.c:4949 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x13bd/0x3550 drivers/usb/core/hub.c:5441
>   process_one_work+0x905/0x1570 kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>   kthread+0x30b/0x410 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
> The buggy address belongs to the object at ffff8881d2db4200
>   which belongs to the cache kmalloc-8k of size 8192
> The buggy address is located 24 bytes inside of
>   8192-byte region [ffff8881d2db4200, ffff8881d2db6200)
> The buggy address belongs to the page:
> page:ffffea00074b6c00 refcount:1 mapcount:0 mapping:ffff8881dac02400
> index:0x0 compound_mapcount: 0
> flags: 0x200000000010200(slab|head)
> raw: 0200000000010200 ffffea0007176e00 0000000300000003 ffff8881dac02400
> raw: 0000000000000000 0000000000030003 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8881d2db4100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8881d2db4180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8881d2db4200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                              ^
>   ffff8881d2db4280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881d2db4300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
>
> Tested on:
>
> commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=1637707a600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=15db9586600000
>
