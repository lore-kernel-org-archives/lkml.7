Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03941C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE61A2238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbfGXTSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:18:34 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38328 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfGXTSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:18:08 -0400
Received: by mail-io1-f70.google.com with SMTP id h4so52227543iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WTTYbLE73AWlaT+4DUpRkatPF3o10cRfnbNcZrdiW7k=;
        b=V46gZjULwm1crmo+siCDLKPkvcMFpTlJt/ZOh2zw3F4YhIt4WNxVTq3FXxNIl7ofuv
         0eoAF/5jnL4fxmtkIYLQnR8jmzeT/msEO3A+dXa1IiVO8wfJvBgSzFfGL8cEy4A/OyY0
         uM8R4EeEXv6bkiS04KOcUtOTKz/vQNOMEtg9b+FUcQJ+bIK40Qn3takHQOjov6j6ENFm
         gRW8iG2yJ5DdYyb3Ua9GSmqSAGHUnhmlbmKeCk9Ku5AzhGABWJviFjDfqNMxMDStUtgU
         QwVKg4OZ6DRUTZmSbga9xBVpW+uX620CX4p9AZOGInvvuwhcShORHTh1UY4fJduq4yui
         L3kQ==
X-Gm-Message-State: APjAAAVZlu41GMyJnemqXdWYshoBXDI62Ji3PuiYmbDMwsZLaE2rf/gz
        HhVE3BlWP+Md8hKo5hU48l6+/+XidTtV3RQIec15Ky5gENRY
X-Google-Smtp-Source: APXvYqzfdGDIebjboIFMguNwKODZmojQT3sEkbs06YCmnVrHK53S2FZaVnW2oYYy9NsTU9Yqk2XE2ERshhGzs9H51ajBfjEKzgop
MIME-Version: 1.0
X-Received: by 2002:a6b:6d08:: with SMTP id a8mr69580148iod.191.1563995887803;
 Wed, 24 Jul 2019 12:18:07 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:18:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052ad6b058e722ba4@google.com>
Subject: memory leak in vq_meta_prefetch
From:   syzbot <syzbot+a871c1e6ea00685e73d7@syzkaller.appspotmail.com>
To:     alexandre.belloni@free-electrons.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nicolas.ferre@atmel.com, robh@kernel.org, sre@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fffef4600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de7d700ea5ac607
dashboard link: https://syzkaller.appspot.com/bug?extid=a871c1e6ea00685e73d7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127b0334600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12609e94600000

The bug was bisected to:

commit 0e5f7d0b39e1f184dc25e3adb580c79e85332167
Author: Nicolas Ferre <nicolas.ferre@atmel.com>
Date:   Wed Mar 16 13:19:49 2016 +0000

     ARM: dts: at91: shdwc binding: add new shutdown controller documentation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c6d53fa00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15c6d53fa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11c6d53fa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a871c1e6ea00685e73d7@syzkaller.appspotmail.com
Fixes: 0e5f7d0b39e1 ("ARM: dts: at91: shdwc binding: add new shutdown  
controller documentation")

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88811b327cc0 (size 32):
   comm "vhost-7201", pid 7205, jiffies 4294952492 (age 19.700s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009e106308>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<000000009e106308>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<000000009e106308>] slab_alloc /mm/slab.c:3319 [inline]
     [<000000009e106308>] kmem_cache_alloc_trace+0x145/0x280 /mm/slab.c:3548
     [<00000000ed2eec2d>] kmalloc /./include/linux/slab.h:552 [inline]
     [<00000000ed2eec2d>] vhost_map_prefetch /drivers/vhost/vhost.c:877  
[inline]
     [<00000000ed2eec2d>] vhost_vq_map_prefetch /drivers/vhost/vhost.c:1838  
[inline]
     [<00000000ed2eec2d>] vq_meta_prefetch+0x18e/0x350  
/drivers/vhost/vhost.c:1849
     [<000000009d9c11b8>] handle_rx+0x9d/0xc00 /drivers/vhost/net.c:1128
     [<000000008f883d86>] handle_rx_net+0x19/0x20 /drivers/vhost/net.c:1270
     [<00000000577ffdd8>] vhost_worker+0xc6/0x120 /drivers/vhost/vhost.c:519
     [<000000001201f3db>] kthread+0x13e/0x160 /kernel/kthread.c:255
     [<00000000093cd85a>] ret_from_fork+0x1f/0x30  
/arch/x86/entry/entry_64.S:352

BUG: memory leak
unreferenced object 0xffff88811b327cc0 (size 32):
   comm "vhost-7201", pid 7205, jiffies 4294952492 (age 20.600s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009e106308>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<000000009e106308>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<000000009e106308>] slab_alloc /mm/slab.c:3319 [inline]
     [<000000009e106308>] kmem_cache_alloc_trace+0x145/0x280 /mm/slab.c:3548
     [<00000000ed2eec2d>] kmalloc /./include/linux/slab.h:552 [inline]
     [<00000000ed2eec2d>] vhost_map_prefetch /drivers/vhost/vhost.c:877  
[inline]
     [<00000000ed2eec2d>] vhost_vq_map_prefetch /drivers/vhost/vhost.c:1838  
[inline]
     [<00000000ed2eec2d>] vq_meta_prefetch+0x18e/0x350  
/drivers/vhost/vhost.c:1849
     [<000000009d9c11b8>] handle_rx+0x9d/0xc00 /drivers/vhost/net.c:1128
     [<000000008f883d86>] handle_rx_net+0x19/0x20 /drivers/vhost/net.c:1270
     [<00000000577ffdd8>] vhost_worker+0xc6/0x120 /drivers/vhost/vhost.c:519
     [<000000001201f3db>] kthread+0x13e/0x160 /kernel/kthread.c:255
     [<00000000093cd85a>] ret_from_fork+0x1f/0x30  
/arch/x86/entry/entry_64.S:352



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
