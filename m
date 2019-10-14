Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4652BC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 03:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFFC2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 03:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfJNDKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 23:10:09 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42102 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfJNDKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 23:10:09 -0400
Received: by mail-io1-f71.google.com with SMTP id w1so24727141ioj.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 20:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=whJlTVHBThaxgNCBbOhdGGsAjN8MnS4+IduwsNPUrvc=;
        b=tgipZnuB1do9bAkqpTN1yM/0RhWMdM8GoKJffRtSiz+KdpAerlP/54+EFVQn6kCHX2
         /aHstiruOspwRBk2Ex9BVENkG789Uu6O47uRYj/rJwYwIqd0Jfx3HrmxYp81xILykEIc
         ftR3ZgzpvFpdXIvaUTmSU9Emst0FiePniQ1eBXCXN3i1Nwqk1/IEzAny20ECRMKt/1o8
         sUdmAqT6U4H7A9eznp66DLcRTLOR39rYLuHJXVMs61oWOCLrBEa3hGUurFcn2B8fnOIA
         11aKzbX7Gp2Qx+YWmfB5XF4je3z5kpy06K+Gkv35SKTzJYAAWkcd4f4dqB4RgLdReknh
         5Hxw==
X-Gm-Message-State: APjAAAV8jm2RP0xoZuyCQgoWZRyYVUe1vwiyBwa4wO4EVUkQNf7lzkx9
        YFrnp9w7yzM8jdKESejp74KzlDzbcyW4ZJmJR/nm1JoMaeFk
X-Google-Smtp-Source: APXvYqx2NyI/bDsUHWBHsVSk9DHfCItkvyJwYwHJhoUy4BfMP2t+0MmkkKzys+z1ajqi3Gkdi6eRnle7+hPGYaooTKAWUqPD0Gu+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3c7:: with SMTP id r7mr34731125jaq.98.1571022606708;
 Sun, 13 Oct 2019 20:10:06 -0700 (PDT)
Date:   Sun, 13 Oct 2019 20:10:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000683a810594d634a2@google.com>
Subject: kernel BUG at include/linux/rmap.h:LINE!
From:   syzbot <syzbot+3370fc9fb190f98c5c72@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, chenjianhong2@huawei.com,
        jannh@google.com, khlebnikov@yandex-team.ru,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, mike.kravetz@oracle.com,
        richardw.yang@linux.intel.com, riel@surriel.com,
        sfr@canb.auug.org.au, steve.capper@arm.com,
        syzkaller-bugs@googlegroups.com, tiny.windzz@gmail.com,
        vbabka@suse.cz, walken@google.com, willy@infradead.org,
        yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    442630f6 Add linux-next specific files for 20191008
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11450d93600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af1bfeef713eefdd
dashboard link: https://syzkaller.appspot.com/bug?extid=3370fc9fb190f98c5c72
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13132d57600000

The bug was bisected to:

commit 480706f51e2c3a450d2f7fc10f5af215c9d249df
Author: Wei Yang <richardw.yang@linux.intel.com>
Date:   Mon Oct 7 20:25:37 2019 +0000

     mm/rmap.c: reuse mergeable anon_vma as parent when forking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107ea520e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=127ea520e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=147ea520e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3370fc9fb190f98c5c72@syzkaller.appspotmail.com
Fixes: 480706f51e2c ("mm/rmap.c: reuse mergeable anon_vma as parent when  
forking")

prot 25 anon_vma ffff88809a9c4b40 vm_ops 0000000000000000
pgoff 20000 file 0000000000000000 private_data 0000000000000000
flags: 0x8100077(read|write|exec|mayread|maywrite|mayexec|account|softdirty)
------------[ cut here ]------------
kernel BUG at include/linux/rmap.h:159!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8601 Comm: syz-executor.0 Not tainted 5.4.0-rc2-next-20191008 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:anon_vma_merge include/linux/rmap.h:159 [inline]
RIP: 0010:__vma_adjust+0x151c/0x1cc0 mm/mmap.c:921
Code: 4c 89 ee 4c 89 f7 e8 b3 01 d2 ff 4d 39 ee 0f 82 1b fe ff ff 45 31 ed  
e9 1b fe ff ff e8 7d 00 d2 ff 48 8b 7d c8 e8 76 62 fc ff <0f> 0b e8 6d 00  
d2 ff 48 8b 85 68 ff ff ff 80 38 00 0f 85 20 07 00
RSP: 0018:ffff8880a0e9f9c0 EFLAGS: 00010286
RAX: 0000000000000147 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815cb676 RDI: ffffed10141d3f12
RBP: ffff8880a0e9fa88 R08: 0000000000000147 R09: ffffed1015d06161
R10: ffffed1015d06160 R11: ffff8880ae830b07 R12: ffff888095f28e10
R13: ffff88808c0f7f18 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000c57940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020d06000 CR3: 0000000090f89000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vma_merge+0xb8a/0xe60 mm/mmap.c:1169
  mmap_region+0x3e0/0x1760 mm/mmap.c:1741
  do_mmap+0x853/0x1190 mm/mmap.c:1552
  do_mmap_pgoff include/linux/mm.h:2361 [inline]
  vm_mmap_pgoff+0x1c5/0x230 mm/util.c:510
  ksys_mmap_pgoff+0xf7/0x630 mm/mmap.c:1604
  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
  __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a59
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcc91b5068 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000459a59
RDX: ffffffffefffffff RSI: 0000000000004000 RDI: 0000000020196000
RBP: 000000000075bf20 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008032 R11: 0000000000000246 R12: 0000000000c57914
R13: 00000000004c6176 R14: 00000000004db118 R15: 00000000ffffffff
Modules linked in:
---[ end trace aa2e499bc1c6fb5e ]---
RIP: 0010:anon_vma_merge include/linux/rmap.h:159 [inline]
RIP: 0010:__vma_adjust+0x151c/0x1cc0 mm/mmap.c:921
Code: 4c 89 ee 4c 89 f7 e8 b3 01 d2 ff 4d 39 ee 0f 82 1b fe ff ff 45 31 ed  
e9 1b fe ff ff e8 7d 00 d2 ff 48 8b 7d c8 e8 76 62 fc ff <0f> 0b e8 6d 00  
d2 ff 48 8b 85 68 ff ff ff 80 38 00 0f 85 20 07 00
RSP: 0018:ffff8880a0e9f9c0 EFLAGS: 00010286
RAX: 0000000000000147 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815cb676 RDI: ffffed10141d3f12
RBP: ffff8880a0e9fa88 R08: 0000000000000147 R09: ffffed1015d06161
R10: ffffed1015d06160 R11: ffff8880ae830b07 R12: ffff888095f28e10
R13: ffff88808c0f7f18 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000c57940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020d06000 CR3: 0000000090f89000 CR4: 00000000001406f0
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
