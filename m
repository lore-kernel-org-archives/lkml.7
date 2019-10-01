Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F7C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931502190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569925913;
	bh=wTK1uclnYBmHee6q3hK34Chlus5spMyt5KaGdaX31ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gC0x96YjtBg3yMX03FhWUfXR0wiMfgRfZObsPOmGEF0tEc3Oi7+lvjnZ11n3bK9pz
	 8dRQI1ZnZN7re+jbz58HKtXInyXTcUuOkeCL/607Ulx140xa419EIOmE4zIpBYJdoP
	 53wmLWjkuS8PWqb6YMhlflDmx3nZuCieKLRrSLfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfJAKbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:31:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33526 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJAKbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:31:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so9475652lfc.0;
        Tue, 01 Oct 2019 03:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cUJpYoO/1alhhABzeFUuEFZyV9yQF8pTcaFb/aecP1Q=;
        b=B3p8tsmb1lG2svTGsN4oBWM7Dd538PSd7PYNbquj/27ZOOsJu+ZOvanPgcSSH7uR5A
         aLf8A2n004nTn2f0kXva+uAHRDf5ZaVCPqMWnJqrpl+3seM5oL6Kvm/E8l7jxKYKkqjY
         rDGmYBnzCVw5m/Kgo0XHwxSDQt3wzRmwzDiNRIKsfsTecFn05FZe0IDgRDY5EqKhmmYN
         P5vc7AW7OIAOO7E9RmVqQ7XpQuRyEs8ghh/qaOkIreAxMjd2zUwSEAEJk1yR8fL/OJ85
         GF6cbBQ9Y3YEsrk9uSmLvK1XVmvsMjZSIMomXrT6gj3P7pNUeFXiB3m46qKpLv58ErMi
         4TAQ==
X-Gm-Message-State: APjAAAXv7YZREmE5+5Q2hAr6eAnyWxt8IedogZpf8oYCFpo+9vaBpVVH
        hCJrs9AhUajgGSRKDfTY4Oo=
X-Google-Smtp-Source: APXvYqw4hqR7hFN99oqEc8R4QnfT5Djo+PiBzNoReOG+fIFTez1czmTAJRb4Ys36uLuKyLdv7kszRQ==
X-Received: by 2002:a05:6512:488:: with SMTP id v8mr14499290lfq.37.1569925909369;
        Tue, 01 Oct 2019 03:31:49 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id k23sm3902047ljc.13.2019.10.01.03.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 03:31:48 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iFFRl-000557-2Y; Tue, 01 Oct 2019 12:31:57 +0200
