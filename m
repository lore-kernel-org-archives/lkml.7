Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142DCC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4C12171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gt02LVUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436954AbfHIRdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:33:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39249 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436858AbfHIRdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:33:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so42419023pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdTY+eLp9CDqeov8hrdEGv9xQZbS8aOvAH7TutoQpYk=;
        b=gt02LVUqRwBOG78dfy/Vxb7fnHkMsjaq6HdQwb7kEZquoStMI9uspNPowfBNxGqkAR
         hBEhN73FjfD9886I3Myd4kyYT83tj76ouCLZIkkSx7l2Mc8UU/ThLKwsiqieYBdlFwsa
         SkFJ4R93iuwIvcSzJWR0/yAZb3L0W1hjQx5S6LMlqTaPc4ZjBt5AXaZtJug+axUTJegx
         tuyvCVPorJ68M/76cmToQJC1MpufXMSNnTetgWYrlrotXuqyZjgYsMO1kcjNJKdELtrq
         b0cv7nBJgh9i3qoLv4Z6ZC2/Nka8gf/92CKuFlEWoT62lnNc6WU7kRncIxzkynsuZn06
         yDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdTY+eLp9CDqeov8hrdEGv9xQZbS8aOvAH7TutoQpYk=;
        b=ii+mFunx9rbFotYK/MCFOxfM7uUaUH09xrtXiCilXLOnAJvoMjQiiKPOmDjNylDGVh
         IW6tOoQ+5lZhTSrJ1abo8hONISHl5gBe+x3Vvp+ujC09qPlU8+LTJp18oZf+S6Zcb7RM
         cLOUAiZ2+FUoCvKsIlVKpcvL/yaRvLhkX50nGgH/FLguB1BvhacEzNECuIoE6hLSkIT6
         BK/lt+aIazTBr1Z9Ypff1rle6xOs8+P8FMcr7X2AhsefUVwYeBgnEafxBhXiWMNAfzDD
         1YE4pZvuZWTb1UxgzEFrySuBCpPAYu39IR1UsO7K6Kis9MWdOeX1n6IAsBuNFs1oPE3R
         Hxqg==
X-Gm-Message-State: APjAAAWX9JJIEFLt4unULeQTZht5QGwRyJItQac8ryuo9mBHMr0HtINq
        qij6Ce2MFx0VzGIPywFIuIc6BWjH2TkCcNbXQAvhQQ==
X-Google-Smtp-Source: APXvYqyAoLAYZ9FUOa6A5C2NcNmkmPc+SgV9frbxgwq1x5Vpm6GQVpVWfTyBsPsvCs9JQ2dtSjMnMp91IeEac/bYQuU=
X-Received: by 2002:a17:90a:a116:: with SMTP id s22mr10416489pjp.47.1565372015673;
 Fri, 09 Aug 2019 10:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000475ecc058faf017f@google.com> <Pine.LNX.4.44L0.1908091229540.1630-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1908091229540.1630-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 9 Aug 2019 19:33:23 +0200
Message-ID: <CAAeHK+wiwkC0SoGMvZgQ49dUbJE7ECpacXfPWpM4f9C84VY=zQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in ld_usb_release
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <greg@kroah.com>,
        syzbot <syzbot+30cf45ebfe0b0c4847a1@syzkaller.appspotmail.com>,
        bhelgaas@google.com, kirr@nexedi.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, lkundrak@v3.sk,
        logang@deltatee.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000f0213d058fb29217"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f0213d058fb29217
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 9, 2019 at 6:51 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
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

This report has a reproducer, so we can try it:

#syz test: https://github.com/google/kasan.git e96407b4

