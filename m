Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371AEC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED6A21537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfFMV4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:56:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37645 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFMV4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:56:06 -0400
Received: by mail-io1-f69.google.com with SMTP id j18so310305ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 14:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ydFXxI0znwbofCXLJ9CCbdYtdW7CJQT/GmF/kJrlloQ=;
        b=d/0NAjVNLjbwDjt0cKpef959u8QzxTt+7CSxylXWUKtTrYjmyl/66PAZcGKfuULH3Q
         tMpUvfS3kyJcK3zsPonTLp25+f9CGisvnshyYCkn1weQOgwtDt6J29R4YuP0NBd+zpwN
         6MWDHn3toPtJcGNiS5HOVi5C7T22EVI1xPyOwjxjkCkVC2lCbRGLAB/sslQaaZRVYqg5
         +sVnj+hMzIprYsFgCq+DB3m8d8k1BdeOujJU/FFUJ7nVM2Ol/5B/nrPI+MtsehZHKWuS
         EcR07qpZfzMLOHZ02fzpgcIbwvAaZaZ9K7O663HxU5SudUUy8hjjSUT4Ak0m4exz3oVU
         qIyA==
X-Gm-Message-State: APjAAAVbCp+BiaMzhS1qsUpLbJW+sztm+2qP7eFBuoBmQ60wj6XH8fxT
        AhJZE8Mmk3VHIldu2wOSUO7Ae1Z/5M2nt2+ejxzdYdASBAUN
X-Google-Smtp-Source: APXvYqzmnd/bESLoN/unmpNR/LTqQ9cjpPKHPfcD/kaNr1DUjqrCy4dA4fIZMBPCQo7Tm4BkaQSiXpFejZNzmJO24gBZ/Z0eORkN
MIME-Version: 1.0
X-Received: by 2002:a6b:2cc7:: with SMTP id s190mr54766893ios.29.1560462965302;
 Thu, 13 Jun 2019 14:56:05 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:56:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb6d57058b3b98eb@google.com>
Subject: memory leak in binder_transaction
From:   syzbot <syzbot+182ce46596c3f2e1eb24@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d1fdb6d8 Linux 5.2-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e5ce1ea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb38d33cd06d8d48
dashboard link: https://syzkaller.appspot.com/bug?extid=182ce46596c3f2e1eb24
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1181703ea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e14392a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+182ce46596c3f2e1eb24@syzkaller.appspotmail.com

-executor774" scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=binder  
permissive=1
BUG: memory leak
unreferenced object 0xffff888123934800 (size 32):
   comm "syz-executor774", pid 7083, jiffies 4294941834 (age 7.970s)
   hex dump (first 32 bytes):
     00 48 93 23 81 88 ff ff 00 48 93 23 81 88 ff ff  .H.#.....H.#....
     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000038ba7202>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000038ba7202>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000038ba7202>] slab_alloc mm/slab.c:3326 [inline]
     [<0000000038ba7202>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000004e63839>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000004e63839>] kzalloc include/linux/slab.h:742 [inline]
     [<0000000004e63839>] binder_transaction+0x28b/0x2eb0  
drivers/android/binder.c:3072
     [<0000000050997ec4>] binder_thread_write+0x357/0x1430  
drivers/android/binder.c:3794
     [<00000000ab2de227>] binder_ioctl_write_read  
drivers/android/binder.c:4827 [inline]
     [<00000000ab2de227>] binder_ioctl+0x8bc/0xbb4  
drivers/android/binder.c:5004
     [<000000002eec2b63>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000002eec2b63>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000002eec2b63>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<0000000048cfc9e6>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<0000000030bf392d>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<0000000030bf392d>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<0000000030bf392d>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<000000007dec438c>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000ae043c96>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
