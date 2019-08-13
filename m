Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C6C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231DD2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfHMUNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:13:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42648 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726066AbfHMUNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:13:49 -0400
Received: (qmail 3672 invoked by uid 2102); 13 Aug 2019 16:13:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Aug 2019 16:13:48 -0400
Date:   Tue, 13 Aug 2019 16:13:48 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>, <hdanton@sina.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <oneukum@suse.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb
In-Reply-To: <000000000000d195cc058feb2498@google.com>
Message-ID: <Pine.LNX.4.44L0.1908121115390.1659-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered  
> crash:
> KASAN: invalid-free in hcd_buffer_free

This bug report shows that Hillf's fix isn't exactly right.

> usb 5-1: USB disconnect, device number 2
> ==================================================================
> BUG: KASAN: double-free or invalid-free in hcd_buffer_free+0x199/0x260  
> drivers/usb/core/buffer.c:165
> 
> CPU: 0 PID: 1745 Comm: kworker/0:2 Not tainted 5.3.0-rc2+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   kasan_report_invalid_free+0x61/0xa0 mm/kasan/report.c:444
>   __kasan_slab_free+0x162/0x180 mm/kasan/common.c:428
>   slab_free_hook mm/slub.c:1423 [inline]
>   slab_free_freelist_hook mm/slub.c:1470 [inline]
>   slab_free mm/slub.c:3012 [inline]
>   kfree+0xe4/0x2f0 mm/slub.c:3953
>   hcd_buffer_free+0x199/0x260 drivers/usb/core/buffer.c:165
>   usb_free_coherent+0x67/0x80 drivers/usb/core/usb.c:932
>   hid_free_buffers.isra.0+0x94/0x290 drivers/hid/usbhid/hid-core.c:964
>   usbhid_stop+0x308/0x450 drivers/hid/usbhid/hid-core.c:1224
>   logi_dj_remove+0x107/0x210 drivers/hid/hid-logitech-dj.c:1797

Here the double-free occurred when logi_dj_remove() called 
hd_hw_stop()...

>   hid_device_remove+0xed/0x240 drivers/hid/hid-core.c:2242
>   __device_release_driver drivers/base/dd.c:1118 [inline]
>   device_release_driver_internal+0x206/0x4c0 drivers/base/dd.c:1151
>   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
>   device_del+0x420/0xb10 drivers/base/core.c:2288
>   hid_remove_device drivers/hid/hid-core.c:2413 [inline]
>   hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2432
>   usbhid_disconnect+0xad/0xd0 drivers/hid/usbhid/hid-core.c:1414

which occurred inside usbhid_disconnect()'s call to
hid_destroy_device().

But just above the call to hid_destroy_device(), Hillf's patch adds a 
direct call to hid_hw_stop(), which is what did the original free.

So it looks like the problem here is that some paths in the original
unpatched code end up calling hid_hw_stop() by way of the hid_device's
driver, and other paths do not.

I haven't had time to track down this difference.  Maybe somebody 
on the mailing list already knows why it occurs.

Alan Stern