Date:   Tue, 1 Oct 2019 12:31:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+eb6ab607626fd1dac0f1@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in usb_kill_anchored_urbs
Message-ID: <20191001103157.GI13531@localhost>
References: <000000000000e84a3a058b0f9307@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e84a3a058b0f9307@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:25:05AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=15df4ecaa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=193d8457178b3229
> dashboard link: https://syzkaller.appspot.com/bug?extid=eb6ab607626fd1dac0f1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11847e7aa00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ef5f2ea00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+eb6ab607626fd1dac0f1@syzkaller.appspotmail.com
> 
> mcba_usb 1-1:0.116 can0: Failed to send cmd (169)
> mcba_usb 1-1:0.116 can0: failed tx_urb -2
> mcba_usb 1-1:0.116 can0: Failed to send cmd (169)
> mcba_usb 1-1:0.116: Microchip CAN BUS Analyzer connected
> usb 1-1: USB disconnect, device number 2
> mcba_usb 1-1:0.116 can0: device disconnected
> ==================================================================
> BUG: KASAN: use-after-free in __lock_acquire+0x3a5d/0x5340  
> kernel/locking/lockdep.c:3664
> Read of size 8 at addr ffff8881d44c63c8 by task kworker/0:1/12
> 
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc1+ #10
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x67/0x231 mm/kasan/report.c:188
>   __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:317
>   kasan_report+0xe/0x20 mm/kasan/common.c:614
>   __lock_acquire+0x3a5d/0x5340 kernel/locking/lockdep.c:3664
>   lock_acquire+0x100/0x2b0 kernel/locking/lockdep.c:4302
>   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
>   _raw_spin_lock_irq+0x2d/0x40 kernel/locking/spinlock.c:167
>   spin_lock_irq include/linux/spinlock.h:363 [inline]
>   usb_kill_anchored_urbs+0x1e/0x110 drivers/usb/core/urb.c:787
>   mcba_urb_unlink drivers/net/can/usb/mcba_usb.c:722 [inline]
>   mcba_usb_disconnect+0xd6/0xe4 drivers/net/can/usb/mcba_usb.c:892
>   usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
>   __device_release_driver drivers/base/dd.c:1081 [inline]
>   device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1112
>   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
>   device_del+0x460/0xb80 drivers/base/core.c:2274
>   usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
>   usb_disconnect+0x284/0x830 drivers/usb/core/hub.c:2197
>   hub_port_connect drivers/usb/core/hub.c:4940 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
>   port_event drivers/usb/core/hub.c:5350 [inline]
>   hub_event+0x1409/0x3590 drivers/usb/core/hub.c:5432
>   process_one_work+0x905/0x1570 kernel/workqueue.c:2268
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2414
>   kthread+0x30b/0x410 kernel/kthread.c:254
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Allocated by task 12:
>   save_stack+0x1b/0x80 mm/kasan/common.c:71
>   set_track mm/kasan/common.c:79 [inline]
>   __kasan_kmalloc mm/kasan/common.c:489 [inline]
>   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:462
>   kmalloc_node include/linux/slab.h:590 [inline]
>   kvmalloc_node+0x61/0xf0 mm/util.c:430
>   kvmalloc include/linux/mm.h:637 [inline]
>   kvzalloc include/linux/mm.h:645 [inline]
>   alloc_netdev_mqs+0x97/0xce0 net/core/dev.c:9154
>   alloc_candev_mqs+0x58/0x320 drivers/net/can/dev.c:738
>   mcba_usb_probe+0xaf/0xbca drivers/net/can/usb/mcba_usb.c:810
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
>   usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
>   hub_port_connect drivers/usb/core/hub.c:5089 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
>   port_event drivers/usb/core/hub.c:5350 [inline]
>   hub_event+0x1ada/0x3590 drivers/usb/core/hub.c:5432
>   process_one_work+0x905/0x1570 kernel/workqueue.c:2268
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2414
>   kthread+0x30b/0x410 kernel/kthread.c:254
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Freed by task 12:
>   save_stack+0x1b/0x80 mm/kasan/common.c:71
>   set_track mm/kasan/common.c:79 [inline]
>   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:451
>   slab_free_hook mm/slub.c:1421 [inline]
>   slab_free_freelist_hook mm/slub.c:1448 [inline]
>   slab_free mm/slub.c:2994 [inline]
>   kfree+0xd7/0x280 mm/slub.c:3949
>   kvfree+0x59/0x60 mm/util.c:459
>   device_release+0x71/0x200 drivers/base/core.c:1064
>   kobject_cleanup lib/kobject.c:691 [inline]
>   kobject_release lib/kobject.c:720 [inline]
>   kref_put include/linux/kref.h:67 [inline]
>   kobject_put+0x171/0x280 lib/kobject.c:737
>   put_device+0x1b/0x30 drivers/base/core.c:2210
>   free_netdev+0x317/0x420 net/core/dev.c:9265
>   mcba_usb_disconnect+0xca/0xe4 drivers/net/can/usb/mcba_usb.c:890
>   usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
>   __device_release_driver drivers/base/dd.c:1081 [inline]
>   device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1112
>   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
>   device_del+0x460/0xb80 drivers/base/core.c:2274
>   usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
>   usb_disconnect+0x284/0x830 drivers/usb/core/hub.c:2197
>   hub_port_connect drivers/usb/core/hub.c:4940 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
>   port_event drivers/usb/core/hub.c:5350 [inline]
>   hub_event+0x1409/0x3590 drivers/usb/core/hub.c:5432
>   process_one_work+0x905/0x1570 kernel/workqueue.c:2268
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2414
>   kthread+0x30b/0x410 kernel/kthread.c:254
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> The buggy address belongs to the object at ffff8881d44c5500
>   which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 3784 bytes inside of
>   4096-byte region [ffff8881d44c5500, ffff8881d44c6500)
> The buggy address belongs to the page:
> page:ffffea0007513000 refcount:1 mapcount:0 mapping:ffff8881dac02600  
> index:0x0 compound_mapcount: 0
> flags: 0x200000000010200(slab|head)
> raw: 0200000000010200 dead000000000100 dead000000000200 ffff8881dac02600
> raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff8881d44c6280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881d44c6300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff8881d44c6380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                ^
>   ffff8881d44c6400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881d44c6480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================

#sys dup: KASAN: use-after-free Read in mcba_usb_disconnect
