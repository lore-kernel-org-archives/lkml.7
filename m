Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1404EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53FD2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfEUNnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:43:08 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:55864 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfEUNnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:43:07 -0400
Received: by mail-it1-f198.google.com with SMTP id o126so2762413itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=54ufEAB1oxrNKH65AwjRyfhqbrCEVbl23HdOFMs6GkM=;
        b=UifLvryKmSSBG1ud6DUcpFzyT/kFVWlIcktZKE9sUm8PC2k6RGIpT1ClFgLxkcBCNO
         ZLkK4duje/ADziELgNuR96GDgJjzAriTKoIs6aib+YoroDS8rVW6ysuGYQFstXG9B3Em
         AJT84EdDRFJKI7s9+AQ1qmx8I1Kl/9Lun1FUrEkBEa0oGVvxqAE/vjbUP6V4UmLgdFWj
         5jnNqbEYHgiDTtWyl/5Y1RUpWDfPr3MICn/FWd6Cg3vBcmwS5nu1QCwGu+XiaBoMDYPy
         Y2ZugkXgvGzET0v0gobLQTqkhCy4RnjhvIbaaqcMkTvDIKLvll7UElUxQcbLfUWElXm7
         g2fg==
X-Gm-Message-State: APjAAAVwQAgrPhGB1tLe605nItl+XIaYaW8nQp350DfA1gEEpaSescji
        T3Zu84P+YARGu1rcnMqv/HoX6iB4AgSrrPdi0HdkxOoBvIcw
X-Google-Smtp-Source: APXvYqw1gpqakpN6VvED6hGdUnvXHxR9rpx+ctUlx7M4wffyN3X13DGEGL7+jH81W1wrJD1HEVTNnBdsN7MP9EFDfp/DZ//KZ26Z
MIME-Version: 1.0
X-Received: by 2002:a24:5547:: with SMTP id e68mr4026789itb.83.1558446186713;
 Tue, 21 May 2019 06:43:06 -0700 (PDT)
Date:   Tue, 21 May 2019 06:43:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c5d1d0589660769@google.com>
Subject: memory leak in lapb_register
From:   syzbot <syzbot+afb980676c836b4a0afa@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-x25@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f49aa1de Merge tag 'for-5.2-rc1-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1042cd9ca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61dd9e15a761691d
dashboard link: https://syzkaller.appspot.com/bug?extid=afb980676c836b4a0afa
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ea4654a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100f6f44a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+afb980676c836b4a0afa@syzkaller.appspotmail.com

g: Permanently added '10.128.0.195' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810dadc400 (size 256):
   comm "softirq", pid 0, jiffies 4294947366 (age 12.720s)
   hex dump (first 32 bytes):
     00 01 00 00 00 00 ad de 00 02 00 00 00 00 ad de  ................
     00 20 85 17 81 88 ff ff 00 00 00 00 00 00 00 00  . ..............
   backtrace:
     [<00000000fe4f5aaf>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000fe4f5aaf>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000fe4f5aaf>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000fe4f5aaf>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000050cea448>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000050cea448>] kzalloc include/linux/slab.h:742 [inline]
     [<0000000050cea448>] lapb_create_cb net/lapb/lapb_iface.c:121 [inline]
     [<0000000050cea448>] lapb_register+0x90/0x1c0 net/lapb/lapb_iface.c:158
     [<00000000c0d81e26>] x25_asy_open drivers/net/wan/x25_asy.c:482 [inline]
     [<00000000c0d81e26>] x25_asy_open_tty+0x26b/0x2f6  
drivers/net/wan/x25_asy.c:572
     [<00000000bdec8ae5>] tty_ldisc_open.isra.0+0x40/0x70  
drivers/tty/tty_ldisc.c:469
     [<000000004f64cfca>] tty_set_ldisc+0x149/0x240  
drivers/tty/tty_ldisc.c:596
     [<00000000d8b98e91>] tiocsetd drivers/tty/tty_io.c:2332 [inline]
     [<00000000d8b98e91>] tty_ioctl+0x366/0xa30 drivers/tty/tty_io.c:2592
     [<00000000343f2123>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000343f2123>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000343f2123>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000b777b7e5>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<0000000026d5db65>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<0000000026d5db65>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<0000000026d5db65>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000006a4653e>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000e706c40e>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

executing program
executing program


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
