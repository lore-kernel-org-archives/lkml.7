Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982B2C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633F8216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slO/KAxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfHURLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:11:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42866 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHURLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:11:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so1654949pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8JWzV7y3Wb7muDGuFWpbLuO73H+7Ng5LVsEjkZrV8I=;
        b=slO/KAxwqHBXzcWz6V5kzyK86xi4s+FeU5BmELzpQwHgmbe9CBvvmScgRFwmnbCcc3
         NxijqMb1z12QIfRGcMEBeajBlnYpRDBdRk+KYzMryMLODi3ol9wvR5IMdMBJP5LNz3yl
         RiTFAYbCi73cUmId4LtTFbUsXwQCuMaZDsRLcn13zzUYFjNtQMv0Ha4PgOLBQQA4KbpF
         iQ/9AmezfDv8295RsY2qZj+WtS3jgICCmZYTKBuFGY6r3nMBHEWnfXF6KRZmKS4qtddv
         BCplWP9+SrmtW34yRnCIemSOA7leZSyJ6/QM/Csu0vDgrcNTtJ66JKwSeDe14bbMqGBk
         p8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8JWzV7y3Wb7muDGuFWpbLuO73H+7Ng5LVsEjkZrV8I=;
        b=c5myVFmClxq671Q4sjyLI7JatsHtmXYOf6mk+udaFnUS9VatYCJIGeAbAp6oSMfE+j
         vzwUshtRsjWuzHtHrvcHnnBPa3Q/KTtp/HBsE2gLf084pyzhSBeulwYJpRAY40fb513H
         dfdx5SvpfSCLGcfCz8r6E5G95S4ZBFeGE4UHqk5Q1k8+/PY0x4r39zM+1+gKvK2gyvVd
         mCQdz1ZQGVc11pnonP9f2DpgnzJ+YNW0QB4+1+O3UlmpfZz7KMo7t4TN1U03GFp5jTC4
         p5oo4huKemipt7cuoulvb/MAUQEV+CW2qpl6FTxOHDRxyhjuW2lxScHzPIdgqnV1UH+k
         vWlA==
X-Gm-Message-State: APjAAAXTf8h8di/a8EVKImjcjUVbaGJKYX7Pvef26pnt85JgQVscTinV
        zn2E0VOxmYgGJkmrL1UTnKgGG1SsoPTtbGgMcCkHlA==
X-Google-Smtp-Source: APXvYqxHNIQ4psiRGEEQu7+v00mea4FGxKiGmaVYgN9pnrhBPEJsWqW+yBy3HpFRpOy9HqUojgyquaRV7A2SBrIrTH4=
X-Received: by 2002:a17:90a:858c:: with SMTP id m12mr993450pjn.129.1566407461198;
 Wed, 21 Aug 2019 10:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ffc8c80587aa1bb1@google.com>
