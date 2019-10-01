Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BF1C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A17221906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569925963;
	bh=9jELwXdO3eJUPxGCtKcV2gBI7pm1LC6MuZ5NTQFAypw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uvrI8k4r+UEURgGRDOXf2DGLubMnu0gWgzYIfw7Ji9fu9BUDTw5jN+jsJk6BVV/ys
	 s3SUFxvOEgpdhAUVH1W2cW8ttRjut6I39inwk6a8dYWy21+IMnntul8fckiJlkcdFm
	 NwyoCIu/qexPUDZGSsckevDjNTWj2UXlrYTSxBhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfJAKcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:32:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38636 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbfJAKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:32:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so12771484ljj.5;
        Tue, 01 Oct 2019 03:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Khg3aofzi3y/RCwSBD7Xayq8I3pziAFgYukoZ7zb6rU=;
        b=HkqPABTo9fco0Hg0r/hhWqWlPi2yB47JN9Hbj/PSMzCm9JeId+yWmRAqVSJ+slE71e
         RNECs3QovhpUAI6I9ow/bFG40X66xSVLRXxbOKOMR6plgeCMcZTGYtCf3EDHR/220Ntj
         qJ5FCie2Q27VP/j8VWCD29ymoEwwir7P8FQ5yOxI7bdgz88zsSkZa2ZT1CVNUleC1Ugd
         mskUmuFBHlmxZtK2gdtsDViFebzfK4Hh2vT7EOLBVZ10rk7O6Kwk6DxwaL5tse6xZa8I
         s1AQhXjx5dyAwGZHQY9H5fnrmxis1WgI5ECkHlzj0lAupCNE3dtoP28F6bvjAS9i3REQ
         XrrA==
X-Gm-Message-State: APjAAAUMs/r81QdGVWqu04jZw9kw1v5ZuFKJdthE4da0babKYn0if0M5
        MWVEfjTSL5h7Tngpt703fJA=
X-Google-Smtp-Source: APXvYqznKMmJpGX5KqoZeKw2jw5mQu/uyaurSQ6yCB45uyfSePTJnlkRc0FWIAdvkJidXYhm2KfJUQ==
X-Received: by 2002:a2e:86c7:: with SMTP id n7mr15062623ljj.227.1569925958596;
        Tue, 01 Oct 2019 03:32:38 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id 4sm3897558ljv.87.2019.10.01.03.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 03:32:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iFFSY-00055s-6a; Tue, 01 Oct 2019 12:32:46 +0200
Date:   Tue, 1 Oct 2019 12:32:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+e29b17e5042bbc56fae9@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in mcba_usb_disconnect
Message-ID: <20191001103246.GJ13531@localhost>
References: <000000000000d4e4900593cce75d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d4e4900593cce75d@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 03:39:15PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    2994c077 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=173b5acd600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=69ddefac6929256a
> dashboard link: https://syzkaller.appspot.com/bug?extid=e29b17e5042bbc56fae9
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ec8e19600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107ad813600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e29b17e5042bbc56fae9@syzkaller.appspotmail.com
> 
> mcba_usb 1-1:0.180 can1: Failed to send cmd (169)
> mcba_usb 1-1:0.180: Microchip CAN BUS Analyzer connected
> usb 1-1: USB disconnect, device number 2
> mcba_usb 1-1:0.95 can0: device disconnected
> ==================================================================
> BUG: KASAN: use-after-free in __lock_acquire+0x3377/0x3eb0  
> kernel/locking/lockdep.c:3828
> Read of size 8 at addr ffff8881d2e98f48 by task kworker/0:1/12
> 
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
>   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
>   kasan_report+0xe/0x12 mm/kasan/common.c:634
>   __lock_acquire+0x3377/0x3eb0 kernel/locking/lockdep.c:3828
>   lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4487
>   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
>   _raw_spin_lock_irq+0x2d/0x40 kernel/locking/spinlock.c:167
>   spin_lock_irq include/linux/spinlock.h:363 [inline]
>   usb_kill_anchored_urbs+0x1e/0x110 drivers/usb/core/urb.c:787
>   mcba_urb_unlink drivers/net/can/usb/mcba_usb.c:711 [inline]
>   mcba_usb_disconnect+0xd6/0xe4 drivers/net/can/usb/mcba_usb.c:881
>   usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
>   __device_release_driver drivers/base/dd.c:1134 [inline]
>   device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
>   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:532
>   device_del+0x420/0xb10 drivers/base/core.c:2375
>   usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
>   usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
>   hub_port_connect drivers/usb/core/hub.c:4949 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
>   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
>   process_scheduled_works kernel/workqueue.c:2331 [inline]
>   worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
>   kthread+0x318/0x420 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> The buggy address belongs to the page:
> page:ffffea00074ba600 refcount:0 mapcount:-128 mapping:0000000000000000  
> index:0x0
> flags: 0x200000000000000()
> raw: 0200000000000000 ffffea0007479208 ffff88821fffac18 0000000000000000
> raw: 0000000000000000 0000000000000003 00000000ffffff7f 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff8881d2e98e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ffff8881d2e98e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > ffff8881d2e98f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                                ^
>   ffff8881d2e98f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ffff8881d2e99000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================

Fix posted

	https://lkml.kernel.org/r/20191001102914.4567-2-johan@kernel.org

Johan
