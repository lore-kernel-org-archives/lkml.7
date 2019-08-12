Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE08C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1109A208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsR5Qy28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfHLOzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:55:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45870 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfHLOzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:55:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so4544319pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0NX7tgWDGZ9ngM3V05e48kG74w3SJCSqRcsvoU8o/o=;
        b=bsR5Qy28E4Ng2CHBknQiYPRihhFkIW6nm1MCKFncBWztXroY4Uq6htNDhNbOPQKo4X
         po+tQD9/Sk1VvZaJHsnzEvCfo4L8F58Y79fM/zTOvjxrfV+ZvwIRVNQNiQD0gzqhIkWJ
         oswcF6r1HuHDBrUINE0jwLh/h6qrB/CyYrsDTZ8FWOZvtDDMC1Bd53Wxeq+iGyMmQ4wE
         jUGsJTYYfWSY/wVUlzlfmXJC1TnQpDhQusBUjvjEw1WqRu1fQ/UBObAEBMaB1TWnnEn7
         qJwIiSPI9uZT8PWmW8LI4rfEJvzUBDvfrsqjyftjlXceD7UeVr7iZmawOI53escOk0Yb
         eG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0NX7tgWDGZ9ngM3V05e48kG74w3SJCSqRcsvoU8o/o=;
        b=IpUxUP91wwrihHLzYQ+vq0Ecg8q12lQaGjT3VY36TgatnwrJdef5EZ+tK82KWm5xwJ
         klViyD1T8JtoTJpsXdtUN8iW1hKlnw+kN+96YyWQWL9v1edRRdp/2SbH85Tk8H4QL1S6
         hewJ61HKYQ0JEDomZJSha16BnQcMPd7VR0uAorD5Uq7sAkgoznCIoNkSIRVGLw/aV8XQ
         GReQpjXW3egdjU26S+pbZiiWQv5YvM8zNORWC4pc9VKzOyRZYi8kIPqe5IVnMqnuOJ+P
         E/z1lDTNbb+lV7mySnt7NgpK6w2Sq825SJeKlWmC9pa4uvsd4SD5eQisqJ5j3SWjbGmP
         G/2Q==
X-Gm-Message-State: APjAAAUHbfS531c8aikneGwJlK4Fou2Vfmnij5p8V/zfvtxPoWWoN9Hv
        qCrM96TBxSQ78b0uTJNZ7/GIDJAzNlM4SzsR1jn2jQ==
X-Google-Smtp-Source: APXvYqzCdGsY2FAhSZiXYcGWWjbR8WFmcRAfdNIHo2yX3tIquionJkEM3XUrzE6c4P6cXAdqudq/ERyXXrOadRLzOKc=
X-Received: by 2002:a63:3006:: with SMTP id w6mr30875068pgw.440.1565621734288;
 Mon, 12 Aug 2019 07:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+z-uCr-bWu9uVDynU2S=wCrtxRbuA-Cut=h5zYuYcS-Cw@mail.gmail.com>
 <20190812144720.1980-1-hdanton@sina.com>
In-Reply-To: <20190812144720.1980-1-hdanton@sina.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 12 Aug 2019 16:55:22 +0200
Message-ID: <CAAeHK+ytb_9Rin=9b6y35MQ8m=03hL5v729nrP0kVAKExiGgXA@mail.gmail.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 4:47 PM Hillf Danton <hdanton@sina.com> wrote:
>
>
> Hi Andrey
>
> On Mon, 12 Aug 2019 06:03:01 -0700
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer still triggered
> > crash:
> > KASAN: invalid-free in hcd_buffer_free
> >
> > usb 5-1: USB disconnect, device number 2
> > ==================================================================
> > BUG: KASAN: double-free or invalid-free in hcd_buffer_free+0x199/0x260
> > drivers/usb/core/buffer.c:165
>
> JFYI:
> 1, the hid-core.patch in the attachment at
> https://lore.kernel.org/lkml/CAAeHK+z-uCr-bWu9uVDynU2S=wCrtxRbuA-Cut=h5zYuYcS-Cw@mail.gmail.com/
>
> ===quote begin===
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com
>
> Let's try Hillf's patch here as well:
>
> #syz test: https://github.com/google/kasan.git 7f7867ff

Remove # when quoting syzbot commands, as this will trigger syzbot
testing again =)

>
> >
> > ------------[ cut here ]------------
> > usb 2-1: BOGUS urb xfer, pipe 2 != type 2
> > WARNING: CPU: 1 PID: 7429 at drivers/usb/core/urb.c:477
> > usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> ===quote end===
>
> is identical to the patch for
> #syz test: https://github.com/google/kasan.git 6a3599ce
> Reported-by: syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com
>
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1410,6 +1410,7 @@ static void usbhid_disconnect(struct usb
>         spin_lock_irq(&usbhid->lock);   /* Sync with error and led handlers */
>         set_bit(HID_DISCONNECTED, &usbhid->iofl);
>         spin_unlock_irq(&usbhid->lock);
> +       hid_hw_stop(hid);
>         hid_destroy_device(hid);
>         kfree(usbhid);
>  }
>
>
> 2, based on the report itself in the quote section above,
>
>         > usb 2-1: BOGUS urb xfer, pipe 2 != type 2
>
> I suggest that we get it invalidated for now. If unfortunately it comes
> up again we know at least what once happened.
>
> 3, this is a new report I did not see before, and worth a new report
> thread with a new subject line. See it soon after 7 hours of sleep and
> prepare patch with Test-by.

Let's dup it into the PM report:

#syz dup: general protection fault in __pm_runtime_resume

Once the fix is in the USB fuzzer tree, the double-free will be
reported in a separate thread (once it gets hit again).

