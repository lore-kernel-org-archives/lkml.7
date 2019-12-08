Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF77BC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 19:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E28020692
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 19:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfLHTfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 14:35:09 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:42005 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfLHTfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 14:35:09 -0500
Received: by mail-il1-f199.google.com with SMTP id n79so9994031ilh.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 11:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gvAQ4NfvnOeIg1SkBSm6bTwN9I84q20C3o5MLaZUt60=;
        b=uN/2kfqB5bheTrPzhEcGQhSws+2GsUvkQP31TDCP7GyucbSopeNjaykvUYA3hr5Exd
         lUcWDlt1L4h2+Z0XpVnGaFExYzvuATxr8DMA0WiRiL0iYwQ+ROzJgFzbPLapkzT4QU4n
         7C9GF9g8cROQjyPC6jU1FTnUTwLxk+/A96EQS833OKHmdvZYvdxQxMb//yqQqXi7hGDk
         84LIgq1CQBErvgFFAWCXCnufDAs07iajXjR1uVBVoX6+j2VnS3kFp1m+MAKePDiss9XI
         H0P5Ch5RRPuk9l3jQ3jnwUWw+GZuVpxnAgt1ZdE8tQVXdVoey8PmbF6U6Yr4CI5p0kQ/
         Fmww==
X-Gm-Message-State: APjAAAWF5fToNK2b6RZQrvnp1TgPmGaz5/y6d7BzCC22Yfdb3USvV2zR
        cMP+pzR2umI+eI5YDlz7c7Ah5e08ozEDSPcr0bMFduZolBr0
X-Google-Smtp-Source: APXvYqxpTAdjbwjwSyRrxHPnqf9fVl+0mX9ZKt0gKVJ9KuSJgBDpf5vT2xdqhaI+qdoIZM21SB8m78X/n87umw67yYCv/DrVR108
MIME-Version: 1.0
X-Received: by 2002:a02:ccb9:: with SMTP id t25mr11790800jap.82.1575833708592;
 Sun, 08 Dec 2019 11:35:08 -0800 (PST)
Date:   Sun, 08 Dec 2019 11:35:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d0a820599366088@google.com>
Subject: memory leak in erase_aeb
From:   syzbot <syzbot+f317896aae32eb281a58@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ad910e36 pipe: fix poll/select race introduced by the pipe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16080232e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3beca47aecbf4a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=f317896aae32eb281a58
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b527f2e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f317896aae32eb281a58@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881225039a0 (size 32):
   comm "syz-executor.0", pid 7318, jiffies 4294950453 (age 8.280s)
   hex dump (first 32 bytes):
     00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 01 00 00 00 02 00 00 00  ................
   backtrace:
     [<000000003a9d0e7e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000003a9d0e7e>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<000000003a9d0e7e>] slab_alloc mm/slab.c:3320 [inline]
     [<000000003a9d0e7e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3484
     [<00000000b53dfd0a>] erase_aeb+0x2a/0x100 drivers/mtd/ubi/wl.c:1691
     [<000000005ccfba82>] ubi_wl_init+0x1ae/0x600 drivers/mtd/ubi/wl.c:1758
     [<000000002350928f>] ubi_attach+0x665/0x18e7  
drivers/mtd/ubi/attach.c:1605
     [<0000000055aac88b>] ubi_attach_mtd_dev+0x5b3/0xd40  
drivers/mtd/ubi/build.c:946
     [<00000000071dc178>] ctrl_cdev_ioctl+0x149/0x1c0  
drivers/mtd/ubi/cdev.c:1043
     [<000000004c359338>] vfs_ioctl fs/ioctl.c:47 [inline]
     [<000000004c359338>] file_ioctl fs/ioctl.c:545 [inline]
     [<000000004c359338>] do_vfs_ioctl+0x551/0x890 fs/ioctl.c:732
     [<000000002f3b4a0e>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:749
     [<0000000071dee951>] __do_sys_ioctl fs/ioctl.c:756 [inline]
     [<0000000071dee951>] __se_sys_ioctl fs/ioctl.c:754 [inline]
     [<0000000071dee951>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:754
     [<0000000069d4ede5>] do_syscall_64+0x73/0x220  
arch/x86/entry/common.c:294
     [<000000001a44675f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
