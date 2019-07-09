Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615F3C73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E7E20861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMLaa5Dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfGIMQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:16:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35844 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:16:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so10021507plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zlbBIFtD0vfqGiiC5BfU9/XKOMbPaIAPFIK/AnAxu4=;
        b=ZMLaa5Dph0P050+LJkf9aSETNp+8QDl4sQ+AF2F26HB+gSVME3a04EKJDjtV3riczo
         kQgIzuot2KNiVSro9eoQpDFZqDBUHAL9wCTrUFvkitCnsS+lgFC+X0pJmUexaYhVpC+p
         5DabHxAo0P0jvK1PgjWep2MVRRiM4TRGulsguruyjY6oPzf4goVJtWM3qZFTHIe9fzrZ
         nyx5/UwC4OooQ9bCiCQc5mWnXubR56/wokFupNL9+ZMJlOaICL8t5+A4MFyisIMgI8vP
         tc1n641PV806RRbRchVICPC2OgdBy9qZYtFuMvt6cNFgjyhVFL6ETJa4ZDBWsuOVdPMI
         asNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zlbBIFtD0vfqGiiC5BfU9/XKOMbPaIAPFIK/AnAxu4=;
        b=qcSNiviaVBLOLrWUKrrDJSiVsT6PCQqVUEyLV0rWXM+VWsnELHTyValEiGBzJDHqs9
         A5OFIMNhwHQ8w+OGbnWOXS6Bdm0vWoCszQYcz4Dd7EJ7yaMxL1h4cr5j4aKqeIHmb46m
         gzYCs0K8OqFZCgnt4ml+enrQ8cocDasDG7HqefgGLwYRN2lz9E1mDWHOlvx5/OyLSs/p
         OeZwCrJ1C7yyKkPPRw319q4yqMyM0njKzuc/a4OuWg/kaEtWLCLXoaVq3wDYTQbirgqt
         7LrmouNa8Qsbh9lJIQvpo1dUCZFMHMuUN44w296r0UI8KbHb+pHhm9kxCxmPQeFCH0Gm
         13Qw==
X-Gm-Message-State: APjAAAUzo9rDODVib52gWQF2AVqlcTgeOn7KnaiAE03xD912lG8JH25S
        DobFGetcMGGgmrIJcFBrEwfGixb/G+qd7xBIT8C1ZA==
X-Google-Smtp-Source: APXvYqyRpvMOsKpgvvFIm5hO+l9JY3DLMLSJQjGh4uU2h63Vzd3ovnMK0LWU62SotvP96tXm+dm8Ny3O5J/DRJnNYUY=
X-Received: by 2002:a17:902:6a87:: with SMTP id n7mr31246385plk.336.1562674593241;
 Tue, 09 Jul 2019 05:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a0b1df058cb460c8@google.com> <20190705095012.13096-1-hdanton@sina.com>
