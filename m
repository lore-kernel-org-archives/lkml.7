Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4ECC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D1120449
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlLKxSii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfHAQB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:01:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42324 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbfHAQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:01:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so34305764pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQxZLZRTutL5Xn+lwvkaAPkB8pSid22ILZpW3pkhg8k=;
        b=OlLKxSiiEr7ZIBVX/Udv1l5OqYxfcsUCnWkzLAiMJ7GDR3ws1Bx9T5y+IAnSjymzz6
         0MwA8bVIWIJ3DSLGu4UmRqENsmSov9/MkTrRbGyHRA1MHLQ2QtwonXRSm+qk8gh0vSW4
         wLw/B58RcJj1E2H/AIHXyvKcw+PqmFL6gaPxTPP5QlpNI918popz3aPJugduM9arx8YB
         IxQkXA9EXM8TBrSM5KEak+xvAaYLg9q8qOOKFnnMihjlee1MHgzpbtZDGwMou+fvuTRt
         0oiZqQbARdP3SrK+ns9TZKuWvxnl0wPHGDSTCb3qq3pXcMGR6NgmN507aV4FE2ziotDI
         u+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQxZLZRTutL5Xn+lwvkaAPkB8pSid22ILZpW3pkhg8k=;
        b=Hle25+fwwidrI47BXFkEPm5nQwVMDrfmJlcihwJCtgQzu4RH4/cqcfq/QYHTt7+W72
         tSH2+aBS0H1VZ6/nsrVI+KIM9oWuvSoqIY2T2bFs7dYaZYv6LjDzqts2zphoMYvUoaqU
         vKGC65ap9hcURJux4A726tELRN9dxsyDrFte1PRuwzAApa7C//BOKuv5Nx5O9x5XfeV0
         dpG6AqEel1pyrPMWH0rDRC1pr4H5KWK2B6A8idzR6Td8w5eewjuMOGBLn31+f2yzZHZk
         2Pu2/pNrjbDAD5JcyD31LKIK1OktkgjsGdryK7EsKEt1QYvN1WXoLnax3wnzulzhbM7I
         /UYw==
X-Gm-Message-State: APjAAAWJlXc+8DW/+h3UfZnKAKhivJQQuAzA+Z3B3iosPc0WgM4ZQ9y8
        rwWa6f2Je4q0JDLkLzOioq62m6U+uhEw4koVRxBWjTWk7OA=
X-Google-Smtp-Source: APXvYqy1eiHI1RM1QkV1eH5Kybp/IFhvotCFYBI+1/RQolQyYljqufvrpfcA37lUHRLf+v/4ujkL+XbF8Xd47md967Q=
X-Received: by 2002:a63:3006:: with SMTP id w6mr42192705pgw.440.1564675283933;
 Thu, 01 Aug 2019 09:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000044d8d0058e5a00da@google.com>
