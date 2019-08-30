Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D1FC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3883621897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfH3T2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:28:30 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49577 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfH3T2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:28:09 -0400
Received: by mail-io1-f70.google.com with SMTP id k13so9641539ioh.16
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eYi+Zn08d1CsnsLxKTjynm4R7M42OiHyCSdhNao9910=;
        b=nn62uW4zXSx3iRjnPJB2fCF/En27ALUR6fn2HAzCUfRZ1F0oloL1dwcCBhha8r5bRO
         jbd3ie83Z+cnLM0JM5im5SNLqJcqnldbD0NAYMEC0iE7Wyb+C1nbcxZ10f+qAlm6SEyy
         RjIfHOnHn+0VTLyZgSaz9qgpObR+vRAozQCN6MAI67D10mOtNQKEeJ+E+jHnvKa6W0pD
         uvuLO2r4+TsDXhhmgJJBdhFOJfaHvrVF4ncd5+p2ZxDJdNpLGG7w9MDOX0Ng8xYE//i4
         79pRrLlEzhAaGH7m193xNDJAQqBiKvEe7+a7OVtUBqwQBW4sDy/WFQO/dcosh5X2X0mU
         YW2w==
X-Gm-Message-State: APjAAAVp++ZjA3VJBjNiFwPopNm6o8nXshrsKb/R+MJXcvl2GqoL/7GR
        1rlVq12H9hODtu+OlaV1eylUzoObcIY0O4PhqDepZncPOeaB
X-Google-Smtp-Source: APXvYqwcSUpc2JyCSA4KFngTbJSiU8mhBPJymAyd6LtJtJzcrOQL1rOX56eS3iYa/EY7oekw7YbnkpH0LJNHXIXomlJFtnc5l8VX
MIME-Version: 1.0
X-Received: by 2002:a6b:4a08:: with SMTP id w8mr8266964iob.246.1567193288238;
 Fri, 30 Aug 2019 12:28:08 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:28:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d789d05915a9fa3@google.com>
Subject: memory leak in nr_rx_frame (2)
From:   syzbot <syzbot+0145ea560de205bc09f0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6525771f Merge tag 'arc-5.3-rc7' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10200912600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6131eafb9408877
dashboard link: https://syzkaller.appspot.com/bug?extid=0145ea560de205bc09f0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b51f9c600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0145ea560de205bc09f0@syzkaller.appspotmail.com

