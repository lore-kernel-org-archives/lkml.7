Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3589EC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127A9223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbfGWJSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:18:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33543 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfGWJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:18:06 -0400
Received: by mail-io1-f72.google.com with SMTP id 132so46535181iou.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 02:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=67ejXHamkY9eIDOeV8VA65Ml5tV/3zBQIL3hb/b5CWA=;
        b=D3rHfgKnoyP4w4r6YIBnXCJh8p4063t/iai2cTaZuvSHmnGbeUQubTXMe4Ywyuhas/
         CupiWi1FX0W/0+cwlJwj36uSw1yc1cEUu0Bs0pDu80dGZa8XyicLtz1OTVerIfzZxtrB
         rClfq58zYma+EcODpyZsEre2F9e44VE/atubzV2QobT1L1EIn7AicXIRPSUgBA0jeUXP
         ujpaLfP6QnUFUmKanWIS0jJWMzVndNm/baCH/l8vVLYdIhJXmnxm9GY64A1bpA+HQ5py
         8ppBVnPZ1K0vOeHWdAKU1W/OuA6Q3wM/BzQnr2vQ5SNzlB8yrh2bhdYMGhPsVGEyxiid
         0XSQ==
X-Gm-Message-State: APjAAAWmeU+dzw/Y1ea3IKAibcIkG8z4zPPiW8vVx90wbog++V9pHP/0
        R1DYnAftoXYtZ/c/wg2HFdyaaNmlfE1iyVBPTSYGlic8mc8C
X-Google-Smtp-Source: APXvYqxla7x1Wm/x/admg25Y5FEMgzOug3OyFzstSB7YQcpwjyTc4WBnxn4XIfu2YSr0unquN0yp5JQ82RbwoHpC9lsEJXa0vyr7
MIME-Version: 1.0
X-Received: by 2002:a5e:d60a:: with SMTP id w10mr57564669iom.78.1563873485990;
 Tue, 23 Jul 2019 02:18:05 -0700 (PDT)
Date:   Tue, 23 Jul 2019 02:18:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b2fe9058e55abbf@google.com>
Subject: memory leak in policydb_read
From:   syzbot <syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        dvyukov@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1613751fa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de7d700ea5ac607
dashboard link: https://syzkaller.appspot.com/bug?extid=fee3a14d4cdf92646287
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a7951fa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16206444600000

The bug was bisected to:

commit d9570ee3bd1d4f20ce63485f5ef05663866fe6c0
Author: Dmitry Vyukov <dvyukov@google.com>
Date:   Sat Jan 13 00:53:10 2018 +0000

     kmemleak: allow to coexist with fault injection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1633cb00600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1533cb00600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1133cb00600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
Fixes: d9570ee3bd1d ("kmemleak: allow to coexist with fault injection")

BUG: memory leak
unreferenced object 0xffff888123547c80 (size 64):
   comm "syz-executor647", pid 6976, jiffies 4294940919 (age 7.920s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000019b1b22a>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<0000000019b1b22a>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<0000000019b1b22a>] slab_alloc /mm/slab.c:3319 [inline]
     [<0000000019b1b22a>] kmem_cache_alloc_trace+0x145/0x280 /mm/slab.c:3548
     [<00000000d64c33c7>] kmalloc /./include/linux/slab.h:552 [inline]
     [<00000000d64c33c7>] kzalloc /./include/linux/slab.h:748 [inline]
     [<00000000d64c33c7>] roles_init /security/selinux/ss/policydb.c:188  
[inline]
     [<00000000d64c33c7>] policydb_init /security/selinux/ss/policydb.c:294  
[inline]
     [<00000000d64c33c7>] policydb_read+0x141/0x1b80  
/security/selinux/ss/policydb.c:2259
     [<000000004dd18ef6>] security_load_policy+0x182/0x740  
/security/selinux/ss/services.c:2141
     [<000000004f5bb277>] sel_write_load+0x101/0x1f0  
/security/selinux/selinuxfs.c:564
     [<00000000ee05c840>] __vfs_write+0x43/0xa0 /fs/read_write.c:494
     [<000000008ca23315>] vfs_write /fs/read_write.c:558 [inline]
     [<000000008ca23315>] vfs_write+0xee/0x210 /fs/read_write.c:542
     [<00000000d97bcbc9>] ksys_write+0x7c/0x130 /fs/read_write.c:611
     [<000000007a3f006b>] __do_sys_write /fs/read_write.c:623 [inline]
     [<000000007a3f006b>] __se_sys_write /fs/read_write.c:620 [inline]
     [<000000007a3f006b>] __x64_sys_write+0x1e/0x30 /fs/read_write.c:620
     [<000000001c16ef20>] do_syscall_64+0x76/0x1a0  
/arch/x86/entry/common.c:296
     [<000000007784189d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