In-Reply-To: <00000000000044d8d0058e5a00da@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 1 Aug 2019 18:01:12 +0200
Message-ID: <CAAeHK+w4e=+qXOaas_Vmm0xnxLFkocN9uRJVxuYmvHhT0hSn1w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 4:28 PM syzbot
<syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f640cc600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> dashboard link: https://syzkaller.appspot.com/bug?extid=1b2449b7b5dc240d107a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116ce31fa00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1022f694600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com
>
> usb 1-1: USB disconnect, device number 2
> ==================================================================
> BUG: KASAN: use-after-free in __lock_acquire+0x3a5d/0x5340
> /kernel/locking/lockdep.c:3665
> Read of size 8 at addr ffff8881cfc4ef90 by task kworker/0:2/108
>
> CPU: 0 PID: 108 Comm: kworker/0:2 Not tainted 5.2.0-rc6+ #15
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack /lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e /lib/dump_stack.c:113
>   print_address_description+0x67/0x231 /mm/kasan/report.c:188
>   __kasan_report.cold+0x1a/0x32 /mm/kasan/report.c:317
>   kasan_report+0xe/0x20 /mm/kasan/common.c:614
>   __lock_acquire+0x3a5d/0x5340 /kernel/locking/lockdep.c:3665
>   lock_acquire+0x100/0x2b0 /kernel/locking/lockdep.c:4303
>   __mutex_lock_common /kernel/locking/mutex.c:926 [inline]
>   __mutex_lock+0xf9/0x12b0 /kernel/locking/mutex.c:1073
>   device_release_driver_internal+0x23/0x4c0 /drivers/base/dd.c:1109
>   bus_remove_device+0x2dc/0x4a0 /drivers/base/bus.c:556
>   device_del+0x460/0xb80 /drivers/base/core.c:2274
>   usb_disable_device+0x211/0x690 /drivers/usb/core/message.c:1237
>   usb_disconnect+0x284/0x830 /drivers/usb/core/hub.c:2199
>   hub_port_connect /drivers/usb/core/hub.c:4949 [inline]
>   hub_port_connect_change /drivers/usb/core/hub.c:5213 [inline]
>   port_event /drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x13bd/0x3550 /drivers/usb/core/hub.c:5441
>   process_one_work+0x905/0x1570 /kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 /kernel/workqueue.c:2415
>   kthread+0x30b/0x410 /kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
>
> Allocated by task 88:
>   save_stack+0x1b/0x80 /mm/kasan/common.c:71
>   set_track /mm/kasan/common.c:79 [inline]
>   __kasan_kmalloc /mm/kasan/common.c:489 [inline]
>   __kasan_kmalloc.constprop.0+0xbf/0xd0 /mm/kasan/common.c:462
>   kmalloc /./include/linux/slab.h:547 [inline]
>   kzalloc /./include/linux/slab.h:742 [inline]
>   usb_set_configuration+0x2c4/0x1670 /drivers/usb/core/message.c:1846
>   generic_probe+0x9d/0xd5 /drivers/usb/core/generic.c:210
>   usb_probe_device+0x99/0x100 /drivers/usb/core/driver.c:266
>   really_probe+0x281/0x660 /drivers/base/dd.c:509
>   driver_probe_device+0x104/0x210 /drivers/base/dd.c:670
>   __device_attach_driver+0x1c2/0x220 /drivers/base/dd.c:777
>   bus_for_each_drv+0x15c/0x1e0 /drivers/base/bus.c:454
>   __device_attach+0x217/0x360 /drivers/base/dd.c:843
>   bus_probe_device+0x1e4/0x290 /drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 /drivers/base/core.c:2111
>   usb_new_device.cold+0x6a4/0xe61 /drivers/usb/core/hub.c:2536
>   hub_port_connect /drivers/usb/core/hub.c:5098 [inline]
>   hub_port_connect_change /drivers/usb/core/hub.c:5213 [inline]
>   port_event /drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x1abd/0x3550 /drivers/usb/core/hub.c:5441
>   process_one_work+0x905/0x1570 /kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 /kernel/workqueue.c:2415
>   kthread+0x30b/0x410 /kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
>
> Freed by task 108:
>   save_stack+0x1b/0x80 /mm/kasan/common.c:71
>   set_track /mm/kasan/common.c:79 [inline]
>   __kasan_slab_free+0x130/0x180 /mm/kasan/common.c:451
>   slab_free_hook /mm/slub.c:1421 [inline]
>   slab_free_freelist_hook /mm/slub.c:1448 [inline]
>   slab_free /mm/slub.c:2994 [inline]
>   kfree+0xd7/0x280 /mm/slub.c:3949
>   device_release+0x71/0x200 /drivers/base/core.c:1064
>   kobject_cleanup /lib/kobject.c:691 [inline]
>   kobject_release /lib/kobject.c:720 [inline]
>   kref_put /./include/linux/kref.h:65 [inline]
>   kobject_put+0x171/0x280 /lib/kobject.c:737
>   put_device+0x1b/0x30 /drivers/base/core.c:2210
>   klist_put+0xce/0x170 /lib/klist.c:221
>   bus_remove_device+0x3a4/0x4a0 /drivers/base/bus.c:552
>   device_del+0x460/0xb80 /drivers/base/core.c:2274
>   usb_disable_device+0x211/0x690 /drivers/usb/core/message.c:1237
>   usb_disconnect+0x284/0x830 /drivers/usb/core/hub.c:2199
>   hub_port_connect /drivers/usb/core/hub.c:4949 [inline]
>   hub_port_connect_change /drivers/usb/core/hub.c:5213 [inline]
>   port_event /drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x13bd/0x3550 /drivers/usb/core/hub.c:5441
>   process_one_work+0x905/0x1570 /kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 /kernel/workqueue.c:2415
>   kthread+0x30b/0x410 /kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
>
> The buggy address belongs to the object at ffff8881cfc4ee80
>   which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 272 bytes inside of
>   2048-byte region [ffff8881cfc4ee80, ffff8881cfc4f680)
> The buggy address belongs to the page:
> page:ffffea00073f1200 refcount:1 mapcount:0 mapping:ffff8881dac02800
> index:0x0 compound_mapcount: 0
> flags: 0x200000000010200(slab|head)
> raw: 0200000000010200 dead000000000100 dead000000000200 ffff8881dac02800
> raw: 0000000000000000 00000000000f000f 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8881cfc4ee80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881cfc4ef00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff8881cfc4ef80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                           ^
>   ffff8881cfc4f000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881cfc4f080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================

Hi Alan,

Could you take a look at this report? This looks like some kind of bug
in USB core code, but I can't really figure out what's going on here.

Thanks!

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
