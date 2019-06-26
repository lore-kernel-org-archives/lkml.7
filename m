Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CBEC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40AF20656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfFZLhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:37:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:44720 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZLhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:37:06 -0400
Received: by mail-io1-f71.google.com with SMTP id i133so2205627ioa.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 04:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cSOQwJy4LcAZ1hrakKHwjlccptKEwQZP3N/p60Pl4SM=;
        b=oAsaZ3WUcm3mEdCZgpJ0AHhp6JnYrDua+qVN7/cqglbcPCoQUNeGOvnGFSy0HSD1oU
         80CTf5cYM7GNCTuPUsfr9spZ3GEQLAfHdhNzlwr+GoUW3KpmdAz8v04OoYK4AvOSgska
         +JM3EsYZkpYy4xBBs8DOrZYgpwOth7WnN+viG2Z1hloC+/fCYkjSuosC5oC2bkxH0j5e
         fXJyBExT9cKXt1iPZnhgmnB0c5hT7vXWrNvXvCD6cbSKlc5axs9QxT1N2fd4+wUHrBH+
         SCC83A0xMhalVTb5vlTE2P0YqvNsS9k9Y9smJsYYopkJskcS7klfzJ45623AkPzTpEVD
         8Hsg==
X-Gm-Message-State: APjAAAVX6khceuVjW52ChKdulBmPy4RJ8bmU13HrrvYGxV+lumfUjyJp
        rPw50nJIehMWQ+P9XVnswUShPLj4oLgY3/RjnXkMUz+G40zY
X-Google-Smtp-Source: APXvYqx2+e7/vKQsYWqF6TavXT+EOCyXt76ksDqtmIlWqF4nzPjheTkJT5U9bibdpw7xKvcQXVzD/tZgAVdzVxUrp8VFI67OWHPU
MIME-Version: 1.0
X-Received: by 2002:a5d:964d:: with SMTP id d13mr4596523ios.224.1561549025374;
 Wed, 26 Jun 2019 04:37:05 -0700 (PDT)
Date:   Wed, 26 Jun 2019 04:37:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4f847058c387616@google.com>
Subject: KASAN: use-after-free Read in corrupted (3)
From:   syzbot <syzbot+8a821b383523654227bf@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net, mhocko@suse.com,
        mingo@kernel.org, namit@vmware.com, netdev@vger.kernel.org,
        peterz@infradead.org, riel@surriel.com,
        syzkaller-bugs@googlegroups.com, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    045df37e Merge branch 'cxgb4-Reference-count-MPS-TCAM-entr..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c6217ea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd16b8dc9d0d210c
dashboard link: https://syzkaller.appspot.com/bug?extid=8a821b383523654227bf
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1389f5b5a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a821b383523654227bf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in vsnprintf+0x1727/0x19a0 lib/vsprintf.c:2503
Read of size 8 at addr ffff8880952500a0 by task syz-executor.1/9180

CPU: 0 PID: 9180 Comm: syz-executor.1 Not tainted 5.2.0-rc5+ #43
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:

Allocated by task 8:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:462
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:497
  slab_post_alloc_hook mm/slab.h:437 [inline]
  slab_alloc mm/slab.c:3326 [inline]
  kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3488
  vm_area_dup+0x21/0x170 kernel/fork.c:343
  dup_mmap kernel/fork.c:528 [inline]
  dup_mm+0x8c4/0x13b0 kernel/fork.c:1341
  copy_mm kernel/fork.c:1397 [inline]
  copy_process.part.0+0x2cde/0x6790 kernel/fork.c:2032
  copy_process kernel/fork.c:1800 [inline]
  _do_fork+0x25d/0xfe0 kernel/fork.c:2369
  __do_sys_clone kernel/fork.c:2476 [inline]
  __se_sys_clone kernel/fork.c:2470 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2470
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2502230480:
------------[ cut here ]------------
Bad or missing usercopy whitelist? Kernel memory overwrite attempt detected  
to SLAB object 'shmem_inode_cache' (offset 1040, size 1)!
WARNING: CPU: 0 PID: 9180 at mm/usercopy.c:74 usercopy_warn+0xeb/0x110  
mm/usercopy.c:74
Kernel panic - not syncing: panic_on_warn set ...
Shutting down cpus with NMI
Kernel Offset: disabled


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
