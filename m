Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BC42070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="J8c6N4Ou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l4WFZw/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfHLPbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:31:05 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48105 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727159AbfHLPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:31:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 539A41FE0;
        Mon, 12 Aug 2019 11:31:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 12 Aug 2019 11:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=e04r69EIO/jLHINnl6gw/xBW4U8
        eoNwEqnQOQ7/1wqs=; b=J8c6N4OupEtY0ByP6XZ/TZXepV+rzTuHnLNc8hBfeQV
        CsdCKZ8VihgLXJ+50rDqr2nAMamuik+yVBjiZFi/J4RPeiLg7XDMlq/b17ytN6Le
        oFii8yzrerpehkF4O1Dhdz3tNJ9BYc7nH26L0tXgY1slmc+Q6DaLnAqJeg87ZPNE
        96ZtHDJFKt7R0wAQ4CXV5cDP8PeZjQH0g/BT8by9KdzVjyTNxCt9SN1SP7Et9kbf
        q0ktG7EYKRMB9aynvRYQ7U+kwpSsPnn63nVwnjzbhF0H72VckHQ7S+uMRJFAIcVJ
        ba3KEjVA4WhEfVu7EUSsvTCd2wW6uxBJkdVu8KrSQpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=e04r69
        EIO/jLHINnl6gw/xBW4U8eoNwEqnQOQ7/1wqs=; b=l4WFZw/yDLaNLu0xLyF8RV
        T2pnkfIcR0cIUoG+fuEus4fMV9rlUnCLDdNbchUx73Cxyd8/gpF+v8JJXRpK+BoE
        U3GO6cEPvZf4LmMVpbCvpgzhsHEK2osSjRSFnLumMtOkYa0FRROfOfYb49AEvGzW
        /gtXOEMOPovIoJRco6B8Ixol80j698aVIa/TXF2UtDkvJt5p+OJOhVfbn+/ujCwx
        9ti63D3T1QbyFoPK/Fq6aSjYA7grjpnUcd3xuCY8bNUTZ+CbcRH1B6ltDD7srl0/
        /Bw4chemGgxRVd3SVpBbhA3U/+Nkbmmnk7Gr5/bS0WnGNPlWv5XoKh8ShsFSi5Cg
        ==
X-ME-Sender: <xms:NoZRXSb2Un_wwS1urebHVKYt1zuKo4ir13-9HLSmtTE_O_vauHgwiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvgedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    fgesthdtredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhh
    drtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprghpphhsphhothdrtgho
    mhenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:NoZRXZrnpT_BFmCiCMH4hImxmYTIIjhIzhI4Pr42TXW3wFNSfK8Q7Q>
    <xmx:NoZRXX_lWvfPpgG1a7ZmuMrs2THHwhZViAU0iSLElyWckg6w8TZ4Ew>
    <xmx:NoZRXY_a9r06GWuQ4Zac8xiMtHqGuAeFeaD_chEL7xnYah7pR-RrgQ>
    <xmx:N4ZRXQkn4vhJR6ycIY_G_t8JtWOOxPwUTpDRBRo1gr9mSnjwDYDLKQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85D47380074;
        Mon, 12 Aug 2019 11:31:01 -0400 (EDT)
Date:   Mon, 12 Aug 2019 17:31:00 +0200
From:   Greg KH <greg@kroah.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+30cf45ebfe0b0c4847a1@syzkaller.appspotmail.com>,
        andreyknvl@google.com, bhelgaas@google.com, kirr@nexedi.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, linux@roeck-us.net,
        lkundrak@v3.sk, logang@deltatee.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in ld_usb_release
Message-ID: <20190812153100.GA28429@kroah.com>
References: <000000000000475ecc058faf017f@google.com>
 <Pine.LNX.4.44L0.1908091229540.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1908091229540.1630-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 12:51:00PM -0400, Alan Stern wrote:
