Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9DEECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3821820869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571309206;
	bh=Yw0aiX1wEW392IEDgt1pbDrJRiUC+2a9NG3ZNLjIPqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QRtVeuqoCLhVHwRL3/3ApDz3Dfb76ezVyydmLzGiyng5CPtf4qXS47FXW/Xhc1C4F
	 YF9+cxAb11qGLoBd3blIXJI5FdbAQXzkojL0IeB+0rvEjOBmkjUK9BLsufs8DSfg6H
	 4wRn79Q7bRdnPHcz3bQk6kzUbRajWWx3lK6P/UrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408946AbfJQKqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:46:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35641 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408933AbfJQKqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:46:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so1501326lfl.2;
        Thu, 17 Oct 2019 03:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2nzwnuvHZxUsW22PYwUywvfUwUVZh8Pwvzu7gDe3XaM=;
        b=ZujIlOTItl5rdarIem2VENde42C20FOiUR/LdecFJqQOlqpY4dzkumD0PbErcsRgTg
         YHAf+OnFBn8Pe6ANZ2vyQqlNdugjgtdd7MRN4HYdraFJoDrLpv+Dt9Bu3PxzMu/NOL3B
         vYTFEEfDbUeCS4WsoCSnIxAFM5hhHZncIDBNCVfiHrUJCiHaz2QsImmwjD8Q97EWml1F
         8ryjD5C4vB6nKk5emysX0kgZDgjGtsyfq0dVvsGycWpONbbqyz0kh4ADSj5jKPjzdeCz
         fkzHs10CEYpTfIFDwkGxcWgldQu9yhAJXW/X1Bewf1AAds7hVxACYEKFxYC2b0oNwGfn
         qJ+Q==
X-Gm-Message-State: APjAAAVIUFAyIIqzcc3u/9Q+UAy/sqxRkkg/Qz5u3f+JiytNOC1idO/q
        69EXG+i/JqOaD5ub8srrzX8=
X-Google-Smtp-Source: APXvYqzsXdV2LA5n9FWMH/DQZnoCjgv8hB3a2Gs+ubQ0bUGDZGyal8FlJ676XgWYVnA6aToGvjzCgQ==
X-Received: by 2002:a05:6512:142:: with SMTP id m2mr1997771lfo.56.1571309200999;
        Thu, 17 Oct 2019 03:46:40 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id y135sm2362254lfa.92.2019.10.17.03.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 03:46:40 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iL3Iw-0007Ru-Qf; Thu, 17 Oct 2019 12:46:51 +0200
Date:   Thu, 17 Oct 2019 12:46:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+6fe95b826644f7f12b0b@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, enric.balletbo@collabora.com,
        gregkh@linuxfoundation.org, johan@kernel.org, kirr@nexedi.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux@roeck-us.net, logang@deltatee.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: slab-out-of-bounds Read in ld_usb_read (3)
Message-ID: <20191017104650.GD21827@localhost>
References: <00000000000070102d059511537d@google.com>
 <20191017102513.GC21827@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017102513.GC21827@localhost>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:25:13PM +0200, Johan Hovold wrote:
> On Wed, Oct 16, 2019 at 06:42:10PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14f6dc5f600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6fe95b826644f7f12b0b
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102c3227600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a503a0e00000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+6fe95b826644f7f12b0b@syzkaller.appspotmail.com
> > 
> > ldusb 1-1:0.28: Read buffer overflow, -131383859965943 bytes dropped
> 
> This warning should be using %zu and thus read 18446612689849585673.
> 
> Apparently, *actual_buffer holds a kernel address ffff8881cfb42000
> instead of a transfer length. Possibly a stale value since the buffer is
> not cleared on allocation.
> 
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x124/0x150  
> > lib/usercopy.c:28
> > Read of size 102391 at addr ffff8881cfb40008 by task syz-executor372/1737
> 
> And due to missing sanity checks the driver proceeds to access data
> beyond the ring-buffer entry.
> 
> > CPU: 0 PID: 1737 Comm: syz-executor372 Not tainted 5.4.0-rc3+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
> >   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
> >   kasan_report+0xe/0x20 mm/kasan/common.c:634
> >   check_memory_region_inline mm/kasan/generic.c:185 [inline]
> >   check_memory_region+0x128/0x190 mm/kasan/generic.c:192
> >   _copy_to_user+0x124/0x150 lib/usercopy.c:28
> >   copy_to_user include/linux/uaccess.h:152 [inline]
> >   ld_usb_read+0x329/0x760 drivers/usb/misc/ldusb.c:492
> >   __vfs_read+0x76/0x100 fs/read_write.c:425
> >   vfs_read+0x1ea/0x430 fs/read_write.c:461
> >   ksys_read+0x1e8/0x250 fs/read_write.c:587
> >   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x4421d9
> > Code: e8 7c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
> > ff 0f 83 bb 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007ffc08eb0888 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > RAX: ffffffffffffffda RBX: 00007ffc08eb0ae0 RCX: 00000000004421d9
> > RDX: 0000000000018ff7 RSI: 0000000020000a80 RDI: 0000000000000004
> > RBP: 0000000000000000 R08: 000000000000000f R09: 0000000000402eb0
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000402eb0 R14: 0000000000000000 R15: 0000000000000000
> > 
> > The buggy address belongs to the page:
> > page:ffffea00073ed000 refcount:1 mapcount:0 mapping:0000000000000000  
> > index:0x0 compound_mapcount: 0
> > flags: 0x200000000010000(head)
> > raw: 0200000000010000 dead000000000100 dead000000000122 0000000000000000
> > raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> > 
> > Memory state around the buggy address:
> >   ffff8881cfb55500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >   ffff8881cfb55580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > ffff8881cfb55600: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >                     ^
> >   ffff8881cfb55680: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >   ffff8881cfb55700: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > ==================================================================
> 
> The drivers ring-buffer implementation is broken so this could
> potentially be a memory-ordering issue (e.g. the entry is read before it
> has been updated).

