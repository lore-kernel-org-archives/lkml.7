Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83781C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 05:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9B820706
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 05:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfLHFpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 00:45:10 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:44119 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLHFpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 00:45:10 -0500
Received: by mail-il1-f199.google.com with SMTP id h87so8860617ild.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 21:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MTe2qzn3l3HhjLyhnGZbKSX1tp0E1VU2WlXpFjF8hAI=;
        b=NAYo2IciAu6RARg/ltRVwCN+joF4KDxXo93FTFLOJSYHS+Tw0fDUnGk+9cJ1YX2G61
         Uq29OtQLPp0lGRm1IQwRZ7fr72z4Ig+ak6SQQUhXpSbmNAENq0nLm6RoF9slnwtAwVuo
         HuIpusbbalqkqw6ybxm8PGqLMNMJCkeFEaQs8K/PwQrFsM+9FrJQWAJ7NJguyYGLU3Z7
         aRJwWQazoTE3WNJ8gFyQhGJ8YL/97s49MzbJoYTt4Kbqc8/iBCj9uvX2mmJM/PnhtVyJ
         lmpko+MKqBlJJYSVPPTfjLDYVQiVU+AinK9Yjs9AHkpnaGLWMcb+QcADTqUOuG0WvmQ6
         2Zgw==
X-Gm-Message-State: APjAAAXGQ1hwS2V3cyBTV7DZuNCOhvtbkBSW91H3jVTt87K1uwgkdqnP
        PiTAItbXi4FOJMhJwJ/gi2n+5Hi20ccz6jRMoOXytTQ8sE5R
X-Google-Smtp-Source: APXvYqxW47nvOh4dAUBDxjFaJuQSozp3vnJuHfQxbvXfs4l3Wt7CDKsCLcfmZfhyO0rgYJT2Fu+2v+hMe6MLmn1D/aZkB1jHYeL+
MIME-Version: 1.0
X-Received: by 2002:a5d:9eda:: with SMTP id a26mr17559388ioe.238.1575783909020;
 Sat, 07 Dec 2019 21:45:09 -0800 (PST)
Date:   Sat, 07 Dec 2019 21:45:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023dba505992ac8aa@google.com>
Subject: memory leak in fasync_helper
From:   syzbot <syzbot+4b1fe8105f8044a26162@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bf929479 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123e91e2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=874c75a332209d41
dashboard link: https://syzkaller.appspot.com/bug?extid=4b1fe8105f8044a26162
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120faee2e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178a0ef6e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4b1fe8105f8044a26162@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812a4082a0 (size 48):
   comm "syz-executor670", pid 6989, jiffies 4294952355 (age 19.520s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
     00 00 00 00 00 00 00 00 00 6b 05 1f 81 88 ff ff  .........k......
   backtrace:
     [<000000002a74b343>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000002a74b343>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<000000002a74b343>] slab_alloc mm/slab.c:3319 [inline]
     [<000000002a74b343>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000fa370506>] fasync_alloc fs/fcntl.c:895 [inline]
     [<00000000fa370506>] fasync_add_entry fs/fcntl.c:953 [inline]
     [<00000000fa370506>] fasync_helper+0x37/0xa9 fs/fcntl.c:982
     [<000000006c3eaaf1>] sock_fasync+0x4d/0xa0 net/socket.c:1293
     [<0000000098076f55>] ioctl_fioasync fs/ioctl.c:550 [inline]
     [<0000000098076f55>] do_vfs_ioctl+0x409/0x810 fs/ioctl.c:655
     [<00000000df24d2b9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<000000003fec9c80>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<000000003fec9c80>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<000000003fec9c80>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<000000002bebbfe6>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000722d8431>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888128cdf240 (size 48):
   comm "syz-executor670", pid 6990, jiffies 4294952942 (age 13.650s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
     00 00 00 00 00 00 00 00 00 d8 02 19 81 88 ff ff  ................
   backtrace:
     [<000000002a74b343>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000002a74b343>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<000000002a74b343>] slab_alloc mm/slab.c:3319 [inline]
     [<000000002a74b343>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000fa370506>] fasync_alloc fs/fcntl.c:895 [inline]
     [<00000000fa370506>] fasync_add_entry fs/fcntl.c:953 [inline]
     [<00000000fa370506>] fasync_helper+0x37/0xa9 fs/fcntl.c:982
     [<000000006c3eaaf1>] sock_fasync+0x4d/0xa0 net/socket.c:1293
     [<0000000098076f55>] ioctl_fioasync fs/ioctl.c:550 [inline]
     [<0000000098076f55>] do_vfs_ioctl+0x409/0x810 fs/ioctl.c:655
     [<00000000df24d2b9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<000000003fec9c80>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<000000003fec9c80>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<000000003fec9c80>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<000000002bebbfe6>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000722d8431>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888128cdff60 (size 48):
   comm "syz-executor670", pid 6991, jiffies 4294953529 (age 7.780s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
     00 00 00 00 00 00 00 00 00 63 05 1f 81 88 ff ff  .........c......
   backtrace:
     [<000000002a74b343>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000002a74b343>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<000000002a74b343>] slab_alloc mm/slab.c:3319 [inline]
     [<000000002a74b343>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000fa370506>] fasync_alloc fs/fcntl.c:895 [inline]
     [<00000000fa370506>] fasync_add_entry fs/fcntl.c:953 [inline]
     [<00000000fa370506>] fasync_helper+0x37/0xa9 fs/fcntl.c:982
     [<000000006c3eaaf1>] sock_fasync+0x4d/0xa0 net/socket.c:1293
     [<0000000098076f55>] ioctl_fioasync fs/ioctl.c:550 [inline]
     [<0000000098076f55>] do_vfs_ioctl+0x409/0x810 fs/ioctl.c:655
     [<00000000df24d2b9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<000000003fec9c80>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<000000003fec9c80>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<000000003fec9c80>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<000000002bebbfe6>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000722d8431>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
