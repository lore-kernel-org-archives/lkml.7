Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D8C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C80221881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfIQJnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:43:09 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52857 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfIQJnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:43:08 -0400
Received: by mail-io1-f72.google.com with SMTP id g8so4845289iop.19
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 02:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uh6PoBzT683nq7GzMl97faij38tm0DCB1vQJQAu00EE=;
        b=laDZt1S3EzTUbbV3UnSj2wenJU/w3THt0uhhWextp5e807XMLbOTMdnOQpSnlm8Are
         NVdZwK8llK7ynwdxVdPZ8Wxgqg0BOv2qDowOx0NH/j4IgyPFXWaHjjd+kWPuq0QAHTTR
         wrpOps59ppiv9AJpJvZmjJQ5IfSYy6qEXXgA0461C2fdlKg+hQmAqLv+wEV+3+wyxvJk
         VbwGTo+6QUHXwG4tudyYe0NxD9vfomZbx1MDQLAnlXGNKtu9NxA/13ZppcGtynT1Oh8r
         WCwE9YdfZh3firtiCCjswDo6Wrcm6X7HBtjlwafgnp7jY9q0HbQE6dX08lTGQvSS9dLo
         uSDw==
X-Gm-Message-State: APjAAAUwAXTlU6McIFJk4hjHYGp65/6p3eGVovvCIq5pPDsaU+GUR7ME
        cZV2y6R0OARHvStOIDd9KyuHYy4UPrWBY5m9tdsVvUk2xhEK
X-Google-Smtp-Source: APXvYqwONeIKVxQVj9cwWmdwB1BJtIbb+WJhwPQ/Ubhy/YwyEXnC9C2so4i33dpXHmj6ZSYLq5gv9P9uIrraM5UTjZHkjoUc/u2v
MIME-Version: 1.0
X-Received: by 2002:a6b:fe11:: with SMTP id x17mr2790321ioh.6.1568713386329;
 Tue, 17 Sep 2019 02:43:06 -0700 (PDT)
Date:   Tue, 17 Sep 2019 02:43:06 -0700
In-Reply-To: <00000000000053d7e9058a97f4ca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002590570592bc8c42@google.com>
Subject: Re: memory leak in cfserl_create
From:   syzbot <syzbot+7ec324747ce876a29db6@syzkaller.appspotmail.com>
To:     alexios.zavras@intel.com, allison@lohutok.net, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rfontana@redhat.com, swinslow@gmail.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    cef72982 Merge tag 'armsoc-dt' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1042ac45600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=779aef2b86e19d75
dashboard link: https://syzkaller.appspot.com/bug?extid=7ec324747ce876a29db6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ef2331600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f0c091600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7ec324747ce876a29db6@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810a3b7380 (size 128):
   comm "syz-executor868", pid 7100, jiffies 4294943513 (age 21.740s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000004f492e65>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000004f492e65>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000004f492e65>] slab_alloc mm/slab.c:3319 [inline]
     [<000000004f492e65>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000478a63c3>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000478a63c3>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000478a63c3>] cfserl_create+0x24/0x76 net/caif/cfserl.c:36
     [<0000000097ca7138>] caif_device_notify+0x347/0x3bc  
net/caif/caif_dev.c:388
     [<0000000078bf2b15>] notifier_call_chain+0x66/0xb0 kernel/notifier.c:95
     [<000000001a557d7e>] __raw_notifier_call_chain kernel/notifier.c:396  
[inline]
     [<000000001a557d7e>] raw_notifier_call_chain+0x2e/0x40  
kernel/notifier.c:403
     [<00000000de93bbde>] call_netdevice_notifiers_info+0x33/0x70  
net/core/dev.c:1749
     [<0000000004467db0>] call_netdevice_notifiers_extack  
net/core/dev.c:1761 [inline]
     [<0000000004467db0>] call_netdevice_notifiers net/core/dev.c:1775  
[inline]
     [<0000000004467db0>] register_netdevice+0x445/0x610 net/core/dev.c:8757
     [<000000007e97ac10>] ldisc_open+0x1f7/0x350  
drivers/net/caif/caif_serial.c:359
     [<000000003eb33d8f>] tty_ldisc_open.isra.0+0x44/0x70  
drivers/tty/tty_ldisc.c:469
     [<00000000ded1208b>] tty_set_ldisc+0x149/0x240  
