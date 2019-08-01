Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E512BC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B30206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfHAKwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:52:05 -0400
Received: from foss.arm.com ([217.140.110.172]:33898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfHAKwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:52:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3022C1570;
        Thu,  1 Aug 2019 03:52:04 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4D793F575;
        Thu,  1 Aug 2019 03:52:02 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in usb_free_coherent
To:     syzbot+d1fedb1c1fdb07fca507@syzkaller.appspotmail.com,
        andreyknvl@google.com, dtor@chromium.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mans@mansr.com,
        mathias.payer@nebelwelt.net, robh@kernel.org,
        srinivas.kandagatla@linaro.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
References: <0000000000003f86d8058f0bd671@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <8d2b9cb5-d32c-e24c-c973-a3a11a436dc6@arm.com>
Date:   Thu, 1 Aug 2019 11:52:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0000000000003f86d8058f0bd671@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 01/08/2019 11:38, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7f7867ff usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=13efa030600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> dashboard link: https://syzkaller.appspot.com/bug?extid=d1fedb1c1fdb07fca507
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d1fedb1c1fdb07fca507@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in usb_free_coherent+0x79/0x80
> drivers/usb/core/usb.c:928
> Read of size 8 at addr ffff8881b18599c8 by task syz-executor.4/16007
> 
> CPU: 0 PID: 16007 Comm: syz-executor.4 Not tainted 5.3.0-rc2+ #23
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>    __dump_stack lib/dump_stack.c:77 [inline]
>    dump_stack+0xca/0x13e lib/dump_stack.c:113
>    print_address_description+0x6a/0x32c mm/kasan/report.c:351
>    __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
>    kasan_report+0xe/0x12 mm/kasan/common.c:612
>    usb_free_coherent+0x79/0x80 drivers/usb/core/usb.c:928
>    yurex_delete+0x138/0x330 drivers/usb/misc/yurex.c:100
>    kref_put include/linux/kref.h:65 [inline]
>    yurex_release+0x66/0x90 drivers/usb/misc/yurex.c:392
>    __fput+0x2d7/0x840 fs/file_table.c:280
>    task_work_run+0x13f/0x1c0 kernel/task_work.c:113
>    tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>    exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
>    prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>    syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
>    do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x413511
> Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48
> 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48
> 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007ffc424ea2e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000413511
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
> RBP: 0000000000000001 R08: 0000000029a2fc22 R09: 0000000029a2fc26
> R10: 00007ffc424ea3c0 R11: 0000000000000293 R12: 000000000075c9a0
> R13: 000000000075c9a0 R14: 0000000000761938 R15: ffffffffffffffff
> 
> Allocated by task 2776:
>    save_stack+0x1b/0x80 mm/kasan/common.c:69
>    set_track mm/kasan/common.c:77 [inline]
>    __kasan_kmalloc mm/kasan/common.c:487 [inline]
>    __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
>    kmalloc include/linux/slab.h:552 [inline]
>    kzalloc include/linux/slab.h:748 [inline]
>    usb_alloc_dev+0x51/0xf95 drivers/usb/core/usb.c:583
>    hub_port_connect drivers/usb/core/hub.c:5004 [inline]
>    hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>    port_event drivers/usb/core/hub.c:5359 [inline]
>    hub_event+0x15c0/0x3640 drivers/usb/core/hub.c:5441
>    process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
>    worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>    kthread+0x318/0x420 kernel/kthread.c:255
>    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Freed by task 16007:
>    save_stack+0x1b/0x80 mm/kasan/common.c:69
>    set_track mm/kasan/common.c:77 [inline]
>    __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
>    slab_free_hook mm/slub.c:1423 [inline]
>    slab_free_freelist_hook mm/slub.c:1470 [inline]
>    slab_free mm/slub.c:3012 [inline]
>    kfree+0xe4/0x2f0 mm/slub.c:3953
>    device_release+0x71/0x200 drivers/base/core.c:1064
>    kobject_cleanup lib/kobject.c:693 [inline]
>    kobject_release lib/kobject.c:722 [inline]
>    kref_put include/linux/kref.h:65 [inline]
>    kobject_put+0x171/0x280 lib/kobject.c:739
>    put_device+0x1b/0x30 drivers/base/core.c:2213
>    usb_put_dev+0x1f/0x30 drivers/usb/core/usb.c:725
>    yurex_delete+0x40/0x330 drivers/usb/misc/yurex.c:95
>    kref_put include/linux/kref.h:65 [inline]
>    yurex_release+0x66/0x90 drivers/usb/misc/yurex.c:392
>    __fput+0x2d7/0x840 fs/file_table.c:280
>    task_work_run+0x13f/0x1c0 kernel/task_work.c:113
>    tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>    exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
>    prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>    syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
>    do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 

Looks like the yurex_delete() drops the ref count on the dev->udev
way early in the function and then later tries to see if there
are any other buffers associated with it worth releasing. So,
I am guessing moving the usb_put_dev(), after we have finished
all that might solve the issue ?

----8>----

diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 7b306aa22d25..e38fe3a53c97 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -92,7 +92,6 @@ static void yurex_delete(struct kref *kref)

  	dev_dbg(&dev->interface->dev, "%s\n", __func__);

-	usb_put_dev(dev->udev);
  	if (dev->cntl_urb) {
  		usb_kill_urb(dev->cntl_urb);
  		kfree(dev->cntl_req);
@@ -108,6 +107,8 @@ static void yurex_delete(struct kref *kref)
  				dev->int_buffer, dev->urb->transfer_dma);
  		usb_free_urb(dev->urb);
  	}
+
+	usb_put_dev(dev->udev);
  	kfree(dev);
  }