>
> Alan Stern
>
>
>  drivers/usb/core/file.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Index: usb-devel/drivers/usb/core/file.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/core/file.c
> +++ usb-devel/drivers/usb/core/file.c
> @@ -193,9 +193,10 @@ int usb_register_dev(struct usb_interfac
>                 intf->minor = minor;
>                 break;
>         }
> -       up_write(&minor_rwsem);
> -       if (intf->minor < 0)
> +       if (intf->minor < 0) {
> +               up_write(&minor_rwsem);
>                 return -EXFULL;
> +       }
>
>         /* create a usb class device for this usb interface */
>         snprintf(name, sizeof(name), class_driver->name, minor - minor_base);
> @@ -203,12 +204,11 @@ int usb_register_dev(struct usb_interfac
>                                       MKDEV(USB_MAJOR, minor), class_driver,
>                                       "%s", kbasename(name));
>         if (IS_ERR(intf->usb_dev)) {
> -               down_write(&minor_rwsem);
>                 usb_minors[minor] = NULL;
>                 intf->minor = -1;
> -               up_write(&minor_rwsem);
>                 retval = PTR_ERR(intf->usb_dev);
>         }
> +       up_write(&minor_rwsem);
>         return retval;
>  }
>  EXPORT_SYMBOL_GPL(usb_register_dev);
> @@ -234,12 +234,12 @@ void usb_deregister_dev(struct usb_inter
>                 return;
>
>         dev_dbg(&intf->dev, "removing %d minor\n", intf->minor);
> +       device_destroy(usb_class->class, MKDEV(USB_MAJOR, intf->minor));
>
>         down_write(&minor_rwsem);
>         usb_minors[intf->minor] = NULL;
>         up_write(&minor_rwsem);
>
> -       device_destroy(usb_class->class, MKDEV(USB_MAJOR, intf->minor));
>         intf->usb_dev = NULL;
>         intf->minor = -1;
>         destroy_usb_class();
>

--000000000000f0213d058fb29217
Content-Type: text/x-patch; charset="US-ASCII"; name="usb_core_file.patch"
Content-Disposition: attachment; filename="usb_core_file.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jz4e1yt50>
X-Attachment-Id: f_jz4e1yt50

SW5kZXg6IHVzYi1kZXZlbC9kcml2ZXJzL3VzYi9jb3JlL2ZpbGUuYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSB1
c2ItZGV2ZWwub3JpZy9kcml2ZXJzL3VzYi9jb3JlL2ZpbGUuYworKysgdXNiLWRldmVsL2RyaXZl
cnMvdXNiL2NvcmUvZmlsZS5jCkBAIC0xOTMsOSArMTkzLDEwIEBAIGludCB1c2JfcmVnaXN0ZXJf
ZGV2KHN0cnVjdCB1c2JfaW50ZXJmYWMKIAkJaW50Zi0+bWlub3IgPSBtaW5vcjsKIAkJYnJlYWs7
CiAJfQotCXVwX3dyaXRlKCZtaW5vcl9yd3NlbSk7Ci0JaWYgKGludGYtPm1pbm9yIDwgMCkKKwlp
ZiAoaW50Zi0+bWlub3IgPCAwKSB7CisJCXVwX3dyaXRlKCZtaW5vcl9yd3NlbSk7CiAJCXJldHVy
biAtRVhGVUxMOworCX0KIAogCS8qIGNyZWF0ZSBhIHVzYiBjbGFzcyBkZXZpY2UgZm9yIHRoaXMg
dXNiIGludGVyZmFjZSAqLwogCXNucHJpbnRmKG5hbWUsIHNpemVvZihuYW1lKSwgY2xhc3NfZHJp
dmVyLT5uYW1lLCBtaW5vciAtIG1pbm9yX2Jhc2UpOwpAQCAtMjAzLDEyICsyMDQsMTEgQEAgaW50
IHVzYl9yZWdpc3Rlcl9kZXYoc3RydWN0IHVzYl9pbnRlcmZhYwogCQkJCSAgICAgIE1LREVWKFVT
Ql9NQUpPUiwgbWlub3IpLCBjbGFzc19kcml2ZXIsCiAJCQkJICAgICAgIiVzIiwga2Jhc2VuYW1l
KG5hbWUpKTsKIAlpZiAoSVNfRVJSKGludGYtPnVzYl9kZXYpKSB7Ci0JCWRvd25fd3JpdGUoJm1p
bm9yX3J3c2VtKTsKIAkJdXNiX21pbm9yc1ttaW5vcl0gPSBOVUxMOwogCQlpbnRmLT5taW5vciA9
IC0xOwotCQl1cF93cml0ZSgmbWlub3JfcndzZW0pOwogCQlyZXR2YWwgPSBQVFJfRVJSKGludGYt
PnVzYl9kZXYpOwogCX0KKwl1cF93cml0ZSgmbWlub3JfcndzZW0pOwogCXJldHVybiByZXR2YWw7
CiB9CiBFWFBPUlRfU1lNQk9MX0dQTCh1c2JfcmVnaXN0ZXJfZGV2KTsKQEAgLTIzNCwxMiArMjM0
LDEyIEBAIHZvaWQgdXNiX2RlcmVnaXN0ZXJfZGV2KHN0cnVjdCB1c2JfaW50ZXIKIAkJcmV0dXJu
OwogCiAJZGV2X2RiZygmaW50Zi0+ZGV2LCAicmVtb3ZpbmcgJWQgbWlub3JcbiIsIGludGYtPm1p
bm9yKTsKKwlkZXZpY2VfZGVzdHJveSh1c2JfY2xhc3MtPmNsYXNzLCBNS0RFVihVU0JfTUFKT1Is
IGludGYtPm1pbm9yKSk7CiAKIAlkb3duX3dyaXRlKCZtaW5vcl9yd3NlbSk7CiAJdXNiX21pbm9y
c1tpbnRmLT5taW5vcl0gPSBOVUxMOwogCXVwX3dyaXRlKCZtaW5vcl9yd3NlbSk7CiAKLQlkZXZp
Y2VfZGVzdHJveSh1c2JfY2xhc3MtPmNsYXNzLCBNS0RFVihVU0JfTUFKT1IsIGludGYtPm1pbm9y
KSk7CiAJaW50Zi0+dXNiX2RldiA9IE5VTEw7CiAJaW50Zi0+bWlub3IgPSAtMTsKIAlkZXN0cm95
X3VzYl9jbGFzcygpOwo=
--000000000000f0213d058fb29217--
