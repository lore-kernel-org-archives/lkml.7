Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1072DC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C936520989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfCYH6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:58:05 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50783 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbfCYH6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:58:05 -0400
Received: by mail-io1-f71.google.com with SMTP id s24so7211705ioe.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 00:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aDTz/0yfw77EAc/SfJC6xJNXW3HSydXJ6jKlF9grqps=;
        b=chV1a3yg6BNLaojC1hgxlMbzBAue1r0iaQIVnzxAIUbAkrlIi9OZpFhHZIFXv96jcU
         YXGj+BBoZcmEa31pvYhgLTZ+YeDXRUkseZ7oXLq6IgZrs/TnyNeOH7jb7juaPXK843ZI
         cWAobUmegaeGqG6L7DTDYCSTt6712TuQGomT9PXdXw/BpHEodqNSO5uj2r3S+CL/d+b4
         VVCObxZrL7MU6OM4W/IzLRMQaYuPYkiZe0LFYfsMHVq98q4nYG+osIYsU/YtdJrit+rA
         5oxQB4YQkh+9gRGRc+7TpVTW+MoSl2IBq8RbwbvAOXW0Pz9q6CL80S456qkgzmlAuols
         Hvgg==
X-Gm-Message-State: APjAAAU02naF5EiTWcv6zTTDtgHFgyxMQKWM42Jgt/hRtZAvZ2ElZH4g
        vLizE8kQRkt07QNAT52DCPrj1qKyY8MzVSIYCStedWylQ41H
X-Google-Smtp-Source: APXvYqxWRT+qs6ou6TkgDYzh4fKcuNEt0mWW7ZZvPsFO34HkHDbLKW5ZeP4E/o5TzqegHqdk+YDy+8p6MIdBNB1Vmibp3/tzuo0q
MIME-Version: 1.0
X-Received: by 2002:a24:4483:: with SMTP id o125mr9695672ita.137.1553500684355;
 Mon, 25 Mar 2019 00:58:04 -0700 (PDT)
Date:   Mon, 25 Mar 2019 00:58:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007311ca0584e690c1@google.com>
Subject: kernel BUG at mm/internal.h:LINE!
From:   syzbot <syzbot+ce4fa49466985039fb35@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aryabinin@virtuozzo.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a5ed1e96 Merge tag 'powerpc-5.1-3' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117a556d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
dashboard link: https://syzkaller.appspot.com/bug?extid=ce4fa49466985039fb35
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ce4fa49466985039fb35@syzkaller.appspotmail.com

page:ffffea0002fffa00 count:2 mapcount:1 mapping:ffff8880970929f0  
index:0x4e4
ext4_da_aops
name:"syz-fuzzer"
flags: 0x1fffc0000020016(referenced|uptodate|lru|mappedtodisk)
raw: 01fffc0000020016 ffffea0001f82548 ffffea0001ab5388 ffff8880970929f0
raw: 00000000000004e4 0000000000000000 0000000200000000 ffff8880aa204bc0
page dumped because: VM_BUG_ON_PAGE(page_ref_count(page))
page->mem_cgroup:ffff8880aa204bc0
------------[ cut here ]------------
kernel BUG at mm/internal.h:77!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1046 Comm: kcompactd0 Not tainted 5.1.0-rc1+ #34
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:set_page_refcounted mm/internal.h:77 [inline]
RIP: 0010:set_page_refcounted mm/internal.h:74 [inline]
RIP: 0010:split_page+0x1e5/0x250 mm/page_alloc.c:2999
Code: 4c 89 e7 e8 5d 98 0c 00 0f 0b 48 c7 c6 20 09 72 87 4c 89 e7 e8 4c 98  
0c 00 0f 0b 48 c7 c6 a0 09 72 87 4c 89 e7 e8 3b 98 0c 00 <0f> 0b 48 c7 c6  
c0 08 72 87 4c 89 e7 e8 2a 98 0c 00 0f 0b 4c 89 f7
RSP: 0000:ffff8880a83d77b8 EFLAGS: 00010293
RAX: ffff8880a83c80c0 RBX: ffffea0002fffa34 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8199dda2 RDI: ffffed101507aedb
RBP: ffff8880a83d77d8 R08: 0000000000000021 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0002fffa00
R13: dffffc0000000000 R14: ffffea0003000034 R15: ffffea0002fff800
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f161d6cc169 CR3: 0000000095b2c000 CR4: 00000000001426e0
Call Trace:
  split_map_pages+0x334/0x540 mm/compaction.c:83
  isolate_freepages mm/compaction.c:1529 [inline]
  compaction_alloc+0x14ca/0x2290 mm/compaction.c:1543
  unmap_and_move mm/migrate.c:1175 [inline]
  migrate_pages+0x484/0x2cd0 mm/migrate.c:1426
  compact_zone+0x1b56/0x38d0 mm/compaction.c:2174
  kcompactd_do_work+0x303/0xaa0 mm/compaction.c:2555
  kcompactd+0x247/0x890 mm/compaction.c:2648
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace c8941b63dcddd106 ]---
RIP: 0010:set_page_refcounted mm/internal.h:77 [inline]
RIP: 0010:set_page_refcounted mm/internal.h:74 [inline]
RIP: 0010:split_page+0x1e5/0x250 mm/page_alloc.c:2999
Code: 4c 89 e7 e8 5d 98 0c 00 0f 0b 48 c7 c6 20 09 72 87 4c 89 e7 e8 4c 98  
0c 00 0f 0b 48 c7 c6 a0 09 72 87 4c 89 e7 e8 3b 98 0c 00 <0f> 0b 48 c7 c6  
c0 08 72 87 4c 89 e7 e8 2a 98 0c 00 0f 0b 4c 89 f7
RSP: 0000:ffff8880a83d77b8 EFLAGS: 00010293
RAX: ffff8880a83c80c0 RBX: ffffea0002fffa34 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8199dda2 RDI: ffffed101507aedb
RBP: ffff8880a83d77d8 R08: 0000000000000021 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0002fffa00
R13: dffffc0000000000 R14: ffffea0003000034 R15: ffffea0002fff800
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000422d10 CR3: 0000000095b2c000 CR4: 00000000001426e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