Heh, it doesn't even need to race to trigger this; the driver sets
dev->interrupt_in_done when the URB is killed on disconnect() and read
happily continues with reading the next entry which was never updated.

> Let's try the below.

The below should work, but should be amended so that a blocking read()
returns after disconnect().

Johan

> #syz test: https://github.com/google/kasan.git 22be26f7
> 
> From 61c87ec9b1311949e313f633e84aab5c73975078 Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan@kernel.org>
> Date: Thu, 17 Oct 2019 11:53:04 +0200
> Subject: [PATCH] wip: USB: lsusb: fix ring-buffer locking
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/misc/ldusb.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
> index f3108d85e768..c8d09ac7ade9 100644
> --- a/drivers/usb/misc/ldusb.c
> +++ b/drivers/usb/misc/ldusb.c
> @@ -467,7 +467,7 @@ static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
>  
>  	/* wait for data */
>  	spin_lock_irq(&dev->rbsl);
> -	if (dev->ring_head == dev->ring_tail) {
> +	while (dev->ring_head == dev->ring_tail) {
>  		dev->interrupt_in_done = 0;
>  		spin_unlock_irq(&dev->rbsl);
>  		if (file->f_flags & O_NONBLOCK) {
> @@ -477,8 +477,8 @@ static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
>  		retval = wait_event_interruptible(dev->read_wait, dev->interrupt_in_done);
>  		if (retval < 0)
>  			goto unlock_exit;
> -	} else {
> -		spin_unlock_irq(&dev->rbsl);
> +
> +		spin_lock_irq(&dev->rbsl);
>  	}
>  
>  	/* actual_buffer contains actual_length + interrupt_in_buffer */
> @@ -487,17 +487,19 @@ static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
>  	if (bytes_to_read < *actual_buffer)
>  		dev_warn(&dev->intf->dev, "Read buffer overflow, %zd bytes dropped\n",
>  			 *actual_buffer-bytes_to_read);
> +	spin_unlock_irq(&dev->rbsl);
>  
>  	/* copy one interrupt_in_buffer from ring_buffer into userspace */
>  	if (copy_to_user(buffer, actual_buffer+1, bytes_to_read)) {
>  		retval = -EFAULT;
>  		goto unlock_exit;
>  	}
> -	dev->ring_tail = (dev->ring_tail+1) % ring_buffer_size;
> -
>  	retval = bytes_to_read;
>  
>  	spin_lock_irq(&dev->rbsl);
> +
> +	dev->ring_tail = (dev->ring_tail+1) % ring_buffer_size;
> +
>  	if (dev->buffer_overflow) {
>  		dev->buffer_overflow = 0;
>  		spin_unlock_irq(&dev->rbsl);
> @@ -693,12 +695,17 @@ static int ld_usb_probe(struct usb_interface *intf, const struct usb_device_id *
>  		dev_warn(&intf->dev, "Interrupt out endpoint not found (using control endpoint instead)\n");
>  
>  	dev->interrupt_in_endpoint_size = usb_endpoint_maxp(dev->interrupt_in_endpoint);
> +	dev_info(&intf->dev, "%s - interrupt_in_endpoint_size = %zu\n",
> +			__func__, dev->interrupt_in_endpoint_size);
>  	dev->ring_buffer =
>  		kmalloc_array(ring_buffer_size,
>  			      sizeof(size_t) + dev->interrupt_in_endpoint_size,
>  			      GFP_KERNEL);
>  	if (!dev->ring_buffer)
>  		goto error;
> +	dev_info(&intf->dev, "%s - ring_buffer = %px\n", __func__,
> +			dev->ring_buffer);
> +
>  	dev->interrupt_in_buffer = kmalloc(dev->interrupt_in_endpoint_size, GFP_KERNEL);
>  	if (!dev->interrupt_in_buffer)
>  		goto error;