drivers/tty/tty_ldisc.c:596
     [<00000000df974937>] tiocsetd drivers/tty/tty_io.c:2334 [inline]
     [<00000000df974937>] tty_ioctl+0x366/0xa30 drivers/tty/tty_io.c:2594
     [<00000000739f048c>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000739f048c>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000739f048c>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000e122cb0c>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<0000000067a2ba29>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<0000000067a2ba29>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<0000000067a2ba29>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000071a2e1c5>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000c342e2c0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810a3b7400 (size 128):
   comm "syz-executor868", pid 7101, jiffies 4294943519 (age 21.680s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000004f492e65>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000004f492e65>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000004f492e65>] slab_alloc mm/slab.c:3319 [inline]
     [<000000004f492e65>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000478a63c3>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000478a63c3>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000478a63c3>] cfserl_create+0x24/0x76 net/caif/cfserl.c:36
     [<0000000097ca7138>] caif_device_notify+0x347/0x3bc  
net/caif/caif_dev.c:388
     [<0000000078bf2b15>] notifier_call_chain+0x66/0xb0 kernel/notifier.c:95
     [<000000001a557d7e>] __raw_notifier_call_chain kernel/notifier.c:396  
[inline]
     [<000000001a557d7e>] raw_notifier_call_chain+0x2e/0x40  
kernel/notifier.c:403
     [<00000000de93bbde>] call_netdevice_notifiers_info+0x33/0x70  
net/core/dev.c:1749
     [<0000000004467db0>] call_netdevice_notifiers_extack  
net/core/dev.c:1761 [inline]
     [<0000000004467db0>] call_netdevice_notifiers net/core/dev.c:1775  
[inline]
     [<0000000004467db0>] register_netdevice+0x445/0x610 net/core/dev.c:8757
     [<000000007e97ac10>] ldisc_open+0x1f7/0x350  
drivers/net/caif/caif_serial.c:359
     [<000000003eb33d8f>] tty_ldisc_open.isra.0+0x44/0x70  
drivers/tty/tty_ldisc.c:469
     [<00000000ded1208b>] tty_set_ldisc+0x149/0x240  
drivers/tty/tty_ldisc.c:596
     [<00000000df974937>] tiocsetd drivers/tty/tty_io.c:2334 [inline]
     [<00000000df974937>] tty_ioctl+0x366/0xa30 drivers/tty/tty_io.c:2594
     [<00000000739f048c>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000739f048c>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000739f048c>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000e122cb0c>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<0000000067a2ba29>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<0000000067a2ba29>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<0000000067a2ba29>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000071a2e1c5>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000c342e2c0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810a3b7780 (size 128):
   comm "syz-executor868", pid 7138, jiffies 4294943524 (age 21.630s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000004f492e65>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000004f492e65>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000004f492e65>] slab_alloc mm/slab.c:3319 [inline]
     [<000000004f492e65>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000478a63c3>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000478a63c3>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000478a63c3>] cfserl_create+0x24/0x76 net/caif/cfserl.c:36
     [<0000000097ca7138>] caif_device_notify+0x347/0x3bc  
net/caif/caif_dev.c:388
     [<0000000078bf2b15>] notifier_call_chain+0x66/0xb0 kernel/notifier.c:95
     [<000000001a557d7e>] __raw_notifier_call_chain kernel/notifier.c:396  
[inline]
     [<000000001a557d7e>] raw_notifier_call_chain+0x2e/0x40  
kernel/notifier.c:403
     [<00000000de93bbde>] call_netdevice_notifiers_info+0x33/0x70  
net/core/dev.c:1749
     [<0000000004467db0>] call_netdevice_notifiers_extack  
net/core/dev.c:1761 [inline]
     [<0000000004467db0>] call_netdevice_notifiers net/core/dev.c:1775  
[inline]
     [<0000000004467db0>] register_netdevice+0x445/0x610 net/core/dev.c:8757
     [<000000007e97ac10>] ldisc_open+0x1f7/0x350  
drivers/net/caif/caif_serial.c:359
     [<000000003eb33d8f>] tty_ldisc_open.isra.0+0x44/0x70  
drivers/tty/tty_ldisc.c:469
     [<00000000ded1208b>] tty_set_ldisc+0x149/0x240  
drivers/tty/tty_ldisc.c:596
     [<00000000df974937>] tiocsetd drivers/tty/tty_io.c:2334 [inline]
     [<00000000df974937>] tty_ioctl+0x366/0xa30 drivers/tty/tty_io.c:2594
     [<00000000739f048c>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000739f048c>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000739f048c>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000e122cb0c>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<0000000067a2ba29>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<0000000067a2ba29>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<0000000067a2ba29>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000071a2e1c5>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000c342e2c0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

executing program
executing program
executing program
executing program

