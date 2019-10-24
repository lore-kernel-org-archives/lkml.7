Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126FCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E235C20578
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407697AbfJXQHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:07:09 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40051 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407544AbfJXQHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:07:09 -0400
Received: by mail-il1-f199.google.com with SMTP id x17so7324685ill.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OyJyUWTXgYDE0ZGZQBuGao9EPjeeROvLEAHJFjf5bew=;
        b=gYbdVd96hBdMmhFYUlTS3j9tqLnn/zxQuDW7coBUGZPikLFPee25cKkCPPWKCKdYLf
         GsCU4H0qY+0cMPeBJaJGI/L0SZ+Nezx4YqG8HDTdWZ5uvoTKGAUirnG4M6jZXFtEebs8
         FVP93YFn5XGoUch/mEOq/CsH7vJezeWtIgC5DEJmH/iE8uFI26fp+wyQwKZrvEfHcFY8
         OqK6LB89Stn+D2fD/W43JlIz5dqt+eOCukxUnmRa9U0s0Ive4E/F3I0kV3mfpJpAVZI8
         9KjyBSD9cZsOiDEQxVB3N5EfMrKyBDGgaM4gX8P8ewQcBx2GztXePfTqu02pGzhM8zyX
         JL3A==
X-Gm-Message-State: APjAAAX8Yn4Gf7/8nupdAYlaWI0JNGvRqss5QAuwtX7UsUbxIr4B+5vU
        wHWzaVw/rNKc7oK39a6NxMU8i0wM4ZBEX+DyRysYqmjiWkIz
X-Google-Smtp-Source: APXvYqzZJRLedKQCOpSr3npo4aYE9rsrgUb3oYjHPngsYdi5Gm/onIYHRBF0HtXrb/p3HWT7s5x9s285do8Yq5ZVXWOtUAXhFmam
MIME-Version: 1.0
X-Received: by 2002:a92:d0a:: with SMTP id 10mr12485141iln.218.1571933228668;
 Thu, 24 Oct 2019 09:07:08 -0700 (PDT)
Date:   Thu, 24 Oct 2019 09:07:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b49e190595aa39fe@google.com>
Subject: KCSAN: data-race in __rb_rotate_set_parents / vm_area_dup
From:   syzbot <syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, cyphar@cyphar.com, elena.reshetova@intel.com,
        elver@google.com, guro@fb.com, keescook@chromium.org,
        ldv@altlinux.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=1060c47b600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
dashboard link: https://syzkaller.appspot.com/bug?extid=c034966b0b02f94f7f34
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __rb_rotate_set_parents / vm_area_dup

read to 0xffff88811eef53e8 of 200 bytes by task 7738 on cpu 0:
  vm_area_dup+0x70/0xf0 kernel/fork.c:359
  __split_vma+0x88/0x350 mm/mmap.c:2678
  __do_munmap+0xb02/0xb60 mm/mmap.c:2803
  do_munmap mm/mmap.c:2856 [inline]
  mmap_region+0x165/0xd50 mm/mmap.c:1749
  do_mmap+0x6d4/0xba0 mm/mmap.c:1577
  do_mmap_pgoff include/linux/mm.h:2353 [inline]
  vm_mmap_pgoff+0x12d/0x190 mm/util.c:496
  ksys_mmap_pgoff+0x2d8/0x420 mm/mmap.c:1629
  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
  __x64_sys_mmap+0x91/0xc0 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff88811eef5440 of 8 bytes by task 7737 on cpu 1:
  __rb_rotate_set_parents+0x4d/0xf0 lib/rbtree.c:79
  __rb_insert lib/rbtree.c:215 [inline]
  __rb_insert_augmented+0x109/0x370 lib/rbtree.c:459
  rb_insert_augmented include/linux/rbtree_augmented.h:50 [inline]
  rb_insert_augmented_cached include/linux/rbtree_augmented.h:60 [inline]
  vma_interval_tree_insert+0x196/0x230 mm/interval_tree.c:23
  __vma_link_file+0xd9/0x110 mm/mmap.c:634
  __vma_adjust+0x1ac/0x12a0 mm/mmap.c:842
  vma_adjust include/linux/mm.h:2276 [inline]
  __split_vma+0x208/0x350 mm/mmap.c:2707
  split_vma+0x73/0xa0 mm/mmap.c:2736
  mprotect_fixup+0x43f/0x510 mm/mprotect.c:413
  do_mprotect_pkey+0x3eb/0x660 mm/mprotect.c:553
  __do_sys_mprotect mm/mprotect.c:578 [inline]
  __se_sys_mprotect mm/mprotect.c:575 [inline]
  __x64_sys_mprotect+0x51/0x70 mm/mprotect.c:575
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 7737 Comm: blkid Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