> Greg:
> 
> See below...
> 
> On Fri, 9 Aug 2019, syzbot wrote:
> 
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15a16f26600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=30cf45ebfe0b0c4847a1
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1416df26600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ce511c600000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+30cf45ebfe0b0c4847a1@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: use-after-free in __mutex_lock_common  
> > kernel/locking/mutex.c:912 [inline]
> > BUG: KASAN: use-after-free in __mutex_lock+0xf23/0x1360  
> > kernel/locking/mutex.c:1077
> > Read of size 8 at addr ffff8881d21fc2d8 by task syz-executor834/1878
> > 
> > CPU: 0 PID: 1878 Comm: syz-executor834 Not tainted 5.3.0-rc2+ #25
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   print_address_description+0x6a/0x32c mm/kasan/report.c:351
> >   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
> >   kasan_report+0xe/0x12 mm/kasan/common.c:612
> >   __mutex_lock_common kernel/locking/mutex.c:912 [inline]
> >   __mutex_lock+0xf23/0x1360 kernel/locking/mutex.c:1077
> >   ld_usb_release+0xb1/0x400 drivers/usb/misc/ldusb.c:386
> >   __fput+0x2d7/0x840 fs/file_table.c:280
> >   task_work_run+0x13f/0x1c0 kernel/task_work.c:113
> >   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
> >   exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
> >   prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
> >   syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
> >   do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x406b31
> > Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48  
> > 83 ec 08 e8 6a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
> > 89 c2 e8 b3 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> > RSP: 002b:00007ffcf13bd080 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> > RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000406b31
> > RDX: fffffffffffffff7 RSI: 0000000000000080 RDI: 0000000000000004
> > RBP: 0000000000000159 R08: 0000000000000020 R09: 0000000000000020
> > R10: 00007ffcf13bd0b0 R11: 0000000000000293 R12: 000000000001d884
> > R13: 0000000000000004 R14: 00000000006e39ec R15: 0000000000000064
> > 
> > Allocated by task 1775:
> >   save_stack+0x1b/0x80 mm/kasan/common.c:69
> >   set_track mm/kasan/common.c:77 [inline]
> >   __kasan_kmalloc mm/kasan/common.c:487 [inline]
> >   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
> >   kmalloc include/linux/slab.h:552 [inline]
> >   kzalloc include/linux/slab.h:748 [inline]
> >   ld_usb_probe+0x6e/0xa65 drivers/usb/misc/ldusb.c:661
> >   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
> >   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
> >   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
> >   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
> >   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> >   kthread+0x318/0x420 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > 
> > Freed by task 1775:
> >   save_stack+0x1b/0x80 mm/kasan/common.c:69
> >   set_track mm/kasan/common.c:77 [inline]
> >   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
> >   slab_free_hook mm/slub.c:1423 [inline]
> >   slab_free_freelist_hook mm/slub.c:1470 [inline]
> >   slab_free mm/slub.c:3012 [inline]
> >   kfree+0xe4/0x2f0 mm/slub.c:3953
> >   ld_usb_probe+0x728/0xa65 drivers/usb/misc/ldusb.c:744
> >   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
> >   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
> >   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
> >   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
> >   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> >   kthread+0x318/0x420 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > 
> > The buggy address belongs to the object at ffff8881d21fc280
> >   which belongs to the cache kmalloc-512 of size 512
> > The buggy address is located 88 bytes inside of
> >   512-byte region [ffff8881d21fc280, ffff8881d21fc480)
> > The buggy address belongs to the page:
> > page:ffffea0007487f00 refcount:1 mapcount:0 mapping:ffff8881da002500  
> > index:0x0 compound_mapcount: 0
> > flags: 0x200000000010200(slab|head)
> > raw: 0200000000010200 ffffea000739fc80 0000000900000009 ffff8881da002500
> > raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> > 
> > Memory state around the buggy address:
> >   ffff8881d21fc180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8881d21fc200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > ffff8881d21fc280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                                      ^
> >   ffff8881d21fc300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8881d21fc380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> 
> I have tracked this bug down.  The root causes lie in 
> usb_register_dev() and usb_deregister_dev().
> 
> The first problem is that usb_deregister_dev() sets 
> usb_minors[intf->minor] to NULL before calling device_destroy() on the 
> class device.  This leaves a window during which another thread can 
> allocate the same minor number but will encounter a duplicate name 
> error when it tries to register its own class device.
> 
> This error shows up in the kernel log from the syzbot test (not shown 
> in the bug report above, though):
> 
> [  120.583776][ T1775] sysfs: cannot create duplicate filename '/class/usbmisc/ldusb0'
> 
> This can be fixed easily enough by reordering the statements in 
> usb_deregister_dev().
> 
> The second problem is in usb_register_dev().  When that routine runs,
> it first allocates a minor number, then drops minor_rwsem, and then
> creates the class device.  If the device creation fails, the minor
> number is deallocated and the whole routine returns an error.  But
> during the time while minor_rwsem was dropped, there is a window in
> which the minor number is allocated and so another thread could
> successfully open the device file!
> 
> These two scenarios are exactly what happened during the syzbot test.  
> Minor number 0 was deallocated and then allocated in another thread.  
> The second allocation failed because the old class device was still in
> existence.  As a result of this failure, ldusb's private data structure
> was released.  Nevertheless, a third thread managed to open the device
> file during the brief time that minor number 0 was re-allocated.  When
> that thread closed the file, it tried to access the private data
> structure that had already been released.
> 
> I believe the patch below will fix both problems.  But you should take
> a look at it first to see if it seems right; syzbot can't really test
> the patch because it involves two separate races both coming out wrong!

Ugh, nasty races, good find.  Your fixes look fine, feel free to turn
this into a patch I can submit and I will do so.

thanks for finding this!

greg k-h
