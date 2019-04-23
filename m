Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCEFC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B401520811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfDWQNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:13:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:45088 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:13:07 -0400
Received: by mail-io1-f71.google.com with SMTP id j25so7348550ioj.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TsBpmWJ2BE859RBEAtZU1hf2lp7jmv5EzAmOLfO0OnE=;
        b=A+n4bVkDRajeBTA0AEZNfcYULNwdTSucpxJpqFHhJz/MhijqCVehJUOm1WuSVrWlEV
         GS2CeME3sU55Kyw9b+Z0IazCLVBw3VMydXPOfRfXfmlPq2Nx2GMdopvCcwwkYBnVNFg9
         krorGPAkKtU78FYc0xBXTu3zS4XShQHdS7u3d+Ltl/UBNApd8UWJwUqt9RfT8EyqrtpW
         1TTpkTusEy5+YlX0SPUbgjJ5N+TfAUt3Jt7U8VwLBE8Yl1lBrPjqrKvnCpLe+F7hYx7A
         nm+Qd/ZFamX9IXsxU+Fqd89qgKWu5kVJt3qXogEVEa0gNRy3NuEhobM9pm1WvLAPuzk6
         i/dg==
X-Gm-Message-State: APjAAAWjXAl+zbVN/skzNuTfMq0kEI/7jpm3qK9hLNnJAzPKGpAZR8ED
        HMiA2H5zrCaa/Uk6frner4YJkyDEQ4LSuMspJD8SQFIv0W+Z
X-Google-Smtp-Source: APXvYqzIw+qJYoBa2d5BBqGlKr84pDJX0ldn6kQyGtIn9iH5nKs5vaN6KyrIn+bBYM1v7YiT4NgV/R+ECA7Wbzz4kIEei2JKLqUe
MIME-Version: 1.0
X-Received: by 2002:a24:36d4:: with SMTP id l203mr2742100itl.143.1556035986559;
 Tue, 23 Apr 2019 09:13:06 -0700 (PDT)
Date:   Tue, 23 Apr 2019 09:13:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c9bea058734dc28@google.com>
Subject: WARNING: locking bug in split_huge_page_to_list
From:   syzbot <syzbot+35a50f1f6dfd5a0d7378@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dave.jiang@intel.com, hughd@google.com, jglisse@redhat.com,
        jrdr.linux@gmail.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e53f31bf Merge tag '5.1-rc5-smb3-fixes' of git://git.samba..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ecb7e3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=35a50f1f6dfd5a0d7378
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+35a50f1f6dfd5a0d7378@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
WARNING: CPU: 0 PID: 1553 at kernel/locking/lockdep.c:3673  
__lock_acquire+0x1887/0x3fb0 kernel/locking/lockdep.c:3673
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 1553 Comm: kswapd0 Not tainted 5.1.0-rc5+ #74
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__lock_acquire+0x1887/0x3fb0 kernel/locking/lockdep.c:3673
Code: d2 0f 85 7b 1f 00 00 44 8b 3d 29 0d 07 08 45 85 ff 0f 85 20 f3 ff ff  
48 c7 c6 80 3f 6b 87 48 c7 c7 c0 15 6b 87 e8 67 e3 eb ff <0f> 0b e9 09 f3  
ff ff 0f 0b e9 41 f1 ff ff 8b 1d c5 32 05 09 85 db
RSP: 0018:ffff8880a621f448 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815afcb6 RDI: ffffed1014c43e7b
RBP: ffff8880a621f580 R08: ffff8880a625e440 R09: fffffbfff11335fd
R10: fffffbfff11335fc R11: ffffffff8899afe3 R12: 00000000692b29d5
R13: 0000000000000009 R14: 00000000000409d5 R15: 0000000000000000
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
  down_write+0x38/0x90 kernel/locking/rwsem.c:70
  anon_vma_lock_write include/linux/rmap.h:120 [inline]
  split_huge_page_to_list+0x5d7/0x2de0 mm/huge_memory.c:2682
  split_huge_page include/linux/huge_mm.h:148 [inline]
  deferred_split_scan+0x64b/0xa60 mm/huge_memory.c:2853
  do_shrink_slab+0x400/0xa80 mm/vmscan.c:551
  shrink_slab mm/vmscan.c:700 [inline]
  shrink_slab+0x4be/0x5e0 mm/vmscan.c:680
  shrink_node+0x552/0x1570 mm/vmscan.c:2724
  kswapd_shrink_node mm/vmscan.c:3482 [inline]
  balance_pgdat+0x56c/0xe80 mm/vmscan.c:3640
  kswapd+0x5f4/0xfd0 mm/vmscan.c:3895
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