In-Reply-To: <000000000000ffc8c80587aa1bb1@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 19:10:50 +0200
Message-ID: <CAAeHK+zHyxxEWk0ZoORXOOc7qdigGaEBSX1C-Wg8G8u8Twa0tg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in au0828_usb_disconnect
To:     syzbot <syzbot+15e91d49c4c757c3d363@syzkaller.appspotmail.com>
Cc:     brad@nextdimension.cc, Hans Verkuil <hans.verkuil@cisco.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        USB list <linux-usb@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 2:06 PM syzbot
<syzbot+15e91d49c4c757c3d363@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=106c9498a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
> dashboard link: https://syzkaller.appspot.com/bug?extid=15e91d49c4c757c3d363
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+15e91d49c4c757c3d363@syzkaller.appspotmail.com
>
> usb 5-1: selecting invalid altsetting 5
> au0828: Failure setting usb interface0 to as5
> au0828: au0828_usb_probe() au0828_analog_register failed to register on V4L2
> BUG: unable to handle kernel paging request at fffffffc4508a958
> #PF error: [normal kernel read fault]
> PGD 1167e067 P4D 1167e067 PUD 0
> Oops: 0000 [#1] SMP KASAN PTI
> CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.1.0-rc3-319004-g43151d6 #6
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:decode_cpu kernel/locking/osq_lock.c:34 [inline]
> RIP: 0010:osq_lock+0xfd/0x5a0 kernel/locking/osq_lock.c:111
> Code: 48 63 e8 48 b8 00 00 00 00 00 fc ff df 48 8d 3c ed 60 b0 39 91 48 89
> f9 48 c1 e9 03 80 3c 01 00 0f 85 2c 04 00 00 48 8d 53 08 <4c> 03 2c ed 60
> b0 39 91 48 b8 00 00 00 00 00 fc ff df 48 89 d6 48
> RSP: 0018:ffff8880a84f70e8 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff8880ad12dfc0 RCX: 1fffffff88a1152b
> RDX: ffff8880ad12dfc8 RSI: 0000000000000004 RDI: fffffffc4508a958
> RBP: ffffffff9679df1f R08: 0000000000000000 R09: ffffed10122cb31e
> R10: ffffed10122cb31d R11: ffff8880916598eb R12: ffff8880ad12dfd0
> R13: 000000000002dfc0 R14: ffff8880a84db100 R15: ffff8880916598e8
> FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffc4508a958 CR3: 00000000824b6000 CR4: 00000000001406e0
> Call Trace:
>   mutex_optimistic_spin kernel/locking/mutex.c:630 [inline]
>   __mutex_lock_common kernel/locking/mutex.c:928 [inline]
>   __mutex_lock+0x27d/0x12b0 kernel/locking/mutex.c:1072
>   au0828_usb_disconnect+0xa3/0x130 drivers/media/usb/au0828/au0828-core.c:194
>   au0828_usb_probe.cold+0x121/0x7d8
> drivers/media/usb/au0828/au0828-core.c:661
>   usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
>   really_probe+0x2da/0xb10 drivers/base/dd.c:509
>   driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
>   __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
>   bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x223/0x3a0 drivers/base/dd.c:844
>   bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
>   device_add+0xad2/0x16e0 drivers/base/core.c:2106
>   usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2023
>   generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
>   usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
>   really_probe+0x2da/0xb10 drivers/base/dd.c:509
>   driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
>   __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
>   bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x223/0x3a0 drivers/base/dd.c:844
>   bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
>   device_add+0xad2/0x16e0 drivers/base/core.c:2106
>   usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
>   hub_port_connect drivers/usb/core/hub.c:5089 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
>   port_event drivers/usb/core/hub.c:5350 [inline]
>   hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
>   process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
>   worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
>   kthread+0x313/0x420 kernel/kthread.c:253
>   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> Modules linked in:
> CR2: fffffffc4508a958
> ---[ end trace e04421c5fdf22ecf ]---
> RIP: 0010:decode_cpu kernel/locking/osq_lock.c:34 [inline]
> RIP: 0010:osq_lock+0xfd/0x5a0 kernel/locking/osq_lock.c:111
> Code: 48 63 e8 48 b8 00 00 00 00 00 fc ff df 48 8d 3c ed 60 b0 39 91 48 89
> f9 48 c1 e9 03 80 3c 01 00 0f 85 2c 04 00 00 48 8d 53 08 <4c> 03 2c ed 60
> b0 39 91 48 b8 00 00 00 00 00 fc ff df 48 89 d6 48
> RSP: 0018:ffff8880a84f70e8 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff8880ad12dfc0 RCX: 1fffffff88a1152b
> RDX: ffff8880ad12dfc8 RSI: 0000000000000004 RDI: fffffffc4508a958
> RBP: ffffffff9679df1f R08: 0000000000000000 R09: ffffed10122cb31e
> R10: ffffed10122cb31d R11: ffff8880916598eb R12: ffff8880ad12dfd0
> R13: 000000000002dfc0 R14: ffff8880a84db100 R15: ffff8880916598e8
> FS:  0000000000000000(0000) GS:ffff8880ad100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffc4508a958 CR3: 00000000824b6000 CR4: 00000000001406e0
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

#syz dup: KASAN: slab-out-of-bounds Read in au0828_rc_unregister (2)
