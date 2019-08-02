Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ED4C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3032B20880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436754AbfHBR6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:58:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41865 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405953AbfHBR6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:58:07 -0400
Received: by mail-io1-f72.google.com with SMTP id x17so83419555iog.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 10:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8gjBIigprDYsZ6IoQ4881DtqPGJYdccKdh/YFaFCRCQ=;
        b=jqKZLEfR8k/LkAXaC3EK6qpGiIRAy8IGuWNDXx/COA+1YTVDLfbxJwrSiO+dRPtpx+
         G7Y+okmYLfoqFXaVASeUe6AD54lSkCMe+ETz/B0jz3SL0vU7gLSfQw7LHTCTFEzWEN/B
         iq9XwNcNvHlZuic9/pV/v15cvCNDefiZpghtc2DY0i3l3zZJLNCKf4rCdRnrIrODI5L9
         AB32duG5Kbk75U0zSn6gus4oVL99bjTEaI7jdDKUcvhesK4XHd4KxCDNEw6am1heCKwU
         /LmjxAyHfeWdoYvgDU1QLutxELQOntMC5f4HYFAK44b19EdegCnA4T5CfrVPhWQ9coKG
         H94w==
X-Gm-Message-State: APjAAAUrVK7ZBtKJNPlQhC+u/tqRJl2eYm2Z8I9WE/H5XXDJp9E6f3qT
        4vxBDFAdj1omMlbIQ/cPbDJd9jAWErTD3jF5FuvAYsX5kLjB
X-Google-Smtp-Source: APXvYqzLhSuB+g/dBt/46an5igOJbXyOVXGaJ1Mtb9YcYfXTepiNxCdC0OiFOIrsNAtI5+FJipCIfZ0xO4kqN9v/qnF3bhaMei+d
MIME-Version: 1.0
X-Received: by 2002:a6b:da1a:: with SMTP id x26mr100598512iob.285.1564768685611;
 Fri, 02 Aug 2019 10:58:05 -0700 (PDT)
Date:   Fri, 02 Aug 2019 10:58:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9694d058f261963@google.com>
Subject: kernel BUG at mm/vmscan.c:LINE! (2)
From:   syzbot <syzbot+8e6326965378936537c3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, chris@chrisdown.name, chris@zankel.net,
        dancol@google.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        hdanton@sina.com, james.bottomley@hansenpartnership.com,
        kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        laoar.shao@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, mhocko@kernel.org,
        mhocko@suse.com, minchan@kernel.org, oleksandr@redhat.com,
        ralf@linux-mips.org, rth@twiddle.net, sfr@canb.auug.org.au,
        shakeelb@google.com, sonnyrao@google.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, timmurray@google.com,
        yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0d8b3265 Add linux-next specific files for 20190729
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1663c7d0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae96f3b8a7e885f7
dashboard link: https://syzkaller.appspot.com/bug?extid=8e6326965378936537c3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c437c600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15645854600000

The bug was bisected to:

commit 06a833a1167e9cbb43a9a4317ec24585c6ec85cb
Author: Minchan Kim <minchan@kernel.org>
Date:   Sat Jul 27 05:12:38 2019 +0000

     mm: introduce MADV_PAGEOUT

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1545f764600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1745f764600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1345f764600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8e6326965378936537c3@syzkaller.appspotmail.com
Fixes: 06a833a1167e ("mm: introduce MADV_PAGEOUT")

raw: 01fffc0000090025 dead000000000100 dead000000000122 ffff88809c49f741
raw: 0000000000020000 0000000000000000 00000002ffffffff ffff88821b6eaac0
page dumped because: VM_BUG_ON_PAGE(PageActive(page))
page->mem_cgroup:ffff88821b6eaac0
------------[ cut here ]------------
kernel BUG at mm/vmscan.c:1156!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9846 Comm: syz-executor110 Not tainted 5.3.0-rc2-next-20190729  
#54
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:shrink_page_list+0x2872/0x5430 mm/vmscan.c:1156
Code: d9 ea ff ff e8 df 3c dd ff 4c 8d 6b ff e9 1c db ff ff e8 d1 3c dd ff  
48 8b bd 10 ff ff ff 48 c7 c6 80 85 93 87 e8 fe 10 07 00 <0f> 0b e8 b7 3c  
dd ff be 08 00 00 00 4c 89 ef e8 0a f2 17 00 4c 89
RSP: 0018:ffff888092427598 EFLAGS: 00010293
RAX: ffff88809a6a43c0 RBX: 0000000000000020 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff819bfec7 RDI: ffffed1012484e97
RBP: ffff888092427730 R08: 0000000000000021 R09: ffffed1015d260d1
R10: ffffed1015d260d0 R11: ffff8880ae930687 R12: dffffc0000000000
R13: ffffea0002198000 R14: 0000000000000000 R15: ffffea0002198008
FS:  000055555617d880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 00000000a818a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  reclaim_pages+0x3b8/0x8f0 mm/vmscan.c:2202
  madvise_cold_or_pageout_pte_range+0x18c4/0x2e20 mm/madvise.c:391
  walk_pmd_range mm/pagewalk.c:51 [inline]
  walk_pud_range mm/pagewalk.c:109 [inline]
  walk_p4d_range mm/pagewalk.c:135 [inline]
  walk_pgd_range mm/pagewalk.c:161 [inline]
  __walk_page_range+0xd2a/0x1680 mm/pagewalk.c:254
  walk_page_range+0x1a6/0x3e0 mm/pagewalk.c:335
  madvise_pageout_page_range.isra.0+0xdd/0x120 mm/madvise.c:532
  madvise_pageout+0x227/0x3a0 mm/madvise.c:568
  madvise_vma mm/madvise.c:965 [inline]
  __do_sys_madvise mm/madvise.c:1145 [inline]
  __se_sys_madvise mm/madvise.c:1073 [inline]
  __x64_sys_madvise+0x719/0x1500 mm/madvise.c:1073
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440149
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdb1a77db8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440149
RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004019d0
R13: 0000000000401a60 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace f888ef64246a2afc ]---
RIP: 0010:shrink_page_list+0x2872/0x5430 mm/vmscan.c:1156
Code: d9 ea ff ff e8 df 3c dd ff 4c 8d 6b ff e9 1c db ff ff e8 d1 3c dd ff  
48 8b bd 10 ff ff ff 48 c7 c6 80 85 93 87 e8 fe 10 07 00 <0f> 0b e8 b7 3c  
dd ff be 08 00 00 00 4c 89 ef e8 0a f2 17 00 4c 89
RSP: 0018:ffff888092427598 EFLAGS: 00010293
RAX: ffff88809a6a43c0 RBX: 0000000000000020 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff819bfec7 RDI: ffffed1012484e97
RBP: ffff888092427730 R08: 0000000000000021 R09: ffffed1015d260d1
R10: ffffed1015d260d0 R11: ffff8880ae930687 R12: dffffc0000000000
R13: ffffea0002198000 R14: 0000000000000000 R15: ffffea0002198008
FS:  000055555617d880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 00000000a818a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