2019/08/29 23:31:49 executed programs: 8
2019/08/29 23:31:56 executed programs: 15
2019/08/29 23:32:02 executed programs: 24
BUG: memory leak
unreferenced object 0xffff888123355800 (size 2048):
   comm "softirq", pid 0, jiffies 4295062008 (age 25.620s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     06 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
   backtrace:
     [<00000000bbb1ff80>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000bbb1ff80>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000bbb1ff80>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000bbb1ff80>] __do_kmalloc mm/slab.c:3653 [inline]
     [<00000000bbb1ff80>] __kmalloc+0x169/0x300 mm/slab.c:3664
     [<000000003948180d>] kmalloc include/linux/slab.h:557 [inline]
     [<000000003948180d>] sk_prot_alloc+0x112/0x170 net/core/sock.c:1603
     [<00000000ad5c33ee>] sk_alloc+0x35/0x2f0 net/core/sock.c:1657
     [<000000004e2b1f5c>] nr_make_new net/netrom/af_netrom.c:476 [inline]
     [<000000004e2b1f5c>] nr_rx_frame+0x339/0x8ee net/netrom/af_netrom.c:959
     [<00000000df4c3d82>] nr_loopback_timer+0x4e/0xd0  
net/netrom/nr_loopback.c:59
     [<00000000e886ef23>] call_timer_fn+0x45/0x1e0 kernel/time/timer.c:1322
     [<00000000cc0c55bd>] expire_timers kernel/time/timer.c:1366 [inline]
     [<00000000cc0c55bd>] __run_timers kernel/time/timer.c:1685 [inline]
     [<00000000cc0c55bd>] __run_timers kernel/time/timer.c:1653 [inline]
     [<00000000cc0c55bd>] run_timer_softirq+0x256/0x740  
kernel/time/timer.c:1698
     [<000000008a8ac853>] __do_softirq+0x115/0x33f kernel/softirq.c:292
     [<00000000c33f7c40>] invoke_softirq kernel/softirq.c:373 [inline]
     [<00000000c33f7c40>] irq_exit+0xbb/0xe0 kernel/softirq.c:413
     [<00000000dc851865>] exiting_irq arch/x86/include/asm/apic.h:537  
[inline]
     [<00000000dc851865>] smp_apic_timer_interrupt+0x96/0x190  
arch/x86/kernel/apic/apic.c:1133
     [<000000006a57c22f>] apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:830
     [<00000000ec52384e>] arch_local_irq_restore  
arch/x86/include/asm/paravirt.h:768 [inline]
     [<00000000ec52384e>] console_unlock.part.0+0x5f0/0x6d0  
kernel/printk/printk.c:2471
     [<0000000013f07031>] console_unlock kernel/printk/printk.c:2364 [inline]
     [<0000000013f07031>] vprintk_emit+0x251/0x360  
kernel/printk/printk.c:1986
     [<00000000704abaae>] vprintk_default+0x28/0x30  
kernel/printk/printk.c:2013
     [<000000008aa8a0ba>] vprintk_func+0x59/0xfa  
kernel/printk/printk_safe.c:386
     [<000000004d884645>] printk+0x60/0x7d kernel/printk/printk.c:2046

BUG: memory leak
unreferenced object 0xffff88810e8bd820 (size 32):
   comm "softirq", pid 0, jiffies 4295062008 (age 25.620s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     03 00 00 00 03 00 00 00 0f 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000092f05cd5>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000092f05cd5>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<0000000092f05cd5>] slab_alloc mm/slab.c:3319 [inline]
     [<0000000092f05cd5>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000f2b13853>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000f2b13853>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000f2b13853>] selinux_sk_alloc_security+0x48/0xb0  
security/selinux/hooks.c:5073
     [<000000002301f7f8>] security_sk_alloc+0x49/0x70  
security/security.c:2029
     [<000000009fb5708b>] sk_prot_alloc+0x12d/0x170 net/core/sock.c:1606
     [<00000000ad5c33ee>] sk_alloc+0x35/0x2f0 net/core/sock.c:1657
     [<000000004e2b1f5c>] nr_make_new net/netrom/af_netrom.c:476 [inline]
     [<000000004e2b1f5c>] nr_rx_frame+0x339/0x8ee net/netrom/af_netrom.c:959
     [<00000000df4c3d82>] nr_loopback_timer+0x4e/0xd0  
net/netrom/nr_loopback.c:59
     [<00000000e886ef23>] call_timer_fn+0x45/0x1e0 kernel/time/timer.c:1322
     [<00000000cc0c55bd>] expire_timers kernel/time/timer.c:1366 [inline]
     [<00000000cc0c55bd>] __run_timers kernel/time/timer.c:1685 [inline]
     [<00000000cc0c55bd>] __run_timers kernel/time/timer.c:1653 [inline]
     [<00000000cc0c55bd>] run_timer_softirq+0x256/0x740  
kernel/time/timer.c:1698
     [<000000008a8ac853>] __do_softirq+0x115/0x33f kernel/softirq.c:292
     [<00000000c33f7c40>] invoke_softirq kernel/softirq.c:373 [inline]
     [<00000000c33f7c40>] irq_exit+0xbb/0xe0 kernel/softirq.c:413
     [<00000000dc851865>] exiting_irq arch/x86/include/asm/apic.h:537  
[inline]
     [<00000000dc851865>] smp_apic_timer_interrupt+0x96/0x190  
arch/x86/kernel/apic/apic.c:1133
     [<000000006a57c22f>] apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:830
     [<00000000ec52384e>] arch_local_irq_restore  
arch/x86/include/asm/paravirt.h:768 [inline]
     [<00000000ec52384e>] console_unlock.part.0+0x5f0/0x6d0  
kernel/printk/printk.c:2471
     [<0000000013f07031>] console_unlock kernel/printk/printk.c:2364 [inline]
     [<0000000013f07031>] vprintk_emit+0x251/0x360  
kernel/printk/printk.c:1986
     [<00000000704abaae>] vprintk_default+0x28/0x30  
kernel/printk/printk.c:2013



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
