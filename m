Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754EAC282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51907216E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfEYRiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:38:15 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:56374 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfEYRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:38:06 -0400
Received: by mail-it1-f199.google.com with SMTP id l124so6790844itg.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CpgloL8+onz68GPgmg9tXtXXtVgIppru3CwueKNVn1M=;
        b=GQ7pmgu0w2qZIFtkHob5nCG3PqlihCmbtkn/roG73QZKNv4TJ8B40FLu41b19YYcB4
         U9ALGRmHO6JP/RnLc7ophBE4HWFqUlp5pkBZyouDlw12Vcq6SSTouVBtp+pFUGOM3E78
         nUVlkKRWXVhFTaxiSkLUxCJctO5XGKutNdhz9vZkHZs/vjwyXQywwyf2y0vBTfHnmETU
         yofAYqYCuO3zmCLvy3UmfV9I09xYkCG1G0Hj3JGPhfPY50aS2xuJM0d1ScK6hNmQnYAn
         XsYLCR6V2ahu0Lwazp7RTxz+g67lMZox4Hsrxt5a/fzJrSgG3HQYoLET2VP+qW+x84pw
         eoXw==
X-Gm-Message-State: APjAAAWX9iigyj71X2XWthtSP2YCSvdiARWSZLMs8wQBUeFHvXIQv+FY
        /BoZhqSui5qJMroypRinjKmZTmqmZYK39KmGIC9MIvTxgCee
X-Google-Smtp-Source: APXvYqyE0Jyhh6VMGfVY8tyiGNU+fB9Yn0ef/lFln7vD4bJPM0xETATwopqivsVpYCTq8b42O1CePf1IV1oBWXPPk/hFfPxiKtCR
MIME-Version: 1.0
X-Received: by 2002:a5e:9907:: with SMTP id t7mr13326663ioj.24.1558805885897;
 Sat, 25 May 2019 10:38:05 -0700 (PDT)
Date:   Sat, 25 May 2019 10:38:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a546b0589b9c74f@google.com>
Subject: KASAN: use-after-free Read in class_equal
From:   syzbot <syzbot+83c135be90fc92db7e13@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c50bbf61 Merge tag 'platform-drivers-x86-v5.2-2' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12130c9aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
dashboard link: https://syzkaller.appspot.com/bug?extid=83c135be90fc92db7e13
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e7d84ca00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83c135be90fc92db7e13@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in class_equal+0x40/0x50  
kernel/locking/lockdep.c:1527
Read of size 8 at addr ffff88807aedf360 by task syz-executor.0/9275

CPU: 0 PID: 9275 Comm: syz-executor.0 Not tainted 5.2.0-rc1+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:

Allocated by task 9264:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:462
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:497
  slab_post_alloc_hook mm/slab.h:437 [inline]
  slab_alloc mm/slab.c:3326 [inline]
  kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3488
  getname_flags fs/namei.c:138 [inline]
  getname_flags+0xd6/0x5b0 fs/namei.c:128
  getname+0x1a/0x20 fs/namei.c:209
  do_sys_open+0x2c9/0x5d0 fs/open.c:1064
  __do_sys_open fs/open.c:1088 [inline]
  __se_sys_open fs/open.c:1083 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1083
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9264:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:451
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:459
  __cache_free mm/slab.c:3432 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3698
  putname+0xef/0x130 fs/namei.c:259
  do_sys_open+0x318/0x5d0 fs/open.c:1079
  __do_sys_open fs/open.c:1088 [inline]
  __se_sys_open fs/open.c:1083 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1083
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88807aede580
  which belongs to the cache names_cache of size 4096
The buggy address is located 3552 bytes inside of
  4096-byte region [ffff88807aede580, ffff88807aedf580)
The buggy address belongs to the page:
page:ffffea0001ebb780 refcount:1 mapcount:0 mapping:ffff8880aa596c40  
index:0x0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0001ebb708 ffffea0001ebb908 ffff8880aa596c40
raw: 0000000000000000 ffff88807aede580 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88807aedf200: 00 00 fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88807aedf280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb f1 f1
> ffff88807aedf300: f1 f1 00 f2 f2 f2 00 f2 f2 f2 fb fb fb fb 00 00
                                                        ^
  ffff88807aedf380: 00 f3 f3 f3 f3 f3 fb fb fb fb fb fb fb fb fb fb
  ffff88807aedf400: fb fb fb fb fb fb fb fb fb fb fb fb fb 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
