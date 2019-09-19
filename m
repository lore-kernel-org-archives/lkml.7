Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC03C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EF4207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rN/VcTqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392019AbfISS1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 14:27:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32826 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389805AbfISS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 14:27:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so2379571pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8e0dNVlCm2ER/Mcg4fyncBrKia3gYtZ/jIkj1l9+2Rs=;
        b=rN/VcTqKzplV5ES/dI9JI5dfkCnOWnpXYMukyzdrUCIOlXvnWX3egQxoIQwjn0cCeP
         cSdI8REvVHDFRV0lpUGMPRjpXXCGNMMQQDiYw0pkeRnQtpeXRFy7YNX4B6ILJLbfufj+
         5elbIhhiCicxjv8BvMT+y0FP448bnDNxmX4eqt7iC4lBraOP3lnWQZwosU3bNqLDlsUg
         6DpktL/8At4/sDUThYio4uwR1PpGUSuw5CuX+Upng8NkVlObABdi05h+IRBrxdPna4NX
         x+gUWZ219e6DKNHaQtgbeGi5m1yndhvzUDhng19gBrwTF1KIAMNOp/FH8CDkcMqiuAMo
         lliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8e0dNVlCm2ER/Mcg4fyncBrKia3gYtZ/jIkj1l9+2Rs=;
        b=Nq7LvYywsvHyRIjJ4fvxtkPjJLDIUAlIDujPoqP/2fYjskvePzHBP9zww0O42RDkOX
         0+p2hUVfqQD4lZHdJptjHklcqxpVfWviMP7OlywRf7CTu5a1zTjaLdkHGfA7eNuc8/jY
         kkGyfU50JcLlUERqjXsbY9e0Q6cJuKv5+ep+XzHiBqa5Cl7sKGkJlfcPkxFc7QgSX3Rp
         3t38SS8N4MtsjWtjv0/tlodCpuu79XnzcOqPPo+R37Fkkrph3/BK0ayitjJdUGiKIVgR
         Ilck0WfnPEK7kw2ILrtNnV5oq0DecmeDmypMJWQZ6i4zgYPu7aCUdYDIp7lrRsOoaR7E
         f/Jw==
X-Gm-Message-State: APjAAAVYA6W40gTCq77IOGbIfDE0YD4Qm+yhmNeemeRoLbKUacBjq22j
        nke4KG9OU6OBd1CiwHMjMCcdr6myEQy1PYmb+6nKi6zlSgnmYA==
X-Google-Smtp-Source: APXvYqxmWFbpCVB/hbfgs0V+Q1y2eYh/bWgOoPraHLQq+V8uvuspLSKloB9a8nak1mM0yhFfb3ZS/ukRL8ZpQ/DwkGs=
X-Received: by 2002:a17:90a:1990:: with SMTP id 16mr5168213pji.47.1568917639460;
 Thu, 19 Sep 2019 11:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003e64aa0592ebfde1@google.com>
In-Reply-To: <0000000000003e64aa0592ebfde1@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 19 Sep 2019 20:27:08 +0200
Message-ID: <CAAeHK+yyZKfD5tZGiZaJAJwW9tuv+Q+XEowaU3+3EEVYuzEfaw@mail.gmail.com>
Subject: Re: KMSAN: kernel-usb-infoleak in hid_submit_ctrl
To:     syzbot <syzbot+7c2bb71996f95a82524c@syzkaller.appspotmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
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

