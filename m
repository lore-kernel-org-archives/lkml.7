Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6709C282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A245520863
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfEYRiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:38:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:45584 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfEYRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:38:06 -0400
Received: by mail-io1-f71.google.com with SMTP id z2so10089506iog.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=W0sM+dkM5p+EzGcOUhbNOnMkSf+3EYQYnJRlw+QErig=;
        b=SP3KUGKWOnhK7O6liRCkBd1jL1wt2HfrPhypimINi8Gc9SZZEUMdIZpNCMCROU5HyV
         YuEBeFZ7CwhzpgMVhw0N/xGSkUi/s5U0lUVdTQJZFvJJlb8Jo/xkxeZrw1zC5Dld8D5w
         UD+uanZzsykbW+vzkbV42XOqlCl4uY5WfaPQxxlNe/2LDiovNc7Lsw5rkGclaGJsaR78
         cO85D22YNTTuactWAY+oKqT6OeaBVujntaqk0zHIsLqbqJF56f6UqVx1wXuavNfWfEDo
         F3EIEt8OzV2j8hyaeg5aW1qGX9/ybSw7hTJaqlEz2G8c93yvmAfYbryENRXuPCv6H8BY
         ND+g==
X-Gm-Message-State: APjAAAVVf6UjBNA/jl7mPr6qynGOuaaM8n6ECTlg133W5OPiVPalnnO3
        fHE9fjc1FJ67jJz4yGEG2Lb6pKLFZe4lsaGG9pYwWSAhFW41
X-Google-Smtp-Source: APXvYqzmCzxmhXot/pkKNomMM3XaJxwIL1NaHND0Utz8T5kE3LtJd7GN/NO/HFZnk5/+gXXmbaITmho3ro/+PY/Va91xxzpwx+Kb
MIME-Version: 1.0
X-Received: by 2002:a02:c7c9:: with SMTP id s9mr982338jao.82.1558805885471;
 Sat, 25 May 2019 10:38:05 -0700 (PDT)
Date:   Sat, 25 May 2019 10:38:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013d4880589b9c7d3@google.com>
Subject: memory leak in bcsp_recv
From:   syzbot <syzbot+98162c885993b72f19c4@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c50bbf61 Merge tag 'platform-drivers-x86-v5.2-2' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113f684ca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61dd9e15a761691d
dashboard link: https://syzkaller.appspot.com/bug?extid=98162c885993b72f19c4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143fcb8aa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137bd84ca00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+98162c885993b72f19c4@syzkaller.appspotmail.com