In-Reply-To: <20190705095012.13096-1-hdanton@sina.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 9 Jul 2019 14:16:22 +0200
Message-ID: <CAAeHK+zO6s5zWmz_QP6HiXd81Q217X6Viua+v1HkyXiowS_2Sg@mail.gmail.com>
Subject: Re: WARNING in sisusb_send_bulk_msg/usb_submit_urb
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 11:50 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Thu, 04 Jul 2019 07:09:05 -0700 (PDT)
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12e5bf93a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
> > dashboard link: https://syzkaller.appspot.com/bug?extid=23be03b56c5259385d79
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11effc85a00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172189aba00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com
> >
> > usb 1-1: string descriptor 0 read error: -22
> > usb 1-1: New USB device found, idVendor=0711, idProduct=0550,
> > bcdDevice=da.7e
> > usb 1-1: New USB device strings: Mfr=37, Product=1, SerialNumber=1
> > usb 1-1: USB2VGA dongle found at address 2
> > usb 1-1: Allocated 8 output buffers
> > ------------[ cut here ]------------
> > usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> > WARNING: CPU: 1 PID: 21 at drivers/usb/core/urb.c:477
> > usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #13
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   panic+0x292/0x6c9 kernel/panic.c:219
> >   __warn.cold+0x20/0x4b kernel/panic.c:576
> >   report_bug+0x262/0x2a0 lib/bug.c:186
> >   fixup_bug arch/x86/kernel/traps.c:179 [inline]
> >   fixup_bug arch/x86/kernel/traps.c:174 [inline]
> >   do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
> >   do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
> >   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
> > RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> > Code: 4d 85 ed 74 2c e8 78 db e8 fd 4c 89 f7 e8 a0 36 13 ff 41 89 d8 44 89
> > e1 4c 89 ea 48 89 c6 48 c7 c7 80 23 1a 86 e8 03 a0 be fd <0f> 0b e9 20 f4
> > ff ff e8 4c db e8 fd 4c 89 f2 48 b8 00 00 00 00 00
> > RSP: 0018:ffff8881d9efed28 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3dfd97
> > RBP: ffff8881d09bbb80 R08: ffff8881d9e36000 R09: ffffed103b665d30
> > R10: ffffed103b665d2f R11: ffff8881db32e97f R12: 0000000000000003
> > R13: ffff8881ccdd79a8 R14: ffff8881d03711a0 R15: ffff8881d9449000
> >   sisusb_bulkout_msg drivers/usb/misc/sisusbvga/sisusb.c:238 [inline]
> >   sisusb_send_bulk_msg.constprop.0+0x88a/0x1030  drivers/usb/misc/sisusbvga/sisusb.c:393
> >   sisusb_send_bridge_packet.constprop.0+0x11c/0x240  drivers/usb/misc/sisusbvga/sisusb.c:581
> >   sisusb_do_init_gfxdevice+0x8a/0x450  drivers/usb/misc/sisusbvga/sisusb.c:2137
> >   sisusb_init_gfxdevice+0xe0/0x18d0 drivers/usb/misc/sisusbvga/sisusb.c:2237
> >   sisusb_probe+0x924/0xbcb drivers/usb/misc/sisusbvga/sisusb.c:3122
> >   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
> >   really_probe+0x281/0x660 drivers/base/dd.c:509
> >   driver_probe_device+0x104/0x210 drivers/base/dd.c:670
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:843
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2111
> >   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
> >   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
> >   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
> >   really_probe+0x281/0x660 drivers/base/dd.c:509
> >   driver_probe_device+0x104/0x210 drivers/base/dd.c:670
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:843
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2111
> >   usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
> >   hub_port_connect drivers/usb/core/hub.c:5089 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
> >   port_event drivers/usb/core/hub.c:5350 [inline]
> >   hub_event+0x1ada/0x3590 drivers/usb/core/hub.c:5432
> >   process_one_work+0x905/0x1570 kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> >   kthread+0x30b/0x410 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> >
>
> There are three defines that can be found currently in the mainline.
>
> ===define-1=== linux/usb.h
>
> /* NOTE:  these are not the standard USB_ENDPOINT_XFER_* values!! */
> /* (yet ... they're the values used by usbfs) */
> #define PIPE_ISOCHRONOUS                0
> #define PIPE_INTERRUPT                  1
> #define PIPE_CONTROL                    2
> #define PIPE_BULK                       3
>
>
> ===define-2=== usb/core/urb.c
>
> static const int pipetypes[4] = {
>         PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
> };
>
>
> ===define-3=== uapi/linux/usb/ch9.h
>
> #define USB_ENDPOINT_XFERTYPE_MASK      0x03    /* in bmAttributes */
> #define USB_ENDPOINT_XFER_CONTROL       0
> #define USB_ENDPOINT_XFER_ISOC          1
> #define USB_ENDPOINT_XFER_BULK          2
> #define USB_ENDPOINT_XFER_INT           3
>
> And PIPE_BULK is unable to match its counterpart in pipetypes array as long as
> code is correct. Nor XFER_BULK.
>

Hi Hilf,

The USB stack produces this kind of WARNING when the driver uses a
bulk pipe and usb_fill_bulk_urb(), but the endpoint is actually
interrupt. The driver should check that the ep has the expected type
before using it.

Thanks!