>
> Thanks
> Hillf
>
> >
> > CPU: 0 PID: 1745 Comm: kworker/0:2 Not tainted 5.3.0-rc2+ #1
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   print_address_description+0x6a/0x32c mm/kasan/report.c:351
> >   kasan_report_invalid_free+0x61/0xa0 mm/kasan/report.c:444
> >   __kasan_slab_free+0x162/0x180 mm/kasan/common.c:428
> >   slab_free_hook mm/slub.c:1423 [inline]
> >   slab_free_freelist_hook mm/slub.c:1470 [inline]
> >   slab_free mm/slub.c:3012 [inline]
> >   kfree+0xe4/0x2f0 mm/slub.c:3953
> >   hcd_buffer_free+0x199/0x260 drivers/usb/core/buffer.c:165
> >   usb_free_coherent+0x67/0x80 drivers/usb/core/usb.c:932
> >   hid_free_buffers.isra.0+0x94/0x290 drivers/hid/usbhid/hid-core.c:964
> >   usbhid_stop+0x308/0x450 drivers/hid/usbhid/hid-core.c:1224
> >   logi_dj_remove+0x107/0x210 drivers/hid/hid-logitech-dj.c:1797
> >   hid_device_remove+0xed/0x240 drivers/hid/hid-core.c:2242
> >   __device_release_driver drivers/base/dd.c:1118 [inline]
> >   device_release_driver_internal+0x206/0x4c0 drivers/base/dd.c:1151
> >   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
> >   device_del+0x420/0xb10 drivers/base/core.c:2288
> >   hid_remove_device drivers/hid/hid-core.c:2413 [inline]
> >   hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2432
> >   usbhid_disconnect+0xad/0xd0 drivers/hid/usbhid/hid-core.c:1414
> >   usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
> >   __device_release_driver drivers/base/dd.c:1120 [inline]
> >   device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1151
> >   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
> >   device_del+0x420/0xb10 drivers/base/core.c:2288
> >   usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
> >   usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
> >   hub_port_connect drivers/usb/core/hub.c:4949 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
> >   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >   process_scheduled_works kernel/workqueue.c:2331 [inline]
> >   worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
> >   kthread+0x318/0x420 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> > Allocated by task 1745:
> >   save_stack+0x1b/0x80 mm/kasan/common.c:69
> >   set_track mm/kasan/common.c:77 [inline]
> >   __kasan_kmalloc mm/kasan/common.c:487 [inline]
> >   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
> >   kmalloc include/linux/slab.h:557 [inline]
> >   hcd_buffer_alloc+0x1ca/0x290 drivers/usb/core/buffer.c:135
> >   usb_alloc_coherent+0x5d/0x80 drivers/usb/core/usb.c:910
> >   hid_alloc_buffers drivers/hid/usbhid/hid-core.c:846 [inline]
> >   usbhid_start+0x60b/0x22f0 drivers/hid/usbhid/hid-core.c:1075
> >   hid_hw_start+0x5d/0x130 drivers/hid/hid-core.c:1976
> >   logi_dj_probe+0x808/0xcd7 drivers/hid/hid-logitech-dj.c:1703
> >   hid_device_probe+0x2be/0x3f0 drivers/hid/hid-core.c:2209
> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   hid_add_device+0x33c/0x990 drivers/hid/hid-core.c:2365
> >   usbhid_probe+0xa81/0xfa0 drivers/hid/usbhid/hid-core.c:1386
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
> > Freed by task 1745:
> >   save_stack+0x1b/0x80 mm/kasan/common.c:69
> >   set_track mm/kasan/common.c:77 [inline]
> >   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
> >   slab_free_hook mm/slub.c:1423 [inline]
> >   slab_free_freelist_hook mm/slub.c:1470 [inline]
> >   slab_free mm/slub.c:3012 [inline]
> >   kfree+0xe4/0x2f0 mm/slub.c:3953
> >   hcd_buffer_free+0x199/0x260 drivers/usb/core/buffer.c:165
> >   usb_free_coherent+0x67/0x80 drivers/usb/core/usb.c:932
> >   hid_free_buffers.isra.0+0x94/0x290 drivers/hid/usbhid/hid-core.c:964
> >   usbhid_stop+0x308/0x450 drivers/hid/usbhid/hid-core.c:1224
> >   usbhid_disconnect+0xa5/0xd0 drivers/hid/usbhid/hid-core.c:1413
> >   usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
> >   __device_release_driver drivers/base/dd.c:1120 [inline]
> >   device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1151
> >   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
> >   device_del+0x420/0xb10 drivers/base/core.c:2288
> >   usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
> >   usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
> >   hub_port_connect drivers/usb/core/hub.c:4949 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
> >   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >   process_scheduled_works kernel/workqueue.c:2331 [inline]
> >   worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
> >   kthread+0x318/0x420 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> > The buggy address belongs to the object at ffff8881d5875500
> >   which belongs to the cache kmalloc-4k of size 4096
> > The buggy address is located 0 bytes inside of
> >   4096-byte region [ffff8881d5875500, ffff8881d5876500)
> > The buggy address belongs to the page:
> > page:ffffea0007561c00 refcount:1 mapcount:0 mapping:ffff8881da00c280
> > index:0x0 compound_mapcount: 0
> > flags: 0x200000000010200(slab|head)
> > raw: 0200000000010200 dead000000000100 dead000000000122 ffff8881da00c280
> > raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >   ffff8881d5875400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >   ffff8881d5875480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > ffff8881d5875500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                     ^
> >   ffff8881d5875580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8881d5875600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> >
> >
> > Tested on:
> >
> > commit:         7f7867ff usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13833b9a600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=167d2a0e600000
>