9 tx timeout
BUG: memory leak
unreferenced object 0xffff888123ccbc00 (size 224):
   comm "syz-executor717", pid 7249, jiffies 4295003727 (age 28.450s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000600479ed>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000600479ed>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000600479ed>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000600479ed>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<0000000059f3ba6b>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<0000000074e70f06>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<0000000074e70f06>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339  
[inline]
     [<0000000074e70f06>] bcsp_recv+0x1c3/0x540  
drivers/bluetooth/hci_bcsp.c:685
     [<00000000edf8c323>] hci_uart_tty_receive+0xba/0x200  
drivers/bluetooth/hci_ldisc.c:607
     [<000000009051651a>] tiocsti drivers/tty/tty_io.c:2195 [inline]
     [<000000009051651a>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
     [<000000005695f2c9>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000005695f2c9>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000005695f2c9>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000be82d55d>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d19fa7dc>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d19fa7dc>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d19fa7dc>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000051eaf016>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000000b0b6970>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888123ccbc00 (size 224):
   comm "syz-executor717", pid 7249, jiffies 4295003727 (age 30.380s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000600479ed>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000600479ed>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000600479ed>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000600479ed>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<0000000059f3ba6b>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<0000000074e70f06>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<0000000074e70f06>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339  
[inline]
     [<0000000074e70f06>] bcsp_recv+0x1c3/0x540  
drivers/bluetooth/hci_bcsp.c:685
     [<00000000edf8c323>] hci_uart_tty_receive+0xba/0x200  
drivers/bluetooth/hci_ldisc.c:607
     [<000000009051651a>] tiocsti drivers/tty/tty_io.c:2195 [inline]
     [<000000009051651a>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
     [<000000005695f2c9>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000005695f2c9>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000005695f2c9>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000be82d55d>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d19fa7dc>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d19fa7dc>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d19fa7dc>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000051eaf016>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000000b0b6970>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888123ccbc00 (size 224):
   comm "syz-executor717", pid 7249, jiffies 4295003727 (age 31.350s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000600479ed>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000600479ed>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000600479ed>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000600479ed>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<0000000059f3ba6b>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<0000000074e70f06>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<0000000074e70f06>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339  
[inline]
     [<0000000074e70f06>] bcsp_recv+0x1c3/0x540  
drivers/bluetooth/hci_bcsp.c:685
     [<00000000edf8c323>] hci_uart_tty_receive+0xba/0x200  
drivers/bluetooth/hci_ldisc.c:607
     [<000000009051651a>] tiocsti drivers/tty/tty_io.c:2195 [inline]
     [<000000009051651a>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
     [<000000005695f2c9>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000005695f2c9>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000005695f2c9>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000be82d55d>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d19fa7dc>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d19fa7dc>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d19fa7dc>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000051eaf016>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000000b0b6970>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888123ccbc00 (size 224):
   comm "syz-executor717", pid 7249, jiffies 4295003727 (age 31.400s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000600479ed>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000600479ed>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000600479ed>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000600479ed>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<0000000059f3ba6b>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<0000000074e70f06>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<0000000074e70f06>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339  
[inline]
     [<0000000074e70f06>] bcsp_recv+0x1c3/0x540  
drivers/bluetooth/hci_bcsp.c:685
     [<00000000edf8c323>] hci_uart_tty_receive+0xba/0x200  
drivers/bluetooth/hci_ldisc.c:607
     [<000000009051651a>] tiocsti drivers/tty/tty_io.c:2195 [inline]
     [<000000009051651a>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
     [<000000005695f2c9>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000005695f2c9>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000005695f2c9>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000be82d55d>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d19fa7dc>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d19fa7dc>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d19fa7dc>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000051eaf016>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000000b0b6970>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888123ccbc00 (size 224):
   comm "syz-executor717", pid 7249, jiffies 4295003727 (age 32.360s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000600479ed>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000600479ed>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000600479ed>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000600479ed>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<0000000059f3ba6b>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<0000000074e70f06>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<0000000074e70f06>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339  
[inline]
     [<0000000074e70f06>] bcsp_recv+0x1c3/0x540  
drivers/bluetooth/hci_bcsp.c:685
     [<00000000edf8c323>] hci_uart_tty_receive+0xba/0x200  
drivers/bluetooth/hci_ldisc.c:607
     [<000000009051651a>] tiocsti drivers/tty/tty_io.c:2195 [inline]
     [<000000009051651a>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
     [<000000005695f2c9>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000005695f2c9>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000005695f2c9>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000be82d55d>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d19fa7dc>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d19fa7dc>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d19fa7dc>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000051eaf016>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000000b0b6970>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888123ccbc00 (size 224):
   comm "syz-executor717", pid 7249, jiffies 4295003727 (age 33.320s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000600479ed>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000600479ed>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000600479ed>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000600479ed>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<0000000059f3ba6b>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<0000000074e70f06>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<0000000074e70f06>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339  
[inline]
     [<0000000074e70f06>] bcsp_recv+0x1c3/0x540  
drivers/bluetooth/hci_bcsp.c:685
     [<00000000edf8c323>] hci_uart_tty_receive+0xba/0x200  
drivers/bluetooth/hci_ldisc.c:607
     [<000000009051651a>] tiocsti drivers/tty/tty_io.c:2195 [inline]
     [<000000009051651a>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
     [<000000005695f2c9>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000005695f2c9>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000005695f2c9>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000be82d55d>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d19fa7dc>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d19fa7dc>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d19fa7dc>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000051eaf016>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000000b0b6970>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888123ccbc00 (size 224):
   comm "syz-executor717", pid 7249, jiffies 4295003727 (age 33.370s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000600479ed>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000600479ed>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000600479ed>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000600479ed>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<0000000059f3ba6b>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
     [<0000000074e70f06>] alloc_skb include/linux/skbuff.h:1058 [inline]
     [<0000000074e70f06>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339  
[inline]
     [<0000000074e70f06>] bcsp_recv+0x1c3/0x540  
drivers/bluetooth/hci_bcsp.c:685
     [<00000000edf8c323>] hci_uart_tty_receive+0xba/0x200  
drivers/bluetooth/hci_ldisc.c:607
     [<000000009051651a>] tiocsti drivers/tty/tty_io.c:2195 [inline]
     [<000000009051651a>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
     [<000000005695f2c9>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000005695f2c9>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000005695f2c9>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000be82d55d>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000d19fa7dc>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000d19fa7dc>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000d19fa7dc>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000051eaf016>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000000b0b6970>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

executing program


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
