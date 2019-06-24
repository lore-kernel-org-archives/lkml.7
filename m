Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2EFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794DA20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfFXH1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:27:16 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50963 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfFXH1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:27:09 -0400
Received: by mail-io1-f69.google.com with SMTP id m26so20851323ioh.17
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 00:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YIBl5sn+qEAnvVG9RktF5oSe3uviRA0QejfBS359Mi8=;
        b=NGz2sz0sCXZQq49psga/Mrr8DjbQx1AFXFZ1elB4i7A2Cb+wVpv8pfhVFRBI1i8YTi
         mCJxurkFUXp358lfXjowVgBE+Cymmfmveq0BHKWKZ1gJK5XnuqUsp+ChhdFSWnt3BPEM
         7Y3dGspoJ79LRxtWXTjXgYI3SkIDcriEDSk8Dvd6phDgIstbKOPu/NN+QP7u2Ahq5CZF
         RZifd4SiEOnRQ8zmUwdhguIi4SuYRAB8TQ8IaQNN4YzwyQYkSDWDoBoM8XZ5cX6IoV7u
         vCMqKUsM0VdZ0Oaw2q9V8cYyyDDVr/j9N4IYmEKQdKbesNiJAoEwg6YrJfkPEU1F5ZcG
         uFtA==
X-Gm-Message-State: APjAAAXO4B+twybxP6hXblQMPv21VBfDSv/STaH+RB0hgLk0wqUErptV
        OafU6atsFBVPibyPTKGAkBZPTEmpEPWpwc93Ef0jgbcCcAKP
X-Google-Smtp-Source: APXvYqw/SDM0pKIz2hztVK7kLGs1klUZUsrSE68p3+ZOknK6Pl2jz+INUj5tzF/BdQlh2jd5BSMqVorSU4vh1DYf07VoFiDkG6ah
MIME-Version: 1.0
X-Received: by 2002:a6b:6b14:: with SMTP id g20mr40168187ioc.28.1561361228957;
 Mon, 24 Jun 2019 00:27:08 -0700 (PDT)
Date:   Mon, 24 Jun 2019 00:27:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b1779058c0cbdda@google.com>
Subject: memory leak in h4_recv_buf
From:   syzbot <syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com>
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

HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1054e6b2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce
dashboard link: https://syzkaller.appspot.com/bug?extid=97388eb9d31b997fe1d0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1073d8aaa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b36fbea00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com

program
BUG: memory leak
unreferenced object 0xffff88810991fa00 (size 224):
   comm "syz-executor739", pid 7080, jiffies 4294949854 (age 18.640s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000da42c09f>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000da42c09f>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000da42c09f>] slab_alloc_node mm/slab.c:3269 [inline]
     [<00000000da42c09f>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
     [<00000000f6fbcf84>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
     [<00000000ea93fc4c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<00000000ea93fc4c>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339  
[inline]
     [<00000000ea93fc4c>] h4_recv_buf+0x26d/0x450  
drivers/bluetooth/hci_h4.c:182
     [<00000000e0312475>] h4_recv+0x51/0xb0 drivers/bluetooth/hci_h4.c:116
     [<00000000ebf11fab>] hci_uart_tty_receive+0xba/0x200  
drivers/bluetooth/hci_ldisc.c:592
     [<0000000095e1216e>] tiocsti drivers/tty/tty_io.c:2195 [inline]
     [<0000000095e1216e>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
     [<000000009fa523f0>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000009fa523f0>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000009fa523f0>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<000000000cebb5d9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<000000001630008a>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<000000001630008a>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<000000001630008a>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000c62091e3>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000005c213625>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881204f4400 (size 1024):
   comm "syz-executor739", pid 7080, jiffies 4294949854 (age 18.640s)
   hex dump (first 32 bytes):
     6c 69 62 75 64 65 76 00 fe ed ca fe 28 00 00 00  libudev.....(...
     28 00 00 00 a0 00 00 00 52 ca da 77 00 00 00 00  (.......R..w....
   backtrace:
     [<0000000034504843>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000034504843>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000034504843>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000034504843>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<0000000056d30eb5>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<0000000056d30eb5>] __kmalloc_node_track_caller+0x38/0x50  
mm/slab.c:3634
     [<00000000df40176c>] __kmalloc_reserve.isra.0+0x40/0xb0  
net/core/skbuff.c:138
     [<0000000035340e64>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
     [<00000000ea93fc4c>] alloc_skb include/linux/skbuff.h:1054 [inline]
     [<00000000ea93fc4c>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339  
[inline]
     [<00000000ea93fc4c>] h4_recv_buf+0x26d/0x450  
drivers/bluetooth/hci_h4.c:182
     [<00000000e0312475>] h4_recv+0x51/0xb0 drivers/bluetooth/hci_h4.c:116
     [<00000000ebf11fab>] hci_uart_tty_receive+0xba/0x200  
drivers/bluetooth/hci_ldisc.c:592
     [<0000000095e1216e>] tiocsti drivers/tty/tty_io.c:2195 [inline]
     [<0000000095e1216e>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
     [<000000009fa523f0>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000009fa523f0>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000009fa523f0>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<000000000cebb5d9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<000000001630008a>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<000000001630008a>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<000000001630008a>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000c62091e3>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000005c213625>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