On Thu, Sep 19, 2019 at 8:19 PM syzbot
<syzbot+7c2bb71996f95a82524c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    014077b5 DO-NOT-SUBMIT: usb-fuzzer: main usb gadget fuzzer..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=123e42a5600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
> dashboard link: https://syzkaller.appspot.com/bug?extid=7c2bb71996f95a82524c
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b0411a600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d1ee01600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7c2bb71996f95a82524c@syzkaller.appspotmail.com
>
> microsoft 0003:045E:07DA.0002: unknown main item tag 0x0
> microsoft 0003:045E:07DA.0002: unknown main item tag 0x0
> ==================================================================
> BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x7ef/0x1f50
> drivers/usb/core/urb.c:405
> CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.3.0-rc7+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>   kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
>   kmsan_internal_check_memory+0x7be/0x8d0 mm/kmsan/kmsan.c:553
>   kmsan_handle_urb+0x28/0x40 mm/kmsan/kmsan_hooks.c:621
>   usb_submit_urb+0x7ef/0x1f50 drivers/usb/core/urb.c:405
>   hid_submit_ctrl+0xb5f/0x1160 drivers/hid/usbhid/hid-core.c:416
>   usbhid_restart_ctrl_queue+0x355/0x510 drivers/hid/usbhid/hid-core.c:258
>   __usbhid_submit_report drivers/hid/usbhid/hid-core.c:601 [inline]
>   usbhid_submit_report+0x924/0x1200 drivers/hid/usbhid/hid-core.c:638
>   usbhid_request+0xc6/0xe0 drivers/hid/usbhid/hid-core.c:1253
>   hid_hw_request include/linux/hid.h:1053 [inline]
>   __hidinput_change_resolution_multipliers+0x132/0x6a0
> drivers/hid/hid-input.c:1566
>   hidinput_change_resolution_multipliers drivers/hid/hid-input.c:1604
> [inline]
>   hidinput_connect+0x2b9a/0x4220 drivers/hid/hid-input.c:1914
>   hid_connect+0x582/0x15c0 drivers/hid/hid-core.c:1877
>   hid_hw_start+0x141/0x230 drivers/hid/hid-core.c:1981
>   ms_probe+0x39b/0x8f0 drivers/hid/hid-microsoft.c:388
>   hid_device_probe+0x490/0x820 drivers/hid/hid-core.c:2209
>   really_probe+0xd08/0x1dc0 drivers/base/dd.c:548
>   driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
>   __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
>   bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
>   __device_attach+0x489/0x750 drivers/base/dd.c:882
>   device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
>   bus_probe_device+0x131/0x390 drivers/base/bus.c:514
>   device_add+0x25b5/0x2df0 drivers/base/core.c:2165
>   hid_add_device+0x132b/0x1470 drivers/hid/hid-core.c:2365
>   usbhid_probe+0x152b/0x1880 drivers/hid/usbhid/hid-core.c:1386
>   usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
>   really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
>   driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
>   __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
>   bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
>   __device_attach+0x489/0x750 drivers/base/dd.c:882
>   device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
>   bus_probe_device+0x131/0x390 drivers/base/bus.c:514
>   device_add+0x25b5/0x2df0 drivers/base/core.c:2165
>   usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
>   generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
>   usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
>   really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
>   driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
>   __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
>   bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
>   __device_attach+0x489/0x750 drivers/base/dd.c:882
>   device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
>   bus_probe_device+0x131/0x390 drivers/base/bus.c:514
>   device_add+0x25b5/0x2df0 drivers/base/core.c:2165
>   usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
>   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
>   process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
>   process_scheduled_works kernel/workqueue.c:2331 [inline]
>   worker_thread+0x189c/0x2460 kernel/workqueue.c:2417
>   kthread+0x4b5/0x4f0 kernel/kthread.c:256
>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
>
> Uninit was created at:
>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:189 [inline]
>   kmsan_internal_poison_shadow+0x58/0xb0 mm/kmsan/kmsan.c:148
>   kmsan_slab_alloc+0xaa/0x120 mm/kmsan/kmsan_hooks.c:175
>   slab_alloc_node mm/slub.c:2790 [inline]
>   slab_alloc mm/slub.c:2799 [inline]
>   __kmalloc+0x28e/0x430 mm/slub.c:3830
>   kmalloc include/linux/slab.h:557 [inline]
>   hcd_buffer_alloc+0x391/0x510 drivers/usb/core/buffer.c:132
>   usb_alloc_coherent+0x11a/0x190 drivers/usb/core/usb.c:910
>   hid_alloc_buffers drivers/hid/usbhid/hid-core.c:851 [inline]
>   usbhid_start+0xf60/0x3970 drivers/hid/usbhid/hid-core.c:1075
>   hid_hw_start+0x9a/0x230 drivers/hid/hid-core.c:1976
>   ms_probe+0x39b/0x8f0 drivers/hid/hid-microsoft.c:388
>   hid_device_probe+0x490/0x820 drivers/hid/hid-core.c:2209
>   really_probe+0xd08/0x1dc0 drivers/base/dd.c:548
>   driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
>   __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
>   bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
>   __device_attach+0x489/0x750 drivers/base/dd.c:882
>   device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
>   bus_probe_device+0x131/0x390 drivers/base/bus.c:514
>   device_add+0x25b5/0x2df0 drivers/base/core.c:2165
>   hid_add_device+0x132b/0x1470 drivers/hid/hid-core.c:2365
>   usbhid_probe+0x152b/0x1880 drivers/hid/usbhid/hid-core.c:1386
>   usb_probe_interface+0xd19/0x1310 drivers/usb/core/driver.c:361
>   really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
>   driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
>   __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
>   bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
>   __device_attach+0x489/0x750 drivers/base/dd.c:882
>   device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
>   bus_probe_device+0x131/0x390 drivers/base/bus.c:514
>   device_add+0x25b5/0x2df0 drivers/base/core.c:2165
>   usb_set_configuration+0x309f/0x3710 drivers/usb/core/message.c:2027
>   generic_probe+0xe7/0x280 drivers/usb/core/generic.c:210
>   usb_probe_device+0x146/0x200 drivers/usb/core/driver.c:266
>   really_probe+0x1373/0x1dc0 drivers/base/dd.c:552
>   driver_probe_device+0x1ba/0x510 drivers/base/dd.c:709
>   __device_attach_driver+0x5b8/0x790 drivers/base/dd.c:816
>   bus_for_each_drv+0x28e/0x3b0 drivers/base/bus.c:454
>   __device_attach+0x489/0x750 drivers/base/dd.c:882
>   device_initial_probe+0x4a/0x60 drivers/base/dd.c:929
>   bus_probe_device+0x131/0x390 drivers/base/bus.c:514
>   device_add+0x25b5/0x2df0 drivers/base/core.c:2165
>   usb_new_device+0x23e5/0x2fb0 drivers/usb/core/hub.c:2536
>   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x581d/0x72f0 drivers/usb/core/hub.c:5441
>   process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
>   process_scheduled_works kernel/workqueue.c:2331 [inline]
>   worker_thread+0x189c/0x2460 kernel/workqueue.c:2417
>   kthread+0x4b5/0x4f0 kernel/kthread.c:256
>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
>
> Bytes 0-4095 of 4096 are uninitialized
> Memory access of size 4096 starts at ffff888108f43000
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

Looks like the bug is that the HID subsystem doesn't account for the
fact that HID report size might be 0, which causes an underflow when
calculating buffer size in bytes as ((report->size - 1) >> 3) + 1. In
this particular case a report of size 0 leads to hid_submit_ctrl()
submitting an IN request with wLength == 0 (and transfer_buffer_length
= 4096), which is interpreted as an OUT request by the USB core layer,
and leads to a leak of 4096 bytes from transfer_buffer.

This particular code path that leads to a info leak was introduced by
commit 2dc702c9 "HID: input: use the Resolution Multiplier for
high-resolution scrolling" in December 2018, so it's quite new. I've
failed to leak any non-zero data from an Ubuntu laptop with 5.0 kernel
that I have, probably because the leaked memory is allocated from USB
HCD DMA pools and some kind of spraying is required here. I've also
failed to find other ways to trigger a leak.

Other manifestations the same issue:

WARNING in __alloc_pages_nodemask:
https://syzkaller.appspot.com/bug?extid=e38fe539fedfc127987e
KASAN: slab-out-of-bounds Write in hid_report_raw_event:
https://syzkaller.appspot.com/bug?extid=54323a55a37ec53f8045
